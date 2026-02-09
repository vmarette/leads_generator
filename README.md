# 🤖 Projet Automation n8n - Talium

Système d'automation pour la génération de leads B2B pour Talium (marketing digital).

## 📁 Structure du projet

```
Claude Code/
├── README.md                    # Ce fichier
├── automation n8n.md            # Documentation complète du projet ⭐
├── SETUP-N8N.md                 # Guide de configuration
├── verify-installation.sh       # Script de vérification
├── .mcp.json.example            # Exemple de configuration MCP
└── .gitignore                   # Fichiers à ignorer
```

## 🎯 Objectifs du projet

1. **Détecter les sites obsolètes** - Identifier les entreprises avec des sites web nécessitant une refonte
2. **Nouvelles PME** - Cibler les nouvelles entreprises sans présence web
3. **Prospection automatisée** - Envoyer des emails personnalisés RGPD-compliant

## ✅ Installation

### MCP Server et Skills n8n - INSTALLÉS ✅

- **MCP Server n8n**: 532 nodes documentés, 99% de couverture
- **7 Skills n8n**: Expression syntax, MCP tools expert, Workflow patterns, etc.

### Vérifier l'installation

```bash
./verify-installation.sh
```

Résultat attendu:
```
✅ Installation de base complète!
✅ Node.js installé: v24.12.0
✅ 7 skills n8n installés
```

## 🚀 Démarrage rapide

### 1. Configurez vos credentials n8n

```bash
# Copiez le fichier exemple
cp .mcp.json.example .mcp.json

# Éditez avec vos vraies credentials
# Obtenez votre API key depuis: Settings → API dans n8n
```

### 2. Redémarrez Claude Code

Fermez et relancez Claude Code pour charger la nouvelle configuration.

### 3. Testez la connexion

Demandez à Claude:
```
Peux-tu lister mes workflows n8n disponibles?
```

### 4. Commencez à construire

Suivez le plan dans [automation n8n.md](automation n8n.md):
- **Workflow 1**: Détection de sites obsolètes
- **Workflow 2**: Monitoring nouvelles PME
- **Workflow 3**: Séquences d'emails

## 📚 Documentation

- **[automation n8n.md](automation n8n.md)** - Documentation complète avec scénarios, workflows, outils, RGPD
- **[SETUP-N8N.md](SETUP-N8N.md)** - Guide de configuration détaillé
- **[.mcp.json.example](.mcp.json.example)** - Template de configuration

## 🛠️ Technologies

### MCP Server
- **n8n-mcp-czlonkowski** - Accès complet à la documentation n8n
- 532 nodes, 263 nodes AI, 90% de documentation

### Skills Claude Code
1. n8n-expression-syntax
2. n8n-mcp-tools-expert
3. n8n-workflow-patterns
4. n8n-validation-expert
5. n8n-node-configuration
6. n8n-code-javascript
7. n8n-code-python

### Outils externes
- **Scraping**: Apify, Puppeteer
- **Emails**: Brevo, Hunter.io, Dropcontact
- **Analyse**: PageSpeed Insights, Lighthouse
- **CRM**: Google Sheets, Airtable, HubSpot

## 🎯 Workflows prévus

### Workflow 1: Sites obsolètes
```
Scraping → Analyse technique → Scoring → Enrichissement → CRM → Email
```
- Scraper des annuaires (Pages Jaunes, Google Maps)
- Analyser performance, technologies, responsive
- Scorer de 0-100
- Enrichir avec Hunter.io
- Envoyer email personnalisé via Brevo

### Workflow 2: Nouvelles PME
```
Monitoring → Filtrage → Recherche web → Enrichissement → CRM → Séquence
```
- Monitor Moniteur Belge RSS
- Filtrer par secteur
- Vérifier existence site
- Séquence 3 emails (J+1, J+7, J+14)

### Workflow 3: Gestion emails
- Templates personnalisés
- A/B testing
- Tracking ouvertures/clics
- Gestion opt-outs

## ⚖️ RGPD Compliance

✅ **Conforme:**
- Prospection B2B autorisée en Belgique
- Emails professionnels uniquement
- Opt-out dans chaque email
- Documentation des sources

❌ **Interdit:**
- Emails personnels
- Spam de masse
- Ignorer les opt-outs
- Acheter des listes

## 📊 KPIs cibles

### Prospection
- Leads détectés/jour: 50-100
- Taux qualification: >60%
- Coût/lead: <5€

### Emails
- Taux ouverture: >25%
- Taux clic: >5%
- Taux réponse: >2%

## 🔧 Dépannage

### Le MCP ne fonctionne pas
```bash
# Vérifier Node.js
node --version

# Tester manuellement
npx n8n-mcp

# Vérifier config
cat ~/.claude/mcp.json
```

### Les skills ne sont pas actifs
```bash
# Lister les skills
ls ~/.claude/skills/

# Devrait afficher 7 dossiers n8n-*
```

### Erreur API n8n
- Vérifiez votre API key dans `.mcp.json`
- Vérifiez l'URL de votre instance
- Régénérez l'API key si nécessaire

## 🚦 Statut du projet

- [x] Documentation complète créée
- [x] MCP Server n8n installé
- [x] Skills n8n installés
- [ ] Configuration credentials n8n
- [ ] Test connexion MCP
- [ ] Création Workflow 1 (Sites obsolètes)
- [ ] Création Workflow 2 (Nouvelles PME)
- [ ] Création Workflow 3 (Emails)
- [ ] Tests et validations
- [ ] Déploiement production

## 📞 Support

- **Documentation n8n**: https://docs.n8n.io/
- **MCP Server**: https://github.com/3rzy/n8n-mcp-czlonkowski
- **Skills**: https://github.com/czlonkowski/n8n-skills
- **Communauté n8n**: https://community.n8n.io/

## 📝 Notes

- Toujours tester en développement avant production
- Ne jamais committer `.mcp.json` avec credentials
- Suivre les bonnes pratiques RGPD
- Documenter les changements dans `automation n8n.md`

## 🎉 C'est parti!

Commencez par lire [SETUP-N8N.md](SETUP-N8N.md) puis demandez à Claude:

```
Commençons par créer le Workflow 1 pour détecter les sites obsolètes
```

**Bonne automation! 🚀**
