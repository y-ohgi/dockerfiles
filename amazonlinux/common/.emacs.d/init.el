(prefer-coding-system 'utf-8)

; forget
(require 'cl-lib)
(require 'cl)
(put 'downcase-region 'disabled nil)

; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

; keybind
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-o") 'other-window)


; dired
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)

; dont leave a backup file
(setq make-backup-files nil)

; "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

; auto file reload
(global-auto-revert-mode 1)

; dont distinction on case
(setq case-fold-search t)

; Disable bell
(setq ring-bell-function 'ignore)

; follow symbolic link
(setq vc-follow-symlinks t)
