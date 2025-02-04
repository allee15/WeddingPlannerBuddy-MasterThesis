import mongoose from "mongoose";

const Schema = mongoose.Schema;

const SongSchema = new Schema({
    songUUId: {
        type: Schema.Types.String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    artist: {
        type: String,
        required: true
    },
    url: {
        type: URL,
        required: true
    }
})

export const Song = mongoose.model("song", SongSchema)