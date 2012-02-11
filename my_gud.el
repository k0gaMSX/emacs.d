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
