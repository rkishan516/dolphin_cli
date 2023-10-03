
### Dolphin CLI


The official CLI (Command Line Interface) dev tools for working with the Dolphin framework. Dolphin is a framework built in Flutter for production teams. It is built for maintenance, readability, and scaleability. 
  
[<p align="center"><img src="https://raw.githubusercontent.com/rkishan516/dolphin_cli/main/doc/assets/logo.svg" align="center" width="200" /></p>](https://github.com/rkishan516/dolphin_cli)

## Quick Start 🚀

### Installing 🧑‍💻

```sh
dart pub global activate dolphin_cli
```

Or install a [specific version](https://pub.dev/packages/dolphin_cli/versions) using:

```sh
dart pub global activate dolphin_cli <version>
```

### Commands ✨

### `dolphin create`

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
dolphin create app my_app --descritption "My new Flutter app" --org "com.custom.org"

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

---

### `dolphin delete`

Easily delete your dolphin project components using the `dolphin delete` command.

```sh
Provides access to the different deletion tools we have for dolphin.

Usage: dolphin delete <subcommand> <deletion-component-name> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  dialog    Deletes a dialog with all associated files and makes necessary code changes for deleting a dialog.
  service   Deletes a service with all associated files and makes necessary code changes for deleting a service.
  view      Deletes a view with all associated files and makes necessary code changes for deleting a view.

Run "dolphin help" to see global options.
```

### `dolphin generate`

Easily generate code for your dolphin project components using the `dolphin generate` command.

```sh
Generates the code for the dolphin application if any changes were made.

Usage: dolphin generate [arguments]
-h, --help                               Print this usage information.
-d, --[no-]delete-conflicting-outputs    Assume conflicting outputs in the users package are from previous builds, and skip the user prompt that would usually be provided.
                                         (defaults to on)
-w, --[no-]watch                         Generates the code for the Dolphin application, watching the file system for updates and rebuilding as appropriate.

Run "dolphin help" to see global options.
```

### `dolphin update`

```sh
Updates dolphin_cli to latest version.

Usage: dolphin update [arguments]
-h, --help                               Print this usage information.

Run "dolphin help" to see global options.
```