class: center, middle

# Jekyll
## Day 1

---
class: center, middle

# So, what is Jekyll?

---
class: center, middle

#A simple static site generator

???

It takes a template directory containing
* raw text files in various formats
* runs it through a converter (like Markdown)
* and our Liquid renderer
* and spits out a complete, ready-to-publish static website
* suitable for serving with your favorite web server.

---
class: middle

```bash
~ $ gem install jekyll
~ $ jekyll new myblog
~ $ cd myblog
~/myblog $ bundle install
~/myblog $ bundle exec jekyll serve
# => Now browse to http://localhost:4000
```

---
class: center, middle

#Let's update the `_config.yml` now

---
class: middle

```
.
├── _config.yml
├── _drafts
|   ├── begin-with-the-crazy-ideas.textile
|   └── on-simplicity-in-technology.markdown
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   └── post.html
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
|   └── 2009-04-26-barcamp-boston-4-roundup.textile
├── _data
|   └── members.yml
├── _site
├── .jekyll-metadata
└── index.html
```

---
class: center, middle

# Let's get some data on our page using liquid template

---
class: center, middle

###The index page is defined by the theme gem.

###If you want to make changes, define your own in `_layouts` and `_includes`.

???
Do not use tabs in config file

---
class: middle

# Front Matter Defaults

```
defaults:
 -
  scope:
    path: "" # an empty string here means all files in the project
    type: "posts"
  values:
    layout: "post"
 -
  scope:
    path: "" # an empty string here means all files in the project
    type: "pages"
  values:
    layout: "page"
    author: "Ayush Goel"
```

???
* type is optional

---
class: middle

## For debugging, we will set the `error_mode` for liquid templating engine as `warn`.
```
liquid:
  error_mode: warn
```

---
class: middle

# Front Matter

```
---
layout: post
title:  "Welcome to Jekyll!"
date:   2016-10-15 07:43:36 +0530
categories: jekyll update
---
```

???
* On top of post/page
* enclosed within three dashes ---
  * layout
  * permalink
  * category
  * tags

---
class: center, middle

# Creating Posts

---
class: middle

#### 1. Create post file in `_posts`
#### 2. Format for filename is `YEAR-MONTH-DAY-title.MARKUP`.
#### 3. With correct converters installed, `MARKUP` can be any format.

---
class: center, middle

# Including Assets

???
1. Create a root folder named `assets`.
2. Link to them using `{{ site.url }}/assets/screenshot.jpg`.
3. Liquid takes care of the link.
4. In markdown `![text](link)`.
5. Pro tip : If url is going to be root domain, ignore `site.url`. `/assets/screenshot.jpg` is enough.

---
class: middle

# Code highlighting

```
{% highlight ruby linenos %}
def show
  @widget = Widget(params[:id])
end
{% endhighlight %}
```

---
class: center, middle

# Creating pages

---
class: middle

# Create markdown in `_pages` and add a `permalink` front matter tag on top.

###Picked from Jekyll 2

---
class: middle

# Create markdown in root folder itself.

```
|-- about.html    # => http://example.com/about.html
|-- index.html    # => http://example.com/
|-- other.md      # => http://example.com/other.html
└── contact.html  # => http://example.com/contact.html
```

---
class: center, middle

# Create named folders in root with `index` files in them.

```
├── about/
|   └── index.html  # => http://example.com/about/
├── contact/
|   └── index.html  # => http://example.com/contact/
|── other/
|   └── index.md    # => http://example.com/other/
└── index.html      # => http://example.com/
```

---
class: center, middle

#[Variables](https://jekyllrb.com/docs/variables/)
###https://jekyllrb.com/docs/variables/

---
class: center, middle

# CSS
## Sass / SCSS

???
* all sass files in `_sass`
* Use @import to get your other files

---
class: middle

```
---
# Front matter comment to ensure Jekyll properly reads file.
---

//Import
@import "base", "typography", "layout", "syntax";
// These files would be looked in sass_dir

```

---
class: center, middle

# [Blog Migrations](https://import.jekyllrb.com/docs/home/)
### https://import.jekyllrb.com/docs/home/

---
class: center, middle

# Pagination

---
class: middle

1. Add `paginate` in `_config.yml`
2. `jekyll-paginate` gem in `_config` and `Gemfile`.
3. `bundle install`.

---
class: middle

```
<!-- This loops through the paginated posts -->
{% for post in paginator.posts %}
  <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
  <p class="author">
    <span class="date">{{ post.date }}</span>
  </p>
{% endfor %}
```

---
class: middle

```
<!-- Pagination links -->
{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo;</a>
  {% else %}
    <span>&laquo;</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <em>{{ page }}</em>
    {% elsif page == 1 %}
      <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">{{ page }}</a>
    {% else %}
      <a href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
    {% endif %}
  {% endfor %}

  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">&raquo;</a>
  {% else %}
    <span>&raquo;</span>
  {% endif %}
</div>
{% endif %}
```

---
class: center, middle

# Plugins

### Create custom generated content using your own code, but `gihub-pages` doesn't support plugins, so it falls out of context here.
---
class: center, middle
