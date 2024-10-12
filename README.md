<div align="center">

# asdf-android-sdk [![Build](https://github.com/tommyo/asdf-android-sdk/actions/workflows/build.yml/badge.svg)](https://github.com/tommyo/asdf-android-sdk/actions/workflows/build.yml) [![Lint](https://github.com/tommyo/asdf-android-sdk/actions/workflows/lint.yml/badge.svg)](https://github.com/tommyo/asdf-android-sdk/actions/workflows/lint.yml)

[android-sdk](https://developer.android.com/tools/sdkmanager) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

## Contents

- [asdf-android-sdk  ](#asdf-android-sdk--)
  - [Contents](#contents)
  - [Dependencies](#dependencies)
  - [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

## Install

Plugin:

```shell
asdf plugin add android-sdk
# or
asdf plugin add android-sdk https://github.com/tommyo/asdf-android-sdk.git
```

android-sdk:

```shell
# Show all installable versions
asdf list-all android-sdk

# Install specific version
asdf install android-sdk latest

# Set a version globally (on your ~/.tool-versions file)
asdf global android-sdk latest

# Now android-sdk commands are available
sdkmanager --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/tommyo/asdf-android-sdk/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Tom O'Reilly](https://github.com/tommyo/)
