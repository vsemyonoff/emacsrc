;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zerodark-theme :defer t
  :hook ((vs-emacs-theme-loaded . vs|theme/mode-line-setup)
         (vs-emacs-config-gui   . vs|theme/enable         ))
  :init
  (defvar vs-mode-line-modes
    (list '("" mode-name) '("" mode-line-process) '("" minor-mode-alist))
    "Mode line construct for displaying major and minor modes.")

  (defvar vs-mode-line-vc
    '(vc-mode ((:eval (all-the-icons-faicon "code-fork"
                                            :height 0.9
                                            :v-adjust 0
                                            :face (when (zerodark--active-window-p)
                                                    (zerodark-git-face))))
               " "
               (:eval (let ((vc-mode (truncate-string-to-width vc-mode 100 nil nil "...")))
                        (string-match "[-:@!?]\\(.+\\)$" vc-mode)
                        (substring vc-mode (match-beginning 1)))))))

  (defun vs|theme/mode-line-setup ()
    "Mode line setup."
    (setq-default mode-line-format
                  `(;"%e "
                    ,zerodark-modeline-ro " "
                    ,zerodark-buffer-coding " "
                    ,zerodark-modeline-modified " "
                    ,zerodark-modeline-buffer-identification
                    ,zerodark-modeline-position " ["
                    vs-mode-line-modes "]   "
                    ,vs-mode-line-vc "    "
                    (:eval (zerodark-modeline-flycheck-status)) " "
                    mode-line-misc-info mode-line-end-spaces)))

  (defun vs|theme/enable ()
    "Enable Zerodark theme."
    ;; Load theme
    (load-theme 'zerodark t t)
    (enable-theme 'zerodark)

    ;; Set font
    (set-face-attribute 'default nil :font "Roboto Mono" :height 100 :foreground "#f8f8f2")

    ;; Increase faces background
    (let ((faces '(error hl-line region success warning)))
      (vs|emacs/scale-face-color faces 10 t))

    ;; Increase faces foreground
    (let ((faces '(font-lock-builtin-face
                   font-lock-comment-face font-lock-constant-face font-lock-doc-face
                   font-lock-function-name-face font-lock-keyword-face font-lock-string-face
                   font-lock-type-face font-lock-variable-name-face)))
      (vs|emacs/scale-face-color faces 20))

    ;; Change colors
    (set-face-attribute 'company-preview-common nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'company-tooltip-common nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'company-tooltip-common-selection nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'ivy-current-match nil :inherit 'hl-line :background nil :foreground nil)
    (set-face-attribute 'ivy-subdir nil :inherit 'font-lock-builtin-face :foreground nil)
    (set-face-attribute 'show-paren-match nil :inherit 'error :background nil :foreground nil :underline t)))


(provide 'use-theme)
;;; use-theme.el ends here
