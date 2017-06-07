## curly.el
*Straight way to work with current file locations.*

---
[![License GPLv3](https://img.shields.io/badge/license-GPL_v3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.html)
[![Build Status](https://travis-ci.org/veelenga/curly.el.svg?branch=master)](https://travis-ci.org/veelenga/curly.el)

<img src="https://github.com/veelenga/bin/blob/master/curly.el/logo.png">

Simple plugin that can format and copy file location based on the available locators.

### Usage

Run interactive function `curly-copy-loc` to create and copy file location you need.

Available locators:

 * `@` - absolute path to the current project
 * `#` - absolute path to the current directory
 * `%` - absolute path to the current file

 * `p` - project's root directory name
 * `d` - relative path to the current directory
 * `f` - relative path to the current file

 * `l` - line number
 * `c` - column number
 * `t` - point number

For example, if you need to copy a relative path to the current file with a line
number, use `(curly-copy-loc "f:l")`

### Function Documentation


#### `(curly-expand INPUT)`

Expand INPUT using file locators.

#### `(curly-copy-loc INPUT)`

Format and copy file location based on user INPUT.

-----
<div style="padding-top:15px;color: #d0d0d0;">
Markdown README file generated by
<a href="https://github.com/mgalgs/make-readme-markdown">make-readme-markdown.el</a>
</div>
