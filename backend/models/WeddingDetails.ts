import mongoose from "mongoose";

const Schema = mongoose.Schema;

const WeddingDressSchema = new Schema({
    weddingDressUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String
    },
    description: {
        type: Schema.Types.String
    }
});

const BouquetSchema = new Schema({
    bouquetUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String
    },
    description: {
        type: Schema.Types.String
    }
});

const GroomSuitSchema = new Schema({
    groomSuitUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String
    },
    description: {
        type: Schema.Types.String
    }
});

const ChurchCeremonySchema = new Schema({
    churchCeremonyUUID: {
        type: Schema.Types.String,
        required: true
    },
    churchAddress: {
        type: Schema.Types.String
    },
    date: {
        type: Schema.Types.String
    },
    hour: {
        type: Schema.Types.String
    },
    preotName: {
        type: Schema.Types.String
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
        type: Schema.Types.String
    },
    date: {
        type: Schema.Types.String
    },
    hour: {
        type: Schema.Types.String
    },
    decorationsOrganizerDetails: {
        type: Schema.Types.String
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
        type: Schema.Types.String
    },
    date: {
        type: Schema.Types.String
    },
    hour: {
        type: Schema.Types.String
    }
});

const FoodMenuSchema = new Schema({
    foodMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    antreu: [{
        type: Schema.Types.String
    }],
    firstCourse: [{
        type: Schema.Types.String
    }],
    mainCourse: [{
        type: Schema.Types.String
    }],
    secondMainCourse: [{
        type: Schema.Types.String
    }],
    price: {
        type: Schema.Types.Int32
    }
});

const BarMenuSchema = new Schema({
    barMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    alcoholic: [{
        type: Schema.Types.String
    }],
    nonalcoholic: [{
        type: Schema.Types.String
    }],
    coffee: [{
        type: Schema.Types.String
    }],
    juice: [{
        type: Schema.Types.String
    }],
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
        type: Schema.Types.String
    },
    photo: {
        type: Schema.Types.String
    },
    description: {
        type: Schema.Types.String
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
        type: Schema.Types.String
    },
    price: {
        type: Schema.Types.Int32
    },
    hour: {
        type: Schema.Types.String
    },
    details: {
        type: Schema.Types.String
    },
    
});

const WeddingDetailsSchema = new Schema({
    weddingDetailsUUID: {
        type: Schema.Types.String,
        required: true
    },
    date: {
        type: Schema.Types.String,
        default: ""
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