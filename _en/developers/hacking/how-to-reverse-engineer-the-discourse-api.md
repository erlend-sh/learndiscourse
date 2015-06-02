---
title: How to reverse engineer the Discourse API
name: how-to-reverse-engineer-the-discourse-api
---

Discourse is backed by a complete JSON api. Anything you can do on the site you can also do using the JSON api. 

Many of the endpoints are properly documented in the [discourse_api][1] gem, however some endpoints lack documentation. 

To determine how to do something with the JSON API here are some steps you can follow. 

Example: recategorize a topic.

- Go to a topic and start editing a category:

<img src="/uploads/default/35184/75238c2b804186e0.png" width="690" height="108"> 

- Open Chrome dev tools, select XHR filter:

<img src="/uploads/default/35185/dde8907a921a3d17.png" width="573" height="500"> 

- Perform the operation

<img src="/uploads/default/35186/1212af16b492e3d7.png" width="690" height="285"> 

- Look at preview as well to figure out the results

<img src="/uploads/default/35187/d1c53df33f556d23.png" width="690" height="181"> 

- You now have all the info you need. 

1. The endpoint is `http://try.discourse.org/t/online-learning/108.json`
2. Payload is passed using a `PUT`
3. The params sent are: 
   `title: Online learning` 
   `category_id: 5`

Equip with this information you can make your own calls using your favorite programming language, all you need to do is add **api_username** and **api_key** to parameters to the request. 

They can be generated using the API admin tab.

<img src="/uploads/default/35188/b374e59136404ca6.png" width="690" height="164"> 


  [1]: https://github.com/discourse/discourse_api