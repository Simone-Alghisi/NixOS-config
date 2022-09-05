<!-- omit in toc -->
# Python template with Mach-Nix

A simple python template using [mach-nix](https://github.com/DavHau/mach-nix).

<!-- omit in toc -->
## TOC

- [Change Mach-Nix version](#change-mach-nix-version)
- [Change python version](#change-python-version)
- [Build a package from a repository](#build-a-package-from-a-repository)
  - [on GitHub](#on-github)
  - [on your local machine](#on-your-local-machine)
- [Build from a tarball](#build-from-a-tarball)
- [Using python packages provided by Nix](#using-python-packages-provided-by-nix)
  - [Override packages](#override-packages)
- [Execute commands or set variables upon entering an environment](#execute-commands-or-set-variables-upon-entering-an-environment)
- [Troubleshooting](#troubleshooting)
  - [Cache Issues](#cache-issues)
  - [Qt5 on a Gnome environment](#qt5-on-a-gnome-environment)
  - [Pip cannot find a certain package version](#pip-cannot-find-a-certain-package-version)
  - [System dependent package/library](#system-dependent-packagelibrary)
  - [Others](#others)

## Change Mach-Nix version
To update or change mach-nix version to a previous release, simply change its tag in the `url` field of `mach-nix` in the flake inputs.

```nix
{
  mach-nix = {
    url = "mach-nix/3.3.0";
    ...
  };
}
```

## Change python version
To change the python version, simply change `python` value in the flake outputs.

```nix
{
  python-build = mach.mkPython {
    python = "python39";
    ...
  };
}
```

## Build a package from a repository
### on GitHub
It is possible to build a package starting from a github repository by letting mach-nix automatically detect the right requirements through `buildPythonPackage`.


```nix
{
  poke-env = mach-nix.lib."${system}".buildPythonPackage {
    pname = "poke-env";
    version = "0.4.21";
    src = pkgs.fetchFromGitHub {
      owner = "Simone-Alghisi";
      repo = "poke-env";
      rev = "1a2212339d7a05af9b8fdda50044aa3d41fc9179";
      hash = "sha256-g5+8Ch02bm6tzhsRKY0s3evG3WuUIDu7iwbzgE0QE1Q=";
    };
  };
}
```

Then, add this to `packagesExtra`, just like it follows:

```nix
{
  python-build = mach-nix.lib."${system}".mkPython {
    packagesExtra = [
      poke-env
      ...
    ];
    ...
  };
}
```

### on your local machine
Instead, to build a python package from a local repository it is simply necessary to add its path to `packagesExtra` list:

```nix
{
  python-build = mach-nix.lib."${system}".mkPython {
    packagesExtra = [
      ./path/to/repo
      ...
    ];
    ...
  };
}
```

## Build from a tarball
To build from a tarball I suggest using the `builtins.fetchTarball` command because it is possible to specify the `sha256` field, necessary for flakes pure evaluation.

Differently from building directly from the repository, such command can be directly put inside of `extraPackages`:

```nix
{
  python-build = mach-nix.lib."${system}".mkPython {
    packagesExtra = [
      (builtins.fetchTarball {
        url = "https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.1.0/en_core_web_sm-3.1.0.tar.gz";
        sha256 = "0iqhcmwvl2jna6m2zk6g9j1j7six6wf7kzd2xlxgypn0s8649dvb";
      })
      ...
    ];
    ...
  };
}
```

## Using python packages provided by Nix
It is possible to add additional packages provided by Nix to the environment by adding them in the `buildInputs` list:

```nix
{
  devShell = pkgs.mkShell {
    buildInputs = [
      # Additional packages
      pkgs.python39Packages.matplotlib
      ...
    ];
  };
}
```

### Override packages
It is also possible to override Nix provided packages to make them compatible with your system or current configuration. Depending on the override, several functions are available. The simplest override is something like it follows:

```nix
{
  Qt-matplotlib = pkgs.python39Packages.matplotlib.override {
    enableQt = false;
    enableTk = true;
  }; 
}
```

Then, such packages can be added to `buildInputs`:

```nix
{
  devShell = pkgs.mkShell {
    buildInputs = [
      # Additional packages
      Qt-matplotlib
      ...
    ];
  };
}
```

## Execute commands or set variables upon entering an environment
The easiest way to do that is append the list of commands or exports to

- the `shellHook` variable;
- the `.envrc` file.

## Troubleshooting
### Cache Issues
I think that this is the most nerve wreaking issue due to the fact it is not an actual error, but things do not work as they should.

For example, if
- mach-nix detects older requirements;
- a package does not get updated;
- ...

It may be a problem of cache. My suggestion is to:

1. remove the package from the flake;
2. re-build the environment (should be performed automatically);
3. run `nix-collect-garbage -d` to remove unlinked packages;
4. try adding back the package, change the hash, re-build the environment.

### Qt5 on a Gnome environment
In order to setup Qt5, for example as matplotlib backend, it is necessary to override the package and also properly setup the wrapper.

```nix
let
  Qt-matplotlib = pkgs.python39Packages.matplotlib.override {
    enableQt = false;
    enableTk = true; 
  };
in
{
  devShell = pkgs.mkShell {
    buildInputs = [
      Qt-matplotlib
      pkgs.libsForQt5.qt5.wrapQtAppsHook
      pkgs.python39Packages.pyqt5
    ];
  };
}
```

Moreover, it is necessary to edit the `.envrc` to add

```shell
export QT_QPA_PLATFORM=wayland-egl
```

### Pip cannot find a certain package version
The fastest workaround is to clone the repository to your local folder, change the requirements file accordingly to pypi-debs-db. My suggestion is to change a requirements as it follows:

```python
bs4==0.0.1
requests==2.*
texttable==1.*
tqdm==4.*
```

### System dependent package/library
Hope that it is not a dependency of a python package and that it is available as a Nix package.

### Others
I wish you the best of luck, and suggests the following:

- [mach-nix example file](https://github.com/DavHau/mach-nix/blob/master/examples.md);
- [take a deep breath](https://www.google.com/search?client=firefox-b-d&q=cats);
- the *[works-(almost)-every-time](https://www.google.com)* method.