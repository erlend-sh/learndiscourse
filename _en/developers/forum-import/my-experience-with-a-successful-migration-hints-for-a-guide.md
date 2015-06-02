---
title: My experience with a successful migration (hints for a guide)
name: my-experience-with-a-successful-migration-hints-for-a-guide
---

Hello. After 2 days and 50 commits to the migration plugin i finally completed my forum migration. 
I want to share my experience and some hints for the perfect forum migration. (and sorry for my bad english)

I have two goals:

1. Migrate my old php forum (custom bulletin board)
2. Keep the topic IDs during migrations, so I can write a 301 redirect for SEO 

For the migration I use the fantastic gem [forum2discourse][1]: is flexible and very easy to configure. 
If you want to keep your topic ID you need to make some changes:

In /discourse/topic.rb add the ID to the attr_accessor

    # Standard attrs
      attr_accessor :title, :category, :views, :id 

In you topic model add the ID to the method:

    Forum2Discourse::Models::Discourse::Topic.new({
          id: id,
          title: subject,
          created_at: posted,
          category: forum.forum_name,
          views: num_views,
          posts: posts.map(&:to_discourse)
        })

The ID of course is protected by Rails, so you need to override the protection method.

Inside topic.rb model (Discourse) add the overriding method (only for import).

    def self.attributes_protected_by_default
        [] 
      end

You have to remove this method when the import task is complete.

The last tweak to the Discourse code is in Topic_creator.rb (discourse/lib): you have to add ID also here (line 39)

    topic_params = {title: @opts[:title],id: @opts[:id], user_id: @user.id, last_post_user_id: @user.id}

You are now ready to import your forum, but you must pay attention to Discourse configuration.

1. Create a new admin user.

2. In setting disable any filter (max username length, max number of daily reply, spam filter). Configure Discourse to give a user any sort of permission. This is very important, because during the import you don't receive any feedback and you can lose posts if some user has some restriction.

3. In setting flag : allow import.

You have also to consider a couple of things:

1. When you create the user Discourse create a "welcome admin" topic. This topic has ID 1, so if you have in your forum a topic with ID 1 you must delete it

2. When the importer create a category Discourse add a "Category Description Topic": these topics can cause postgres conflicts and topics from source with the same ID of these "Category Description Topic" are not imported. 

My forum has about 30.000 topics and I lose only "9" topics from import, very old topics. 

When the migration is finished remember to restore original topic.rb and topic_creator.rb.

Now I have only to check if there are some problems of data integrity, but everything is working so I think that the procedure is ok.


  [1]: https://github.com/initforthe/forum2discourse