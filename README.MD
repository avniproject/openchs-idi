# Implementation Deployment Interface

Example Implementation:

* [Gruntfile.js](https://github.com/OpenCHS/ihmp/blob/master/Gruntfile.js)
* [Makefile](https://github.com/OpenCHS/ihmp/blob/master/Makefile)

Both are needed. Makefile provided by openchs-idi is a thin wrapper to provide quick bash auto complete.

To upgrade `rules-config` do the following in sdk and push it to master:
```
yarn add github:openchs/rules-config#build
```
then in the implementation
```
yarn add github:openchs/openchs-idi#master
```

Caution:
* Implementations should not rely on specific version of `rules-config` package.
* Implementations should always take rule-config installed by openchs-idi
