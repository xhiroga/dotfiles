# dotfiles

[hiroga](https://github.com/hiroga-cc)'s development environment.

## setup

```shell script
export GITHUB_USER="hiroga-cc"
export GITHUB_PERSONAL_TOKEN="$GITHUB_PERSONAL_TOKEN"

# create and add ssh key
./add-ssh-key

# update dotfiles
./update

# (only macOS) install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# setup
./${ENVIRONMENT}/setup
```

## hand operations

- [Caps lock と Control の入れ替え](https://pc-karuma.net/mac-keys-modifiers-switch-command-control-caps/)
- 同じアプリ内でウィンドウを切り替え: Keybaord → Shortcuts → キーボード → 次のウィンドウを操作対象にする
- Hot Corners(左下でディスプレイをスリープ): Mission Control → Hot Corners
- 操作スペースの並べ替えの無効化: Mission Control → Automatically rearrange...のチェックを外す
- コンピューターのスリープをしない: 省エネルギー → コンピューターのスリープ
- Tap to click(タップでクリック): Trackpad → Point&Click
- Tap dragging(ダブルタップでドラッグ): Accesibility → Mouse&Trackpad → Trackpad Options... → Enable Dragging
- カーソル速度: Trackpad → Point & Click → Tracking Speed
- Dock: Show recent applications in Dock → チェックを外す

## References

- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
