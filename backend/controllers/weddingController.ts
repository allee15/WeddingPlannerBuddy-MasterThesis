import { Request, Response } from "express";
import { User } from "../models/User";
import {WeddingDetails} from "../models/WeddingDetails";

export const startWedding = async (req: Request, res: Response): Promise<any> => {
    try {
        const { userUID } = req.body;
        const user = await User.findOne({ userUID: userUID });

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        user.hasActiveWedding = true;
        await user.save();
        await WeddingDetails.create({ weddingDetailsUUID: user._id });
        return res.status(200).json({ success: true });
    } catch (error) {
        console.log("Error in startWedding controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
};