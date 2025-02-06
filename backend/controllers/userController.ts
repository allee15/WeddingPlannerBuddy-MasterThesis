import { Request, Response } from "express";
import { User } from "../models/User";
import * as admin from "firebase-admin";

export const getUser = async (req: Request, res: Response): Promise<any> => {
    const token = req.body.token;
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    try {
        const decodedToken = await admin.auth().verifyIdToken(token);
        const user = await User.findById(decodedToken.uid).select("userUID");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        return res.status(200).json(user);
        
    } catch (error) {
        console.log("Error in getUser controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
  };