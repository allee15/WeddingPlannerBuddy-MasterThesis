import mongoose from "mongoose";

const Schema = mongoose.Schema;

const UserSchema = new Schema({
    userUID: {
        type: Schema.Types.String,
        required: true,
    }
})

export const User = mongoose.model("user", UserSchema)