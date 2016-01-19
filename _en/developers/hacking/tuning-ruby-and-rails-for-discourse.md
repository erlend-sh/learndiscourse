---
title: Tuning Ruby and Rails for Discourse
weight: 100
---

Here are some quick raw notes I would like to flesh out to a blog post, eventually. 

Been noticing performance on the front page of Discourse is rather bad, after digging in with MiniProfiler I notices lots of GCs are hit for a single page view. I ran some tests in production with a few settings and wanted to share them with you. 

### What is going on? 

A strong indicator you are seeing too many GCs are huge gaps in MiniProfiler

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/1X/6a23499a439f3ea21b5e9c5a73e589bc011edd09" width="543" height="253">

An even stronger one is running MiniProfiler with ?pp=profile-gc-time

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/1X/f290e1fd20becdc64c6f626a3f160d4d6257d7aa" width="690" height="159">

(4 **stop the world** GCs for a single request) 

###Installs tested


- `rvm install 1.9.3-p385`
- `rvm install 1.9.3-p385 --patch https://github.com/funny-falcon/ruby/compare/p385...p385_falcon.diff` 
- `rvm install 2.0.0`

**note** this is an in-progress post, feel free to comment, but it will grow quite a bit as I flesh it out. 

--- 

###Environments testing

- default 
- RUBY_GC_MALLOC_LIMIT=90000000 (GC)
- LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so.0.1.0 (GC+TC)

<pre>
RAILS_ENV=production bundle exec thin start -p 3111

RAILS_ENV=production RUBY_GC_MALLOC_LIMIT=90000000 bundle exec thin start -p 3111

RAILS_ENV=production RUBY_GC_MALLOC_LIMIT=90000000 LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so.0.1.0 bundle exec thin start -p 3111
</pre>

<sub>(tried a bunch of other "recommended" optimisations, most of them made little to no diff) </sub>

###Test rig

Production:  Intel(R) Xeon(R) CPU E3-1280 V2 @ 3.60GHz

###Test performed

Results for: `ab -n 100 -c 1 http://localhost:3111/`
<sub>first run discarded</sub>


###rvm use 1.9.3-p385

```
RAILS_ENV=production bundle exec thin start -p 3111

                min  mean[+/-sd] median   max
Default:        209  260  15.3    263     297
GC     :         84  135  32.1    139     205
GC+TC  :         76  124  27.1    131     178
```

###rvm install 1.9.3-p385 --patch falcon

```
              min  mean[+/-sd] median   max
Default:        72  131  49.1    124     540
GC     :        70  120  18.9    126     158
GC+TC:          67  121  40.4    116     395

```

###rvm use 2.0.0

```
              min  mean[+/-sd] median   max
Default:       119  158  25.3    154     211
GC    :         65  120  36.1    118     221
GC+TC :         67  113  20.0    114     175

```

###What is the deal with RUBY_GC_MALLOC_LIMIT

This is one of the most poorly documented bits of optimisation out there: 

https://github.com/ruby/ruby/blob/trunk/gc.c#L68-L70

https://github.com/ruby/ruby/blob/trunk/gc.c#L3479-L3483

Out-of-the box Ruby forces a GC every time 8 megs of memory is allocated this is insanely low, our front page caused about 32megs of allocation thus causing 4 GCs. bumping this up to allowing 90megs of allocation before forcing a GC means there is much less pressure of the GC. We are able to handle 3 or so requests without a GC.

As a rule we want the number large, but not too large, if its too big we will bleed way too much memory and GC will take forever. If its too small, like it is out-of-the-box we will have multiple GCs per page which is horrible on so many levels.

###What is the impact of raising RUBY_GC_MALLOC_LIMIT to 90 million ? 

On our test rig, resident memory raised from **116Megs**  to **193Megs** for the GC setting alone and up to **211Megs** when combined with tcmalloc

###What do you recommend?

I have 2 recommendations depending on your stance:

- **Conservative**: All conservative installs should use  RUBY_GC_MALLOC_LIMIT=90000000 , its a no-brainer and the increased memory usage is well worth the extra perf, you get a **48%** decrease in median request time just by doing that. 

- **Bleeding Edge**: I would recommend using Ruby 2.0 allocating memory using tcmalloc. You get a **57%** decrease in median request time using that. 

I can no longer recommend falcon patches due to the fact most of the patches are in 2.0 anyway, embrace the future. 

###Issues with this test 

The test was performed on a CPU that has [Turbo Boost][1] enabled. This means that clock speed varies based on load. It made it more complicated to get consistent test runs, that said I repeated all the tests multiple times and **it was run on our production boxes**. 

###Why are we eating so much memory per request? 

The easiest thing to answer here is what kind of memory we are consuming: (adding ?pp=profile-gc)

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/1X/78220269ef8888a5dd756d3f6f8c1bbbff3abb81" width="498" height="325">

<sub>230 THOUSAND strings allocated during one request</sub>

It is going to take us a while to work through this to find the actual culprits, though quite a few of the strings allocated over and over again do seem to be coming from Active Record, so focusing on cutting the amount of querying is a sure way to reduce string allocations during a request life cycle. 

###What about Rails 4? 

We need to re-test this under rails 4 to see if its faster or slower and determine if string allocations have gone up or down. 

 
  [1]: http://en.wikipedia.org/wiki/Intel_Turbo_Boost

<small class="documentation-source">Source: [https://meta.discourse.org/t/tuning-ruby-and-rails-for-discourse/4126](https://meta.discourse.org/t/tuning-ruby-and-rails-for-discourse/4126)</small>
