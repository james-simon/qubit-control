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



(* :Title: FigData *)
(* :Context: SciDraw` *)
(* :Summary: Data plotting *)
(* :Author: Mark A. Caprio, Department of Physics, University of Notre Dame *)
(* :Copyright: Copyright FIGYEAR, Mark A. Caprio *)
(* :Package Version: FIGVERSION *)
(* :Mathematica Version: MATHVERSION *)
(* :Discussion: FIGDISCUSSION *)
(* :History: See package information file. *)


BeginPackage["SciDraw`",SciDraw`Private`$ExternalContexts];


Unprotect[Evaluate[$Context<>"*"]];


DataPlot::usage="FIGURE OBJECT: DataPlot[data] produces customizable data plots.";
DataLegend::usage="FIGURE OBJECT: DataLegend[point,{{dataset1,label1},...}] generates a data plot legend.";


DataLine::usage="The option values for DataLine affect the appearance of data plots.";
DataSymbol::usage="The option values for DataSymbol affect the appearance of data plots.";
DataFill::usage="The option values for DataFill affect the appearance of data plots.";
DataDrop::usage="The option values for DataFill affect the appearance of data plots.";


$DataLineShapeRegistry::usage="Global registry of curve shapes for use with DataPlot.";
DefineDataLineShape::usage="DefineDataLineShape[name,function] defines a new value to be accepted for the DataLineShape option.  The function should take a list of two or more {x,y} points (as canvas coordinates) and return a new list of points.";


$DataSymbolShapeRegistry::usage="Global registry of symbol shapes for use with DataPlot.";DefineDataSymbolShape::usage="DefineDataSymbolShape[name,points] defines a new value to be accepted for the DataSymbol option.  The argument points should be an expression which evaluates to a list of points.  These would describe the symbol centered on the origin and contained in the box covering the coordinate intervals [-1,+1].";


$DataAxisScaleRegistry::usage="Global registry of axis scale functions for use with DataPlot.";DefineAxisScale::usage="DefineAxisScale[name,function] defines a new value to be accepted for the XAxisScale and YAxisScale options.  The function f[x] should take an unscaled value of x and return the scaled value.  It should always return a numeric value (possibly -Infinity or Infinity).";


CurveShape::usage="Option name for use with DataPlot."; 
SymbolShape::usage="Option name for use with DataPlot.";
SymbolSize::usage="Option name for use with DataPlot.";
SymbolSizeScale::usage="Option name for use with DataPlot.";


DataColumns::usage="Option name for use with DataPlot.";
ColumnNames::usage="Option name for use with DataPlot.";
XErrorColumn::usage="Option name for use with DataPlot.";
YErrorColumn::usage="Option name for use with DataPlot.";
XAxisScale::usage="Option name for use with DataPlot.";
YAxisScale::usage="Option name for use with DataPlot.";
DataFilters::usage="Option name for use with DataPlot.";
SymbolOptionColumns::usage="Option name for use with DataPlot.";
InternalSeparation::usage="Option name for use with DataLegend.";
EntrySpacing::usage="Option name for use with DataLegend.";
RowLimit::usage="Option name for use with DataLegend.";


DataSymbolVerticesFunction::usage="DataSymbolVerticesFunction[symbolname] returns a function f[{{x,y},s}] which takes a canvas point into a list of canvas vertices.";


AttachIndex::usage="AttachIndex[data] or AttachIndex[start,data] or AttachIndex[start,step,data] prepends a column to data, containing a running index.  The data may either be a vector (list of values) or a matrix (data set).";


SelectByColumn::usage="SelectByColumn[data,c,patt] selects those rows of a data set for which the value in column c matches the pattern (or value) patt.  SelectByColumn[data,{c1,patt1},{c2,patt2},...] applies the conjunction of pattern tests on the entries in columns c1, c2, ..., of each row.";


DataEntry::usage="Dummy argument for MakeDataSet";
MakeDataSet::usage="MakeDataSet[expr,data] or MakeDataSet[expr,{data1,data2,...}] returns a data set in which each row is obtained from corresponding rows of data1, data2, etc. by evaluating expr, which should be a list and which may invoke DataEntry[column], DataEntry[{row,column}], DataEntry[set,column], DataEntry[set,{row,column}], or Row.";


DataSetPattern::usage="Pattern matching a valid rectangular data set or null set.";
DataColumnNamePattern::usage="Pattern matching a positive integer or proper column name (i.e., string or {string,...}).";


Begin["`Private`"];





$DataLineShapeRegistry={};


SetAttributes[DefineDataLineShape,{HoldRest}];


DefineDataLineShape[Name_,Function_]:=Module[
{},
AppendTo[$DataLineShapeRegistry,Name];
DataLineShapeFunction[Name]:=Function;
];


DefineDataLineShape[
"Straight",
Identity
];


DefineDataLineShape[
"Step",
Function[Points,
Join[
{Points[[1]]},
Flatten[
Table[
{
{(First[Points[[i]]]+First[Points[[i+1]]])/2,Last[Points[[i]]]},{(First[Points[[i]]]+First[Points[[i+1]]])/2,Last[Points[[i+1]]]}
},
{i,1,Length[Points]-1}
],
1
],
{Points[[-1]]}
]
]
];


DefineDataLineShape[
"SideStep",
Function[Points,
Join[
{Points[[1]]},
Flatten[
Table[
{
{First[Points[[i]]],(Last[Points[[i]]]+Last[Points[[i+1]]])/2},
{First[Points[[i+1]]],(Last[Points[[i]]]+Last[Points[[i+1]]])/2}
},
{i,1,Length[Points]-1}
],
1
],
{Points[[-1]]}
]
]
];


DefineDataLineShape[
"Histogram",
Function[Points,
Module[
{CanvasBase=FigResolveCoordinate[0,Vertical]},
Join[
Join[
{
{(3/2*First[Points[[1]]]-1/2*First[Points[[2]]]),CanvasBase},
{(3/2*First[Points[[1]]]-1/2*First[Points[[2]]]),Last[Points[[1]]]}
},
Flatten[
Table[
{
{(First[Points[[i]]]+First[Points[[i+1]]])/2,Last[Points[[i]]]},
{(First[Points[[i]]]+First[Points[[i+1]]])/2,CanvasBase},
{(First[Points[[i]]]+First[Points[[i+1]]])/2,Last[Points[[i+1]]]}
},
{i,1,Length[Points]-1}
],
1
],
{
{(3/2*First[Points[[-1]]]-1/2*First[Points[[-2]]]),Last[Points[[-1]]]},
{(3/2*First[Points[[-1]]]-1/2*First[Points[[-2]]]),CanvasBase}
}
]
]
]
]
];


DefineDataLineShape[
"SideHistogram",
Function[Points,
Module[
{CanvasBase=FigResolveCoordinate[0,Horizontal]},
Join[
Join[
{
{CanvasBase,(3/2*Last[Points[[1]]]-1/2*Last[Points[[2]]])},
{First[Points[[1]]],(3/2*Last[Points[[1]]]-1/2*Last[Points[[2]]])}
},
Flatten[
Table[
{
{First[Points[[i]]],(Last[Points[[i]]]+Last[Points[[i+1]]])/2},
{CanvasBase,(Last[Points[[i]]]+Last[Points[[i+1]]])/2},
{First[Points[[i+1]]],(Last[Points[[i]]]+Last[Points[[i+1]]])/2}
},
{i,1,Length[Points]-1}
],
1
],
{
{First[Points[[-1]]],(3/2*Last[Points[[-1]]]-1/2*Last[Points[[-2]]])},
{CanvasBase,(3/2*Last[Points[[-1]]]-1/2*Last[Points[[-2]]])}
}
]
]
]
]
];


$DataSymbolShapeRegistry={};


SetAttributes[DefineDataSymbolShape,{HoldRest}];


DefineDataSymbolShape[Name_,Function_]:=Module[
{},
AppendTo[$DataSymbolShapeRegistry,Name];
DataSymbolShapeFunction[Name]:=Function;
];


(* circle *)


DefineDataSymbolShape[
"Circle",
{{0.9238795325112867,0.3826834323650898},{0.7071067811865475,0.7071067811865475},{0.3826834323650898,0.9238795325112867},{0.,1.},{-0.3826834323650898,0.9238795325112867},{-0.7071067811865475,0.7071067811865475},{-0.9238795325112867,0.3826834323650898},{-1.,0.},{-0.9238795325112867,-0.3826834323650898},{-0.7071067811865475,-0.7071067811865475},{-0.3826834323650898,-0.9238795325112867},{0.,-1.},{0.3826834323650898,-0.9238795325112867},{0.7071067811865475,-0.7071067811865475},{0.9238795325112867,-0.3826834323650898},{1.,0.}}
];


(* quadrilaterals *)


DefineDataSymbolShape[
"Square",
1.2*{{-0.7071067811865476,0.7071067811865476},{-0.7071067811865476,-0.7071067811865476},{0.7071067811865476,-0.7071067811865476},{0.7071067811865476,0.7071067811865476}}
];
DefineDataSymbolShape[
"Diamond",
1.2*{{0.,1.},{-1.,0.},{0.,-1.},{1.,0.}}
];


DefineDataSymbolShape[
"UpTriangle",
1.2*{{0.,1.},{-0.8660254037844386,-0.5},{0.8660254037844386,-0.4999999999999999}}
];
DefineDataSymbolShape[
"LeftTriangle",
1.2*{{-1.,0.},{0.5,-0.8660254037844386},{0.4999999999999999,0.8660254037844386}}
];
DefineDataSymbolShape[
"DownTriangle",
1.2*{{0.,-1.},{0.8660254037844386,0.5},{-0.8660254037844386,0.4999999999999999}}
];
DefineDataSymbolShape[
"RightTriangle",
1.2*{{1.,0.},{-0.5,0.8660254037844386},{-0.4999999999999999,-0.8660254037844386}}
];


DefineDataSymbolShape[
"Plus",
1.2*{{0,0},{1,0},{0,0},{0,1},{0,0},{-1,0},{0,0},{0,-1},{0,0}}
];
DefineDataSymbolShape[
"Horizontal",
1.2*{{-1,0},{1,0}}
];
DefineDataSymbolShape[
"Vertical",
1.2*{{0,-1},{0,1}}
];
DefineDataSymbolShape[
"Cross",
1.2*{{0,0},{-0.7071067811865476,0.7071067811865476},{0,0},{-0.7071067811865476,-0.7071067811865476},{0,0},{0.7071067811865476,-0.7071067811865476},{0,0},{0.7071067811865476,0.7071067811865476},{0,0}}
];
DefineDataSymbolShape[
"Asterisk",
1.2*{{0,0},{-0.7071067811865476,0.7071067811865476},{0,0},{-1,0},{0,0},{-0.7071067811865476,-0.7071067811865476},{0,0},{0,-1},{0,0},{0.7071067811865476,-0.7071067811865476},{0,0},{1,0},{0,0},{0.7071067811865476,0.7071067811865476},{0,0},{0,1},{0,0}}
];


(* general polygon *)


DefineDataSymbolShape[
{"Polygon",n_},
N[Table[{Cos[2*Pi*i/n+Pi/2],Sin[2*Pi*i/n+Pi/2]},{i,1,n}]]
];


DataSymbolVerticesFunction[SymbolShape_]:=With[
{
BasicShape=N[DataSymbolShapeFunction[SymbolShape]]
},

(* validate symbol vertices *)
(* must be list of points (at least 2 points) or list of lists of points (at least 2 points), as suitable for Line and Polygon *)
FigCheckValue[SciDraw,BasicShape,
{Repeated[NumericalPairPattern,{2,Infinity}]}|{{Repeated[NumericalPairPattern,{2,Infinity}]}..},
"calculated symbol shape"
];

(* translate and scale symbol point *)
(* 
Function[Ps,
(Ps[[1]]+#)&/@(Ps[[2]]/2*BasicShape)
]
*)
Function[Ps,
Map[
(Ps[[1]]+#)&,
(Ps[[2]]/2*BasicShape),
{Depth[BasicShape]-2}  (* allow for list of lists of points; map at level 1 or 2 for list or list of lists, respectively *)
]
]

];


ErrorBarLinesFunction=Function[
{p,CanvasErrorCapCenters,s0},
Join[
If[
ListQ[CanvasErrorCapCenters[[1,1]]],
{{p,CanvasErrorCapCenters[[1,1]]},{CanvasErrorCapCenters[[1,1]]+(s0/2)*{0,-1},CanvasErrorCapCenters[[1,1]]+(s0/2)*{0,+1}}},
{}
],
If[
ListQ[CanvasErrorCapCenters[[1,2]]],
{{p,CanvasErrorCapCenters[[1,2]]},{CanvasErrorCapCenters[[1,2]]+(s0/2)*{0,-1},CanvasErrorCapCenters[[1,2]]+(s0/2)*{0,+1}}},
{}
],
If[
ListQ[CanvasErrorCapCenters[[2,1]]],
{{p,CanvasErrorCapCenters[[2,1]]},{CanvasErrorCapCenters[[2,1]]+(s0/2)*{-1,0},CanvasErrorCapCenters[[2,1]]+(s0/2)*{+1,0}}},
{}
],
If[
ListQ[CanvasErrorCapCenters[[2,2]]],
{{p,CanvasErrorCapCenters[[2,2]]},{CanvasErrorCapCenters[[2,2]]+(s0/2)*{-1,0},CanvasErrorCapCenters[[2,2]]+(s0/2)*{+1,0}}},
{}
]
]
];


DeclareFigClass[DataLine,{},{},{}];
DefineFigClassOptions[
DataLine,
{
CurveShape->"Straight"
}
];


DeclareFigClass[DataSymbol,{},{},{}];
DefineFigClassOptions[
DataSymbol,
{
SymbolShape->"Circle",SymbolSize->2.5,SymbolSizeScale->1.0
}
];


DeclareFigClass[DataFill,{},{},{}];
DefineFigClassOptions[
DataFill,
{ShowLine->False,Layer->$FigBackgroundLayer},
{
Direction->Vertical,
Filling->None
}
];


DeclareFigClass[DataDrop,{},{},{}];
DefineFigClassOptions[
DataDrop,
{
Direction->Vertical,
Filling->None
}
];


QuasiInfinity=10000;


SuperRegion[]:=ExtendRegion[CurrentWindow[]@UserRegion[],QuasiInfinity*{{1,1},{1,1}},Scaled];


SuperClipPoint[{x_,y_}]:={Clip[x,First[SuperRegion[]]],Clip[y,Last[SuperRegion[]]]};
SuperClipCoordinate[x_,CoordinateIndex:(1|2)]:=Clip[x,SuperRegion[][[CoordinateIndex]]];


ApplyNotMissing[f_][x_?NumericQ]:=f[x];
ApplyNotMissing[f_][x_Missing]:=x;


$DataAxisScaleRegistry={};


SetAttributes[DefineAxisScale,{HoldRest}];


DefineAxisScale[Name_,Function_]:=Module[
{},
AppendTo[$DataAxisScaleRegistry,Name];
DataAxisScaleFunction[Name]:=Function;
];


DefineAxisScale[None,Identity];


DefineAxisScale[{Scaled,ScaleUnits_?NumericQ},Function[x,x/ScaleUnits]];


DefineAxisScale[{"Linear",a_?NumericQ,b_?NumericQ},Function[x,a*x+b]];


LimitedLog[b_:E,x_?Positive]=Log[b,x];
LimitedLog[b_:E,_?NonPositive]=-Infinity;


DefineAxisScale[Log,LimitedLog[10,#]&];


DefineAxisScale[{Log,Base_},LimitedLog[Base,#]&];


DeclareFigClass[
DataPlot,
{"Points","CurvePoints","StyleRules"},
{},
{Center,Left,Right,Tail,Head,Point}
];
DefineFigClassOptions[
DataPlot,
{
(* graphical options pass-through*)
DataLine->{},
DataSymbol->{},
DataFill->{},
DataDrop->{},

(* data processing *)
DataColumns->{1,2},
ColumnNames->None,
SymbolOptionColumns->None,
XErrorColumn->None,
YErrorColumn->None,
XAxisScale->None,
YAxisScale->None,
DataFilters->None,

(* attached label default overrides *)
(* see comments at DefineFigClassOptions *)
SciDraw`TailTextOrientation->Horizontal,
SciDraw`HeadTextOrientation->Horizontal,

(* data archiving *)
Print->False
}
];


ResolveEdgeOptionSwap[
Self_Object,
Option_Symbol,XYOption:{XOption_Symbol,YOption_Symbol},
EntryPattern_,Filler_,XYUnique:LogicalPattern,Mirror:LogicalPattern,
FullOptions_List
]:=Module[
{FullPattern,Result},

(* validate options *)
(* for options where propagating a single value to both X and Y is nonsense, except in the case of None, only allow "None" as a single value *)
FullPattern=Default|If[XYUnique,None,EntryPattern]|{EntryPattern,EntryPattern}|{{EntryPattern,EntryPattern},{EntryPattern,EntryPattern}}|{EntryPattern,EntryPattern,EntryPattern,EntryPattern};

(*Print[Option," ",XYOption," ",EntryPattern," ",Filler," ",XYUnique," ",Mirror];
Print["      ",FullPattern];
Print["      ",Option/.FullOptions," ",XYOption/.FullOptions];*)

FigCheckOption[Self,Option,FullPattern,FullOptions];
FigCheckOption[Self,XOption,EntryPattern,FullOptions];
FigCheckOption[Self,YOption,EntryPattern,FullOptions];

(* resolve XY fallthrough and upgrade to all four edges *)
Result=ResolveOption[
Option,
{
(* If is needed so that patterns which can match flat lists or special values do not here match the {X,Y} list from the Default fallthrough *)
If[
(Option/.FullOptions)===Default,
(* Default as XY fallthrough *)
Default:>(XYOption/.FullOptions),
(* upgrade single value, as U\[Rule]{U,U}, if it survived the option validation *)
u:EntryPattern:>{u,u}
],
(* upgrade XY pair to all edges, using either mirroring {B,L}\[Rule]{{L,L},{B,B}} or filler {B,L}\[Rule]{{L,X},{B,X}} *)
{x:EntryPattern,y:EntryPattern}:>Reverse@{{y,If[Mirror,y,Filler]},{x,If[Mirror,x,Filler]}},
(* gracefully accept pre-6 legacy edge parameter specification, as {B,L,T,R}\[Rule]{{L,R},{B,T}} *)
{b:EntryPattern,l:EntryPattern,t:EntryPattern,r:EntryPattern}:>{{l,r},{b,t}}
},
FullOptions
]

(*Print[Result];Result*)

];


ExtractData[
DataSet_List,
{cx_Integer,cy_Integer},
{{cdx1:(_Integer)|None,cdx2:(_Integer)|None},{cdy1:(_Integer)|None,cdy2:(_Integer)|None}},
OptionColumnRules_List
]:=Module[
{},
Cases[
N[DataSet],
(Row_List)/;(NumberQ[Row[[cx]]]&&NumberQ[Row[[cy]]]):>{

(* x data *)
{
Row[[cx]],
If[(cdx1===None)||!NumericQ[Row[[cdx1]]],Missing[],Row[[cx]]-Row[[cdx1]]],
If[(cdx2===None)||!NumericQ[Row[[cdx2]]],Missing[],Row[[cx]]+Row[[cdx2]]]
},

(* y data *)
{
Row[[cy]],
If[(cdy1===None)||!NumericQ[Row[[cdy1]]],Missing[],Row[[cy]]-Row[[cdy1]]],
If[(cdy2===None)||!NumericQ[Row[[cdy2]]],Missing[],Row[[cy]]+Row[[cdy2]]]
},

(* option data *)
Cases[
OptionColumnRules,
Rule[OptionName_Symbol,c_Integer]/;(!MatchQ[Row[[c]],(_Missing)|Default]):>Rule[OptionName,Row[[c]]]
]
}
]
];


RescaleData[CoordinateData_List,f:{fx_,fy_}]:=Module[
{RescaledData},

(* rescale all coordinates *)
RescaledData=Map[
MapThread[Map,{{ApplyNotMissing[fx],ApplyNotMissing[fy],Identity},#}]&,
CoordinateData
];

(* keep only cases with finite (x,y) data point value *)
Cases[RescaledData,{{_?NumberQ,_,_},{_?NumberQ,_,_},{___}}]

];


NumericOrInfiniteQ[(_?NumericQ)|(_DirectedInfinity)]=True;
NumericOrInfiniteQ[Except[(_?NumericQ)|(_DirectedInfinity)]]=False;


MakeDataCanvasPoint[DataPoint:{{x_,x1_,x2_},{y_,y1_,y2_},DataPointOptions_List}]:=(CurrentWindow[]@TFunction[])[{x,y}];


MakeDataSymbolPrimatives[DataPoint:{{x_,x1_,x2_},{y_,y1_,y2_},DataPointOptions_List},DataSymbolOptions_List]:=Module[
{
FullDataPointOptions=Join[DataPointOptions,DataSymbolOptions],LineDirectives,FillDirectives,
CanvasPoint,CanvasErrorCapCenters,tf
},

(* calculate canvas point geometry *)
tf=CurrentWindow[]@TFunction[];
CanvasPoint=tf@{x,y};
(* extract data point and error cap center points (or None) as {{x,y},px1,px2,py1,py2,size}; infinite error bars are clipped to finite values "a bit outside the region" so as not to befuddle the window transformation function*)
CanvasErrorCapCenters={
{
If[NumericOrInfiniteQ[x1],tf@SuperClipPoint[{x1,y}],None],
If[NumericOrInfiniteQ[x2],tf@SuperClipPoint[{x2,y}],None]
},
{
If[NumericOrInfiniteQ[y1],tf@SuperClipPoint[{x,y1}],None],
If[NumericOrInfiniteQ[y2],tf@SuperClipPoint[{x,y2}],None]
}
};

(* generate primatives *)
{
(* error bar -- lines function takes {p,px1,px2,py1,py2,s0} *)
LineDirectives=MakeLineDirectives[FullDataPointOptions];
FillDirectives=MakeFillDirectives[FullDataPointOptions];
If[
(LineDirectives=!=None),
Flatten[{
LineDirectives,
Line[
ErrorBarLinesFunction[
CanvasPoint,
CanvasErrorCapCenters,
(SymbolSize/.DataSymbolOptions)
]
]
}],
{}
],

(* symbol -- data symbol vertices function takes canvas {{x,y},s}  *)
If[
{LineDirectives,FillDirectives}=!={None,None},
Flatten[{
{EdgeForm[LineDirectives],FaceForm[FillDirectives]},
Polygon[
DataSymbolVerticesFunction[(SymbolShape/.FullDataPointOptions)][{CanvasPoint,(SymbolSize/.FullDataPointOptions)*(SymbolSizeScale/.FullDataPointOptions)}]
]
}],
{}
]

}

];


(*DataSetPattern=(_?(ArrayQ[#,2]&))|{};*)(* chokes if data entries are lists, e.g., for symbol specifier*)


DataSetPattern=(_?(ArrayDepth[#]>=2&))|{};
DataColumnNamePattern=((_Integer)?Positive)|(_String)|{_String,___};  (* excludes None *)


DataPlot::columnname="Encountered undefined column name `1`.";
Constructor[Class:DataPlot,Self_Object][DataSet_,Opts___?OptionQ]:=FigObjectWrapper[Class,Self,{Opts},
Module[
{
DataStyle,DataLineOptions,DataSymbolOptions,DataFillOptions,DataDropOptions,
UsedColumnNames,UsedDataColumns,ColumnResolutionRules,
PointData,CanvasPoints,CurvePoints,UsedDataSymbolVerticesFunction,CanvasErrorPoints,UsedErrorColumns,UsedAxisScales,
UsedSymbolOptionColumns
},

(* validate extra options *)
FigCheckOption[Self,DataLine,_List,FigOptions];
FigCheckOption[Self,DataSymbol,_List,FigOptions];
FigCheckOption[Self,DataColumns,{DataColumnNamePattern,DataColumnNamePattern},FigOptions];
FigCheckOption[Self,ColumnNames,None|{DataColumnNamePattern...},FigOptions];
FigCheckOption[Self,XErrorColumn,None|DataColumnNamePattern|{None|DataColumnNamePattern,None|DataColumnNamePattern},FigOptions];
FigCheckOption[Self,YErrorColumn,(None|DataColumnNamePattern)|{None|DataColumnNamePattern,None|DataColumnNamePattern},FigOptions];
(*FigCheckOption[Self,SymbolOptionColumns,None|{Rule[(SymbolShape|SymbolSize|SymbolSizeScale|Color|FillColor|LineColor|LineThickness),DataColumnNamePattern]...},FigOptions];*)
FigCheckOption[Self,SymbolOptionColumns,None|{Rule[
(Color|Directives|FillColor|FillDirectives|FillOpacity|LineCapForm|LineColor|LineDashing|LineDirectives|LineJoinForm|LineOpacity|LineThickness|Opacity|Show|ShowFill|ShowLine|SymbolShape|SymbolSize|SymbolSizeScale),
DataColumnNamePattern]...},FigOptions];
FigCheckOption[Self,XAxisScale,Alternatives@@$DataAxisScaleRegistry,FigOptions];  
FigCheckOption[Self,YAxisScale,Alternatives@@$DataAxisScaleRegistry,FigOptions];
FigCheckOption[Self,DataFilters,_,FigOptions];  (* TODO tighten validation pattern once implemented *)
FigCheckOption[Self,Print,LogicalPattern,FigOptions];

(* validate plot data *)
FigCheckValue[Self,DataSet,DataSetPattern,"given data set"];

(* apply plot style *)
WithStyle[
(Style/.FigOptions),
DataLineOptions=FigRealizeOptions[Self,DataLine,(DataLine/.FigOptions)];
DataSymbolOptions=FigRealizeOptions[Self,DataSymbol,(DataSymbol/.FigOptions)];
DataFillOptions=FigRealizeOptions[Self,DataFill,(DataFill/.FigOptions)];
DataDropOptions=FigRealizeOptions[Self,DataDrop,(DataDrop/.FigOptions)]
];

(* save plot style rules*)
Self@SetStyleRules[
{
DataLine->DataLineOptions,
DataSymbol->DataSymbolOptions,
DataFill->DataFillOptions,
DataDrop->DataDropOptions
}
];

(* impose DataPlot Show\[Rule]False override *)
DataLineOptions=OptionsUnion[
Show->((Show/.FigOptions)&&(Show/.DataLineOptions)),
DataLineOptions
];
DataSymbolOptions=OptionsUnion[
Show->((Show/.FigOptions)&&(Show/.DataSymbolOptions)),
DataSymbolOptions
];
DataFillOptions=OptionsUnion[
Show->((Show/.FigOptions)&&(Show/.DataFillOptions)),
DataFillOptions
];
DataDropOptions=OptionsUnion[
Show->((Show/.FigOptions)&&(Show/.DataDropOptions)),
DataDropOptions
];

(* validate data plot style options *)
FigCheckBaseOptions[Self,DataLineOptions];
FigCheckOption[Self,CurveShape,Alternatives@@$DataLineShapeRegistry,DataLineOptions];FigCheckBaseOptions[Self,DataSymbolOptions];
FigCheckOption[Self,SymbolShape,Alternatives@@$DataSymbolShapeRegistry,DataSymbolOptions];
FigCheckOption[Self,SymbolSize,_?Positive,DataSymbolOptions];
FigCheckOption[Self,SymbolSizeScale,_?Positive,DataSymbolOptions];
FigCheckBaseOptions[Self,DataFillOptions];
FigCheckOption[Self,Direction,Horizontal|Vertical,DataFillOptions];
FigCheckOption[Self,Filling,None|Axis|(_?NumericQ)|(_DirectedInfinity)|ObjectNamePattern[DataPlot],DataFillOptions];
FigCheckBaseOptions[Self,DataDropOptions];
FigCheckOption[Self,Direction,Horizontal|Vertical,DataDropOptions];
FigCheckOption[Self,Filling,None|Axis|(_?NumericQ)|(_DirectedInfinity),DataDropOptions];


(* generate data archive cell *)
If[(Print/.FigOptions),
CellPrintValue[
TableForm[DataSet],
Label->"FigData plot data"
]
];

(* define columns *)
UsedColumnNames=ResolveOption[ColumnNames,{None->{}},FigOptions];
ColumnResolutionRules=
Join[
(* preserve integer literal column (or None) *)
{None->None,(c_Integer):>c},

(* make named column rules *)
Table[
UsedColumnNames[[c]]->c,
{c,1,Length[UsedColumnNames]}
],

(* fallthrough *)
{x_:>FigError[DataPlot,"columnname",x]}

];
UsedDataColumns=Replace[(DataColumns/.FigOptions),ColumnResolutionRules,{1}];  (* replace at level {1} for {x,y} *)
UsedErrorColumns=Replace[{UpgradePair[(XErrorColumn/.FigOptions)],UpgradePair[(YErrorColumn/.FigOptions)]},ColumnResolutionRules,{2}]; (* replace at level {2} for {{xm,xp},{ym,ym}} *)
UsedSymbolOptionColumns=Cases[
ResolveOption[SymbolOptionColumns,{None->{}},FigOptions],
(opt_->c_):>(opt->Replace[c,ColumnResolutionRules])
]; (* replace via cases for {option\[Rule]c} *)


(* extract nonmissing data *)
PointData=ExtractData[
DataSet,
UsedDataColumns,UsedErrorColumns,
UsedSymbolOptionColumns
];
If[(Debug/.FigOptions),Print["  ","PointData: ",PointData]];

(* rescale data by data axis scales and re-prune values -- result is in user coordinates  *)
UsedAxisScales={XAxisScale/.FigOptions,YAxisScale/.FigOptions};
PointData=RescaleData[PointData,DataAxisScaleFunction/@UsedAxisScales];
If[(Debug/.FigOptions),Print["  ","PointData (rescaled): ",PointData]];

(* save data needed for anchor generation *)
CanvasPoints=MakeDataCanvasPoint/@PointData;
CurvePoints=DataLineShapeFunction[(CurveShape/.DataLineOptions)][CanvasPoints];
Self@SetPoints[CanvasPoints];
Self@SetCurvePoints[CurvePoints];

(* make graphics elements *)

(* fill *)
If[(Filling/.DataFillOptions)=!=None,  (* short circuit *)
FigPolygonElement[
{Polygon[FillPoints[CurvePoints,(Filling/.DataFillOptions),(Direction/.DataFillOptions)]]},
DataFillOptions
]
];

(* drop *)
If[(Filling/.DataDropOptions)=!=None,  (* short circuit *)
FigLineElement[
{Line[DropSegments[CurvePoints,(Filling/.DataDropOptions),(Direction/.DataDropOptions)]]},
DataDropOptions
]
];

(* curve *)
FigLineElement[
{Line[CurvePoints]},
DataLineOptions
];

(* symbol and error bars *)
FigPolygonElement[
Map[
MakeDataSymbolPrimatives[#,DataSymbolOptions]&,
PointData
],
DataSymbolOptions
];


]
];


MakeAnchor[Class:DataPlot,Self_Object][Name_,Arg_]:=FigMakeAnchorWrapper[Class,Self,Name,Arg,
FigCurveAnchorFromPoints[Self@GetCurvePoints[],Name,Arg]
];
MakeBoundingBox[Class:DataPlot,Self_Object][]:=FigCurveBoundingBox[Self@GetCurvePoints[]];


FillPoints[CurvePoints_,x_,Horizontal]:=FillPoints[CurvePoints,x,1];
FillPoints[CurvePoints_,x_,Vertical]:=FillPoints[CurvePoints,x,2];


FillPoints[CurvePoints_List,Filling:None,CoordinateIndex:(1|2)]:={};
FillPoints[CurvePoints_List,Filling:Axis,CoordinateIndex:(1|2)]:=FillPoints[CurvePoints,0,CoordinateIndex];
FillPoints[CurvePoints_List,Filling:_DirectedInfinity,CoordinateIndex:(1|2)]:=FillPoints[CurvePoints,SuperClipCoordinate[Filling,1],CoordinateIndex];
FillPoints[CurvePoints_List,Filling_?NumericQ,CoordinateIndex:(1|2)]:=Module[
{CanvasCoordinate},
CanvasCoordinate=FigResolveCoordinate[Filling,CoordinateIndex];
Join[
{First[CurvePoints]*UnitVector[AntiCoordinateIndex[CoordinateIndex]]+CanvasCoordinate*UnitVector[CoordinateIndex]},
CurvePoints,
{Last[CurvePoints]*UnitVector[AntiCoordinateIndex[CoordinateIndex]]+CanvasCoordinate*UnitVector[CoordinateIndex]}
]
];
FillPoints[CurvePoints_List,Filling:ObjectNamePattern[DataPlot],CoordinateIndex:(1|2)]:=Module[
{OtherCurve},
OtherCurve=Object[Filling]@GetCurvePoints[];
Join[
CurvePoints,
Reverse[OtherCurve]
]
];


DropSegments[CurvePoints_,x_,Horizontal]:=DropSegments[CurvePoints,x,1];
DropSegments[CurvePoints_,x_,Vertical]:=DropSegments[CurvePoints,x,2];


DropSegments[CurvePoints_List,Filling:None,CoordinateIndex:(1|2)]:={};
DropSegments[CurvePoints_List,Filling:Axis,CoordinateIndex:(1|2)]:=DropSegments[CurvePoints,0,CoordinateIndex];
DropSegments[CurvePoints_List,Filling:_DirectedInfinity,CoordinateIndex:(1|2)]:=DropSegments[CurvePoints,SuperClipCoordinate[Filling,1],CoordinateIndex];
DropSegments[CurvePoints_List,Filling_?NumericQ,CoordinateIndex:(1|2)]:=Module[
{CanvasCoordinate},
CanvasCoordinate=FigResolveCoordinate[Filling,CoordinateIndex];
Table[
{p*UnitVector[AntiCoordinateIndex[CoordinateIndex]]+CanvasCoordinate*UnitVector[CoordinateIndex],p},
{p,CurvePoints}
]
];


DeclareFigClass[
DataLegend,
{"TextElement"},
{},
{}
];
DefineFigClassOptions[
DataLegend,
{TextOffset->{-1,+1}},
{
(* given position *)
Point->{0,0},

(* legend formatting *)
Width->20,InternalSeparation->2,EntrySpacing->{10,2},RowLimit->None
}
];


(*DataSetInfoPattern={({_,_}|{_,_,DataPlot}|{_,_,SciDraw`FigLine})...};  *)(* must explicitly provide context for FigLine if FigShape comes after FigData in loading order *)
DataSetInfoPattern={({_,_}|{_,_,DataPlot}|{_,_,_Symbol})...};


BasicDataLegend[Self_Object][GivenAnchor_Object,DataSetInfo:DataSetInfoPattern]:=
Module[
{
UsedDimensions,UsedRows,UsedColumns,
CurrentStyleName,CurrentText,CurrentEntryStyleMode,CurrentStyleOptions,
DataLineOptions,DataFillOptions,DataSymbolOptions,FigLineOptions,
P0,
LineEndpoints,UsedDataSymbolVerticesFunction,Index,
EntryGraphicalElements,EntryGraphics,EntryWidth,EntryHeight,EntryText,
LegendContents,TextElement,DataDescriptorWindow
},

(* validate extra options *)
FigCheckOption[Self,Width,_?NonNegative,FigOptions];
FigCheckOption[Self,InternalSeparation,NonNegativeScalarParameterPattern,FigOptions];
FigCheckOption[Self,EntrySpacing,NonNegativeIntervalParametersPattern,FigOptions];
FigCheckOption[Self,RowLimit,None|(_Integer),FigOptions];

(* validate list of styles *)
FigCheckValueList[Self,First/@DataSetInfo,StyleSpecifierPattern,"style identifiers"];

(* row/column dimension calculations *)
UsedDimensions=Switch[
(RowLimit/.FigOptions),
None,{Length[DataSetInfo],1},
_Integer,{(RowLimit/.FigOptions),Max[Ceiling[Length[DataSetInfo]/(RowLimit/.FigOptions)],1]}
];
{UsedRows,UsedColumns}=UsedDimensions;

(* geometry calculations *)
P0=GivenAnchor; 
EntryWidth=(Width/.FigOptions);
LineEndpoints={{-1,0},{+1,0}}*(EntryWidth/2);

(* assemble legend contents *)
LegendContents=If[
(Show/.FigOptions), (* otherwise overridden by Show in DataLineOpts or DataSymbolOpts *)

Grid[
Table[
(* retrieve entry information *)
Index=r+(s-1)*UsedRows;
If[
Index>Length[DataSetInfo],

(* no entry *)
{EntryGraphics,EntryText}={Null,Null},

(* entry *)
(* force current entry mode to DataPlot if not specified *)
{CurrentStyleName,CurrentText,CurrentEntryStyleMode}=Replace[DataSetInfo[[Index]],{a_,b_}:>{a,b,DataPlot}];

If[
CurrentStyleName=!=None,

(* obtain plot style *)
WithStyle[
CurrentStyleName,
Switch[
CurrentEntryStyleMode,
DataPlot,
(* take plot options from usual DataPlot option sets *)
DataLineOptions=FigRealizeOptions[Self,DataLine,Options[DataLine]];
DataSymbolOptions=FigRealizeOptions[Self,DataSymbol,Options[DataSymbol]],
(*DataFillOptions=FigRealizeOptions[Self,DataFill,Options[DataFill]];*)
_,
(* take plot line options from given object, e.g., FigLine or FigRule, and do not provide data symbol options *)
DataLineOptions=FigRealizeOptions[Self,CurrentEntryStyleMode,Options[CurrentEntryStyleMode]];
]
];

(* make entry graphical elements *)

(* record symbol size with safe (double) line thickness allowance *)
EntryHeight=(SymbolSize/.DataSymbolOptions)*(SymbolSizeScale/.DataSymbolOptions)+2*(LineThickness/.DataSymbolOptions);

(* make window in which to draw curve/symbol *)
DataDescriptorWindow=FigWindow[{{-1,+1}*EntryWidth,{-1,+1}*EntryHeight/2}];

(* make curve/symbol elements *)
(*Note:draw a legend symbol using DataLine and DataSymbol options defined by style,in a box spanning internal coordinates {{-EntryWidth/2,EntryWidth/2},{-EntryHeight/2,EntryHeight/2}} and of size {EntryWidth,EntryHeight} in printer's points.*)

EntryGraphicalElements=CollectGraphicalElements[

(* curve *)
FigLineElement[
{Line[LineEndpoints]},
DataLineOptions
];

(* symbol *)
Switch[
CurrentEntryStyleMode,
DataPlot,
UsedDataSymbolVerticesFunction=DataSymbolVerticesFunction[(SymbolShape/.DataSymbolOptions)];
FigPolygonElement[
{Composition[Polygon,UsedDataSymbolVerticesFunction][{{0,0},(SymbolSize/.DataSymbolOptions)*(SymbolSizeScale/.DataSymbolOptions)}]},
DataSymbolOptions
]
],


DataDescriptorWindow,CurrentBackground[] (* background irrelevant *)

], (* CollectGraphicalEleents *)
EntryGraphicalElements={}
]; (* If CurrentStyleName *)

(* consolidate entry graphical elements into Graphics *)
EntryGraphics=Graphics[
FigAssemblePrimatives[EntryGraphicalElements],
PlotRange->{{-1,+1}*EntryWidth/2,{-1,+1}*EntryHeight/2},
ImageSize->{EntryWidth,EntryHeight}
];
If[
(Debug/.FigOptions),
Print[EntryGraphics//FullForm]
];

(* produce text *)
EntryText=FigStyledText[CurrentText,FigOptions];
]; (* If entry *)

(* produce entry from graphics/text *)
Grid[{{EntryGraphics,EntryText}},Alignment->{Left,Center},Spacings->UpgradeScalar[(InternalSeparation/.FigOptions)]/(FontSize/.FigOptions)],

{r,1,UsedRows},{s,1,UsedColumns}
], (* Table *)
Alignment->{Left,Center},
Spacings->UpgradePair[(EntrySpacing/.FigOptions)]/(FontSize/.FigOptions)
], (* Grid *)
None
] ;(* If show *)

(* emit legend *)
TextElement=FigTextElement[P0,LegendContents,FigOptions];

(* save references to spawned objects *)
Self@SetTextElement[TextElement];
];


Constructor[Class:DataLegend,Self_Object][p:FigPointPattern,DataSetInfo:DataSetInfoPattern,Opts___?OptionQ]:=FigObjectWrapper[Class,Self,{Opts},

BasicDataLegend[Self][FigAnchor[p],DataSetInfo]
];


Constructor[Class:DataLegend,Self_Object][DataSetInfo:DataSetInfoPattern,Opts___?OptionQ]:=FigObjectWrapper[Class,Self,{Opts},

(* validate special option *)
FigCheckOption[Self,Point,FigPointPattern,FigOptions];

BasicDataLegend[Self][FigAnchor[(Point/.FigOptions)],DataSetInfo]

];


MakeAnchor[Class:DataLegend,Self_Object][Name_,Arg_]:=FigMakeAnchorWrapper[Class,Self,Name,Arg,
FigRectangleAnchor[
(Self@GetTextElement[])@GetCenter[],(Self@GetTextElement[])@GetRadius[],(Self@GetTextElement[])@GetPivot[],(Self@GetTextElement[])@GetRotation[],
Name,Arg
]
];
MakeBoundingBox[Class:DataLegend,Self_Object][]:=FigRectangleBoundingBox[
(Self@GetTextElement[])@GetCenter[],(Self@GetTextElement[])@GetRadius[],(Self@GetTextElement[])@GetPivot[],(Self@GetTextElement[])@GetRotation[]
];


Default[AttachIndex]=1;
AttachIndex[Start_.,Step_.,DataArray_?MatrixQ]:=Module[
{Indices},
Indices=Table[Start+i*Step,{i,0,Length[DataArray]-1}];
ArrayFlatten[{{Transpose[{Indices}],DataArray}}]
];
AttachIndex[Start_.,Step_.,DataList_?VectorQ]:=AttachIndex[Start,Step,Transpose[{DataList}]];


DeclareFigFallThroughError[AttachIndex];


SelectByColumn[DataArray_?MatrixQ,c_Integer,patt_]:=Select[DataArray,MatchQ[Part[#,c],patt]&];


(*SelectByColumn[DataArray_?MatrixQ,{c_Integer,patt_}]:=Select[DataArray,MatchQ[Part[#,c],patt]&];*)
SelectByColumn[DataArray_?MatrixQ]:=DataArray;
SelectByColumn[DataArray_?MatrixQ,{c_Integer,patt_},RestSeq:({_Integer,_}...)]:=Select[SelectByColumn[DataArray,RestSeq],MatchQ[Part[#,c],patt]&];


DeclareFigFallThroughError[SelectByColumn];


MissingQ[expr_]:=!FreeQ[expr,Missing];


Missingify[expr_]:=Replace[expr,(_Complex)|Except[_?NumericQ]->Missing[]];


MakeDataSet::length="Data sets have differing lengths `1`.";
MakeDataSet::nodata="MakeDataSet has been given an empty data set (possibly by accident?).";
MakeDataSet::outofrange="Encountered a reference to an entry DataEntry[`1`,`2`] with out-of-range indices, inconsistent with the given data sets.  (The indices shown here as the arguments to DataEntry are the full, explicit indices, including data set number, row number, and column number or range.  You may have actually specified the entry in abbreviated form.)";
MakeDataSet::badexpr="Expression for row gave non-list data.";
Options[MakeDataSet]={Range->All,Number->True,Select->True};
SetAttributes[MakeDataSet,HoldFirst]; (* HoldFirst to prevent premature evaluation of conditionals in row expression *)
MakeDataSet[Expr_,DataSet:{},Opts:OptionsPattern[]]:=(Message[MakeDataSet::nodata];{});
MakeDataSet[Expr_,DataSet:(_?MatrixQ),Opts:OptionsPattern[]]:=MakeDataSet[Expr,{DataSet},Opts];
MakeDataSet[Expr_,DataSets:{(_?MatrixQ)..},Opts:OptionsPattern[]]:=Module[
{RowsToUse,RawTable,DataSetDimensions,DataEntryExtractor,ExtractedData,NullRow},

(* check for consistent lengths *)
DataSetDimensions=Dimensions/@DataSets;
If[
!Equal@@(First/@DataSetDimensions),
FigError[MakeDataSet,"length",(First/@DataSetDimensions)]
];

(* define extractor functions *)
(* define single entry *)
DataEntryExtractor[s:_Integer:1,{r_Integer,c_Integer}]:=If[
((1<=s)&&(s<=Length[DataSets]))
&&((1<=Abs[r])&&(Abs[r]<=DataSetDimensions[[s,1]]))
&&((1<=Abs[c])&&(Abs[c]<=DataSetDimensions[[s,2]])),
ExtractedData=DataSets[[s,r,c]];
ExtractedData/.(_Missing->Missing[Unique[]]),
FigError[MakeDataSet,"outofrange",s,{r,c}]
];
(* define span entry *)
DataEntryExtractor[s:_Integer:1,{r_Integer,c:(All|_Span)}]:=If[
((1<=s)&&(s<=Length[DataSets]))
&&((1<=Abs[r])&&(Abs[r]<=DataSetDimensions[[s,1]])),
ExtractedData=DataSets[[s,r,c]];
If[
Head[ExtractedData]===Part,
FigError[MakeDataSet,"outofrange",s,{r,c}]
];
Sequence@@(ExtractedData/.(_Missing->Missing[Unique[]])),
FigError[MakeDataSet,"outofrange",s,{r,c}]
];
(* define entry with implicit row *)
DataEntryExtractor[s:_Integer:1,c:(_Integer|All|_Span)]:=DataEntry[s,{Row,c}];

(* construct new data set *)
RowsToUse=Take[Range[Length[First[DataSets]]],OptionValue[Range]];
(*RowsToUse=Part[Range[Length[First[DataSets]]],OptionValue[Range]]; -- this was used but is not consistent with documented meaning *)
Block[
{Row,DataEntry=DataEntryExtractor,RowData},
RawTable=Table[
If[TrueQ[OptionValue[Select]],
RowData=Expr;
If[
!ListQ[First[{RowData}]],  (* contortion necessary to trap possible RowData=Sequence[...] *)
FigError[MakeDataSet,"badexpr"]];
RowData,
NullRow
],
{Row,RowsToUse}
]
];
RawTable=Cases[RawTable,Except[NullRow]];

(* simplify "missing" entries *)
Map[
If[TrueQ[OptionValue[Number]],Missingify,Identity],
RawTable,
{2}
]
];


DeclareFigFallThroughError[MakeDataSet];


End[];


Protect[Evaluate[$Context<>"*"]];
Unprotect[Evaluate[$Context<>"$*"]];
EndPackage[];
