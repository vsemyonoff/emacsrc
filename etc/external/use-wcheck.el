;;; use-wcheck.el ---  wcheck mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(when vs-emacs-aspell-bin
  (use-package wcheck-mode
    :hook (prog-mode text-mode)
    :bind (("C-c s" . wcheck-mode)
           ("C-c c" . wcheck-actions)
           ("C-c n" . wcheck-jump-forward)
           ("C-c p" . wcheck-jump-backward))
    :config
    (defun vs:wcheck/args (lang &optional dict dict-dir)
      "Produce Aspell arguments list for language LANG,
dictionary DICT and extra dictonaries directory DICT-DIR."
      (let ((args `(,(format "--home-dir=%s" (vs:xdg/config "aspell"))
                    ,(format "--personal=%s.pws" dict)
                    ,(format "--repl=%s.prepl" dict)
                    "-l" ,lang)))
        (when dict
          (setq args (append args `("-d" ,dict)))
          (when dict-dir
            (add-to-list 'args (format "--dict-dir=%s" dict-dir) t)))
        args))

    (defun vs:wcheck/add-to-dictionary (marked-text)
      "Add current word to personal word list dictionary"
      (let ((word (downcase (aref marked-text 0))))
        (message "===> [TODO] vs:wcheck/add-to-dictionary: %s" word)))

    (defun vs:wcheck/suggestions-menu (marked-text)
      (cons (cons "[Add to dictionary]" (lambda () (vs:wcheck/add-to-dictionary marked-text)))
            (wcheck-parser-ispell-suggestions)))

    (defun wcheck--choose-action-minibuffer (actions)
      "Redefined `[Add to dictionary]--choose-action-[Add to dictionary]' with `ivy-read' [Add to dictionary]."
      (let ((ivy-use-selectable-prompt nil))
        (ivy-read "Choose: " actions
                  :require-match t
                  :action (lambda (cell)
                            (let ((val (cdr cell)))
                              (when (functionp val)
                                (funcall val)))))))

    (setq-default
     wcheck-language      "Ru+En"
     wcheck-language-data
     `(("Ru+En"
        (connection     . pty                       )
        (program        . ,vs-emacs-aspell-bin      )
        (action-program . ,vs-emacs-aspell-bin      )
        (action-parser  . vs:wcheck/suggestions-menu)
        ,(append '(args)
                 (vs:wcheck/args "ru" "ru-en"
                                 vs-aspell-dict-dir)
                 '("list"))
        ,(append '(action-args)
                 (vs:wcheck/args "ru" "ru-en"
                                 vs-aspell-dict-dir)
                 '("pipe"))
        (read-or-skip-faces
         ((emacs-lisp-mode c-mode c++-mode python-mode sh-mode shell-script-mode)
          read font-lock-comment-face font-lock-string-face font-lock-doc-face)
         (org-mode
          skip org-block-begin-line org-block-end-line org-meta-line org-link)
         (message-mode
          read nil message-header-subject message-cited-text)
         (git-commit-mode
          read nil git-commit-summary-face)
         (nil)))))))

(provide 'use-wcheck)
;;; use-wcheck.el ends here
