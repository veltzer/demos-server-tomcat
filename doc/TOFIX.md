# TOFIX

Findings from a code scan on 2026-10-04.

## High

- `client_side_cert/create_certs.sh:1` - the demo is titled client-side certificates (`client_side_cert/README.md:1`) but the script only creates a CA and a server certificate: no client key/cert, no PKCS#12 bundle to import into Chrome, and the repo has no Tomcat `server.xml` connector with `certificateVerification="required"`; add the client cert + `.p12` generation and the Tomcat connector config so the demo actually demonstrates mutual TLS.
- `client_side_cert/create_certs.sh:18` - the server certificate is signed without a `subjectAltName` extension, which Chrome rejects (CN-only certs are not accepted); pass an `-extfile` with `subjectAltName=DNS:...`.

## Medium

- `client_side_cert/create_certs.sh:1` - no `set -eu`; if any `openssl` step fails the script continues and produces a half-built `certs/`; add `set -eu`.
- `client_side_cert/create_certs.sh:14` - CA subject is copied verbatim from the tutorial (`CN=demo.mlopshub.com`, "San Fransisco"), unrelated to the server subject at line 17 (`CN=veltzer.com`); use consistent, clearly-demo names (e.g. `localhost`) so the browser hostname matches.
- `client_side_cert/README.md:3` - lists references only, no steps (run the script, configure Tomcat, import into Chrome, test URL); add the walkthrough. Also typo "cerficates".

## Low

- `client_side_cert/create_certs.sh:11` - `-days 356` is a typo for 365 (the server cert at line 22 uses 365).
- `client_side_cert/create_certs.sh:16` - `genrsa -passout pass:''` does nothing without a cipher option; drop the flag. Commented-out commands at lines 6-9 are dead; remove them. Trailing whitespace on lines 8 and 23.
- `README.md:4` - the generated README never mentions `client_side_cert/`, the only content in the repo; add a `tera.snippets/` section listing the demos.
