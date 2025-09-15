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

}
