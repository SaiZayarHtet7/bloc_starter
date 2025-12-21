#!/bin/bash

# Watch for changes in ARB files and regenerate localizations
echo "👀 Watching for localization file changes..."
echo "Press Ctrl+C to stop"

# Initial generation
flutter gen-l10n

# Watch for changes (requires fswatch: brew install fswatch)
if command -v fswatch &> /dev/null; then
    fswatch -o lib/l10n/*.arb | while read; do
        echo "🔄 ARB file changed, regenerating localizations..."
        flutter gen-l10n
        echo "✅ Localizations updated"
    done
else
    echo "⚠️  fswatch not installed. Install with: brew install fswatch"
    echo "Or use VS Code tasks instead"
fi
