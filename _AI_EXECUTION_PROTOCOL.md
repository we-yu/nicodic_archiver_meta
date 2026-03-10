# AI Execution Protocol

This file defines operational rules for AI when interacting
with this repository and the developer environment.

The goal is to make AI behavior predictable and consistent
across sessions and across different AI systems.

--------------------------------------------------
EDITOR PREFERENCE
--------------------------------------------------

Preferred editor:

vi

Do NOT suggest nano unless explicitly requested.

Example:

vi export_snapshot.sh


--------------------------------------------------
CODE OUTPUT RULE
--------------------------------------------------

When outputting code blocks:

Always end the code with a blank line.

Example:

print("hello")

(blank line)

Reason:

Some configuration formats require a trailing newline.


--------------------------------------------------
COMMAND FORMAT RULE
--------------------------------------------------

When showing shell commands:

Do NOT use "\" line continuation.

Always output commands in a single line.

Bad:

docker run \
  -it \
  image

Good:

docker run -it image


--------------------------------------------------
PATH DISPLAY RULE
--------------------------------------------------

If modifying files outside the project directory,
always show the absolute path.

Example:

/etc/nginx/nginx.conf

If inside the project directory,
relative paths are preferred.

Example:

./export_snapshot.sh
./copilot/main.py

--------------------------------------------------
FILE EDIT GUIDANCE RULE
--------------------------------------------------

When instructing the developer to modify a file,
the AI should normally provide copy-paste-ready text.

Preferred order:

1. show the file path
2. show the exact section to change
3. show the replacement or inserted text
4. if needed, show the full function / block / file text

The AI should avoid vague instructions such as:

"edit this section"
"update the state file"
"add a review log"

unless the exact text is already obvious from the immediately preceding context.

Inside this project, practical editing guidance should favor:
- exact replacement text
- full block examples
- minimal ambiguity

This rule exists because the developer primarily works in a Linux terminal
and ambiguous editing instructions increase mistake risk.

--------------------------------------------------
TERMINAL ASSUMPTION
--------------------------------------------------

The developer primarily uses a Linux terminal.

Commands should be copy-paste friendly.


--------------------------------------------------
SAFE OPERATION RULE
--------------------------------------------------

AI should avoid destructive commands unless necessary.

For example:

rm -rf
sudo system modifications

If such commands are required,
the AI should clearly explain the impact.


--------------------------------------------------
AI ROLE REMINDER
--------------------------------------------------

AI is an advisor.

Human developer is the architect.

AI should suggest improvements but not force changes.


--------------------------------------------------
END
--------------------------------------------------

