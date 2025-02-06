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
    tablesAtWedding: [{
        type: Schema.Types.ObjectId,
        ref: 'Table'
    }],
    otherWeddings: [{
        type: Schema.Types.ObjectId,
        ref: 'WeddingGuest'
    }],
    guests: [{
        type: Schema.Types.ObjectId,
        ref: 'Guest'
    }]
})

export const User = mongoose.model("user", UserSchema)
