# Kubernetes-Cluster sichern: So einfach gehts

Kubexporter im Schnelldurchlauf

<!-- incremental_lists: true -->

* **Kubexporter Schedulen**: Ein k8s-(Cron)-Job oder ein cli-command und schon wird gebackupt
* **Storage**: Von einem einfachen PV zu S3 und HyperScaler Cloudstorage: alles geht
* **Verschlüsselung**: Secrets aus-sterndlen ***, AES oder AGE verschlüsseln
* **Restore**: Ganze Directories, einzelne Dateien oder einfach nur "güxle" in Git


<!-- incremental_lists: false -->

<!-- end_slide -->

# Warum das alles wirklich praktisch ist

Wieviele Male haben wir schon Configs überschrieben oder nicht mehr im Original gefunden ?

<!-- incremental_lists: true -->

* **Ressourcen Ressourcen Ressourcen**
  * **CR's welche nicht unter Git/Argo Kontrolle waren** (Der Klassiker)
  * **ConfigMaps, Secrets oder andere Resouce-Definitionen welche abhanden kamen** (Soll es auch im professionellen Umfeld geben)
  * **Cluster eigene Resourcen welche sich geändert haben** (Wer kennt OLM ?)
  * **RBAC, Service-Accounts und Konsorten** (Haben wir das nicht ge-Gitopst ?)
* **Murphy is in the house**
  * **Namespace Configs** (Aber ich dachte, wir hätten ...)
  * **Cluster Upgrades** (War vor dem Upgrade ganze sicher anders)
  * **Fat Fingers** (Ooops I did it again)

<!-- incremental_lists: false -->

<!-- end_slide -->

# Diff is your friend

Config vor und nach der Änderung vergleichen: yep
Audit-Log zeigt in eine bestimmte Richtung ?: vergleichen wir die Config

### Git is your friend

<!-- incremental_lists: true -->

* Einfache Intregration in eine Git basierte Versionsverwaltung
* Git eigene Commit History hilft enorm
* **Git Repo Magic** Repositories können durch Git Tooling verwaltet werden

<!-- incremental_lists: false -->

<!-- end_slide -->

# Die Lösung: KubExporter

Auf GitHub finden wir genau das Werkzeug, das uns diese Arbeit abnimmt:
👉 `https://github.com/bakito/kubexporter`

> "KubExporter allows you to export resources from kubernetes as yaml/json files."

<!-- end_slide -->

# Was macht KubExporter so stark?

<!-- incremental_lists: true -->

* **Automatische Erkennung**: Exportiert standardmässig alle Ressourcen. Neue CRDs werden automatisch erfasst.
* **Flexibilität**: Exportiert wahlweise als **YAML**, **JSON** oder **kubernets yaml/kyaml**.
* **Bereinigung**: Unerwünschte Ressourcen und Standard-Metadaten lassen sich gezielt ausschliessen.

<!-- incremental_lists: false -->

<!-- end_slide -->

# Installation & Verwendung

### Schnelle Installation
```bash
# Als kubectl Plugin via Krew
kubectl krew install exporter

# Oder via Homebrew
brew install --cask kubexporter
```

### Einfacher Aufruf
```bash
# Exportiert standardmässig in den Ordner "exports"
kubectl exporter
```

<!-- end_slide -->

# Advanced Features (Ausblick)

KubExporter bietet nativen Support für moderne GitOps- und Backup-Workflows:

<!-- incremental_lists: true -->

* 📦 **Archivierung**: Direktes Packen als `.tar.gz` mit Upload in **S3** oder **GCS**.
* 🔐 **Security**: Integrierte Ver- und Entschlüsselung von Secrets mittels **Age** oder **AES**.
* 📊 **Monitoring**: Liefert OTel-Metriken inklusive vorgefertigtem **Grafana-Dashboard**.
* 🦉 **Versionskontrolle**: Exporte lassen sich einfach in eine Git-Versionierung integrieren.


<!-- incremental_lists: false -->

<!-- end_slide -->

# Fazit

* Container-Backups neu gedacht.
* Fokus auf das, was zählt: **Die Infrastruktur als Code**.
* Schlank, effizient und perfekt für die CI/CD-Pipeline.

<!-- end_slide -->
