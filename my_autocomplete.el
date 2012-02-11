;; ****************************************************************************
;; Autocomplete modes
;; ****************************************************************************


(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-clang)
(require 'cc-mode)

(defvar my-auto-complete-clangp nil
  "Flag to indicate clang is present")

(when (and ac-clang-executable (file-executable-p ac-clang-executable))
  (setq my-auto-complete-clangp t))

(ac-config-default)
(global-auto-complete-mode t)


(defun my-sense-completion ()
  "Performs a auto completions based in sense information
taken from clang if it is installed, or in other case taken
from semantic"
  (interactive)
  (if (and my-auto-complete-clangp c-buffer-is-cc-mode)
      (auto-complete '(ac-source-clang))
    (auto-complete '(ac-source-semantic
		     ac-source-semantic-raw))))


(global-set-key [(control return)] 'my-sense-completion)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(ac-flyspell-workaround)
