;;; use-modeline.el ---  mode line settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(if (not (straight-use-package 'telephone-line))
    (warn "===> Can't install 'telephone-line'")

  ;; Config
  (with-eval-after-load 'telephone-line

    ;; Custon segments
    (telephone-line-defsegment* vs|modeline/major-mode-segment ()
      (all-the-icons-icon-for-mode major-mode :height 1 :v-adjust 0)
      )

    (telephone-line-defsegment vs|modeline/projectile-segment ()
      (if (fboundp 'projectile-project-name)
          (format "[%s]" (propertize (projectile-project-name)
                                        ;'face 'mode-line
                                     'display '(raise 0.0)
                                     'help-echo "Switch project"
                                        ;'mouse-face '(:box 1)
                                     'local-map (make-mode-line-mouse-map
                                                 'mouse-1 (lambda ()
                                                            (interactive)
                                                            (projectile-switch-project)))))))

    (telephone-line-defsegment vs|modeline/vc-segment ()
      (when vc-mode
        (list (all-the-icons-faicon "code-fork" :height 1 :v-adjust 0 :face (vs|git/face))
              " "
              (when (string-match "[-:@!?]\\(.+\\)$" vc-mode)
                (let ((branch (match-string 1 vc-mode)))
                  (if (> (length branch) 20)
                      (format "%s..." (truncate-string-to-width branch 17))
                    branch
                    )
                  )
                )
              )
        )
      )

    (telephone-line-defsegment* vs|modeline/buffer-segment ()
      (let ((face (if (buffer-modified-p) 'error 'success)))
        (list (if (buffer-file-name)
                  (all-the-icons-icon-for-file (buffer-file-name) :face face :v-adjust 0 :height 0.8)
                (condition-case nil
                    (all-the-icons-icon-for-buffer :face face :v-adjust 0 :height 0.8)
                  (error nil)
                  )
                )
              " "
              mode-line-buffer-identification
              )
        )
      )

    (telephone-line-defsegment vs|modeline/flycheck-segment ()
      (when (bound-and-true-p flycheck-mode)
        (let ((text (pcase flycheck-last-status-change
                      ('finished (if flycheck-current-errors
                                     (let-alist (flycheck-count-errors flycheck-current-errors)
                                       (let ((icon (if .error "times-circle" "minus-circle"))
                                             (face (if .error 'error 'warning)))
                                         (all-the-icons-faicon icon :face face :v-adjust 0 :height 1)))
                                   (all-the-icons-faicon "check-circle" :face 'success :v-adjust 0 :height 1)))
                      ('running     (all-the-icons-faicon "history" :v-adjust 0 :height 1))
                      ('no-checker  (all-the-icons-faicon "minus-circle" :v-adjust 0 :height 1))
                      ('not-checked (all-the-icons-faicon "times-circle" :v-adjust 0 :height 1))
                      ('errored     (all-the-icons-faicon "times-circle" :v-adjust 0 :height 1 :face 'error))
                      ('interrupted (all-the-icons-faicon "minus-circle" :v-adjust 0 :height 1 :face 'error))
                      ('suspicious  (all-the-icons-faicon "question-circle" :v-adjust 0 :height 1 :face 'warning))
                      )
                    )
              )
          (propertize text
                      'help-echo (pcase flycheck-last-status-change
                                   ('finished "Display errors found by Flycheck")
                                   ('running "Running...")
                                   ('no-checker "No Checker")
                                   ('not-checked "Not Checked")
                                   ('errored "Error!")
                                   ('interrupted "Interrupted")
                                   ('suspicious "Suspicious?"))
                      'local-map (make-mode-line-mouse-map
                                  'mouse-1 #'flycheck-list-errors)))))

    (telephone-line-defsegment vs|modeline/encoding-segment ()
      (let ((sys (coding-system-plist buffer-file-coding-system)))
        (cond
         ((memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8)) nil)
         (t (upcase (symbol-name (plist-get sys :name))))
         )
        )
      )

    (telephone-line-defsegment vs|modeline/eol-segment ()
      (pcase (coding-system-eol-type buffer-file-coding-system)
        (0  nil )
        (1 "DOS")
        (2 "MAC")
        )
      )

    (telephone-line-defsegment* vs|modeline/buffer-position-segment ()
      (let ((l 4) (c 3))
        (format "%%%dl:%%%dc " l c)
        )
      )

    ;; Left segments
    (setq telephone-line-lhs
          '(
            ;;(accent . (vs|modeline/major-mode-segment))
            (accent . (telephone-line-major-mode-segment))
            (accent . (vs|modeline/projectile-segment))
            (nil    . (vs|modeline/vc-segment))
            (nil    . (vs|modeline/buffer-segment))
            )
          )

    ;; Right segments
    (setq telephone-line-rhs
          '(
            (nil    . (vs|modeline/flycheck-segment))
            (accent . (vs|modeline/encoding-segment))
            (accent . (vs|modeline/eol-segment))
            (accent . (vs|modeline/buffer-position-segment))
            (accent . (telephone-line-hud-segment))
            )
          )

    ;; Separators
    (setq telephone-line-primary-left-separator 'telephone-line-flat
          telephone-line-secondary-left-separator 'telephone-line-flat
          telephone-line-primary-right-separator 'telephone-line-flat
          telephone-line-secondary-right-separator 'telephone-line-flat)

    ;; Height
    (setq telephone-line-height 24)
    )

  ;; Trigger
  (add-hook 'vs-emacs-config-hook #'telephone-line-mode t)

  )

(provide 'use-modeline)
;;; use-modeline.el ends here
