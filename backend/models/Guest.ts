import mongoose from "mongoose";

const Schema = mongoose.Schema;

const GuestSchema = new Schema({
    guestUUID: {
        type: Schema.Types.String,
        required: true
    },
    tableUID: {
        type: Schema.Types.String,
        required: true
    },
    name: {
        type: Schema.Types.String,
        required: true
    },
    email: {
        type: Schema.Types.String,
        required: true,
        trim: true,
        unique: true
    }
})

export const Guest = mongoose.model("Guest", GuestSchema)

