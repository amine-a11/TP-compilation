# TP1 👩‍🏫

## Table des matières
1. [Exercice 1](#exercice-1-)
    - [Partie 1](#partie-1-)
    - [Partie 2](#partie-2-)

## Exercice 1 🧮

### Partie 1 🛠️

- Programme Flex pour déterminer si une chaîne est un nombre binaire ou non.
- Commande à exécuter :

```bash
make exercice1-partie1
```

![Binaire](./images/exe01-00.jpg)

- Pour exécuter le programme binaire avec un fichier en entrée, utilisez la commande suivante :

```bash
make exercice1-partie1 ARGS=in.txt
```

- Pour permettre au programme d'écrire le résultat dans un fichier `resultat.txt`, vous devez changer le yyout de Flex pour qu'il pointe vers un fichier, comme suit :

```c
yyout = fopen("resultat.txt", "w");
```

- Sinon, assignez yyout à stdout :

```c
yyout = stdout;
```

- Ensuite, vous devez modifier les instructions printf pour écrire dans le yyout, qui peut être soit resultat.txt soit stdout :

```c
fprintf(yyout, "C'est un nombre binaire");
```

- Ainsi, si vous exécutez cette commande :

```bash
make exercice1-partie1 ARGS=in.txt
```

- Vous obtenez un fichier resultat.txt.

| Entrée | Sortie |
|--------|--------|
| ![Image d'entrée](./images/exe01-01.jpg) | ![Image de sortie](./images/exe01-02.jpg) |

- Remarque : En cas d'utilisation du WSL comme moi, exécutez cette commande sur in.txt pour supprimer les caractères invisibles :

```bash
sed -i 's/[^[:print:]]//g' in.txt
```

### Partie 2 🧩

```c
pairpair (aa|bb)*((ab|ba)(aa|bb)*(ab|ba)(aa|bb)*)*
%%
{pairpair} printf("[%s]: nombre pair de a et de b\n", yytext);
a*b* printf("[%s]: des a d'abord et des b ensuite\n", yytext);
. {}
%%
int yywrap() { return 1; }
int main() {
    yylex();
}
```

- Résultat du code sur les entrées : "babbaaab", "abbb", "aabb", "baabbbb", "bbaabbba", "baabbbbab", "aaabbbba".

![Image de sortie](./images/exe01-03.jpg)

- Après avoir permuté ces deux lignes :

```c
a*b* printf("[%s]: des a d'abord et des b ensuite\n", yytext);
{pairpair} printf("[%s]: nombre pair de a et de b\n", yytext);
```

- On obtient :

![Image de sortie](./images/exe01-04.jpg)

- Il y a une différence dans le mot "aabb" car ce mot appartient à {pairpair} et à a*b*, donc le message qui sera écrit est celui de l'expression régulière qui vient en premier.
