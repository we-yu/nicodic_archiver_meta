# TASK037 nginx prelim publication

## Task
TASK037

Add `nicoarc-prelim.mimizuku.dev` as a bounded third nginx site using the
existing host multi-site + certbot-managed TLS style, while keeping the runtime
Web backend localhost-bound behind nginx and preserving existing public sites.

## Positioning
This is a bounded external publication / ops task.

It changes:
- host nginx multi-site publication state
- public DNS reachability for the preliminary runtime Web FQDN
- certbot-managed TLS coverage for the new preliminary site

It does not change:
- product code
- scrape semantics
- DB semantics
- queue semantics
- scheduler semantics
- Web app semantics
- container topology in product terms
- public-bind policy for the runtime backend

## What changed
Operational result completed outside the product repositories:

- `nicoarc-prelim.mimizuku.dev` DNS now points to the existing host
- host nginx now serves a third site for:
  - `nicoarc-prelim.mimizuku.dev`
- the new site proxies to:
  - `http://127.0.0.1:58001`
- the runtime backend remains localhost-bound behind nginx
- certbot successfully issued and deployed a certificate for:
  - `nicoarc-prelim.mimizuku.dev`
- HTTP to HTTPS redirect is now active for the new site
- the public HTTPS entry now serves the runtime Web top page
- existing sites remained intact:
  - `notes.mimizuku.dev`
  - `sandbox.mimizuku.dev`

## Validation summary
The following practical validation was completed:

1. confirmed existing nginx multi-site baseline for:
   - `notes.mimizuku.dev`
   - `sandbox.mimizuku.dev`
2. confirmed runtime backend reachability on:
   - `127.0.0.1:58001`
3. added and enabled the new nginx site config for:
   - `nicoarc-prelim.mimizuku.dev`
4. confirmed nginx syntax success
5. confirmed host-header HTTP routing to the runtime Web app
6. confirmed public DNS resolution for the new FQDN
7. confirmed certbot certificate issuance and deploy success
8. confirmed HTTPS content reachability for the new site
9. confirmed existing sites still returned healthy responses
10. confirmed certbot scheduled renewal presence
11. confirmed `certbot renew --dry-run` success for:
    - `nicoarc-prelim.mimizuku.dev`
    - `notes.mimizuku.dev`
    - `sandbox.mimizuku.dev`

## Practical result
Current public entry behavior should now be read as:

- public browser access to:
  - `https://nicoarc-prelim.mimizuku.dev`
  reaches the runtime Web top page
- host nginx remains the shared ingress on:
  - `80`
  - `443`
- the runtime backend remains closed behind the host-local proxy port:
  - `127.0.0.1:58001`

## What did not change
This task did not introduce:
- product-feature work
- public bind of the runtime backend
- Docker compose public-bind redesign
- Caddy adoption
- broad infra redesign
- auth / account / abuse-control work
- queue / worker / scheduler redesign
- Web UX redesign

## Interpretation
TASK037 should be read as a successful bounded publication closeout.

It establishes a preliminary public runtime Web entrypoint without changing
product semantics and without widening the backend exposure boundary.

## Meta note
This review log is AI-readable working memory.
It is not authoritative by itself.

Authoritative current state should still be restored from:
- `AI_CONTEXT.md`
- `_AI_RULES.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


