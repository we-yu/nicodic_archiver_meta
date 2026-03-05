#!/bin/bash

echo "* META INFO * Say to Advisor-AI [Read this file and understand the project.] with output file."

MAIN_OUT="project_snapshot.txt"
KNOWLEDGE_OUT="project_knowledge_snapshot.txt"

rm -f $MAIN_OUT
rm -f $KNOWLEDGE_OUT


########################################
# AI SNAPSHOT (for GPT context restore)
########################################

echo "===== AI BOOTSTRAP =====" >> $MAIN_OUT
cat AI_BOOTSTRAP.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== AI CONTEXT =====" >> $MAIN_OUT
cat AI_CONTEXT.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== AI EXECUTION PROTOCOL =====" >> $MAIN_OUT
cat _AI_EXECUTION_PROTOCOL.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== AI RULES =====" >> $MAIN_OUT
cat _AI_RULES.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== AI DEVELOPMENT MODEL =====" >> $MAIN_OUT
cat _AI_DEVELOPMENT_MODEL.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== AI ORCHESTRATION VISION =====" >> $MAIN_OUT
cat _AI_ORCHESTRATION_VISION.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== PROJECT STATE =====" >> $MAIN_OUT
cat PROJECT_STATE.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== WORKSPACE =====" >> $MAIN_OUT
cat WORKSPACE.md >> $MAIN_OUT
echo "" >> $MAIN_OUT

echo "===== PROJECT SNAPSHOT =====" >> $MAIN_OUT
echo "generated: $(date)" >> $MAIN_OUT
echo "" >> $MAIN_OUT


find . -type f \
! -path "*/.git/*" \
! -path "*/data/*" \
! -path "*/__pycache__/*" \
! -path "*/.pytest_cache/*" \
! -name "project_snapshot.txt" \
! -name "project_knowledge_snapshot.txt" \
| sort | while read file
do
  echo "" >> $MAIN_OUT
  echo "=============================" >> $MAIN_OUT
  echo "FILE: $file" >> $MAIN_OUT
  echo "=============================" >> $MAIN_OUT
  cat "$file" >> $MAIN_OUT
done


########################################
# KNOWLEDGE SNAPSHOT (for GPT Knowledge)
########################################

echo "===== AI DEVELOPMENT MODEL =====" >> $KNOWLEDGE_OUT
cat _AI_DEVELOPMENT_MODEL.md >> $KNOWLEDGE_OUT
echo "" >> $KNOWLEDGE_OUT

echo "===== AI EXECUTION PROTOCOL =====" >> $KNOWLEDGE_OUT
cat _AI_EXECUTION_PROTOCOL.md >> $KNOWLEDGE_OUT
echo "" >> $KNOWLEDGE_OUT

echo "===== AI ORCHESTRATION VISION =====" >> $KNOWLEDGE_OUT
cat _AI_ORCHESTRATION_VISION.md >> $KNOWLEDGE_OUT
echo "" >> $KNOWLEDGE_OUT

echo "===== AI RULES =====" >> $KNOWLEDGE_OUT
cat _AI_RULES.md >> $KNOWLEDGE_OUT
echo "" >> $KNOWLEDGE_OUT


echo "Knowledge snapshot generated."


########################################
# RESULT
########################################

echo ""
echo "Generated files:"
echo "  $MAIN_OUT"
echo "  $KNOWLEDGE_OUT"
echo ""

