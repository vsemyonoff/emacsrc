;;; use-speck.el ---  speck mode (spellchecker) settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package speck :ensure quelpa :disabled
  :config
  (progn
    (setenv "DICPATH" (expand-file-name "dictionaries" vs-emacs-data-dir))

    (setq speck-doublets                         t
          speck-engine                           'Hunspell

          ;; Hunspell engine settings
          speck-hunspell-coding-system           'utf-8
          speck-hunspell-default-dictionary-name "en,ru"
          speck-hunspell-dictionary-alist        '(("en,ru" . "en_RU"))
          speck-hunspell-language-options        '(("en,ru" utf-8 nil nil nil))
          speck-hunspell-library-directory       "")

    (defun vs|speck/mode-on()
      (speck-mode +1))

    (defun vs|speck/prog-mode-on ()
      (set (make-local-variable 'speck-syntactic) t)
      (vs|speck/mode-on)))

  :hook
  ((text-mode . vs|speck/mode-on     )
   (conf-mode . vs|speck/prog-mode-on)
   (prog-mode . vs|speck/prog-mode-on))

  :quelpa (speck :fetcher github :repo "ahungry/emacswiki-mirror" :files ("speck.el")))


(provide 'use-speck)
;;; use-speck.el ends here
