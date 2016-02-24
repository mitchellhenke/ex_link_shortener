# LinkShortener

Simple link shortener using Plug.

A form POST to `/shorten_url` where the request body is url-encoded with a `url` key and a url in the value will return a shortened url in the body.

Any GET requests to that link will hopefully redirect to the original link relatively quickly :)

The link information is stored in ETS via [con_cache](https://github.com/sasa1977/con_cache).

A running example is available on heroku [here](https://salty-cove-39400.herokuapp.com/).
