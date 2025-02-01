import mongoose from "mongoose"

export const createDatabaseConnection = async () => {
    await mongoose.connect(process.env.ATLAS_URI ?? process.env.MONGODB_URI as string, {
        autoIndex: true
    });
}