# Automation n8n - Génération de Leads Talium

## 📋 Vue d'ensemble du projet

Projet d'automation pour générer des leads qualifiés pour Talium (société de marketing digital) via n8n.

**Objectifs:**
- Détecter les sites internet obsolètes nécessitant une refonte
- Identifier les nouvelles PME sans présence web
- Automatiser la prospection B2B de manière RGPD-compliant

---

## 🔧 Configuration Claude Code pour n8n

### MCP Server n8n installé ✅

**Serveur:** [n8n-mcp-czlonkowski](https://github.com/3rzy/n8n-mcp-czlonkowski)

**Capacités:**
- 🎯 **532 nodes n8n** documentés (n8n-nodes-base + @n8n/n8n-nodes-langchain)
- 📚 **99% de couverture** des propriétés de nodes
- ⚙️ **63.6% de couverture** des opérations disponibles
- 📖 **90% de documentation** depuis les docs officielles n8n
- 🤖 **263 nodes AI** avec documentation complète

**Installation:** Le serveur est configuré dans `~/.claude/mcp.json`

### Skills n8n installés ✅

7 skills spécialisés pour construire des workflows n8n de haute qualité:

#### 1. **n8n-expression-syntax**
Syntaxe d'expressions n8n
- Patterns `{{ }}` corrects
- Variables: `$json`, `$node`, `$now`, `$env`, etc.
- Fonctions et transformations de données

#### 2. **n8n-mcp-tools-expert** ⭐ (Priorité haute)
Expert des outils MCP n8n
- Utilisation optimale du serveur MCP
- Accès à la documentation des nodes
- Requêtes efficaces

#### 3. **n8n-workflow-patterns**
Patterns architecturaux
- Webhook processing
- HTTP API workflows
- Database operations
- AI workflows
- Scheduled tasks

#### 4. **n8n-validation-expert**
Expert en validation
- Interprétation des erreurs
- Débogage de workflows
- Résolution de problèmes

#### 5. **n8n-node-configuration**
Configuration des nodes
- Dépendances entre propriétés
- Exigences spécifiques par opération
- Bonnes pratiques de configuration

#### 6. **n8n-code-javascript**
Nodes Code JavaScript
- Patterns d'accès aux données
- Fonctions built-in
- Manipulation de `$input`, `$items`, etc.

#### 7. **n8n-code-python**
Nodes Code Python
- Utilisation des nodes Python
- Limitations des librairies
- Patterns Python dans n8n

### Configuration de votre instance n8n

**Fichier:** `.mcp.json.example` (à personnaliser)

Pour activer la gestion complète des workflows via MCP:

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
      }
    }
  }
}
```

**Pour obtenir votre API key n8n:**
1. Connectez-vous à votre instance n8n
2. Allez dans Settings → API
3. Créez une nouvelle API key
4. Copiez-la dans le fichier `.mcp.json`

**⚠️ Sécurité:** Ne commitez jamais `.mcp.json` avec vos vraies credentials!

### Avantages pour ce projet

Avec ce setup, Claude Code peut:

✅ **Consulter la documentation** de n'importe quel node n8n
✅ **Construire des workflows** avec la syntaxe exacte
✅ **Valider les configurations** avant déploiement
✅ **Déboguer les erreurs** efficacement
✅ **Suggérer les meilleurs nodes** pour chaque tâche
✅ **Générer du code** JavaScript/Python optimisé pour n8n
✅ **Suivre les patterns** recommandés par la communauté

### Comment utiliser

Maintenant, vous pouvez simplement demander:
- "Crée un workflow n8n pour scraper des emails"
- "Comment configurer le node Hunter.io?"
- "Débogue cette erreur dans mon workflow"
- "Quel node utiliser pour envoyer des emails via Brevo?"

Claude Code utilisera automatiquement le MCP server et les skills pour vous donner des réponses précises et du code prêt à l'emploi!

---

## 🎯 Scénario 1 : Détection de sites obsolètes

### Workflow n8n

```
[Source de données] → [Analyse du site] → [Qualification] → [Enrichissement] → [CRM] → [Email]
```

### Étapes détaillées

#### 1. Source de données
**Objectif:** Scraper des annuaires d'entreprises

**Sources possibles:**
- Pages Jaunes (Belgique)
- Google Maps API (recherche par secteur/localisation)
- Registres des commerces (Moniteur Belge, BCE)
- Annuaires professionnels locaux

**Nœuds n8n:**
- HTTP Request (pour APIs)
- Apify (pour scraping avancé)
- Code (JavaScript/Python pour parsing)

#### 2. Analyse du site
**Vérifications à effectuer:**

✅ **Existence du site**
- Tester l'URL via HTTP Request
- Statut code 200/404/timeout

✅ **Technologie utilisée**
- API: BuiltWith API
- Alternative: Wappalyzer API
- Détecter CMS obsolètes (Joomla ancien, Flash, etc.)

✅ **Date de dernière mise à jour**
- PageSpeed Insights API (metadata)
- Scraping du footer/copyright
- Archive.org Wayback Machine API

✅ **Responsive design**
- Mobile-Friendly Test API (Google)
- Détection viewport meta tag

✅ **Performance**
- Lighthouse API (score global)
- PageSpeed Insights (vitesse de chargement)
- WebPageTest API

**Nœuds n8n:**
- HTTP Request (APIs externes)
- Puppeteer (scraping + screenshots)
- Function/Code (analyse des résultats)

#### 3. Qualification
**Critères de filtrage:**

**Score de priorité (0-100):**
- Site > 5 ans sans update: +30 points
- Pas de HTTPS: +20 points
- Pas mobile-friendly: +25 points
- Score Lighthouse < 50: +15 points
- CMS obsolète: +10 points

**Seuil:** Leads avec score > 60 passent à l'étape suivante

**Nœuds n8n:**
- IF (conditions)
- Switch (routing selon score)
- Filter (éliminer les non-qualifiés)

#### 4. Enrichissement contact
**Trouver l'email:**

**Services:**
- Hunter.io (vérification + recherche email)
- Apollo.io (base B2B)
- Dropcontact (enrichissement français/belge)
- Snov.io (alternative)

**Pattern de recherche:**
- Prénom.nom@entreprise.be
- Contact@entreprise.be
- Info@entreprise.be

**Validation:**
- Vérification syntaxe
- Vérification MX records
- Détection catch-all

**Nœuds n8n:**
- Hunter.io node
- HTTP Request (APIs d'enrichissement)
- Email Validation nodes

#### 5. CRM
**Stockage du lead:**

**Options:**
- Google Sheets (simple)
- Airtable (structuré + automatisations)
- HubSpot (CRM complet)
- Pipedrive (orienté vente)

**Champs à stocker:**
- Nom entreprise
- Secteur d'activité
- URL site
- Email contact
- Score de priorité
- Détails techniques (score, technologie, etc.)
- Date de détection
- Statut (nouveau/contacté/qualifié/perdu)

**Nœuds n8n:**
- Google Sheets
- Airtable
- HubSpot
- Pipedrive

#### 6. Email de prospection
**Template d'email personnalisé:**

```
Objet: [Entreprise] - Votre site web pourrait vous faire perdre des clients

Bonjour [Prénom],

Je naviguais sur le site de [Entreprise] et j'ai remarqué quelques points qui
pourraient impacter votre visibilité en ligne:

[Personnalisation selon analyse]:
- Votre site n'est pas optimisé pour mobile (70% du trafic actuel)
- La vitesse de chargement pourrait être améliorée
- Certaines technologies utilisées sont obsolètes

Chez Talium, nous aidons les PME belges à moderniser leur présence digitale.

Seriez-vous disponible pour un audit gratuit de 15 minutes?

Cordialement,
[Votre nom]
Talium - Marketing Digital

P.S. Pas intéressé? Cliquez ici pour vous désinscrire.
```

**Services d'envoi:**
- Brevo (que vous avez déjà)
- Gmail/SMTP (limité à 500/jour)
- SendGrid
- Mailgun

**Bonnes pratiques:**
- Personnalisation maximale
- A/B testing des objets
- Envoi espacé (pas de spam)
- Tracking d'ouverture/clics

**Nœuds n8n:**
- Brevo
- Gmail
- SendGrid
- Wait (espacer les envois)

---

## 🚀 Scénario 2 : Nouvelles PME

### Workflow n8n

```
[Monitoring] → [Filtrage] → [Recherche web] → [Enrichissement] → [CRM] → [Séquence email]
```

### Étapes détaillées

#### 1. Monitoring
**Sources de nouvelles entreprises:**

✅ **Moniteur Belge**
- RSS feed des nouvelles immatriculations
- Publication quotidienne
- Gratuit

✅ **Banque-Carrefour des Entreprises (BCE)**
- API ou scraping
- Données officielles
- Filtrage par date de création

✅ **Chambres de commerce locales**
- Newsletters
- Pages "nouveaux membres"

✅ **Autres sources:**
- LinkedIn (nouvelles pages entreprises)
- Registres provinciaux
- Médias locaux (communiqués)

**Nœuds n8n:**
- RSS Feed Read
- HTTP Request (APIs)
- Schedule Trigger (vérification quotidienne)
- Webhook (si flux temps réel)

#### 2. Filtrage
**Critères de sélection:**

**Secteurs d'activité:**
- Commerce de détail
- Services aux entreprises
- Restauration/HoReCa
- Professions libérales
- E-commerce
- (Exclure: agriculture, construction, etc. selon votre cible)

**Taille:**
- PME (< 50 employés)
- Startups
- Indépendants avec potentiel

**Géographie:**
- Belgique (priorité)
- Zones spécifiques selon votre couverture

**Nœuds n8n:**
- Filter (conditions)
- Switch (routing par secteur)
- IF (taille entreprise)

#### 3. Recherche web
**Vérifier s'ils ont déjà un site:**

**Méthode:**
1. Google Search API: `"nom entreprise" + site`
2. Vérifier URL potentielle: `www.nom-entreprise.be`
3. Recherche domaines enregistrés (WHOIS)

**Classification:**
- Pas de site = priorité haute
- Site basique = prospect pour upgrade
- Site professionnel = pas de contact

**Nœuds n8n:**
- HTTP Request (Google Custom Search)
- Puppeteer (vérification visuelle)
- Code (parsing résultats)

#### 4. Enrichissement contact
**Même process que Scénario 1:**
- Hunter.io
- Apollo.io
- Dropcontact
- Recherche LinkedIn

**Information supplémentaire:**
- Nom du fondateur/gérant
- Téléphone (registre BCE)
- LinkedIn de l'entreprise
- Secteur exact

#### 5. CRM
**Même setup que Scénario 1, champs additionnels:**
- Date de création entreprise
- Statut site (inexistant/basique/complet)
- Source de détection
- Tag: "nouvelle-pme"

#### 6. Séquence email
**Email 1 (J+1) - Félicitations:**

```
Objet: Félicitations pour le lancement de [Entreprise] 🎉

Bonjour [Prénom],

Toutes nos félicitations pour le lancement de [Entreprise]!

Créer une entreprise est un défi passionnant. Pour vous aider à démarrer sur de
bonnes bases, nous offrons aux nouvelles PME belges:

✅ Audit digital gratuit
✅ -30% sur votre premier projet web
✅ Guide "Checklist digitale pour PME"

Intéressé? Réservez 15 minutes dans mon agenda: [lien]

Bon démarrage!
[Nom]
Talium
```

**Email 2 (J+7) - Valeur:**

```
Objet: 3 erreurs digitales que font 90% des nouvelles PME

Bonjour [Prénom],

La plupart des nouvelles entreprises font ces erreurs:

1. Attendre 6 mois avant de créer leur site (pendant que leurs concurrents captent les clients)
2. Sous-estimer l'importance du mobile (70% du trafic)
3. Négliger le référencement local

Voici notre guide gratuit pour les éviter: [lien]

Besoin d'un coup de main? Je suis là.

[Nom]
```

**Email 3 (J+14) - Social proof:**

```
Objet: Comment [Entreprise similaire] a gagné ses 10 premiers clients en ligne

Bonjour [Prénom],

[Entreprise similaire dans votre secteur] était dans votre situation il y a 6 mois.

Aujourd'hui:
- 150 visiteurs/mois sur leur site
- 10 demandes de devis qualifiées
- ROI de 400%

[Lien vers case study]

Intéressé par la même approche? Répondez simplement "OUI".

[Nom]
```

**Nœuds n8n:**
- Wait (délais entre emails)
- Switch (selon réponse/ouverture)
- Brevo (séquences)

---

## 🛠️ Outils et intégrations

### Scraping
- **Apify** - Scraping à grande échelle
- **Puppeteer** - Contrôle browser headless
- **Scrapy** - Alternative Python
- **Bright Data** - Proxies et scraping

### Emails et enrichissement
- **Hunter.io** - Recherche et vérification emails
- **Dropcontact** - Enrichissement B2B français/belge
- **Snov.io** - Alternative complète
- **Apollo.io** - Base de données B2B
- **Brevo** (déjà en place) - Envoi d'emails marketing

### Analyse de sites
- **Google PageSpeed Insights API** - Performance et mobile
- **WebPageTest API** - Tests avancés
- **Lighthouse API** - Scores qualité
- **BuiltWith API** - Détection technologies
- **Wappalyzer API** - Alternative détection tech

### CRM et stockage
- **Google Sheets** - Simple et gratuit
- **Airtable** - Base de données structurée
- **HubSpot** - CRM complet (plan gratuit disponible)
- **Pipedrive** - CRM orienté vente
- **Notion** - Alternative flexible

### Envoi d'emails
- **Brevo** (recommandé - déjà en place)
- **SendGrid** - Jusqu'à 100 emails/jour gratuit
- **Mailgun** - API puissante
- **Gmail SMTP** - 500 emails/jour max

### APIs utiles
- **Google Custom Search API** - Recherche web
- **LinkedIn API** - Enrichissement
- **Google Maps API** - Géolocalisation
- **Clearbit** - Enrichissement entreprise

---

## ⚖️ Conformité RGPD

### Base légale
**Intérêt légitime (B2B):**
- Prospection B2B autorisée en Belgique
- Emails professionnels uniquement
- Relation commerciale potentielle

**À documenter:**
- Source de collecte des données
- Date de collecte
- Critères de qualification
- Conservation des données (max 3 ans)

### Bonnes pratiques

✅ **DO:**
- Emails professionnels uniquement (nom@entreprise.be)
- Lien de désinscription dans chaque email
- Respecter les opt-outs immédiatement
- Documenter le processus de collecte
- Offrir de la valeur (pas que de la vente)
- Personnaliser au maximum

❌ **DON'T:**
- Emails personnels (@gmail, @hotmail)
- Emails en masse non-ciblés
- Continuer après opt-out
- Mentir sur la source des données
- Acheter des listes d'emails
- Masquer l'identité de l'expéditeur

### Template de désinscription

```
Ce message vous a été envoyé car votre entreprise correspond à notre cible de
prospection B2B (détection automatique via sources publiques).

Pour vous désinscrire: [lien]
Pour mettre à jour vos préférences: [lien]
Pour exercer vos droits RGPD: privacy@talium.be

Talium SPRL - [Adresse] - BCE: [Numéro]
```

### Registre RGPD
**À maintenir:**
- Liste des sources de données
- Finalité du traitement
- Durée de conservation
- Mesures de sécurité
- Opt-outs enregistrés

---

## 📊 Architecture n8n recommandée

### Workflow 1: Collecte et analyse (quotidien)
```
Trigger Schedule (1x/jour à 8h)
  ↓
Scraping sources (parallèle)
  ↓
Analyse technique sites
  ↓
Calcul score qualification
  ↓
Stockage Google Sheets
```

### Workflow 2: Enrichissement (horaire)
```
Trigger Schedule (chaque heure)
  ↓
Lire nouveaux leads (score > 60)
  ↓
Enrichissement email (Hunter.io)
  ↓
Mise à jour Google Sheets
  ↓
Notification Slack (optionnel)
```

### Workflow 3: Envoi emails (manuel ou auto)
```
Trigger Manuel ou Schedule
  ↓
Lire leads qualifiés non-contactés
  ↓
Personnalisation template
  ↓
Envoi via Brevo
  ↓
Tracking ouvertures/clics
  ↓
Update statut CRM
```

### Workflow 4: Monitoring nouvelles PME (quotidien)
```
Trigger Schedule (1x/jour à 9h)
  ↓
Lecture RSS Moniteur Belge
  ↓
Filtrage secteurs
  ↓
Recherche site web
  ↓
Enrichissement contact
  ↓
Ajout CRM avec tag "nouvelle-pme"
```

### Workflow 5: Séquence emails nouvelles PME
```
Trigger (nouveau lead tag "nouvelle-pme")
  ↓
Email 1 (immédiat)
  ↓
Wait 7 jours
  ↓
Email 2 (si pas de réponse)
  ↓
Wait 7 jours
  ↓
Email 3 (si pas de réponse)
  ↓
Archivage ou passage commercial
```

---

## 🚀 Plan de mise en œuvre

### Phase 0: Configuration Claude Code (30 minutes) ✅
- [x] Installation MCP server n8n
- [x] Installation des 7 skills n8n
- [x] Configuration `.mcp.json` avec vos credentials n8n
- [ ] Redémarrage de Claude Code
- [ ] Test de connexion au MCP server

### Phase 1: Setup initial (Semaine 1)
- [x] Installation n8n (self-hosted ou cloud)
- [x] Obtention API key n8n
- [ ] Création comptes APIs (Hunter.io, PageSpeed, etc.)
- [ ] Setup Google Sheets template
- [ ] Configuration Brevo

### Phase 2: Workflow sites obsolètes (Semaine 2-3)
- [ ] Workflow collecte données
- [ ] Workflow analyse technique
- [ ] Workflow enrichissement
- [ ] Tests et ajustements

### Phase 3: Workflow nouvelles PME (Semaine 4)
- [ ] Monitoring Moniteur Belge
- [ ] Filtrage et qualification
- [ ] Intégration CRM

### Phase 4: Automation emails (Semaine 5)
- [ ] Templates emails
- [ ] Séquences automatiques
- [ ] A/B testing

### Phase 5: Optimisation (Ongoing)
- [ ] Analyse taux d'ouverture
- [ ] Amélioration templates
- [ ] Scaling

---

## 📈 KPIs à suivre

### Prospection
- Nombre de leads détectés/jour
- Taux de qualification (score > 60)
- Taux d'enrichissement réussi
- Coût par lead qualifié

### Emails
- Taux d'ouverture (objectif: >25%)
- Taux de clic (objectif: >5%)
- Taux de réponse (objectif: >2%)
- Taux d'opt-out (<0.5%)

### Business
- Nombre de rendez-vous obtenus
- Taux de conversion lead → client
- ROI de l'automation
- Temps économisé vs. prospection manuelle

---

## 💡 Idées d'amélioration futures

### Intelligence artificielle
- Scoring prédictif avec ML
- Génération emails par IA (GPT)
- Analyse sentiment des réponses

### Canaux additionnels
- LinkedIn automation (avec précaution)
- SMS pour urgences
- Retargeting Facebook/Google

### Données enrichies
- Données financières (chiffre d'affaires)
- Signaux d'achat (recrutement, levée de fonds)
- Analyse concurrence

### Intégrations
- CRM complet (HubSpot/Salesforce)
- Téléphonie (appels automatiques)
- Chat bot sur site web

---

## 📞 Contacts et ressources

### Documentation
- [n8n Documentation](https://docs.n8n.io/)
- [n8n MCP Server](https://github.com/3rzy/n8n-mcp-czlonkowski)
- [n8n Skills](https://github.com/czlonkowski/n8n-skills)
- [Brevo API](https://developers.brevo.com/)
- [Hunter.io API](https://hunter.io/api-documentation)
- [PageSpeed Insights API](https://developers.google.com/speed/docs/insights/v5/get-started)

### Support
- [n8n Community](https://community.n8n.io/)
- [n8n Discord](https://discord.gg/n8n)
- [MCP Server Issues](https://github.com/3rzy/n8n-mcp-czlonkowski/issues)

### Légal RGPD
- [Autorité de protection des données (Belgique)](https://www.autoriteprotectiondonnees.be/)
- [Guide prospection B2B](https://www.autoriteprotectiondonnees.be/professionnel/themes/marketing-prospection)

---

## 📝 Notes et apprentissages

*Cette section sera mise à jour au fur et à mesure du projet*

### Problèmes rencontrés
-

### Solutions trouvées
-

### Optimisations effectuées
-

### Prochaines étapes
-

---

**Dernière mise à jour:** 2026-02-09
**Version:** 1.0
**Propriétaire:** Talium - Valerie Marette
