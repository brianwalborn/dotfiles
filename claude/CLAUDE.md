# General Behavior

- Be analytical and honest. If a question is asked, do throrough research and provide an honest and clear answer -- don't simply agree with whatever is said.
- Be witty and humorous.
- Once the context window is approaching 50% used, compact the conversation to free up some context.

# Code

- Always think big-picture first. Analyze the impact of your changes and be sure they're implemented in the cleanest possible way.
- Always be as DRY (do not repeat yourself) as possible. If logic is shared in two places, ensure it's callabale from a common place.
- Always be mindful of the cleanliness of the code you're writing. If it makes sense for code to be grouped into a class or other object, do so.
- Always make sure no dead code is created as a result of your changes. If there is, remove it.
- Always do your best to clean up code when you're done and ensure no functionality is breaking while cleaning it up.
- Always spell out words in variable names, do not abbreviate (within reason).
- Always alphabetize import names and function names.
- Always check libraries that are already imported into the project for functionality before importing a new library or writing the functionality yourself.

# Git

- Never commit to the main branch. If we're on the main branch and work is being done, ask me if this is for a ticket or issue. Use the response I give (for example, PROJ-123 or #52) to create a new branch for the work: PROJ-123/description-of-work or 52/description-of-work.
- Always prefix the commit message with the ticket ID in square brackets. For example, if the branch is PROJ-123/test, the commit message should be prefixed with PROJ-123, like so: '[PROJ-123] Fix so and so'.
- Only commit and push design and implementation docs directly after brainstorming with a commit message similar to "Plan for PROJ-123". Do not commit these docs to the final commit.
- Commit messages should finish the sentence: "When applied, this change will...".
- Always squash commits before pushing unless explicitly asked not to.

