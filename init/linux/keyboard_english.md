# 英字キーボードを使えるようにするための設定
## 前提 
デフォルトのインプットメソッドがibusだとできないのでfcitxにする。
また、バインドAが他とかぶってるとそちらが優先されるので、設定のショートカットを無効にする

## 設定

http://jun-networks.hatenablog.com/entry/2019/11/20/160003

* 下のコマンドで英字キーボードを選択 

  ```sh
  sudo dpkg-reconfigure keyboard-configuration
  ```

* /usr/share/ibus/component/mozc.xml の<layout>の部分をdefault -> enにする。
* fcitxのメソッドをmozc、英字キーボードだけにし、双方の配列は英字とする。
* fcitxの全体設定の入力メソッドのオンオフを使いたいバインド(バインドAとする)にする。
* mozcの設定のキー設定の選択をfcitxのときとは違うバインド(バインドBとする)にする。これは、mozcの日本語と英語を切り替えるために必要。

以上のように設定すると、ログイン時にバインドBで日本語入力を一度有効にするとバインドAでトグルができる。
