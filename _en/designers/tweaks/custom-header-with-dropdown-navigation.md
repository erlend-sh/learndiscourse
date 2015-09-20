---
title: Custom header with dropdown navigation
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/custom-header-with-dropdown-navigation/33451](https://meta.discourse.org/t/custom-header-with-dropdown-navigation/33451)</small>

I recently made a dropdown navigation menu for [Envato's new forums][1], so I'll share some code to implement something similar on your own site.

----------

We'll be implementing a black header with one link that reveals a menu of more links, like this:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/4/0/400b7559b2c054526ab45b0085a312f72f31fc17.png" width="413" height="171">

In Admin > Customize > CSS/HTML, create a new customization. Remember that you can have multiple customizations active at the same time, so it's a good idea to use many of them instead of one giant one for everything. For this custom header, create a new customization called "Header Nav".

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/a/2/a2a885c01cdc659da0e05035b39d69b5f2d9176c.png" width="690" height="244">

To implement this sample nav, we need some CSS, HTML, and javascript to show and hide the dropdown menu.

In the CSS tab:

```
/********** Sticky Nav **********/

.desktop-view body #main {
  padding-top: 74px;
}

#top-navbar {
  height:60px;
  background-color:#222;
  width:100%;
  position: fixed;
  z-index: 1001;
}

.desktop-view body header.d-header {
  top: 59px;
  padding-top: 6px;
}

div#top-navbar-links {
  width:100%;
  margin: 0 auto;
  padding-top: 0;
  max-width:1100px;
  margin-top: 0;
}

div#top-navbar-links a, div#top-navbar-links span {
  color:#eee;
  font-size: 14px;
}


/* js dropdown navs */
#top-external-nav {
  float: right;
  margin-top: 12px;
  position: relative;

  list-style: none;

  li.top-ext--main {
    float: left;
    margin-right: 10px;
    > a, > a:visited, > a:active {
      display: inline-block;
      padding: 6px 10px;
      font-size: 14px;
      color: #999999;
      &:hover {
        background-color: black;
      }
    }
  }

  #top-discourse-link a.top-discourse-link-main {
    padding: 6px 10px 20px 10px;
  }

  ul.top-ext--sub {
    display: none;
    position: absolute;
    top: 40px;
    left: 0;
    margin-left: 0;
    background-color: white;
    box-shadow: 0 2px 5px rgba(0,0,0, .5);
    list-style: none;

    li.top-ext--sub-item {
      float: none;
      padding: 0;
      margin: 0;
      background-color: white;
      a, a:visited {
        display: inline-block;
        width: 190px;
        padding: 8px 10px;
        span {
          font-size: 14px;
          color: #666;
        }

        img {
          width: 20px;
          margin-right: 6px;
        }
      }

      &:hover {
        background-color: #eef;
      }
    }
  }
}
```

In the Header tab, we add the HTML with our navigation links:

```
<div id="top-navbar">
  <div id="top-navbar-links">
    <ul id="top-external-nav">
      <li class="top-ext--main" id="top-discourse-link">
        <a class="top-ext--link top-discourse-link-main" href="http://www.discourse.org/">Discourse</a>
        <ul class="top-ext--sub" id="top-discourse-sub">
          <li class="top-ext--sub-item">
            <a class="top-ext--link" href="https://meta.discourse.org" target="blank">
              <span>Meta</span>
            </a>
          </li>
          <li class="top-ext--sub-item">
            <a class="top-ext--link" href="http://try.discourse.org/" target="blank">
              <span>Try</span>
            </a>
          </li>
          <li class="top-ext--sub-item">
            <a class="top-ext--link" href="https://www.discourse.org/faq/" target="blank">
              <span>FAQ</span>
            </a>
          </li>
        </ul>
      </li>

      <li class="top-ext--main">
        <a class="top-ext--link" href="http://blog.discourse.org/" target="blank">Blog</a>
      </li>

      <li class="top-ext--main">
        <a class="top-ext--link" href="https://payments.discourse.org/buy/" target="blank">Buy It</a>
      </li>
    </ul>
  </div>
</div>
```

Finally, in the `</body>` tab, we add the javascript to get the dropdown menu to appear and disappear:

```
<script type="text/javascript">
$(function() {
  var $topDiscourseSub = $('#top-discourse-sub');
  $('#top-discourse-link').hover(function() {
    $topDiscourseSub.show();
  }, function() {
    $topDiscourseSub.hide();
  });
});
</script>
```

Check the "enabled" checkbox and Save it. View the site in another tab to see it in action!

  [1]: https://forums.envato.com
