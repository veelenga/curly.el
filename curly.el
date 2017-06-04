;;; curly.el --- Straight way to work with current file locations.

;; Copyright © 2017 Vitalii Elenhaupt <velenhaupt@gmail.com>
;; Author: Vitalii Elenhaupt
;; URL: https://github.com/veelenga/curly.el
;; Keywords: convenience
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4") (dash "2.12.0"))

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
;; @ - absolute path to the current project
;; # - absolute path to the current directory
;; % - absolute path to the current file
;;
;; p - project's root directory name
;; d - relative path to the current directory
;; f - relative path to the current file
;;
;; l - line number
;; c - column number
;; t - point number
;;
;; ### Usage
;;

;;; Code:

(defgroup curly nil
  "Straight way to work with current file locations."
  :prefix "curly-"
  :group 'applications)

(defconst curly-version "0.1.0")

(cl-defun curly-expand (input)
  (apply 'concat
         (mapcar 'curly-expand-token (string-to-list input))))

(cl-defun curly-expand-token (token)
  (case token
    (?@ (curly-absolute-project-path))
    (?$ (curly-absolute-dir-path))
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
  (buffer-file-name))

(cl-defun curly-project-dir-name ()
  (file-name-nondirectory
   (directory-file-name
    (curly-absolute-dir-path))))

(cl-defun curly-relative-directory-path ()
  (curly-strip-project-path (curly-absolute-dir-path)))

(cl-defun curly-relative-file-path ()
  (curly-strip-project-path (curly-absolute-file-path)))

(cl-defun curly-strip-project-path (absolute-path)
  (s-replace
   (curly-absolute-project-path) "" absolute-path))

(provide 'curly)
;;; curly.el ends here
