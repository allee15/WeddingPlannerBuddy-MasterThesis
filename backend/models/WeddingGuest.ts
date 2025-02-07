import mongoose from "mongoose";

const Schema = mongoose.Schema;

const WeddingGuestSchema = new Schema({
    weddingGuestUID: {
        type: Schema.Types.String,
        required: true
    },
    tableNb: {
        type: Schema.Types.String,
        required: true
    },
    location: {
        type: Schema.Types.String,
        required: true
    },
    date: {
        type: Schema.Types.String,
        required: true
    }
})

export const WeddingGuest = mongoose.model("WeddingGuest", WeddingGuestSchema)
