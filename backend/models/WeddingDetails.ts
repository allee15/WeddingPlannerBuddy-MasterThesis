import mongoose from "mongoose";

const Schema = mongoose.Schema;

const WeddingDressSchema = new Schema({
    weddingDressUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String,
        default: ""
    },
    description: {
        type: Schema.Types.String,
        default: ""
    }
});

export const WeddingDress = mongoose.model("weddingDress", WeddingDressSchema)

const BouquetSchema = new Schema({
    bouquetUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String,
        default: ""
    },
    description: {
        type: Schema.Types.String,
        default: ""
    }
});

export const Bouquet = mongoose.model("bouquet", BouquetSchema)

const GroomSuitSchema = new Schema({
    groomSuitUUID: {
        type: Schema.Types.String,
        required: true
    },
    link: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    photo: {
        type: Schema.Types.String,
        default: ""
    },
    description: {
        type: Schema.Types.String,
        default: ""
    }
});

export const GroomSuit = mongoose.model("groomSuit", GroomSuitSchema)

const ChurchCeremonySchema = new Schema({
    churchCeremonyUUID: {
        type: Schema.Types.String,
        required: true
    },
    churchAddress: {
        type: Schema.Types.String,
        default: ""
    },
    date: {
        type: Schema.Types.String,
        default: ""
    },
    hour: {
        type: Schema.Types.String,
        default: ""
    },
    preotName: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    }
});

export const ChurchCeremony = mongoose.model("churchCeremony", ChurchCeremonySchema)

const PartyLocationSchema = new Schema({
    partyLocationUUID: {
        type: Schema.Types.String,
        required: true
    },
    partyAddress: {
        type: Schema.Types.String,
        default: ""
    },
    date: {
        type: Schema.Types.String,
        default: ""
    },
    hour: {
        type: Schema.Types.String,
        default: ""
    },
    decorationsOrganizerDetails: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    }
});

export const PartyLocation = mongoose.model("partyLocation", PartyLocationSchema)

const CivilMarriageSchema = new Schema({
    civilMarriageUUID: {
        type: Schema.Types.String,
        required: true
    },
    address: {
        type: Schema.Types.String,
        default: ""
    },
    date: {
        type: Schema.Types.String,
        default: ""
    },
    hour: {
        type: Schema.Types.String,
        default: ""
    }
});

export const CivilMarriage = mongoose.model("civilMarriage", CivilMarriageSchema)

const FoodMenuSchema = new Schema({
    foodMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    antreu: [{
        type: Schema.Types.String,
        default: ""
    }],
    firstCourse: [{
        type: Schema.Types.String,
        default: ""
    }],
    mainCourse: [{
        type: Schema.Types.String,
        default: ""
    }],
    secondMainCourse: [{
        type: Schema.Types.String,
        default: ""
    }],
    price: {
        type: Schema.Types.Int32,
        default: 0
    }
});

export const FoodMenu = mongoose.model("foodMenu", FoodMenuSchema)

const BarMenuSchema = new Schema({
    barMenuUUID: {
        type: Schema.Types.String,
        required: true
    },
    alcoholic: [{
        type: Schema.Types.String,
        default: ""
    }],
    nonalcoholic: [{
        type: Schema.Types.String,
        default: ""
    }],
    coffee: [{
        type: Schema.Types.String,
        default: ""
    }],
    juice: [{
        type: Schema.Types.String,
        default: ""
    }],
    price: {
        type: Schema.Types.Int32,
        default: 0
    }
});

export const BarMenu = mongoose.model("barMenu", BarMenuSchema)

const WeddingCakeSchema = new Schema({
    weddingCakeUUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: Schema.Types.String,
        default: ""
    },
    photo: {
        type: Schema.Types.String,
        default: ""
    },
    description: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    }
});

export const WeddingCake = mongoose.model("weddingCake", WeddingCakeSchema)

const LiveBandSchema = new Schema({
    liveBandUUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: Schema.Types.String,
        default: ""
    },
    price: {
        type: Schema.Types.Int32,
        default: 0
    },
    hour: {
        type: Schema.Types.String,
        default: ""
    },
    details: {
        type: Schema.Types.String,
        default: ""
    },
    
});

export const LiveBand = mongoose.model("liveBand", LiveBandSchema)

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
        type: Schema.Types.ObjectId,
        ref: 'weddingDress'
    },
    bouquet: {
        type: Schema.Types.ObjectId,
        ref: 'bouquet'
    },
    groomSuit: {
        type: Schema.Types.ObjectId,
        ref: 'groomSuit'
    },
    churchCeremony: {
        type: Schema.Types.ObjectId,
        ref: 'churchCeremony'
    },
    partyLocation: {
        type: Schema.Types.ObjectId,
        ref: 'partyLocation'
    },
    civilMarriage: {
        type: Schema.Types.ObjectId,
        ref: 'civilMarriage'
    },
    foodMenu: {
        type: Schema.Types.ObjectId,
        ref: 'foodMenu'
    },
    barMenu: {
        type: Schema.Types.ObjectId,
        ref: 'barMenu'
    },
    weddingCake: {
        type: Schema.Types.ObjectId,
        ref: 'weddingCake'
    },
    liveBand: {
        type: Schema.Types.ObjectId,
        ref: 'liveBand'
    }
})

export const WeddingDetails = mongoose.model("weddingDetails", WeddingDetailsSchema)