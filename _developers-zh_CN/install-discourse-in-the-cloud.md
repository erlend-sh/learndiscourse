---
title: "在云上安装 Discourse"
translations:
  -
    code: en
    url: '/developers/install-discourse-in-the-cloud/'
tags:
  - 安装
---
使用我们的 [Discourse Docker 镜像][dd]在不需要了解任何 Ruby、Rails 或 Linux shell 的情况下 **在 30 分钟内在云服务器上部署 Discourse**。如果想要在境外部署，我们更喜欢[Digital Ocean][do]。当然这些步骤应该在别的支持 Docker 的云服务商那也应该是一样的。让我们开始吧！

# 创建新的 Digital Ocean Droplet

[注册 Digital Ocean 账户][do]，更新付款信息，然后创建您的新云服务器（Droplet）。

- 输入您的域名 `discourse.example.com` 将其作为 Droplet 的名字。

- 默认的 **1GB** RAM 对小社群是足够的。我们推荐中等大小的社群使用 2GB 内存。

- 默认的 **Ubuntu 14.04 LTS x64** 没有问题。总是选用最新的 64位的[长期支持（LTS）发行版][lts]。

创建您的新 Droplet。您将收到一封来自 Digital Ocean 的邮件，包含了您服务器的 root 账户的密码。（不过，如果您知道[如何使用 SSH keys](https://www.google.com/search?q=digitalocean+ssh+keys)，您可能不需要密码就可以登录了。）

# 访问您的 Droplet

通过 SSH 连接至您的 Droplet，或在 Windows 上使用 [Putty][put]：

    ssh root@192.168.1.1

用您 Droplet 的 IP 地址替换 `192.168.1.1`。

<img src='/uploads/default/5/04498edc72de562e.png' width="586" height="128">

您会被问到是否同意连接，输入`yes`，然后再输入您从 Digital Ocean 邮件中收到的 root 账户的密码。您也可能被提示更改 root 账户的密码。

<img src='/uploads/default/6/3c5c9c6f43fe1f37.png' width="584" height="300">

# 设置 Swap（如果需要）

- 如果您在使用最小的 1GB 内存安装，您必须[设置 swap 文件](https://meta.discoursecn.org/t/linux-swap/25)。

- 如果您的服务器有 2GB+ 的内存，您可能不需要设置 swap 文件。

# 安装 Docker / Git

    wget -qO- https://get.docker.io/ | sh

<img src='/uploads/default/7/00dd79c9264cf1b1.png' width="586" height="452">

# 安装 Discourse

创建 `/var/discourse` 文件夹，克隆[官方 Discourse Docker 镜像][dd]至其中，然后在拷贝一个配置文件，并命名为 `app.yml`：

    mkdir /var/discourse
    git clone https://github.com/discourse/discourse_docker.git /var/discourse
    cd /var/discourse
    cp samples/standalone.yml containers/app.yml

<img src='/uploads/default/8/055834184371be06.png' width="662" height="240">

# 编辑 Discourse 配置文件

**配置文件是 YAML 格式，请不要删除配置项“:”前的内容。**

在 `app.yml` 中编辑 Discourse 配置:

    nano containers/app.yml

我们建议使用 Nano 是因为它是一个经典的图形文本编辑器，只使用了方向键。

- 将 `params` 中的 `version` 前的注释符号 `#` 去掉，然后设置其为最稳定的 `stable`。其他还有两个分支可以选择，分别是 `beta` 和 `tests-passed`。`beta` 更新比 `stable` 快，如果想帮助反馈问题和试用新特性，可以较为安全的使用。`tests-passed` 和主线开发版本非常近，但不稳定。

- 在 `env` 中增加 `DISCOURSE_DEFAULT_LOCALE`，并设为您想用的语言，比如简体中文 `zh_CN`。Discourse 初始化时会自动创建一些分类和主题，这样可以初始化成简体中文。如果在此设置了语言，在站点设置中将无法修改站点语言，但是你总是可以在配置文件中更改语言并重建容器。

- 如果是在墙内部署，添加 `web.china.template.yml` 模板，具体方法见：[在大陆地区的云上部署 Discourse][mainland]。

- 将 `DISCOURSE_DEVELOPER_EMAILS` 改为您的邮件地址。

- 将 `DISCOURSE_HOSTNAME` 设置为 `discourse.example.com`，意思是您想要您的 Discourse 可以通过 `http://discourse.example.com/` 访问。您需要更新您的 DNS 的 A 记录，使其指向您服务器的 IP 地址。

- 将您邮件发送的验证信息填在 `DISCOURSE_SMTP_ADDRESS`、`DISCOURSE_SMTP_PORT`、`DISCOURSE_SMTP_USER_NAME`和`DISCOURSE_SMTP_PASSWORD`。如果需要的话请确定删掉了这几行前面的多余空格和 `#` 字符。

- 如果您在使用 1 GB 的服务器，将 `UNICORN_WORKERS` 设为 2，`db_shared_buffers`设为 128MB，以节省内存。

<img src='/uploads/default/9/c1292819d8dc6d5a.png' width="578" height="407">

完成这些编辑后，按下<kbd>Ctrl</kbd><kbd>O</kbd>之后再按<kbd>Enter</kbd>保存，再按<kbd>Ctrl</kbd><kbd>X</kbd>退出。

# 电子邮件及其重要

**Discourse 需要在账户创建和通知时发送电子邮件给用户。如果您没有在初始化前配置好电子邮件设置，您的站点没法正常工作！**

- 已经有邮件服务器了？很好，使用那个邮件服务器的验证信息。

- 没有邮件服务器，或您根本不知道这是什么？没问题，在[**Mandrill**][man]（或 [Mailgun][gun]，或 [Mailjet][jet]）注册一个免费账户，然后使用他们仪表盘里提供的验证信息。

- 要保证邮件成功投递，您必须设置正确的 DNS 记录[SPF 和 DKIM 记录](http://help.mandrill.com/entries/21751322-What-are-SPF-and-DKIM-and-do-I-need-to-set-them-up-)。在 Mandrill 中，验证信息在  Sending Domains、View DKIM/SPF 安装指引下。

# 初始化 Discourse

保存好 `app.yml` 文件，然后开始初始化 Discourse：

    ./launcher bootstrap app

运行这个命令大致要 8 分钟。它自动配置好您的 Discourse 环境。

运行完成后，启动 Discourse：

    ./launcher start app

<img src='/uploads/default/10/7c74a9f78e46172e.png' width="669" height="233">

恭喜！您的 Discourse 可以使用了！

假设您配置好了 DNS 记录且也已生效，您就可以通过您前面输入的域名 `discourse.example.com` 访问了。如果不行，您可以直接通过服务器 IP 访问，例如  `http://192.168.1.1`。

<img src="/uploads/default/171/4616df874f575ca7.png" width="690" height="327">


# 注册新账户并成为管理员

请想想上面填写的`DISCOURSE_DEVELOPER_EMAILS`；通过填写的邮件地址中的任意一个注册新账户，之后您的账户将自动变成管理员。

（如果您没有收到任何邮件，并且您注册不了管理员账户，请看我们的[电子邮件配置除错检查清单](https://meta.discourse.org/t/troubleshooting-email-on-a-new-discourse-install/16326)。）

<img src="/uploads/default/169/1407e8fd5403a8e2.png" width="595" height="500">
您应该可以看到职员主题和[管理员操作指南（这里有一份中文版）](https://github.com/discourse/discourse/blob/master/docs/ADMIN-QUICK-START-GUIDE.md)。它包含了进一步配置和自定义您 Discourse 安装的指南。

（如果您仍不能通过邮件注册成为管理员，参见[通过命令行创建管理员账户](https://meta.discourse.org/t/create-admin-account-from-console/17274)，但是请注意如果没有配置好邮件设置，您的站点仍不能正常运行。）

# 安装后维护

我们强烈建议您打开 Ubuntu 的自动安全更新功能：

    dpkg-reconfigure -plow unattended-upgrades

要 **升级 Discourse 至最新版**，访问 `/admin/upgrade` 并按照指示操作。

在 `/var/discourse` 下的 `launcher`命令可以完成几种维护操作：

    Usage: launcher COMMAND CONFIG [--skip-prereqs]
    Commands:
        start:      启动/初始化容器
        stop:       关闭运行中的容器
        restart:    重启容器
        destroy:    关闭并删除容器
        enter:      使用 nsenter 进入容器
        ssh:        在运行中的容器中启动 bash shell
        logs:       容器的 Docker 日志
        mailtest:   测试容器中的邮件配置
        bootstrap:  基于配置文件预设模板初始化容器
        rebuild:    重建一个容器（删除老容器，初始化，启动新容器）

# 使用更多 Discourse 特性

您想要...

* 用户只能通过原有网站的注册系统登录？[配置单点登录](https://meta.discoursecn.org/t/discourse/52/1)。

- 用户想要通过 Google 登录？（新的 Oauth2 验证方式）[配置 Google 登录](https://meta.discourse.org/t/configuring-google-login-for-discourse/15858)。

- 用户想要通过邮件回复？[配置通过邮件回复](https://meta.discoursecn.org/t/topic/31/1)。

- 想要每天自动创建备份？[Configure backups](https://meta.discourse.org/t/configure-automatic-backups-for-discourse/14855)

- HTTPS / SSL 支持？[配置 SSL](https://meta.discoursecn.org/t/docker-discourse-ssl/63/1)。

- 想在同一站点运行多个 Discourse？[配置多站点](https://meta.discoursecn.org/t/docker/59/1)。

- 用内容分发网络全球加速访问？[配置 CDN](https://meta.discoursecn.org/t/discourse-cdn/53/1)。

- 从 vBulletin、PHPbb、Vanilla、Drupal、BBPress 和 Discuz 等等论坛程序中导入旧数据？[看我们的开源导入脚本](https://github.com/discourse/discourse/tree/master/script/import_scripts)、[使用教程](https://meta.discoursecn.org/t/discourse/36/1)。

- A firewall on your server? [Configure firewall](https://meta.discourse.org/t/configure-a-firewall-for-discourse/20584)

- 想将 Discourse [内嵌至 WordPress 中](https://meta.discoursecn.org/t/discourse-wordpress/72) 或, or [on your static HTML site](http://eviltrout.com/2014/01/22/embedding-discourse.html)?


  [dd]: https://github.com/discourse/discourse_docker
  [man]: https://mandrillapp.com
  [ssh]: https://help.github.com/articles/generating-ssh-keys
  [meta]: https://meta.discourse.org/t/beginners-guide-to-deploy-discourse-on-digital-ocean-using-docker/12156
  [do]: https://www.digitalocean.com/?refcode=5fa48ac82415
  [lts]: https://wiki.ubuntu.com/LTS
  [jet]: http://www.mailjet.com/pricing
  [gun]: http://www.mailgun.com/
  [put]: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html
  [mainland]: https://meta.discoursecn.org/t/zai-da-lu-di-qu-de-yun-shang-bu-shu-discourse/28
