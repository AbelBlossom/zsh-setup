#!/bin/zsh

apt update

if [ $? -ne 0 ]; then
  echo An Error Occured
  exit 1
fi

# Install zsh
apt install zsh curl git

if [ $? -ne 0 ]; then
  echo An Error Occured
  exit 1
fi

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# exec zsh || true
# intall extensionsion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
if [ $? -ne 0 ]; then
  echo An Error Occured
  exit 1
fi

RC_CONFIG=$HOME/.zshrc
##  plugins to add
P_REPLACE="plugins=(git sudo dirhistory history jsontools zsh-autosuggestions)"

## get the line number of the plugins
LN=$(cat $RC_CONFIG | grep -n plugins= | grep -v \# | cut -d: -f1)
if [ $? -ne 0 ]; then
  echo An Error Occured
  exit 1
fi

sed -i.old "${LN}s/.*/${P_REPLACE}/" $RC_CONFIG

if [ $? -ne 0 ]; then
  echo An Error Occured
  exit 1
fi

source $RC_CONFIG

echo DONE!!!
