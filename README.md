# LinkShortener

Simple link shortener using Plug.

A POST to `/make_short_link` where the request body contains the link to be shortened will return a shortened link in the response body.

Any GET requests to that link will hopefully redirect to the original link relatively quickly :)

The link information is stored in ETS via [con_cache](https://github.com/sasa1977/con_cache).
