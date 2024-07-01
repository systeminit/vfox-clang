# vfox-clang

[Clang](https://clang.llvm.org/) plugin for [vfox](https://vfox.lhan.me).

## Install

After installing [vfox](https://github.com/version-fox/vfox), install the plugin by running:

``` shell
vfox add clang
```

Next, search and select the version to install. By default, vfox keeps cache for available versions, use the `--no-cache` flag to delete the cache file.

``` shell
vfox search clang
vfox search clang --no-cache && vfox search clang
```

Install the latest stable version with `latest` tag.

``` shell
vfox install clang@latest
```

Some environment variables are served as following:

| Environment variables | Default value         | Description         |
| :-------------------- | :-------------------- | :------------------ |
| Conda_Forge           | `conda-forge`         | conda-forge channel |
| GITHUB_URL            | `https://github.com/` | GitHub mirror URL   |

Usage:

``` shell
export Conda_Forge=https://prefix.dev/conda-forge
export GITHUB_URL=https://mirror.ghproxy.com/https://github.com/
```