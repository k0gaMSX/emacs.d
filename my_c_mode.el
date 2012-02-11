
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


(defadvice c-indent-line
  (before indent-and-forward-tempo activate)
  (when (my-inside-javadoc-comment)
    (tempo-forward-mark)))


(defun my-c-mode ()
  (doxymacs-mode)
  (c-set-style "linux")
  (local-set-key "\C-cc" 'my-c-comment-function)
  (eldoc-mode)
  (local-set-key [ (control tab) ] 'eassist-switch-h-cpp)
  (turn-on-filladapt-mode)	      ;This cause problems with space key in
  (auto-fill-mode t))		      ;lines which begins with /*



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
