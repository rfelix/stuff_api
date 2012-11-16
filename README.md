# Stuff API

The Stuff API is an example I created for a presentation on Hypermedia APIs I gave at SAPO Codebits 2012:

### [REST: You're doing it wrong][1].

It's a really basic Todo list API that uses the [Collection+JSON][2] media type. It's currently only holds Todo items in memory, no persistence. Oh, and there's no authentication, only one giant Todo list for everybody :)

What it currently allows is:

* Listing of 3 different types of lists (Inbox, Today, Next)
* Creating a new Todo item in the corresponding list
* Moving a Todo item from one list to another

I actually deployed this service on Heroku which you can find at: http://stuff-api.herokuapp.com

Go ahead and try navigate this Hypermedia API:

```
curl -v http://stuff-api.herokuapp.com
```

[1]: https://codebits.eu/intra/s/session/255
[2]: http://amundsen.com/media-types/collection/

### Notes on implementation

This was built with Ruby using the Padrino framework.

The code was Behaviour Driven Developed using RSpec for unit tests and RSpec-Given for the acceptance (feature) tests.

It's not the most exemplary code, there's *a lot* of things that can be done better.

I also decided to try out some of the ideas mentioned in the talk [The Clean Architecture][3] by Robert Martin (aka Uncle Bob).

[3]: http://vimeo.com/43612849

## Sources

These are some of the sources I used during the presentation and which can act as a starting point for those who would like to learn more about Hypermedia APIs.

Books:

 - [Steve Klabnik Designing Hypermedia APIs](http://designinghypermediaapis.com/)
 - [Mike Amundsen: Building Hypermedia APIs with HTML5 and Node](http://shop.oreilly.com/product/0636920020530.do)
 - [Roy T. Fielding: Architectural Styles and the Design of Network-based Software Architectures](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)
 - [Mike Amundsen at QCon](http://www.infoq.com/presentations/Hypermedia-API-Node-js)

Presentations:

 - [Jon Moore at Øredev 2010](https://vimeo.com/20781278)
 - [Mike Amundsen at REST Fest 2012](https://vimeo.com/49503453)
 - [Designing Hypermedia APIs](https://speakerd.s3.amazonaws.com/presentations/50546c34bf73df000204729d/hypermedia_railsclub.pdf)

Blog posts:

 - [If REST was...](http://amundsen.com/blog/archives/1131)
 - [Hypermedia Benefits for M2M Communication](http://www.innoq.com/blog/st/2012/06/hypermedia-benefits-for-m2m-communication/)
 - [Practical Hypermedia for our post ORM world](http://www.aaronheld.com/post/practical-hypermedia)
 - [REST APIs must be hypertext-driven](http://roy.gbiv.com/untangled/2008/rest-apis-must-be-hypertext-driven)
 - [Gustaf Nilsson Kotte: Combining HTML Hypermedia APIs and Adaptive Web Design](http://www.jayway.com/2012/08/01/combining-html-hypermedia-apis-and-adaptive-web-design/)
 - [Björn Rochel: My Pain With a Non Hypermedia HTTP API](http://www.bjoernrochel.de/2012/10/16/the-pain-of-a-non-hypermedia-http-api/)
 - [Jan Kronquist and Mads Enevoldsen: Why hypermedia APIs?](http://www.jayway.com/2012/10/06/why-hypermedia-apis/)
 - [Collection+JSON](http://amundsen.com/media-types/collection/)