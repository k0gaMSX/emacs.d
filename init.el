;	$Id$

;TODO: Put english dictionary in programming modes
;TODO: erase C-v Custom and search other for M-v
;TODO: Modify  ECB in maximized windos  behaviour. When an item  of the tree
;      windows  is selected  I want  the ECB  windos stay  selected  and not
;      changes to the source windows
;TODO: link fill-column and comment init-pos and end-pos
;TODO: Document str-fill-spaces-c-comment defun
;TODO: meterle acelerador de raton
;TODO: añadir la pila de buffers
;TODO: Modify planner to allow change directory where is saved timeclock file
;TODO: Configure ps-printer-name variable
;TODO: put local configurations in init-local.el
;TODO: Put highlight-80+ & highline into mouse  menu

(defvar time-format "%Y-%02m-%02d %02H:%02M:%02S"
  "Variable which store the time format string")


(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(add-subdirs-to-load-path "~/.emacs.d/site-lisp")
(load-file "~/.emacs.d/site-lisp/cedet/common/cedet.elc")


(require 'setup-keys)                   ;Aditional keys
(require 'menu-bar+)                    ;Aditional menus


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
 '(ac-dwim t)
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode asm-mode)))
 '(auto-image-file-mode t)
 '(auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/.saves-")
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/cache"))))
 '(browse-kill-ring-highlight-current-entry t)
 '(browse-kill-ring-highlight-inserted-item t)
 '(column-number-mode t)
 '(dabbrev-case-replace nil)
 '(develock-max-column-plist (quote (emacs-lisp-mode 80 lisp-interaction-mode w change-log-mode t texinfo-mode t c-mode 80 c++-mode 80 java-mode 80 jde-mode 80 html-mode 80 html-helper-mode 80 cperl-mode 80 perl-mode 80 mail-mode t message-mode t cmail-mail-mode t tcl-mode 80 ruby-mode 80)))
 '(diff-switches "-cb")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(doxymacs-file-comment-template my-doxymacs-JavaDoc-file-comment-template)
 '(doxymacs-function-comment-template my-doxymacs-JavaDoc-function-comment-template)
 '(ecb-auto-activate nil)
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.1676300578034682 . 0.2926829268292683) (ecb-sources-buffer-name 0.1676300578034682 . 0.21951219512195122) (ecb-methods-buffer-name 0.1676300578034682 . 0.2926829268292683) (ecb-history-buffer-name 0.1676300578034682 . 0.17073170731707318)))))
 '(ecb-maximize-next-after-maximized-select (quote (ecb-history-buffer-name ecb-sources-buffer-name ecb-directories-buffer-name)))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-source-path (quote ("~/")))
 '(ecb-stealthy-tasks-delay 7)
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(ecb-winman-winring-name "ECB")
 '(ede-project-placeholder-cache-file "~/.emacs.d/cache/.projects.ede")
 '(ediff-diff-options "--binary -w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(eshell-directory-name "~/.emacs.d/cache")
 '(explicit-shell-file-name "bash")
 '(ffap-url-fetcher (quote w3m-browse-url))
 '(fill-column 76)
 '(filladapt-token-table (quote (("^" beginning-of-line) (">+" citation->) ("\\(\\w\\|[0-9]\\)[^'`\"<
]*>[    ]*" supercite-citation) (";+" lisp-comment) ("#+" sh-comment) ("%+" postscript-comment) ("^[    ]*\\(//\\|\\*\\)[^      ]*" c++-comment) ("@c[ \\t]" texinfo-comment) ("@comment[       ]" texinfo-comment) ("\\\\item[         ]" bullet) ("[0-9]+\\.[         ]" bullet) ("[0-9]+\\(\\.[0-9]+\\)+[    ]" bullet) ("[A-Za-z]\\.[       ]" bullet) ("(?[0-9]+)[         ]" bullet) ("(?[A-Za-z])[       ]" bullet) ("[0-9]+[A-Za-z]\\.[         ]" bullet) ("(?[0-9]+[A-Za-z])[         ]" bullet) ("[-~*+]+[   ]" bullet) ("o[         ]" bullet) ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[      ]*[A-Za-z_][A-Za-z_0-9]*[       ]+" bullet) ("[\\@][A-Za-z_]+[  ]*" bullet) ("[         ]+" space) ("$" end-of-line))))
 '(font-lock-maximum-decoration t)
 '(font-lock-mode t t (font-lock))
 '(gdb-cpp-define-alist-program "cc -E  -")
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-same-frame nil)
 '(gdb-show-main t)
 '(gdb-speedbar-auto-raise t)
 '(global-semantic-idle-summary-mode t nil (semantic-idle))
 '(global-semantic-idle-tag-highlight-mode t nil (semantic-idle))
 '(global-semantic-stickyfunc-mode nil nil (semantic-util-modes))
 '(gnus-nntp-server "quimby.gnus.org")
 '(grep-files-aliases (quote (("el" . "*.el") ("ch" . "*.[ch] *.cpp *.hxx *.cxx *.hpp") ("c" . "*.c *.cpp *.cxx") ("h" . "*.h *.hpp *.hxx") ("asm" . "*.[sS]") ("m" . "[Mm]akefile*") ("cl" . "[Cc]hange[Ll]og*") ("tex" . "*.tex") ("texi" . "*.texi") ("d" . "*.lua *.ui *.xml *.cfg *.def *.lvl *.trk *.xslt *.qrc *.c *.cpp *.cxx *.h *.hpp *.hxx") ("u" . "*.ui *.xml *.qrc *.xslt") ("g" . "*.def *.xml *.lvl *.trk *.xslt") ("l" . "*.lua"))))
 '(gud-tooltip-mode t)
 '(ido-save-directory-list-file "~/.emacs.d/cache/.ido.last")
 '(image-dired-db-file "/home/roberto/.emacs.d/cache/image-dired/.image-dired_db")
 '(image-dired-dir "/home/roberto/.emacs.d/cache/image-dired/")
 '(image-dired-gallery-dir "/home/roberto/.emacs.d/cache/image-dired/.image-dired_gallery")
 '(image-dired-temp-image-file "/home/roberto/.emacs.d/cache/image-dired/.image-dired_temp")
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
 '(search-highlight t)
 '(semantic-idle-scheduler-work-idle-time 15)
 '(semanticdb-default-save-directory "~/.emacs.d/cache")
 '(semanticdb-default-system-save-directory "~/.emacs.d/cache")
 '(shell-file-name "bash")
 '(srecode-map-load-path (quote ("/home/roberto/.emacs.d/site-lisp/cedet/srecode/templates/")))
 '(srecode-map-save-file "/home/roberto/.emacs.d/cache/srecode-map")
 '(time-stamp-format time-format)
 '(timeclock-get-workday-function (quote askworkday))
 '(timeclock-workday 32400)
 '(tooltip-mode t)
 '(tramp-auto-save-directory "~/.emacs.d/cache")
 '(tramp-persistency-file-name "~/.emacs.d/cache/tramp")
 '(tramp-remote-path (quote (tramp-default-remote-path "/home/revargas/" "/opt/sunstudio10/SUNWspro/prod/bin" "/usr/sbin" "/usr/local/bin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/usr/bin")))
 '(tramp-verbose 3)
 '(transient-mark-mode t)
 '(user-full-name "Roberto Vargas Caballero")
 '(user-mail-address "roberto@nemesis.com")
 '(winring-prompt-on-create nil)
 '(winring-show-names t)
 '(yas/root-directory (quote ("~/.emacs.d/yasnippets")) nil (yasnippet))
 '(yas/triggers-in-field t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "Anonymous Pro"))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(fringe ((((class color) (background light)) (:background "gray75"))))
 '(highlight-80+ ((((background light)) (:background "orange"))))
 '(highline-face ((t (:background "LightBlue1"))))
 '(hl-line ((t (:background "LightBlue1"))))
 '(paren-face-match ((t (:background "light grey")))))






;; ****************************************************************************
;; ECB
;; ****************************************************************************

(require 'ecb)
(ecb-winman-winring-enable-support)     ;Must be called before of requiring
                                        ;winring

(global-set-key [f2] 'ecb-toggle-ecb-windows)
(global-set-key [f3] '(lambda()
                        (interactive)
                        (my-winring-jump-to-configuration "ECB")))





;; ****************************************************************************
;; CEDET configuration.
;; ****************************************************************************



(require 'semantic-load)
(require 'semanticdb-system)
(require 'semantic-ia)
(require 'semantic-gcc)
(require 'semanticdb-global)


(setq semantic-load-turn-everything-on t)
(semantic-load-enable-excessive-code-helpers)


;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
(semantic-load-enable-primary-exuberent-ctags-support)

(global-semantic-idle-completions-mode nil) ;This mode doesn't work very well

(which-function-mode t)

;Customization of srecode. I will back over srecode some day
;;'(srecode-map-load-path (quote ("~/.emacs.d/site-lisp/cedet/cogre/templates/"
;; "~/.emacs.d/site-lisp/cedet/srecode/templates/"
;; "~/.emacs.d/srecode/")))
;; '(srecode-map-save-file "~/emacs.d/cache/srecode-map")


(global-set-key "\C-\M-g" 'semantic-complete-jump)
(global-set-key "\C-\M-b" 'semantic-complete-jump-local)
(global-set-key "\C-\M-d" 'semantic-ia-fast-jump)
(global-set-key "\C-\M-x" 'semantic-analyze-proto-impl-toggle)
(global-set-key "\C-\M-c" 'semantic-ia-complete-symbol-menu)
(global-set-key "\C-\M-t" 'senator-completion-menu-popup)
(global-set-key [(control meta <)] 'semantic-mrub-switch-tags)
(global-set-key [(control meta return)] 'complete-tag)




;; ****************************************************************************
;; Files
;; ****************************************************************************


(require 'jka-compr)
(require 'ido)
(ido-mode t)
(icomplete-mode t)

;convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

;vice versa
(defun unix2dos ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "\r\n")))



(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))


(defun dos-file ()
  "Change the current buffer to Latin 1 with DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-dos t))




(defun my-delete-trailing-whitespace ()
  "Delete all trailing white spaces"
  (interactive)
  (delete-trailing-whitespace))

(add-hook 'write-file-functions 'my-delete-trailing-whitespace)
(add-hook 'write-file-functions 'time-stamp)
(setq default-buffer-file-coding-system 'iso-latin-1-unix)

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
; doxymacs
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
;; Makefile mode
;;*****************************************************************************

(setq auto-mode-alist
       (append auto-mode-alist
         '(("\\.mak$" . makefile-mode))))




;; ****************************************************************************
;; Autocomplete modes
;; ****************************************************************************


(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(add-to-list
 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete//ac-dict")



(set-default 'ac-sources
             '(ac-source-yasnippet
               ac-source-abbrev
               ac-source-words-in-buffer))

(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

;(define-key ac-complete-mode-map "\M-/" 'ac-stop)
;(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map [(return)] 'ac-stop)



;; ****************************************************************************
;; C modes
;; ****************************************************************************


(require 'cc-mode)
(require 'doxymacs)
(require 'filladapt)
(require 'develock)

(require 'eassist)
(setq eassist-header-switches
      '(("h" "cpp" "cc" "c" "pc") ("hpp" "cpp" "cc")
        ("pc" "h" "hpp")
        ("cpp" "h" "hpp") ("c" "h") ("C" "H")
        ("H" "C" "CPP" "CC") ("cc" "h" "hpp")
        ("pc h")))



(defun my-c-mode ()
  (doxymacs-mode)
  (setq ac-override-local-map t)
  (setq yas/fallback-behavior nil)
  (local-set-key [tab]
                 '(lambda nil
                    (interactive)
                    (yas/expand)
                    (c-indent-line-or-region)
                    (when (my-inside-javadoc-comment)
                      (tempo-forward-mark))))
  (local-set-key [C-tab] 'eassist-switch-h-cpp)
  (add-to-list 'ac-omni-completion-sources
               (cons "\\." '(ac-source-semantic)))
  (add-to-list 'ac-omni-completion-sources
               (cons "->" '(ac-source-semantic)))
  (local-set-key [(return )]  'my-javadoc-return)
  (setq ac-sources
        '(ac-source-gtags
          ac-source-c++-keywords
          ac-source-yasnippet
          ac-source-words-in-buffer))
  (turn-on-filladapt-mode)
  (auto-fill-mode t))


(setq-mode-local c-mode
                 semanticdb-find-default-throttle
                 '(project unloaded recursive omniscience))

(setq-mode-local c++-mode
                 semanticdb-find-default-throttle
                 '(project unloaded recursive omniscience))


;;;(srecode-minor-mode t)
; if you want to enable support for gnu global -> CRASH!!!!
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
;  if you want to enable support for exuberant ctags <- Problems
;; (semanticdb-enable-exuberent-ctags 'c-mode)
;; (semanticdb-enable-exuberent-ctags 'c++-mode)

;(semanticdb-load-ebrowse-caches

(add-hook 'c-mode-hook 'my-c-mode)
(add-hook 'c++-mode-hook 'my-c-mode)
(setq auto-mode-alist
       (append auto-mode-alist
         '(("\\.pc$" . c-mode))))




(defun fill-spaces-c-comment (&optional init-pos end-pos)
  "Fill with spaces the line until fill-column and after put \"*/\""
  (interactive)
  (when (not init-pos) (setq init-pos (current-column)))
  (when (not end-pos) (setq end-pos fill-column))
  (insert-char ?  (- end-pos init-pos 2))
  (insert "*/"))



(defun str-fill-spaces-c-comment (&optional str init-pos end-pos)
  "Return a string which fill right part of the C comment"
  (when (not (stringp str)) (setq str ""))
  (when (not init-pos) (setq init-pos (current-column)))
  (when (not end-pos) (setq end-pos fill-column))
  (let ((cont (- end-pos init-pos 2)))
    (while (> cont 0)
      (setq cont (- cont 1))
      (setq str (concat str " ")))
    (concat str "*/")))



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
        (end-of-line)
        (insert (str-fill-spaces-c-comment))
        (forward-line 1)))))








;; ****************************************************************************
;; layout-restore
;; ****************************************************************************


(require 'layout-restore)

(global-set-key [?\C-c ?l] 'layout-save-current)
(global-set-key [?\C-c ?\C-l ?\C-l] 'layout-restore)
(global-set-key [?\C-c ?\C-l ?\C-c] 'layout-delete-current)






;; ****************************************************************************
;; GUD
;; ****************************************************************************

(require 'gud)
(require 'gdb-ui)
(require 'highline)

(global-set-key [f11] 'gdba)

;; (add-hook 'pre-command-hook 'highline-unhighlight-current-line)
;; (add-hook 'post-command-hook 'highline-highlight-current-line)

(add-hook 'gdb-mode-hook
          '(lambda ()
             (my-winring-jump-to-configuration "GUD")
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
               (auto-fill-mode t)
               (setq ac-sources
                     '(ac-source-yasnippet
                       ac-source-abbrev
                       ac-source-words-in-buffer
                       ac-source-symbols))))




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
(winring-rename-configuration "GUD")
(winring-new-configuration nil)
(winring-rename-configuration "ECB")




(defun my-winring-jump-to-configuration (var)
  "Go to the named window configuration."
  (let* ((ring (winring-get-ring))
         (index (my-winring-complete-name var))
         item)
    ;; if the current configuration was chosen, winring-complete-name
    ;; returns -1
    (when (<= 0 index)
      (setq item (ring-remove ring index))
      (winring-save-current-configuration)
      (winring-restore-configuration item))))




(defun my-winring-complete-name (var)
  (let* ((ring (winring-get-ring))
         (n (1- (ring-length ring)))
         (current (winring-name-of-current))
         (table (list (cons current -1))))
    ;; populate the completion table
    (while (<= 0 n)
      (setq table (cons (cons (winring-name-of (ring-ref ring n)) n) table)
            n (1- n)))
    (setq name var)
    (if (string-equal name "")
        (setq name current))
    (cdr (assoc name table))))




;;*****************************************************************************
;;Compile
;;*****************************************************************************


(require 'compile)
(global-set-key [f4] 'recompile)

(add-hook 'compilation-mode-hook (lambda nil
                                   (highline-local-mode t)))


;; Close the compilation window if  there was no error at all.
;; (setq compilation-exit-message-function
;;       ‘(lambda (status code msg)
;;          (when (and (eq status ‘exit) (zerop code))
;;            (bury-buffer)        ;; then bury the *compilation* buffer,
;;            (delete-window      ;; so that C-x b doesn’t go there and delete
;;             (get-buffer-window                        ;;the *compilation* window
;;              (get-buffer “*compilation*”))))
;;          (cons msg code))




(require 'mic-paren)
(paren-activate)
(require 'w3m-load)
(require 'avoid)
(mouse-avoidance-mode 'animate)
;(require 'tabbar)
;(tabbar-mode t)
;(require 'zenburn)
;(color-theme-classic)
;(zenburn)
(server-start)
;(turn-on-auto-fill)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)







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
;; timeclock & planner configuration
;; ****************************************************************************

(require 'timeclock)

(global-set-key "\C-cti" 'timeclock-in)
(global-set-key "\C-cto" 'timeclock-out)
(global-set-key "\C-ctc" 'timeclock-change)
(global-set-key "\C-ctr" 'timeclock-reread-log)
(global-set-key "\C-ctu" 'timeclock-update-modeline)
(global-set-key "\C-ctw" '(lambda ()
                            (interactive)
                            (message (timeclock-when-to-leave-string nil t))))

(global-set-key "\C-cts" 'timeclock-status-string)
(global-set-key "\C-ctv" 'timeclock-visit-timelog)
(global-set-key "\C-ctl" 'timeclock-generate-report)
(global-set-key "\C-ctt" 'timeclock-modeline-display)



(defun askworkday ()
  (interactive)
  (* 60 60 (string-to-number (read-from-minibuffer "Numero de horas: "))))



(setq planner-project "WikiPlanner")
(setq muse-project-alist
      '(("WikiPlanner"
         ("~/plans"   ;; Or wherever you want your planner files to be
          :default "index"
          :major-mode planner-mode
          :visit-link planner-visit-link))))

(require 'planner)                      ;here the order is important!
(require 'planner-timeclock)
(require 'planner-timeclock-summary)






;; ****************************************************************************
;; hacking for text mode
;; ****************************************************************************

(cond ((eq window-system nil)
       (global-semantic-stickyfunc-mode -1)
       (global-set-key "\C-\M-c" 'semantic-ia-complete-symbol)
       (menu-bar-mode nil)))





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
;*****************************************************************************

(require 'ediff)

;; Ediff
;; =====
;; When you run Ediff on the Develock'ed buffers, you may feel
;; everything is in confusion.  For such a case, the following hooks
;; may help you see diffs clearly.
;;

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
(define-key browse-kill-ring-mode-map [(control tab)]
  'browse-kill-ring-previous)



;;*****************************************************************************
;; Control version
;;*****************************************************************************

(require 'pcvs)
(require 'psvn)
(require 'vc)
(require 'flyspell)


(add-hook 'log-edit-mode-hook (lambda nil
                                (flyspell-mode 1)))


;;*****************************************************************************
;; flyspell
;;*****************************************************************************

(require 'flyspell)


;; (defadvice flyspell-mode
;;   (after advice-flyspell-check-buffer-on-start activate)
;;   (flyspell-buffer))

;; (add-hook 'kill-emacs-hook (lambda nil
;;                              (ispell-pdict-save)))

;; ****************************************************************************
;; User defined functions
;;*****************************************************************************


(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder
  <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %02X %c\n" i i i))))
  (goto-line 0))



;; ****************************************************************************
;; Sunrise commander
;; ****************************************************************************

;; There is some other things in sunrise directory

(require 'sunrise-commander)
(require 'sunrise-x-buttons)            ;only necessary if you want the  buttons
(require 'sunrise-x-loop)         ;allow execute in background using C-u prefix
(sunrise-mc-keys)                           ;activate MC keys in sunrise-mode

(global-set-key '[(control c) (x)] 'sunrise)
(global-set-key '[(control c) (X)] 'sunrise-cd)

(when (not (or (eq system-type 'windows-nt) ;Not change it in windows
               (eq system-type 'cygwin)))
  (progn
   (sr-rainbow sr-gorw-dir-face            ;Mark directories
               (:background "misty rose"
                            :foreground "blue1"
                            :bold t)
               "^..\\(d....\\(...\\)?w..*$\\)")

   (sr-rainbow sr-gorw-face                ;Mark files with bad rights
               (:background "misty rose")
               "^..\\(-....\\(...\\)?w..*$\\)")))


;;****************************************************************************
;; SQL
;;****************************************************************************


(eval-after-load "sql"
  ;; (load-library "sql-complete")          ; I need know how I can use it
  (load-library "sql-indent"))
