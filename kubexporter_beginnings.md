# Kubernetes-Cluster sichern: So einfach gehts

Kubexporter History

<!-- incremental_lists: true -->

* **Marc Brugger aka Bakito**: "Das geht besser"-Mindset - und Morgen gibt es die Lösung auf Github
* **Raphael Müller aka Raphi Milla**: "KISS-Prinzip"-Mindset - Einfache Dinge zuerst


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
  * **OpenSource hilft verbunden zu blieben** (und wenn nur schon über PR's und Issues)
  * **OpenSource hilft sich und das Produkt weiter zu entwickeln** (PR's und MR's für neue Features und Ideen)
  * **Opensource hilft anderen Kollegen und Firmen die selben Probleme anzugehen** (Wie macht Ihr ... ?)
* **Murphy lauert immer und überall - Begenem wir ihm vorbereitet**
  * **Namespace Configs** (Aber ich dachte, wir hätten ...)
  * **Cluster Upgrades** (War vor dem Upgrade ganz sicher anders)
  * **Fat Fingers** (Ooops I did it again)

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
* **Flexibilität**: Exportiert wahlweise als **YAML**, **JSON**.
* **Bereinigung**: Unerwünschte Ressourcen und Standard-Metadaten lassen sich gezielt ausschliessen.

<!-- end_slide -->