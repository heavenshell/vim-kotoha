vim-kotoha
==========

Vim plugin for [kotoha](https://github.com/konifar/kotoha)

vim-kotoha is useful Vim plugin that help you to quote a good phrase!

Usage
-----

##Search by word

You can quote a phrase by typing search word after /k.

```viml
:set omnifunc=kotoha#complete
:KotohaQuery -query=仕事
```

##Search by tag

You can quote a phrase by typing search word after /k.

```viml
:set omnifunc=kotoha#complete
:KotohaTag -query=shiro
```

Requirement
-----------
This plugin need [webapi-vim](https://github.com/mattn/webapi-vim).
