# 🚀 Guide d'Utilisation - Workflows Leads Generator

**Créé le :** 2026-02-09
**Statut :** ✅ 4 Workflows déployés sur n8n
**Instance n8n :** https://n8n.srv1353532.hstgr.cloud

---

## 📋 Vue d'ensemble

Vous avez maintenant **4 workflows n8n** prêts à générer des leads qualifiés pour Talium :

| Workflow | ID | Objectif | Trigger |
|----------|-----|----------|---------|
| 🔍 Workflow 1 | `P8rBHSPqa4b9NHyf` | Scraping + Analyse sites obsolètes | Manuel |
| 🏢 Workflow 2 | `sB48PmBE6FZzupfb` | Monitoring nouvelles PME (RSS) | Manuel |
| 📧 Workflow 3 | `caXgcUzautDDHICx` | Enrichissement emails (gratuit) | Manuel |
| ✉️ Workflow 4 | `QrqK7OVpdSR71arx` | Envoi emails prospection | Manuel |

---

## ⚙️ Configuration requise (IMPORTANT)

### 1. Google Sheets - Structure requise

Vous devez créer un Google Sheet avec ces 2 feuilles :

#### Feuille "Leads" (Sites obsolètes)
```
Colonnes requises :
- Entreprise
- Site Web
- Score
- Priorité
- HTTPS
- Mobile
- Années
- Date Analyse
- Email
- Confiance Email
- Source Email
- MX Valide
- Date Enrichissement
- Email Envoyé
- Date Envoi
- Template Utilisé
```

#### Feuille "Nouvelles PME"
```
Colonnes requises :
- Entreprise
- BCE
- Site Web
- Statut Site
- Score
- Priorité
- Type
- Date Publication
- Date Analyse
- Email
- Email Envoyé
```

### 2. Configurer l'ID Google Sheet

**ÉTAPES :**

1. Créez votre Google Sheet avec les colonnes ci-dessus
2. Récupérez l'ID du Sheet depuis l'URL :
   ```
   https://docs.google.com/spreadsheets/d/1ABC...XYZ/edit
                                           ^^^^^^^^^^^
                                           Copiez cet ID
   ```
3. Allez sur votre n8n : https://n8n.srv1353532.hstgr.cloud
4. Remplacez `VOTRE_GOOGLE_SHEET_ID` dans **chaque workflow** :
   - Workflow 1 : Node "📄 Sauver dans Google Sheets"
   - Workflow 2 : Node "📄 Sauver dans Google Sheets"
   - Workflow 3 : Node "Lire Leads depuis Google Sheets" + "🔄 Mettre à jour"
   - Workflow 4 : Node "Lire Leads Qualifiés" + "✅ Marquer Email Envoyé"

### 3. Configurer les Credentials Gmail

Pour le Workflow 4 (envoi emails) :

1. Allez dans n8n → Settings → Credentials
2. Créez une nouvelle credential "Gmail OAuth2"
3. Suivez les instructions pour connecter votre compte Gmail
4. Assignez cette credential au node "📧 Envoyer via Gmail" dans le Workflow 4

---

## 🎯 Comment utiliser les workflows

### Workflow 1 : Scraping Sites Obsolètes

**Objectif :** Trouver des sites web obsolètes qui nécessitent une refonte

**Comment l'utiliser :**

1. Ouvrez le workflow dans n8n
2. Cliquez sur "Execute Workflow" (bouton ▶️)
3. Le workflow va :
   - Scraper Pages Jaunes Belgique (ou utiliser les 5 entreprises de test)
   - Tester chaque site web (HTTPS, mobile, technologies)
   - Calculer un score de priorité (0-100)
   - Sauvegarder les leads avec score > 60 dans Google Sheets

**Résultat :**
- Leads qualifiés dans votre Google Sheet "Leads"
- Prêts pour l'enrichissement email (Workflow 3)

**Personnalisation :**
- Node "Scraper Pages Jaunes BE" : Changez l'URL pour cibler d'autres secteurs
- Node "Filtrer Score > 60" : Ajustez le seuil de qualification

---

### Workflow 2 : Monitoring Nouvelles PME

**Objectif :** Détecter les nouvelles entreprises belges qui n'ont pas encore de site web

**Comment l'utiliser :**

1. Ouvrez le workflow dans n8n
2. Cliquez sur "Execute Workflow"
3. Le workflow va :
   - Lire le RSS du Moniteur Belge
   - Extraire les nouvelles immatriculations
   - Filtrer par secteurs cibles (web, marketing, commerce, etc.)
   - Vérifier si elles ont un site web
   - Calculer une priorité (priorité haute si pas de site)
   - Sauvegarder dans Google Sheets "Nouvelles PME"

**Résultat :**
- Liste de nouvelles PME sans site web
- Opportunités à contacter rapidement

**Personnalisation :**
- Node "Filtrer Secteurs Cibles" : Ajustez la regex pour cibler d'autres secteurs
- Node "Calculer Priorité" : Modifiez les critères de scoring

---

### Workflow 3 : Enrichissement Emails

**Objectif :** Trouver les adresses email de contact pour vos leads

**Comment l'utiliser :**

1. Assurez-vous d'avoir des leads **sans email** dans votre Google Sheet
2. Ouvrez le workflow dans n8n
3. Cliquez sur "Execute Workflow"
4. Le workflow va :
   - Lire les leads sans email
   - Générer des patterns d'email (contact@, info@, etc.)
   - Valider les MX records du domaine
   - Scraper la page /contact pour trouver l'email
   - Mettre à jour le Google Sheet avec l'email trouvé

**Résultat :**
- Colonne "Email" remplie dans votre Google Sheet
- Confiance email : High (scraped) ou Medium (pattern)

**Méthode gratuite :**
- Pas besoin de Hunter.io ou autres services payants
- Utilise le scraping + validation DNS

---

### Workflow 4 : Envoi Emails Prospection

**Objectif :** Envoyer des emails personnalisés à vos leads qualifiés

**Comment l'utiliser :**

1. Configurez d'abord Gmail OAuth (voir section Configuration)
2. Assurez-vous d'avoir des leads avec emails dans votre Google Sheet
3. Ouvrez le workflow dans n8n
4. Cliquez sur "Execute Workflow"
5. Le workflow va :
   - Lire les leads non contactés (Email Envoyé = vide)
   - Sélectionner le bon template (Nouvelle PME ou Site Obsolète)
   - Personnaliser l'email avec les données du lead
   - Envoyer via Gmail
   - Attendre 30 secondes entre chaque envoi (anti-spam)
   - Marquer le lead comme contacté

**Résultat :**
- Emails envoyés depuis votre Gmail
- Colonne "Email Envoyé" = "Oui" dans le Sheet

**⚠️ Limites Gmail :**
- 500 emails / jour maximum
- Attendez 30 secondes entre chaque envoi (intégré dans le workflow)

---

## 📧 Templates d'emails inclus

### Template 1 : Nouvelle PME (Félicitations)

**Utilisé pour :** Leads détectés dans le Workflow 2

**Sujet :** `Félicitations pour le lancement de [Entreprise] 🎉`

**Corps :**
```
Bonjour,

Toutes nos félicitations pour le lancement de [Entreprise] !

Créer une entreprise est un défi passionnant. Pour vous aider à démarrer sur de bonnes bases digitales, nous offrons aux nouvelles PME belges :

✅ Un audit digital gratuit de 30 minutes
✅ -30% sur votre premier projet web
✅ Notre guide "Checklist digitale pour PME" (valeur 49€)

Chez Talium, nous aidons les entreprises belges à construire une présence digitale professionnelle sans se ruiner.

💻 Nos services :
- Création de sites web modernes
- Référencement local (Google My Business)
- Stratégie de contenu
- Automation marketing

Intéressé ? Répondez simplement "OUI" à cet email.

Bon démarrage !

Valérie Marette
Fondatrice - Talium
Marketing Digital pour PME
📧 val@talium.be
🌐 www.talium.be

---

PS: Pas intéressé ? Pas de problème, répondez "STOP" et vous ne recevrez plus de messages.

📍 Ce message vous a été envoyé car votre entreprise vient d'être enregistrée au Moniteur Belge.
Vous pouvez exercer vos droits RGPD en contactant privacy@talium.be
```

**Personnalisation automatique :**
- `[Entreprise]` = Remplacé par le nom de l'entreprise

---

### Template 2 : Site Obsolète (Audit)

**Utilisé pour :** Leads détectés dans le Workflow 1

**Sujet :** `[Entreprise] - Votre site web pourrait vous faire perdre des clients`

**Corps :**
```
Bonjour,

Je naviguais sur [Site Web] et j'ai remarqué quelques points qui pourraient impacter votre visibilité en ligne :

[Problèmes détectés - personnalisés automatiquement]

Ces problèmes peuvent vous coûter des clients sans que vous le sachiez. En 2026, 75% des internautes jugent la crédibilité d'une entreprise sur la qualité de son site web.

Chez Talium, nous aidons les PME belges à moderniser leur présence digitale :

✅ Audit technique gratuit (valeur 199€)
✅ Sites web modernes et rapides
✅ Optimisation SEO incluse
✅ Formation à la gestion de contenu

Seriez-vous disponible pour un audit gratuit de 15 minutes par vidéo ?

Je vous montrerai exactement ce qui pêche et comment y remédier.

Cordialement,

Valérie Marette
Fondatrice - Talium
Marketing Digital pour PME
📧 val@talium.be
🌐 www.talium.be
📱 +32 XXX XX XX XX

---

PS: Pas intéressé ? Répondez "STOP" pour vous désinscrire.

📍 Ce message vous a été envoyé car votre site web a été identifié comme ayant un potentiel d'amélioration.
Vous pouvez exercer vos droits RGPD en contactant privacy@talium.be
```

**Personnalisation automatique :**
- `[Entreprise]` = Nom de l'entreprise
- `[Site Web]` = URL du site
- `[Problèmes détectés]` = Liste générée selon l'analyse :
  - ❌ Pas de sécurisation HTTPS
  - ❌ Non optimisé pour mobile
  - ❌ Technologie obsolète

---

## 🔄 Workflow complet recommandé

Pour générer des leads de A à Z :

### Semaine 1 : Collecte

1. **Lundi** : Exécuter Workflow 1 (Sites obsolètes)
2. **Mardi** : Exécuter Workflow 2 (Nouvelles PME)
3. **Mercredi** : Vérifier les leads dans Google Sheets

### Semaine 2 : Enrichissement

4. **Lundi** : Exécuter Workflow 3 (Enrichissement emails) sur tous les leads
5. **Mardi** : Vérifier que les emails sont bien trouvés
6. **Mercredi** : Nettoyer manuellement si nécessaire

### Semaine 3 : Prospection

7. **Lundi-Vendredi** : Exécuter Workflow 4 (max 50 emails/jour pour commencer)
8. **Suivre les réponses** dans votre boîte Gmail

---

## 📊 Google Sheets - Template complet

Voici le template Google Sheet à créer :

**Onglet 1 : "Leads"** (Sites obsolètes)

| Entreprise | Site Web | Score | Priorité | HTTPS | Mobile | Années | Date Analyse | Email | Confiance Email | Source Email | MX Valide | Date Enrichissement | Email Envoyé | Date Envoi | Template Utilisé |
|------------|----------|-------|----------|-------|--------|--------|--------------|-------|-----------------|--------------|-----------|---------------------|--------------|------------|------------------|
| Restaurant Le Vieux Bruxelles | http://www.vieuxbruxelles.be | 75 | Haute | Non | Non | 7 | 2026-02-09 | contact@vieuxbruxelles.be | Medium | Generated pattern | Oui | 2026-02-09 | | | |

**Onglet 2 : "Nouvelles PME"**

| Entreprise | BCE | Site Web | Statut Site | Score | Priorité | Type | Date Publication | Date Analyse | Email | Email Envoyé |
|------------|-----|----------|-------------|-------|----------|------|------------------|--------------|-------|--------------|
| Digital Solutions SPRL | 0123456789 | https://www.digital-solutions.be | Inexistant | 80 | Très Haute | Nouvelle PME | 2026-02-09 | 2026-02-09 | | |

---

## ✅ Checklist avant de démarrer

- [ ] Google Sheet créé avec les 2 onglets (Leads + Nouvelles PME)
- [ ] ID Google Sheet copié et collé dans les 4 workflows
- [ ] Credentials Google Sheets configurées dans n8n
- [ ] Credentials Gmail OAuth configurées dans n8n
- [ ] Test du Workflow 1 réussi (5 entreprises de test)
- [ ] Test du Workflow 2 réussi (3 PME de test)
- [ ] Test du Workflow 3 réussi (enrichissement)
- [ ] Test du Workflow 4 réussi (1 email de test à vous-même)

---

## 🚀 Prochaines étapes

### Version 2.0 (optionnel)

Une fois que la version gratuite fonctionne bien, vous pourrez :

1. **Passer en automatique** : Changer les triggers manuels en Schedule (quotidien)
2. **Ajouter Hunter.io** : Pour améliorer la précision des emails (9$/mois)
3. **Ajouter PageSpeed Insights API** : Pour des scores de performance réels
4. **Ajouter Brevo** : Pour des séquences emails avancées (gratuit jusqu'à 300 emails/jour)
5. **Ajouter un CRM** : HubSpot gratuit ou Pipedrive

---

## ⚠️ Conformité RGPD

### ✅ Ce qui est inclus

- Base légale : Intérêt légitime B2B (prospection professionnelle)
- Lien de désinscription dans chaque email (répondez "STOP")
- Mention RGPD dans le footer
- Source de collecte indiquée (Moniteur Belge, analyse publique)

### ❌ Règles à respecter

- Ne contactez QUE des emails professionnels (@entreprise.be)
- Ne contactez JAMAIS des emails personnels (@gmail, @hotmail)
- Respectez immédiatement les demandes de désinscription
- Ne vendez/partagez jamais les données collectées
- Supprimez les leads qui ne répondent pas après 3 mois

---

## 🆘 Support et dépannage

### Problème : Le workflow ne trouve pas les emails

**Solution :**
- Vérifiez que le site web fonctionne
- Vérifiez que le domaine a des MX records (le workflow le teste)
- Essayez de scraper manuellement la page /contact

### Problème : Gmail refuse d'envoyer des emails

**Solution :**
- Vérifiez que Gmail OAuth est bien configuré
- Respectez la limite de 500 emails/jour
- Attendez 30 secondes entre chaque envoi (déjà dans le workflow)

### Problème : Google Sheets ne se met pas à jour

**Solution :**
- Vérifiez que l'ID du Sheet est correct
- Vérifiez que les credentials Google Sheets sont actives
- Vérifiez que les noms de colonnes correspondent exactement

---

## 📈 KPIs à suivre

Dans votre Google Sheet, vous pourrez suivre :

- **Leads générés/semaine** : Nombre de nouvelles lignes
- **Score moyen** : Moyenne de la colonne "Score"
- **Taux d'enrichissement** : % de leads avec email trouvé
- **Emails envoyés** : Nombre de "Oui" dans "Email Envoyé"
- **Taux de réponse** : À suivre manuellement dans Gmail

---

**🎉 Vous êtes prêt à générer vos premiers leads automatiquement !**

**Bon courage !**
**Valérie Marette - Talium**
