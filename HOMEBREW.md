# Homebrew Distribution

## Quick Install (after tap is set up)

```bash
brew tap marcelxv/gut
brew install gut
```

## Setting Up the Tap

Homebrew formulas live in a separate "tap" repository. Here's how to set it up:

### 1. Create the tap repo

Create a new GitHub repo named `homebrew-gut` under your organization:

```
https://github.com/marcelxv/homebrew-gut
```

### 2. Add the formula

Copy `Formula/gut.rb` to the tap repo:

```
homebrew-gut/
└── Formula/
    └── gut.rb
```

### 3. Create a release

Tag a release in the main gut-cli repo:

```bash
git tag -a v0.1.0 -m "Initial release"
git push origin v0.1.0
```

### 4. Update the formula SHA

After creating the release, get the SHA256 of the tarball:

```bash
curl -sL https://github.com/marcelxv/gut-cli/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
```

Update the `sha256` in `Formula/gut.rb` with this value.

### 5. Test locally

```bash
brew install --build-from-source ./Formula/gut.rb
```

## Alternative: Install from HEAD

Users can install directly from the main branch without a release:

```bash
brew install --HEAD marcelxv/gut/gut
```

## Formula Location

The formula is included in this repo at `Formula/gut.rb` for reference. The canonical version should live in the `homebrew-gut` tap repo.

## Updating

When releasing a new version:

1. Tag the release: `git tag -a vX.Y.Z -m "Release X.Y.Z"`
2. Push the tag: `git push origin vX.Y.Z`
3. Get new SHA: `curl -sL <tarball-url> | shasum -a 256`
4. Update formula in tap repo with new version and SHA
5. Users run: `brew upgrade gut`
