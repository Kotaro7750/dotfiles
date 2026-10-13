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

chezmoi の設定ファイルを標準パスに配置する。コピー後の設定は利用環境に合わせて編集し、`data.profile` を `work` または `personal` に設定する。未設定時は `personal` を使う。

```sh
mkdir -p ~/.config/chezmoi
cp ./chezmoi.example.yaml ~/.config/chezmoi/chezmoi.yaml
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

Homebrew のインストール対象は `chezmoi/dot_Brewfile.tmpl` で宣言し、プロファイルと OS に応じて `~/.Brewfile` を生成する。

`chezmoi apply` は Brewfile を配置した後、内容が変わったときに `brew bundle install --no-upgrade` を実行する。既存パッケージの更新や一覧外パッケージの削除は自動では行わない。

プロファイルを切り替えるには、ローカル設定の `data.profile` を変更し、差分確認後に適用する。

```sh
chezmoi edit-config
chezmoi --source ./chezmoi diff
chezmoi --source ./chezmoi apply
```

一覧外のパッケージを削除したい場合は、まず削除候補を確認する。手動で導入した一覧外のパッケージも対象になる。

```sh
brew bundle cleanup --file="$HOME/.Brewfile"
```

候補を確認してから実際に削除する。

```sh
brew bundle cleanup --force --file="$HOME/.Brewfile"
```

mise は開発用ツールのバージョン管理に使う。言語ランタイム、Language Server、コーディングエージェント、プロジェクト横断で使う開発補助ツールを扱う。
