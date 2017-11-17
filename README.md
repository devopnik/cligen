# CliGen

__CommandLine Generator__

This repo is meant to be forked to be a scaffold for creating cli tools via the [Thor gem](http://whatisthor.com/) and its task running model. This repo/app is somewhat of a framework that allows practical namespacing for task runners.

### Templates and usage:

```
generate new role

generate new taskrunner
```

You will be prompted for input about how you want to structure your commands, primarily the namespace, roles, and any descriptors for them

#### Taskrunner
A simple task runner to invoke tasks without the need for namespacing

#### Role
Namespaced taskrunners, meant for semantic categorization of your tasks, allows for logically separating objects upon which tasks run.

Using a compare namespace as an example, there can be several roles which comparison tasks can be run, i.e. `bin/compare client files` uses an `files` task to make comparisons between client files, where `bin/compare file items` uses the `items` task to make comparisons between files. This is meant to help make the invoking of a command more like natural language, as an imperative statement that elicits a response based on the verb object in context to the preposition that the is the task being invoked. This might not be the best way to organize, but it's a start ¯\\\_(ツ)_/¯


### Namespace File Structure


The file structure for a namespaced task runner is broken down as such:

```
bin/namespace
lib/commands/namespace/
                      helpers/
                      rolename/
                              tasks/
```

Conversely, a taskrunner is structure like so:

```
bin/taskrunner
lib/commands/taskrunner/
                      helpers/
                      tasks/
```

_Note: The executables and referenced lib structure require they have the same name._

Directory breakdown (from above)

`helpers/` - add any helping classes or code that makes sense in scope of the `namespace/tasks/` that will be invoked

`tasks/` - Write your Thor tasks within this file

Reading through the [Thor documentation](https://github.com/erikhuda/thor/wiki) is highly recommended. It is suggested that you use the helper classes to do most of the heavy lifting, and keep the task methods for interface logic.

**_NB: Namespaces will not need to be completed so long as there is no regex ambiguity, so roles namespaced as xyz can be invoked as xy so long as there's not another role that starts with xy_**

_i.e._

`bin/namespace xy task`

_is the same as_

`bin/namespace xyz task`
