+++
title = "Colophon"
date = 2022-02-14T16:21:00-06:00
tags = ["Web"]
draft = false
+++

[Source code for the website](https://github.com/Artynnn/artyn-garden-hugo-source).

This is about the [design of the website](https://artyns-garden.vercel.app) and the principles behind them.

[rss](rss.md)


[rss]({{< ref "rss.md" >}})

## Principles {#principles}

### KISS {#kiss}

Do not use over-engineered build scripts, web frameworks or big tooling. The max I am going to use is maybe SASS and [esbuild](https://esbuild.github.io/).


### Keep content clean {#keep-content-clean}

I keep my [content in a seperate git repository](https://github.com/Artynnn/wiki/) and I try to keep it as clean as possible, I don't want anything tied to that is specific to Hugo or my website.

This might seem a bit weird but I like the flexibility of packing up whenever I can. I don't see my content as fundamentally tied to website, which merely serves as a interface to it.


### Be beautiful {#be-beautiful}

Websites should be beautiful. Have beautiful typography and niceties.


## On the format being a personal wiki {#on-the-format-being-a-personal-wiki}

There are many reasons why I prefer the personal wiki format for my website rather then a blog.

-   Quality is favored over recency.

-   Easier to approach the whole site, particularity if it's very divergent compared to what you usually see. Grokking is easier.

-   Modification is normal and good.

-   Holism over trendiness

-   drafts are okay (stubs), nothing wrong in making them. This makes it easy to make more content.

-   Long absences are okay

Blogs are great, but I don't think they suit the purpose of my personal website and what I want. My blogging needs are solved with Mastodon.

I know the distinction between personal and blog can get blurry, some blogs are very personal wiki-eqsque, like for example Jeremy Friesen's [takeonrules](https://takeonrules.com/), who constantly updates old posts, maintains a glossary and weaves blogposts into series.

To me a blog mean being bound to publication date rather then the modification date.


### Handling RSS {#handling-rss}

I personally do want RSS and I want that RSS to be useful. I think this is one of the main benefits of blog is that it makes getting regular good content easy.

My current solution is to tag things "evergreen" (like a fully developed tree) if its in a very finished and complete state and this will syndicate full text in my website RSS feed. Of course evergreen content will get updated but its probably going to like 10% more not 95% more.

Stubs and "saplings" can be followed via my [github RSS feed](https://github.com/mapstruct/mapstruct/commits/master.atom)[^fn:1].

More bloggy and status updates can be followed via my [Mastodon feed](https://fosstodon.org/@artyn.rss).


### Features {#features}

My website has a lot of features that aid its function as a personal wiki.

-   Link to revision history.

-   Side-notes (you don't have to click 25 times backward and forward). Also the sidenotes are just Hugo footnotes not shortcodes or any special syntax. Things behave normally if javascript is disabled

-   Backlinks: See where the page you are currently viewing is referred to.

-   aside TOC: for easy navigation? This is a bit buggy.

-   link to jump to top of the page


### possible future features {#possible-future-features}

Things I am not sure of adding right now but might in the future:

-   webmentions: I am not sure how to implement it. I think I want it mainly the Mastodon support. I am interested in how bridging services to non webmention supporting sites are. Some guides for Hugo ([embacing the Indie Web](https://ascraeus.org/embracing-the-indieweb/), [adding web mentions to my hugo site](https://anaulin.org/blog/adding-webmentions/))

-   access-keys: I would [follow the standard](https://archive.fo/58CAY).

-   [microformats2](http://microformats.org/wiki/microformats2): I am in generally very confused on how to set this up. I need to do more reading. I have seen very few websites follow it, only Indieweb ones.

-   microData: Even more confused.


### Useful documents {#useful-documents}

On the management of wikis.

-   [Wikipedia guide on Edit Summary](https://en.wikipedia.org/wiki/Help:Edit_summary#Always_provide_an_edit_summary)
-   [Revision Controlled Journalism](https://gist.github.com/Enegnei/a33e8c11e6bd23ac7b367a57b895d077) ([example](https://github.com/Enegnei/JacobAppelbaumLeavesTor))


## Style {#style}

I like the Tufte design and it basically follow that, I am not using its style sheet at all just following some of its style.

[^fn:1]: I wish included information on size of commit.
