---
title: Any kind of Data-Input (also anonymous) through Google-Forms
weight: 160
---

Heyah,

I have written a short script **automatically posting new Google-Form-Entries to Discourse**. You can use it to allow any kind of 3-party Data input into discourse for example:
 
 - Anonymous Feedback
 - Support-Request
 - Membership-Applications (this is what we do with it)

### The script
The script is small and simple:

```javascript
// ----- MINIMUM CONFIGURATION !!!!
// generate this at /admin/api
API_KEY = "d29dXXXXXXXXXXXXXXXXXXXXX70"
// use full qualified domain name in url to discourse index
TARGET_INSTALLATION = "http://DISCOURSE.EXAMPLE.ORG/"

// ----- Optional Configuartion

// which category to post this to? Default: 'uncategorized'
CATEGORY = 'uncategorized'
// which user should be the one posting? Default: 'system'
POSTER = "system"

// you probably wanna activate this, when using templates
INCLUDE_RAW_DATA = true

// the title to post at,
// should contain any 'form'-replacer or Discourse might complain it already has that title
TITLE_TEMPLATE = "New Form Entry: {{Name}}"

// Wanna have it look pretty?
TEMPLATE  = "# {{Name}}\n\n - Water Type: {{Water}}" + 
             

function _compile(source, values){
    var processed = source;
    for (key in values) {
      processed = processed.replace("{{" + key + "}}", values[key]);
    }
    return processed;
  }


function _compile_data_from_form(formResponse){
  var data = {},
      itemResponses = formResponse.getItemResponses();
  for (var j = 0; j < itemResponses.length; j++) {
    var itemResponse = itemResponses[j];
    data[itemResponse.getItem().getTitle()] = itemResponse.getResponse();
  }
  return data;
 }

function postToDiscourse(evt) {
  
  var vals = evt.namedValues || _compile_data_from_form(evt.response),
      title = _compile(TITLE_TEMPLATE, vals),
      text  = _compile(TEMPLATE, vals);
 
  if (INCLUDE_RAW_DATA) {
    var entries = [];
    for (key in vals){
      entries.push(" - **" + key + "**: " + vals[key]);
    }
    text += "\n Raw Values: \n\n" + entries.join('\n');
  }
  
  UrlFetchApp.fetch(TARGET_INSTALLATION + "/posts", {'method': 'post', 'payload':{
                    'category': CATEGORY,
                    'auto_track': false,
                    'title': title,
                    'raw': text,
                    'api_key': API_KEY,
                    'api_username': POSTER
                    }});
}

function API_TEST(){
  //var form = {namedValues:{'Name': 'Benji', 'Email': 'Testi'}};
  var form = FormApp.openById("1RnCD4I2VgWpzTiJTq-0qq6u-v-LEpEKQgOBmhafTsQo"),
      formResponses = form.getResponses(),
      newestResponse = formResponses[formResponses.length -1];
  postToDiscourse({response: newestResponse});
}
```

### Installation

1. Generate an ADMIN-Key of your installation at /admin/api
2. Add Script to a new googles form or existing one via `Tools-> Script Editor`
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/a/3ac2c05306bea1bf1bffcd1ab6c07128901d5fc2.png" width="270" height="151"> 

3. Copy the entire script into the new Editor that opens
4. Replace the API-Key in the script with the one from your installation,
Change the Installation-Target-Name
5. Save and check your configuration by running the "API_TEST" function:
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/9/d919b8d3054432c8e48250cd3ee16ff1fa1e6453.png" width="246" height="119">  <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/f/3f4544f93df306f8f36c916e19f7bc025e6318e8.png" width="189" height="59"> 

6. A new post should show up in your Discourse.
 – you might want to do redo this one until the configuration (posting user, posting in proper category) are all figure out
7. Connect function to trigger by going to `Resources->All Triggers` and an on-form-submit-trigger connected to the `postToDiscourse` function:
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/1/6/16dd3f7b4ecb5fe7743768682e8c6cb583572326.png" width="279" height="117">  <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/1/1/11ecd15ce45a2bbd55ca8096eac84f92e65b0907.png" width="690" height="40"> 
(you might be asked to give permission when saving the first time: yes, please do so)

**Voilá, you'll receive new posts (including all update and email features) of forms submitted in your discourse instance from now on.**

You might want to also take a look at my ["automatically email form-data" script and add that one][1], too. As always, feel free to posts questions, feedback and praise right down here as replies :) .


  [1]: https://gist.github.com/ligthyear/5488787

<small class="documentation-source">Source: [https://meta.discourse.org/t/any-kind-of-data-input-also-anonymous-through-google-forms/21008](https://meta.discourse.org/t/any-kind-of-data-input-also-anonymous-through-google-forms/21008)</small>
