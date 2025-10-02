import { Request, Response } from "express";
import { Table } from "../models/Table";
import { User } from "../models/User";
import { Guest } from "../models/Guest";
import { WeddingGuest } from "../models/WeddingGuest";
import * as admin from "firebase-admin";
import crypto from "crypto";

function generateRandomPassword(length = 10) {
    return crypto.randomBytes(length).toString("hex").slice(0, length);
}  

export const addTable = async (req: Request, res: Response): Promise<any> => {
    try {
        const { userUID, tableUID, position, label, participants, isObject} = req.body;

        if (!tableUID || !position || !label) {
            return res.status(400).json({ error: "Missing required fields" });
        }

        const newTable = new Table({
            tableUID,
            position,
            label,
            participants,
            isObject
        });

        await newTable.save();

        const user = await User.findOneAndUpdate(
            { userUID },
            { $push: { tablesAtWedding: newTable._id } },
            { new: true }
        ).populate("tablesAtWedding");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        return res.status(200).json({ success: true, user });
    } catch(error) {
        console.log("Error in addTable controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
}

export const addRectangle = async (req: Request, res: Response): Promise<any> => {
    try {
        const { userUID, tableUID, position, label, participants, isObject} = req.body;

        if (!tableUID || !position || !label) {
            return res.status(400).json({ error: "Missing required fields" });
        }

        const newTable = new Table({
            tableUID,
            position,
            label,
            participants,
            isObject
        });

        await newTable.save();

        const user = await User.findOneAndUpdate(
            { userUID },
            { $push: { tablesAtWedding: newTable._id } },
            { new: true }
        ).populate("tablesAtWedding");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        return res.status(200).json({ success: true, user });
    } catch(error) {
        console.log("Error in addRectangle controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
}

export const addParticipant = async (req: Request, res: Response): Promise<any> => {
    try {
        const { guestUUID, userUID, tableUID, name, email } = req.body;

        if (!tableUID || !userUID || !email) {
            return res.status(400).json({ error: "Missing required fields" });
        }

        const organizer = await User.findOne({ userUID }).populate("weddings");
        if (!organizer || organizer.weddings.length === 0) {
            return res.status(404).json({ error: "Organizer or wedding not found" });
        }

        const weddingId = organizer.weddings[0]._id;

        const password = generateRandomPassword();

        const firebaseUser = await admin.auth().createUser({
            email,
            password,
            displayName: name,
        });

        const newUser = new User({
            userUID: firebaseUser.uid,
            email,
            hasActiveWedding: false,
        });

        await newUser.save();

        const newGuest = new Guest({
            guestUUID,
            tableUID,
            name,
            email,
            user: newUser._id,
        })

        await newGuest.save();

        const weddingGuest = new WeddingGuest({
            weddingGuestUID: guestUUID,
            tableNb: 1,
            location: "Restaurant X",
            date: new Date().toISOString(),
            weddingUUID: weddingId
        });
        await weddingGuest.save();

        await User.findByIdAndUpdate(newUser._id, {
            $push: { otherWeddings: weddingGuest._id }
        });

        const table = await Table.findOneAndUpdate(
            { tableUID },
            { $push: { participants: newGuest._id } },
            { new: true }
        ).populate("participants");

        if (!table) {
            return res.status(404).json({ error: "Table not found" });
        }

        const user = await User.findOneAndUpdate(
            { userUID },
            { $push: { guests: newGuest._id } },
            { new: true }
        ).populate("guests tablesAtWedding");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        return res.status(200).json({ success: true, email, password, guestUUID });
    } catch(error) {
        console.log("Error in addParticipant controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
}

export const updateTablePosition = async (req: Request, res: Response): Promise<any> => {
    try {
        const { userUID, tableUID, position } = req.body;

        if (!userUID || !tableUID || !position || typeof position.x !== 'number' || typeof position.y !== 'number') {
            return res.status(400).json({ error: "Missing or invalid required fields" });
        }

        const table = await Table.findOneAndUpdate(
            { tableUID },
            { $set: { position } },
            { new: true }
        );

        if (!table) {
            return res.status(404).json({ error: "Table not found" });
        }

        return res.status(200).json({ success: true, table });
    } catch (error) {
        console.log("Error in updateTablePosition controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};
