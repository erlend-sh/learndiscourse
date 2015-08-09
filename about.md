---
layout: page
lang: en
identifier: about
translations:
  -
    lang: en
    url: 'hi'
---

## Workflow for Docs Contributors

Contributing to learndiscourse.org is very simple. All of this site's documentation contents is copied directly from meta.discourse.org's How-to and FAQ categories. All original documentation editing should be done strictly on Meta.

### Creating a new Document

1. Simply create a new topic in either the [How-tos] (requires TL 2) or [FAQ] category. 

2. Give it a day or two, and your new document will appear on learndiscourse.org with a link back to your original topic on Meta. *That's it!*

*(For now, docs contributors can't decide the section (/users, /developers etc.) or sub-section for their article. The docs maintainers will simply make that call. This will probably change in the future.)*

### Editing an existing Document

1. Simply edit your (or a wiki-enabled) topic on Meta and save your changes.

2. Your changes will be applied the next time we update learndiscourse.org, which usually happens at least once every week.

## Updating learndiscourse.org

*NOTE: This job is reserved for Owners or Contributors of /nahtnam/learndiscourse.*

### The 'How'

For the time being, learndiscourse.org is manually updated, aided by simple script utilities. This is how we do it:

1. Clone `https://github.com/nahtnam/learndiscourse`
2. Edit the `/tools/doc_list.yml` file to reflect newly added or moved pages (you can skip this step if you're only updating existing pages).
3. Run the `/tools/doc_section_maintainer.rb` Ruby script (requires 2.1 or higher).
4. Overwrite the top level `/_en` folder with the new folders & files in the `export` folder created by the script.
5. (Optional) Run `generate_sidebar.rb` to generate a new sidebar. Overwrite & commit.

#### What is `doc_list.yml`?

`doc_list.yml` is a yaml file that tells `doc_section_maintainer.rb` which topics to pull down from meta.disourse.org.

#### What is `doc_section_maintainer.rb`?

`doc_section_maintainer.rb` is a ruby script that pulls down the first post of any Discourse topic on meta.discourse.org, and saves it as a .markdown file readable by Jekyll.


### The 'When'

You should run the script, check for changes and commit them if:

- It's been 2+ days since the last update.
- A new documentation-topic on Meta has not been copied to learndiscourse.org yet.
- An existing documentation-topic just received a major edit.
