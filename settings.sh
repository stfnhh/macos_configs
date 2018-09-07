cd /tmp

# Dock
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-process-indicators -bool true

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true


# Trackpad
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -bool false
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1

# Keyboard
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false


# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Appearance: Graphite
defaults write -g AppleAquaColorVariant -int 6

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false






# Don't illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool false
# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true


# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done


# Install homebrew and apps
echo | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off

declare -a apps=(
  "wget:false"
  "httpie:false"
  "htop:false"
  "prettyping:false"
  "jq:false"
  "tldr:false"
  "fish:false"
  "archey:false"
  "virtualbox:false"
  "vagrant:false"
  "mas:false"
  "spectacle:true"
  "sublime-text:true"
  "appcleaner:true"
  "viscosity:true"
  "paw:true"
  "postico:true"
  "keka:true"
  "vmware-fusion:true"
  "sequel-pro:true"
  "eloston-chromium:true"
  "transmit:true"
  "iterm2:true"
  "arq:true"
  "viscosity:true"
  "little-snitch:true"
)

for app in "${apps[@]}"; do
  if [ ${app#*:} == true ]
  then
    brew cask install $app
  else
    brew install $app
  fi
done


mas install 409203825 # Numbers


#Sublime

ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

#iTerm2
wget -O ~/Library/Preferences/com.googlecode.iterm2.plist https://raw.githubusercontent.com/stfnhh/macos_configs/master/com.googlecode.iterm2.plist
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Library/Preferences/"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true


# Configure Fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install transfer

wget -O /Library/Fonts/droid_sans_mono_for_powerline.ttf https://raw.githubusercontent.com/stfnhh/macos_configs/master/droid_sans_mono_for_powerline.ttf
fisher install omf/theme-bobthefish

wget -O ~/.config/fish/functions/fish_prompt.fish https://raw.githubusercontent.com/stfnhh/macos_configs/master/fish_prompt.fish

echo 'function fish_right_prompt; end' >> ~/.config/fish/config.fish
printf "function fish_greeting\n\tarchey --offline\nend" >> ~/.config/fish/config.fish


# Vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
echo """
execute pathogen#infect()
syntax on
filetype plugin indent on
let g:airline_powerline_fonts = 1
""" > ~/.vimrc

