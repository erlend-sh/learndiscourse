---
title: Simple Discourse Deployment with Rubber
---

I've put together what I believe to be the simplest way of deploying Discourse yet using [Rubber][1].

First, some background on Rubber.  Rubber is a capistrano extension that keeps all configuration within your codebase and manages tasks by what roles a server has similar to Chef/Puppet etc.

It's advantages are:

 1. All config is within your codebase and configurable using ERB within the configs
 2. It's abstraction simplifies the process enough so that you get down to two commands to setup and one command to update. 
 `rubber vulcanize discourse` and `cap rubber:create_staging` to start
`cap deploy` to update
But it also allows complete configurablility to scale to a full production architecture
 3. Utilizes cloud providers such as AWS, Rackspace, Digital Ocean or your own generic ubuntu box
 4. Been used in production by many companies for years

Advantages for Discourse: 

 1. Separates application code and ops code
 2. The Discourse team can update the Rubber template with the best
    options and rubber will handle the upgrading without having to check
    file diffs
 3. Replaces BluePill for process management
 4. Custom Discourse infrastructure tasks can be written into Rubber for easy customer use

I've written up a [Gist][2] for using Rubber with Discourse ([PR here][3])

I'm hoping to get it down to 3 lines:

 1. `gem install rubber`
 2. `rubber vulcanize discourse`
 3. edit minimal config for your provider
 4. `cap rubber:create_staging`

It's still a little rough so I'd appreciate some feedback.

Edit:  Adding the contents of the gist to be discussed here.

**Long Version:**

#### Setup
`git clone https://github.com/discourse/discourse.git`
`cd discourse`
`echo "gem 'rubber', github: 'ScotterC/rubber', branch: 'discourse'" >> Gemfile`
`bundle`
`rubber vulcanize discourse` reply with n to overwrite questions

##### Edit config/rubber/rubber.yml
`app_name: discourse`
`domain: discourse.com`

##### For EC2:
key_name and key_file # => Requires EC2 keypair
`access_key:  AWS_KEY`
`secret_access_key: AWS_SECRET`
`account: AWS_ACCOUNT`
`image_type: m1.small`
`staging_roles: "web,app,db:primary=true,redis_master,sidekiq,discourse"`

##### Other Providers see:
* [Vagrant][4]
* [Rackspace and Digital Ocean][5]

#####Edit config/rubber/rubber-ruby.yml
 `ruby_version: 2.0.0-p247`

##### Discourse config:
Remove duplicate 'rubber' line from Gemfile
`bundle`
`cd config/`
`cp redis.yml.sample redis.yml`
`cp environments/production.rb.sample environments/production.rb`
`cd ../`

#### Deploy
`cap rubber:create_staging`
 
Prompts:
hit return for hostname prompt
hit return for roles if they mimic above staging roles
computer password for access to /etc/hosts

Note:
if it fails with `vboxadd: unrecognized service`. Make sure you're not using [Capistrano 2.15.5][6]. Comment out `reinstall_virtualbox_additions` task in rubber/deploy-setup.rb and run `cap rubber:bootstrap && cap deploy:migrations`  


When create_staging finishes.  In your browser `production.discourse.com` should be a discourse site


  [1]: http://github.com/rubber/rubber
  [2]: https://gist.github.com/ScotterC/6703521
  [3]: https://github.com/rubber/rubber/pull/398
  [4]: https://github.com/rubber/rubber/wiki/Running-with-vagrant
  [5]: https://github.com/rubber/rubber/wiki/Providers
  [6]: https://github.com/rubber/rubber/issues/397

<small class="documentation-source">Source: [https://meta.discourse.org/t/simple-discourse-deployment-with-rubber/10029](https://meta.discourse.org/t/simple-discourse-deployment-with-rubber/10029)</small>
