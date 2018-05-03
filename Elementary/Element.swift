//
//  Element.swift
//  Elementary
//
//  Created by Rick on 15/04/2018.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

struct Element : Equatable, Hashable {
    
    public let chemicalSymbol : String
    public let fullName : String
    public let atomicNumber : Int
    public let atomicMass : Int
    public let hexColourCode : String
    public let naturalState : State
    public let bondingType : BondingType
    public let group : Group
    
    private init(_ chemicalSymbol: String, _ fullName: String, _ atomicNumber: Int, _ atomicMass: Int, _ hexColourCode: String,
                 _ naturalState: State, _ bondingType: BondingType, _ group: Group) {
        self.chemicalSymbol = chemicalSymbol
        self.fullName = fullName
        self.atomicNumber = atomicNumber
        self.atomicMass = atomicMass
        self.hexColourCode = hexColourCode
        self.naturalState = naturalState
        self.bondingType = bondingType
        self.group = group
    } 
       
    public static let H     = Element("H",  "Hydrogen",     1,  1,   "FFFFFF", State.GAS,    BondingType.DIATOMIC,         Group.NON_METAL)
    public static let HE    = Element("He", "Helium",       2,  4,   "D9FFFF", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let LI    = Element("Li", "Lithium",      3,  7,   "CC80FF", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let BE    = Element("Be", "Beryllium",    4,  9,   "C2FF00", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let B     = Element("B",  "Boron",        5,  11,  "FFB5B5", State.SOLID,  BondingType.COVALENT_NETWORK, Group.METALLOID)
    public static let C     = Element("C",  "Carbon",       6,  12,  "909090", State.SOLID,  BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let N     = Element("N",  "Nitrogen",     7,  14,  "3050F8", State.GAS,    BondingType.DIATOMIC,         Group.NON_METAL)
    public static let O     = Element("O",  "Oxygen",       8,  16,  "FF0D0D", State.GAS,    BondingType.DIATOMIC,         Group.NON_METAL)
    public static let F     = Element("F",  "Fluorine",     9,  19,  "90E050", State.GAS,    BondingType.ATOMIC,           Group.NON_METAL)
    public static let NE    = Element("Ne", "Neon",         10, 20,  "B3E3F5", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let NA    = Element("Na", "Sodium",       11, 23,  "AB5CF2", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let MG    = Element("Mg", "Magnesium",    12, 24,  "8AFF00", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let AL    = Element("Al", "Aluminum",     13, 27,  "BFA6A6", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let SI    = Element("Si", "Silicon",      14, 28,  "F0C8A0", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let P     = Element("P",  "Phosphorus",   15, 31,  "FF8000", State.SOLID,  BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let S     = Element("S",  "Sulfur",       16, 32,  "FFFF30", State.SOLID,  BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let CL    = Element("Cl", "Chlorine",     17, 35,  "1FF01F", State.GAS,    BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let AR    = Element("Ar", "Argon",        18, 40,  "80D1E3", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let K     = Element("K",  "Potassium",    19, 39,  "8F40D4", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let CA    = Element("Ca", "Calcium",      20, 40,  "3DFF00", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let SC    = Element("Sc", "Scandium",     21, 45,  "E6E6E6", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let TI    = Element("Ti", "Titanium",     22, 48,  "BFC2C7", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let V     = Element("V",  "Vanadium",     23, 51,  "A6A6AB", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let CR    = Element("Cr", "Chromium",     24, 52,  "8A99C7", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let MN    = Element("Mn", "Manganese",    25, 55,  "9C7AC7", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let FE    = Element("Fe", "Iron",         26, 56,  "E06633", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let CO    = Element("Co", "Cobalt",       27, 59,  "F090A0", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let NI    = Element("Ni", "Nickel",       28, 59,  "50D050", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let CU    = Element("Cu", "Copper",       29, 64,  "C88033", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let ZN    = Element("Zn", "Zinc",         30, 65,  "7D80B0", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let GA    = Element("Ga", "Gallium",      31, 70,  "C28F8F", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let GE    = Element("Ge", "Germanium",    32, 73,  "668F8F", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let AS    = Element("As", "Arsenic",      33, 75,  "BD80E3", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let SE    = Element("Se", "Selenium",     34, 79,  "FFA100", State.SOLID,  BondingType.METALLIC,         Group.NON_METAL)
    public static let BR    = Element("Br", "Bromine",      35, 80,  "A62929", State.LIQUID, BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let KR    = Element("Kr", "Krypton",      36, 84,  "5CB8D1", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let RB    = Element("Rb", "Rubidium",     37, 85,  "702EB0", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let SR    = Element("Sr", "Strontium",    38, 88,  "00FF00", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let Y     = Element("Y",  "Yttrium",      39, 89,  "94FFFF", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let ZR    = Element("Zr", "Zirconium",    40, 91,  "94E0E0", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let NB    = Element("Nb", "Niobium",      41, 93,  "73C2C9", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let MO    = Element("Mo", "Molybdenum",   42, 96,  "54B5B5", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let TC    = Element("Tc", "Technetium",   43, 98,  "3B9E9E", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let RU    = Element("Ru", "Ruthenium",    44, 101, "248F8F", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let RH    = Element("Rh", "Rhodium",      45, 103, "0A7D8C", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let PD    = Element("Pd", "Palladium",    46, 106, "006985", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let AG    = Element("Ag", "Silver",       47, 108, "C0C0C0", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let CD    = Element("Cd", "Cadmium",      48, 112, "FFD98F", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let IN    = Element("In", "Indium",       49, 115, "A67573", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let SN    = Element("Sn", "Tin",          50, 119, "668080", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let SB    = Element("Sb", "Antimony",     51, 122, "9E63B5", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let TE    = Element("Te", "Tellurium",    52, 128, "D47A00", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let I     = Element("I",  "Iodine",       53, 127, "940094", State.SOLID,  BondingType.COVALENT_NETWORK, Group.NON_METAL)
    public static let XE    = Element("Xe", "Xenon",        54, 131, "429EB0", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let CS    = Element("Cs", "Cesium",       55, 133, "57178F", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let BA    = Element("Ba", "Barium",       56, 137, "00C900", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let LA    = Element("La", "Lanthanum",    57, 139, "70D4FF", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let CE    = Element("Ce", "Cerium",       58, 140, "FFFFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let PR    = Element("Pr", "Praseodymium", 59, 141, "D9FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let ND    = Element("Nd", "Neodymium",    60, 144, "C7FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let PM    = Element("Pm", "Promethium",   61, 145, "A3FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let SM    = Element("Sm", "Samarium",     62, 150, "8FFFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let EU    = Element("Eu", "Europium",     63, 152, "61FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let GD    = Element("Gd", "Gadolinium",   64, 157, "45FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let TB    = Element("Tb", "Terbium",      65, 159, "30FFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let DY    = Element("Dy", "Dysprosium",   66, 163, "1FFFC7", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let HO    = Element("Ho", "Holmium",      67, 165, "00FF9C", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let ER    = Element("Er", "Erbium",       68, 167, "000000", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let TM    = Element("Tm", "Thulium",      69, 169, "00D452", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let YB    = Element("Yb", "Ytterbium",    70, 173, "00BF38", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let LU    = Element("Lu", "Lutetium",     71, 175, "00AB24", State.SOLID,  BondingType.METALLIC,         Group.LANTHANOID)
    public static let HF    = Element("Hf", "Hafnium",      72, 178, "4DC2FF", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let TA    = Element("Ta", "Tantalum",     73, 181, "4DA6FF", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let W     = Element("W",  "Tungsten",     74, 184, "2194D6", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let RE    = Element("Re", "Rhenium",      75, 186, "267DAB", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let OS    = Element("Os", "Osmium",       76, 190, "266696", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let IR    = Element("Ir", "Iridium",      77, 192, "175487", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let PT    = Element("Pt", "Platinum",     78, 195, "D0D0E0", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let AU    = Element("Au", "Gold",         79, 197, "FFD123", State.SOLID,  BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let HG    = Element("Hg", "Mercury",      80, 201, "B8B8D0", State.LIQUID, BondingType.METALLIC,         Group.TRANSITION_METAL)
    public static let TL    = Element("Tl", "Thallium",     81, 204, "A6544D", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let PB    = Element("Pb", "Lead",         82, 207, "575961", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let BI    = Element("Bi", "Bismuth",      83, 209, "9E4FB5", State.SOLID,  BondingType.METALLIC,         Group.POST_TRANSITION_METAL)
    public static let PO    = Element("Po", "Polonium",     84, 209, "AB5C00", State.SOLID,  BondingType.METALLIC,         Group.METALLOID)
    public static let AT    = Element("At", "Astatine",     85, 210, "754F45", State.SOLID,  BondingType.COVALENT_NETWORK, Group.METALLOID)
    public static let RN    = Element("Rn", "Radon",        86, 222, "428296", State.GAS,    BondingType.ATOMIC,           Group.NOBLE_GAS)
    public static let FR    = Element("Fr", "Francium",     87, 223, "420066", State.SOLID,  BondingType.METALLIC,         Group.ALKALI_METAL)
    public static let RA    = Element("Ra", "Radium",       88, 226, "007D00", State.SOLID,  BondingType.METALLIC,         Group.ALKALINE_EARTH_METAL)
    public static let AC    = Element("Ac", "Actinium",     89, 227, "70ABFA", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let TH    = Element("Th", "Thorium",      90, 232, "00BAFF", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let PA    = Element("Pa", "Protactinium", 91, 231, "00A1FF", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let U     = Element("U",  "Uranium",      92, 238, "008FFF", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let NP    = Element("Np", "Neptunium",    93, 237, "0080FF", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let PU    = Element("Pu", "Plutonium",    94, 244, "006BFF", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let AM    = Element("Am", "Americium",    95, 243, "545CF2", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let CM    = Element("Cm", "Curium",       96, 247, "785CE3", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let BK    = Element("Bk", "Berkelium",    97, 247, "8A4FE3", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID)
    public static let CF    = Element("Cf", "Californium",  98, 251, "A136D4", State.SOLID,  BondingType.METALLIC,         Group.ACTINOID);
    
    public static let all = [H, HE, LI, BE, B, C, N, O, F, NE, NA, MG, AL, SI, P, S, CL, AR, K, CA, SC, TI, V, CR, MN, FE, CO, NI, CU, ZN, GA, GE, AS, SE, BR, KR, RB, SR, Y, ZR, NB, MO, TC, RU, RH, PD, AG, CD, IN, SN, SB, TE, I, XE, CS, BA, LA, CE, PR, ND, PM, SM, EU, GD, TB, DY, HO, ER, TM, YB, LU, HF, TA, W, RE, OS, IR, PT, AU, HG, TL, PB, BI, PO, AT, RN, FR, RA, AC, TH, PA, U, NP, PU, AM, CM, BK, CF]
    
    
    public static func getRandomEight() -> [Element] {
        var chosen = Set<Int>()
        while (chosen.count < 8) {
            chosen.insert(Int(arc4random_uniform(UInt32(Element.all.count))))
        }

        return chosen.map { all[$0] }
    }
    
    var hashValue: Int {
        return chemicalSymbol.hashValue ^ fullName.hashValue ^ atomicNumber.hashValue ^ atomicMass.hashValue
            ^ hexColourCode.hashValue ^ naturalState.hashValue ^ bondingType.hashValue ^ group.hashValue &* 16777619
    }
    
    static func == (lhs: Element, rhs: Element) -> Bool {
        // all should be unique but just to be sure check symbol AND name
        return lhs.chemicalSymbol == rhs.chemicalSymbol && lhs.fullName == rhs.fullName
    }
    
    struct State : Equatable, Hashable {
        
        public let label : String
        
        private init(label: String) {
            self.label = label
        }
        
        public static let SOLID     = State(label: "Solid")
        public static let LIQUID    = State(label: "Liquid")
        public static let GAS       = State(label: "Gas")
        
        var hashValue: Int {
            return label.hashValue &* 16777619
        }
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.label == rhs.label
        }
    }
    
    struct BondingType : Equatable, Hashable {
        
        public let label : String
        
        private init(label: String) {
            self.label = label
        }
        
        public static let ATOMIC            = BondingType(label: "Atomic")
        public static let DIATOMIC          = BondingType(label: "Diatomic")
        public static let COVALENT_NETWORK  = BondingType(label: "Covalent\nNetwork")
        public static let METALLIC          = BondingType(label: "Metallic")
        
        var hashValue: Int {
            return label.hashValue &* 16777619
        }
        
        static func == (lhs: BondingType, rhs: BondingType) -> Bool {
            return lhs.label == rhs.label
        }
    }
    
    struct Group : Equatable, Hashable {
        
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
        
        var hashValue: Int {
            return label.hashValue &* 16777619
        }
        
        static func == (lhs: Group, rhs: Group) -> Bool {
            return lhs.label == rhs.label
        }
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    struct Property : Equatable, Hashable {
        public let label: String
        private init(_ label: String) {
            self.label = label
        }
        public static let ATOMIC_NUMBER = Property("Atomic Number")
        public static let ATOMIC_MASS = Property("Atomic Mass")
        public static let NATURAL_STATE = Property("Natural State")
        public static let BONDING_TYPE = Property("Bonding Type")
        public static let GROUP = Property("Group")
        public static let FULL_NAME = Property("Full Name")
        
        public static func all() -> Set<Property> {
            return Set([ATOMIC_NUMBER, ATOMIC_MASS, NATURAL_STATE, BONDING_TYPE, GROUP, FULL_NAME])
        }
        
        public func getValue(from element: Element) -> String {
            return Property.getValue(for: self, from: element)
        }
        
        public static func getValue(for property: String, from element: Element) -> String {
            let property = getProperty(for: property)
            return getValue(for: property, from: element)
        }
        
        public static func getProperty(for propertyLabel: String) -> Property {
            return all().first(where: { $0.label == propertyLabel })!
        }
        
        public static func hasMatchingPropertyValue(for element: Element, and propertyLabel: String, matches expectedValue: String) -> Bool {
            let actualPropertyValue = getValue(for: propertyLabel, from: element)
            return actualPropertyValue == expectedValue
        }
        
        public static func getValue(for property: Property, from element: Element) -> String {
            switch (property) {
            case ATOMIC_NUMBER:
                return String(element.atomicNumber)
            case ATOMIC_MASS:
                return String(element.atomicMass)
            case NATURAL_STATE:
                return element.naturalState.label
            case BONDING_TYPE:
                return element.bondingType.label
            case GROUP:
                return element.group.label
            case FULL_NAME:
                return element.fullName
            default:
                return "" // cant happen....
            }
        }
        
        var hashValue: Int {
            return label.hashValue &* 16777619
        }
        
        static func == (lhs: Property, rhs: Property) -> Bool {
            return lhs.label == rhs.label
        }
    }
    
    static func getAnswer(_ element: Element, _ property: Property) -> Answer {
        return Answer(element: element, property: property.label, value: property.getValue(from: element))
    }
    
}
