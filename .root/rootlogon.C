{
    TString includePath = "-I${ROOTSYS}/include ";
    gSystem->SetIncludePath(includePath.Data());
    
    //================= define the style =================== //
    
    // divisions: axis marks outside the figure (minus sign)
    gStyle->SetTickLength(-0.03,"X");  gStyle->SetTickLength(-0.03,"Y");
    gStyle->SetNdivisions(508,"X");    gStyle->SetNdivisions(506,"Y"); // set ndvx (y)
    
    // dimensions and position of fonts connected to axes
    gStyle->SetLabelSize(0.05,"X");    gStyle->SetLabelSize(0.05,"Y");
    gStyle->SetLabelOffset(0.02,"X");  gStyle->SetLabelOffset(0.04,"Y");
    
    // dimension of the canvas and of the figure (pad) inside it
    gStyle->SetTitleBorderSize(0);
    gStyle->SetCanvasDefW(600);        gStyle->SetCanvasDefH(600);
    gStyle->SetPadBottomMargin(0.16);  gStyle->SetPadLeftMargin(0.18);
    gStyle->SetPadTopMargin(0.08);     gStyle->SetPadRightMargin(0.06);
    gStyle->SetTitleXSize(0.05);       gStyle->SetTitleYSize(0.05);
    gStyle->SetTitleXOffset(1.5);      gStyle->SetTitleYOffset(1.9);
    gStyle->SetStatW(0.16);            gStyle->SetStatH(0.16);
    gStyle->SetFitFormat("9.6g");
    gStyle->SetCanvasColor(0);
    gStyle->SetCanvasBorderMode(0);
    gStyle->SetPadBorderMode(0);
    gStyle->SetOptTitle(1);
    gStyle->SetLabelFont(62,"XYZ");
    gStyle->SetTitleFont(62,"XYZ");
    gStyle->SetTitleFont(62,"PAD");
    
    TGaxis::SetMaxDigits(3);
    
    //  gStyle->SetOptStat(0);
    gStyle->SetOptStat(1110);
    gStyle->SetOptFit(1);
    
    gStyle->SetPalette(1,0);  // rainbow colors
    gStyle->SetHistLineWidth(2);
    
    gStyle->SetFrameBorderMode(0);
    gROOT->ForceStyle();
    
}

