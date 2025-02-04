import mongoose from "mongoose";

const Schema = mongoose.Schema;

const WeddingSchema = new Schema({
    weddingUUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: Schema.Types.String,
        required: true
    },
    location: {
        type: Schema.Types.String,
        required: true
    },
    images: {
        type: [String],
        default: []
    }, 
    date: {
        type: String,
        required: true
    }
})

export const Wedding = mongoose.model("wedding", WeddingSchema)