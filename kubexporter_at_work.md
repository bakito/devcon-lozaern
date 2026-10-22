<!-- font_size: 2 -->
# Kubernetes-Cluster sichern: So einfach gehts
<!-- newlines: 2 -->

Kubexporter im Schnelldurchlauf

<!-- incremental_lists: true -->

* **Kubexporter Schedulen**: Ein k8s-(Cron)-Job oder ein cli-command und schon wird gebackupt
* **Storage**: Von einem einfachen PV zu S3 und HyperScaler Cloudstorage: alles geht
* **Verschlüsselung**: Secrets aus-sterndlen ***, AES oder AGE verschlüsseln
* **Restore**: Ganze Directories, einzelne Dateien oder einfach nur "güxle" in Git


<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Warum das alles wirklich praktisch ist
<!-- newlines: 2 -->

Wieviele Male haben wir schon Configs überschrieben oder nicht mehr im Original gefunden ?

<!-- incremental_lists: true -->

* **Ressourcen Ressourcen Ressourcen**
  * **CR's welche nicht unter Git/Argo Kontrolle waren** (Der Klassiker)
  * **ConfigMaps, Secrets oder andere Ressource-Definitionen welche abhanden kamen** (Soll es auch im professionellen Umfeld geben)
  * **Cluster eigene Ressourcen, die sich geändert haben** (Wer kennt OLM ?)
  * **RBAC, Service-Accounts und Konsorten** (Haben wir das nicht ge-GitOpst ?)
* **Murphy is in the house**
  * **Namespace Configs** (Aber ich dachte, wir hätten ...)
  * **Cluster Upgrades** (War vor dem Upgrade ganze sicher anders)
  * **Fat Fingers** (Ooops I did it again)

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Diff is your friend
<!-- newlines: 1 -->
```bash
diff -u snap1/kubexporter-test/ConfigMap.diff-hello.yaml snap2/kubexporter-test/ConfigMap.diff-hello.yaml
```
<!-- newlines: 1 -->

```diff
--- snap1/kubexporter-test/ConfigMap.diff-hello.yaml	2026-10-22 16:19:55.912027563 +0200
+++ snap2/kubexporter-test/ConfigMap.diff-hello.yaml	2026-10-22 16:19:56.125027564 +0200
@@ -1,6 +1,6 @@
 apiVersion: v1
 data:
-  hello: World
+  hello: Lucerne
 kind: ConfigMap
 metadata:
   name: diff-hello
```
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* Einfache Intregration in eine Git basierte Versionsverwaltung
* Git eigene Commit History hilft enorm
* **Git Repo Magic** Repositories können durch Git Tooling verwaltet werden

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Was macht KubExporter so stark?
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* **Automatische Erkennung**: Exportiert standardmässig alle Ressourcen. Neue CRDs werden automatisch erfasst.
* **Flexibilität**: Exportiert wahlweise als **YAML** oder **JSON**.
* **Bereinigung**: Unerwünschte Ressourcen und Standard-Metadaten lassen sich gezielt ausschliessen.

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Installation & Verwendung
<!-- newlines: 2 -->

### Schnelle Installation
```bash
# Als kubectl Plugin via Krew
kubectl krew install exporter

# Oder via Homebrew
brew install --cask kubexporter
```
<!-- newlines: 2 -->
### Einfacher Aufruf
```bash
# Exportiert standardmässig in den Ordner "exports"
kubectl exporter
```

<!-- end_slide -->
<!-- font_size: 2 -->

# Fazit
<!-- newlines: 2 -->
<!-- incremental_lists: true -->

* Container-Backups neu gedacht
* Fokus auf das, was zählt: **Die Infrastruktur als Code**
* Schlank, effizient und perfekt für die CI/CD-Pipeline
