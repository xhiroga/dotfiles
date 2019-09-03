# dotfiles
top level setting of hiroga`s mac.

# setup
```
# 1. homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 2. init
bash init.sh -f

# 3. ssh configuration
# See https://help.github.com/en/articles/connecting-to-github-with-ssh

ssh-keygen -t rsa -f ${FILE} # OR
ssh-keygen -t ed25519 -f ${FILE}

# vi ~/.ssh/config

ssh -T git@github.com
```

# hand operations
* Caps lockとControlの入れ替え
https://pc-karuma.net/mac-keys-modifiers-switch-command-control-caps/

* 同じアプリ内でウィンドウを切り替え: Keybaord → Shortcuts → キーボード → 次のウィンドウを操作対象にする
* Hot Corners(左下でディスプレイをスリープ): Mission Control → Hot Corners
* 操作スペースの並べ替えの無効化: Mission Control → Automatically rearrange...
* コンピューターのスリープをしない: 省エネルギー → コンピューターのスリープ
* Tap to click(タップでクリック): Trackpad → Point&Click
* Tap dragging(ダブルタップでドラッグ): Accesibility → Mouse&Trackpad → Trackpad Options... → Enable Dragging
