# Bearing, a scripting helper for Bear

## What it does

Bearing allows for scripting Bear. Out of the box, Bear can be automated using
[its x-callback-url API](https://bear.app/faq/X-callback-url%20Scheme%20documentation/),
meaning you call a URI
(`open "bear://x-callback-url/[action]?[action parameters]&[x-callback parameters]"`)
to do things.  Bearing adds to that by slightly abstracting and enhancing the
experience:

1. You get a dedicated `bearing` CLI tool.
2. Bearing returns callback responses as JSON.


## Usage

```bash
/usr/local/bin/bearing ACTION [parameters]
```

`ACTION` is the Bear action to call (e.g., 'open-note', 'create', 'add-text',
etc.)

Parameters are passed as 'key=value' pairs, e.g. 'title="My new note"'. See
[Bear's API documentation](https://bear.app/faq/X-callback-url%20Scheme%20documentation/)
for available parameters.

Bearing consists of both an unobtrusive statusbar app and a CLI component.
The former will automatically open when the latter is used; it is needed for
getting return values from the Bear API.


## Examples

Please note: the results below are formatted nicely for better readability, the
actual JSON results are not pretty-printed.

### Opening a note

```bash
/usr/local/bin/bearing \
  open-note \
  --id="123D41D6-E0F1-1234-1234-1B80D08074B7-12345-0000A0958DF5307C"
```

Returns:

```json
{
  "creationDate": "2020-06-12T07:39:06Z",
  "title": "rtomayko/posix-spawn: Ruby process spawning library",
  "is_trashed": "no",
  "note": "# rtomayko/posix-spawn: Ruby process spawning library\nhttps://github.com/rtomayko/posix-spawn\n\n…",
  "identifier": "123D41D6-E0F1-1234-1234-1B80D08074B7-12345-0000A0958DF5307C",
  "modificationDate": "2020-06-12T07:39:06Z",
  "_success": true
}
```

### Creating a note

```bash
/usr/local/bin/bearing \
  create \
  --title="Bearing test note" \
  --text="Works for me!"
```

Returns:

```json
{
  "title": "Bearing test note",
  "identifier": "4963F8B4-3FE0-4835-B96D-7DCCB6101A62-1917-00013DC4BC4EE819",
  "_success": true
}
```

### Searching

```bash
/usr/local/bin/bearing
  search \
  --term=macOS \
  --token=ABCDEF-123456-A1B2C3
```

Returns:

```json
{
  "notes": [
    {
      "creationDate": "2020-06-14T10:09:00Z",
      "title": "Maccy - clipboard manager for macOS",
      "modificationDate": "2020-06-14T10:09:00Z",
      "identifier": "37FA3BEA-E670-1234-1234-9BA2EAB129FF-687-0000004F844AA84B",
      "pin": "no"
    },
    {
      "creationDate": "2020-06-12T07:39:06Z",
      "title": "rtomayko/posix-spawn: Ruby process spawning library",
      "modificationDate": "2020-06-12T07:39:06Z",
      "identifier": "123D41D6-E0F1-1234-1234-1B80D08074B7-12345-0000A0958DF5307C",
      "pin": "no"
    },
    {
      "creationDate": "2020-06-05T09:29:17Z",
      "title": "sbusso/Bear-Power-Pack: A collection of workflows enhancing Bear writer app on iOS and Mac.",
      "modificationDate": "2020-06-11T15:11:07Z",
      "identifier": "310C0689-50D2-1234-1234-F122397F8784-12345-00030C6A48F46C48",
      "pin": "no"
    },
    …
  ]
}
```


## Credits

Bearing was made by Carlo Zottmann, <https://czm.io/>, <carlo@zottmann.org>.


## License

MIT.  See [LICENSE.md](LICENSE.md).


## Acknowledgements

[Bear](https://bear.app/) is a neat piece of software
(c) [Shiny Frog, Inc.](http://www.shinyfrog.net/)  Bearing and its
author are neither affiliated nor endorsed by Shiny Frog.  I'm just a fan of
their stuff.

The Bearing app was made using [Platypus](https://sveinbjorn.org/platypus), _"a
developer tool that creates native Mac applications from command line scripts"_
by Sveinbjörn Þórðarson.  Platypus is dope, trust me on that.

---

![app icon](assets/appicon.png)
