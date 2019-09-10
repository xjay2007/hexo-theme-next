{% macro render(posts) %}
{%- for post in posts %}

  {%- set year %}
  {%- set month %}
  {%- set post.year = date(post.date, 'YYYY') %}
  {%- set post.month = date(post.date, 'MM') %}

  {%- if post.year !== year || post.month !== month %}
    {%- set year = post.year %}
    {%- set month = post.month %}
    <div class="collection-year">
      <{%- if theme.seo %}h2{% else %}h1{%- endif %} class="collection-header">{{ year }}.{{ month }}</{%- if theme.seo %}h2{% else %}h1{%- endif %}>
    </div>
  {%- endif %}

  <article itemscope itemtype="http://schema.org/Article">
    <header class="post-header">

      <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="post-title">
        {%- if post.link %}{# Link posts #}
          {%- set postTitleIcon = '<i class="fa fa-external-link"></i>' %}
          {%- set postText = post.title or post.link %}
          {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url' }) }}
        {% else %}
          <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
            <span itemprop="name">{{ post.title | default(__('post.untitled')) }}</span>
          </a>
        {%- endif %}
      </{%- if theme.seo %}h3{% else %}h2{%- endif %}>

      <div class="post-meta">
        <time class="post-time" itemprop="dateCreated"
              datetime="{{ moment(post.date).format() }}"
              content="{{ date(post.date, config.date_format) }}">
          {{ date(post.date, 'MM-DD') }}
        </time>
      </div>

    </header>
  </article>

{%- endfor %}
{% endmacro %}
