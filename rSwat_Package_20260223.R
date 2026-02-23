# =============================================================================
# SWAT+ ECOSYSTEM — Installation et chargement des packages R
# =============================================================================
# Auteur      : Steven Chouto
# Date        : 2025
# Description : Script d'installation et de vérification de l'ensemble des
#               packages R nécessaires à la modélisation hydrologique SWAT+.
#               Couvre la préparation des données, la construction du modèle,
#               la calibration, le diagnostic et la lecture des résultats.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. CONFIGURATION GLOBALE-----------------------------------------------------
# -----------------------------------------------------------------------------

# Augmenter le délai d'expiration des téléchargements (utile pour les gros
# packages hébergés sur GitHub ou des connexions lentes)
options(timeout = 9999)

# Vérifier et installer les gestionnaires de packages si absents
if (!requireNamespace("remotes",  quietly = TRUE)) install.packages("remotes")
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
if (!requireNamespace("pak",      quietly = TRUE)) install.packages("pak")


# -----------------------------------------------------------------------------
# 1. PRÉPARATION DES DONNÉES — SWATprepR---------------------------------------
# -----------------------------------------------------------------------------
# Outils pour préparer les données d'entrée du modèle SWAT+ :
# météo, sols, occupation du sol, données de calibration, etc.
# Dépôt : https://github.com/biopsichas/SWATprepR

remotes::install_github("biopsichas/SWATprepR")


# -----------------------------------------------------------------------------
# 2. CALIBRATION ET TUNING — SWATtunR------------------------------------------
# -----------------------------------------------------------------------------
# Fonctions pour la calibration automatisée et le réglage des paramètres
# du modèle SWAT+.
# Dépôt : https://github.com/biopsichas/SWATtunR

remotes::install_github("biopsichas/SWATtunR")


# -----------------------------------------------------------------------------
# 3. LECTURE DE FICHIERS TABULAIRES — readr (tidyverse)------------------------
# -----------------------------------------------------------------------------
# Package de lecture rapide de fichiers CSV/TSV/texte, utilisé en support
# par plusieurs packages SWAT+.
# Installé via pak pour une résolution propre des dépendances.

pak::pak("tidyverse/readr")


# -----------------------------------------------------------------------------
# 4. CONSTRUCTION DU PROJET SWAT+ — SWATbuildR---------------------------------
# -----------------------------------------------------------------------------
# Permet de construire ou modifier la structure d'un projet SWAT+ directement
# depuis R (fichiers .sqlite, paramètres du modèle, etc.).
# Dépôt : https://github.com/chrisschuerz/SWATbuildR

remotes::install_github("chrisschuerz/SWATbuildR")


# -----------------------------------------------------------------------------
# 5. GESTION DES PRATIQUES AGRICOLES — SWATfarmR-------------------------------
# -----------------------------------------------------------------------------
# Outils pour définir et gérer les rotations culturales, les opérations
# culturales et les pratiques de gestion agricole dans SWAT+.
# Dépôt : https://github.com/chrisschuerz/SWATfarmR

remotes::install_github("chrisschuerz/SWATfarmR")


# -----------------------------------------------------------------------------
# 6. DIAGNOSTIC DU MODÈLE — SWATdoctR (installation locale)--------------------
# -----------------------------------------------------------------------------
# Package de diagnostic et de contrôle qualité du modèle SWAT+.
# Installé depuis une archive locale (.zip) car non disponible sur GitHub public.
#
# ⚠  Modifier le chemin ci-dessous selon votre environnement.
# Exemple Windows : "S:/ToDELETE/swatdoctr-main.zip"
# Exemple Linux   : "/media/partage/swatdoctr-main.zip"

LOCAL_SWATDOCTR_PATH <- "S:/ToDELETE/swatdoctr-main.zip"  # <-- À adapter

remotes::install_local(LOCAL_SWATDOCTR_PATH)

# Chargement et vérification de la version installée
library(SWATdoctR)
cat("Version SWATdoctR installée :", as.character(packageVersion("SWATdoctR")), "\n")


# -----------------------------------------------------------------------------
# 7. MESURES ET DONNÉES OBSERVÉES — SWATmeasR----------------------------------
# -----------------------------------------------------------------------------
# Gestion et intégration des données de mesures (débits, charges sédimentaires,
# nutriments…) pour la comparaison modèle/observations.
# Dépôt : https://github.com/chrisschuerz/SWATmeasR

remotes::install_github("chrisschuerz/SWATmeasR")


# -----------------------------------------------------------------------------
# 8. LECTURE DES SORTIES SWAT+ — SWATreadR-------------------------------------
# -----------------------------------------------------------------------------
# Importation et mise en forme des fichiers de sortie du modèle SWAT+
# (débits, variables de bassin versant, variables HRU, etc.).
# Dépôt : https://github.com/chrisschuerz/SWATreadR

remotes::install_github("chrisschuerz/SWATreadR")


# -----------------------------------------------------------------------------
# 9. EXÉCUTION ET ANALYSE DU MODÈLE — SWATplusR--------------------------------
# -----------------------------------------------------------------------------
# Interface principale pour lancer des simulations SWAT+, effectuer des
# analyses de sensibilité et des calibrations depuis R.
# Dépôt : https://github.com/chrisschuerz/SWATplusR

devtools::install_github("chrisschuerz/SWATplusR")


# -----------------------------------------------------------------------------
# 10. JEUX DE DONNÉES D'EXEMPLE — SWATdata-------------------------------------
# -----------------------------------------------------------------------------
# Données de démonstration pour tester et illustrer les fonctionnalités
# des autres packages SWAT+.
# Dépôt : https://github.com/chrisschuerz/SWATdata

devtools::install_github("chrisschuerz/SWATdata")


# =============================================================================
# VÉRIFICATION GLOBALE DES INSTALLATIONS
# =============================================================================
# Liste de tous les packages SWAT+ à vérifier

swat_packages <- c(
  "SWATprepR", "SWATtunR",   "readr",
  "SWATbuildR", "SWATfarmR", "SWATdoctR",
  "SWATmeasR",  "SWATreadR", "SWATplusR",
  "SWATdata"
)

cat("\n--- Statut des packages SWAT+ ---\n")
for (pkg in swat_packages) {
  installed <- requireNamespace(pkg, quietly = TRUE)
  version   <- if (installed) as.character(packageVersion(pkg)) else "NON INSTALLÉ"
  status    <- if (installed) "✔" else "✘"
  cat(sprintf("  %s  %-15s  %s\n", status, pkg, version))
}
cat("---------------------------------\n")

# =============================================================================
# FIN DU SCRIPT
# =============================================================================
