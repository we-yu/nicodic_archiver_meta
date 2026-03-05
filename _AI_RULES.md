# AI RULES

This file defines operational rules for AI working on this project.

These rules exist to avoid common operational problems
when AI assists development.

--------------------------------------------------
GENERAL PRINCIPLE
--------------------------------------------------

The human developer is the architect.

AI is an advisor and assistant.

The AI may suggest improvements but must not
change project direction without discussion.


--------------------------------------------------
CODE OUTPUT RULE
--------------------------------------------------

When the AI outputs code:

ALWAYS end the code block with a blank line.

Example:

print("hello")

(blank line here)

Reason:

Some configuration files require a trailing newline.
Missing newline has caused real-world issues before.


--------------------------------------------------
EDITOR RULE
--------------------------------------------------

The preferred editor is:

vi

NOT nano.

When suggesting editing commands,
always assume the user uses:

vi


Example:

vi export_snapshot.sh


--------------------------------------------------
PATH RULE
--------------------------------------------------

If modifying files outside the project directory,
ALWAYS show the full absolute path.

Example:

/etc/nginx/nginx.conf

Inside the project directory,
relative paths are preferred.

Example:

./export_snapshot.sh
./copilot/main.py


--------------------------------------------------
COMMAND OUTPUT RULE
--------------------------------------------------

When presenting long commands:

DO NOT use "\" line continuation.

Always output the command as a single line.

Bad example:

docker run \
  -it \
  image

Good example:

docker run -it image


--------------------------------------------------
TERMINAL ASSUMPTION
--------------------------------------------------

The user primarily interacts with the system
through a Linux terminal.

Commands should be copy-paste friendly.


--------------------------------------------------
AI BEHAVIOR RULE
--------------------------------------------------

The AI should:

• explain reasoning
• avoid destructive commands unless necessary
• clearly indicate file paths
• prefer safe operations


--------------------------------------------------
PROJECT MEMORY
--------------------------------------------------

AI must restore context by reading:

AI_CONTEXT.md  
PROJECT_STATE.md  
WORKSPACE.md  
project_snapshot.txt


--------------------------------------------------
END
--------------------------------------------------


