(define-resource gebruiker ()
  :class (s-prefix "foaf:Person")
  :resource-base (s-url "http://data.lblod.info/id/gebruiker/")
  :properties `((:voornaam :string ,(s-prefix "foaf:firstName"))
                (:achternaam :string ,(s-prefix "foaf:familyName"))
                (:rijksregister-nummer :string ,(s-prefix "dct:identifier")))
  :has-many `((account :via ,(s-prefix "foaf:account")
                       :as "account")
              (bestuurseenheid :via ,(s-prefix "foaf:member")
                              :as "bestuurseenheden")
              (search-query :via ,(s-prefix "searchToezicht:hasSearchQuery")
                              :as "search-queries")
             )
  :features `(include-uri)
  :on-path "gebruikers"
)

(define-resource account ()
  :class (s-prefix "foaf:OnlineAccount")
  :resource-base (s-url "http://data.lblod.info/id/account/")
  :properties `((:provider :via ,(s-prefix "foaf:accountServiceHomepage"))
                (:vo-id :via ,(s-prefix "dct:identifier")))
  :has-one `((gebruiker
              :via ,(s-prefix "foaf:account")
              :inverse t
              :as "gebruiker")
             (user
              :via ,(s-prefix "foaf:account")
              :inverse t
              :as "user"))
  :has-many `((group :via ,(s-prefix "foaf:member")
                         :as "groups"))
  :on-path "accounts"
)

(define-resource user ()
  :class (s-prefix "foaf:Person")
  :properties `((:first-name :string ,(s-prefix "foaf:firstName"))
                (:family-name :string ,(s-prefix "foaf:familyName")))
  :has-many `((account
               :via ,(s-prefix "foaf:account")
               :as "accounts")
              (group
               :via ,(s-prefix "foaf:member")
               :as "groups"))
  :resource-base (s-url "http://data.lblod.info/id/gebruiker/")
  :on-path "users")


(define-resource group ()
  :class (s-prefix "besluit:Bestuurseenheid")
  :properties `((:name :string ,(s-prefix "skos:prefLabel")))
  :has-one `((administrative-unit-classification-codes
              :via ,(s-prefix "org:classification")
              :as "classification"))
  :resource-base (s-url "http://data.lblod.info/id/bestuurseenheden/")
  :on-path "groups")