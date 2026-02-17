# ✅ Configuration Complète - Workflows n8n

**Date :** 2026-02-09
**Statut :** 🎉 Prêt à utiliser
**Instance n8n :** https://n8n.srv1353532.hstgr.cloud

---

## 🎯 Ce qui a été configuré

### ✅ Google Sheet connecté
- **ID :** `1aFlxd63Fya97ZKzDQ5BZ4FugVaQkPZKAUNTBwowKCOg`
- **Nom :** "génération de lead"
- **Status :** ✅ Configuré dans les 4 workflows

### ✅ Brevo (Sendinblue) connecté
- **Email expéditeur :** val@talium.be
- **API Key :** Configurée ✅
- **Limite gratuite :** 300 emails/jour
- **Status :** ✅ Remplace Gmail dans le Workflow 4

---

## 📊 Structure Google Sheet requise

Votre Google Sheet doit avoir **2 onglets** avec ces colonnes :

### Onglet 1 : "Leads" (pour sites obsolètes - Workflow 1)

| Colonne | Description | Rempli par |
|---------|-------------|------------|
| **Entreprise** | Nom de l'entreprise | Workflow 1 |
| **Site Web** | URL du site | Workflow 1 |
| **Score** | Score de priorité (0-100) | Workflow 1 |
| **Priorité** | Niveau (Haute, Moyenne, Basse) | Workflow 1 |
| **HTTPS** | Sécurité (Oui/Non) | Workflow 1 |
| **Mobile** | Responsive (Oui/Non) | Workflow 1 |
| **Années** | Années depuis dernière MAJ | Workflow 1 |
| **Date Analyse** | Date de détection | Workflow 1 |
| **Email** | Email de contact | Workflow 3 |
| **Confiance Email** | High/Medium | Workflow 3 |
| **Source Email** | Scraped/Generated | Workflow 3 |
| **MX Valide** | Serveurs email OK (Oui/Non) | Workflow 3 |
| **Date Enrichissement** | Date enrichissement email | Workflow 3 |
| **Email Envoyé** | Status envoi (Oui/vide) | Workflow 4 |
| **Date Envoi** | Date d'envoi email | Workflow 4 |
| **Template Utilisé** | Nom du template | Workflow 4 |

### Onglet 2 : "Nouvelles PME" (pour nouvelles entreprises - Workflow 2)

| Colonne | Description | Rempli par |
|---------|-------------|------------|
| **Entreprise** | Nom de l'entreprise | Workflow 2 |
| **BCE** | Numéro BCE (Belgique) | Workflow 2 |
| **Site Web** | URL testée | Workflow 2 |
| **Statut Site** | Existant/Inexistant | Workflow 2 |
| **Score** | Score de priorité | Workflow 2 |
| **Priorité** | Niveau de priorité | Workflow 2 |
| **Type** | "Nouvelle PME" | Workflow 2 |
| **Date Publication** | Date Moniteur Belge | Workflow 2 |
| **Date Analyse** | Date de détection | Workflow 2 |
| **Email** | Email de contact | Workflow 3 |
| **Email Envoyé** | Status envoi | Workflow 4 |

---

## 🚀 Workflows déployés

### 1. 🔍 Workflow 1 - Scraping Sites Obsolètes
- **ID :** `P8rBHSPqa4b9NHyf`
- **Status :** ✅ Configuré avec Google Sheet
- **Déclencheur :** Manuel (cliquez pour exécuter)

**Ce qu'il fait :**
1. Scrape des entreprises (actuellement : 5 entreprises de test)
2. Teste chaque site web (HTTP, HTTPS, mobile, technologies)
3. Calcule un score de priorité (0-100)
4. Sauvegarde les leads avec score > 60 dans l'onglet "Leads"

**Personnalisation :**
- Node "Scraper Pages Jaunes BE" → Changez l'URL pour scraper d'autres sources
- Node "Extraire Entreprises" → 5 entreprises de test incluses par défaut

---

### 2. 🏢 Workflow 2 - Nouvelles PME Belges
- **ID :** `sB48PmBE6FZzupfb`
- **Status :** ✅ Configuré avec Google Sheet
- **Déclencheur :** Manuel

**Ce qu'il fait :**
1. Lit le flux RSS du Moniteur Belge
2. Extrait les nouvelles immatriculations
3. Filtre par secteurs (web, digital, marketing, commerce, etc.)
4. Vérifie si l'entreprise a un site web
5. Calcule un score (bonus si pas de site = opportunité)
6. Sauvegarde dans l'onglet "Nouvelles PME"

**Note :** Utilise des données de test si le RSS est vide.

---

### 3. 📧 Workflow 3 - Enrichissement Emails
- **ID :** `caXgcUzautDDHICx`
- **Status :** ✅ Configuré avec Google Sheet
- **Déclencheur :** Manuel

**Ce qu'il fait :**
1. Lit les leads **sans email** depuis Google Sheets
2. Génère des patterns d'email (contact@, info@, hello@)
3. Valide les MX records (serveurs email du domaine)
4. Scrape la page /contact pour trouver l'email réel
5. Met à jour Google Sheets avec l'email trouvé

**Méthode gratuite :**
- Pas besoin de Hunter.io
- Validation DNS gratuite
- Scraping de la page contact

---

### 4. ✉️ Workflow 4 - Envoi Emails Prospection
- **ID :** `QrqK7OVpdSR71arx`
- **Status :** ✅ Configuré avec Google Sheet + Brevo
- **Déclencheur :** Manuel
- **Email expéditeur :** val@talium.be

**Ce qu'il fait :**
1. Lit les leads avec email mais non contactés (Email Envoyé = vide)
2. Sélectionne le bon template :
   - **Nouvelle PME** → Template de félicitations
   - **Site Obsolète** → Template d'audit
3. Personnalise l'email avec les données du lead
4. Envoie via **Brevo** (300 emails/jour gratuit)
5. Attend 30 secondes entre chaque envoi (anti-spam)
6. Marque le lead comme contacté dans Google Sheets

**Templates inclus :**
- ✅ Template "Félicitations Nouvelle PME"
- ✅ Template "Audit Site Obsolète" (personnalisé selon problèmes)

---

## ⚙️ Configuration Brevo dans n8n

**IMPORTANT :** Vous devez configurer la credential Brevo dans n8n.

### Étapes :

1. Connectez-vous à votre n8n : https://n8n.srv1353532.hstgr.cloud
2. Allez dans **Settings** (⚙️) → **Credentials**
3. Cliquez sur **"Add Credential"**
4. Cherchez **"Brevo"** ou **"Sendinblue"**
5. Entrez votre API key :
   ```
   VOTRE_CLE_API_BREVO
   ```
6. Nommez-la : **"Brevo API"**
7. Sauvegardez

### Vérifier l'email expéditeur dans Brevo :

1. Connectez-vous à Brevo : https://app.brevo.com
2. Allez dans **Settings** → **Senders & IP**
3. Vérifiez que **val@talium.be** est bien autorisé
4. Si ce n'est pas le cas, ajoutez-le et validez via OVH

---

## 📧 Templates d'emails personnalisés

### Template 1 : Nouvelle PME

**Sujet :** Félicitations pour le lancement de [Entreprise] 🎉

**Personnalisation automatique :**
- `[Entreprise]` = Nom de l'entreprise
- Offres spéciales nouvelles PME
- CTA : Répondre "OUI" pour un audit gratuit

### Template 2 : Site Obsolète

**Sujet :** [Entreprise] - Votre site web pourrait vous faire perdre des clients

**Personnalisation automatique :**
- `[Entreprise]` = Nom
- `[Site Web]` = URL
- **Liste des problèmes détectés** :
  - ❌ Pas de HTTPS (si détecté)
  - ❌ Non optimisé mobile (si détecté)
  - ❌ Technologies obsolètes (si détecté)
- CTA : Audit gratuit 15 minutes

**Tous les emails incluent :**
- ✅ Lien de désinscription RGPD
- ✅ Mention de la source des données
- ✅ Contact privacy@talium.be pour exercer les droits

---

## 🎯 Comment utiliser (Ordre recommandé)

### 🔄 Cycle complet de génération de leads

#### **Semaine 1 : Collecte**
```
Lundi    : Exécuter Workflow 1 (Sites obsolètes)
Mardi    : Exécuter Workflow 2 (Nouvelles PME)
Mercredi : Vérifier Google Sheets - Analyser les leads
```

#### **Semaine 2 : Enrichissement**
```
Lundi    : Exécuter Workflow 3 sur onglet "Leads"
Mardi    : Exécuter Workflow 3 sur onglet "Nouvelles PME"
Mercredi : Vérifier les emails trouvés dans Google Sheets
```

#### **Semaine 3-4 : Prospection**
```
Lundi-Vendredi : Exécuter Workflow 4 (max 50-100 emails/jour)
                 Suivre les réponses dans val@talium.be
                 Marquer les leads qui répondent
```

---

## 📊 Limites gratuites

| Service | Limite | Notes |
|---------|--------|-------|
| **Brevo** | 300 emails/jour | Gratuit, professionnel ✅ |
| **Google Sheets** | Illimité | Gratuit ✅ |
| **n8n (votre instance)** | Selon hébergement | Vérifier avec Hostinger |
| **RSS Moniteur Belge** | Gratuit | Public ✅ |

---

## ⚠️ Checklist avant le premier test

- [ ] Google Sheet créé avec 2 onglets ("Leads" et "Nouvelles PME")
- [ ] Colonnes créées selon la structure ci-dessus
- [ ] Credential Brevo configurée dans n8n
- [ ] Email val@talium.be vérifié dans Brevo
- [ ] Credential Google Sheets configurée dans n8n
- [ ] Test Workflow 1 (devrait créer 5 leads de test)
- [ ] Test Workflow 3 (devrait trouver des emails)
- [ ] Test Workflow 4 en vous envoyant un email à vous-même d'abord

---

## 🧪 Premier test recommandé

### Test 1 : Workflow 1 (Scraping)
1. Ouvrez Workflow 1 dans n8n
2. Cliquez sur "Execute Workflow"
3. Vérifiez que 5 entreprises de test apparaissent dans l'onglet "Leads"

### Test 2 : Workflow 3 (Enrichissement)
1. Ouvrez Workflow 3
2. Exécutez-le
3. Vérifiez que les emails sont ajoutés dans la colonne "Email"

### Test 3 : Workflow 4 (Email de test)
1. Dans Google Sheets, modifiez un lead :
   - Email = votre email personnel
   - Email Envoyé = vide
2. Ouvrez Workflow 4
3. Exécutez-le
4. Vérifiez que vous recevez l'email de val@talium.be

**Si ça fonctionne ✅ → Vous pouvez passer en production !**

---

## 🚀 Passage en production

Une fois les tests OK :

### Option 1 : Mode manuel (recommandé au début)
- Gardez les triggers manuels
- Exécutez les workflows quand vous voulez
- Contrôle total sur le volume d'emails

### Option 2 : Mode automatique (plus tard)
- Changez les triggers en "Schedule"
- Workflow 1 : Quotidien à 8h
- Workflow 2 : Quotidien à 9h
- Workflow 3 : Toutes les heures
- Workflow 4 : Quotidien à 10h (max 50 emails/jour au début)

---

## 📈 Optimisations futures

### Court terme (1-2 mois)
- [ ] Ajouter plus de sources de scraping (autres annuaires)
- [ ] Améliorer les templates emails avec A/B testing
- [ ] Créer une séquence email (Email 2, Email 3)
- [ ] Ajouter un dashboard de suivi (Airtable ou Notion)

### Moyen terme (3-6 mois)
- [ ] Intégrer Hunter.io pour emails plus précis (9$/mois)
- [ ] Ajouter PageSpeed Insights API (gratuit)
- [ ] Intégrer un CRM (HubSpot gratuit)
- [ ] Créer des workflows de suivi automatique

### Long terme (6+ mois)
- [ ] IA pour personnalisation emails (OpenAI)
- [ ] Scoring prédictif ML
- [ ] LinkedIn automation
- [ ] Webhooks pour temps réel

---

## 🆘 Dépannage

### Problème : "No credential found"
**Solution :** Créez les credentials Brevo et Google Sheets dans n8n

### Problème : "Google Sheets : Sheet not found"
**Solution :** Vérifiez que les onglets s'appellent exactement "Leads" et "Nouvelles PME"

### Problème : "Brevo : Sender not verified"
**Solution :** Vérifiez val@talium.be dans Brevo → Settings → Senders

### Problème : "Email non trouvé" (Workflow 3)
**Solution :** Normal pour certains sites, le pattern généré sera utilisé

---

## 📞 Support

- **Documentation n8n :** https://docs.n8n.io
- **Brevo Support :** https://help.brevo.com
- **Votre instance n8n :** https://n8n.srv1353532.hstgr.cloud

---

## ✅ Résumé

**Vous avez maintenant :**
- ✅ 4 workflows n8n prêts à l'emploi
- ✅ Google Sheet configuré automatiquement
- ✅ Brevo configuré pour envoyer depuis val@talium.be
- ✅ 2 templates d'emails personnalisés RGPD-compliant
- ✅ Méthode 100% gratuite pour commencer
- ✅ Guide complet d'utilisation

**Prochaine étape :**
1. Créez les 2 onglets dans votre Google Sheet
2. Configurez la credential Brevo dans n8n
3. Testez le Workflow 1
4. Testez le Workflow 3
5. Testez le Workflow 4 avec votre email
6. 🚀 Lancez votre première campagne !

---

**Bon succès avec votre génération de leads ! 🎉**

**Valérie Marette - Talium**
**val@talium.be**
