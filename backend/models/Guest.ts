import mongoose from "mongoose";

const Schema = mongoose.Schema;

const GuestSchema = new Schema({
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

