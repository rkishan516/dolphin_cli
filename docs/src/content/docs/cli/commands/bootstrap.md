---
title: Bootstrap
description: A guide to bootstrap with dolphin.
---

Convert flutter basic app into a dolphin project in seconds based on the provided template. Each template has a corresponding sub-command (e.g.,`dolphin bootstrap` will bootstrap a Dolphin starter app).

```sh
Convert basic flutter app to Dolphin application

Usage: dolphin bootstrap [arguments]
-h, --help                Print this usage information.
-t, --template            Selects the type of starter template to use when creating a new app. One oriented for mobile first or web first.
                          [mobile (default)]
-c, --config-path         Sets the file path for the custom config.
-l, --line-length=<80>    When a number is provided, it will be used as the line length for formatting code.
    --backend             Selects the type of backend to create with app.
                          [firebase, supabase, appwrite]

Run "dolphin help" to see global options.
```


#### Usage

```sh
# Bootstrap a new Dolphin app
dolphin bootstrap

# Bootstrap a new Dolphin app with backend framework
dolphin bootstrap --backend=firebase

```