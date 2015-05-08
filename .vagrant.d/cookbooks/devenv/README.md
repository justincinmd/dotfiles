# devenv-cookbook

Installs packages, dotfiles, and a shell.

## Supported Platforms

Ubuntu

## Validating Changes

To lint, run:

    foodcritic .

To run automated tests:

    bundle exec kitchen test

## Usage

### devenv::default

Include `devenv` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[devenv]"
  ]
}
```

And configure:

```json
{
  "devenv": {
    "packages": ['git', 'silversearcher-ag', 'vim-nox', 'ack-grep', 'ruby1.9.1-dev', 'htop', 'tree'],
    "users": {
      "vagrant": {
        "repo": 'git@github.com:jcnnghm/dotfiles.git',
        "shell": 'zsh'
      }
    }
  }
}
```

## License and Authors

Author:: Justin Cunningham
