{
    withKubernetes ? false,
    historySize ? 100000,
}:
{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
            ];
            theme = "bira";
        };

        history = {
          size = historySize;
          save = historySize;
        };

        initExtra = (if withKubernetes then ''
            if (( $+commands[kubectl] )); then
                # If the completion file doesn't exist yet, we need to autoload it and
                # bind it to `kubectl`. Otherwise, compinit will have already done that.
                if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
                  typeset -g -A _comps
                  autoload -Uz _kubectl
                  _comps[kubectl]=_kubectl
                fi

                kubectl completion zsh 2> /dev/null >| "$ZSH_CACHE_DIR/completions/_kubectl" &|
            fi
        '' else "");
        shellAliases = {

           ocr="cd ~/Documents/OCR_sudocul/";
           b="brightnessctl set";
           src="source ~/.bashrc";

           tp="cd ~/Documents/s3_prog/repo_git/";
           brc="vim ~/.bashrc";
           la="ls -a";

           rright="xrandr --output eDP-1 --rotate right";
           rnorm="xrandr --output eDP-1 --rotate normal";

           exrright="xrandr --output DP-1 --rotate right";
           exrnorm="xrandr --output DP-1 --rotate normal";

           vrc="vi ~/.vimrc";

           nvrc="vi ~/.config/nvim/init.vim";
           math="cd ~/Desktop/math & nix-shell -p xsel";

           conf="sudo vim /etc/nixos/configuration.nix";
           mc="make clean";

           e="exit";
           al="cd /home/tayron/Documents/Algo_TP/s3-2027-prefix-trees";

           hk="cd /home/tayron/Desktop/Hackathon_Istanbul/";

           build="sudo nixos-rebuild switch";

           goc="cd ~/.config";
         };
       };
}
