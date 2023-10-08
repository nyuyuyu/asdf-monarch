<div align="center">

# asdf-monarch [![Build](https://github.com/nyuyuyu/asdf-monarch/actions/workflows/build.yml/badge.svg)](https://github.com/nyuyuyu/asdf-monarch/actions/workflows/build.yml) [![Lint](https://github.com/nyuyuyu/asdf-monarch/actions/workflows/lint.yml/badge.svg)](https://github.com/nyuyuyu/asdf-monarch/actions/workflows/lint.yml)

[monarch](https://monarchapp.io/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `xz`: only required for Linux.

# Install

Plugin:

```shell
asdf plugin add monarch
# or
asdf plugin add monarch https://github.com/nyuyuyu/asdf-monarch.git
```

monarch:

```shell
# Show all installable versions
asdf list-all monarch

# Install specific version
asdf install monarch latest

# Set a version globally (on your ~/.tool-versions file)
asdf global monarch latest

# Now monarch commands are available
monarch --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/nyuyuyu/asdf-monarch/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [nyuyuyu](https://github.com/nyuyuyu/)
