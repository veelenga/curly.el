;;; curly.el --- Straight way to work with current file locations. -*- lexical-binding: t; -*-

;; Copyright © 2017 Vitalii Elenhaupt <velenhaupt@gmail.com>
;; Author: Vitalii Elenhaupt
;; URL: https://github.com/veelenga/curly.el
;; Keywords: convenience
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4") (projectile "0.14.0"))

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; https://github.com/veelenga/bin/blob/master/curly.el/logo.png
;;
;; Simple plugin that can format and copy file location based on the available locators.
;;
;; ### Usage
;;
;; Run interactive function `curly-copy-loc` to create and copy file location you need.
;;
;; Available locators:
;;
;;  * `@` - absolute path to the current project
;;  * `#` - absolute path to the current directory
;;  * `%` - absolute path to the current file
;;
;;  * `p` - project's root directory name
;;  * `d` - relative path to the current directory
;;  * `f` - relative path to the current file
;;
;;  * `l` - line number
;;  * `c` - column number
;;  * `t` - point number
;;
;; For example, if you need to copy a relative path to the current file with a line
;; number, use `(curly-copy-loc "f:l")`
;;
;;; Code:

(eval-when-compile
  (require 'cl-lib)
  (require 'projectile))

(defgroup curly nil
  "Straight way to work with current file locations."
  :prefix "curly-"
  :group 'applications)

(defconst curly-version "0.1.0")

(cl-defun curly-expand-token (token)
  (cl-case token
    (?@ (curly-absolute-project-path))
    (?# (curly-absolute-dir-path))
    (?% (curly-absolute-file-path))
    (?p (curly-project-dir-name))
    (?d (curly-relative-directory-path))
    (?f (curly-relative-file-path))
    (?l (int-to-string (line-number-at-pos)))
    (?c (int-to-string (current-column)))
    (?t (int-to-string (point)))
    (otherwise (char-to-string token))))

(cl-defun curly-absolute-project-path ()
  (projectile-project-root))

(cl-defun curly-absolute-dir-path ()
  default-directory)

(cl-defun curly-absolute-file-path ()
  (or (buffer-file-name) ""))

(cl-defun curly-project-dir-name ()
  (file-name-nondirectory
   (directory-file-name
    (curly-absolute-project-path))))

(cl-defun curly-relative-directory-path ()
  (curly-strip-project-path (curly-absolute-dir-path)))

(cl-defun curly-relative-file-path ()
  (curly-strip-project-path (curly-absolute-file-path)))

(cl-defun curly-strip-project-path (absolute-path)
  (replace-regexp-in-string
   (curly-absolute-project-path) "" absolute-path))

(cl-defun curly-read-input ()
  (list (read-string "
  Format a location using locators:

    @/p - absolute/relative path to the current project
    #/d - absolute/relative path to the current directory
    %/f - absolute/relative path to the current file

    l/c/t - line/column/point number

    i.e. 'd/f:l'

    Enter your input: ")))

(defun curly-expand (input)
  "Expand INPUT using file locators."
  (apply 'concat
         (mapcar 'curly-expand-token (string-to-list input))))

;;;###autoload
(defun curly-copy-loc (input)
  "Format and copy file location based on user INPUT."
  (interactive (curly-read-input))
  (let ((loc (curly-expand input)))
    (message (kill-new loc))))


(provide 'curly)
;;; curly.el ends here
