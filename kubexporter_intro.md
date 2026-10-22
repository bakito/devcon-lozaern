<!-- font_size: 2 -->

# Kubernetes-Cluster sichern: Die Realität

<!-- newlines: 2 -->
Herkömmliche Backup-Tools eignen sich **nicht** für Container.

<!-- incremental_lists: true -->

* **Schnelllebigkeit**: Container sind transient und ephemeral.
* **Falscher Fokus**: Klassische Datei- oder VM-Backups greifen hier ins Leere.

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->
# Gängige Kubernetes Backup-Tools

<!-- newlines: 2 -->
Spricht man über Kubernetes-Backups, fallen meistens diese Namen:

<!-- incremental_lists: true -->

* **Enterprise- & All-in-One-Lösungen**
  * **Velero** (Der Open-Source-Standard von VMware)
  * **Kasten K10** (Veeam – stark im Enterprise-Umfeld)
  * **TrilioVault** (Fokus auf Cloud-Native & App-Sicherung)
* **Storage- & Snapshot-Fokussiert**
  * **Longhorn** (Eingebautes Backup für verteilten Storage)
  * **OADP** (Red Hat Produkt, welches auf Velero aufsetzt)
  * **Portworx PX-Backup** (Fokus auf Multi-Cloud-Storage)

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Persistente Daten vs. Konfiguration
<!-- newlines: 2 -->

Die genannten Tools sind mächtig, haben aber oft einen Haken:
Sie sind darauf ausgelegt, persistente Volumes (PVs) zu sichern.

<!-- newlines: 2 -->
<!-- pause -->
### Unsere Philosophie:

<!-- incremental_lists: true -->

* Wir wollen möglichst **keine** persistenten Daten innerhalb von Kubernetes betreiben
* **Was wir wirklich brauchen:** Eine reine Sicherung der Config-Ressourcen!

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
