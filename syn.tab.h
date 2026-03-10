
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BeginProject_mc = 258,
     EndProject_mc = 259,
     Setup_mc = 260,
     Run_mc = 261,
     define_mc = 262,
     const_mc = 263,
     int_mc = 264,
     float_mc = 265,
     if_mc = 266,
     then_mc = 267,
     else_mc = 268,
     endIf_mc = 269,
     loop_mc = 270,
     while_mc = 271,
     endloop_mc = 272,
     for_mc = 273,
     in_mc = 274,
     to_mc = 275,
     endfor_mc = 276,
     out_mc = 277,
     AND_mc = 278,
     OR_mc = 279,
     NON_mc = 280,
     addition = 281,
     sustra = 282,
     multipl = 283,
     div_op = 284,
     supperieure = 285,
     inferieure = 286,
     affectation = 287,
     barre_mc = 288,
     deux_points = 289,
     point_virg = 290,
     point = 291,
     egal = 292,
     virg = 293,
     parenthese_ouvrante = 294,
     parenthese_fermante = 295,
     accolade_ouvrante = 296,
     accolade_fermante = 297,
     crochet_ouvrant = 298,
     crochet_fermant = 299,
     idf = 300,
     cst_int = 301,
     cst_float = 302,
     chaine = 303
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


