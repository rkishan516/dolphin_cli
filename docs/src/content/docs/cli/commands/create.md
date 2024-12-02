---
title: Create
description: A guide to use dolphin create.
---

Create a dolphin project and components in seconds based on the provided template. Each template has a corresponding sub-command (e.g.,`dolphin create app dolphin_app` will generate a Dolphin starter app).

```sh
Provides access to the different creation tools we have for dolphin.

Usage: dolphin create <subcommand> <creation-component-name> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  app            Creates a Dolphin application with all the basics setup.
  bottom_sheet   Creates a bottom sheet with all associated files and makes necessary code changes for adding a bottom sheet.
  dialog         Creates a dialog with all associated files and makes necessary code changes for adding a dialog.
  service        Creates a service with all associated files and makes necessary code changes to include that service.
  view           Creates a view with all associated files and makes necessary code changes for adding a view.
  widget         Creates a widget with their model file.

Run "dolphin help" to see global options.
```

#### Usage

```sh
# Create a new Dolphin app named my_app
dolphin create app my_app

# Create a new Dolphin app named my_app with a custom org
dolphin create app my_app --descritption "My new Flutter app" --org "com.custom.org" --backend=firebase

# Create a new view named my_view (In common features)
dolphin create view my_view

# Create a new view named my_view in feature named my_feature
dolphin create view my_view --feature=my_feature

# Create a new widget named my_widget (In common features)
dolphin create widget my_widget

# Create a new widget named my_widget in feature named my_feature
dolphin create widget my_widget --feature=my_feature

# Create a new service named my_service (In common features)
dolphin create service my_service

# Create a new service named my_service in feature named my_feature
dolphin create service my_service --feature=my_feature

# Create a new bottom sheet named my_bottom_sheet (In common features)
dolphin create bottom_sheet my_bottom_sheet

# Create a new bottom sheet named my_bottom_sheet in feature named my_feature
dolphin create bottom_sheet my_bottom_sheet --feature=my_feature

# Create a new dialog named my_dialog (In common features)
dolphin create dialog my_dialog

# Create a new dialog named my_dialog in feature named my_feature
dolphin create dialog my_dialog --feature=my_feature


```