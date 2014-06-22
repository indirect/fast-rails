# fast-rails

This Rails app boots quickly by loading neither Bundler or Rubygems.

To benchmark with Bundler and Rubygems:

```bash
$ time ruby -rbundler/setup bin/rails runner '0'
```

To benchmark without Bundler, but with Rubygems:

```bash
$ time ruby bin/rails runner '0'
```

To benchmark without Bundler or Rubygems:

```bash
$ time bin/rails runner '0'
```

In my testing, the times are 770ms, 730ms, and 650ms, respectively.
