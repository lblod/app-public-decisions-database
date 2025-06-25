# Changelog
## 1.22.2 (2025-06-25)
- Mega maintenance spree.
  SeeAlso: DL-6663, DL-6662
### deploy notes

```
drc down
```
Remove the version specification (probably it will mention `version: '3.7'`) in the top of the file: `docker-compose.override.yml`.
```
rm data/db/virtuoso.trx # Note: this is hard but not much risk.
drc pull
/bin/bash ./config/scripts/reset-elastic.sh # (until the mu-cli version stabelizes)
# while it's running best disable the syncs
drc stop  op-consumer-for-auth op-consumer files-consumer submissions-consumer
```

## 1.22.1 (2025-06-03)
- Bump ES
### Deploy Notes
```
drc up -d elasticsearch
```
## 1.22.0 (2025-05-07)

- Add new form 'melding interne beslissing tot samenvoeging' [DL-6361]

### Deploy Notes

```
drc restart migrations && drc logs -ft --tail=200 migrations
drc up -d enrich-submission
```

## 1.21.0 (2025-04-24)
- Update multiple forms. [DL-6602] [DL-6486] [DL-6487] [DL-6488]
### Deploy Notes
#### For updating the forms
```
drc restart migrations && drc logs -ft --tail=200 migrations
drc up -d enrich-submission
```
## 1.20.0 (2025-03-25)
- Add missing compose keys. [DL-6490]
- Reorganize delta consumers config to harmonize with the ecosystem
### Deploy Notes
Before running the command, make sure to remove `restart: always` from `files-consumer` inside `docker-compose.override.yml`.
```
drc up -d submissions-consumer files-consumer op-consumer op-consumer-for-auth
```

## 1.19.7 (2025-02-26)

- Update semantic forms with `Opdrachthoudende vereniging met private deelname` classification. [DL-6447]
- Add op-consumer-for-auth [DL-6458]

### Deploy Notes

#### Update Semantic Forms

```
drc restart migrations && drc logs -ft --tail=200 migrations
```
```
drc restart resource cache
```
```
drc up -d enrich-submission
```

#### Add second op-consumer

```
drc down
```

Update the `docker-compose.override.yml`, make sure to rename the first op-consumer since it had a rename, depending on the environment the first op-consumer should/should not run again (dev/qa already had an initialSync done):
```
  op-consumer:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # or another endpoint
      DCR_LANDING_ZONE_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_REMAPPING_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
  op-consumer-for-auth:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # choose the correct endpoint
      DCR_LANDING_ZONE_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_REMAPPING_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
```

Then:
```
drc up -d virtuoso database op-consumer-for-auth
# when deploying to prod, op-consumer also needs to run
# drc up -d virtuoso database op-consumer op-consumer-for-auth
```
After the initialSync job is done, update the `docker-compose.override.yml`:
```
  op-consumer:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # or another endpoint
      DCR_LANDING_ZONE_DATABASE: "database"
      DCR_REMAPPING_DATABASE: "database"
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
  op-consumer-for-auth:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # choose the correct endpoint
      DCR_LANDING_ZONE_DATABASE: "database"
      DCR_REMAPPING_DATABASE: "database"
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
```

```
drc up -d
```

## 1.19.6 (2025-02-13)
- Add op-public-consumer [DL-6324]

### Deploy Notes
```
drc down
```

Update the `docker-compose.override.yml`:
```
  op-public-consumer:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # choose the correct endpoint
      DCR_LANDING_ZONE_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_REMAPPING_DATABASE: "virtuoso" # for the initial sync, we go directly to virtuoso
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
```

Then:
```
drc up -d migrations && drc logs -ft --tail=200 migrations
# Wait until migrations are finished
drc up -d database op-public-consumer
```
After the initialSync job is done, update the `docker-compose.override.yml`:
```
  op-public-consumer:
    environment:
      DCR_SYNC_BASE_URL: "https://organisaties.abb.vlaanderen.be" # choose the correct endpoint
      DCR_LANDING_ZONE_DATABASE: "database"
      DCR_REMAPPING_DATABASE: "database"
      DCR_DISABLE_DELTA_INGEST: "false"
      DCR_DISABLE_INITIAL_SYNC: "false"
```

```
drc up -d
```

## 1.19.5 (2025-01-22)
- Add Jaarrekening PEVA form [DL-6284]
## 1.19.4 (2024-12-13)
- New semantic form `Kerkenbeleidsplan`
- New semantic forms for cross referencing
## 1.19.3 (2024-10-13)
### Toezicht
 - Update URI form "Aangewezen Burgemeester" [DL-6298]

### Deploy notes
```
drc restart migrations; drc up -d enrich-submission
```
## 1.19.2 (2024-10-11)

- Bump `enrich-submission-service` to latest version
- Updated to new semantic form file

## 1.19.1 (2024-05-29)
  - Fix custom info label field in forms LEKP-rapport - Melding correctie authentieke bron and LEKP-rapport - Toelichting Lokaal Bestuur (DL-5934)
### Deploy Notes
  - `drc up -d enrich-submission; drc restart migrations resource cache`
## 1.19.0 (2024-05-16)

### General
- Update forms
  - Adjust LEKP rapport Klimaattafels (DL-5832)
  - Add new LEKP rapport Wijkverbeteringscontract (DL-5829)

### Deploy Notes
- `drc up -d enrich-submission; drc restart migrations resource cache`
## 1.18.0 (2024-03-14)
- Update forms
  - Adding new form Aanduiding en eedaflegging van de aangewezen burgemeester (DL-5669)
  - Adding new form Strandconcessies - reddingsdiensten kustgemeenten (DL-5625)
  - Adding new form Melding onvolledigheid inzending eredienstbestuur (DL-5643)
  - Adding new form Opstart beroepsprocedure naar aanleiding van een beslissing (DL-5646)
  - Adding informational text to forms to minimize usage of the wrong forms (DL-5665)
  - Adding new form Afschrift erkenningszoekende besturen (DL-5670)
- Frontend [v1.8.0](https://github.com/lblod/frontend-public-decisions/blob/master/CHANGELOG.md#v180-2024-03-13) (DL-5735)
### Deploy instructions
- drc up -d enrich-submission frontend; drc restart migrations resource cache
## 1.17.0 (2024-01-12)
- Update forms
    - New forms LEKP Collectieve Energiebesparende Renovatie, Fietspaden, Sloopbeleidsplan
    - New forms Niet-bindend advies op statuten and Niet-bindend advies op oprichting
    - Change form LEKP Melding correctie authentieke bron, removed field "type correctie"
- Bump frontend (ACM/IDM change), see https://github.com/lblod/frontend-public-decisions/blob/master/CHANGELOG.md#v170-2024-01-05
### Deploy instructions
- drc up -d enrich-submission frontend; drc restart migrations resource cache dispatcher
## 1.16.0 (2023-11-15)
- update forms
### Deploy instructions
- drc up -d enrich-submission; drc restart migrations resource cache
## 1.15.0 (2023-11-02)
- bump-consumer
## 1.14.0 (2023-10-17)
- update forms
### Deploy instructions
- drc restart migrations
## 1.13.0 (2023-06-30)
- added new forms
- update organen bestuurslabels
## 1.12.0 (2023-05-05)
- added VVSG
## 1.11.0 (2023-04-24)
- update forms
## 1.10.1 (2023-04-08)
- adjusted schorsing beslissing eredienstbesturen form for deputatie
## 1.10.0 (2023-02-08)
- update forms
## 1.9.1 (2023-01-26)
- revert additive indexes setting
## 1.9.0 (2023-01-25)
- new updated forms
- update ES config (needs re-index)
## 1.8.0 (2022-11-08)
- new updated forms
## 1.7.2 (2022-10-20)
- fix forms
## 1.7.1 (2022-10-20)
- bump consumer
## 1.7.0 (2022-10-20)
- bump consumer
- added new formsp
## 1.6.0 (2022-10-17)
- bump consumer
## 1.5.1 (2022-09-29)
- Update OVO code kabinet Somers
## 1.5.0 (2022-09-27)
- feature: update frontend to v1.5.0
    - replace some outdated links and text
    - add a favicon
    - drop IE11 support
    - modernize the login button setup
    - maintenance work
## 1.4.0 (2022-07-27)
- update forms
## 1.3.1 (2022-06-22)
- hotfix: tweak dispatcher rules for more variations in browser-requests with regard to the download attribute.
## 1.3.0 (2022-05-18)
- feature: update frontend to v1.4.0
    - Update Appuniversum to the latest version
    - Update ember-submission-form-fields to the latest version
    - textual improvements
- feature: new "erediensten" forms
## 1.2.2 (2022-04-15)
- fix: bump frontend
## 1.2.1 (2022-04-15)
- fix: vo-entiteiten in correct graph
- fix: configurable frontend on startup
## 1.2.0 (2022-04-04)
- Add vo-entiteiten migration
## 1.1.0 (2022-03-01)
- documentation updates
- minor fixes labels
## 1.0.0 (2022-03-01)
- initial release
## 0.3.2 (2022-02-24)
- fix broken form
## 0.3.1 (2022-02-23)
- fix broken form
## 0.3.0 (2022-02-18)
- Prepare ACM/IDM login
- Latest version of the forms
- Various improvements to easy the delta-consuming process
## 0.2.0 (2022-01-27)
### :sunrise: Show ourselves to the world
- Go to production
