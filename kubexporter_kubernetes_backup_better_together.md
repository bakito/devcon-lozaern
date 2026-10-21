---
theme:
  slide_title:
    font_size: 2
  override:
    footer:
      style: template
      left: '**DevCon Lozärn 23.10.2026**'
      height: 3
    palette:
      classes:
        noice:
          foreground: red
---

<!-- newlines: 5 -->

![image:width:30%](kubexporter.png)

KubExporter  
(kubernetes) Backup better. Together.
====
<!-- alignment: center -->
<span style="color: #2e6ce6">Raphael Müller / Concordia &nbsp;&nbsp; Marc Brugger / Bison Group</span>

<!-- end_slide -->

<!-- // Include rmu Slides -->

<!-- include: kubexporter_beginnings.md -->
<!-- end_slide -->

<!-- include: kubexporter_intro.md -->
<!-- end_slide -->

<!-- include: kubexporter_at_work.md -->
<!-- end_slide -->
<!-- font_size: 2 -->

# Ursprung - wo kommt KubExporter her?
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* Community-Produkt auf Ruby-Basis wurde verwendet, um Kubernetes-Ressourcen zu sichern
    * Alle Ressourcen mussten explizit in der Konfiguration definiert werden – sonst wurden sie nicht gesichert
    * Ein Export eines Clusters dauerte über eine Stunde
    * Nach Einführung einer neuen CRD im Cluster wurde diese nicht in die Konfiguration aufgenommen → wir hatten keine Backups, wenn wir sie brauchten

<!-- incremental_lists: false -->

<!-- incremental_lists: true -->

* Entscheidung, ein neues Backup-Tool in go zu implementieren
    * Opt-Out statt Opt-In (Alle Ressourcen sind standardmässig enthalten)
    * Exportdauer auf < 30s reduziert
    * Läuft als CronJob → Keine permanenten Ressourcen erforderlich
    * Export nach Git → Vollständige Historie verfügbar

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Warum OpenSource
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* Grossteil der Zeit wurde privat ausserhalb des Unternehmens investiert
* OpenSource → Community-gesteuerte Entwicklung
* Neue Features werden von der Community angefordert/hinzugefügt
* Für alle zugänglich
    * Apache 2.0-Lizenz
* Integration in bestehende Paket-/Plugin-Manager
    * ❄️ nix
    * 🍺 brew
    * 🔌 krew (kubectl-Plugin)

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Funktionen
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* 🗲  Parallele Export-Worker
* 📊 Verschiedene Fortschrittsformate
* ☁️  S3 / Google Storage Bucket-Unterstützung
* 🔐 Secret-Maskierung oder -Verschlüsselung (age/AES)
* 📈 OTLP-Metriken
* 🔄 Owner-Reference-Migration (Wiederimport mit aktualisierten Owner-References)
* Möglichkeit für integration in git

<!-- incremental_lists: false -->

<!-- end_slide -->
<!-- font_size: 2 -->

# Wie / wann neue Funktionen hinzufügen?
<!-- newlines: 2 -->

<!-- incremental_lists: true -->

* ☁️  S3 / Google Storage Bucket-Unterstützung
    * Migration in die Cloud, wo Git keine Option war
* 🔐 Secret-Maskierung oder -Verschlüsselung
    * Bei der Arbeit mit Git ist es nicht sicher, den Inhalt von Secrets zu committen
* 📈 OTLP-Metriken
    * Regression nach Implementierung der Multi-Namespace-Auswahl. KubExporter wurde ohne Fehler beendet, hat aber nichts
      exportiert → Mit Metriken können wir Alerts basierend auf den Metriken einrichten.
* 🔄 Owner-Reference-Migration
    * Ressourcen, die in einem Cluster importiert wurden, in dem die übergeordneten Ressourcen neu erstellt wurden (neue UUID),
      wurden aufgrund ungültiger Owner-Reference gelöscht

<!-- incremental_lists: false -->


<!-- end_slide -->
<!-- font_size: 2 -->

# Demo

(Drücke `ctrl + e` zum Ausführen)

```bash +exec +acquire_terminal
clear
cd "${DEVBOX_PROJECT_ROOT}/kubexporter"
kubexporter --config demo-config.yaml -p bar --summary=false
echo
read -n 1 -s -r -p "Press any key to return to the presentation..."
```

<!-- end_slide -->
<!-- font_size: 2 -->

# Demo otel (OpenTelemetry) Metrics

If configures, metrics will be pushed to the otel collector if the sync is finished.
<!-- font_size: 1 -->
<!-- alignment: center -->

| Metric                                       | Description                                        |
|----------------------------------------------|----------------------------------------------------|
| kubexporter.duration_seconds                 | Total export duration in seconds                   |
| kubexporter.errors                           | Number of errors encountered during export         |
| kubexporter.exported_resources               | Total number of exported resources                 |
| kubexporter.exported_size_bytes              | Total size of exported resources in bytes          |
| kubexporter.kinds                            | Number of kinds processed                          |
| kubexporter.namespaces                       | Number of namespaces containing exported resources |
| kubexporter.query_pages                      | Total number of query pages requested              |
| kubexporter.resource.export_duration_seconds | Export duration per kind in seconds                |
| kubexporter.resource.exported_instances      | Number of exported resource instances per kind     |
| kubexporter.resource.exported_size_bytes     | Size of exported resources per kind in bytes       |
| kubexporter.resource.instances               | Number of resource instances found per kind        |
| kubexporter.resource.query_duration_seconds  | Query duration per kind in seconds                 |
| kubexporter.resource.query_pages             | Number of query pages per kind                     |


```bash +exec +pty:150:20
kubectl logs -l app=otel-collector -n otel --tail=-1 | grep exported.instances | cut -c40-200 
```

![alt text](image.png)