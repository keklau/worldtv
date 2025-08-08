
# World TV — Release Signing (GitHub Actions)

Ce guide te permet d'obtenir un **APK Release signé** automatiquement via **GitHub Actions**.

## 1) Créer un keystore de signature

Exécute sur ta machine (macOS / Linux / WSL) :
```bash
keytool -genkeypair -v   -keystore worldtv.jks   -alias worldtv   -keyalg RSA -keysize 2048 -validity 3650
```
> Garde **précieusement** le fichier `worldtv.jks` et les mots de passe saisis.

## 2) Encoder le keystore en Base64
```bash
base64 worldtv.jks > worldtv.jks.b64
```

## 3) Ajouter les **Secrets** dans ton dépôt GitHub
Dans **Settings → Secrets and variables → Actions → New repository secret**, ajoute :

- `ANDROID_KEYSTORE_BASE64` : contenu du fichier `worldtv.jks.b64`
- `STORE_PASSWORD` : mot de passe du **keystore**
- `KEY_ALIAS` : `worldtv` (ou celui que tu as choisi)
- `KEY_PASSWORD` : mot de passe de la **clé**

## 4) Workflow déjà prêt
Le workflow `.github/workflows/android.yml` :
- Build **Debug APK** (toujours)
- Build **Release APK** **signé** si les secrets ci-dessus sont définis
- Publie les artefacts : `WorldTV-debug-apk` et `WorldTV-release-apk`

## 5) Récupérer l'APK Release
Va dans l’onglet **Actions** → ouvre le dernier run → section **Artifacts** → télécharge **WorldTV-release-apk**.

## Remarques
- La signature Release n'empêche pas l'avertissement "Sources inconnues" lors d'une installation **hors Play Store** ; c'est normal pour tout APK sideloadé.
- Tu peux modifier le nom d'alias/keystore ; mets bien la même valeur dans `KEY_ALIAS`.
- Si tu veux générer un **App Bundle (.aab)** pour le Play Store, ajoute une étape :
  ```bash
  ./gradlew :app:bundleRelease
  ```
  et upload l’artefact `app/build/outputs/bundle/release/*.aab`.
