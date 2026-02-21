# Guide de Configuration Facebook Graph API

Ce guide explique comment configurer l'accès Facebook pour enrichir les données dans WF2 (recherche d'emails et téléphones sur les pages Facebook Business).

## Vue d'ensemble

Le workflow WF2 utilise Facebook Graph API pour rechercher les pages Facebook Business des entreprises et extraire:
- Adresse email publique
- Numéro de téléphone
- Lien vers la page Facebook

Cette fonctionnalité est **optionnelle** - le workflow fonctionne sans token Facebook, mais n'utilisera pas cette source d'enrichissement.

## Prérequis

- Un compte Facebook
- Une App Facebook (gratuit)
- 15 minutes pour la configuration initiale

## Étape 1: Créer une App Facebook

1. Aller sur [Facebook Developers](https://developers.facebook.com/apps)
2. Cliquer sur **"Create App"** (Créer une application)
3. Choisir le type d'app: **"Business"** ou **"Other"**
4. Remplir les informations:
   - **App Name**: "Leads Generator" (ou autre nom)
   - **App Contact Email**: Votre email
   - **App Purpose**: "Business operations" ou "Analytics"
5. Cliquer sur **"Create App"**

## Étape 2: Générer un Access Token

### Option A: User Access Token (Recommandé pour tests)

1. Dans votre App, aller dans **Tools → Graph API Explorer**
2. Dans le menu déroulant en haut, sélectionner votre App créée
3. Dans **"Permissions"**, ajouter les permissions suivantes:
   - `pages_show_list` - Pour rechercher des pages
   - `pages_read_engagement` - Pour lire les infos de contact
4. Cliquer sur **"Generate Access Token"**
5. Autoriser l'accès dans la fenêtre popup
6. **Copier le token généré** (commence par `EAAG...`)

⚠️ **Important**: Ce token expire après 1-2 heures. Pour un usage en production, passez à l'Option B.

### Option B: Long-Lived Access Token (Production)

Un User Access Token expire rapidement. Pour obtenir un token longue durée (60 jours):

1. Générer d'abord un User Access Token (Option A)
2. Obtenir votre **App ID** et **App Secret** depuis le Dashboard de votre App
3. Utiliser cet endpoint (remplacer les valeurs):

```bash
curl "https://graph.facebook.com/v18.0/oauth/access_token?grant_type=fb_exchange_token&client_id=VOTRE_APP_ID&client_secret=VOTRE_APP_SECRET&fb_exchange_token=VOTRE_SHORT_TOKEN"
```

4. Vous recevrez un token longue durée valide 60 jours

### Option C: Page Access Token (Meilleur pour production)

Si vous avez une page Facebook Business, vous pouvez obtenir un Page Access Token qui ne expire jamais:

1. Dans Graph API Explorer, sélectionner votre page dans le menu déroulant **"User or Page"**
2. Ajouter la permission `pages_read_engagement`
3. Générer le token
4. Ce token ne expire pas tant que l'App existe et que les permissions restent valides

## Étape 3: Configurer le Token dans n8n

### Méthode 1: Variable d'environnement (Recommandé)

1. Éditer le fichier `.env` de votre instance n8n:
```bash
FB_ACCESS_TOKEN=EAAG...votre_token_complet...
```

2. Redémarrer n8n:
```bash
docker-compose restart  # Si Docker
# OU
pm2 restart n8n  # Si PM2
# OU
systemctl restart n8n  # Si systemd
```

3. Le workflow récupérera automatiquement le token via `process.env.FB_ACCESS_TOKEN`

### Méthode 2: Directement dans le code (Non recommandé - pour tests uniquement)

1. Dans n8n, ouvrir le workflow **WF2 - Nouvelles PME Belges**
2. Double-cliquer sur le node **"Enrichir Email"**
3. Dans le code JavaScript, trouver la ligne:
```javascript
const FB_ACCESS_TOKEN = process.env.FB_ACCESS_TOKEN || ''; // À CONFIGURER
```

4. Remplacer par:
```javascript
const FB_ACCESS_TOKEN = process.env.FB_ACCESS_TOKEN || 'EAAG...votre_token...';
```

⚠️ **Attention**: Ne commitez jamais un token dans Git ! Utilisez plutôt les variables d'environnement.

## Étape 4: Tester l'intégration

1. Dans n8n, ouvrir **WF2 - Nouvelles PME Belges**
2. Cliquer sur **"Execute Workflow"** (mode manuel)
3. Vérifier dans les résultats:
   - Champ `facebook_found`: `true` si une page a été trouvée
   - Champ `facebook_page`: Lien vers la page Facebook
   - Champ `email_source`: "Facebook Business Page" si email trouvé via Facebook

### Débogage

Si les emails Facebook ne sont pas trouvés:

1. **Vérifier le token**:
```bash
curl "https://graph.facebook.com/v18.0/me?access_token=VOTRE_TOKEN"
```
Devrait retourner des infos sur votre compte.

2. **Vérifier les permissions**:
```bash
curl "https://graph.facebook.com/v18.0/me/permissions?access_token=VOTRE_TOKEN"
```
Vérifier que `pages_show_list` et `pages_read_engagement` sont `granted`.

3. **Tester une recherche**:
```bash
curl "https://graph.facebook.com/v18.0/pages/search?q=Test&type=page&access_token=VOTRE_TOKEN"
```

4. **Vérifier les logs n8n**: Les erreurs Facebook apparaîtront dans le champ `error` si présent.

## Limites et Quotas

Facebook Graph API a des limites de taux (rate limits):

- **User Access Token**: ~200 appels/heure/utilisateur
- **App Access Token**: ~200 appels/heure/app
- **Page Access Token**: ~4800 appels/jour

Pour WF2:
- **1 recherche** = 1 appel (search)
- **1 détail de page** = 1 appel (get page info)
- **Total par entreprise** = 2 appels max

Si vous traitez 50 entreprises/jour, cela fait ~100 appels, bien en dessous des limites.

## Confidentialité et Sécurité

### Ce qui est récupéré:
- ✅ Informations publiques des pages Business (nom, email, téléphone publics)
- ✅ Données que les entreprises ont choisi de rendre publiques

### Ce qui N'est PAS récupéré:
- ❌ Informations privées des profils personnels
- ❌ Posts ou contenu de la page
- ❌ Données des followers

### Bonnes pratiques:

1. **Ne partagez jamais votre Access Token**
2. **Utilisez des variables d'environnement** (jamais hardcodé)
3. **Renouvelez les tokens expirés** régulièrement
4. **Respectez les conditions d'utilisation** Facebook
5. **Ne stockez que les données nécessaires** (email + téléphone)

## Alternatives sans Facebook

Si vous ne souhaitez pas utiliser Facebook, le workflow fonctionne avec:

1. **WHOIS lookup** (déjà implémenté) - Pour domaines .be
2. **Scraping website** (déjà implémenté) - Pages contact
3. **Email pattern** (déjà implémenté) - info@domain.be

Vous pouvez simplement **ne pas configurer** de token Facebook et le workflow fonctionnera avec ces méthodes alternatives.

## Support

En cas de problème:

1. Vérifier que l'App Facebook est bien créée et active
2. Vérifier que les permissions sont accordées
3. Tester le token manuellement avec curl
4. Vérifier les logs d'exécution n8n pour les erreurs détaillées
5. Consulter la [documentation Facebook Graph API](https://developers.facebook.com/docs/graph-api/)

## Résumé - Démarrage rapide

```bash
# 1. Créer App Facebook sur developers.facebook.com
# 2. Générer Access Token avec permissions: pages_show_list, pages_read_engagement
# 3. Configurer dans n8n:

echo "FB_ACCESS_TOKEN=EAAG...votre_token..." >> .env
docker-compose restart n8n

# 4. Tester dans WF2 - Execute Workflow
# 5. Vérifier facebook_found: true dans les résultats
```

---

**Date de création**: 2026-02-21
**Version**: 1.0
**Workflow concerné**: WF2 - Nouvelles PME Belges
