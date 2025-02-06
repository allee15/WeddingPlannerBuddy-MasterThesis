import mongoose from "mongoose";
import { Guest } from "./Guest";

const Schema = mongoose.Schema;

const CGPointSchema = new Schema({
    x: { type: Number, required: true },
    y: { type: Number, required: true }
});

const TableSchema = new Schema({
    tableUID: {
        type: Schema.Types.String,
        required: true
    },
    position: {
        type: CGPointSchema,
        required: true
    },
    label: {
        type: Schema.Types.String,
        required: true
    },
    participants: [{
        type: Schema.Types.ObjectId,
        ref: 'Guest'
    }],
    isObject: {
        type: Schema.Types.Boolean,
        required: true, 
        default: false
    }
})

export const Table = mongoose.model("table", TableSchema)