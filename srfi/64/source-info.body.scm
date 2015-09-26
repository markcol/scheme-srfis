;; Copyright (c) 2015 Taylan Ulrich Bayırlı/Kammer <taylanbayirli@gmail.com>
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

(define (canonical-syntax form arg)
  (cond-expand
   (kawa arg)
   (guile form)
   (else #f)))

(cond-expand
 ((or kawa guile-2)
  (define-syntax source-info
    (lambda (stx)
      (syntax-case stx ()
        ((_ <x>)
         (let* ((stx (canonical-syntax stx (syntax <x>)))
                (file (syntax-source-file stx))
                (line (syntax-source-line stx)))
           (quasisyntax
            (cons (unsyntax file) (unsyntax line)))))))))
 (else
  (define-syntax source-info
    (syntax-rules ()
      ((_ <x>)
       #f)))))

(define (syntax-source-file stx)
  (cond-expand
   (kawa
    (syntax-source stx))
   (guile-2
    (let ((source (syntax-source stx)))
      (and source (assq-ref source 'filename))))
   (else
    #f)))

(define (syntax-source-line stx)
  (cond-expand
   (kawa
    (syntax-line stx))
   (guile-2
    (let ((source (syntax-source stx)))
      (and source (assq-ref source 'line))))
   (else
    #f)))

(define (set-source-info! runner source-info)
  (when source-info
    (test-result-set! runner 'source-file (car source-info))
    (test-result-set! runner 'source-line (cdr source-info))))

;;; source-info.body.scm ends here
