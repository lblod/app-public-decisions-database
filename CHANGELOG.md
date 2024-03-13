# Changelog
## Unreleased
- Frontend [v1.8.0](https://github.com/lblod/frontend-public-decisions/blob/master/CHANGELOG.md#v180-2024-03-13) (DL-5735)
### Deploy instructions
- drc up -d frontend
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
