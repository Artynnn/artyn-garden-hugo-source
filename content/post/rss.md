+++
title = "RSS"
author = ["Artyn"]
date = 2022-02-10T10:38:00-06:00
tags = ["Web"]
draft = false
+++

## what is RSS? and how do I use it? {#what-is-rss-and-how-do-i-use-it}

RSS is a way to follow updates to websites, however there are many different ways to see it.

-   user agent to the web
-   some see it as a notification system
-   personal newspaper (with their own personal design)
-   multi-platform social media client
-   a personal live bookmarking system, and a more user-centric "history" and "search".
-   like "email", a personal to-do list and they must have a "zero inbox".

This is done via a RSS 2.0 or ATOM XML document that your feed reader downloads and parses.


## history of RSS {#history-of-rss}

RSS had a complicated history. From Netscape RDF site summary, to aggregator (Winer's RSS 9.x) to O'Reilly expansive RSS 1 and Winer's final revision RSS 2. And a simpler project of ATOM.

RSS proper came about in the early 2000s. It's first introduction was in the 1999. Note the RSS protocol has a lot of technical problems ([see this](https://nullprogram.com/blog/2013/09/23/)), and the RSS project was lead by, [what many saw as a despotic dictator](http://www.smashcompany.com/technology/rss-has-been-damaged-by-in-fighting-among-those-who-advocate-for-it). These two problems lead to the creation of ATOM protocol, which most people who build feed readers prefer you to use.&nbsp;[^fn:1]

RSS never re-gained it's mid 2000s centrality, numerous [websites build on top of it](https://mattmower.com/2021/08/02/what-we-lost/) to create social applications like [Google Reader](https://www.ripgooglereader.com/). And many mega-corporations saw fit to abandon it for their own walled gardens like Google shutting down Google Reader for Google+ and their other products, [Twitter and Facebook removing the ability to follow by RSS](https://web.archive.org/web/20110602013236/http://www.staynalive.com/2011/05/twitter-and-facebook-both-quietly-kill.html?q=1). In the pasts browsers like Safari and Firefox supported RSS natively.


## what features should your feeder reader have? {#what-features-should-your-feeder-reader-have}

There are so many options but I think having these qualites are ideal for a feed reader.

-   be able to change the styling
-   be able to categorize (tags, folders, categories etc)
-   searchable (full text, title, tag, date etc)
-   open in external program (browser, media player, PDF reader)
-   extendable and programmable
-   can change the keybindings
-   kill or score file (be able to remove things based title, content etc, preferable programmable)
-   less important:
    -   different types of views
    -   star items (if you can have tags this is easy)
    -   be able to annotate?
    -   can view offline

I personal recommend the following clients:

-   liferea (GUI)
-   quiteRSS (GUI)
-   elfeed (Emacs)
-   newsboat (TUI)

These clients fufill the above qualities and are easy to setup and use. Its too much of a hassle to set up PHP, MongoDB and Apache just to get a feed reader (e.g freshRSS, tinyRSS etc).


## what you can access {#what-you-can-access}

I think it is imporant to write down all the possible things you can follow. People don't know how versatile it really is.

-   google custom search (need more work on understanding how)
-   pubmed search
-   academic journals
-   reddit
-   podcasts
-   github / gitlab commits
-   youtube
-   substack
-   most blogs
-   twitter (via nitter)
-   academic journals
-   via [bridges](https://github.com/RSS-Bridge/rss-bridge/tree/master/bridges)
    -   duckduckgo searches
    -   instagram
    -   [email](https://github.com/remko/atomail)
    -   [anything](https://createfeed.fivefilters.org/) (with css selectors for scraping purposes)

Note that the bridges are unreliable so I don't think you should focus on them too much.

[^fn:1]: Though I have heard contradictory accounts. Mainly that he was bullied by the O'Reilley faction. Whatever the case, coordination was a disaster.