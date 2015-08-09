---
title: Custom nav header like discourse.org
---

<small class="doc-source">Source: https://meta.discourse.org/t/custom-nav-header-like-discourse-org/21053</small>

Getting inspired by 
<https://meta.discourse.org/t/best-way-to-customize-the-header/13368>

I managed to copy <https://discourse.org>'s main website header (hope you guys don't mind...).

Go to `admin/customize/css_html` and add a new customization. You can remove `target="_blank"` if you don't want the link to open in a new window. You might not need all the css, but I leave it there as it is what <https://discourse.org> has ;)

## Screens

Here's how it looks when you copy paste the code below.
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/7/9/79028d9cabc9051731372139dd79752411a5b689.png" width="690" height="90"> 

And how it looks after some more tweaking to match our theme.
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/a/3aa695360ad8d7de34c25ddeeaa0f39fac7493c1.png" width="690" height="86"> 

## Code

### Header

```
<nav id="bar">
    <ul>
        <li><a class="nav-link grey" href="https://example.com/link1" target="_blank">Link1</a></li>
        <li><a class="nav-link orange" href="https://example.com/link2" target="_blank">Link2</a></li>
        <li><a class="nav-link green" href="https://example.com/link3" target="_blank">Link3</a></li>
        <li><a class="nav-link yellow" href="https://example.com/link4" target="_blank">Link4</a></li>
        <li><a class="nav-link blue" href="https://example.com/link5" target="_blank">Link5</a></li>
    </ul>
</nav>
```

### Stylesheet

```
nav ul { 
    text-align: center;
}

nav ul li { 
    display: inline-block;
}

a:hover {
    transition: color 150ms ease-out 0s;
    color: rgb(44, 174, 195);
}

a {
    transition: color 150ms ease-out 0s;
    color: rgb(35, 137, 153);
}

nav#bar {
    width: 100%;
    height: 48px;
    background: #1b1f20;
    top: 20;
    z-index: 1;
}

nav#bar a.nav-link {
    color: rgb(255, 255, 255);
    text-decoration: none;
    text-align: center;
    font-family: 'Montserrat', sans-serif; 
    line-height: 48px;
    min-width: 90px;
    font-size: 16px;
    float: left;
}

nav#bar a.red.selected {
  color: #d13332;
  border-color: #d13332 !important; }

nav#bar a.red:hover {
  color: #d13332;
  text-shadow: 0px 0px 5px #d13332; }

nav#bar a.orange.selected {
  color: #ea5932;
  border-color: #ea5932 !important; }

nav#bar a.orange:hover {
  color: #ea5932;
  text-shadow: 0px 0px 5px #ea5932; }

nav#bar a.yellow.selected {
  color: #fff9ae;
  border-color: #fff9ae !important; }

nav#bar a.yellow:hover {
  color: #fff9ae;
  text-shadow: 0px 0px 5px #fff9ae; }

nav#bar a.green.selected {
  color: #18b159;
  border-color: #18b159 !important; }

nav#bar a.green:hover {
  color: #18b159;
  text-shadow: 0px 0px 5px #18b159; }

nav#bar a.blue.selected {
  color: #00aeef;
  border-color: #00aeef !important; }

nav#bar a.blue:hover {
  color: #00aeef;
  text-shadow: 0px 0px 5px #00aeef; }

nav#bar a.grey.selected {
  color: #aaa;
  border-color: #aaa !important; }

nav#bar a.grey:hover {
  color: #aaa;
  text-shadow: 0px 0px 5px #aaa; }

nav#bar a.nav-link.selected {
  line-height: 42px;
  border-top: 3px solid #0b0d0d;
  background-color: #0b0d0d;
  height: 45px;
}
```
