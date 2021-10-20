;;; ivylang-mode.el --- A major mode for Ivylang source files

;; Copyright (c) Microsoft Corporation

;; Author: Microsoft
;; Version: 1.0
;; URL: http://github.com/Microsoft/ivylang
;; Keywords: languages, ivylang

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;; DEALINGS IN THE SOFTWARE.

;;; Commentary:

;; A major mode for editing Ivylang source files.

;; To use this, place this file somewhere in your emacs load-path and
;; add this code to your emacs init file:

;; (add-to-list 'auto-mode-alist '("\\.ivylang\\'" . ivylang-mode))
;; (autoload 'ivylang-mode "ivylang" "Major mode for editing Ivylang code" t)

;;; Code:

(defconst ivylang-keywords
  '("relation"
    "individual"
    "axiom"
    "conjecture"
    "schema"
    "instantiate"
    "derived"
    "concept"
    "init"
    "action"
    "state"
    "assume"
    "assert"
    "set"
    "null"
    "old"
    "from"
    "update"
    "params"
    "in"
    "match"
    "ensures"
    "requires"
    "modifies"
    "true"
    "false"
    "fresh"
    "module"
    "type"
    "if"
    "else"
    "local"
    "let"
    "call"
    "entry"
    "macro"
    "interpret"
    "forall"
    "exists"
    "returns"
    "mixin"
    "before"
    "after"
    "isolate"
    "with"
    "export"
    "delegate"
    "import"
    "include"
    "progress"
    "rely"
    "mixord"
    "extract"
    "function"
    "class"
    "object"
    "method"
    "execute"
    "destructor"
    "some"
    "maximizing"
    "maximizing"
    "private"
    "implement"
    "using"
    "property"
    "while"
    "invariant"
    "struct"
    "definition"
    "ghost"
    "alias"
    "trusted"
    "this"
    "var"
    "instance"
    "attribute"
    "variant"
    "of"
    "proof"
    "specification"
    "implementation"
    "decreases"
    "require"
    "ensure"
    "around"
    "parameter"
    "autoinstance"
    "temporal"
    "tactic"
    "theorem"
    "apply"
    "named"
    "global"
    "process"
))

(defconst ivylang-types '("bool" "int" "bv"))
(defconst ivylang-constants '())
(defconst ivylang-events '())
(defconst ivylang-functions '())

(defconst ivylang-keywords-regexp (regexp-opt ivylang-keywords 'words))
(defconst ivylang-type-regexp (regexp-opt ivylang-types 'words))
(defconst ivylang-constant-regexp (regexp-opt ivylang-constants 'words))
(defconst ivylang-event-regexp (regexp-opt ivylang-events 'words))
(defconst ivylang-functions-regexp (regexp-opt ivylang-functions 'words))

(defconst ivylang-font-lock-keywords
  `((,ivylang-type-regexp . font-lock-type-face)
    (,ivylang-constant-regexp . font-lock-constant-face)
    (,ivylang-event-regexp . font-lock-builtin-face)
    (,ivylang-functions-regexp . font-lock-function-name-face)
    (,ivylang-keywords-regexp . font-lock-keyword-face)))

(defgroup ivylang nil
  "Major mode for Ivylang source files."
  :group 'languages)

(defcustom ivylang-indent-offset 4
  "Indentation offset for `ivylang-mode'."
  :type 'integer
  :group 'ivylang)

(defun ivylang-indent-line ()
  "Indent current line for `ivylang-mode'."
  (interactive)
  (let ((indent-col 0))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list 1)
            (when (looking-at "[[{]")
              (setq indent-col (+ indent-col ivylang-indent-offset))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at "[]}]") (>= indent-col ivylang-indent-offset))
        (setq indent-col (- indent-col ivylang-indent-offset))))
    (indent-line-to indent-col)))

(defvar ivylang-syntax-table
  (let ((synTable (make-syntax-table)))

    ;; bash style comment: “# …”
    (modify-syntax-entry ?# "< b" synTable)
    (modify-syntax-entry ?\n "> b" synTable)

    synTable)
  "Syntax table for `ivylang-mode'.")

;;;###autoload
(define-derived-mode ivylang-mode text-mode "Ivylang"
  "Major mode for editing Ivylang files."
  (make-local-variable 'ivylang-indent-offset)
  (set (make-local-variable 'indent-line-function) 'ivylang-indent-line)
  (set (make-local-variable 'comment-start) "#")
  (set-syntax-table ivylang-syntax-table)
  (setq font-lock-defaults '((ivylang-font-lock-keywords))))

(provide 'ivylang-mode)
;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; ivylang-mode.el ends here
