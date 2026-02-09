# 🚀 Configuration n8n - Guide de démarrage rapide

## ✅ Ce qui est déjà installé

- ✅ MCP Server n8n (n8n-mcp-czlonkowski)
- ✅ 7 Skills n8n pour Claude Code
- ✅ Configuration de base dans `~/.claude/mcp.json`

## 📋 Prochaines étapes

### 1. Obtenez vos credentials n8n

#### Si vous utilisez n8n.cloud:
1. Connectez-vous à [n8n.cloud](https://n8n.cloud)
2. Allez dans **Settings** → **API**
3. Cliquez sur **Create API Key**
4. Copiez la clé générée

#### Si vous utilisez n8n self-hosted:
1. Connectez-vous à votre instance n8n
2. Allez dans **Settings** → **API**
3. Activez l'API si nécessaire
4. Créez une nouvelle API key
5. Notez l'URL de votre instance (ex: `https://n8n.votredomaine.com`)

### 2. Configurez votre fichier MCP

Copiez le fichier exemple:
```bash
cp .mcp.json.example .mcp.json
```

Puis éditez `.mcp.json` avec vos vraies credentials:

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "info",
        "N8N_API_URL": "https://votre-instance.n8n.cloud",
        "N8N_API_KEY": "votre-api-key-ici"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

⚠️ **Important:**
- Remplacez `https://votre-instance.n8n.cloud` par votre vraie URL
- Remplacez `votre-api-key-ici` par votre vraie API key
- Ne commitez JAMAIS ce fichier avec vos vraies credentials!

### 3. Ajoutez .mcp.json au .gitignore

```bash
echo ".mcp.json" >> .gitignore
```

### 4. Testez la connexion

Redémarrez Claude Code, puis demandez:
```
Peux-tu lister les workflows disponibles dans mon instance n8n?
```

Si tout fonctionne, vous verrez la liste de vos workflows!

## 📚 Utilisation

Maintenant que tout est configuré, vous pouvez:

### Consulter la documentation de nodes
```
Comment fonctionne le node Hunter.io dans n8n?
```

### Créer un workflow
```
Crée un workflow n8n qui:
1. Scrape le Moniteur Belge pour les nouvelles entreprises
2. Filtre par secteur
3. Cherche leurs emails avec Hunter.io
4. Les enregistre dans Google Sheets
```

### Déboguer une erreur
```
J'ai cette erreur dans mon workflow: [copier l'erreur]
Comment la résoudre?
```

### Optimiser un workflow existant
```
Voici mon workflow JSON: [coller le JSON]
Comment puis-je l'améliorer?
```

## 🎯 Workflows prioritaires pour Talium

D'après votre document `automation n8n.md`, voici les workflows à créer:

### Workflow 1: Sites obsolètes (Priorité haute)
- Scraping annuaires
- Analyse technique des sites
- Scoring et qualification
- Enrichissement emails
- Stockage CRM

### Workflow 2: Nouvelles PME (Priorité haute)
- Monitoring Moniteur Belge
- Filtrage secteurs
- Recherche web
- Enrichissement contact
- Séquence emails

### Workflow 3: Envoi emails (Priorité moyenne)
- Templates personnalisés
- A/B testing
- Tracking
- Gestion réponses

## 🔧 Dépannage

### Le MCP server ne se connecte pas
```bash
# Vérifiez que Node.js est installé
node --version  # Devrait afficher v24.12.0 ou plus

# Testez manuellement le serveur
npx n8n-mcp

# Vérifiez vos credentials dans .mcp.json
```

### Les skills ne sont pas détectés
```bash
# Vérifiez l'installation
ls ~/.claude/skills/

# Devrait afficher:
# n8n-code-javascript
# n8n-code-python
# n8n-expression-syntax
# n8n-mcp-tools-expert
# n8n-node-configuration
# n8n-validation-expert
# n8n-workflow-patterns
```

### Erreur "API key invalid"
- Vérifiez que vous avez copié la clé complète
- Vérifiez que l'URL est correcte (avec https://)
- Régénérez une nouvelle API key si nécessaire

## 📞 Support

- [Issues MCP Server](https://github.com/3rzy/n8n-mcp-czlonkowski/issues)
- [Issues Skills](https://github.com/czlonkowski/n8n-skills/issues)
- [Documentation n8n](https://docs.n8n.io/)
- [Communauté n8n](https://community.n8n.io/)

## 🎉 C'est parti!

Une fois configuré, vous pouvez dire:
```
Commençons par le Workflow 1 pour détecter les sites obsolètes
```

Et Claude Code vous aidera à construire le workflow étape par étape! 🚀
