import mongoose from "mongoose";

const Schema = mongoose.Schema;

const WeddingDressSchema = new Schema({
    weddingDressUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: String
    },
    description: {
        type: String
    }
});

const BouquetSchema = new Schema({
    bouquetUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: String
    },
    description: {
        type: String
    }
});

const GroomSuitSchema = new Schema({
    groomSuitUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: String
    },
    description: {
        type: String
    }
});

const ChurchCeremonySchema = new Schema({
    churchCeremonyUUID: {
        type: Schema.Types.String,
        required: true
    },
    churchAddress: {
        type: String
    },
    date: {
        type: String
    },
    hour: {
        type: String
    },
    preotName: {
        type: String
    },
    price: {
        type: Schema.Types.Int32
    }
});

const PartyLocationSchema = new Schema({
    partyLocationUUID: {
        type: Schema.Types.String,
        required: true
    },
    partyAddress: {
        type: String
    },
    date: {
        type: String
    },
    hour: {
        type: String
    },
    decorationsOrganizerDetails: {
        type: String
    },
    price: {
        type: Schema.Types.Int32
    }
});

const CivilMarriageSchema = new Schema({
    civilMarriageUUID: {
        type: Schema.Types.String,
        required: true
    },
    address: {
        type: String
    },
    date: {
        type: String
    },
    hour: {
        type: String
    }
});

const FoodMenuSchema = new Schema({
    foodMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    antreu: {
        type: [String]
    },
    firstCourse: {
        type: [String]
    },
    mainCourse: {
        type: [String]
    },
    secondMainCourse: {
        type: [String]
    },
    price: {
        type: Schema.Types.Int32
    }
});

const BarMenuSchema = new Schema({
    barMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    alcoholic: {
        type: [String]
    },
    nonalcoholic: {
        type: [String]
    },
    coffee: {
        type: [String]
    },
    juice: {
        type: [String]
    },
    price: {
        type: Schema.Types.Int32
    }
});

const WeddingCakeSchema = new Schema({
    weddingCakeUUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: String
    },
    photo: {
        type: String
    },
    description: {
        type: String
    },
    price: {
        type: Schema.Types.Int32
    }
});

const LiveBandSchema = new Schema({
    liveBandUUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: String
    },
    price: {
        type: Schema.Types.Int32
    },
    hour: {
        type: String
    },
    details: {
        type: String
    },
    
});

const WeddingDetailsSchema = new Schema({
    weddingDetailsUUID: {
        type: Schema.Types.String,
        required: true
    },
    date: {
        type: String,
        required: true
    },
    weddingDress: {
        type: WeddingDressSchema
    },
    bouquet: {
        type: BouquetSchema
    },
    groomSuit: {
        type: GroomSuitSchema
    },
    churchCeremony: {
        type: ChurchCeremonySchema
    },
    partyLocation: {
        type: PartyLocationSchema
    },
    civilMarriage: {
        type: CivilMarriageSchema
    },
    foodMenu: {
        type: FoodMenuSchema
    },
    barMenu: {
        type: BarMenuSchema
    },
    weddingCake: {
        type: WeddingCakeSchema
    },
    liveBand: {
        type: LiveBandSchema
    }
})

export const WeddingDetails = mongoose.model("weddingDetails", WeddingDetailsSchema)