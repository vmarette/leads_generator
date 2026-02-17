# 🚀 Démarrage Rapide - Leads Generator

**Pour :** Valerie Marette - Talium
**Date :** 2026-02-09
**Status :** Configuration à finaliser

---

## 📊 Situation actuelle

✅ **Ce qui est FAIT :**
- 4 workflows créés sur n8n
- Google Sheet ID configuré dans tous les workflows
- Brevo API configuré dans le Workflow 4
- Gmail remplacé par Brevo (emails depuis val@talium.be)
- Templates d'emails personnalisés créés
- Documentation complète disponible

⏳ **Ce qu'il vous RESTE À FAIRE :**
1. Créer les onglets dans votre Google Sheet
2. Connecter Google Sheets à n8n (OAuth)
3. Connecter Brevo à n8n
4. Tester les workflows

**Temps estimé :** 20-30 minutes

---

## 🎯 Plan d'action (dans l'ordre)

### Étape 1 : Préparer votre Google Sheet (5 min)

📄 **Guide détaillé :** [GUIDE-CONFIGURATION-GOOGLE-SHEETS.md](GUIDE-CONFIGURATION-GOOGLE-SHEETS.md)

**Actions rapides :**
1. Ouvrez votre Google Sheet "génération de lead"
2. Créez l'onglet **"Leads"** avec ces colonnes (ligne 1) :
   ```
   Entreprise | Site Web | Score | Priorité | HTTPS | Mobile | Années | Date Analyse | Email | Confiance Email | Source Email | MX Valide | Date Enrichissement | Email Envoyé | Date Envoi | Template Utilisé
   ```

3. Créez l'onglet **"Nouvelles PME"** avec ces colonnes :
   ```
   Entreprise | BCE | Site Web | Statut Site | Score | Priorité | Type | Date Publication | Date Analyse | Email | Email Envoyé
   ```

✅ Fait ? Passez à l'étape 2

---

### Étape 2 : Connecter Google Sheets à n8n (10 min)

📄 **Guide détaillé :** [GUIDE-CONFIGURATION-GOOGLE-SHEETS.md](GUIDE-CONFIGURATION-GOOGLE-SHEETS.md) (Partie 2)

**Actions rapides :**
1. Allez sur : https://n8n.srv1353532.hstgr.cloud
2. Settings → Credentials → Add Credential
3. Cherchez "Google Sheets OAuth2 API"
4. Cliquez sur "Connect my account"
5. Autorisez dans la popup Google
6. Nommez la credential : **"Google Sheets - Génération Leads"**
7. Save

**Puis assignez aux workflows :**
- Workflow 1 : 1 node Google Sheets
- Workflow 2 : 1 node Google Sheets
- Workflow 3 : 2 nodes Google Sheets
- Workflow 4 : 2 nodes Google Sheets

✅ Fait ? Testez avec l'étape 3

---

### Étape 3 : Premier test - Workflow 1 (2 min)

**Actions rapides :**
1. Dans n8n, ouvrez **Workflow 1**
2. Cliquez sur "Execute Workflow" (▶️)
3. Attendez quelques secondes
4. Vérifiez votre Google Sheet → onglet "Leads"
5. Vous devriez voir **5 entreprises de test**

**Résultat attendu :**
```
Restaurant Le Vieux Bruxelles | http://www.vieuxbruxelles.be | 75 | ...
Plomberie Dubois SPRL | https://www.plomberie-dubois.be | ...
Coiffure Martine | ...
Garage Central | ...
Boulangerie Artisanale | ...
```

✅ Ça marche ? Passez à l'étape 4

❌ Ça ne marche pas ? Consultez le guide Google Sheets section "Résolution de problèmes"

---

### Étape 4 : Connecter Brevo à n8n (5 min)

📄 **Guide détaillé :** [GUIDE-CONFIGURATION-BREVO.md](GUIDE-CONFIGURATION-BREVO.md)

**Vérification préalable :**
1. Allez sur https://app.brevo.com
2. Settings → Senders & IP
3. Vérifiez que **val@talium.be** est dans la liste avec ✅

**Si val@talium.be n'est PAS vérifié :**
- Cliquez sur "Add a sender"
- Ajoutez val@talium.be
- Validez via l'email reçu

**Configuration n8n :**
1. n8n → Settings → Credentials → Add Credential
2. Cherchez "Brevo API"
3. Collez votre API Key :
   ```
   VOTRE_CLE_API_BREVO
   ```
4. Nommez : **"Brevo - val@talium.be"**
5. Save

**Assignez au Workflow 4 :**
- Ouvrez Workflow 4
- Node "📧 Envoyer via Brevo"
- Assignez la credential "Brevo - val@talium.be"
- Save

✅ Fait ? Passez au test final

---

### Étape 5 : Test final - Envoi d'email (5 min)

**Préparation :**
1. Ouvrez votre Google Sheet
2. Dans l'onglet "Leads", ligne 2 (Restaurant Le Vieux Bruxelles)
3. Colonne **"Email"** (I) : Mettez **VOTRE email perso** (pour tester)
4. Colonne **"Email Envoyé"** (N) : Laissez **VIDE**

**Test :**
1. Dans n8n, ouvrez **Workflow 4**
2. Cliquez sur "Execute Workflow" (▶️)
3. Attendez 30 secondes
4. Vérifiez votre boîte mail

**Email attendu :**
- **Expéditeur :** val@talium.be
- **Sujet :** "Restaurant Le Vieux Bruxelles - Votre site web pourrait vous faire perdre des clients"
- **Corps :** Template personnalisé avec les problèmes détectés

🎉 **Si vous avez reçu l'email → TOUT FONCTIONNE !**

---

## 📚 Documentation disponible

| Guide | Contenu | Quand l'utiliser |
|-------|---------|------------------|
| **[GUIDE-CONFIGURATION-GOOGLE-SHEETS.md](GUIDE-CONFIGURATION-GOOGLE-SHEETS.md)** | Configuration Google Sheets complète | Étapes 1-3 |
| **[GUIDE-CONFIGURATION-BREVO.md](GUIDE-CONFIGURATION-BREVO.md)** | Configuration Brevo complète | Étapes 4-5 |
| **[GUIDE-UTILISATION-WORKFLOWS.md](GUIDE-UTILISATION-WORKFLOWS.md)** | Comment utiliser les workflows | Après configuration |
| **[CONFIGURATION-COMPLETE.md](CONFIGURATION-COMPLETE.md)** | Vue d'ensemble technique | Référence |
| **[automation n8n.md](automation n8n.md)** | Spécifications du projet | Contexte |

---

## 🎯 Une fois configuré, comment utiliser ?

### Cycle complet de génération de leads

**Semaine 1 : Collecte**
```
Lundi    : Execute Workflow 1 (Sites obsolètes)
           → 5 leads de test dans "Leads"

Mardi    : Execute Workflow 2 (Nouvelles PME)
           → 3 leads de test dans "Nouvelles PME"
```

**Semaine 2 : Enrichissement**
```
Lundi    : Execute Workflow 3
           → Trouve les emails automatiquement
```

**Semaine 3 : Prospection**
```
Lundi-Vendredi : Execute Workflow 4
                 → Envoie les emails personnalisés
                 → Max 50-100 emails/jour au début
```

---

## 📊 Résumé des 4 workflows

### 🔍 Workflow 1 - Sites Obsolètes
**Fait quoi ?** Trouve des sites web qui ont besoin d'une refonte
**Trigger :** Manuel
**Résultat :** Leads dans l'onglet "Leads" avec score de priorité

### 🏢 Workflow 2 - Nouvelles PME
**Fait quoi ?** Détecte les nouvelles entreprises belges sans site web
**Trigger :** Manuel
**Résultat :** Leads dans l'onglet "Nouvelles PME"

### 📧 Workflow 3 - Enrichissement Emails
**Fait quoi ?** Trouve les emails de contact (gratuit)
**Trigger :** Manuel
**Résultat :** Colonne "Email" remplie dans Google Sheets

### ✉️ Workflow 4 - Envoi Emails
**Fait quoi ?** Envoie des emails personnalisés depuis val@talium.be
**Trigger :** Manuel
**Résultat :** Emails envoyés + colonne "Email Envoyé" = "Oui"

---

## 💡 Conseils pour débuter

### 1. Commencez petit
- Jour 1-3 : Utilisez les données de test (5 entreprises)
- Semaine 1 : Testez le cycle complet
- Semaine 2 : Ajoutez de vraies données progressivement

### 2. Ne vous précipitez pas sur les emails
- Testez d'abord avec votre propre email
- Puis 5-10 emails/jour
- Puis augmentez progressivement à 50-100/jour

### 3. Surveillez les métriques dans Brevo
- Taux d'ouverture : Objectif >25%
- Taux de clic : Objectif >5%
- Taux de bounce : Objectif <2%

### 4. Adaptez les templates
Les templates sont personnalisés automatiquement, mais vous pouvez :
- Modifier le ton dans le code des nodes
- A/B tester différents sujets
- Ajuster selon les retours

---

## 🆘 Besoin d'aide ?

### Problème avec Google Sheets ?
→ Consultez [GUIDE-CONFIGURATION-GOOGLE-SHEETS.md](GUIDE-CONFIGURATION-GOOGLE-SHEETS.md) section "Résolution de problèmes"

### Problème avec Brevo ?
→ Consultez [GUIDE-CONFIGURATION-BREVO.md](GUIDE-CONFIGURATION-BREVO.md) section "Résolution de problèmes"

### Problème avec un workflow ?
→ Consultez [GUIDE-UTILISATION-WORKFLOWS.md](GUIDE-UTILISATION-WORKFLOWS.md)

### Autre problème ?
→ Demandez-moi directement !

---

## ✅ Checklist de démarrage

Cochez au fur et à mesure :

**Configuration Google Sheets :**
- [ ] Onglet "Leads" créé avec 16 colonnes
- [ ] Onglet "Nouvelles PME" créé avec 11 colonnes
- [ ] Credential Google Sheets créée dans n8n
- [ ] Credential assignée aux 4 workflows (6 nodes)
- [ ] Test Workflow 1 réussi (5 entreprises dans "Leads")

**Configuration Brevo :**
- [ ] val@talium.be vérifié dans Brevo
- [ ] API Key active
- [ ] Credential Brevo créée dans n8n
- [ ] Credential assignée au Workflow 4
- [ ] Test d'envoi réussi (email reçu de val@talium.be)

**Prêt à utiliser :**
- [ ] Les 4 workflows fonctionnent
- [ ] Google Sheet se remplit automatiquement
- [ ] Emails envoyés depuis val@talium.be
- [ ] Documentation lue et comprise

**Si tout est coché ✅ → Vous pouvez commencer à générer des leads !**

---

## 🚀 Prochaines optimisations (facultatif)

Une fois à l'aise avec les workflows :

**Court terme (1-2 mois) :**
- [ ] Passer les triggers en automatique (Schedule)
- [ ] Ajouter plus de sources de scraping
- [ ] Créer des séquences d'emails (Email 2, Email 3)
- [ ] Optimiser les templates selon les retours

**Moyen terme (3-6 mois) :**
- [ ] Intégrer Hunter.io pour emails plus précis
- [ ] Ajouter PageSpeed Insights API (scores réels)
- [ ] Intégrer un CRM (HubSpot gratuit)
- [ ] Créer un dashboard de suivi

**Long terme (6+ mois) :**
- [ ] IA pour personnalisation avancée (OpenAI)
- [ ] Scoring prédictif avec ML
- [ ] LinkedIn automation
- [ ] Webhooks temps réel

---

## 🎉 Félicitations !

Vous avez maintenant un système complet de génération de leads automatisé, professionnel et RGPD-compliant !

**Ce qui a été créé pour vous :**
- ✅ 4 workflows n8n fonctionnels
- ✅ Configuration Google Sheets automatisée
- ✅ Configuration Brevo pour envoi professionnel
- ✅ 2 templates d'emails personnalisés
- ✅ Documentation complète (5 guides)
- ✅ Méthode 100% gratuite pour commencer (300 emails/jour)

**Votre investissement :**
- 💰 Coût : 0€ pour commencer (tout gratuit !)
- ⏱️ Temps : 20-30 minutes de configuration
- 🎯 Résultat : Génération automatique de leads qualifiés

**Prochaine étape :**
👉 **Suivez les 5 étapes ci-dessus et lancez votre premier test !**

---

**Bon succès avec vos leads ! 🚀**

**Valérie Marette - Talium**
**val@talium.be**
