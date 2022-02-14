+++
title = "Thoughts on Usenet"
date = 2022-02-10T18:24:00-06:00
tags = ["Web"]
draft = false
+++

Note that I never used it. Only read about it. But from what I've read it seems quite interesting.

For those who don't know Usenet use to be the de-facto internet. HTML use to not be the dominant medium but E-mail and E-mail style protocols.

It was basically like Reddit but conforming to the constraints of that time (e.g you could only transmit plain text at a reliable rate). Its like if Reddit acted more like E-mail.

Unlike Reddit it was standardized (defined currently by what I believe is RFC 5536, 5537, 6048, 4643 and 4644?&nbsp;[^fn:1]), and had a plethora of powerful clients (Gnus, \*rn family) and didn't really ban anyone&nbsp;[^fn:2] It also had a hierarchical structure which aided in discoverability (unlike Reddits flat hierarchy).

Despites it ubiquity I am personally shocked how a lot of its ideas haven't seeped into the designs of other websites. Its a quite fascinating read since so many of ideas and design choices are so alien.

I wish their was a Usenet 2. Usenet without the bad parts and supporting things like multi-media by default. I use Firefox Nightly, not some old unmaintained browser, and Reddit links constantly throw me a error, sometimes the page just randomly jitters, the textbox is in a different place since I am being used in a A/B test and I am bombarded with a random livestream in my feed.

Btw one of the best Usenet clients was Emacs (see my [Emacs Configuration]({{< relref "emacs_config.md" >}}) for more info)

[^fn:1]: During its heyday it seems to have been defined by RFC 822 1036 (and son of 1036) 977 934 and 1153.
[^fn:2]: This I thought was surprising when I learned about Usenet. They had a regex-based block and mute engine (the Killfile and the Scorefile). Even stranger, banning people on Usenet was a taboo. There were moderated newsgroups that had strict moderation however.