# Kubernetes-Cluster sichern: So einfach gehts

Kubexporter History

<!-- incremental_lists: true -->

* **Marc Brugger aka Bakito**: Das geht besser Mindset - und Morgen gibt es die Lösung auf Github
* **Raphael Müller aka Raphi**: Das KISS-Prinzip hat mich seit 1998 - Einfache Dinge zuerst


<!-- incremental_lists: false -->

<!-- end_slide -->

# Wo alles begann (once upon a time in zürich hardturm quartier)

Marc begann seinen Kubernetes Entwickler-Journey mit OpenShift 3 und bemängelte das Tooling ...
Dann kamen Custom-Ressourcen und Operator welche mit Go am besten Laufen ..
Plötzlich wurde aus OpenShift eine komplett customizde Enterprise Kubernetes Platform genau auf die Firma abgestummen .

Raphi kam aus der Linux-Welt hinzu und fing Feuer am definierten Zustand der Platform ...
Dann kam die Erkenntnis, dass Operator und Reconsilation Loops einem das Leben erleichtern ..
Plötzlich konnten Abläufe die in der alten Welt Monate brauchten, innerhalb 24 h abgearbeitet werden .



<!-- incremental_lists: true -->

* **Warum sind wir hier ?**
  * **OpenSource hilft bei der Zusammenarbeit auch in neuen Firmen** (Marc Bison, Raphi CONCORDIA)
  * **OpenSource hilft verbunden zu blieben** (PR's und )
  * **OpenSource hilft sich und das Produkt weiter zu entwickeln** (PR's und MR's für neue Features und Ideen)
  * **Opensource hilft anderen Kollegen und Firmen die selben Probleme anzugehen** (Wie macht Ihr ... ?)
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
