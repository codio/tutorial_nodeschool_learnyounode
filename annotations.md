@annotation:tour hello_world 
#1. Hello World
##Challenge
Write a program that prints the text "HELLO WORLD" to the console (stdout).

##Hints
To make Node.js program, create a new file with a `.js` extension and start writing JavaScript! Execute your program by running it with the `node` command. e.g.:

    $ node myprogram.js

You can write to the [console](http://nodejs.org/api/stdio.html#stdio_console) in the same way as in the browser:
  
    console.log("text")

When you are done, you must run:

    learnyounode verify myprogram.js

to proceed. Your program will be tested, a report will be generated, and the lesson will be marked 'completed' if you are successful.

##Node Documentation
- [console](http://nodejs.org/api/stdio.html#stdio_console)


@annotation:tour baby_steps
#2. Baby Steps
##Challenge
Write a program that accepts one or more numbers as command-line arguments and prints the sum of those numbers to the console (stdout).

You can access command-line arguments via the global `process` object. The `process` object has an `argv` property which is an array containing the complete command-line. i.e. `process.argv`.

##Hints
To get started, write a program that simply contains:

    console.log(process.argv)

Run it with `node myprogram.js` and some numbers as arguments. e.g:

    $ node myprogram.js 1 2 3

In which case the output would be an array looking something like:

    [ 'node', '/path/to/your/program.js', '1', '2', '3' ]
  
You'll need to think about how to loop through the number arguments so you can output just their sum. The first element of the process.argv array is always 'node', and the second element is always the path to your program.js file, so you need to start at the 3rd element (index 2), adding each item to the total until you reach the end of the array.

Also be aware that all elements of `process.argv` are strings and you may need to *coerce* them into numbers. You can do this by prefixing the property with `+` or passing it to `Number()`. e.g. `+process.argv[2]` or `Number(process.argv[2])`.


@annotation:tour my_first_io
#3. My First IO

##Challenge
Write a program that uses a single **synchronous** filesystem operation to read a file and print the number of newlines it contains to the console (stdout), similar to running `cat file | wc -l`.

The full path to the file to read will be provided as the first command-line argument.

##Hints
To perform a filesystem operation you are going to need the [`fs`](http://nodejs.org/api/fs.html) module from the Node core library. To load this kind of module, or any other "global" module, use the following incantation:

    var fs = require('fs')

Now you have the full `fs` module available in a variable named `fs`.

All synchronous (or blocking) filesystem methods in the `fs` module end with 'Sync'. To read a file, you'll need to use [`fs.readFileSync('/path/to/file')`](http://nodejs.org/api/fs.html#fs_fs_readfilesync_filename_options). This method will *return* a `Buffer` object containing the complete contents of the file.

###Documentation
- [fs.readFileSync('/path/to/file')](http://nodejs.org/api/fs.html#fs_fs_readfilesync_filename_options)
- [fs module](http://nodejs.org/api/fs.html#fs_file_system)
- [buffer](http://nodejs.org/api/buffer.html#buffer_class_buffer)

- `Buffer` objects are Node's way of efficiently representing arbitrary arrays of data, whether it be ascii, binary or some other format.
- `Buffer` objects can be converted to strings by simply calling the `toString()` method on them. e.g. `var str = buf.toString()`.

If you're looking for an easy way to count the number of newlines in a string, recall that a JavaScript `String` can be `.split()` into an array of substrings and that `\n`. Using this method you'll end up with an array that has one more element than the number of newlines.

    
@annotation:tour my_first_async_io
#4. My First Async IO
##Challenge
Write a program that uses a single **asynchronous** filesystem operation to read a file and print the number of newlines it contains to the console (stdout), similar to running `cat file | wc -l`.

The full path to the file to read will be provided as the first command-line argument.

##Hints
The solution to this problem is *almost* the same as the previous problem except you must now do it **the Node.js way**: asynchronous.

Instead of `fs.readFileSync()` you will want to use [`fs.readFile()`](http://nodejs.org/api/fs.html#fs_fs_readfile_filename_options_callback) and instead of using the return value of this method you need to collect the value from a callback function that you pass in as the second argument.

Remember that idiomatic Node.js callbacks normally have the signature:

  function (err, data) { ... }

so you can check if an error occurred by checking whether the first argument is truthy. If there is no error, you should have your `Buffer` object as the second argument. As with `readFileSync()`, you can supply `utf8` as the second argument and put the callback as the third argument and you will get a `String` instead of a `Buffer`.

###Documentation
- [fs module](http://nodejs.org/api/fs.html#fs_file_system)
- [fs.readFile()](http://nodejs.org/api/fs.html#fs_fs_readfile_filename_options_callback)


@annotation:tour filtered_ls
#5. Filtered ls (folder contents listing)

##Challenge
Create a program that prints a list of files in a given directory, filtered by the extension of the files. You will be provided a directory name as the first argument to your program (e.g. `/path/to/dir/`) and a file extension to filter by as the second
argument.

For example, if you get `txt` as the second argument then you will need to filter the list to only files that **end with .txt**. 

The list of files should be printed to the console, one file per line. You **must** use asynchronous I/O.

##Hints
The [`fs.readdir()`](http://nodejs.org/api/fs.html#fs_fs_readdir_path_callback) method takes a pathname as its first argument and a callback as its second. The callback signature is:

    function (err, list) { ... }

where `list` is an array of filename strings.

###Documentation
- [fs module](http://nodejs.org/api/fs.html#fs_file_system)
- [RegExp](https://developer.mozilla.org/en/docs/Web/JavaScript/Guide/Regular_Expressions)


@annotation:tour make_it_modular
#6. Make it modular

##Challenge
This problem is the same as the previous but introduces the concept of **modules**. You will need to create two files to solve this.

Create a program that prints a list of files in a given directory, filtered by the extension of the files. The first argument is the directory name and the second argument is the extension filter. Print the list of files to the console. You **must** use asynchronous I/O.

Your program must use a [*module*](http://nodejs.org/api/modules.html) to do most of the work. The module must *export* a single function that takes **three** arguments: the directory name, the filter string and a callback function.

The callback must be called with an error, and only an error, as the first argument if one is passed from your call to [`fs.readdir()`](http://nodejs.org/api/fs.html#fs_fs_readdir_path_callback). If there are no errors then the first argument to the callback must be null and the second must be your filtered list of files in an array.

In the case of an error bubbling up to your original program file, simply check for it and print an informative message to the console.

##Hints
Create a new module by creating a new file that just contains your directory reading and filtering function. To define a *single function export* you assign your function to the `module.exports` object, overwriting what is already there:

    module.exports = function (...) { ... }

Or you can use a named function and assign the name.

To use your new module in your original program file, use the `require()` call in the same way that you `require('fs')` to load the `fs` module. The only difference is that for local modules must be prefixed with `./`. So, if your file is named mymodule.js then: 

    var mymodule = require('./mymodule.js')

The `.js` is optional here and you will often see it omitted.

You now have the `module.exports` object in your module assigned to the `mymodule` variable. Since you are exporting a single function, `mymodule` is a function you can call!

Also keep in mind that it is idiomatic to check for errors and do early-returns within callback functions:

    foo(function (err, data) {
      if (err)
        return callback(err)
  
      ... // continue when no-error
    })

###Documentation
- [fs module](http://nodejs.org/api/fs.html#fs_file_system)
- [fs.readdir()](http://nodejs.org/api/fs.html#fs_fs_readdir_path_callback)
- [RegExp](https://developer.mozilla.org/en/docs/Web/JavaScript/Guide/Regular_Expressions)
- [module.exports](http://nodejs.org/api/modules.html#modules_module_exports)
- [Modules](http://nodejs.org/api/modules.html)
- [forEach](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)

@annotation:tour http_client
#7. An http client

##Challenge
Write a program that performs an HTTP GET request to a URL provided to you as the first command-line argument. Write the String contents of **each** "data" event from the response to a new line on the console (stdout).

You'll want to test it with 

- `node yourcode.js http://www.google.com/index.html`

or

- `learnyounode run yourcode.js http://www.google.com/index.html`

##Hints
For this exercise you will need to use the [http](http://nodejs.org/api/http.html#http_http) core module.

The [`http.get()`](http://nodejs.org/api/http.html#http_http_get_options_callback) method is a shortcut for simple GET requests, use it to simplify your solution. The first argument to `http.get()` can be the URL you want to GET, provide a callback as the second argument. 

Unlike other callback functions, this one has the signature:

    function (response) { ... }

Where the `response` object is a Node **Stream** object. You can treat Node Streams as objects that emit events, the three events that are of most interest are: "data", "error" and "end". You listen to an event like so:

    stream.on("data", function (data) { ... })

The "data" is emitted when a chunk of data is available and can be processed. The size of the chunk depends upon the underlying data source.

The `response` object / Stream that you get from `http.get()` also has a `setEncoding()` method. If you call this method with "utf8", the "data" events will emit Strings rather than the standard Node `Buffer` objects which you have to explicitly convert to Strings.

###Documentation
- [http.get](http://nodejs.org/api/http.html#http_http_get_options_callback)
- [http](http://nodejs.org/api/http.html#http_http)
- [stream](http://nodejs.org/api/stream.html#stream_stream)
- [stream.setEncoding](http://nodejs.org/api/stream.html#stream_readable_setencoding_encoding)
- [Stream events](http://nodejs.org/api/stream.html#stream_event_readable)


@annotation:tour http_collect
#8. Http Collect

##Challenge
Write a program that performs an HTTP GET request to a URL provided to you as the first command-line argument. Collect **all** data from the server (not just the first "data" event) and then write two lines to the console (stdout).

The first line you write should just be an integer representing the number of characters received from the server and the second line should contain the complete String of characters sent by the server.

##Hints
There are two approaches you can take to this problem: 

1. Collect data across multiple "data" events and append the results together prior to printing the output. Use the "end" event to determine when the stream is finished and you can write the output.
1. Use a third-party package to abstract the difficulties involved in collecting an entire stream of data. Two different packages provide a useful API for solving this problem (there are likely more!). [`bl`](https://npmjs.org/package/bl) (Buffer List) and [`concat-stream`](https://npmjs.org/package/concat-stream); take your pick!

    - `http://npm.im/bl`
    - `http://npm.im/concat-stream`

To install a Node package, use the Node Package Manager `npm`. Simply type:

    npm install bl

And it will download and install the latest version of the package into a subdirectory named `node_modules`. Any package in this
subdirectory under your main program file can be loaded with the `require` syntax without being prefixed by './':

    var bl = require('bl')

Node will first look in the core modules and then in the `node_modules` directory where the package is located.

Both `bl` and `concat-stream` can have a stream *piped* in to them and they will collect the data for you. Once the stream has ended, a callback will be fired with the data:

    response.pipe(bl(function (err, data) { ... }))

Note that you will probably need to `data.toString()` to convert from a Buffer.

###Documentation
- [stream.pipe](http://nodejs.org/api/stream.html#stream_readable_pipe_destination_options)
- [bl](https://npmjs.org/package/bl)
- [concat-stream](https://npmjs.org/package/concat-stream)


@annotation:tour juggling_async
#9. Juggling Async
##Challenge
This problem is the same as the previous problem (HTTP COLLECT) in that you need to use [`http.get()`](http://nodejs.org/api/http.html#http_http_get_options_callback). However, this time you will be provided with **three** URLs as the first three command-line arguments.

You must collect the complete content provided to you by each of the URLs and print it to the console (stdout). You don't need to print out the length, just the data as a String; one line per URL. The catch is that you **must** print them out in the same order as the URLs are provided to you as command-line arguments.

##Hints
Don't expect these three servers to play nicely! They are not going to give you complete responses in the order you hope, so you can't naively just print the output as you get it because they will be out of order.

You will need to queue the results and keep track of how many of the URLs have returned their entire contents. Only once you have them all, you can print the data to the console.

Counting callbacks is one of the fundamental ways of managing async in Node. Rather than doing it yourself, you may find it more convenient to rely on a third-party library such as [`http://npm.im/async`](https://npmjs.org/package/async) or [`http://npm.im/after`](https://npmjs.org/package/after).

But for this exercise, try and do it without any external helper library!


@annotation:tour time_server
#10. Time Server
##Challenge
Write a **TCP time server**!

Your server should listen to TCP connections on **port 8000**. For each connection you must write the current date & time in the format:

    YYYY-MM-DD hh:mm

followed by a **newline** character. Month, day, hour and minute must be *zero-filled* to 2 integers. For example:

    2013-07-06 07:42

##Hints
For this exercise we'll be creating a raw TCP server. There's no HTTP involved here so we need to use the [net](http://nodejs.org/api/net.html#net_net) module from Node core which has all the basic networking functions.

The [net](http://nodejs.org/api/net.html#net_net) module has a method named [net.createServer()](http://nodejs.org/api/net.html#net_net_createserver_options_connectionlistener) that takes a callback function. Unlike most callbacks in Node, the callback used by [net.createServer()](http://nodejs.org/api/net.html#net_net_createserver_options_connectionlistener) is called more than once. Every connection received by your server triggers another call to the callback. The callback function has the signature:

    function (socket) { ... }

`net.createServer()` also returns an instance of your `server`. You must call `server.listen(portNumber)` to start listening on a
particular port.

A typical Node TCP server looks like this:

    var net = require('net')
    var server = net.createServer(function (socket) {
      // socket handling logic
    })
    server.listen(8000)

The [socket](http://nodejs.org/api/net.html#net_class_net_socket) object contains a lot of meta-data regarding the connection, but it is also a Node duplex Stream, in that it can be both read from, and written to. For this exercise we only need to write data and then close the socket.

Use [socket.write(data)](http://nodejs.org/api/net.html#net_socket_write_data_encoding_callback) to write data to the socket and `socket.end()` to close the socket. Alternatively, the `.end()` method
also takes a data object so you can simplify to just:

- [socket.end(data)](http://nodejs.org/api/net.html#net_event_end)

To create the date, you'll need to create a custom format from a [new Date()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) object. The methods that will be useful are:

    date.getFullYear()
    date.getMonth()     (starts at 0)
    date.getDate()      (returns the day of month)
    date.getHours()
    date.getMinutes()

Or, if you want to be adventurous, use the [moment](https://npmjs.org/package/moment) package from npm.

###Documentation

- [net](http://nodejs.org/api/net.html#net_net)
- [net.createServer()](http://nodejs.org/api/net.html#net_net_createserver_options_connectionlistener)
- [socket](http://nodejs.org/api/net.html#net_class_net_socket)
- [socket.write(data)](http://nodejs.org/api/net.html#net_socket_write_data_encoding_callback)
- [socket.end(data)](http://nodejs.org/api/net.html#net_event_end)
- [moment](https://npmjs.org/package/moment)
- [Date object]((https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date))


@annotation:tour http_file_server
#11. HTTP File Server
##Challenge
Write an HTTP **server** that serves the same text file for each request it receives.

You will be provided with the location of the file to serve as the first command-line argument. You **must** use the [fs.createReadStream()](http://nodejs.org/api/fs.html#fs_fs_createreadstream_path_options) method to stream the file contents to the response.

Your server should listen on **port 8000**.

##Hints
Because we need to create an HTTP server for this exercise rather than a generic TCP server, we should use the [http](http://nodejs.org/api/http.html#http_http) module from Node core. 

Like the `net` module, `http` also has a method named [http.createServer()](http://nodejs.org/api/http.html#http_http_createserver_requestlistener) but this one creates a server that can talk
HTTP.

[http.createServer()](http://nodejs.org/api/http.html#http_http_createserver_requestlistener) takes a callback that is called once for each connection received by your server. The callback function has the signature:

    function (request, response) { ... }

Where the two arguments are objects representing the HTTP request and the corresponding response for this request. `request` is used to fetch properties, such as the header and query-string from the request while `response` is for sending data to the client, both headers and body.

Both `request` and `response` are also Node streams! Which means that you can use the streaming abstractions to send and receive data if they suit your use-case.

`http.createServer()` also returns an instance of your `server`. You must call `server.listen(portNumber)` to start listening on a particular port.

A typical Node HTTP server looks like this:

    var http = require('http')
    var server = http.createServer(function (req, res) {
      // request handling logic...
    })
    server.listen(8000)

The `fs` core module also has some streaming APIs for files. You will need to use the `fs.createReadStream()` method to create a stream representing the file you are given as a command-line argument. The method returns a stream object which you can use [src.pipe(dst)](http://nodejs.org/api/stream.html#stream_readable_pipe_destination_options) to pipe the data from the `src` stream to the `dst` stream. In this way you can connect a filesystem stream with an HTTP response stream.

###Documentation
- [http](http://nodejs.org/api/http.html#http_http)
- [http.createServer()](http://nodejs.org/api/http.html#http_http_createserver_requestlistener)
- [fs.createReadStream()](http://nodejs.org/api/fs.html#fs_fs_createreadstream_path_options)


@annotation:tour http_uppercaserer
#12. Upper Caserer
##Challenge
Write an HTTP **server** that receives only POST requests and converts incoming POST body characters to upper-case and returns it to the client.

Your server should listen on **port 8000**.

##Hints
While you're not restricted to using the streaming capabilities of the `request` and `response` objects, it will be much easier if you do.

There are a number of different packages in npm that you can use to *"transform"* stream data as it's passing through. For this exercise the [through2-map](https://npmjs.org/package/through2-map) package offers the simplest API.

[through2-map](https://npmjs.org/package/through2-map)  allows you to create a *transform stream* using only a single function that takes a chunk of data and returns a chunk of data. It's designed to work much like `Array#map()` but for streams:

    var map = require('through2-map')
    inStream.pipe(map(function (chunk) {
      return chunk.toString().split('').reverse().join('')
    })).pipe(outStream)

In the above example, the incoming data from `inStream` is converted to a String (if it isn't already), the characters are reversed and the result is [piped](http://nodejs.org/api/stream.html#stream_readable_pipe_destination_options) through to `outStream`. So we've made a chunk character reverser! Remember though that the chunk size is determined up-stream and you have little control over it for incoming data.

To install [through2-map](https://npmjs.org/package/through2-map)  type:

    npm install through2-map

###Documentation
- [through2-map](https://npmjs.org/package/through2-map)
- [src.pipe(dst)](http://nodejs.org/api/stream.html#stream_readable_pipe_destination_options)


@annotation:tour http_json_api_server
#13. HTTP Json Api Server
##Challenge
Write an HTTP **server** that serves JSON data when it receives a GET request to the path `/api/parsetime`. Expect the request to contain a query string with a key `iso` and an ISO-format time as the value. 

For example:

    /api/parsetime?iso=2013-08-10T12:10:15.474Z

The JSON response should contain only 'hour', 'minute' and 'second' properties. For example:

    {
      "hour": 14,
      "minute": 23,
      "second": 15
    }

Add second endpoint for the path `/api/unixtime` which accepts the same query string but returns UNIX epoch time under the property
'unixtime'. 

For example:

    { "unixtime": 1376136615474 }

Your server should listen on **port 8000**.

##Hints
The `request` object from an HTTP server has a [url](http://nodejs.org/api/url.html) property that you will need to use to *"route"* your requests for the two endpoints. 

You can parse the URL and query string using the Node core [url](http://nodejs.org/api/url.html) module. [url.parse(request.url, true)](http://nodejs.org/api/url.html#url_url_parse_urlstr_parsequerystring_slashesdenotehost) will parse content of request.url and provide you with an object with helpful properties. For example, on the command prompt, type:

    node -pe "require('url').parse('/test?q=1', true)"

You should also be a good web citizen and set the Content-Type properly:

    res.writeHead(200, { 'Content-Type': 'application/json' })
    
The JavaScript [Date](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) object can print dates in ISO format, e.g. `new Date().toISOString()`. It can also parse this format if you pass the string into the `Date` constructor. `Date#getTime()` will also come in handy.

