import { Request, Response } from "express";
import { Table } from "../models/Table";
import { User } from "../models/User";
import { Guest } from "../models/Guest";

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

        if (!tableUID || !userUID ) {
            return res.status(400).json({ error: "Missing required fields" });
        }

        const newGuest = new Guest({
            guestUUID,
            tableUID,
            name,
            email
        })

        await newGuest.save();

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

        return res.status(200).json({ success: true, user });
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
