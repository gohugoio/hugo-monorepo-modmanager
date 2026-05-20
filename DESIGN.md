NPM is a convenient tool; it's widely used and hosts like Netlify etc. auto-installs dependencies on builds, there's GitHub's @dependabot that provides automatic updates and security alerts. But its popularity also gains the increasing attention of attackers.

In [Hugo](https://gohugo.io/) you can get very far and never need NPM. Even JS packages from NPM can be downloaded and wrapped as a [Hugo Module](https://gohugo.io/hugo-modules/use-modules/). But the current semin-manual approach is a little cumbersome, and we e.g. lose out on the @dependabot alerts.

This outlines a new CLI tool that creates or updates a set of NPM depdendencies as Hugo Modules.

* We start out with a list of `dependencies` (for this purpose we only read `dependencies` and not `devDependencies`). This would enable `@dependabot` support for versions.
* We only support specific versions, e.g. `1.0.4` and not `~1.0.4`.

So, for all `dependencies` in `package.json`, extract the version and:

1. Use https://github.com/bep/fetch-npm-package (or possibly pull that code into this repo) into a folder with name matching the package.
2. Run `hugo mod init` inside that folder if no `go.mod` exists.
3. Create or update `hugo.toml` with some basic mounts.

There's a @fetchtest.sh script that writes some test dependencies to @testout1.

The current assumption is that

- The management, e.g. the location of the `main.go` program that updates lives in this mono repo.
- Each package maps to a Hugo Module (with a `go.mod` and a minimal `hugo.toml` with a src/target mount)
- We would probably have to support multi-module repos (as in GitHub repositories with multiple modules in sub folders).

We need figure out if we need config file and what that would look like. This depends on how much information we can deduce from the `package.json` files.

Let's update this document with the findings. And let's say that we:

* Read the package.json in this folder.
* Writes all output to folders in @testout2 (in .gitignore) (one folder per package for now)
* Follow the steps above to make a proper Hugo Module out of each.
* The mount `src` would be the relevant ESM module to import in a given package.
* The mount `target` would `assets/<esm-import-target>`. 
