%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

/* --- MOTS-CLÉS DE STRUCTURE --- */
%token BeginProject_mc EndProject_mc
%token Setup_mc Run_mc

/* --- MOTS-CLÉS DE DÉCLARATION ET TYPES --- */
%token define_mc const_mc
%token int_mc float_mc

/* --- STRUCTURES DE CONTRÔLE --- */
%token if_mc then_mc else_mc endIf_mc
%token loop_mc while_mc endloop_mc
%token for_mc in_mc to_mc endfor_mc

/* --- ENTRÉE / SORTIE --- */
%token out_mc

/* --- OPÉRATEURS LOGIQUES (Majuscules) --- */
%token AND_mc OR_mc NON_mc

/* --- OPÉRATEURS ARITHMÉTIQUES ET COMPARAISON --- */
%token addition sustra multipl div_op
%token supperieure inferieure

/* --- OPÉRATEURS D'AFFECTATION ET SPÉCIAUX --- */
%token affectation    /* <- */
%token barre_mc       /* |  */

/* --- DÉLIMITEURS ET SYMBOLES --- */
%token deux_points    /* :  */
%token point_virg     /* ;  */
%token point          /* .  */
%token egal          /* =  */
%token virg         /* ,  */
%token parenthese_ouvrante parenthese_fermante /* ( ) */
%token accolade_ouvrante  accolade_fermante   /* { } */
%token crochet_ouvrant    crochet_fermant      /* [ ] */

/* --- IDENTIFICATEURS ET VALEURS --- */
/* Ces tokens correspondent aux définitions Regex de ton Flex */
%token idf
%token cst_int
%token cst_float
%token chaine


%start S
%%



/* --- II.1. STRUCTURE GÉNÉRALE --- */

S : BeginProject_mc idf point_virg SECTION_SETUP SECTION_RUN EndProject_mc point_virg
    { printf("Felicitations : La structure du programme ProLang est valide !\n"); }
  ;

/* --- II.2. PARTIE DÉCLARATION (Setup) --- */

SECTION_SETUP : Setup_mc deux_points LISTE_DECLARATIONS
              ;

LISTE_DECLARATIONS : UNE_DECLARATION LISTE_DECLARATIONS
                   | /* vide */
                   ;

UNE_DECLARATION : DECL_DEFINE
                | DECL_CONSTANTE
                ;

/* --- DEFINE (variables ou tableau) --- */

DECL_DEFINE : define_mc idf LISTE_IDFS_SUITE deux_points SUITE_TYPE
            ;

/* gestion du | */
LISTE_IDFS_SUITE : barre_mc idf LISTE_IDFS_SUITE
                 | /* vide */
                 ;

/* après ":" on décide si c'est tableau ou variable */
SUITE_TYPE : TYPE OPT_INIT point_virg
           | crochet_ouvrant TYPE point_virg ENTIER crochet_fermant point_virg
           ;

/* initialisation optionnelle */
OPT_INIT : egal VALEUR
         | /* vide */
         ;

/* constante */

DECL_CONSTANTE : const_mc idf deux_points TYPE egal VALEUR point_virg
               ;

/* types */

TYPE : int_mc
     | float_mc
     ;

/* valeurs modifiées pour utiliser les nombres signés/non-signés */
VALEUR : ENTIER
       | REEL
       ;

/* --- SECTION RUN (Instructions) --- */

SECTION_RUN : Run_mc deux_points accolade_ouvrante LISTE_INSTRUCTIONS accolade_fermante
            ;

/* On utilise la récursion pour accepter 0, 1 ou plusieurs instructions */
LISTE_INSTRUCTIONS : LISTE_INSTRUCTIONS UNE_INSTRUCTION
                   | /* vide */
                   ;

UNE_INSTRUCTION : INSTRUCTION_AFFECTATION
                | INSTRUCTION_CONDITION
                | INSTRUCTION_BOUCLE
                | INSTRUCTION_IO
                ;

/* 1. Affectation : Idf <- Expression ; ou Idf [5] <- Expression ; */
INSTRUCTION_AFFECTATION : idf affectation EXPRESSION point_virg
                        | idf crochet_ouvrant ENTIER crochet_fermant affectation EXPRESSION point_virg
                        ;

/* 2. Condition : if (condition) then { %% } else { %% } endIf ; */
INSTRUCTION_CONDITION : if_mc parenthese_ouvrante CONDITION parenthese_fermante then_mc 
                        accolade_ouvrante LISTE_INSTRUCTIONS accolade_fermante
                        else_mc 
                        accolade_ouvrante LISTE_INSTRUCTIONS accolade_fermante
                        endIf_mc point_virg
                      ;

/* 3. Boucles : loop while et for */
INSTRUCTION_BOUCLE : loop_mc while_mc parenthese_ouvrante CONDITION parenthese_fermante 
                     accolade_ouvrante LISTE_INSTRUCTIONS accolade_fermante 
                     endloop_mc point_virg
                   
                   | for_mc idf in_mc VALEUR to_mc VALEUR 
                     accolade_ouvrante LISTE_INSTRUCTIONS accolade_fermante 
                     endfor_mc point_virg
                   ;

/* 4. Entrée / Sortie */
INSTRUCTION_IO : out_mc parenthese_ouvrante LISTE_OUT parenthese_fermante point_virg
               | in_mc parenthese_ouvrante idf parenthese_fermante point_virg
               ;

LISTE_OUT : chaine
          | chaine virg idf
          | idf
          ;

/* --- DÉFINITION DES EXPRESSIONS --- */

EXPRESSION : EXPRESSION addition TERME
           | EXPRESSION sustra TERME
           | TERME
           ;

TERME : TERME multipl FACTEUR
      | TERME div_op FACTEUR
      | FACTEUR
      ;

/* Facteurs modifiés pour utiliser ENTIER et REEL */
FACTEUR : idf
        | ENTIER
        | REEL
        | idf crochet_ouvrant ENTIER crochet_fermant  /* Pour lire Tab[i] */
        | parenthese_ouvrante EXPRESSION parenthese_fermante
        ;

/* --- CONDITIONS --- */

CONDITION : EXPRESSION OPERATEUR_COMP EXPRESSION
          | parenthese_ouvrante CONDITION parenthese_fermante
          | CONDITION AND_mc CONDITION
          | CONDITION OR_mc CONDITION
          | NON_mc CONDITION
          ;

OPERATEUR_COMP : supperieure 
               | inferieure 
               | egal 
               | '!' '='  
               ;

/* --- GESTION DES NOMBRES --- */

ENTIER : cst_int
       | parenthese_ouvrante SIGNE cst_int parenthese_fermante
       ;

REEL : cst_float
     | parenthese_ouvrante SIGNE cst_float parenthese_fermante
     ;

SIGNE : addition
      | sustra
      ;


%%
void yyerror(const char *s) {
    extern int nb_ligne;
    fprintf(stderr, "Erreur syntaxique a la ligne %d: %s\n", nb_ligne, s);
}

int main() {
    yyparse();
    return 0;
}
int yywrap() { return 1; }