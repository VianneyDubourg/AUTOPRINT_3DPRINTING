## AUTOPRINT_3DPRINTING

This repository is built to show you how to print automatically with your 3D printer. No additional hardware is required, and this method works with almost all slicers. For example, in this tutorial, we discuss the Ender 3 V3 KE.

You can watch a video of the printer in action here: https://www.youtube.com/shorts/Ip12LMHYTdg .

inspired by this video : https://www.youtube.com/watch?v=avlengYsJdw&t=514s&ab_channel=MakeAnything

---

### Tutorial

1. Open your slicer software and go to your printer setting.
2. 
   
   ![image](https://github.com/user-attachments/assets/d81aa235-df29-4b29-9bfd-3652f957b01b)

   ![image](https://github.com/user-attachments/assets/7f17854d-b333-40f5-adbb-1afb2d0b4d6f)

   
3. Then go to the section for end gcode and type this :


   ![image](https://github.com/user-attachments/assets/01f9e6a3-f266-4ab8-9632-fe48ab6a657e)


### Décomposition du code

#### 1. **Déplacement initial de la tête d'impression vers le haut et l'arrière**  
```gcode
G1 X105 Y195 Z50 F3000 ; Move up and back
```
- `G1` : C'est une commande pour déplacer la tête d'impression en utilisant une vitesse spécifique.
- `X105 Y195 Z50` : Indique la position cible en millimètres dans les axes **X** (gauche/droite), **Y** (avant/arrière), et **Z** (haut/bas).
- `F3000` : Définit la vitesse de déplacement (3000 mm/min).

💡 **Explication simplifiée** : Cette ligne dit à l'imprimante **d'éloigner la tête d'impression et de la monter à 50 mm de hauteur** après l'impression.

---

#### 2. **Jouer une mélodie avec le buzzer de l'imprimante**
```gcode
M300 S3520 P200 ; A7
M300 S4698.63 P200 ; D8
M300 S5274.04 P200 ; E8
M300 S6271.93 P200 ; G8
```
- `M300` : Commande pour jouer un son sur le buzzer de l'imprimante.
- `S3520` : Fréquence du son en Hertz (Hz).
- `P200` : Durée du son en millisecondes (200 ms).

💡 **Explication simplifiée** : Ce bout de code joue une **courte mélodie** en émettant différents sons à des fréquences précises.

---

#### 3. **Abaisser la tête d'impression près du plateau**
```gcode
G1 X105 Y195 Z1 F3000 ; Lower
```
- `Z1` : Abaisse la tête d'impression à **1 mm** du plateau.
- `F3000` : Vitesse de déplacement.

💡 **Explication simplifiée** : La tête descend à une hauteur de **1 mm**, probablement en préparation pour l'éjection de l'impression terminée.

---

#### 4. **Éjection de l'impression**
```gcode
G1 X105 Y1 Z1 F2400 ; Remove Print
```
- `Y1` : Déplace la tête d'impression **vers l'avant du plateau**.
- `F2400` : Définit la vitesse à **2400 mm/min**.

💡 **Explication simplifiée** : L'imprimante **pousse la pièce imprimée vers l'avant** pour la retirer.

---

#### 5. **Secouer la pièce pour la détacher**
```gcode
G1 X105 Y30 Z1 F8000 ; Shake it out
G1 X105 Y1 Z1 F8000 ; Shake it out
G1 X105 Y30 Z1 F8000 ; Shake it out
```
- **Ces trois lignes font osciller la tête entre Y = 1 mm et Y = 30 mm très rapidement (F8000)**.

💡 **Explication simplifiée** : L'imprimante **fait un mouvement de va-et-vient rapide** pour essayer de détacher la pièce du plateau.

---

#### 6. **Rétraction du filament**
```gcode
G1 E-2 F2700 ;Retract a bit 
```
- `E-2` : **Rétracte 2 mm de filament** pour éviter qu'il ne coule après l'impression.
- `F2700` : Définit la vitesse de rétraction.

💡 **Explication simplifiée** : Cela **évite les fuites de filament** quand l'impression est terminée.

---

#### 7. **Commandes en commentaire (non exécutées)**
```gcode
; G91 ;Relative positionning 
; G1 E-2 Z0.2 F2400 ;Retract and raise Z 
; G1 X5 Y5 F3000 ;Wipe out 
; G1 Z5 ;Raise Z more 
; G90 ;Absolute positionning 
```
- **Les points-virgules (`;`) indiquent que ces lignes sont des commentaires**.  
- Ces lignes auraient permis :
  - De passer en **mode de position relative** (`G91`).
  - De **rétracter un peu plus de filament et lever la tête d’impression** (`G1 E-2 Z0.2`).
  - D'effectuer un **mouvement de nettoyage** (`G1 X5 Y5`).
  - De **remettre l'imprimante en mode absolu** (`G90`).

💡 **Explication simplifiée** : Ces lignes sont désactivées, mais elles servaient probablement à **ajouter des précautions supplémentaires après l'impression**.

---

#### 8. **Présenter l'impression à l'utilisateur (Désactivé)**
```gcode
; G1 X2 Y218 F3000 ;Present print 
```
- `G1 X2 Y218` : Déplace la tête à une position spécifique pour "montrer" l'impression à l'utilisateur.
- `F3000` : Définit la vitesse.

💡 **Explication simplifiée** : Cela permettrait **de ramener la tête d'impression à une position plus visible**.

---

#### 9. **Éteindre les composants**
```gcode
; M106 S0 ;Turn-off fan 
; M104 S0 ;Turn-off hotend 
; M140 S0 ;Turn-off bed 
```
- `M106 S0` : **Éteint le ventilateur**.
- `M104 S0` : **Éteint la buse**.
- `M140 S0` : **Éteint le plateau chauffant**.

💡 **Explication simplifiée** : Ces commandes éteignent **les composants chauffants et les ventilateurs** pour économiser de l’énergie.

---

#### 10. **Désactiver les moteurs**
```gcode
; M84 X Y E ;Disable all steppers but Z
```
- `M84 X Y E` : Désactive **les moteurs des axes X, Y et de l'extrudeur**, mais garde Z actif.

💡 **Explication simplifiée** : Désactive certains moteurs pour **éviter une surchauffe et économiser de l'énergie**.

    

