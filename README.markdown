# Hubboard

Want to know who and when pushed latests changes to your company's repo?

Want to know who started following something interesting?

Want to see latests gists created by someone you follow?

Want to stop using your browser for checking that stuff?

Want to get notified about it with you favorite desktop notification tool?

## Use hubboard!

![very early screenshot](http://img.skitch.com/20101210-ka3wqj8hu9h8ujt3e7efnhjet4.jpg)

## Why?

Hubboard was created because of two reasons:

* I'm using GitHub both at work and personally so I want to stay informed on what's going on - especially while at work
* I wanted to see whether you can create a non-trivial app in Ruby using [wxRuby](http://wxruby.rubyforge.org)


# How to make it work?

If you have a Mac you can just grab the package from *Downloads* (you'll
need Growl as well for the notifications).

Linux is a bit tricky - recent changes to wxWidgets packages made wxRuby
gem unusable - see [this issue for details](https://github.com/lukaszkorecki/Hubboard/issues#issue/1)

However previous Ubuntu version (10.4 - Lucid) is perfectly fine, you'll
be able to run Hubboard after installing some dependencies (`wxbase`,
`libwxgtk-2.8-{0,dev}`)

Notifications support is underway.

I haven't checked Ms Windows - if someone's eager to test it out that
would be splendid!

# Contributing and stuff

There's a set of Rake tasks which will help you out.  `rake -T` for help.


Usual rules: fork, feature branch, pull request. Thanks!

## Credits

[Fugue Icon Set](http://p.yusukekamiyamane.com/) by [Yusuke Kamiyamane](http://p.yusukekamiyamane.com/about/)

## TODO

* fix issues
* once Linux version works - add support for notifications
* Gist support (CRUD)
