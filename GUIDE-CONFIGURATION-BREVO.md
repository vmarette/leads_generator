# ✉️ Guide Complet - Configuration Brevo dans n8n

**Pour :** Envoyer des emails professionnels depuis val@talium.be
**Temps estimé :** 10 minutes
**Niveau :** Débutant

---

## 🎯 Ce que nous allons faire

1. Vérifier votre compte Brevo
2. Vérifier que val@talium.be est autorisé
3. Créer la credential Brevo dans n8n
4. Assigner la credential au Workflow 4
5. Tester l'envoi d'un email

---

## Partie 1 : Vérifier votre compte Brevo

### Étape 1.1 : Se connecter à Brevo

1. Ouvrez votre navigateur
2. Allez sur : **https://app.brevo.com**
3. Connectez-vous avec votre compte Brevo

### Étape 1.2 : Vérifier votre API Key

Votre API Key est : `VOTRE_CLE_API_BREVO`

Pour vérifier qu'elle est active :

1. Dans Brevo, cliquez sur votre nom en haut à droite
2. Sélectionnez **"SMTP & API"**
3. Cliquez sur l'onglet **"API Keys"**
4. Vous devriez voir votre clé qui commence par `VOTRE_CLE_API_BREVO...`
5. Le status doit être **"Active"** (vert)

✅ **Si c'est actif, passez à l'étape suivante**

---

## Partie 2 : Vérifier l'expéditeur (val@talium.be)

**TRÈS IMPORTANT :** Brevo n'autorise l'envoi que depuis des adresses email **vérifiées**.

### Étape 2.1 : Vérifier si val@talium.be est validé

1. Dans Brevo, allez dans **"Settings"** (⚙️ en haut à droite)
2. Cliquez sur **"Senders & IP"** dans le menu de gauche
3. Regardez la liste des **"Senders"** (expéditeurs)

**3 cas possibles :**

#### Cas A : val@talium.be est dans la liste avec ✅ (vérifié)
→ **Parfait ! Passez directement à la Partie 3**

#### Cas B : val@talium.be est dans la liste avec ⏳ (en attente)
→ **Vous devez valider l'email**

1. Brevo a envoyé un email de validation à **val@talium.be**
2. Ouvrez votre boîte mail OVH (val@talium.be)
3. Cherchez l'email de Brevo (sujet : "Verify your sender email")
4. Cliquez sur le lien de validation dans l'email
5. Retournez dans Brevo → Le statut devrait passer à ✅

#### Cas C : val@talium.be n'est PAS dans la liste
→ **Vous devez l'ajouter**

1. Cliquez sur le bouton **"+ Add a sender"**
2. Entrez :
   - **Email** : `val@talium.be`
   - **Name** : `Valérie Marette - Talium`
3. Cliquez sur **"Add"**
4. Brevo envoie un email de validation à val@talium.be
5. Suivez les instructions du **Cas B** ci-dessus

### Étape 2.2 : Configurer les paramètres SPF/DKIM (optionnel mais recommandé)

Pour améliorer la délivrabilité de vos emails (éviter le spam) :

1. Dans **"Senders & IP"**, cliquez sur **"Domains"**
2. Cliquez sur **"Add a domain"**
3. Entrez : `talium.be`
4. Brevo vous donne des enregistrements DNS à ajouter chez OVH

**Si vous ne savez pas faire :** Pas de panique, vous pouvez envoyer des emails sans ça (mais ils risquent plus d'arriver en spam)

**Si vous voulez le faire :** Je peux vous guider pour ajouter les DNS chez OVH

---

## Partie 3 : Créer la Credential Brevo dans n8n

### Étape 3.1 : Accéder aux Credentials

1. Allez sur : **https://n8n.srv1353532.hstgr.cloud**
2. Connectez-vous
3. Cliquez sur **⚙️ Settings** dans le menu de gauche
4. Cliquez sur **"Credentials"**

### Étape 3.2 : Créer une nouvelle Credential Brevo

1. Cliquez sur **"+ Add Credential"** en haut à droite
2. Dans la barre de recherche, tapez : **`brevo`**
3. Cliquez sur **"Brevo API"** (il n'y en a qu'un seul)

### Étape 3.3 : Entrer votre API Key

1. Dans le champ **"API Key"**, collez :
   ```
   VOTRE_CLE_API_BREVO
   ```

2. Dans le champ **"Credential Name"**, entrez :
   ```
   Brevo - val@talium.be
   ```

3. Cliquez sur le bouton **"Save"** en bas

✅ **Votre credential Brevo est créée !**

---

## Partie 4 : Assigner la Credential au Workflow 4

### Étape 4.1 : Ouvrir le Workflow 4

1. Dans n8n, cliquez sur **"Workflows"** dans le menu de gauche
2. Cliquez sur **"✉️ Workflow 4 - Envoi Emails Prospection"**

### Étape 4.2 : Configurer le node Brevo

1. Cherchez le node **"📧 Envoyer via Brevo"** (au milieu du workflow)
2. Cliquez dessus pour le sélectionner
3. Dans le panneau de droite, vous verrez plusieurs champs :

**Configuration du node :**

- **Credential to connect with** :
  - Cliquez sur le menu déroulant
  - Sélectionnez : **"Brevo - val@talium.be"**

- **Resource** : Email (déjà configuré ✅)
- **Operation** : Send (déjà configuré ✅)

- **From Email** :
  - Devrait afficher : `val@talium.be` ✅
  - **Si ce n'est pas le cas**, entrez : `val@talium.be`

- **From Name** :
  - Devrait afficher : `Valérie Marette - Talium` ✅
  - **Si ce n'est pas le cas**, entrez : `Valérie Marette - Talium`

- **To** :
  - Devrait afficher : `={{ $json.Email }}` ✅
  - Ne touchez pas à ça (c'est une expression n8n)

- **Subject** :
  - Devrait afficher : `={{ $json.email_subject }}` ✅
  - Ne touchez pas

- **Text Content** :
  - Devrait afficher : `={{ $json.email_body }}` ✅
  - Ne touchez pas

4. Cliquez sur **"Save"** en haut à droite

✅ **Le Workflow 4 est maintenant connecté à Brevo !**

---

## Partie 5 : Test d'envoi d'email

### Étape 5.1 : Préparer un lead de test dans Google Sheets

**Important :** Pour le premier test, envoyez l'email **à vous-même** pour vérifier que tout fonctionne.

1. Ouvrez votre Google Sheet "génération de lead"
2. Allez dans l'onglet **"Leads"**
3. Si vous avez déjà exécuté le Workflow 1, vous devriez avoir 5 entreprises de test
4. Modifiez la première ligne (Restaurant Le Vieux Bruxelles) :
   - **Colonne I (Email)** : Remplacez par **votre propre email** (ex: votre Gmail perso)
   - **Colonne N (Email Envoyé)** : Laissez **VIDE** (important !)

### Étape 5.2 : Exécuter le Workflow 4

1. Retournez dans n8n
2. Ouvrez **Workflow 4**
3. En haut à droite, cliquez sur **"Execute Workflow"** (▶️)
4. Le workflow s'exécute...
5. Vous devriez voir des **checkmarks verts ✓** sur tous les nodes

### Étape 5.3 : Vérifier la réception de l'email

1. Ouvrez votre boîte mail (celle que vous avez mise dans le Google Sheet)
2. Attendez 30 secondes à 1 minute
3. Cherchez un email de **val@talium.be**
4. Sujet : **"Restaurant Le Vieux Bruxelles - Votre site web pourrait vous faire perdre des clients"**

**Si vous avez reçu l'email → 🎉 BRAVO ! Tout fonctionne !**

### Étape 5.4 : Vérifier dans Brevo

Pour voir les statistiques de l'email :

1. Allez sur https://app.brevo.com
2. Cliquez sur **"Campaigns"** → **"Transactional"**
3. Vous devriez voir votre email envoyé
4. Cliquez dessus pour voir :
   - ✅ Email délivré
   - 👁️ Email ouvert (si vous l'avez ouvert)
   - 🖱️ Liens cliqués

---

## 🆘 Résolution de problèmes

### Problème 1 : "Error: Sender not verified"

**Cause :** val@talium.be n'est pas vérifié dans Brevo

**Solution :**
1. Retournez à la **Partie 2** de ce guide
2. Vérifiez/ajoutez val@talium.be dans Brevo
3. Validez l'email via le lien envoyé par Brevo

### Problème 2 : "Error 401: Unauthorized"

**Cause :** L'API Key n'est pas valide

**Solution :**
1. Vérifiez que vous avez copié l'API Key complète (sans espaces)
2. Dans Brevo, vérifiez que l'API Key est **Active**
3. Si besoin, générez une nouvelle API Key dans Brevo
4. Mettez à jour la credential dans n8n

### Problème 3 : "Error: Invalid email format"

**Cause :** L'email dans Google Sheets n'est pas au bon format

**Solution :**
1. Vérifiez que l'email dans la colonne "Email" est valide
2. Format correct : `nom@domaine.com` (pas d'espaces, pas de caractères spéciaux)

### Problème 4 : Email reçu en SPAM

**Cause :** Délivrabilité à améliorer

**Solution :**
1. Configurez SPF/DKIM dans Brevo (voir Partie 2.2)
2. Ajoutez val@talium.be dans vos contacts (marque l'expéditeur comme sûr)
3. Évitez les mots "spam" dans les emails (urgent, gratuit, cliquez ici, etc.)

### Problème 5 : Email non reçu du tout

**Solution :**
1. Vérifiez vos **spams/indésirables**
2. Dans Brevo, allez dans Campaigns → Transactional
3. Vérifiez le statut de l'email :
   - **Sent** = Envoyé avec succès
   - **Blocked** = Bloqué (vérifier le destinataire)
   - **Hard bounce** = Email invalide

### Problème 6 : "Error: Daily sending limit exceeded"

**Cause :** Vous avez dépassé la limite Brevo (300 emails/jour)

**Solution :**
1. Attendez le lendemain (limite réinitialisée à minuit)
2. OU passez à un plan payant Brevo pour plus d'emails

---

## 📊 Limites du plan gratuit Brevo

| Limite | Valeur | Notes |
|--------|--------|-------|
| **Emails/jour** | 300 | Suffisant pour commencer |
| **Contacts** | Illimité | ✅ |
| **Expéditeurs** | Illimité | Mais tous doivent être vérifiés |
| **Templates** | Illimité | ✅ |
| **Statistiques** | Basiques | Ouvertures, clics, bounces |

**Pour augmenter les limites :**
- Plan Lite : 10 000 emails/mois pour 25€/mois
- Plan Premium : 20 000 emails/mois pour 65€/mois

---

## 💡 Bonnes pratiques d'envoi

### 1. Commencez doucement

**Jour 1 :** 10-20 emails
**Jour 2-3 :** 30-50 emails
**Semaine 2 :** 100-200 emails/jour

**Pourquoi ?** Pour construire votre réputation d'expéditeur.

### 2. Espacez les envois

Le Workflow 4 attend déjà **30 secondes entre chaque email**. C'est parfait !

### 3. Surveillez le taux de bounce

- **Bounce rate > 5%** = Problème (emails invalides)
- Nettoyez votre liste si nécessaire

### 4. Respectez les désinscriptions

Le template inclut déjà "Répondez STOP pour vous désinscrire". Respectez toujours ces demandes.

### 5. Personnalisez au maximum

Les templates sont déjà personnalisés automatiquement avec :
- Nom de l'entreprise
- URL du site
- Problèmes détectés spécifiques

---

## 📋 Checklist finale

Avant de passer en production :

- [ ] Compte Brevo actif
- [ ] val@talium.be vérifié dans Brevo (✅)
- [ ] API Key Brevo active
- [ ] Credential Brevo créée dans n8n
- [ ] Credential assignée au Workflow 4
- [ ] Test d'envoi réussi (email reçu)
- [ ] Email bien reçu depuis val@talium.be
- [ ] Email non arrivé en spam
- [ ] Statistiques visibles dans Brevo

**Si tout est coché ✅ → Vous êtes prêt à envoyer des vrais emails !**

---

## 🎯 Utilisation en production

### Scénario 1 : Petite campagne (10-20 emails)

1. Dans Google Sheets, identifiez 10-20 leads qualifiés
2. Vérifiez que la colonne "Email Envoyé" est vide pour ces leads
3. Exécutez le Workflow 4
4. Attendez 30 minutes (le workflow attend 30 sec × 20 emails = 10 minutes)
5. Vérifiez dans Brevo que tous sont envoyés

### Scénario 2 : Campagne moyenne (50-100 emails)

1. Même processus que Scénario 1
2. Durée : 50 emails × 30 sec = 25 minutes
3. Suivez les statistiques dans Brevo

### Scénario 3 : Grande campagne (200-300 emails)

1. Divisez en plusieurs sessions (matin/après-midi)
2. Ne dépassez pas 150 emails d'un coup
3. Surveillez le taux d'ouverture après la première vague
4. Ajustez le template si nécessaire

---

## 📈 Analyser les résultats dans Brevo

### Voir les statistiques globales

1. Brevo → **"Statistics"**
2. Vous verrez :
   - **Sent** : Emails envoyés
   - **Delivered** : Emails délivrés
   - **Opened** : Taux d'ouverture (objectif : >25%)
   - **Clicked** : Taux de clic (objectif : >5%)
   - **Bounced** : Emails rejetés (objectif : <2%)
   - **Unsubscribed** : Désinscriptions (objectif : <0.5%)

### Voir les détails par email

1. Brevo → **"Campaigns"** → **"Transactional"**
2. Cliquez sur un email
3. Vous verrez :
   - Date/heure d'envoi
   - Destinataire
   - Statut (délivré, ouvert, cliqué)
   - Appareil utilisé (mobile/desktop)

### Exporter les statistiques

1. Brevo → **"Contacts"** → **"Export contacts"**
2. Vous pouvez exporter un CSV avec toutes les stats

---

## 🔐 Sécurité et confidentialité

### Votre API Key est sensible !

**⚠️ NE PARTAGEZ JAMAIS votre API Key publiquement**

- Ne la commitez pas dans Git
- Ne la collez pas dans des forums
- Ne la partagez pas par email

**Si compromise :**
1. Allez dans Brevo → SMTP & API → API Keys
2. Supprimez l'ancienne clé
3. Créez-en une nouvelle
4. Mettez à jour la credential dans n8n

### Données RGPD

Brevo est conforme RGPD. Vos contacts sont stockés en Europe.

**Vos obligations :**
- Respecter les opt-outs
- Supprimer les contacts qui le demandent
- Ne contacter que des emails professionnels B2B

---

## ✅ Félicitations !

Vous avez terminé la configuration Brevo ! 🎉

**Ce que vous pouvez faire maintenant :**
- ✅ Envoyer des emails depuis val@talium.be
- ✅ Personnaliser automatiquement chaque email
- ✅ Suivre les ouvertures et clics
- ✅ Respecter les limites gratuites (300/jour)
- ✅ Gérer les désinscriptions

**Prochaine étape :**
👉 **Lancer votre première vraie campagne !**

---

**Besoin d'aide ?** Je suis là pour vous guider ! 🚀
