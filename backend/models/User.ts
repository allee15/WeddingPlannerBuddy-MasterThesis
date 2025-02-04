import mongoose from "mongoose";
import { Table } from "./Table";
import { Guest } from "./Guest";
import { WeddingGuest } from "./WeddingGuest";

const Schema = mongoose.Schema;

const UserSchema = new Schema({
    userUID: {
        type: Schema.Types.String,
        required: true
    },
    token: {
        type: Schema.Types.String,
        required: true
    },
    email: {
        type: Schema.Types.String,
        required: true,
        trim: true,
        unique: true
    },
    hasActiveWedding: {
        type: Schema.Types.Boolean,
        required: true,
        default: false
    },
    tablesAtWedding: {
        type: [Table],
        required: true,
        default: []
    },
    otherWeddings: {
        type: [WeddingGuest],
        required: true,
        default: []
    },
    guests: {
        type: [Guest],
        required: true,
        default: []
    }
})

export const User = mongoose.model("user", UserSchema)
