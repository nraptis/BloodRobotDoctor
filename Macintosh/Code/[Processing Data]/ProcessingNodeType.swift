//
//  ProcessingNodeType.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/3/23.
//

import Foundation

enum ProcessingNodeType: Int, CaseIterable {
    case none
    case gray
    case gauss
    case erosion
    case dilation
    
    /*
    void Erosion( int, void* )
    {
      int erosion_type = 0;
      if( erosion_elem == 0 ){ erosion_type = MORPH_RECT; }
      else if( erosion_elem == 1 ){ erosion_type = MORPH_CROSS; }
      else if( erosion_elem == 2) { erosion_type = MORPH_ELLIPSE; }
      Mat element = getStructuringElement( erosion_type,
                           Size( 2*erosion_size + 1, 2*erosion_size+1 ),
                           Point( erosion_size, erosion_size ) );
      erode( src, erosion_dst, element );
      imshow( "Erosion Demo", erosion_dst );
    }
    void Dilation( int, void* )
    {
      int dilation_type = 0;
      if( dilation_elem == 0 ){ dilation_type = MORPH_RECT; }
      else if( dilation_elem == 1 ){ dilation_type = MORPH_CROSS; }
      else if( dilation_elem == 2) { dilation_type = MORPH_ELLIPSE; }
      Mat element = getStructuringElement( dilation_type,
                           Size( 2*dilation_size + 1, 2*dilation_size+1 ),
                           Point( dilation_size, dilation_size ) );
      dilate( src, dilation_dst, element );
      imshow( "Dilation Demo", dilation_dst );
    }
    */
    
}

extension ProcessingNodeType {
    var name: String {
        switch self {
        case .none:
            return "None"
        case .gray:
            return "Gray"
        case .gauss:
            return "Gaussian"
        case .erosion:
            return "Erosion"
        case .dilation:
            return "Dilation"
        }
    }
}

extension ProcessingNodeType: Identifiable {
    var id: Int {
        rawValue
    }
}
