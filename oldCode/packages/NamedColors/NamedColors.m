(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* :Title: NamedColors *)
(* :Context: NamedColors` *)
(* :Author: Mark A. Caprio, Department of Physics, University of Notre Dame *)(* :Summary: Defines legacy color names for use with Mathematica 6 and above (except those names which conflict with Mathematica 6 kernel colors).  Provides a color selection palette for the combined legacy plus Mathematica kernel colors. *)
(* :Copyright: Copyright 2011, Mark A. Caprio *)
(* :Package Version: 1.0 *)
(* :Mathematica Version: 6.0 *)
(* :History:

(History for LegacyColors: V1 .0, August 2007. V1 .1, February 2009.  Mathematica 7 compatibility update.)

(History for NamedColorPalette: V1 .0, January 27,2006. V1 .1, June 30, 2007. Manually include kernel colors removed from Graphics`Colors` to kernel in Mathematica 5.1. V2.0, August 7, 2007.  Revision for Mathematica 6 kernel plus legacy colors.)

V1 .0, May 26, 2011.  Standalone package created by combining LevelScheme package's NamedColorPalette and LegacyColors subpackages.  Updated to check for prior definition of color symbols, before trying again to assign them, to prevent assignment error if package is sourced more than once.

*)


BeginPackage[
"NamedColors`"
];


Unprotect[Evaluate[$Context<>"*"]];


KernelColors::usage="KernelColors contains a list of the 24 color names defined in the Mathematica 6/7 kernel.";NonkernelLegacyColors::usage="NonkernelLegacyColors contains a list of legacy color names excluding those 17 names also defined in the Mathematica 6/7 kernel.";
NamedColorPalette::usage="NamedColorPalette[] generates a palette of the Mathematica 6 named kernel colors plus legacy colors.";


KernelColors={
"Black", "Blue", "Brown", "Cyan", "Gray", "Green","Magenta", "Orange", "Pink", "Purple", "Red", "White", "Yellow",
"LightBlue", "LightBrown", "LightCyan", "LightGray", "LightGreen", "LightMagenta", "LightOrange", "LightPink", "LightPurple", "LightRed",
"LightYellow"
};
NonkernelLegacyColors=Complement[
First/@ColorData["Legacy", "ColorRules"],
KernelColors
];


Scan[ToExpression,NonkernelLegacyColors];


Begin["`Private`"];





DefineColor[s_String]:=If[
AtomQ[ToExpression[s]],
Evaluate[ToExpression[s]]=ColorData["Legacy",s]
];
Scan[DefineColor,NonkernelLegacyColors];


Options[NamedColorPalette]={Length->20,Names->Union[KernelColors,NonkernelLegacyColors]};
NamedColorPalette[Opts___?OptionQ]:=Module[
{
FullOpts=Flatten[{Opts,Options[NamedColorPalette]}],
Rows,
ColorName,Color,TextColor,
ButtonList,ButtonArray,ButtonGrid,ButtonCell,
CaptionCell,
i,
NamedColors
},

NamedColors=(Names/.FullOpts);

Rows=(Length/.FullOpts);
ButtonList=Table[
ColorName=NamedColors[[i]];
Color=ToExpression[ColorName];
TextColor=If[(Plus@@Color)/Length[Color]>0.3,Black,White];
ButtonBox[
StyleBox[ColorName,FontColor->TextColor],
ButtonData->ColorName,
ButtonNote->ColorName,
Background->Color,
Active->True,ButtonFrame->"DialogBox"
],
{i,1,Length[NamedColors]}
];
ButtonArray=Transpose@Partition[ButtonList,Rows,Rows,{1,1},ButtonBox[""]];
ButtonGrid=GridBox[ButtonArray,ColumnSpacings->0,RowSpacings->0];
ButtonCell=Cell[BoxData[FormBox[ButtonGrid,DisplayForm]],ShowCellBracket->False];
CaptionCell=Cell[TextData["Click on a color to paste its name into the current notebook.  Use the close button on the title bar to close this palette."]];
NotebookPut[Notebook[
{ButtonCell,CaptionCell},
WindowSize->{FitAll,FitAll},WindowElements->{"StatusArea"},WindowTitle->"Mathematica named colors",WindowFrame->"Palette",WindowFloating->True,WindowClickSelect->False,
Editable->False,Selectable->False,Copyable->False,
ShowCellBracket->False,CellMargins->{{0,0},{0,0}}]
];

];


End[];


Protect[Evaluate[$Context<>"*"]];
Unprotect[Evaluate[$Context<>"$*"]];
EndPackage[];