import { Request, Response, NextFunction } from "express";
import { User } from "../models/User";

export const addUser = async (req: Request, res: Response, next: NextFunction) => {
    // logic for adding user
    // User.create({
    //     userUID: req.body.userUID
    // }).then(response => {
    //     res.send('User created')
    // }).catch(err => {
    //     res.status(404).send(err);
    // })
    res.send(await User.find({}))
}