#Golang
set -x GOPATH $HOME/go
set -Ux PATH $HOME/.local/bin $PATH

#Android
set -x ANDROID_HOME $HOME/Android/Sdk
set -x JAVA_HOME $HOME/.local/share/JetBrains/Toolbox/apps/android-studio/jbr
for dir in $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator
    if not contains $dir $PATH
        set -gx PATH $dir $PATH
    end
end
