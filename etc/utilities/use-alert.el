;;; use-alert.el --- notifications library. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package alert
  :commands alert
  :config
  (defun vs|alert/custom-notifier (info)
    "Customized terminal-notifier for MacOS."
    (let ((alert-cmd "/usr/local/bin/terminal-notifier")
          (cmd-args
           (list "-activate"      "org.gnu.Emacs"
                 "-appIcon"       (or (plist-get info :icon) alert-notifier-default-icon)
                 "-group"         "org.gnu.Emacs"
                 "-message"       (alert-encode-string (plist-get info :message))
                 "-sender"        "com.apple.Finder"
                 "-title"         (alert-encode-string (plist-get info :title)))))
      (apply 'call-process alert-cmd nil nil nil cmd-args)))

  (alert-define-style 'custom-osx-notifier
                      :title "Notify using terminal-notifier"
                      :notifier 'vs|alert/custom-notifier)

  (setq alert-default-style (if (display-graphic-p)
                                (if running-on-macos
                                    'custom-osx-notifier
                                  'notifications)
                              'mode-line)))


(provide 'use-alert)
;;; use-alert.el ends here
