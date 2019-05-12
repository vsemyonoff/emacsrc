;;; use-wcheck.el ---  wcheck mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defconst vs-emacs-spellchecker (executable-find "hunspell")
  "Spellchecker program name.")

(when vs-emacs-spellchecker
  (if (not (straight-use-package 'wcheck-mode))
      (warn "===> Can't install 'wcheck-mode'")

    ;; Triggers
    (add-hook 'prog-mode-hook #'wcheck-mode)
    (add-hook 'text-mode-hook #'wcheck-mode)

    ;; Bindings
    (global-set-key (kbd "C-c s") #'wcheck-mode)
    ;;(global-set-key (kbd "C-c l") #'wcheck-change-language)
    (global-set-key (kbd "C-c c") #'wcheck-actions)
    (global-set-key (kbd "C-c n") #'wcheck-jump-forward)
    (global-set-key (kbd "C-c p") #'wcheck-jump-backward)

    ;; Config
    (with-eval-after-load 'wcheck-mode
      (defun wcheck--choose-action-minibuffer (actions)
        "Redefined `wcheck--choose-action-minibuffer' from `wcheck-mode'."
        (let ((ivy-use-selectable-prompt nil))
          (ivy-read "Choose: " actions)
          )
        )

      ;; Path to Hunspell dictionaries
      (setenv "DICPATH" (vs|emacs/data "dict"))

      ;; Define languages and set default
      (setq-default
       wcheck-language      "default"
       wcheck-language-data `(("default"
                               (connection     . pty                             )

                               (program        . ,vs-emacs-spellchecker          )
                               (args             "-i" "UTF-8" "-d" "en_RU" "-w"  )

                               (action-program . ,vs-emacs-spellchecker          )
                               (action-args      "-i" "UTF-8" "-d" "en_RU" "-a"  )
                               (action-parser  . wcheck-parser-ispell-suggestions)

                               (read-or-skip-faces
                                ((emacs-lisp-mode c-mode c++-mode python-mode shell-script-mode)
                                 read font-lock-comment-face font-lock-string-face
                                 )
                                (org-mode
                                 skip org-block-begin-line org-block-end-line org-meta-line org-link
                                 )
                                (nil)
                                )
                               )
                              )
       )
      )
    )
  )

(provide 'use-wcheck)
;;; use-wcheck.el ends here
