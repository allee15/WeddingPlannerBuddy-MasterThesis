import { Request, Response } from "express";
import { User } from "../models/User";
import { Wedding } from "../models/Wedding";
import { WeddingGuest } from "../models/WeddingGuest";

export const getUser = async (req: Request, res: Response): Promise<any> => {
    const token = req.header("authorization")?.split(" ")[1];
    
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    try {
        Wedding.exists({});
        WeddingGuest.exists({});
        const user = await User.find({ userUID: token })
        .populate("tablesAtWedding")
        .populate({
        path: "otherWeddings",
        populate: {
            path: "weddingUUID"
        }
        })
        .populate("guests")
        .populate("weddings");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        return res.status(200).json(user);
        
    } catch (error) {
        console.log("Error in getUser controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
};

export const registerUser = async (req: Request, res: Response): Promise<any> => {
    const {email, token} = req.body;
    try {
        const user = await User.create({ 
            email: email, 
            userUID: token, 
            tablesAtWedding: [], 
            guests: [],
            otherWeddings: [],
            weddings: [] });
        return res.status(201).json({success: true });
    } catch (error) {
        console.log("Error in registerUser controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
};