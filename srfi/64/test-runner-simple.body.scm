;; Copyright (c) 2005, 2006, 2007, 2012, 2013 Per Bothner
;; Added "full" support for Chicken, Gauche, Guile and SISC.
;;   Alex Shinn, Copyright (c) 2005.
;; Modified for Scheme Spheres by Álvaro Castro-Castilla, Copyright (c) 2012.
;; Support for Guile 2 by Mark H Weaver <mhw@netris.org>, Copyright (c) 2014.
;; Refactored by Taylan Ulrich Bayırlı/Kammer, Copyright (c) 2014, 2015.
;;
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
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(define (test-runner-simple)
  (let ((runner (test-runner-null)))
    (test-runner-reset runner)
    (test-runner-on-group-begin! runner test-on-group-begin-simple)
    (test-runner-on-group-end! runner test-on-group-end-simple)
    (test-runner-on-final! runner test-on-final-simple)
    (test-runner-on-test-begin! runner test-on-test-begin-simple)
    (test-runner-on-test-end! runner test-on-test-end-simple)
    (test-runner-on-bad-count! runner test-on-bad-count-simple)
    (test-runner-on-bad-end-name! runner test-on-bad-end-name-simple)
    runner))

(define (test-on-group-begin-simple runner name count)
  (if (null? (test-runner-group-stack runner))
      (format #t "Test suite begin: ~a~%" name)
      (format #t "Group begin: ~a~%" name)))

(define (test-on-group-end-simple runner)
  (let ((name (car (test-runner-group-stack runner))))
    (if (= 1 (length (test-runner-group-stack runner)))
        (format #t "Test suite end: ~a~%" name)
        (format #t "Group end: ~a~%" name))))

(define (test-on-final-simple runner)
  (format #t "Passes:            ~a\n" (test-runner-pass-count runner))
  (format #t "Expected failures: ~a\n" (test-runner-xfail-count runner))
  (format #t "Failures:          ~a\n" (test-runner-fail-count runner))
  (format #t "Unexpected passes: ~a\n" (test-runner-xpass-count runner))
  (format #t "Skipped tests:     ~a~%" (test-runner-skip-count runner)))

(define (test-on-test-begin-simple runner)
  (values))

(define (test-on-test-end-simple runner)
  (define (string-join strings delimiter)
    (if (null? strings)
        ""
        (let loop ((result (car strings))
                   (rest (cdr strings)))
          (if (null? rest)
              result
              (loop (string-append result delimiter (car rest))
                    (cdr rest))))))
  (let* ((result-kind (test-result-kind runner))
         (result-kind-name (case result-kind
                             ((pass) "PASS") ((fail) "FAIL")
                             ((xpass) "XPASS") ((xfail) "XFAIL")
                             ((skip) "SKIP")))
         (name (let ((test-name (test-result-name runner)))
                 (if (string=? "" test-name)
                     (format #f "~a" (test-result-expression runner))
                     test-name)))
         (label (string-join (append (test-runner-group-path runner)
                                     (list name))
                             "/")))
    (format #t "[~a] ~a~%" result-kind-name label)
    (when (memq result-kind '(fail xpass))
      (let ((nil (cons #f #f)))
        (define (found? value)
          (not (eq? nil value)))
        (define (maybe-print value message)
          (when (found? value)
            (format #t message value)))
        (let ((file (test-result-ref runner 'source-file))
              (line (test-result-ref runner 'source-line))
              (expression (test-result-ref runner 'source-form))
              (expected-value (test-result-ref runner 'expected-value nil))
              (actual-value (test-result-ref runner 'actual-value nil))
              (expected-error (test-result-ref runner 'expected-error nil))
              (actual-error (test-result-ref runner 'actual-error nil)))
          (newline)
          (when line
            (format #t "Source:\n~a:~a\n~%" (or file "(unknown file)") line))
          (format #t "Expression:\n~a\n~%" expression)
          (maybe-print expected-value "Expected value:\n~a\n~%")
          (maybe-print expected-error "Expected error:\n~a\n~%")
          (when (or (found? expected-value) (found? expected-error))
            (maybe-print actual-value "Got value:\n~a\n~%"))
          (maybe-print actual-error "Got error:\n~a\n~%"))))))

(define (test-on-bad-count-simple runner count expected-count)
  (format #t "*** Total number of tests was ~a but should be ~a. ***~%"
          count expected-count)
  (format #t "*** Discrepancy indicates testsuite error or exceptions. ***~%"))

(define (test-on-bad-end-name-simple runner begin-name end-name)
  (error (format #f "Test-end \"~a\" does not match test-begin \"~a\"."
                 end-name begin-name)))

;;; test-runner-simple.scm ends here