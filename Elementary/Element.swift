//
//  Element.swift
//  Elementary
//
//  Created by Rick on 15/04/2018.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

struct Element {
    
    public let chemicalSymbol : String
    public let fullName : String
    public let atomicNumber : Int
    public let atomicMass : Int
    public let hexColourCode : String
    public let naturalState : State
    public let bondingType : BondingType
    public let group : Group
    
    private init(chemicalSymbol: String, fullName: String, atomicNumber: Int, atomicMass: Int, hexColourCode: String,
                 naturalState: State, bondingType: BondingType, group: Group) {
        self.chemicalSymbol = chemicalSymbol
        self.fullName = fullName
        self.atomicNumber = atomicNumber
        self.atomicMass = atomicMass
        self.hexColourCode = hexColourCode
        self.naturalState = naturalState
        self.bondingType = bondingType
        self.group = group
    }
    
    public static let H     = Element(chemicalSymbol: "H",  fullName: "Hydrogen",        atomicNumber: 1,  atomicMass: 1,      hexColourCode: "FFFFFF",   naturalState: State.GAS,    bondingType: BondingType.DIATOMIC,           group: Group.NON_METAL)
    public static let HE    = Element(chemicalSymbol: "He", fullName: "Helium",          atomicNumber: 2,  atomicMass: 4,      hexColourCode: "D9FFFF",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let LI    = Element(chemicalSymbol: "Li", fullName: "Lithium",         atomicNumber: 3,  atomicMass: 7,      hexColourCode: "CC80FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let BE    = Element(chemicalSymbol: "Be", fullName: "Beryllium",       atomicNumber: 4,  atomicMass: 9,      hexColourCode: "C2FF00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let B     = Element(chemicalSymbol: "B",  fullName: "Boron",           atomicNumber: 5,  atomicMass: 11,     hexColourCode: "FFB5B5",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.METALLOID)
    public static let C     = Element(chemicalSymbol: "C",  fullName: "Carbon",          atomicNumber: 6,  atomicMass: 12,     hexColourCode: "909090",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let N     = Element(chemicalSymbol: "N",  fullName: "Nitrogen",        atomicNumber: 7,  atomicMass: 14,     hexColourCode: "3050F8",   naturalState: State.GAS,    bondingType: BondingType.DIATOMIC,           group: Group.NON_METAL)
    public static let O     = Element(chemicalSymbol: "O",  fullName: "Oxygen",          atomicNumber: 8,  atomicMass: 16,     hexColourCode: "FF0D0D",   naturalState: State.GAS,    bondingType: BondingType.DIATOMIC,           group: Group.NON_METAL)
    public static let F     = Element(chemicalSymbol: "F",  fullName: "Fluorine",        atomicNumber: 9,  atomicMass: 19,     hexColourCode: "90E050",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NON_METAL)
    public static let NE    = Element(chemicalSymbol: "Ne", fullName: "Neon",            atomicNumber: 10, atomicMass: 20,     hexColourCode: "B3E3F5",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let NA    = Element(chemicalSymbol: "Na", fullName: "Sodium",          atomicNumber: 11, atomicMass: 23,     hexColourCode: "AB5CF2",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let MG    = Element(chemicalSymbol: "Mg", fullName: "Magnesium",       atomicNumber: 12, atomicMass: 24,     hexColourCode: "8AFF00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let AL    = Element(chemicalSymbol: "Al", fullName: "Aluminum",        atomicNumber: 13, atomicMass: 27,     hexColourCode: "BFA6A6",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let SI    = Element(chemicalSymbol: "Si", fullName: "Silicon",         atomicNumber: 14, atomicMass: 28,     hexColourCode: "F0C8A0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let P     = Element(chemicalSymbol: "P",  fullName: "Phosphorus",      atomicNumber: 15, atomicMass: 31,     hexColourCode: "FF8000",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let S     = Element(chemicalSymbol: "S",  fullName: "Sulfur",          atomicNumber: 16, atomicMass: 32,     hexColourCode: "FFFF30",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let CL    = Element(chemicalSymbol: "Cl", fullName: "Chlorine",        atomicNumber: 17, atomicMass: 35,     hexColourCode: "1FF01F",   naturalState: State.GAS,    bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let AR    = Element(chemicalSymbol: "Ar", fullName: "Argon",           atomicNumber: 18, atomicMass: 40,     hexColourCode: "80D1E3",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let K     = Element(chemicalSymbol: "K",  fullName: "Potassium",       atomicNumber: 19, atomicMass: 39,     hexColourCode: "8F40D4",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let CA    = Element(chemicalSymbol: "Ca", fullName: "Calcium",         atomicNumber: 20, atomicMass: 40,     hexColourCode: "3DFF00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let SC    = Element(chemicalSymbol: "Sc", fullName: "Scandium",        atomicNumber: 21, atomicMass: 45,     hexColourCode: "E6E6E6",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let TI    = Element(chemicalSymbol: "Ti", fullName: "Titanium",        atomicNumber: 22, atomicMass: 48,     hexColourCode: "BFC2C7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let V     = Element(chemicalSymbol: "V",  fullName: "Vanadium",        atomicNumber: 23, atomicMass: 51,     hexColourCode: "A6A6AB",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let CR    = Element(chemicalSymbol: "Cr", fullName: "Chromium",        atomicNumber: 24, atomicMass: 52,     hexColourCode: "8A99C7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let MN    = Element(chemicalSymbol: "Mn", fullName: "Manganese",       atomicNumber: 25, atomicMass: 55,     hexColourCode: "9C7AC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let FE    = Element(chemicalSymbol: "Fe", fullName: "Iron",            atomicNumber: 26, atomicMass: 56,     hexColourCode: "E06633",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let CO    = Element(chemicalSymbol: "Co", fullName: "Cobalt",          atomicNumber: 27, atomicMass: 59,     hexColourCode: "F090A0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let NI    = Element(chemicalSymbol: "Ni", fullName: "Nickel",          atomicNumber: 28, atomicMass: 59,     hexColourCode: "50D050",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let CU    = Element(chemicalSymbol: "Cu", fullName: "Copper",          atomicNumber: 29, atomicMass: 64,     hexColourCode: "C88033",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let ZN    = Element(chemicalSymbol: "Zn", fullName: "Zinc",            atomicNumber: 30, atomicMass: 65,     hexColourCode: "7D80B0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let GA    = Element(chemicalSymbol: "Ga", fullName: "Gallium",         atomicNumber: 31, atomicMass: 70,     hexColourCode: "C28F8F",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let GE    = Element(chemicalSymbol: "Ge", fullName: "Germanium",       atomicNumber: 32, atomicMass: 73,     hexColourCode: "668F8F",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let AS    = Element(chemicalSymbol: "As", fullName: "Arsenic",         atomicNumber: 33, atomicMass: 75,     hexColourCode: "BD80E3",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let SE    = Element(chemicalSymbol: "Se", fullName: "Selenium",        atomicNumber: 34, atomicMass: 79,     hexColourCode: "FFA100",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.NON_METAL)
    public static let BR    = Element(chemicalSymbol: "Br", fullName: "Bromine",         atomicNumber: 35, atomicMass: 80,     hexColourCode: "A62929",   naturalState: State.LIQUID, bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let KR    = Element(chemicalSymbol: "Kr", fullName: "Krypton",         atomicNumber: 36, atomicMass: 84,     hexColourCode: "5CB8D1",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let RB    = Element(chemicalSymbol: "Rb", fullName: "Rubidium",        atomicNumber: 37, atomicMass: 85,     hexColourCode: "702EB0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let SR    = Element(chemicalSymbol: "Sr", fullName: "Strontium",       atomicNumber: 38, atomicMass: 88,     hexColourCode: "00FF00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let Y     = Element(chemicalSymbol: "Y",  fullName: "Yttrium",         atomicNumber: 39, atomicMass: 89,     hexColourCode: "94FFFF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let ZR    = Element(chemicalSymbol: "Zr", fullName: "Zirconium",       atomicNumber: 40, atomicMass: 91,     hexColourCode: "94E0E0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let NB    = Element(chemicalSymbol: "Nb", fullName: "Niobium",         atomicNumber: 41, atomicMass: 93,     hexColourCode: "73C2C9",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let MO    = Element(chemicalSymbol: "Mo", fullName: "Molybdenum",      atomicNumber: 42, atomicMass: 96,     hexColourCode: "54B5B5",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let TC    = Element(chemicalSymbol: "Tc", fullName: "Technetium",      atomicNumber: 43, atomicMass: 98,     hexColourCode: "3B9E9E",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let RU    = Element(chemicalSymbol: "Ru", fullName: "Ruthenium",       atomicNumber: 44, atomicMass: 101,    hexColourCode: "248F8F",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let RH    = Element(chemicalSymbol: "Rh", fullName: "Rhodium",         atomicNumber: 45, atomicMass: 103,    hexColourCode: "0A7D8C",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let PD    = Element(chemicalSymbol: "Pd", fullName: "Palladium",       atomicNumber: 46, atomicMass: 106,    hexColourCode: "006985",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let AG    = Element(chemicalSymbol: "Ag", fullName: "Silver",          atomicNumber: 47, atomicMass: 108,    hexColourCode: "C0C0C0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let CD    = Element(chemicalSymbol: "Cd", fullName: "Cadmium",         atomicNumber: 48, atomicMass: 112,    hexColourCode: "FFD98F",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let IN    = Element(chemicalSymbol: "In", fullName: "Indium",          atomicNumber: 49, atomicMass: 115,    hexColourCode: "A67573",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let SN    = Element(chemicalSymbol: "Sn", fullName: "Tin",             atomicNumber: 50, atomicMass: 119,    hexColourCode: "668080",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let SB    = Element(chemicalSymbol: "Sb", fullName: "Antimony",        atomicNumber: 51, atomicMass: 122,    hexColourCode: "9E63B5",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let TE    = Element(chemicalSymbol: "Te", fullName: "Tellurium",       atomicNumber: 52, atomicMass: 128,    hexColourCode: "D47A00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let I     = Element(chemicalSymbol: "I",  fullName: "Iodine",          atomicNumber: 53, atomicMass: 127,    hexColourCode: "940094",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.NON_METAL)
    public static let XE    = Element(chemicalSymbol: "Xe", fullName: "Xenon",           atomicNumber: 54, atomicMass: 131,    hexColourCode: "429EB0",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let CS    = Element(chemicalSymbol: "Cs", fullName: "Cesium",          atomicNumber: 55, atomicMass: 133,    hexColourCode: "57178F",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let BA    = Element(chemicalSymbol: "Ba", fullName: "Barium",          atomicNumber: 56, atomicMass: 137,    hexColourCode: "00C900",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let LA    = Element(chemicalSymbol: "La", fullName: "Lanthanum",       atomicNumber: 57, atomicMass: 139,    hexColourCode: "70D4FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let CE    = Element(chemicalSymbol: "Ce", fullName: "Cerium",          atomicNumber: 58, atomicMass: 140,    hexColourCode: "FFFFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let PR    = Element(chemicalSymbol: "Pr", fullName: "Praseodymium",    atomicNumber: 59, atomicMass: 141,    hexColourCode: "D9FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let ND    = Element(chemicalSymbol: "Nd", fullName: "Neodymium",       atomicNumber: 60, atomicMass: 144,    hexColourCode: "C7FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let PM    = Element(chemicalSymbol: "Pm", fullName: "Promethium",      atomicNumber: 61, atomicMass: 145,    hexColourCode: "A3FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let SM    = Element(chemicalSymbol: "Sm", fullName: "Samarium",        atomicNumber: 62, atomicMass: 150,    hexColourCode: "8FFFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let EU    = Element(chemicalSymbol: "Eu", fullName: "Europium",        atomicNumber: 63, atomicMass: 152,    hexColourCode: "61FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let GD    = Element(chemicalSymbol: "Gd", fullName: "Gadolinium",      atomicNumber: 64, atomicMass: 157,    hexColourCode: "45FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let TB    = Element(chemicalSymbol: "Tb", fullName: "Terbium",         atomicNumber: 65, atomicMass: 159,    hexColourCode: "30FFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let DY    = Element(chemicalSymbol: "Dy", fullName: "Dysprosium",      atomicNumber: 66, atomicMass: 163,    hexColourCode: "1FFFC7",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let HO    = Element(chemicalSymbol: "Ho", fullName: "Holmium",         atomicNumber: 67, atomicMass: 165,    hexColourCode: "00FF9C",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let ER    = Element(chemicalSymbol: "Er", fullName: "Erbium",          atomicNumber: 68, atomicMass: 167,    hexColourCode: "000000",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let TM    = Element(chemicalSymbol: "Tm", fullName: "Thulium",         atomicNumber: 69, atomicMass: 169,    hexColourCode: "00D452",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let YB    = Element(chemicalSymbol: "Yb", fullName: "Ytterbium",       atomicNumber: 70, atomicMass: 173,    hexColourCode: "00BF38",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let LU    = Element(chemicalSymbol: "Lu", fullName: "Lutetium",        atomicNumber: 71, atomicMass: 175,    hexColourCode: "00AB24",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.LANTHANOID)
    public static let HF    = Element(chemicalSymbol: "Hf", fullName: "Hafnium",         atomicNumber: 72, atomicMass: 178,    hexColourCode: "4DC2FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let TA    = Element(chemicalSymbol: "Ta", fullName: "Tantalum",        atomicNumber: 73, atomicMass: 181,    hexColourCode: "4DA6FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let W     = Element(chemicalSymbol: "W",  fullName: "Tungsten",        atomicNumber: 74, atomicMass: 184,    hexColourCode: "2194D6",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let RE    = Element(chemicalSymbol: "Re", fullName: "Rhenium",         atomicNumber: 75, atomicMass: 186,    hexColourCode: "267DAB",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let OS    = Element(chemicalSymbol: "Os", fullName: "Osmium",          atomicNumber: 76, atomicMass: 190,    hexColourCode: "266696",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let IR    = Element(chemicalSymbol: "Ir", fullName: "Iridium",         atomicNumber: 77, atomicMass: 192,    hexColourCode: "175487",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let PT    = Element(chemicalSymbol: "Pt", fullName: "Platinum",        atomicNumber: 78, atomicMass: 195,    hexColourCode: "D0D0E0",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let AU    = Element(chemicalSymbol: "Au", fullName: "Gold",            atomicNumber: 79, atomicMass: 197,    hexColourCode: "FFD123",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let HG    = Element(chemicalSymbol: "Hg", fullName: "Mercury",         atomicNumber: 80, atomicMass: 201,    hexColourCode: "B8B8D0",   naturalState: State.LIQUID, bondingType: BondingType.METALLIC,           group: Group.TRANSITION_METAL)
    public static let TL    = Element(chemicalSymbol: "Tl", fullName: "Thallium",        atomicNumber: 81, atomicMass: 204,    hexColourCode: "A6544D",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let PB    = Element(chemicalSymbol: "Pb", fullName: "Lead",            atomicNumber: 82, atomicMass: 207,    hexColourCode: "575961",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let BI    = Element(chemicalSymbol: "Bi", fullName: "Bismuth",         atomicNumber: 83, atomicMass: 209,    hexColourCode: "9E4FB5",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.POST_TRANSITION_METAL)
    public static let PO    = Element(chemicalSymbol: "Po", fullName: "Polonium",        atomicNumber: 84, atomicMass: 209,    hexColourCode: "AB5C00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.METALLOID)
    public static let AT    = Element(chemicalSymbol: "At", fullName: "Astatine",        atomicNumber: 85, atomicMass: 210,    hexColourCode: "754F45",   naturalState: State.SOLID,  bondingType: BondingType.COVALENT_NETWORK,   group: Group.METALLOID)
    public static let RN    = Element(chemicalSymbol: "Rn", fullName: "Radon",           atomicNumber: 86, atomicMass: 222,    hexColourCode: "428296",   naturalState: State.GAS,    bondingType: BondingType.ATOMIC,             group: Group.NOBLE_GAS)
    public static let FR    = Element(chemicalSymbol: "Fr", fullName: "Francium",        atomicNumber: 87, atomicMass: 223,    hexColourCode: "420066",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALI_METAL)
    public static let RA    = Element(chemicalSymbol: "Ra", fullName: "Radium",          atomicNumber: 88, atomicMass: 226,    hexColourCode: "007D00",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ALKALINE_EARTH_METAL)
    public static let AC    = Element(chemicalSymbol: "Ac", fullName: "Actinium",        atomicNumber: 89, atomicMass: 227,    hexColourCode: "70ABFA",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let TH    = Element(chemicalSymbol: "Th", fullName: "Thorium",         atomicNumber: 90, atomicMass: 232,    hexColourCode: "00BAFF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let PA    = Element(chemicalSymbol: "Pa", fullName: "Protactinium",    atomicNumber: 91, atomicMass: 231,    hexColourCode: "00A1FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let U     = Element(chemicalSymbol: "U",  fullName: "Uranium",         atomicNumber: 92, atomicMass: 238,    hexColourCode: "008FFF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let NP    = Element(chemicalSymbol: "Np", fullName: "Neptunium",       atomicNumber: 93, atomicMass: 237,    hexColourCode: "0080FF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let PU    = Element(chemicalSymbol: "Pu", fullName: "Plutonium",       atomicNumber: 94, atomicMass: 244,    hexColourCode: "006BFF",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let AM    = Element(chemicalSymbol: "Am", fullName: "Americium",       atomicNumber: 95, atomicMass: 243,    hexColourCode: "545CF2",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let CM    = Element(chemicalSymbol: "Cm", fullName: "Curium",          atomicNumber: 96, atomicMass: 247,    hexColourCode: "785CE3",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let BK    = Element(chemicalSymbol: "Bk", fullName: "Berkelium",       atomicNumber: 97, atomicMass: 247,    hexColourCode: "8A4FE3",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID)
    public static let CF    = Element(chemicalSymbol: "Cf", fullName: "Californium",     atomicNumber: 98, atomicMass: 251,    hexColourCode: "A136D4",   naturalState: State.SOLID,  bondingType: BondingType.METALLIC,           group: Group.ACTINOID);
    
    public static let all = [H, HE, LI, BE, B, C, N, O, F, NE, NA, MG, AL, SI, P, S, CL, AR, K, CA, SC, TI, V, CR, MN, FE, CO, NI, CU, ZN, GA, GE, AS, SE, BR, KR, RB, SR, Y, ZR, NB, MO, TC, RU, RH, PD, AG, CD, IN, SN, SB, TE, I, XE, CS, BA, LA, CE, PR, ND, PM, SM, EU, GD, TB, DY, HO, ER, TM, YB, LU, HF, TA, W, RE, OS, IR, PT, AU, HG, TL, PB, BI, PO, AT, RN, FR, RA, AC, TH, PA, U, NP, PU, AM, CM, BK, CF]
    
    
    public static func getRandomEight() -> [Element] {
        var chosen = Set<Int>()
        while (chosen.count < 8) {
            chosen.insert(Int(arc4random_uniform(UInt32(Element.all.count))))
        }

        return chosen.map { all[$0] }
    }
    
    struct State {
        
        public let label : String
        
        private init(label: String) {
            self.label = label
        }
        
        public static let SOLID     = State(label: "Solid")
        public static let LIQUID    = State(label: "Liquid")
        public static let GAS       = State(label: "Gas")
    }
    
    struct BondingType {
        
        public let label : String
        
        private init(label: String) {
            self.label = label
        }
        
        public static let ATOMIC            = BondingType(label: "Atomic")
        public static let DIATOMIC          = BondingType(label: "Diatomic")
        public static let COVALENT_NETWORK  = BondingType(label: "Covalent\nNetwork")
        public static let METALLIC          = BondingType(label: "Metallic")
    }
    
    struct Group {
        
        public let label : String
        
        private init(label: String) {
            self.label = label
        }
        public static let ALKALI_METAL          = Group(label: "Alkali\nMetal")
        public static let ALKALINE_EARTH_METAL  = Group(label: "Alkaline\nEarth\nMetal")
        public static let LANTHANOID            = Group(label: "Lanthanoid")
        public static let ACTINOID              = Group(label: "Actinoid")
        public static let TRANSITION_METAL      = Group(label: "Transition\nMetal")
        public static let POST_TRANSITION_METAL = Group(label: "Post-\nTransition\nMetal")
        public static let METALLOID             = Group(label: "Metalloid")
        public static let NON_METAL             = Group(label: "Non-\nMetal")
        public static let NOBLE_GAS             = Group(label: "Noble\nGas")
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    
    static func getPropertyNameAndValue(_ element: Element, _ propertyIndex: Int) -> Answer {
        switch propertyIndex {
        case 1:
            return Answer(property: "Atomic Number: ", value: String(element.atomicNumber))
        case 2:
            return Answer(property: "Atomic Mass: ", value: String(element.atomicMass))
        case 3:
            return Answer(property: "Natural State: ", value: element.naturalState.label)
        case 4:
            return Answer(property: "Bonding Type: ", value: String(element.bondingType.label))
        case 5:
            return Answer(property: "Element Group: ", value: element.group.label)
        default:
            return Answer(property: "Full Name: ", value: element.fullName)
        }
    }
    
}
