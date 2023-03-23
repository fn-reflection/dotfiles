# dotfiles
環境設定ファイルを様々なコンピュータで一元管理するためのレポジトリです。  
zshなどのinstall処理は含まれていないです。(使う場合は別途インストール必要)  
フォルダの作成処理なども含まれていないので、必要があればmkdirで作ってください。

# How To Use
```shell
git clone git@github.com:fn-reflection/dotfiles.git #このレポジトリをローカルにcloneする
./dotfiles/update_env.sh #このリポジトリにある.filesに向けたシンボリックリンクに置換、既存のものを上書きするので注意
./dotfiles/update_vscode_env.sh #このリポジトリにあるvscode configに向けたシンボリックリンクに置換、既存のものを上書きするので注意
```
