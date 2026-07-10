# dotfiles

## セットアップ
[Homebrew 公式のインストール手順](https://docs.brew.sh/Installation)に従い、Homebrew をインストールする。

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

インストール後、インストーラの案内に従って Homebrew をシェルの環境に追加し、動作を確認する。

```sh
brew --version
```

Homebrew で chezmoi をインストールする。

```sh
brew install chezmoi
chezmoi --version
```

このリポジトリでは `chezmoi/` を chezmoi source directory として使う。適用前に差分を確認する。

```sh
chezmoi --source ./chezmoi diff
```

問題なければ適用する。

```sh
chezmoi --source ./chezmoi apply
```

chezmoi の適用後、mise で管理する開発ツールをインストールする。

```sh
mise install -C ~
```

## ツール管理
Homebrew は macOS/Linuxbrew のパッケージ管理に使う。GUI アプリ、システム寄りの CLI、mise 本体など、OS 側に配置するツールを扱う。

mise は開発用ツールのバージョン管理に使う。言語ランタイム、Language Server、コーディングエージェント、プロジェクト横断で使う開発補助ツールを扱う。
