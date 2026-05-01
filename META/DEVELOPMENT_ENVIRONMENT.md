# Development Environment and Execution Boundary

This file records practical execution-boundary rules for the
nicodic_archiver workspace.

It is workflow memory for humans and advisor AIs.

It is not product code.
It is not a migration file.
It is not a deployment script.

--------------------------------------------------

## Environment shape

The practical environment has three layers:

1. Local machine
   - currently a Mac used by the human developer
   - browser checks are performed here

2. Remote host
   - accessed by SSH
   - example:
     `ssh -i LS-Lobster.pem manage@52.69.114.11`

3. Runtime container
   - current known container name:
     `nicodic_archiver_runtime-personal_runtime-1`
   - runtime-facing Python behavior should be checked in this container

Important interpretation:

- the host is not the runtime Python environment
- host-side raw `python3` may lack runtime dependencies
- runtime-facing Python checks should normally run through container exec
- the workspace root helper `./runtime_exec.sh` is the preferred boundary

--------------------------------------------------

## Python execution rule

When checking runtime behavior, scrape behavior, DB behavior, Web smoke
behavior, or archive-read behavior against runtime-like state, prefer
container execution.

Preferred pattern from the workspace root:

`./runtime_exec.sh "python - <<'PY'
print('hello from runtime container')
PY"`

Use host-side raw `python3` only for meta-repository file operations or other
clearly host-local tasks that do not depend on product runtime dependencies.

Examples of host-local tasks:

- editing root meta files
- regenerating snapshots
- simple text processing over meta files

Examples that should prefer container execution:

- importing product modules that need runtime dependencies
- reading runtime SQLite DB through product code
- smoke checking Web app behavior
- checking archive export behavior
- checking scraper/runtime behavior

Reason:

The runtime container has the product dependency environment.
The host Python environment may not have packages such as BeautifulSoup, lxml,
or other dependencies used by the product.

--------------------------------------------------

## Runtime checkout boundary

The sibling runtime checkout may exist at:

`/home/manage/product/nicodic_archiver_runtime`

This checkout is operational / dogfooding state.

It is not one of the Double Helix implementation repositories.

Do not treat it as:

- `copilot/`
- `cursor/`
- the root meta repository

Runtime reflection must not be performed blindly while a long shot or
scrape-like process is active.

Before runtime reflection, check at minimum:

- no `runtime/logs/periodic_once.lock`
- no active `python main.py batch`
- no active `python main.py periodic`
- no active `python main.py periodic-once`

Prefer existing helpers such as:

- `./reflect_runtime.sh`
- `./runtime_exec.sh`

--------------------------------------------------

## Development Web check through SSH port forwarding

When checking a development Web app from the local Mac browser, do not assume
that a server started on the remote host or inside a container is directly
reachable from the Mac browser.

Use SSH port forwarding.

Typical safe pattern:

1. Start the development Web app on the remote side.

   When running inside the runtime container for smoke checking, bind to:

   `0.0.0.0`

   Example container-side server port:

   `58043`

2. Find the container IP on the remote host:

   `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nicodic_archiver_runtime-personal_runtime-1`

3. On the local Mac, open a separate terminal and create an SSH tunnel:

   `ssh -i LS-Lobster.pem -L 58043:<CONTAINER_IP>:58043 manage@52.69.114.11`

4. Open the local browser at:

   `http://127.0.0.1:58043/`

Important notes:

- runtime public Web normally uses a separate published path
- development smoke Web ports should avoid clashing with runtime Web
- current runtime Web has used port `58001`
- development smoke ports such as `58042` or `58043` are preferred
- stop smoke Web processes after checking

--------------------------------------------------

## Editor AI execution boundary

Editor AIs working inside `copilot/` or `cursor/` should primarily edit files.

They should not create virtual environments.

They should not run `pip install`.

They should not invent ad-hoc validation flows.

Validation ownership primarily belongs to the human / reviewer side through
workspace-root helpers such as:

- `./validate_helix.sh`
- `./collect_task_review.sh`
- `./compare_helix.sh`

If an editor AI cannot run validation without trying to create a venv, install
dependencies, or switch environments, it should complete the implementation and
record the validation limitation in its `TASKXXX_report.txt`.

--------------------------------------------------

## Editor report model/version rule

For future tasks, editor AIs should include their model/tool information in
their task report file.

Expected report field:

`Editor AI model: <tool and model/version as reported by the editor>`

Examples:

- `Editor AI model: GitHub Copilot Chat / GPT-5.4`
- `Editor AI model: Cursor / GPT-5.2`
- `Editor AI model: unknown; editor did not expose model/version`

The human/advisor review log should preserve this information when available.

Reason:

Model/version information is useful for later workflow analysis, especially
when comparing Copilot and Cursor behavior across Double Helix tasks.

This model/version record is metadata only.
It must not override design review, validation results, or human judgment.

--------------------------------------------------

## Review-log model/version rule

When writing a review log under `META/review_log/`, include the editor model
information if it is known.

Recommended shape:

`Copilot editor model: ...`
`Cursor editor model: ...`

If the information is unknown, write:

`Copilot editor model: unknown`
`Cursor editor model: unknown`

--------------------------------------------------

## Long-running runtime shots

When a long shot is running, do not assume product main can be reflected safely
into the runtime checkout.

A code-level soft terminate mechanism is preferred for future operation.

Until such a mechanism exists, avoid live-editing running runtime code as a
substitute for a supported shutdown path.

Reason:

A running Python process has already imported its modules.
Editing files on disk usually does not affect the already-running process.
Live patching can also leave runtime state difficult to reason about.

--------------------------------------------------

END
