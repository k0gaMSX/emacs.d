;;	$Id$

;; TODO: Modify	 ECB in maximized windos  behaviour. When an item  of the tree
;;	windows	 is selected  I want  the ECB  windos stay  selected  and not
;;	changes to the source windows
;; TODO: meterle acelerador de raton
;; TODO: Configure ps-printer-name variable
;; TODO: Solve problems with comments in C modes


(setq warning-suppress-types nil)	;Workaround due to 23.2 bug

;;******************************************************************************
;; Open my init.el
;;******************************************************************************


(global-set-key "\C-ci" '(lambda nil
			   (interactive)
			   (find-file "~/.emacs.d/init.el")))





;;*****************************************************************************
;; Local configuration
;;*****************************************************************************

(when (file-exists-p "~/.emacs.d/local-pre.el")
  (load-file "~/.emacs.d/local-pre.el"))

;;*****************************************************************************

(defvar time-format "%Y-%02m-%02d %02H:%02M:%02S"
  "Variable which store the time format string")


(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(add-subdirs-to-load-path "~/.emacs.d/site-lisp")
(add-subdirs-to-load-path "~/.emacs.d/elpa")
(load-file (concat cedet-home "/common/cedet.elc"))






(defconst my-doxymacs-JavaDoc-function-comment-template
  '((let ((next-func (doxymacs-find-next-func)))
      (if next-func
	  (list
	   'l
	   "/** " '> 'n
	   " * " (doxymacs-doxygen-command-char) "author "
	   (user-full-name) '> 'n
	   " * " (doxymacs-doxygen-command-char) "date	 "
	   (format-time-string time-format) '> 'n
	   " * " (doxymacs-doxygen-command-char) "brief	 " 'p '> 'n
	   " * " (doxymacs-doxygen-command-char) "details  " 'p '> 'n
	   " * " '> 'n
	   (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
	   (unless (string-match
		    (regexp-quote (cdr (assoc 'return next-func)))
		    doxymacs-void-types)
	     '(l " * " > n " * " (doxymacs-doxygen-command-char)
		 "return " (p "Returns:	 ") > n))
	   " */" '>)
	(progn
	  (error "Can't find next function declaration.")
	  nil))))
  "Customized JavaDoc-style template for function documentation.")




(defconst my-doxymacs-JavaDoc-file-comment-template
  '("/**" > n
    " * " (doxymacs-doxygen-command-char) "file	  "
    (if (buffer-file-name)
	(file-name-nondirectory (buffer-file-name))
      "") > n
      " * " (doxymacs-doxygen-command-char) "author "
      (user-full-name) > n
      " * " (doxymacs-doxygen-command-char) "date   "
      (format-time-string time-format) > n
      " * " > n
      " * " (doxymacs-doxygen-command-char) "brief  "
      (p "Brief description of this file: ") > n
      " * " > n
      " * " p > n
      " */" > n)
  "Default JavaDoc-style template for file documentation.")




;; ****************************************************************************
;; Customization variables
;; ****************************************************************************


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start 3)
 '(ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat")
 '(ac-dictionary-directories (quote ("~/.emacs.d/site-lisp/auto-complete//ac-dict")))
 '(ac-dwim t)
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode asm-mode)))
 '(ac-use-menu-map t)
 '(ac-user-dictionary-files (quote ("~/.emacs.d/autocomplete-dict")))
 '(auto-image-file-mode t)
 '(auto-insert-directory "~/.emacs.d/auto-insert/")
 '(auto-insert-mode t)
 '(auto-insert-query nil)
 '(auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/.saves-")
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/cache"))))
 '(browse-kill-ring-highlight-current-entry t)
 '(browse-kill-ring-highlight-inserted-item t)
 '(browse-url-browser-function (quote w3m))
 '(column-number-mode t)
 '(dabbrev-case-replace nil)
 '(develock-max-column-plist (quote (emacs-lisp-mode 80 lisp-interaction-mode w change-log-mode t texinfo-mode t c-mode 80 c++-mode 80 java-mode 80 jde-mode 80 html-mode 80 html-helper-mode 80 cperl-mode 80 perl-mode 80 mail-mode t message-mode t cmail-mail-mode t tcl-mode 80 ruby-mode 80)))
 '(diff-switches "-cw")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(doxymacs-file-comment-template my-doxymacs-JavaDoc-file-comment-template)
 '(doxymacs-function-comment-template my-doxymacs-JavaDoc-function-comment-template)
 '(ecb-auto-activate nil)
 '(ecb-layout-name "left-analyse")
 '(ecb-maximize-next-after-maximized-select (quote (ecb-history-buffer-name ecb-sources-buffer-name ecb-directories-buffer-name)))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-stealthy-tasks-delay 7)
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(ecb-version-check nil)
 '(ecb-windows-width 0.2)
 '(ecb-winman-winring-name "ECB")
 '(ede-project-placeholder-cache-file "~/.emacs.d/cache/.projects.ede")
 '(ede-simple-save-directory "~/.emacs.d/ede")
 '(ediff-diff-options "--binary -w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(eshell-directory-name "~/.emacs.d/cache")
 '(eshell-history-file-name "~/.emacs.d/cache/cachehistory")
 '(eshell-last-dir-ring-file-name "~/.emacs.d/cache/cachelastdir")
 '(explicit-shell-file-name "bash")
 '(ffap-url-fetcher (quote w3m-browse-url))
 '(fill-column 76)
 '(filladapt-token-table (quote (("^" beginning-of-line) (">+" citation->) ("\\(\\w\\|[0-9]\\)[^'`\"<
]*>[	]*" supercite-citation) (";+" lisp-comment) ("#+" sh-comment) ("%+" postscript-comment) ("^[	]*\\(//\\|\\*\\)[^	]*" c++-comment) ("@c[ \\t]" texinfo-comment) ("@comment[	]" texinfo-comment) ("\\\\item[		]" bullet) ("[0-9]+\\.[		]" bullet) ("[0-9]+\\(\\.[0-9]+\\)+[	]" bullet) ("[A-Za-z]\\.[	]" bullet) ("(?[0-9]+)[		]" bullet) ("(?[A-Za-z])[	]" bullet) ("[0-9]+[A-Za-z]\\.[		]" bullet) ("(?[0-9]+[A-Za-z])[		]" bullet) ("[-~*+]+[	]" bullet) ("o[		]" bullet) ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[	]*[A-Za-z_][A-Za-z_0-9]*[	]+" bullet) ("[\\@][A-Za-z_]+[	]*" bullet) ("[		]+" space) ("$" end-of-line))))
 '(flymake-gui-warnings-enabled nil)
 '(flymake-no-changes-timeout 20)
 '(flyspell-default-dictionary "british")
 '(font-lock-maximum-decoration t)
 '(font-lock-mode t t (font-lock))
 '(gdb-cpp-define-alist-program "cc -E	-")
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-same-frame nil)
 '(gdb-show-main t)
 '(gdb-speedbar-auto-raise t)
 '(global-semantic-idle-completions-mode nil nil (semantic-idle))
 '(global-semantic-idle-local-symbol-highlight-mode t nil (semantic-idle))
 '(global-semantic-idle-summary-mode t nil (semantic-idle))
 '(global-semantic-idle-tag-highlight-mode t nil (semantic-idle))
 '(global-semantic-stickyfunc-mode nil nil (semantic-util-modes))
 '(gnus-nntp-server "quimby.gnus.org")
 '(grep-files-aliases (quote (("el" . "*.el") ("ch" . "*.[ch] *.cpp *.hxx *.cxx *.hpp") ("c" . "*.c *.cpp *.cxx") ("h" . "*.h *.hpp *.hxx") ("asm" . "*.[sS]") ("m" . "[Mm]akefile*") ("cl" . "[Cc]hange[Ll]og*") ("tex" . "*.tex") ("texi" . "*.texi") ("d" . "*.lua *.ui *.xml *.cfg *.def *.lvl *.trk *.xslt *.qrc *.c *.cpp *.cxx *.h *.hpp *.hxx") ("u" . "*.ui *.xml *.qrc *.xslt") ("g" . "*.def *.xml *.lvl *.trk *.xslt") ("l" . "*.lua"))))
 '(gud-tooltip-mode t)
 '(ido-save-directory-list-file "~/.emacs.d/cache/.ido.last")
 '(image-dired-db-file "~/.emacs.d/cache/image-dired/.image-dired_db")
 '(image-dired-dir "~/.emacs.d/cache/image-dired/")
 '(image-dired-gallery-dir "~/.emacs.d/cache/image-dired/.image-dired_gallery")
 '(image-dired-temp-image-file "~/.emacs.d/cache/image-dired/.image-dired_temp")
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(make-backup-files nil)
 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(paren-mode (quote sexp) nil (paren))
 '(password-cache-expiry 600)
 '(query-replace-highlight t)
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((indent-tabs-mode . 8) (c-set-style . gnu) (c-set-style . linux) (Mode . C) (Mode . C++) (encoding . iso-8859-15))))
 '(scroll-bar-mode (quote right))
 '(search-highlight t)
 '(semantic-idle-scheduler-work-idle-time 15)
 '(semanticdb-default-save-directory "~/.emacs.d/cache")
 '(semanticdb-default-system-save-directory "~/.emacs.d/cache/system")
 '(shell-file-name "bash")
 '(sr-popviewer-mode nil)
 '(srecode-map-load-path (quote ("~/.emacs.d/site-lisp/cedet/srecode/templates/")))
 '(srecode-map-save-file "~/.emacs.d/cache/srecode-map")
 '(time-stamp-format time-format)
 '(tooltip-mode t)
 '(tramp-auto-save-directory "~/.emacs.d/cache")
 '(tramp-persistency-file-name "~/.emacs.d/cache/tramp")
 '(tramp-remote-path (quote (tramp-default-remote-path "/home/revargas/" "/opt/sunstudio10/SUNWspro/prod/bin" "/usr/sbin" "/usr/local/bin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/usr/bin")))
 '(tramp-verbose 3)
 '(transient-mark-mode t)
 '(w3m-default-display-inline-images t)
 '(w3m-use-cookies t)
 '(winring-prompt-on-create nil)
 '(winring-show-names t)
 '(yas/prompt-functions (quote (yas/dropdown-prompt yas/ido-prompt yas/completing-prompt)))
 '(yas/root-directory (quote ("~/.emacs.d/yasnippets")) nil (yasnippet))
 '(yas/triggers-in-field t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "unknown" :family "Anonymous Pro"))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(flymake-errline ((t (:underline "red"))))
 '(flymake-warnline ((t (:underline "yellow"))))
 '(fringe ((((class color) (background light)) (:background "gray75"))))
 '(highline-face ((t (:inherit hl-line))))
 '(paren-face-match ((t (:background "gray75"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow" :foreground "black" :family "Anonymous Pro")))))


(let ((default-directory user-emacs-directory))
  (load-file "my_flymake.el")
  (load-file "my_ecb.el")
  (load-file "my_cedet.el")
  (load-file "my_doxymacs.el")
  (load-file "my_autocomplete.el")
  (load-file "my_c_mode.el")
  (load-file "my_gud.el")
  (load-file "my_lisp.el")
  (load-file "my_yasnippet.el")
  (load-file "my_jump.el")
  (load-file "my_window.el"))



;; ****************************************************************************
;; Files
;; ****************************************************************************


(require 'jka-compr)
(require 'ido)
(ido-mode t)
(icomplete-mode t)


(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))


(defun dos-file ()
  "Change the current buffer to Latin 1 with DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-dos t))


(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'time-stamp)
(setq buffer-file-coding-system 'iso-latin-1-unix)

(global-set-key "\C-\M-f" 'find-file-at-point)


;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
  "~/.emacs.d/cache/")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

(require 'highline-autoloads)
(require 'tramp)
(add-hook 'dired-mode-hook (lambda nil
			     (highline-local-mode t)))








;; ***************************************************************************
;; assembler modes
;; ***************************************************************************

(require 'gas-mode)
(require 'z80)

(add-to-list 'auto-mode-alist '(".*\.asm?$" . z80-mode))
(add-to-list 'auto-mode-alist '(".*\.[sS]$" . gas-mode))


(when (or (eq system-type 'windows-nt)
	  (eq system-type 'cygwin))
  (progn
    (require 'cygwin-mount)
    (cygwin-mount-activate)))





;; ****************************************************************************
;; Winring
;; ****************************************************************************

(require 'winring) ;Must be loaded after ecb-winman-winring-enable-support call
(winring-initialize)

(defun iy/winring-jump-or-create (&optional name)
  "Jump to or create configuration by name"
  (interactive)
  (let* ((ring (winring-get-ring))
	 (n (1- (ring-length ring)))
	 (current (winring-name-of-current))
	 (lst (list (cons current -1)))
	 index item)
    (while (<= 0 n)
      (push (cons (winring-name-of (ring-ref ring n)) n) lst)
      (setq n (1- n)))
    (setq name
	  (or name
	      (completing-read
	       (format "Window configuration name (%s): " current)
	       lst nil 'confirm nil 'winring-name-history current)))
    (setq index (cdr (assoc name lst)))
    (if (eq nil index)
	(progn
	  (winring-save-current-configuration)
	  (delete-other-windows)
	  (switch-to-buffer winring-new-config-buffer-name)
	  (winring-set-name name))
      (when (<= 0 index)
	(setq item (ring-remove ring index))
	(winring-save-current-configuration)
	(winring-restore-configuration item)))))


;;*****************************************************************************
;;Compile
;;*****************************************************************************


(require 'compile)
(global-set-key [f4] 'recompile)

(add-hook 'compilation-mode-hook (lambda nil
				   (highline-local-mode t)))


;;Interpretate ansi sequences

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)



;;*****************************************************************************




(require 'mic-paren)
(paren-activate)

(require 'w3m-load)
(require 'avoid)
(mouse-avoidance-mode 'animate)

(require 'server)
(unless (server-running-p)  (server-start))
(setq x-select-enable-clipboard t)


;; ****************************************************************************
;; auto insert
;; ****************************************************************************

(define-auto-insert "\.ac$" "configure.ac")
(define-auto-insert "\.in$" "Makefile.in")



;; ****************************************************************************
;; Questions
;;*****************************************************************************

(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)
(fset 'yes-or-no-p 'y-or-n-p)		;Enable y/n instead of yes/no



;;*****************************************************************************
;; User defined keys
;;*****************************************************************************

(global-set-key "\C-cw" 'delete-region)
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cp" 'previous-error)
(global-set-key [(meta g)]  'goto-line)
(global-set-key [ (meta n) ] 'forward-paragraph)
(global-set-key [ (meta p) ] 'backward-paragraph)


(defun goto-column ()
  "Goto column, counting from column 0 at beginning of line."
  (interactive)
  (move-to-column (string-to-number (read-from-minibuffer "Goto column: "))))






;;*****************************************************************************
;; Ediff
;;*****************************************************************************

(require 'ediff)

;; Ediff
;; =====
;; When you run Ediff on the Develock'ed buffers, you may feel
;; everything is in confusion.	For such a case, the following hooks
;; may help you see diffs clearly.
;;

(defvar develock-mode-suspended nil)

(add-hook
 'ediff-prepare-buffer-hook
 (lambda nil
   (if (and (boundp 'font-lock-mode) font-lock-mode
	    (boundp 'develock-mode) develock-mode)
       (progn
	 (develock-mode 0)
	 (set (make-local-variable 'develock-mode-suspended) t)))))

(add-hook
 'ediff-cleanup-hook
 (lambda nil
   (let ((buffers (list ediff-buffer-A ediff-buffer-B ediff-buffer-C)))
     (save-excursion
       (while buffers
	 (if (buffer-live-p (car buffers))
	     (progn
	       (set-buffer (car buffers))
	       (if (and (boundp 'develock-mode-suspended)
			develock-mode-suspended)
		   (progn
		     (develock-mode 1)
		     (makunbound 'develock-mode-suspended)))))
	 (setq buffers (cdr buffers)))))))


;;*****************************************************************************
;; kill-ring & Selections
;;*****************************************************************************

(require 'second-sel)
(require 'browse-kill-ring+)
(browse-kill-ring-default-keybindings)


;;*****************************************************************************
;; Control version
;;*****************************************************************************

(require 'vc)

(global-set-key '[ (control x ) (v) (t) ]
		(lambda ()
		  (interactive)
		  (cond ((locate-dominating-file default-directory ".git")
			 (require 'magit)
			 (magit-status default-directory))
			((locate-dominating-file default-directory ".CVS")
			 (require 'pcvs)
			 (cvs-status default-directory nil))
			((locate-dominating-file default-directory ".svn")
			 (require 'psvn)
			 (svn-status default-directory)))))

;;*****************************************************************************
;; flyspell
;;*****************************************************************************

(require 'flyspell)

(add-hook 'magit-log-edit-mode-hook (lambda nil
				      (auto-fill-mode)
				      (flyspell-mode 1)))

(add-hook 'log-edit-mode-hook (lambda nil
				(auto-fill-mode)
				(flyspell-mode 1)))

(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(require 'erc-spelling)
(add-hook 'erc-mode-hook 'erc-spelling-mode)
;; ****************************************************************************
;; Sunrise commander
;; ****************************************************************************

;; There is some other things in sunrise directory

(require 'sunrise-commander-autoloads)

(global-set-key '[(control c) (x)] 'sunrise)
(global-set-key '[(control c) (X)] 'sunrise-cd)



;;******************************************************************************
;; It is necessary put this after load the rest of things
;;******************************************************************************

(global-set-key [(C-down-mouse-1)] 'semantic-goto-definition)


;;******************************************************************************
;; Other things
;;******************************************************************************

(require 'w3m)
(require 'google-define)
(require 'ascii)
(require 'zenburn)

(unless (zenburn-format-spec-works-p)
  (zenburn-define-format-spec))
(zenburn)

;;*****************************************************************************
;; ELPA
;;*****************************************************************************

(setq package-archives
      '(("ELPA" . "http://tromey.com/elpa/")
	("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("SC"  . "http://joseito.republika.pl/sunrise-commander/")))


;;*****************************************************************************
;; Local configuration
;;*****************************************************************************

(when (file-exists-p "~/.emacs.d/local-post.el")
  (load-file "~/.emacs.d/local-post.el"))


;;*****************************************************************************
;; Enabling options
;;*****************************************************************************

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-left 'disabled nil)
