(define-library (srfi 13)
  (export
   ;; S7RS defines the following functions that are in the SRFI:
   ;; string string->list string-append list->string string->list
   ;; substring make-string string-length string-ref string-copy
   ;; string-copy! string-fill!
   string-null? string-every string-any string-tabulate string-join string-copy!
   reverse-list->string string-join string-take string-take-right
   string-drop string-drop-right
   string-pad  string-pad-right
   string-trim string-trim-right string-trim-both
   string-fill! string-compare string-compare-ci

   ;; The string and string-ci comparison operators are defined in S7RS
   ;; as string=? and string-ci=? instead of string= and string-ci=.
   ;; Because the standard effectively superceeds the SRFI, converting
   ;; the missing <> comparison operator to use the <>? R7RS naming convention.
   string<>? string-ci<>?

   string-hash  string-hash-ci
   string-prefix-length string-suffix-length
   string-prefix-length-ci string-suffix-length-ci
   string-prefix? string-suffix?
   string-prefix-ci? string-suffix-ci?
   string-index string-index-right
   string-skip string-skip-right
   string-count
   string-contains string-contains-ci
   string-reverse string-reverse!
   string-concatenate
   string-concatenate/shared string-append/shared
   string-concatenate-reverse string-concatenate-reverse/shared
   string-map string-map!
   string-fold string-fold-right
   string-unfold string-unfold-right
   string-for-each string-for-each-index
   xsubstring string-xcopy! string-replace string-tokenize string-filter
   string-delete string-parse-start+end string-parse-final-start+end
   let-string-start+end check-substring-spec
   substring-spec-ok? make-kmp-restart-vector kmp-step string-kmp-partial-search
   )
  (import
   (except (scheme base) map member assoc)
   (scheme case-lambda)
   (scheme cxr)
   (srfi 8)
   (srfi aux))
  (begin
    (define-check-arg check-arg))
  (include "13.body.scm"))
