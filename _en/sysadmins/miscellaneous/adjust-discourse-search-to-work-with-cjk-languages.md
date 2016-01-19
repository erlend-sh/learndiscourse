---
title: Adjust Discourse search to work with CJK languages
---

1. Set the minimum search length to 1

    Open admin dashboard, and set settings > others > "min search term length" to 1

2. Fix database encoding to UTF-8

    1. Enter the discourse docker install directory and run:

            ./launcher enter app

    2. Then enter postgreSQL console:

            sudo -u postgres psql discourse

    3. And update the encoding of database:

            update pg_database set encoding = pg_char_to_encoding('UTF8') where datname = 'discourse';

    4. Leave database:

            \q

    5. Reindex all content:

        Only new content will have UTF-8 index, old content still use ASCII, so go to the docker discourse directory (usually at `/var/www/discourse` ) and run:

            rake search:reindex

3. Now the content can search by CJK language.

Thanks to Audrey Tang, she give me support to finish this article.

<small class="documentation-source">Source: [https://meta.discourse.org/t/adjust-discourse-search-to-work-with-cjk-languages/28741](https://meta.discourse.org/t/adjust-discourse-search-to-work-with-cjk-languages/28741)</small>
