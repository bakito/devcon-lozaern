# Kubernetes-Cluster sichern: Die Realität

Herkömmliche Backup-Tools eignen sich **nicht** für Container.

<!-- incremental_lists: true -->

* **Schnelllebigkeit**: Container sind transient und ephemeral.
* **Falscher Fokus**: Klassische Datei- oder VM-Backups greifen hier ins Leere.

<!-- incremental_lists: false -->

<!-- end_slide -->

# Gängige Kubernetes Backup-Tools

Wenn man über Kubernetes-Backups spricht, fallen meistens diese Namen:

<!-- incremental_lists: true -->

* **Enterprise- & All-in-One-Lösungen**
  * **Velero** (Der Open-Source-Standard von VMware)
  * **Kasten K10** (Veeam – stark im Enterprise-Umfeld)
  * **TrilioVault** (Fokus auf Cloud-Native & App-Sicherung)
* **Storage- & Snapshot-Fokussiert**
  * **Longhorn** (Eingebautes Backup für verteilten Storage)
  * **OADP** (Red Hat Produkt welches auf Velero aufsetzt)
  * **Portworx PX-Backup** (Fokus auf Multi-Cloud-Storage)

<!-- incremental_lists: false -->

<!-- end_slide -->

# Persistente Daten vs. Konfiguration

Die genannten Tools sind mächtig, haben aber oft einen Haken:
Sie sind darauf ausgelegt, persistente Volumes (PVs) zu sichern.

### Unsere Philosophie:

<!-- incremental_lists: true -->

* Wir wollen möglichst **keine** persistenten Daten innerhalb von Kubernetes betreiben.
* **Was wir wirklich brauchen:** Eine reine Sicherung der Config-Ressourcen!

<!-- incremental_lists: false -->

<!-- end_slide -->

# Die Lösung: KubExporter

Auf GitHub finden wir genau das Werkzeug, das uns diese Arbeit abnimmt:

#TODO
# --> screenshot eines kubexporter file-systems ??
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