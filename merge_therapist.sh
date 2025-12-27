#!/bin/bash
# Merge Conflict Therapist - Because blaming Bob won't fix your code

# Color codes for emotional support
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color (for emotional detachment)

# Check if we're in a git repo (basic sanity check)
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}✗ Not in a git repository. Your feelings are valid, but misplaced.${NC}"
    exit 1
fi

# Check for merge conflicts (the source of all emotional distress)
if ! git diff --name-only --diff-filter=U | grep -q '.'; then
    echo -e "${GREEN}✓ No merge conflicts detected. Go enjoy your coffee.${NC}"
    exit 0
fi

# Therapeutic intervention begins
clear
echo -e "${BLUE}🤝 MERGE CONFLICT THERAPIST SESSION 🤝${NC}"
echo -e "${YELLOW}Let's work through this together. Breathe.${NC}"
echo ""

# Show conflicted files (acknowledge the pain)
echo -e "${YELLOW}Conflicted files needing attention:${NC}"
git diff --name-only --diff-filter=U | while read file; do
    echo -e "  ${RED}•${NC} $file"
done
echo ""

# Offer therapeutic options
echo -e "${YELLOW}Therapeutic options:${NC}"
echo "1) ${GREEN}Accept their changes${NC} (be the bigger person)"
echo "2) ${GREEN}Accept your changes${NC} (stand your ground)"
echo "3) ${GREEN}Open in editor${NC} (face your fears)"
echo "4) ${RED}Abort merge${NC} (run away screaming)"
echo ""

# Get user's emotional state
read -p "How would you like to proceed? [1-4]: " choice
echo ""

case $choice in
    1)
        echo -e "${GREEN}Choosing peace... accepting their changes.${NC}"
        git diff --name-only --diff-filter=U | xargs git checkout --theirs
        echo -e "${GREEN}Conflict resolved. Remember: it's not you, it's git.${NC}"
        ;;
    2)
        echo -e "${GREEN}Trusting yourself... accepting your changes.${NC}"
        git diff --name-only --diff-filter=U | xargs git checkout --ours
        echo -e "${GREEN}Conflict resolved. You do you.${NC}"
        ;;
    3)
        echo -e "${YELLOW}Opening conflicted files. Deep breaths...${NC}"
        git diff --name-only --diff-filter=U | head -1 | xargs ${EDITOR:-vim}
        echo -e "${YELLOW}Remember to 'git add' resolved files when done.${NC}"
        ;;
    4)
        echo -e "${RED}Aborting merge. Sometimes walking away is healthy.${NC}"
        git merge --abort
        echo -e "${RED}Merge aborted. Go pet a dog or something.${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice. Even therapists have boundaries.${NC}"
        exit 1
        ;;
esac

echo -e "\n${BLUE}Session complete. Remember: it's just code.${NC}"
