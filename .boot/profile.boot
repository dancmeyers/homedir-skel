(set-env! :dependencies '[[onetom/boot-lein-generate "0.1.3" :scope "test"]
                          [tolitius/boot-check "0.1.7"]])

(require '[boot.lein]
         '[tolitius.boot-check :as check])

(deftask check-source []
  (comp
    (check/with-bikeshed)
    (check/with-eastwood)
    (check/with-kibit)))
