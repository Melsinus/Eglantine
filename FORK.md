# Eglantine - Fork de ZendNevs

Fork non officiel de l'émulateur Switch 2 Eglantine : un seul émulateur pour tous les jeux, réglé en priorité pour Mario Kart World.

Testé sur un seul PC : Ryzen 5 5500X3D, RTX 4070, 16 Go de RAM.

## D'où vient le code

- [Djihads80/Eglantine](https://github.com/Djihads80/Eglantine), branche `nx2`, jusqu'au build-104
- [PokeDinner](https://git.eden-emu.dev/Franseven/PokeDinner-a-Eglantine-Fork) de Franseven
- [Selevet Eglantine](https://github.com/sylvieistaken/selevet-eglantine), détaillé dans [tuned/README.md](tuned/README.md)
- Eden et yuzu, à la base de tous ces projets

Tout le mérite de l'émulateur leur revient. Ce fork n'est une version officielle d'aucun d'eux : ne leur signale pas les problèmes que tu rencontres ici.

## Ce qui change ici

**Mario Kart World**
- Options 30 FPS et FPS dynamique dans Graphismes > Avancé, pour les versions 1.0.0 et 1.8.0.
- Option FPS dynamique pour Donkey Kong Bananza dans Graphismes > Avancé, cochée par défaut.
- Les dessins dont les arguments sont écrits par le GPU restent côté GPU, ce qui supprime la plupart des attentes de relecture.
- Mémoire du programme plafonnée à 4 Go pour ce jeu (`EDEN_NX2_RAM_LIMIT_MIB`, 0 pour couper).

**Génération d'images**
- La case de la génération d'images apparaît dans les réglages graphiques et reste cochée.
- Lsfg fonctionne sur les cartes NVIDIA récentes, où il était coupé sans message.
- Fsr3 interpole entre deux vraies images. Il reste limité sur les mouvements rapides, où il fait plutôt un fondu.

**Donkey Kong Bananza**
- Instructions de shader natives ajoutées (HSETP2 et multiplication de matrices), qui évitent des écrans violets.
- Le rythme d'affichage suit chaque rafraîchissement de 60 Hz.

**Divers**
- Les syncpoints hors limites sont ignorés au lieu de planter.
- `eden-cli` affiche la progression du chargement des shaders.
- Outils de mesure pour les tests automatiques (`EDEN_NX2_KEY_LIVE`, `EDEN_NX2_SAMPLE_SLICE`).

## Résultats

Mario Kart World 1.8.0, Circuit Mario Bros, résolution 1x, mode portable, FPS dynamique, courses de 3 minutes : environ 56 fps en moyenne et 44 à 50 fps sur les 10 % les plus bas. Ce n'est pas un 60 fps stable, et ces chiffres datent d'avant les correctifs de génération d'images.

## Problèmes connus

- Une course de test sur 5 s'est arrêtée brutalement au bout d'une minute, sans erreur. Cela ne s'est pas reproduit et la cause reste inconnue.
- Ne monte jamais le réglage d'overclock du processeur sur Mario Kart World : le jeu croit alors que ses images sont lentes et reste bloqué à 30 fps.

## Ce qu'il te faut

- Un processeur avec AVX2.
- Tes propres clés, firmware et jeux. Rien n'est fourni.
- Pour Lsfg, ton propre `Lossless.dll` (application Lossless Scaling), à placer dans `user\lossless\`. Il n'est pas fourni non plus.

## Compiler

Il faut Visual Studio 2022 avec les outils C++, et un dossier d'outils qui contient :

| Dossier | Contenu |
|---|---|
| `LLVM` | Clang 23 |
| `cmake`, `ninja` | CMake et Ninja |
| `glslang\bin` | `glslangValidator.exe` |
| `Qt\6.10.2\msvc2022_64` | Qt, le Qt fourni par le projet ne compile pas avec MSVC 14.44 |

```bat
set TOOLS=J:\dev\tools
tuned\build-windows.bat
```

Le résultat arrive dans `build-clang\bin`. Compte environ 45 minutes la première fois, et 16 Go de RAM sont justes : ferme le reste pendant la dernière étape.

## Licence et IA

GPL-3.0-or-later, comme les projets d'origine. Voir `LICENSE.txt`.

Les changements de ce fork ont été écrits avec Claude (Anthropic), puis testés en jeu par le propriétaire du dépôt. Les développeurs d'Eglantine ne les ont pas relus.
