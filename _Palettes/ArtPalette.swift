import SwiftUI
import simd;

public struct ArtPalette {
    public typealias ColorType = MultiColor
    
    static func rgb(_ r: Int16, _ g: Int16, _ b: Int16) -> ColorType { return MultiColor.rgb(r, g, b) }

    // Black #05131D rgb(5, 19, 29)
    public static let black: ColorType = rgb(5, 19, 29);
    // Blue #0055BF rgb(0, 85, 191)
    public static let blue: ColorType = rgb(0, 85, 191);
    // Green #237841 rgb(35, 120, 65)
    public static let green: ColorType = rgb(35, 120, 65);
    // Dark-Turquoise #008F9B rgb(0, 143, 155)
    public static let darkTurquoise: ColorType = rgb(0, 143, 155);    
    // Red #C91A09 rgb(201, 26, 9)
    public static let red: ColorType = rgb(201, 26, 9);    
    // Dark-Pink #C870A0 rgb(200, 112, 160)
    public static let darkPink: ColorType = rgb(200, 112, 160);
    // Brown #583927 rgb(88, 57, 39)
    public static let brown: ColorType = rgb(88, 57, 39);
    // Light-Gray #9BA19D rgb(155, 161, 157)
    public static let lightGray: ColorType = rgb(155, 161, 157);
    // Dark-Gray #6D6E5C rgb(109, 110, 92)
    public static let darkGray: ColorType = rgb(109, 110, 92);
    // Light-Blue #B4D2E3 rgb(180, 210, 227)
    public static let lightBlue: ColorType = rgb(180, 210, 227);
    // Bright-Green #4B9F4A rgb(75, 159, 74)
    public static let brightGreen: ColorType = rgb(75, 159, 74);
    // Light-Turquoise #55A5AF rgb(85, 165, 175)
    public static let lightTurquoise: ColorType = rgb(85, 165, 175);
    // Salmon #F2705E rgb(242, 112, 94)
    public static let salmon: ColorType = rgb(242, 112, 94);
    // Pink #FC97AC rgb(252, 151, 172)
    public static let pink: ColorType = rgb(252, 151, 172);
    // Yellow #F2CD37 rgb(242, 205, 55)
    public static let yellow: ColorType = rgb(242, 205, 55);
    // White #FFFFFF rgb(255, 255, 255)
    public static let white: ColorType = rgb(255, 255, 255);
    // Light-Green #C2DAB8 rgb(194, 218, 184)
    public static let lightGreen: ColorType = rgb(194, 218, 184);
    // Light-Yellow #FBE696 rgb(251, 230, 150)
    public static let lightYellow: ColorType = rgb(251, 230, 150);
    // Tan #E4CD9E rgb(228, 205, 158)
    public static let tan: ColorType = rgb(228, 205, 158);
    // Light-Violet #C9CAE2 rgb(201, 202, 226)
    public static let lightViolet: ColorType = rgb(201, 202, 226);
    // Purple #81007B rgb(129, 0, 123)
    public static let purple: ColorType = rgb(129, 0, 123);
    //    Dark-Blue-Violet #2032B0 rgb(32, 50, 176)
    public static let darkBlueViolet: ColorType = rgb(32, 50, 176);
    //    Orange #FE8A18 rgb(254, 138, 24)
    public static let orange: ColorType = rgb(254, 138, 24);
    //    Magenta #923978 rgb(146, 57, 120)
    public static let magenta: ColorType = rgb(146, 57, 120);
    //    Lime #BBE90B rgb(187, 233, 11)
    public static let lime: ColorType = rgb(187, 233, 11);
    //    Dark-Tan #958A73 rgb(149, 138, 115)
    public static let darkTan: ColorType = rgb(149, 138, 115);
    //    Bright-Pink #E4ADC8 rgb(228, 173, 200)
    public static let brightPink: ColorType = rgb(228, 173, 200);
    //    Medium-Lavender #AC78BA rgb(172, 120, 186)
    public static let mediumLavender: ColorType = rgb(172, 120, 186);
    //    Lavender #E1D5ED rgb(225, 213, 237)
    public static let lavender: ColorType = rgb(225, 213, 237);
    //    Very-Light-Orange #F3CF9B rgb(243, 207, 155)
    public static let veryLightOrange: ColorType = rgb(243, 207, 155);
    //    Light-Purple #CD6298 rgb(205, 98, 152)
    public static let lightPurple: ColorType = rgb(205, 98, 152);
    //    Reddish-Brown #582A12 rgb(88, 42, 18)
    public static let reddishBrown: ColorType = rgb(88, 42, 18);
    //    Light-Bluish-Gray #A0A5A9 rgb(160, 165, 169)
    public static let lightBluishGray: ColorType = rgb(160, 165, 169)
    //    Dark-Bluish-Gray #6C6E68 rgb(108, 110, 104)
    public static let darkBluishGray: ColorType = rgb(108, 110, 104);
    //    Medium-Blue #5A93DB rgb(90, 147, 219)
    public static let mediumBlue: ColorType = rgb(90, 147, 219);
    //    Medium-Green #73DCA1 rgb(115, 220, 161)
    public static let mediumGreen: ColorType = rgb(115, 220, 161);
    //    Light-Pink #FECCCF rgb(254, 204, 207)
    public static let lightPink: ColorType = rgb(254, 204, 207);
    //    Light-Flesh #F6D7B3 rgb(246, 215, 179)
    public static let lightFlesh: ColorType = rgb(246, 215, 179);
    //    Milky-White #FFFFFF rgb(255, 255, 255)
    public static let milkyWhite: ColorType = rgb(255, 255, 255);
    //    Metallic-Silver #A5A9B4 rgb(165, 169, 180)
    public static let metallicSilver: ColorType = rgb(165, 169, 180);
    //    Metallic-Green #899B5F rgb(137, 155, 95)
    public static let metallicGreen: ColorType = rgb(137, 155, 95);
    //    Metallic-Gold #DBAC34 rgb(219, 172, 52)
    public static let metallicGold: ColorType = rgb(219, 172, 52);
    //    Medium-Dark-Flesh #CC702A rgb(204, 112, 42)
    public static let mediumDarkFlesh: ColorType = rgb(204, 112, 42);
    //    Dark-Purple #3F3691 rgb(63, 54, 145)
    public static let darkPurple: ColorType = rgb(63, 54, 145);
    //    Dark-Flesh #7C503A rgb(124, 80, 58)
    public static let darkFlesh: ColorType = rgb(124, 80, 58);
    //    Royal-Blue #4C61DB rgb(76, 97, 219)
    public static let royalBlue: ColorType = rgb(76, 97, 219);
    //    Flesh #D09168 rgb(208, 145, 104)
    public static let flesh: ColorType = rgb(208, 145, 104);
    //    Light-Salmon #FEBABD rgb(254, 186, 189)
    public static let lightSalmon: ColorType = rgb(254, 186, 189);
    //    Violet #4354A3 rgb(67, 84, 163)
    public static let violet: ColorType = rgb(67, 84, 163);
    //    Blue-Violet #6874CA rgb(104, 116, 202)
    public static let blueViolet: ColorType = rgb(104, 116, 202);
    //    Medium-Lime #C7D23C rgb(199, 210, 60)
    public static let mediumLime: ColorType = rgb(199, 210, 60)
    //    Aqua #B3D7D1 rgb(179, 215, 209)
    public static let aqua: ColorType = rgb(179, 215, 209)
    //    Light-Lime #D9E4A7 rgb(217, 228, 167)
    public static let lightLime: ColorType = rgb(217, 228, 167)
    //    Light-Orange #F9BA61 rgb(249, 186, 97)
    public static let lightOrange: ColorType = rgb(249, 186, 97)
    //    Copper #AE7A59 rgb(174, 122, 89)
    public static let copper: ColorType = rgb(174, 122, 89)
    //    Metal-Blue #7988A1 rgb(121, 136, 161)
    public static let metalBlue: ColorType = rgb(121, 136, 161)
    //    Very-Light-Bluish-Gray #E6E3E0 rgb(230, 227, 224)
    public static let veryLightBluishGray: ColorType = rgb(230, 227, 224)
    //    Yellowish-Green #DFEEA5 rgb(223, 238, 165)
    public static let yellowishGreen: ColorType = rgb(223, 238, 165)
    //    Flat-Dark-Gold #B48455 rgb(180, 132, 85)
    public static let flatDarkGold: ColorType = rgb(180, 132, 85)
    //    Flat-Silver #898788 rgb(137, 135, 136)
    public static let flatSilver: ColorType = rgb(137, 135, 136)
    //    Pearl-Light-Gray #9CA3A8 rgb(156, 163, 168)
    public static let pearlLightGray: ColorType = rgb(156, 163, 168)
    //    Pearl-Light-Gold #DCBC81 rgb(220, 188, 129)
    public static let pearlLightGold: ColorType = rgb(220, 188, 129)
    //    Pearl-Dark-Gray #575857 rgb(87, 88, 87)
    public static let pearlDarkGray: ColorType = rgb(87, 88, 87)
    //    Pearl-Very-Light-Gray #ABADAC rgb(171, 173, 172)
    public static let pearlVeryLightGray: ColorType = rgb(171, 173, 172);
    //    Pearl-White #F2F3F2 rgb(242, 243, 242)
    public static let pearlWhite: ColorType = rgb(242, 243, 242);
    //    Pearl-Gold #AA7F2E rgb(170, 127, 46)
    public static let pearlGold: ColorType = rgb(170, 127, 46)
    //    Bright-Light-Orange #F8BB3D rgb(248, 187, 61)
    public static let brightLightOrange: ColorType = rgb(248, 187, 61);
    //    Bright-Light-Blue #9FC3E9 rgb(159, 195, 233)
    public static let brightLightBlue: ColorType = rgb(159, 195, 233);
    //    Rust #B31004 rgb(179, 16, 4)
    public static let rust: ColorType = rgb(179, 16, 4);
    //    Bright-Light-Yellow #FFF03A rgb(255, 240, 58)
    public static let brightLightYellow: ColorType = rgb(255, 240, 58);
    //    Sky-Blue #7DBFDD rgb(125, 191, 221)
    public static let skyBlue: ColorType = rgb(125, 191, 221);
    //    Dark-Blue #0A3463 rgb(10, 52, 99)
    public static let darkBlue: ColorType = rgb(10, 52, 99)
    //    Dark-Green #184632 rgb(24, 70, 50)
    public static let darkGreen: ColorType = rgb(24, 70, 50)
    //    Dark-Brown #352100 rgb(53, 33, 0)
    public static let darkBrown: ColorType = rgb(53, 33, 0)
    //    Maersk-Blue #3592C3 rgb(53, 146, 195)
    public static let maerskBlue: ColorType = rgb(53, 146, 195)
    //    Dark-Red #720E0F rgb(114, 14, 15)
    public static let darkRed: ColorType = rgb(114, 14, 15)
    //    Dark-Azure #078BC9 rgb(7, 139, 201)
    public static let darkAzure: ColorType = rgb(7, 139, 201)
    //    Medium-Azure #36AEBF rgb(54, 174, 191)
    public static let mediumAzure: ColorType = rgb(54, 174, 191)
    //    Light-Aqua #ADC3C0 rgb(173, 195, 192)
    public static let lightAque: ColorType = rgb(173, 195, 192)
    //    Olive-Green #9B9A5A rgb(155, 154, 90)
    public static let oliveGreen: ColorType = rgb(155, 154, 90)
    //    Sand-Red #D67572 rgb(214, 117, 114)
    public static let sandRed: ColorType = rgb(214, 117, 114)
    //    Medium-Dark-Pink #F785B1 rgb(247, 133, 177)
    public static let mediumDarkPink: ColorType = rgb(247, 133, 177)
    //    Earth-Orange #FA9C1C rgb(250, 156, 28)
    public static let earthOrange: ColorType = rgb(250, 156, 28)
    //    Sand-Purple #845E84 rgb(132, 94, 132)
    public static let sandPurple: ColorType = rgb(132, 94, 132)
    //    Sand-Green #A0BCAC rgb(160, 188, 172)
    public static let sandGreen: ColorType = rgb(160, 188, 172)
    //    Sand-Blue #6074A1 rgb(96, 116, 161)
    public static let sandBlue: ColorType = rgb(96, 116, 161)
    //    Fabuland-Brown #B67B50 rgb(182, 123, 80)
    public static let fabulandBrown: ColorType = rgb(182, 123, 80)
    //    Medium-Orange #FFA70B rgb(255, 167, 11)
    public static let mediumOrange: ColorType = rgb(255, 167, 11)
    //    Dark-Orange #A95500 rgb(169, 85, 0)
    public static let darkOrange: ColorType = rgb(169, 85, 0)
    //    Very-Light-Gray #E6E3DA rgb(230, 227, 218)
    public static let veryLightGray: ColorType = rgb(230, 227, 218)
    //    Medium-Violet #9391E4 rgb(147, 145, 228)
    public static let mediumViolet: ColorType = rgb(147, 145, 228)
    //    Reddish-Lilac #8E5597 rgb(142, 85, 151)
    public static let reddishLilac: ColorType = rgb(142, 85, 151)
    //    Coral #FF698F rgb(0xFF, 0x69, 0x8F)
    public static let coral: ColorType = rgb(0xFF, 0x69, 0x8F)
    //    VibrantYellow #EBD800 rgb(0xEB, 0xD8, 0x00)
    public static let vibrantYellow: ColorType = rgb(0xEB, 0xD8, 0x00)
    
    
    //    Chrome-Gold #BBA53D rgb(187, 165, 61)
    public static let chromeGold: ColorType = rgb(187, 165, 61)
    //    Chrome-Silver #E0E0E0 rgb(224, 224, 224)
    public static let chromeSilver: ColorType = rgb(224, 224, 224)
    //    Chrome-Antique-Brass #645A4C rgb(100, 90, 76)
    public static let chromeAntiqueBrass: ColorType = rgb(100, 90, 76)
    //    Chrome-Blue #6C96BF rgb(108, 150, 191)
    public static let chromeBlue: ColorType = rgb(108, 150, 191)
    //    Chrome-Green #3CB371 rgb(60, 179, 113)
    public static let chromeGreen: ColorType = rgb(60, 179, 113)
    //    Chrome-Pink #AA4D8E rgb(170, 77, 142)
    public static let chromePink: ColorType = rgb(170, 77, 142)
    //    Chrome-Black #1B2A34 rgb(27, 42, 52)
    public static let chromeBlack: ColorType = rgb(27, 42, 52)
    //    Speckle-Black-Silver #000000 rgb(0, 0, 0)
    public static let speckleBlackSilver: ColorType = rgb(0, 0, 0)
    //    Speckle-Black-Gold #000000 rgb(0, 0, 0)
    public static let speckleBlackGold: ColorType = rgb(0, 0, 0)
    //    Speckle-Black-Copper #000000 rgb(0, 0, 0)
    public static let speckleBlackCopper: ColorType = rgb(0, 0, 0)
    //    Speckle-DBGray-Silver #635F61 rgb(99, 95, 97)
    public static let speckleDBGraySilver: ColorType = rgb(99, 95, 97)
    
    
    
    
    /*
     //
     // Not integrated special colors like glitter, glow-in-the-dark or transparent
     //
     Glow-In-Dark-Opaque #D4D5C9 rgb(212, 213, 201)
     Glow-in-Dark-White #D9D9D9 rgb(217, 217, 217)
     Glow-In-Dark-Trans #BDC6AD rgb(189, 198, 173)
     
     Trans-Orange #F08F1C rgb(240, 143, 28)
     Trans-Pink #E4ADC8 rgb(228, 173, 200)
     Trans-Light-Purple #96709F rgb(150, 112, 159)
     Trans-Flame-Yellowish-Orange #FCB76D rgb(252, 183, 109)
     Trans-Fire-Yellow #FBE890 rgb(251, 232, 144)
     Trans-Light-Royal-Blue #B4D4F7 rgb(180, 212, 247)
     Trans-Black-IR-Lens #635F52 rgb(99, 95, 82)
     Trans-Dark-Blue #0020A0 rgb(0, 32, 160)
     Trans-Green #84B68D rgb(132, 182, 141)
     Trans-Bright-Green #D9E4A7 rgb(217, 228, 167)
     Trans-Red #C91A09 rgb(201, 26, 9)
     Trans-Black #635F52 rgb(99, 95, 82)
     Trans-Light-Blue #AEEFEC rgb(174, 239, 236)
     Trans-Neon-Green #F8F184 rgb(248, 241, 132)
     Trans-Very-Lt-Blue #C1DFF0 rgb(193, 223, 240)
     Trans-Dark-Pink #DF6695 rgb(223, 102, 149)
     Trans-Yellow #F5CD2F rgb(245, 205, 47)
     Trans-Clear #FCFCFC rgb(252, 252, 252)
     Trans-Purple #A5A5CB rgb(165, 165, 203)
     Trans-Neon-Yellow #DAB000 rgb(218, 176, 0)
     Trans-Neon-Orange #FF800D rgb(255, 128, 13)
     Trans-Medium-Blue #CFE2F7 rgb(207, 226, 247)
     
     Glitter-Trans-Dark-Pink #DF6695 rgb(223, 102, 149)
     Glitter-Trans-Clear #FFFFFF rgb(255, 255, 255)     
     Glitter-Trans-Purple #A5A5CB rgb(165, 165, 203)
     Glitter-Trans-Neon-Green #C0F500 rgb(192, 245, 0)
     Glitter-Trans-Light-Blue #68BCC5 rgb(104, 188, 197)
     
     */
    
}
