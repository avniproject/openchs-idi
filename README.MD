# Implementation Deployment Interface

Example Implementation:

* [Gruntfile.js](https://github.com/OpenCHS/ihmp/blob/master/Gruntfile.js)
* [Makefile](https://github.com/OpenCHS/ihmp/blob/master/Makefile)

Both are needed. Makefile provided by openchs-idi is a thin wrapper to provide quick bash auto complete.

Caution:
* Implementations should not rely on specific version of `rules-config` package.
* Implementations should always take rule-config installed by openchs-idi
