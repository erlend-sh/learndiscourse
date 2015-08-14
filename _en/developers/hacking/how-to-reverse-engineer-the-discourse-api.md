---
title: How to reverse engineer the Discourse API
weight: 360
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-reverse-engineer-the-discourse-api/20576](https://meta.discourse.org/t/how-to-reverse-engineer-the-discourse-api/20576)</small>

Discourse is backed by a complete JSON api. Anything you can do on the site you can also do using the JSON api. 

Many of the endpoints are properly documented in the [discourse_api][1] gem, however some endpoints lack documentation. 

To determine how to do something with the JSON API here are some steps you can follow. 

Example: recategorize a topic.

- Go to a topic and start editing a category:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/4/341aa305bf22750b3fbbb0218f30602b576c8371.png" width="690" height="108"> 

- Open Chrome dev tools, select XHR filter:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/4/34dbad12da5c1235ad17161fbfd9a2fa38da0151.png" width="573" height="500"> 

- Perform the operation

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/f/7/f73a597b2ab8c7a370ad4206b161bb05f470f8dd.png" width="690" height="285"> 

- Look at preview as well to figure out the results

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/7/4/74514f638bc8be17e37ecb30da84e5344173f290.png" width="690" height="181"> 

- You now have all the info you need. 

1. The endpoint is `http://try.discourse.org/t/online-learning/108.json`
2. Payload is passed using a `PUT`
3. The params sent are: 
   `title: Online learning` 
   `category_id: 5`

Equip with this information you can make your own calls using your favorite programming language, all you need to do is add **api_username** and **api_key** to parameters to the request. 

They can be generated using the API admin tab.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/6/d6b084f793d0e0d561751b6c460d520d9a8654df.png" width="690" height="164"> 


  [1]: https://github.com/discourse/discourse_api
