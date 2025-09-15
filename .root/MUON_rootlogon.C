/* Copyright(c) 1998-1999, ALICE Experiment at CERN, All rights reserved. *
 * See cxx source for full Copyright notice                               */

/* $Id: rootlogon.C 50857 2011-07-29 10:57:32Z ivana $ */

/// \ingroup macros
/// \file rootlogon.C
/// \brief Macro which is run when starting Root in MUON
///
/// It loads the MUON libraries needed for simulation and reconstruction
/// and sets the include path. 
///
/// \author Laurent Aphecetche

{
    gROOT->SetStyle("Plain");

  //   gStyle->SetHistFillColor( 1 );
  //   gStyle->SetHistFillStyle(5001);
  gStyle->SetOptFit(1);
  gStyle->SetOptStat(1111);
  gStyle->SetHistLineWidth(2);
  gStyle->SetPadGridX( false );
  gStyle->SetPadGridY( false );
  gStyle->SetPalette( 1 );
  gStyle->SetPadTickX( 1 );
  gStyle->SetPadTickY( 1 );

  gStyle->SetLabelSize(0.05,"x"); gStyle->SetLabelSize(0.05,"y");
  gStyle->SetTitleXSize(0.05);
  gStyle->SetTitleYSize(0.05);
  gStyle->SetTitleFontSize(0.05);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetFrameFillColor(0);
  gStyle->SetCanvasBorderMode(0);
  gStyle->SetCanvasColor(0);
  gStyle->SetGridStyle(3);
  gStyle->SetPadBorderMode(0);
  gStyle->SetPadColor(0);

  cout << "Loading MUON libraries ..." << endl;
  gROOT->LoadMacro("${ALICE_ROOT}/MUON/loadlibs.C");
  gInterpreter->ProcessLine("loadlibs()");
    
  cout << "Setting include path ..." << endl;
  TString includePath = "-I${ALICE_ROOT}/STEER ";
  includePath        += "-I${ALICE_ROOT}/STEER/STEER ";
  includePath        += "-I${ALICE_ROOT}/STEER/STEERBase ";
  includePath        += "-I${ALICE_ROOT}/STEER/CDB ";
  includePath        += "-I${ALICE_ROOT}/STEER/ESD ";
  includePath        += "-I${ALICE_ROOT}/RAW ";
  includePath        += "-I${ALICE_ROOT}/FASTSIM ";
  includePath        += "-I${ALICE_ROOT}/EVGEN ";
  includePath        += "-I${ALICE_ROOT}/SHUTTLE/TestShuttle ";
  includePath        += "-I${ALICE_ROOT}/ITS ";
  includePath        += "-I${ALICE_ROOT}/MUON ";
  includePath        += "-I${ALICE_ROOT}/MUON/mapping ";
  includePath        += "-I${ALICE_ROOT}/RAW ";
  includePath        += "-I${ALICE_ROOT}/include ";

  gSystem->SetIncludePath(includePath.Data());
}
