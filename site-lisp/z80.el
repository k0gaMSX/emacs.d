;; z80-mode.el --- mode for editing z80 assembler code

;; Copyright (C) 2011 Roberto E. Vargas Caballero

;; Author: Roberto E. Vargas Caballero <k0ga@shike2.com>
;; Created: 12 Jul 2011
;; Keywords: languages assembler z80

;; This file is written for GNU Emacs, and uses the same license
;; terms; however, it is an add-on and not part of it.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:




;;; Code:

(require 'newcomment)

(defgroup z80 nil
  "Mode for editing z80 assembler code."
  :link '(custom-group-link :tag "Font Lock Faces group" font-lock-faces)
  :group 'languages)


(defcustom z80-opcodes-alist
  '("ld"   "or"  "and"   "dec"  "inc"  "nop"
    "ex"   "add" "rrca"  "djnz" "inc"  "rla"
    "daa"  "cpl"  "scf"  "ccf"  "halt" "adc"
    "xor"  "cp"   "ret"  "pop"  "jp"   "set"
    "out"  "in"   "di"   "call" "rst"  "ei"
    "exx"  "push" "and"  "sls"  "srl"  "rrc"
    "rrd"  "reti" "im"   "retn" "neg"  "rr"
    "sra"  "sbc"  "daa"  "rl"   "rlc"  "dec"
    "bit"  "sla"  "res"  "sub"  "jr"   "rra"
    "rlca" "rlca" "ldir" "lddr")
  "Alist of valid mnemonics for z80 assembler."
  :type '(repeat string)
  :group 'z80)


(defcustom z80-opcode-return-alist
  '("jp"  "jr"  "ret")
  "Alist of opcodes which can mark returning of a subroutine."
  :type  '(repeat string)
  :group 'z80)

(defcustom z80-builtint-alist
  '("org" "equ"  "include" "$")
  "Alist of valid builtint for z80 assembler."
  :type '(repeat string)
  :group 'z80)


(defcustom z80-register-alist
  '("hl" "de" "bc"  "af"  "sp"
    "ix" "iy" "ixl" "ixh" "iyl" "iyh"
    "a" "f" "b" "c" "d" "e" "h" "l" "r" "i")
  "AList of z80 register names."
  :type '(repeat string)
  :group 'z80)


(defcustom z80-types-alist
  '("db" "dw" "dd" "ds")
  "Alist of z80 data directives."
  :type '(repeat string)
  :group 'z80)


(defcustom z80-sym-regexp
  "\\(\\<\\(\\sw\\|\\s_\\)+\\>\\)"
  "Regexp for symbols."
  :type 'regexp
  :group 'z80)


(defcustom z80-integer-regexp-alist
  '("\\(\\<\\([[:digit:]][[:xdigit:]]*[hH]\\)\\>\\)"
    "\\(\\<[[:digit:]]+\\>\\)"
    "\\(\\<[0-7]+[oO]\\>\\)"
    "\\(\\<[01]+[bB]\\>\\)")
  "Regexps for integers values."
  :type '(repeat string)
  :group 'z80)



(defcustom z80-opcode-column 14
  "The opcode column."
  :type 'integer
  :group 'z80)

(defcustom z80-argument-column 20
  "The column for the arguments (if any)."
  :type 'integer
  :group 'z80)

(defcustom z80-comment-column 36
  "The column where end of line asm comments go to."
  :type 'integer
  :group 'z80)



(defvar z80-opcode-return-regexp
  (concat "\\("
          (regexp-opt z80-opcode-return-alist 'words)
          "\\)"))

(defvar z80-opcodes-regexp
  (concat "\\("
          (regexp-opt z80-opcodes-alist 'words)
          "\\)"))

(defvar z80-builtint-regexp
  (concat "\\("
          (regexp-opt z80-builtint-alist 'words)
          "\\)"))

(defvar z80-types-regexp
  (concat "\\("
          (regexp-opt z80-types-alist 'words)
          "\\)"))


(defvar z80-expresion-regexp
  (concat "\\("
          z80-opcodes-regexp "\\|"
          z80-builtint-regexp "\\|"
          z80-types-regexp
          "\\)"))

(defvar z80-register-regexp
  (concat "\\("
          (regexp-opt z80-register-alist 'words)
          "\\)"))




(defvar z80-integer-regexp
  (let ((alist z80-integer-regexp-alist)
        (str nil))
    (while (not (null alist))
      (setq str
            (concat
             str
             (when (not (null str)) "\\|")
             (car alist)))
      (setq alist (cdr alist)))
    (concat "\\(" str "\\)")))



(defvar z80-global-label-regexp
  (concat
   "\\(^\\s *" z80-sym-regexp ":\\)"))


(defvar z80-local-label-regexp
  (concat
     "\\(^\\s *\\." z80-sym-regexp ":\\)"))


(defvar z80-label-regexp
  (concat "\\(" z80-local-label-regexp "\\|" z80-global-label-regexp "\\)"))


(defvar z80-global-data-regexp
  (concat
   "\\(" z80-global-label-regexp "\\(\\s \\|
\\)+" z80-types-regexp "\\)"))


(defvar z80-local-data-regexp
  (concat
   "\\(" z80-local-label-regexp "\\(\\s \\|
\\)+" z80-types-regexp "\\)"))


(defvar z80-data-regexp
  (concat "\\(" z80-global-data-regexp "\\|" z80-local-data-regexp "\\)"))



(defvar z80-defun-regexp
  (concat
   ;; line before label
   "\n\\s *" z80-builtint-regexp "?\n"
   ;; line with label
   "\\s *" z80-global-label-regexp "\\s *\\(" z80-opcodes-regexp ".*\\)?\n"
   ;;at least it must have one opcode
   "\\s *" z80-opcodes-regexp)
  "Regular expression for detecting the beginning of a function.
It searchs a blank line or a line with a builtint expression followed by a
line with a global label, with an optional  opcode in the same line and
followed by at least one opcode. I know this will not catch something
like

label: ret,

but this is a real rare case")


(defface z80-registers
  '((((class color) (background light))
     (:foreground "DarkBlue"))
    (((class color) (background dark))
     (:foreground "grey")))
  "Face to use for z80 registers."
  :group 'z80)


(defface z80-global-label
  '((t :inherit font-lock-function-name-face :weight bold))
  "Face to use in local labels."
  :group 'z80)


(defface z80-local-label
  '((t :inherit font-lock-function-name-face :slant italic))
  "Face to use in local labels."
  :group 'z80)


(defface z80-global-data-label
  '((t :inherit font-lock-variable-name-face :weight bold))
  "Face to use in local labels."
  :group 'z80)


(defface z80-local-data-label
  '((t :inherit font-lock-variable-name-face :slant italic))
  "Face to use in local labels."
  :group 'z80)




(defvar z80-registers-face 'z80-registers)
(defvar z80-global-label-face 'z80-global-label)
(defvar z80-local-label-face 'z80-local-label)
(defvar z80-global-data-label-face 'z80-global-data-label)
(defvar z80-local-data-label-face 'z80-local-data-label)
(defvar z80-keyword-face 'font-lock-keyword-face)
(defvar z80-types-face 'font-lock-type-face)
(defvar z80-constant-face 'font-lock-constant-face)
(defvar z80-variable-face 'font-lock-variable-name-face)
(defvar z80-builtint-face 'font-lock-builtin-face)


(defvar z80-font-lock-defaults
   `((,z80-local-data-regexp 2 z80-local-data-label-face)
     (,z80-global-data-regexp 2 z80-global-data-label-face)
     (,z80-local-label-regexp . z80-local-label-face)
     (,z80-global-label-regexp . z80-global-label-face)
     (,z80-types-regexp . z80-types-face)
     (,z80-register-regexp . z80-registers-face)
     (,z80-integer-regexp . z80-constant-face)
     (,z80-builtint-regexp . z80-builtint-face)
     (,z80-opcodes-regexp . z80-keyword-face)
     (,z80-sym-regexp . z80-variable-face)))






(defun z80-colon ()
  "Insert a colon; if it follows a label, indent the line."
  (interactive)
  (let ((labelp nil))
    (save-excursion
      (skip-syntax-backward "w_")
      (skip-syntax-backward " ")
      (if (setq labelp (bolp)) (delete-horizontal-space)))
    (call-interactively 'self-insert-command)
    (when labelp
      (z80-indent-line))))





(defun z80-beginning-of-defun (&optional arg)
  "Move backward to the beginning of a defun.
Every top level declaration that contains a brace paren block is
considered to be a defun.

With a positive argument, move backward that many defuns.  A negative
argument -N means move forward to the Nth following beginning.  Return
t unless search stops due to beginning or end of buffer."
  (interactive "p")
  (or arg (setq arg 1))
  (cond
   ;; Search backward
   ((> arg 0)
    (while (and (> arg 0)
                (search-backward-regexp z80-defun-regexp nil t))
      (setq arg (- arg 1))
      (goto-char (match-end 0))
      (while (not (equal (char-after) ?:))
        (backward-char))
      (beginning-of-line)))

   ;; search forward
   ((< arg 0)
    (while (and (< arg 0)
                (search-forward-regexp z80-defun-regexp nil t))
      (setq arg (+ arg 1))
      (goto-char (match-end 0))
      (while (not (equal (char-after) ?:))
        (backward-char))
      (beginning-of-line))))

  (zerop arg))





(defun z80-end-of-defun (&optional arg)
  "Skip to the end of the current routine."
  (interactive "p")
  (or arg (setq arg 1))
  (let ((begin nil)
        (end nil))
    (cond
     ((< arg  0)
      (while (and (< arg 0)
                  (search-backward-regexp z80-global-label-regexp nil t))
        (setq arg (+ arg 1))
        (goto-char (match-end 0))
        (forward-line -1))

      (while (or (looking-at "^\\s *\n")
                 (looking-at "^;;;"))
        (forward-line -1))
      (forward-line))

     ((> arg  0)
      (forward-line)
      (while (and (> arg 0)
                  (search-forward-regexp z80-global-label-regexp nil t))
        (setq begin (match-beginning 0))
        (setq end (match-end 0))
        (goto-char begin)
        (forward-line -1)

        (while (or (looking-at "^\\s *\n")
                   (looking-at "^;;;"))
          (forward-line -1))

        (if (and (looking-at (concat "^\\s *" z80-opcodes-regexp))
                 (not (looking-at (concat "^\\s *" z80-opcode-return-regexp))))
            (goto-char end)
          (setq arg (- arg 1))
          (end-of-line))))))

  (zerop arg))




(defun z80-comment nil
  "Helper function which helps to locate where begins comments."
  (save-excursion
    (if (search-forward ";" nil t)
        (point)
      nil)))



(defun z80-delete-whites (num)
  "Helper function, delete NUM (it is a negative value) whitespaces.
In case there isn't NUM blanks delete all blanks except one."

  (let ((goal (+ (current-column) num)))
    (while (and (< goal (current-column))
                (or (equal (char-before (- (point) 1)) ?\ )
                    (equal (char-before (- (point) 1)) ?\t)))
      (delete-char -1))
    ;; we can delete a \t, so we need insert again spaces
    (when (> goal (current-column)))
      (insert-char ? (- goal (current-column)))))



(defun z80-adjust-spaces (regex column bound)
  "Helper function, adjust spaces before REGEX.

Search regexp and try to adjust to the position COLUMN.
If BOUND if diferent nil then limit the regexp search
to avoid search inside of comments."
  (let ((limit nil))
    (if bound
      (setq limit (z80-comment)))
    (when (search-forward-regexp regex limit t)
      (goto-char (match-beginning 0))
      (let ((num-spaces (- column (current-column))))
        (cond ((> num-spaces 0)
               (insert-char ? num-spaces))
              ((< num-spaces 0)
               (z80-delete-whites num-spaces))))
      (search-forward-regexp regex))))



(defun z80-indent-line nil
  "Indent all fields in a line.

If line begins with ;;; indent to the left margin
elseif line begins with ;; indent to z80-opcode-columns
else indent label to the left margin, opcode to z80-opcode-columns,
operand to z80-operand-column and comment to z80-comment-columns."
  (save-excursion
    (save-restriction
      (narrow-to-region
       (progn (beginning-of-line) (point))
       (progn (end-of-line) (point)))
      (goto-char (point-min))

      (cond
       ;; line begin with a line comment
       ((looking-at "^\\(\\s *\\);;;")
        (delete-char (- (match-end 1)(match-beginning 1))))
       ;; line begin with a block comment
       ((looking-at "^\\(\\s *\\);;[^;]")
        (z80-adjust-spaces ";" z80-opcode-column nil))
       ;; usual case: label: opcode operand ;comment
       (t (z80-adjust-spaces z80-label-regexp 0 t)
          (z80-adjust-spaces z80-expresion-regexp z80-opcode-column t)
          (z80-adjust-spaces "[^\\s ;]" z80-argument-column t)
          (z80-adjust-spaces ";" z80-comment-column nil)))))

  ;; And now think where we must put the cursor
  (cond ((< (current-column) z80-opcode-column)
         (move-to-column z80-opcode-column t))
        ((< (current-column) z80-argument-column)
         (move-to-column z80-argument-column t))
        (t  (move-to-column z80-comment-column t))))




(defun z80-indent-region (&optional from to)
  "Indent all fields in a region.

If optional FROM and TO are given, they are used instead of point
and mark for the region's end points."
  (interactive)
  (unless from (setq from (region-beginning)))
  (unless to (setq to (region-end)))
  (combine-after-change-calls
    (save-excursion
      (save-restriction
        (narrow-to-region from to)
        (goto-char (point-min))
        (while (not (equal (point) (point-max)))
          (z80-indent-line)
          (forward-line))))))





(defun z80-comment-dwim (arg)
  "Comment-dwin function for z80 mode.

If region is active call to usual `comment-dwin'.
Else, if the line is blank then add a block comment.
Else, if there is not a comment in the line, then add it
in the `z80-comment-column'.
Else, if the line begins with a line comment, then add
a carriage return and insert a new line comment.
Else, if there is a blank usual comment, then delete it
delete the ; and add a newline and add a block comment.
Argument ARG: Parameter of comment-dwin."
  (interactive "*P")
  (comment-normalize-vars)

  (if (region-active-p) (comment-dwim arg)
    (z80-indent-line)
    (beginning-of-line)

    (cond
     ;; A blank line, so we want add a block comment"
     ((looking-at "^\\s *\n")
      (move-to-column z80-opcode-column t)
      (insert-string ";; "))

     ;; There isn't comment in this line so we have to add one
     ((looking-at "^[^;]*$")
      (move-to-column z80-comment-column t)
      (insert-string "; "))

     ;; If there is a blank line comment, add a new line and comment line
     ((looking-at "^;;;")
      (end-of-line)
      (insert-string "\n;;; "))

     ;; if there is a blank comment, delete the ;
     ;; and add a newline and add a block comment
     ((looking-at "^[^;]*\\(;\\s *\\)\n")
      (delete-region (match-beginning 1) (match-end 1))
      (beginning-of-line)
      (insert-char ?\n 1)
      (forward-line -1)
      (insert-char ?\  z80-opcode-column)
      (insert-string ";; "))

     ;; if there is a block comment without text, transform it
     ;; into a line comment
     ((looking-at "^\\(\\s *\\;;\\s *\\)\n")
      (delete-region (match-beginning 1) (match-end 1))
      (insert-string ";;; ")))))




(defvar z80-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\;  "< b" st)
    (modify-syntax-entry ?\n  "> b" st)
    (modify-syntax-entry ?\t  "-"   st)
    (modify-syntax-entry ?_   "w"   st)
    (modify-syntax-entry ?\"  "\""  st)
    st)
  "Syntax table used in z80 mode.")


(defvar z80-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map ":"         'z80-colon)
    (define-key map "\C-j"      'newline-and-indent)
    (define-key map "\C-m"      'newline-and-indent)
    (define-key map "\C-c;"     'comment-region)
    map)
  "KeyMap for z80 mode.")

(defun z80-semantic-support nil
  "Add support for semantics using ctags."
  (require 'semantic-ectag-lang)
  (semantic-ectag-add-language-support z80-mode "asm" "dlmt")
  (add-hook 'z80-mode-hook 'semantic-ectag-simple-setup))



;;;###autoload
(define-derived-mode z80-mode prog-mode "z80"
  (interactive)
  (setq mode-name "z80")
  (setq major-mode 'asm-mode)
  (set (make-local-variable 'font-lock-defaults)
       '(z80-font-lock-defaults nil t))

  (set (make-local-variable 'indent-line-function) 'z80-indent-line)
  (set (make-local-variable 'indent-region-function) 'z80-indent-region)
  (set (make-local-variable 'tab-always-indent) t)
  (set (make-local-variable 'comment-column) z80-comment-column)
  (set (make-local-variable 'beginning-of-defun-function)
       'z80-beginning-of-defun)
  (set (make-local-variable 'end-of-defun-function)
       'z80-end-of-defun)

  (set (make-local-variable 'comment-start) ";")
  (set (make-local-variable 'comment-end) "")
  (set (make-local-variable 'comment-add) 2)
  (set-syntax-table (make-syntax-table z80-mode-syntax-table))
  (use-local-map (nconc (make-sparse-keymap) z80-mode-map))
  (define-key z80-mode-map [remap comment-dwim] 'z80-comment-dwim))



(provide 'z80)

;;; z80.el ends here
