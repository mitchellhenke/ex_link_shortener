# LinkShortener

Simple link shortener using Plug.

A POST to `/get_short_link` where the body contains the link to be shortened will return a shortened link in the body.

Any GET requests to that link will hopefully redirect to the original link relatively quickly :)

The link information is stored in ETS via [con_cache](https://github.com/sasa1977/con_cache).
