# Implementation Deployment Interface

Example Implementation:

* [Gruntfile.js](https://github.com/OpenCHS/ihmp/blob/master/Gruntfile.js)
* [Makefile](https://github.com/OpenCHS/ihmp/blob/master/Makefile)

Both are needed. Makefile provided by openchs-idi is a thin wrapper to provide quick bash auto complete.

To Install the sdk in an Implementation:
```
yarn add github:openchs/openchs-idi#sdkcommitID             -- sdkcommitID = latest commit in master branch
yarn add github:openchs/rules-config#rulescommitID          -- rulescommitID = latest commit in build branch
```
