;;	$Id$

;; TODO: Modify  ECB in maximized windos  behaviour. When an item  of the tree
;;      windows  is selected  I want  the ECB  windos stay  selected  and not
;;      changes to the source windows
;; TODO: meterle acelerador de raton
;; TODO: Configure ps-printer-name variable
;; TODO: Solve problems with comments in C modes


(setq warning-suppress-types nil)       ;Workaround due to 23.2 bug

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
           " * " (doxymacs-doxygen-command-char) "date   "
           (format-time-string time-format) '> 'n
           " * " (doxymacs-doxygen-command-char) "brief  " 'p '> 'n
           " * " (doxymacs-doxygen-command-char) "details  " 'p '> 'n
           " * " '> 'n
           (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
           (unless (string-match
                    (regexp-quote (cdr (assoc 'return next-func)))
                    doxymacs-void-types)
             '(l " * " > n " * " (doxymacs-doxygen-command-char)
                 "return " (p "Returns:  ") > n))
           " */" '>)
        (progn
          (error "Can't find next function declaration.")
          nil))))
  "Customized JavaDoc-style template for function documentation.")




(defconst my-doxymacs-JavaDoc-file-comment-template
  '("/**" > n
    " * " (doxymacs-doxygen-command-char) "file   "
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
 '(auto-insert-mode t)
 '(auto-insert-query nil)
 '(auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/.saves-")
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/cache"))))
 '(browse-kill-ring-highlight-current-entry t)
 '(browse-kill-ring-highlight-inserted-item t)
 '(column-number-mode t)
 '(dabbrev-case-replace nil)
 '(develock-max-column-plist (quote (emacs-lisp-mode 80 lisp-interaction-mode w change-log-mode t texinfo-mode t c-mode 80 c++-mode 80 java-mode 80 jde-mode 80 html-mode 80 html-helper-mode 80 cperl-mode 80 perl-mode 80 mail-mode t message-mode t cmail-mail-mode t tcl-mode 80 ruby-mode 80)))
 '(diff-switches "-cw")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(doxymacs-file-comment-template my-doxymacs-JavaDoc-file-comment-template)
 '(doxymacs-function-comment-template my-doxymacs-JavaDoc-function-comment-template)
 '(ecb-auto-activate nil)
 '(ecb-layout-name "leftright-analyse")
 '(ecb-layout-window-sizes (quote (("leftright-analyse" (ecb-directories-buffer-name 0.23863636363636365 . 0.391304347826087) (ecb-sources-buffer-name 0.23863636363636365 . 0.2898550724637681) (ecb-history-buffer-name 0.23863636363636365 . 0.30434782608695654) (ecb-methods-buffer-name 0.22727272727272727 . 0.4927536231884058) (ecb-analyse-buffer-name 0.22727272727272727 . 0.4927536231884058)))))
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
]*>[    ]*" supercite-citation) (";+" lisp-comment) ("#+" sh-comment) ("%+" postscript-comment) ("^[    ]*\\(//\\|\\*\\)[^      ]*" c++-comment) ("@c[ \\t]" texinfo-comment) ("@comment[       ]" texinfo-comment) ("\\\\item[         ]" bullet) ("[0-9]+\\.[         ]" bullet) ("[0-9]+\\(\\.[0-9]+\\)+[    ]" bullet) ("[A-Za-z]\\.[       ]" bullet) ("(?[0-9]+)[         ]" bullet) ("(?[A-Za-z])[       ]" bullet) ("[0-9]+[A-Za-z]\\.[         ]" bullet) ("(?[0-9]+[A-Za-z])[         ]" bullet) ("[-~*+]+[   ]" bullet) ("o[         ]" bullet) ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[      ]*[A-Za-z_][A-Za-z_0-9]*[       ]+" bullet) ("[\\@][A-Za-z_]+[  ]*" bullet) ("[         ]+" space) ("$" end-of-line))))
 '(flyspell-default-dictionary "british")
 '(flymake-gui-warnings-enabled nil)
 '(font-lock-maximum-decoration t)
 '(font-lock-mode t t (font-lock))
 '(gdb-cpp-define-alist-program "cc -E  -")
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
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(make-backup-files nil)
 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(paren-mode (quote sexp) nil (paren))
 '(paren-sexp-mode (quote match))
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
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "Anonymous Pro"))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(flymake-errline ((t (:underline "red"))))
 '(flymake-warnline ((t (:underline "yellow"))))
 '(fringe ((((class color) (background light)) (:background "gray75"))))
 '(highline-face ((t (:background "LightBlue1"))))
 '(hl-line ((t (:background "LightBlue1"))))
 '(paren-face-match ((t (:background "light grey"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow" :foreground "black" :family "Anonymous Pro")))))




;; ***************************************************************************
;; Flymake
;; ***************************************************************************

(require 'flymake)
(require 'rfringe)


(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext)))
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))


(defun my-flymake-display-err-popup-el-for-current-line ()
  "Display a menu with errors/warnings for current line if it has
errors and/or warnings."
  (interactive)
  (let* ((line-no
          (flymake-current-line-no))
         (line-err-info-list
          (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data
          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
        (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                              (nth 1 menu-data)
                              "\n")))))


(defadvice flymake-mode (before post-command-stuff activate compile)
  "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
showed in a popup."
  (set (make-local-variable 'post-command-hook)
       (cons
        'my-flymake-display-err-popup-el-for-current-line post-command-hook)))


(add-hook 'find-file-hook 'flymake-find-file-hook)

;; ****************************************************************************
;; ECB
;; ****************************************************************************

(require 'ecb)
(ecb-winman-winring-enable-support)     ;Must be called before of requiring
                                        ;winring

(global-set-key [f2] 'ecb-toggle-ecb-windows)
(global-set-key [f3] '(lambda()
                        (interactive)
                        (iy/winring-jump-or-create "ECB")))





;; ****************************************************************************
;; CEDET configuration.
;; ****************************************************************************



(require 'semantic-load)
(require 'semanticdb-system)
(require 'semantic-gcc)
(require 'semantic-ia)
(require 'ede)
(require 'ede-locate)

(semantic-gcc-setup)
(setq semantic-load-turn-everything-on t)
(semantic-load-enable-excessive-code-helpers)
(semanticdb-load-system-caches)
(global-ede-mode 1)
(global-semantic-idle-completions-mode nil) ;This mode doesn't work very well


(defvar semantic-tags-location-ring (make-ring 20))



(defun semantic-goto-definition (point)
  "Goto definition using semantic-ia-fast-jump
save the pointer marker if tag is found"
  (interactive "d")
  (condition-case err
      (progn
        (ring-insert semantic-tags-location-ring (point-marker))
        (semantic-ia-fast-jump point))
    (error
     ;;if not found remove the tag saved in the ring
     (set-marker (ring-remove semantic-tags-location-ring 0) nil nil)
     (signal (car err) (cdr err)))))


(defun semantic-pop-tag-mark ()
  "popup the tag save by semantic-goto-definition"
  (interactive)
  (if (ring-empty-p semantic-tags-location-ring)
      (message "%s" "No more tags available")
    (let* ((marker (ring-remove semantic-tags-location-ring 0))
              (buff (marker-buffer marker))
                 (pos (marker-position marker)))
      (if (not buff)
            (message "Buffer has been deleted")
        (switch-to-buffer buff)
        (goto-char pos)))))

(when (cedet-gnu-global-version-check t)
  (require 'semanticdb-global)
  (add-to-list 'ede-locate-setup-options 'ede-locate-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))

(when (cedet-cscope-version-check t)
  (require 'semanticdb-cscope)
  (semanticdb-enable-cscope-databases)
  (add-to-list 'ede-locate-setup-options 'ede-locate-cscope))

(when (cedet-idutils-version-check t)
  (add-to-list 'ede-locate-setup-options 'ede-locate-idutils))

(require 'semanticdb-ectag)
(when (semantic-ectag-version)
  (semantic-load-enable-primary-exuberent-ctags-support)
  (semantic-load-enable-secondary-exuberent-ctags-support))

(when (executable-find "locate")
  (add-to-list 'ede-locate-setup-options 'ede-locate-locate))



(global-set-key "\C-\M-x" 'semantic-analyze-proto-impl-toggle)
(global-set-key [(control  <)] 'semantic-goto-definition)
(global-set-key [(control  >)] 'semantic-pop-tag-mark)

;;Customization of srecode. I will back over srecode some day
;;'(srecode-map-load-path (quote ("~/.emacs.d/site-lisp/cedet/cogre/templates/"
;; "~/.emacs.d/site-lisp/cedet/srecode/templates/"
;; "~/.emacs.d/srecode/")))
;; '(srecode-map-save-file "~/emacs.d/cache/srecode-map")



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

(require 'highline)
(require 'tramp)
(add-hook 'dired-mode-hook (lambda nil
                             (highline-local-mode t)))

;; ****************************************************************************
;; doxymacs
;; ****************************************************************************


(require 'doxymacs)
(require 'tempo)



(defun my-inside-javadoc-comment ()
  "Return t if the cursor is inside a comment."
  (let* ((last (point))
         (is-inside
          (if (search-backward "*/" nil t)
              ;; there are some comment endings - search forward
              (if (search-forward "/**" last t)
                  't
                'nil)

            ;; it's the only comment - search backward
            (goto-char last)
            (if (search-backward "/**" nil t)
                't
              'nil))))
    (goto-char last)
    is-inside))



(defun my-javadoc-return ()
  "Advanced C-m for Javadoc multiline comments.
   Inserts `*' at the beggining of the new line if
   unless return was pressed outside the comment"
  (interactive)
  (newline-and-indent)
  (when (my-inside-javadoc-comment) (insert "* ")))



(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode)
          (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))

(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)



;; ****************************************************************************
;; Autocomplete modes
;; ****************************************************************************


(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-clang)
(require 'cc-mode)

(defvar my-auto-complete-clangp nil
  "Flag to indicate clang is present")

(when (file-executable-p ac-clang-executable)
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



;; ****************************************************************************
;; C modes
;; ****************************************************************************


(require 'cc-mode)
(require 'doxymacs)
(require 'filladapt)
(require 'develock)
;; (require 'google-c-style)


(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "linux")
  (develock-mode -1)
  (setq c-basic-offset 8))

(setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
                            auto-mode-alist))


(defun my-c-mode ()
  (doxymacs-mode)
  (c-set-style "k&r")
  (defadvice c-indent-line
    (before indent-and-forward-tempo activate)
    (when (my-inside-javadoc-comment)
      (tempo-forward-mark)))
  (local-set-key [(return )]  'my-javadoc-return)
  (local-set-key "\C-cc" 'my-c-comment-function)
  (eldoc-mode)
  (local-set-key [ (control tab) ] 'eassist-switch-h-cpp)
  (turn-on-filladapt-mode)            ;This cause problems with space key in
  (auto-fill-mode t))                 ;lines which begins with /*



(add-hook 'c-mode-hook 'my-c-mode)
(add-hook 'c++-mode-hook 'my-c-mode)


(require 'eassist)
(setq eassist-header-switches
      '(("h" "cpp" "cc" "c") ("hpp" "cpp" "cc")
        ("cpp" "h" "hpp") ("c" "h") ("C" "H")
        ("H" "C" "CPP" "CC") ("cc" "h" "hpp")))



(defun my-c-comment-function ()
  "Comment a region in c-mode"
  (interactive)
  (unless (and transient-mark-mode mark-active)
    (error "The mark is not set now"))

  (save-excursion
    (save-restriction
      (narrow-to-region (region-beginning) (region-end))
      (goto-char (point-min))

      (while (search-forward "/*" nil t)
        (replace-match "/\\*" nil t))

      (goto-char (point-min))
      (while (search-forward "*/" nil t)
        (replace-match "*\\/" nil t))

      (goto-char (point-min))
      (while (< (point) (point-max))
        (move-to-column 0)
        (insert "/*")
        (if (< fill-column
               (- (line-end-position) (line-beginning-position)))
            (end-of-line)
          (move-to-column fill-column t))
        (insert "*/")
        (forward-line 1)))))



;; ****************************************************************************
;; GUD
;; ****************************************************************************

(require 'gdb-mi)
(require 'highline)

(global-set-key [f11] 'gdb)



(defvar my-gdb-line nil
  "Last line highlithed by gdb")



(defvar my-gdb-file nil
  "Last file highlithed by gdb")



(defun my-gdb-highline-file-line (file line light)
  (with-selected-window gdb-source-window
    (find-file file)
    (goto-char (point-min))
    (forward-line (1- line))
    (setq my-gdb-line line)
    (setq my-gdb-file file)
    (if light
        (highline-highlight-current-line)
      (highline-unhighlight-current-line))))

(defadvice gdb-reset
  (after my-gdb-reset activate)
  (my-gdb-highline-file-line my-gdb-file my-gdb-line nil))



(add-hook 'gdb-stopped-hooks
          '(lambda (arg)
             (let*
                 ((frame (cdr (nth 2 arg)))
                  (line (bindat-get-field frame 'line))
                  (file (bindat-get-field frame 'fullname)))
               (when (and (stringp line) (stringp file))
                 (when (and my-gdb-file my-gdb-line)
                   (my-gdb-highline-file-line my-gdb-file my-gdb-line nil))
                 (my-gdb-highline-file-line file (string-to-number line) t)))))



(add-hook 'gdb-mode-hook
          '(lambda ()
             (iy/winring-jump-or-create "GUD")
             (define-key gud-mode-map [f5] 'gud-step)
             (define-key gud-mode-map [f6] 'gud-next)
             (define-key gud-mode-map [f7] 'gud-finish)
             (define-key gud-mode-map [f8] 'gud-cont)
             (define-key gud-mode-map [f9] 'gud-until)
             (define-key gud-minor-mode-map [f5] 'gud-step)
             (define-key gud-minor-mode-map [f6] 'gud-next)
             (define-key gud-minor-mode-map [f7] 'gud-finish)
             (define-key gud-minor-mode-map [f8] 'gud-cont)
             (define-key gud-minor-mode-map [(control *)]
               'gud-tooltip-dereference)
             (define-key gud-minor-mode-map [f9] 'gud-until)))

(when (or (eq system-type 'windows-nt)
          (eq system-type 'cygwin))
  (progn
    (require 'cygwin-mount)
    (cygwin-mount-activate)))





;; ****************************************************************************
;; Lisp
;; ****************************************************************************

(require 'compile)
(require 'bytecomp)


(global-set-key "\C-ci"
                '(lambda nil
                   (interactive)
                   (find-file "~/.emacs.d/init.el")))

(add-hook 'after-save-hook
          '(lambda nil
             (if (or (string= (buffer-file-name)
                              (expand-file-name
                               (concat default-directory ".emacs")))
                     (string= (buffer-file-name)
                              (expand-file-name
                               (concat default-directory "init.el"))))
                 (byte-compile-file (buffer-file-name)))))


(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key [(return ) ] 'newline-and-indent)
            (eldoc-mode)
            (auto-fill-mode t)))



;; ****************************************************************************
;; window stuff
;; ****************************************************************************


(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))


(global-set-key [(control shift up)] 'enlarge-window)
(global-set-key [(control shift down)] 'shrink-window)
(global-set-key [(control shift left)] 'enlarge-window-horizontally)
(global-set-key [(control shift right)] 'shrink-window-horizontally)



(global-set-key [(control shift up)] 'enlarge-window)
(global-set-key [(control shift down)] 'shrink-window)
(global-set-key [(control shift left)] 'enlarge-window-horizontally)
(global-set-key [(control shift right)] 'shrink-window-horizontally)
(global-set-key [(meta right)] 'select-next-window)
(global-set-key [(meta left)]  'select-previous-window)




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


;; Close the compilation window if  there was no error at all.
(setq compilation-exit-message-function
      '(lambda (status code msg)
         (when (and (eq status 'exit) (zerop code))
           (bury-buffer)        ;; then bury the *compilation* buffer,
           (delete-window      ;; so that C-x b doesn't go there and delete
            (get-buffer-window                        ;;the *compilation* window
             (get-buffer "*compilation*"))))
         (cons msg code)))

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
(server-start)
(setq x-select-enable-clipboard t)



;; ****************************************************************************
;; Jump to point
;; ****************************************************************************

(global-set-key [(shift f1)] '(lambda ()
                                (interactive)
                                (point-to-register 1)))


(global-set-key [(shift f2)] '(lambda ()
                                (interactive)
                                (point-to-register 2)))


(global-set-key [(shift f3)] '(lambda ()
                                (interactive)
                                (point-to-register 3)))


(global-set-key [(shift f4)] '(lambda ()
                                (interactive)
                                (point-to-register 4)))



(global-set-key [(control f1)] '(lambda ()
                                  (interactive)
                                  (jump-to-register 1)))


(global-set-key [(control f2)] '(lambda ()
                                  (interactive)
                                  (jump-to-register 2)))


(global-set-key [(control f3)] '(lambda ()
                                  (interactive)
                                  (jump-to-register 3)))


(global-set-key [(control f4)] '(lambda ()
                                  (interactive)
                                  (jump-to-register 4)))





;; ****************************************************************************
;; Questions
;;*****************************************************************************

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)
(fset 'yes-or-no-p 'y-or-n-p)           ;Enable y/n instead of yes/no



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


;; ****************************************************************************
;; yasnippet
;; ****************************************************************************

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippets/")

;;Modification for allowing flymake and yasnippet runnit at same time


(defvar flymake-is-active-flag nil)

(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))


(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))




;;*****************************************************************************
;; Ediff
;;*****************************************************************************

(require 'ediff)

;; Ediff
;; =====
;; When you run Ediff on the Develock'ed buffers, you may feel
;; everything is in confusion.  For such a case, the following hooks
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


(defadvice flyspell-mode
  (after advice-flyspell-check-buffer-on-start activate)
  (flyspell-buffer))

(add-hook 'magit-log-edit-mode-hook (lambda nil
                                      (auto-fill-mode)
                                      (flyspell-mode 1)))

(add-hook 'log-edit-mode-hook (lambda nil
                                (auto-fill-mode)
                                (flyspell-mode 1)))




;; ****************************************************************************
;; Sunrise commander
;; ****************************************************************************

;; There is some other things in sunrise directory

(require 'sunrise-commander)
(require 'sunrise-x-buttons)            ;only necessary if you want the  buttons
(require 'sunrise-x-loop)         ;allow execute in background using C-u prefix

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


;;*****************************************************************************
;; ELPA
;;*****************************************************************************

(setq package-archives
      '(("ELPA" . "http://tromey.com/elpa/")
        ("gnu" . "http://elpa.gnu.org/packages/")
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
