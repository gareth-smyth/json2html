# json2html
Ruby gem allowing json to be converted very simply to html

## Usage
Not configuration available as yet - simply pass in a json string and receive html.

## Currently Handles
Single json number mapping `{"name":value}` to `<div id='name'>value</div>`
Single json string mapping `{"name":"value"}` to `<div id='name'>value</div>`
Single json null mapping `{"name":"value"}` to `<div id='name'></div>`

## TODO
Boolean => div?  Yes/No?  Checkbox?
Array   => ul?
Object  => ul?
