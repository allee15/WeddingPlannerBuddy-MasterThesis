import { Double } from "mongodb";
import mongoose from "mongoose";

const Schema = mongoose.Schema;

const tableSchema = new Schema({
    tableUID: {
        type: Schema.Types.String,
        required: true
    },
    position: {
        type: {
            x: { type: Double, required: true },
            y: { type: Double, required: true }  
        },
        required: true,
        default: { x: 0.0, y: 0.0 }
    },
    label: {
        type: Schema.Types.String,
        required: true,
        default: ""
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

export const Table = mongoose.model("Table", tableSchema)