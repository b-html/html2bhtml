# html2bhtml

Convert HTML to [b-html](https://github.com/b-html/b-html).

## Installation

```
$ npm install html2bhtml
```

or

```
$ npm install --global html2bhtml
```

## CLI

### `npm install html2bhtml`

```
# convert index.html to index.bhtml
$(npm bin)/html2bhtml index.html

# convert src/**/*.html to dst/**/*.bhtml
$(npm bin)/html2bhtml -o dst/ src/
```

### `npm install --global html2bhtml`

```
# convert index.html to index.bhtml
html2bhtml index.html

# convert src/**/*.html to dst/**/*.bhtml
html2bhtml -o dst/ src/
```

## API

```javascript
import html2bhtml from 'html2bhtml';

html2bhtml('<p>Hello, b-html!</p>') === '<p\n  Hello, b-html!';
```

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
