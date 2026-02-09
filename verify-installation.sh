#!/bin/bash

# Script de vérification de l'installation n8n MCP + Skills

echo "🔍 Vérification de l'installation n8n pour Claude Code"
echo "======================================================="
echo ""

# Vérifier Node.js
echo "1. Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "   ✅ Node.js installé: $NODE_VERSION"
else
    echo "   ❌ Node.js non installé"
    echo "   → Installez Node.js depuis https://nodejs.org"
fi
echo ""

# Vérifier npx
echo "2. npx..."
if command -v npx &> /dev/null; then
    echo "   ✅ npx disponible"
else
    echo "   ❌ npx non disponible"
fi
echo ""

# Vérifier le fichier MCP
echo "3. Configuration MCP..."
if [ -f "$HOME/.claude/mcp.json" ]; then
    echo "   ✅ Fichier mcp.json trouvé: ~/.claude/mcp.json"

    # Vérifier si configuré
    if grep -q "votre-instance.n8n.cloud" "$HOME/.claude/mcp.json" 2>/dev/null; then
        echo "   ⚠️  ATTENTION: Fichier mcp.json non configuré!"
        echo "   → Éditez ~/.claude/mcp.json avec vos vraies credentials"
    elif grep -q "N8N_API_KEY" "$HOME/.claude/mcp.json" 2>/dev/null; then
        echo "   ✅ Configuration détectée"
    else
        echo "   ⚠️  Configuration incomplète"
    fi
else
    echo "   ❌ Fichier mcp.json non trouvé"
    echo "   → Devrait être créé automatiquement"
fi
echo ""

# Vérifier les skills
echo "4. Skills n8n..."
SKILLS_DIR="$HOME/.claude/skills"
if [ -d "$SKILLS_DIR" ]; then
    SKILL_COUNT=$(ls -1 "$SKILLS_DIR" | grep -c "n8n-")
    echo "   ✅ Dossier skills trouvé"
    echo "   ✅ $SKILL_COUNT skills n8n installés:"

    for skill in "$SKILLS_DIR"/n8n-*; do
        if [ -d "$skill" ]; then
            SKILL_NAME=$(basename "$skill")
            echo "      - $SKILL_NAME"
        fi
    done
else
    echo "   ❌ Dossier skills non trouvé"
fi
echo ""

# Vérifier les fichiers du projet
echo "5. Fichiers du projet..."
PROJECT_DIR="$(pwd)"

if [ -f "$PROJECT_DIR/automation n8n.md" ]; then
    echo "   ✅ automation n8n.md"
else
    echo "   ❌ automation n8n.md manquant"
fi

if [ -f "$PROJECT_DIR/.mcp.json.example" ]; then
    echo "   ✅ .mcp.json.example"
else
    echo "   ⚠️  .mcp.json.example manquant"
fi

if [ -f "$PROJECT_DIR/SETUP-N8N.md" ]; then
    echo "   ✅ SETUP-N8N.md"
else
    echo "   ⚠️  SETUP-N8N.md manquant"
fi
echo ""

# Tester npx n8n-mcp
echo "6. Test du serveur MCP n8n..."
echo "   ⏳ Test en cours (peut prendre quelques secondes)..."
if timeout 5s npx -y n8n-mcp --help &> /dev/null; then
    echo "   ✅ Le serveur MCP n8n fonctionne"
else
    echo "   ⚠️  Impossible de tester le serveur (timeout ou erreur)"
    echo "   → Cela peut être normal, testez manuellement: npx n8n-mcp"
fi
echo ""

# Résumé
echo "======================================================="
echo "📊 Résumé"
echo "======================================================="
echo ""

if command -v node &> /dev/null && [ -f "$HOME/.claude/mcp.json" ] && [ -d "$SKILLS_DIR" ]; then
    echo "✅ Installation de base complète!"
    echo ""
    echo "🔧 Prochaines étapes:"
    echo "   1. Obtenez votre API key n8n"
    echo "   2. Éditez ~/.claude/mcp.json avec vos credentials"
    echo "   3. Redémarrez Claude Code"
    echo "   4. Testez avec: 'Peux-tu lister mes workflows n8n?'"
    echo ""
    echo "📚 Lisez SETUP-N8N.md pour plus de détails"
else
    echo "⚠️  Installation incomplète"
    echo ""
    echo "Éléments manquants:"
    if ! command -v node &> /dev/null; then
        echo "   - Node.js"
    fi
    if [ ! -f "$HOME/.claude/mcp.json" ]; then
        echo "   - Configuration MCP"
    fi
    if [ ! -d "$SKILLS_DIR" ]; then
        echo "   - Skills n8n"
    fi
    echo ""
    echo "Consultez SETUP-N8N.md pour l'installation"
fi
echo ""
