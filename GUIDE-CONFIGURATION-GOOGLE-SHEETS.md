# 📊 Guide Complet - Configuration Google Sheets dans n8n

**Pour :** Connexion de votre Google Sheet "génération de lead" aux workflows n8n
**Temps estimé :** 10-15 minutes
**Niveau :** Débutant

---

## 🎯 Ce que nous allons faire

1. Préparer votre Google Sheet avec les bons onglets et colonnes
2. Connecter votre compte Google à n8n (OAuth)
3. Tester la connexion
4. Assigner la credential aux workflows

---

## Partie 1 : Préparer votre Google Sheet

### Étape 1.1 : Ouvrir votre Google Sheet

1. Allez sur https://docs.google.com/spreadsheets
2. Ouvrez votre sheet **"génération de lead"**
3. L'URL devrait ressembler à :
   ```
   https://docs.google.com/spreadsheets/d/1aFlxd63Fya97ZKzDQ5BZ4FugVaQkPZKAUNTBwowKCOg/edit
   ```

### Étape 1.2 : Créer l'onglet "Leads"

**Si l'onglet n'existe pas encore :**

1. En bas de la page, cliquez sur le **"+"** pour ajouter un onglet
2. Nommez-le exactement : **`Leads`** (avec un L majuscule)
3. Dans la première ligne (ligne 1), ajoutez ces colonnes **dans cet ordre** :

```
A1: Entreprise
B1: Site Web
C1: Score
D1: Priorité
E1: HTTPS
F1: Mobile
G1: Années
H1: Date Analyse
I1: Email
J1: Confiance Email
K1: Source Email
L1: MX Valide
M1: Date Enrichissement
N1: Email Envoyé
O1: Date Envoi
P1: Template Utilisé
```

**Astuce :** Vous pouvez copier-coller cette ligne complète :
```
Entreprise	Site Web	Score	Priorité	HTTPS	Mobile	Années	Date Analyse	Email	Confiance Email	Source Email	MX Valide	Date Enrichissement	Email Envoyé	Date Envoi	Template Utilisé
```

### Étape 1.3 : Créer l'onglet "Nouvelles PME"

1. Cliquez encore sur le **"+"** pour ajouter un 2ème onglet
2. Nommez-le exactement : **`Nouvelles PME`** (attention à l'espace et aux majuscules)
3. Dans la première ligne (ligne 1), ajoutez :

```
A1: Entreprise
B1: BCE
C1: Site Web
D1: Statut Site
E1: Score
F1: Priorité
G1: Type
H1: Date Publication
I1: Date Analyse
J1: Email
K1: Email Envoyé
```

**Astuce :** Vous pouvez copier-coller cette ligne :
```
Entreprise	BCE	Site Web	Statut Site	Score	Priorité	Type	Date Publication	Date Analyse	Email	Email Envoyé
```

### Étape 1.4 : Mettre en forme (optionnel mais recommandé)

Pour une meilleure lisibilité :

1. Sélectionnez la **ligne 1** (les en-têtes)
2. Cliquez sur le **"B"** (gras) dans la barre d'outils
3. Changez la couleur de fond (icône pot de peinture) : choisissez une couleur claire (gris, bleu clair)
4. **Figez la ligne 1** : Menu **Affichage** → **Figer** → **1 ligne**

✅ **Votre Google Sheet est prêt !**

---

## Partie 2 : Connecter Google à n8n (OAuth)

### Étape 2.1 : Accéder aux Credentials n8n

1. Ouvrez votre navigateur
2. Allez sur : **https://n8n.srv1353532.hstgr.cloud**
3. Connectez-vous à votre compte n8n
4. Dans le menu de gauche, cliquez sur l'icône **⚙️ Settings** (roue dentée)
5. Cliquez sur **"Credentials"**

### Étape 2.2 : Créer une nouvelle Credential Google Sheets

1. En haut à droite, cliquez sur le bouton **"+ Add Credential"**
2. Dans la barre de recherche, tapez : **`google sheets`**
3. Cliquez sur **"Google Sheets OAuth2 API"** (celui avec le logo Google)

### Étape 2.3 : Choisir la méthode d'authentification

Vous verrez 2 options :

**Option A : "OAuth Redirect URL" (RECOMMANDÉ - Plus simple)**

1. Cliquez sur **"Connect my account"**
2. Une popup Google va s'ouvrir
3. Sélectionnez votre compte Google (celui qui a accès au Google Sheet)
4. Google vous demandera les permissions suivantes :
   - ✅ **"Consulter, modifier, créer et supprimer vos feuilles de calcul"**
   - Cliquez sur **"Autoriser"**
5. La popup se ferme automatiquement
6. Vous revenez sur n8n avec le message "Successfully connected"

**Option B : "Service Account" (Plus avancé - à éviter pour l'instant)**
- Ne pas utiliser cette méthode pour débuter

### Étape 2.4 : Nommer la Credential

1. Dans le champ **"Credential Name"**, entrez : **`Google Sheets - Génération Leads`**
2. Cliquez sur le bouton **"Save"** en bas à droite

✅ **Votre compte Google est maintenant connecté à n8n !**

---

## Partie 3 : Assigner la Credential aux Workflows

Maintenant il faut dire à chaque workflow d'utiliser cette credential.

### Étape 3.1 : Workflow 1 - Sites Obsolètes

1. Dans n8n, cliquez sur **"Workflows"** dans le menu de gauche
2. Cliquez sur **"🔍 Workflow 1 - Scraping Sites Obsolètes"**
3. Le workflow s'ouvre dans l'éditeur
4. Cherchez le node **"💾 Sauver dans Google Sheets"** (en bas du workflow)
5. Cliquez dessus pour le sélectionner
6. Dans le panneau de droite, vous verrez **"Credential to connect with"**
7. Cliquez sur le menu déroulant sous "Credential to connect with"
8. Sélectionnez : **"Google Sheets - Génération Leads"** (celle qu'on vient de créer)
9. En haut à droite, cliquez sur **"Save"** (💾)

### Étape 3.2 : Workflow 2 - Nouvelles PME

1. Retournez à la liste des workflows (cliquez sur "Workflows" dans le menu)
2. Cliquez sur **"🏢 Workflow 2 - Nouvelles PME Belges"**
3. Cherchez le node **"💾 Sauver dans Google Sheets"**
4. Cliquez dessus
5. Dans "Credential to connect with", sélectionnez : **"Google Sheets - Génération Leads"**
6. Cliquez sur **"Save"**

### Étape 3.3 : Workflow 3 - Enrichissement Emails

Ce workflow a **2 nodes** Google Sheets à configurer :

**Node 1 : "Lire Leads depuis Google Sheets"**
1. Ouvrez **"📧 Workflow 3 - Enrichissement Emails"**
2. Cliquez sur le node **"Lire Leads depuis Google Sheets"** (au début)
3. Assignez la credential : **"Google Sheets - Génération Leads"**

**Node 2 : "🔄 Mettre à jour Google Sheets"**
1. Cliquez sur le node **"🔄 Mettre à jour Google Sheets"** (à la fin)
2. Assignez la credential : **"Google Sheets - Génération Leads"**

3. Cliquez sur **"Save"**

### Étape 3.4 : Workflow 4 - Envoi Emails

Ce workflow a aussi **2 nodes** Google Sheets :

**Node 1 : "Lire Leads Qualifiés"**
1. Ouvrez **"✉️ Workflow 4 - Envoi Emails Prospection"**
2. Cliquez sur le node **"Lire Leads Qualifiés"**
3. Assignez la credential : **"Google Sheets - Génération Leads"**

**Node 2 : "✅ Marquer Email Envoyé"**
1. Cliquez sur le node **"✅ Marquer Email Envoyé"** (à la fin)
2. Assignez la credential : **"Google Sheets - Génération Leads"**

3. Cliquez sur **"Save"**

✅ **Tous les workflows sont maintenant connectés à votre Google Sheet !**

---

## Partie 4 : Tester la connexion

### Test 1 : Vérifier que n8n voit votre Google Sheet

1. Ouvrez **Workflow 1**
2. Cliquez sur le node **"💾 Sauver dans Google Sheets"**
3. Dans le panneau de droite, vous verrez :
   - **Document** : Un menu déroulant devrait afficher votre sheet "génération de lead"
   - **Sheet** : Un menu déroulant devrait afficher "Leads"

**Si vous voyez ces menus → ✅ La connexion fonctionne !**

**Si vous voyez une erreur rouge → ❌ Problème de connexion**

### Test 2 : Exécuter le Workflow 1 (Test complet)

1. Dans **Workflow 1**, cliquez sur le bouton **"Execute Workflow"** (▶️) en haut à droite
2. Le workflow va s'exécuter
3. Attendez quelques secondes
4. Vous devriez voir des **checkmarks verts ✓** sur chaque node
5. Le dernier node "💾 Sauver dans Google Sheets" devrait afficher : **"5 items"**

### Test 3 : Vérifier dans votre Google Sheet

1. Retournez dans votre Google Sheet "génération de lead"
2. Allez dans l'onglet **"Leads"**
3. Vous devriez voir **5 entreprises** de test apparaître :
   - Restaurant Le Vieux Bruxelles
   - Plomberie Dubois SPRL
   - Coiffure Martine
   - Garage Central
   - Boulangerie Artisanale

**Si vous voyez ces entreprises → 🎉 TOUT FONCTIONNE !**

---

## 🆘 Résolution de problèmes

### Problème 1 : "Error: Insufficient permissions"

**Cause :** n8n n'a pas les bonnes permissions Google

**Solution :**
1. Allez dans Settings → Credentials
2. Supprimez la credential Google Sheets
3. Recréez-la en suivant Partie 2
4. Lors de la popup Google, assurez-vous de cliquer sur **"Autoriser"**

### Problème 2 : "Sheet not found: Leads"

**Cause :** Le nom de l'onglet n'est pas exactement "Leads"

**Solution :**
1. Vérifiez que l'onglet s'appelle **exactement** `Leads` (avec un L majuscule)
2. Pas d'espaces avant ou après
3. Si besoin, renommez l'onglet : Clic droit sur l'onglet → Renommer

### Problème 3 : "Error: Document not found"

**Cause :** L'ID du Google Sheet n'est pas correct

**Solution :**
1. Ouvrez votre Google Sheet
2. Copiez l'ID depuis l'URL :
   ```
   https://docs.google.com/spreadsheets/d/1aFlxd63Fya97ZKzDQ5BZ4FugVaQkPZKAUNTBwowKCOg/edit
                                           ↑ Copiez cette partie ↑
   ```
3. Dans n8n, ouvrez chaque workflow
4. Pour chaque node Google Sheets, vérifiez que l'ID est : `1aFlxd63Fya97ZKzDQ5BZ4FugVaQkPZKAUNTBwowKCOg`

### Problème 4 : "Error 401: Unauthorized"

**Cause :** La credential a expiré

**Solution :**
1. Settings → Credentials
2. Cliquez sur "Google Sheets - Génération Leads"
3. Cliquez sur "Reconnect"
4. Autorisez à nouveau dans la popup Google

### Problème 5 : Le menu déroulant "Document" est vide

**Cause :** Le compte Google connecté n'a pas accès au Sheet

**Solution :**
1. Vérifiez que vous avez utilisé le bon compte Google lors de l'OAuth
2. Vérifiez que ce compte a accès au Google Sheet (Partage → Vérifier)
3. Si besoin, partagez le Google Sheet avec le compte utilisé dans n8n

---

## 📋 Checklist finale

Avant de passer aux autres configurations, vérifiez :

- [ ] Google Sheet "génération de lead" existe
- [ ] Onglet "Leads" créé avec 16 colonnes
- [ ] Onglet "Nouvelles PME" créé avec 11 colonnes
- [ ] Credential Google Sheets créée dans n8n
- [ ] Credential assignée aux 4 workflows (6 nodes au total)
- [ ] Test Workflow 1 réussi
- [ ] 5 entreprises de test apparaissent dans l'onglet "Leads"

**Si tout est coché ✅ → Passez à la configuration Brevo !**

---

## 🎯 Prochaine étape

Une fois Google Sheets configuré, vous devez configurer **Brevo** pour envoyer les emails.

Suivez le guide : **Configuration Brevo** (je vais le créer pour vous)

---

## 💡 Conseils d'utilisation

### Partager le Google Sheet avec votre équipe

Si vous voulez que d'autres personnes voient les leads :

1. En haut à droite du Google Sheet, cliquez sur **"Partager"**
2. Ajoutez les emails des personnes
3. Donnez-leur l'accès **"Lecteur"** ou **"Éditeur"** selon vos besoins

### Filtrer et trier les leads

Dans votre Google Sheet :
- **Trier par Score** : Cliquez sur colonne C → Trier de Z à A (scores les plus hauts en premier)
- **Filtrer Score > 70** : Menu Données → Créer un filtre → Colonne Score > 70
- **Filtrer "Email Envoyé" vide** : Pour voir qui reste à contacter

### Exporter les données

Pour sauvegarder vos leads :
- Menu **Fichier** → **Télécharger** → **CSV** ou **Excel**

---

## ❓ Questions fréquentes

### Q1 : Puis-je utiliser plusieurs Google Sheets ?

**Réponse :** Oui ! Il suffit de :
1. Créer une nouvelle credential avec un autre compte
2. OU changer l'ID du document dans chaque node

### Q2 : Les workflows peuvent-ils écrire dans le même onglet ?

**Réponse :** Oui, mais attention :
- Workflow 1 et 2 écrivent dans des onglets **différents** (Leads vs Nouvelles PME)
- Workflow 3 lit et met à jour les **deux** onglets
- Workflow 4 lit et met à jour les **deux** onglets

### Q3 : Combien de lignes Google Sheets peut-il gérer ?

**Réponse :** Google Sheets peut contenir jusqu'à **10 millions de cellules**. Pour 16 colonnes, ça fait environ **625 000 lignes**. Largement suffisant !

### Q4 : Les données sont-elles sécurisées ?

**Réponse :** Oui :
- Google OAuth est sécurisé (norme industrielle)
- n8n n'a accès qu'aux Sheets que vous autorisez
- Vous pouvez révoquer l'accès à tout moment dans votre compte Google

### Q5 : Que faire si je renomme mon Google Sheet ?

**Réponse :** Rien ! L'ID du document reste le même. Le nom affiché peut changer sans problème.

---

## ✅ Vous avez terminé !

**Félicitations ! 🎉** Votre Google Sheet est maintenant connecté à n8n.

**Résumé de ce que vous avez fait :**
- ✅ Créé 2 onglets structurés (Leads + Nouvelles PME)
- ✅ Connecté votre compte Google à n8n via OAuth
- ✅ Assigné la credential aux 4 workflows (6 nodes)
- ✅ Testé avec succès le Workflow 1

**Prochaine étape :**
👉 **Configurer Brevo** pour envoyer les emails depuis val@talium.be

---

**Besoin d'aide ?** N'hésitez pas à me demander ! 🚀
