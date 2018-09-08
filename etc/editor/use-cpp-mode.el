;;; use-cpp-mode.el ---  C/C++ mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package irony
  :commands (irony-cdb-autosetup-compile-options irony-mode)

  :config
  (let ((irony-dir (expand-file-name (convert-standard-filename "irony/")
                                     vs-emacs-cache-dir)))
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                    irony-cdb-clang-complete)
                  irony-user-dir                  irony-dir)
    (unless (file-exists-p irony-dir)
      (make-directory irony-dir t)))

  :hook
  ((c-initialization . irony-mode                         )
   (irony-mode       . irony-cdb-autosetup-compile-options)))


(use-package  irony-eldoc
  :after (eldoc irony)
  :commands irony-eldoc
  :hook (irony-mode . irony-eldoc))


(use-package company-irony
  :after (company irony)
  :commands company-irony
  :config (defun vs|company/setup-irony ()
            (add-to-list 'company-backends 'company-irony))
  :hook (company-mode . vs|company/setup-irony))


(use-package flycheck-irony
  :after (flycheck irony)
  :commands flycheck-irony-setup
  :hook
  ((c-mode-common . flycheck-mode       )
   (flycheck-mode . flycheck-irony-setup)))


(use-package rtags :disabled
  :config
  (defun vs|rtags/setup ()
    (unless (rtags-executable-find "rc")
      (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm")
      (error "Binary rdm is not installed!"))
    (setq rtags-autostart-diagnostics t)
    (rtags-enable-standard-keybindings)
    (rtags-diagnostics))

  :general
  ("M-." 'rtags-find-symbol-at-point
   "M-," 'rtags-find-references-at-point
   "M-?" 'rtags-display-summary         )

  :hook ((c-initialization . vs|rtags/setup)
         (kill-emacs       . rtags-quit-rdm)))


(use-package company-rtags :disabled
  :after (company rtags)
  :config (defun vs|company/rtags-setup ()
            (add-to-list 'company-backends 'company-rtags))
  :hook (company-mode . vs|company/rtags-setup))


(use-package cmake-ide
  :commands cmake-ide-setup

  :config
  (defun vs|cmake-ide/set-build-dir ()
    (setq cmake-ide-build-dir (condition-case _
                                  (expand-file-name "build/release"
                                                    (projectile-project-root))
                                (error nil))))
  (vs|cmake-ide/set-build-dir)

  :hook
  ((c-initialization                . cmake-ide-setup           )
   (projectile-after-switch-project . vs|cmake-ide/set-build-dir)))


(use-package modern-cpp-font-lock :delight
  :commands modern-c++-font-lock-mode
  :hook (c++-mode . modern-c++-font-lock-mode))


(provide 'use-cpp-mode)
;;; use-cpp-mode.el ends here
