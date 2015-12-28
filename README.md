[![Join the chat at https://gitter.im/nahtnam/learndiscourse](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/nahtnam/learndiscourse?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

### Discourse Documentation

[Discourse](http://www.discourse.org) is the 100% open source discussion platform built for the next decade of the Internet.

This is [a community effort to improve Discourse's documentation](https://meta.discourse.org/t/a-community-effort-to-improve-discourses-documentation/29129).

### How are articles organized?

- **Users**
  Essential features available to normal users in a community hosted on Discourse.
- **Moderators**
  How to use various features for community and forum moderation.
- **Administrators**
  How to configuration of various site-wide options for discourse through the admin panel.
- **Designers**
  How to customize the look and feel of discourse with themes, HTML, CSS and JavaScript.
- **System Administrators**
  How to install, maintain and optimize systems to run Discourse.
- **Developers**
  Write plugins, features or fix bugs in Discourse.

### Contributing

  This is a work in progress, in the early stages.  If you would like to get involved, please [join the convesation on meta](https://meta.discourse.org/t/a-community-effort-to-improve-discourses-documentation/29129) to see where your efforts are best spent.

  The documentation is built using [Jekyll and hosted on Github Pages](https://help.github.com/articles/using-jekyll-with-pages/).


### Internationalization

  Multilingual approach and a little more about structure.


  ## Glossaries

  - `Portal`: Defined by us. The page works like a directory and doesn't include a bunch of texts. e.g. Install, Developers, Home
  - `Page`: A jekyll doc type. All portals are just pages. But there are also some pages including texts. e.g. about
  - `Collection`: A jekyll doc type between page and post. Doc is a collection item and also belongs to one portal.

  ## Multilingual

  ### Collections

  Collection name is the same as the language code suffix, prefixed with an underscore such as `_en` and `_zh_CN`. Within each language collection, a subdirectory exists for each portal. A few additional configuration value should also be added into `_config.yml`.

      collections:
        en:
          output: true
          permalink: /:path/
        zh_CN:
          output: true
          permalink: /zh_CN/:path/

      defaults:
        -
          scope:
            path: ""
            type: en
          values:
            layout: page
            lang: en
        -
          scope:
            path: ""
            type: zh_CN
          values:
            layout: page
            lang: zh_CN

  ### Collection item

  The only required meta attribute is `title` and `name`.
  `name` must match across all translations as it is used to match an article to its companions.

  For example, here is the metadata for an english article in `_en/developers/`

      ---
      title: "Install Discourse in the cloud"
      name:  install-discourse-in-the-cloud
      tags:
        - install
      ---

  It's Chinese translation has a different title and tag, but a matching name:

      ---
      title: "在云上安装 Discourse"
      name: install-discourse-in-the-cloud
      tags:
        - 安装
      ---


  ### Site translations

  `_config.yml` stores all the translation strings.

      t:
        en:
          language: English
          language_title: Language
          home:
            title: Home
            url: '/'
          about:
            title: About
            url: '/about/'
        zh_CN:
          language: 简体中文
          language_title: 语言
          home:
            title: 主页
            url: '/zh_CN/'
          about:
            title: 关于
            url: '/zh_CN/about/'

  They can be referenced by `{{ site.t[page.lang].xxx_key }}`.

  All page including portals should include a `title` and `url` here.

  #### Portal page

  Required `identifier` and `lang`. `identifier` should match key in the `_config.yml`.

      ---
      layout: default
      lang: en
      identifier: home
      ---

  A set of available languages should be in the heading of a portal by including `{% include portal-language-switcher.html %}`

  #### Other pages

  Required `identifier` and `lang`. `identifier` should match key in the `_config.yml`. Additional `translations` is used to add the translated version in the header. It's no need to add something in the body.

      ---
      layout: default
      lang: en
      identifier: home
      translations:
        -
          lang: en
          url: 'some/url'
      ---

  ## How to add something?

  ### Collection

  1. Create the `_<language-code>` in the root directory.
  2. Declare the meta attributes in the `_config.yml`.
    - Add a `<language-code>` under `collections`, set the output to true to enable front matter and assign a permalink url.
  3. Add scope default variables to collection items.

  ### Collection item

  1. Create a markdown file in the collection folder.
  2. Assign the meta attributes in the file. `title` is required. Assign a `name` to match it with its translated versions as well.

  ### Portal page

  1. Create a page such as `index.html`.
  2. Add the translation string into `_config.yml` including the `title` and `url`.
  3. Add the language switcher by adding a line above the body: `{% include portal-language-switcher.html %}`.
  4. Assign the meta attribute in the file. `lang` and `identifier` are required.

  ### Other pages

  1. Create a page such as `index.html`.
  2. Add the translation string into `_config.yml` including the `title` and `url`.
  3. Assign the meta attribute in the file. `lang` and `identifier` are required. You can include `translations` as you want.

  ### Translation string

  1. Add a key under the `t` in the `_config.yml`.
  2. Now you can reference it by `{{ site.t[page.lang].xxx_key }}`.

## Layouts

Layouts are divided into several types:

- `base.html`: A very basic HTML structure.
- `default.html`: Used by every portal pages and main page, including the banner and sidebar.
- `documentation.html`: Used by documentation page, including the breadcrumb.
- `page.html`: Any other pages didn't fit into the other 3 types. For example, 404 page.
