;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Fulvio di Girolamo"
      user-mail-address "fulviodigirolamo@tutanota.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set default treemacs theme as "doom-colors".
(setq doom-themes-treemacs-theme "doom-colors")

(use-package! org-roam
  :hook (after-init . org-roam-mode)
  :custom (org-roam-directory "~/PhD/roam_kb/"))

;; Enter the org-roam-mode as soon as emacs is opened.
(add-hook 'after-init-hook 'org-roam-mode)

;; Use org-roam-server for nice visualization of knowledge graph.
(use-package! org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; Configure org-roam-protocol so that org-roam-server properly works.
(require 'org-roam-protocol)

(after! org-roam
  (smartparens-global-mode -1)
  (org-roam-server-mode)
  (smartparens-global-mode 1))

;; Activate pdf-tools in all pdf buffers
(pdf-loader-install)

;; Configure helm then remove the helm-recentf keybinding which overrides the evil keybinding
(use-package! helm
  :config
  (define-key ctl-x-map (kbd "c C-c f") nil))

(use-package! helm-org
  :init
  (after! helm-mode
    (add-to-list 'helm-completing-read-handlers-alist '(org-set-tags-command . helm-org-completing-read-tags))))

(use-package! org-ref
  :config
  (setq reftex-default-bibliography '("~/PhD/references/library.bib")
        org-ref-default-bibliography '("~/PhD/references/library.bib")
        org-ref-pdf-directory "~/PhD/references/pdfs/"))

;; Configure org-roam-bibtex
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref))

;; Configure org-journal; replace the default org-journal-mode-map binding C-c C-s from org-journal-search to
;; org-schedule (preferred to using org-journal-new-scheduled-entry). org-journal-search is still accessible via
;; the binding SPC m s s.
(use-package! org-journal
  :config
  (setq org-journal-dir "~/PhD/journal/"
        org-journal-file-type 'yearly
        org-journal-enable-agenda-integration t
        org-journal-carryover-items "")
  (evil-define-key '(normal visual insert emacs motion) org-journal-mode-map (kbd "C-c C-s") 'org-schedule))

(use-package! org-noter
  :config
  (setq org-noter-always-create-frame nil))

(setq org-agenda-todo-list-sublevels nil)
(setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "IDEA(i)" "STRT(s!)" "WAIT(w!)" "HOLD(h!)" "LOOP(r!)" "|" "DONE(d!)" "KILL(k!)")
                          (sequence "Q(q)" "|" "A(a!)")
                          (sequence "[ ](T)" "[-](S!)" "[?](W!)" "|" "[X](D!)" "[/](K!)")))

(use-package! jupyter)

(org-babel-do-load-languages 'org-babel-load-languages (append org-babel-load-languages '((jupyter     . t))))
