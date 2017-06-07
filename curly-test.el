;;; curly-test.el --- Tests for Curly package

;;; Commentary:
;;
;; Run with:
;;
;;   $ emacs -batch -l ert -l projectile.el -l curly-test.el -f ert-run-tests-batch-and-exit
;;
;;; Code:

(eval-when-compile
  (require 'cl)
  (require 'subr-x)
  (require 'projectile))

(load-file "curly.el")

(ert-deftest curly-absolute-project-path ()
  (should (string-suffix-p "curly.el/" (curly-absolute-project-path))))

(ert-deftest curly-absolute-dir-path-test ()
  (should (string-suffix-p "curly.el/" (curly-absolute-dir-path))))

(ert-deftest curly-absolute-file-path-test ()
  (should (not (eq nil (curly-absolute-file-path)))))

(ert-deftest curly-project-dir-name-test ()
  (should (equal "curly.el" (curly-project-dir-name))))

(ert-deftest curly-relative-directory-path-test ()
  (should (not (string-blank-p (curly-relative-directory-path)))))

(ert-deftest curly-expand-at ()
  (should (not (string-blank-p (curly-expand "@")))))

(ert-deftest curly-expand-diez ()
  (should (not (string-blank-p (curly-expand "#")))))

(ert-deftest curly-expand-percent ()
  (should (string-blank-p (curly-expand "%"))))

(ert-deftest curly-expand-p ()
  (should (not (string-blank-p (curly-expand "p")))))

(ert-deftest curly-expand-d ()
  (should (not (string-blank-p (curly-expand "d")))))

(ert-deftest curly-expand-f ()
  (should (not (eq nil (curly-expand "f")))))

(ert-deftest curly-expand-l ()
  (should (equal "1" (curly-expand "l"))))

(ert-deftest curly-expand-c ()
  (should (equal "0" (curly-expand "c"))))

(ert-deftest curly-expand-t ()
  (should (equal "1" (curly-expand "t"))))

(ert-deftest curly-expand-nil ()
  (should (equal "" (curly-expand nil))))

(ert-deftest curly-expand-blank ()
  (should (equal "" (curly-expand ""))))

(ert-deftest curly-expand-combined ()
  (should (not (string-blank-p (curly-expand "d/f:l")))))

;;; curly-test.el ends here
