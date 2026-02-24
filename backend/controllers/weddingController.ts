import { Request, Response } from "express";
import { User } from "../models/User";
import {BarMenu, Bouquet, ChurchCeremony, CivilMarriage, FoodMenu, GroomSuit, LiveBand, PartyLocation, WeddingCake, WeddingDetails, WeddingDress} from "../models/WeddingDetails";
import { Wedding } from "../models/Wedding";
import { put } from "@vercel/blob";
import { WeddingGuest } from "../models/WeddingGuest";

interface MulterRequest extends Request {
    file?: Express.Multer.File;
}

export const startWedding = async (req: Request, res: Response): Promise<any> => {
    try {
        const { userUID, date } = req.body;
        const user = await User.findOne({ userUID: userUID });

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        user.hasActiveWedding = true;
        await user.save();

        const weddingDress = await WeddingDress.create({ weddingDressUUID: user._id });
        const bouquet = await Bouquet.create({ bouquetUUID: user._id });
        const groomSuit = await GroomSuit.create({ groomSuitUUID: user._id });
        const churchCeremony = await ChurchCeremony.create({ churchCeremonyUUID: user._id });
        const partyLocation = await PartyLocation.create({ partyLocationUUID: user._id });
        const civilMarriage = await CivilMarriage.create({ civilMarriageUUID: user._id });
        const foodMenu = await FoodMenu.create({ foodMenuUUID: user._id });
        const barMenu = await BarMenu.create({ barMenuUUID: user._id });
        const weddingCake = await WeddingCake.create({ weddingCakeUUID: user._id });
        const liveBand = await LiveBand.create({ liveBandUUID: user._id });

        const weddingDetails = await WeddingDetails.create({
            weddingDetailsUUID: user._id,
            date: date, 
            weddingDress: weddingDress._id,
            bouquet: bouquet._id,
            groomSuit: groomSuit._id,
            churchCeremony: churchCeremony._id,
            partyLocation: partyLocation._id,
            civilMarriage: civilMarriage._id,
            foodMenu: foodMenu._id,
            barMenu: barMenu._id,
            weddingCake: weddingCake._id,
            liveBand: liveBand._id
        });

        return res.status(200).json({ success: true });
    } catch (error) {
        console.log("Error in startWedding controller", error);
        return res.status(500).json({ error: "Internal Server Error" })
    }
};

export const getWeddingDetails = async (req: Request, res: Response): Promise<any> => {
    try {
        const token = req.header("authorization")?.split(" ")[1];

        if (!token) {
            return res.status(401).send("Unauthorized");
        }

        const user = await User.findOne({ userUID: token });

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        const weddingDetails = await WeddingDetails.findOne({ weddingDetailsUUID: user._id })
            .populate("weddingDress")
            .populate("bouquet")
            .populate("groomSuit")
            .populate("churchCeremony")
            .populate("partyLocation")
            .populate("civilMarriage")
            .populate("barMenu")
            .populate("foodMenu")
            .populate("weddingCake")
            .populate("liveBand");

        if (!weddingDetails) {
            return res.status(404).json({ error: "Wedding details not found" });
        }

        return res.status(200).json({ weddingDetails });
    } catch (error) {
        console.log("Error in getWeddingDetails controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateWeddingDate = async (req: Request, res: Response): Promise<any> => {
    try {
        const { date, weddingId } = req.body;
        const weddingDetails = await WeddingDetails.findOne({ weddingDetailsUUID: weddingId });

        if (!weddingDetails) {
            return res.status(404).json({ error: "Wedding not found" });
        }

        weddingDetails.date = date;
        await weddingDetails.save();

        const wedding = await Wedding.findOne({ weddingUUID: weddingId });
        if (wedding) {
            wedding.date = date;
            await wedding.save();
        }

        await WeddingGuest.updateMany(
            { weddingUUID: wedding?._id },
            {
                $set: {
                    date: date,
                    location: wedding?.location
                }
            }
        );

        return res.status(200).json({ success: true });
    } catch (error) {
        console.log("Error in updateWeddingDate controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateWeddingDress = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { weddingDressUUID, link, price, description } = req.body;

        const weddingDress = await WeddingDress.findOne({ weddingDressUUID: weddingDressUUID });

        if (!weddingDress) {
            return res.status(404).json({ error: "Wedding dress not found" });
        }

        weddingDress.link = link;
        weddingDress.price = price;
        weddingDress.description = description;
        let imageUrl: string | undefined;

if (req.file) {
  const blob = await put(
    `wedding-dress/${Date.now()}-${req.file.originalname}`,
    req.file.buffer,
    {
      access: "public",
      contentType: req.file.mimetype,
    }
  );

  imageUrl = blob.url;
}

if (imageUrl) {
    weddingDress.photo = imageUrl;
  }

        await weddingDress.save();
        return res.status(200).json({ weddingDress });
    } catch (error) {
        console.log("Error in updateWeddingDress controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateBouquet = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { bouquetUUID, link, price, description } = req.body;
        const imagePath = req.file?.path;

        const bouquet = await Bouquet.findOne({ bouquetUUID: bouquetUUID });

        if (!bouquet) {
            return res.status(404).json({ error: "Bouquet not found" });
        }

        bouquet.link = link;
        bouquet.price = price;
        bouquet.description = description;

        if (imagePath) {
            bouquet.photo = imagePath;
        }

        await bouquet.save();

        return res.status(200).json({ bouquet });
    } catch (error) {
        console.log("Error in updateBouquet controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateGroomSuit = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { groomSuitUUID, link, price, description } = req.body;
        const imagePath = req.file?.path;

        const groomSuit = await GroomSuit.findOne({ groomSuitUUID: groomSuitUUID });

        if (!groomSuit) {
            return res.status(404).json({ error: "Groom suit not found" });
        }

        groomSuit.link = link;
        groomSuit.price = price;
        groomSuit.description = description;

        if (imagePath) {
            groomSuit.photo = imagePath;
        }

        await groomSuit.save();

        return res.status(200).json({ groomSuit });
    } catch (error) {
        console.log("Error in updateGroomSuit controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateChurchCeremony = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { churchCeremonyUUID, churchAddress, date, hour, preotName, price } = req.body;

        const churchCeremony = await ChurchCeremony.findOne({ churchCeremonyUUID: churchCeremonyUUID });

        if (!churchCeremony) {
            return res.status(404).json({ error: "Church ceremony not found" });
        }

        churchCeremony.churchAddress = churchAddress;
        churchCeremony.date = date;
        churchCeremony.hour = hour;
        churchCeremony.preotName = preotName;
        churchCeremony.price = price;
        await churchCeremony.save();
        
        return res.status(200).json({ churchCeremony });
    } catch (error) {
        console.log("Error in updateChurchCeremony controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updatePartyLocation = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { partyLocationUUID, partyAddress, date, hour, decorationsOrganizerDetails, price } = req.body;

        const partyLocation = await PartyLocation.findOne({ partyLocationUUID: partyLocationUUID });

        if (!partyLocation) {
            return res.status(404).json({ error: "Party location not found" });
        }

        partyLocation.partyAddress = partyAddress;
        partyLocation.date = date;
        partyLocation.hour = hour;
        partyLocation.decorationsOrganizerDetails = decorationsOrganizerDetails;
        partyLocation.price = price;
        await partyLocation.save();

        const weddingDetails = await WeddingDetails.findOne({
            partyLocation: partyLocation._id
        });

        if (!weddingDetails) {
            return res.status(404).json({ error: "WeddingDetails not found" });
        }

        const wedding = await Wedding.findOne({ weddingUUID: weddingDetails.weddingDetailsUUID });

        if (wedding) {
            wedding.location = partyAddress;
            wedding.date = weddingDetails.date; 
            await wedding.save();

            await WeddingGuest.updateMany(
                { weddingUUID: wedding._id },
                {
                    $set: {
                        location: partyAddress,
                        date: wedding.date
                    }
                }
            );
        }

        return res.status(200).json({ partyLocation });
    } catch (error) {
        console.log("Error in updatePartyLocation controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateCivilMarriage = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { civilMarriageUUID, address, date, hour } = req.body;

        const civilMarriage = await CivilMarriage.findOne({ civilMarriageUUID: civilMarriageUUID });

        if (!civilMarriage) {
            return res.status(404).json({ error: "Civil marriage not found" });
        }

        civilMarriage.address = address;
        civilMarriage.date = date;
        civilMarriage.hour = hour;
        await civilMarriage.save();
        
        return res.status(200).json({ civilMarriage });
    } catch(error) {
        console.log("Error in updateCivilMarriage controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateFoodMenu = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { foodMenuUUID, antreu, firstCourse, mainCourse, secondMainCourse, price } = req.body;

        const foodMenu = await FoodMenu.findOne({ foodMenuUUID: foodMenuUUID });

        if (!foodMenu) {
            return res.status(404).json({ error: "Food menu not found" });
        }

        foodMenu.antreu = antreu;
        foodMenu.firstCourse = firstCourse;
        foodMenu.mainCourse = mainCourse;
        foodMenu.secondMainCourse = secondMainCourse;
        foodMenu.price = price;
        await foodMenu.save();

        return res.status(200).json({ foodMenu });
    } catch (error) {
        console.log("Error in updateFoodMenu controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateBarMenu = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { barMenuUUID, alcoholic, nonalcoholic, coffee, juice, price } = req.body;

        const barMenu = await BarMenu.findOne({ barMenuUUID: barMenuUUID });

        if (!barMenu) {
            return res.status(404).json({ error: "Bar menu not found" });
        }

        barMenu.alcoholic = alcoholic;
        barMenu.nonalcoholic = nonalcoholic;
        barMenu.coffee = coffee;
        barMenu.juice = juice;
        barMenu.price = price;
        await barMenu.save();

        return res.status(200).json({ barMenu });
    } catch (error) {
        console.log("Error in updateBarMenu controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateWeddingCake = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { weddingCakeUUID, name, description, price } = req.body;
        const imagePath = req.file?.path;

        const weddingCake = await WeddingCake.findOne({ weddingCakeUUID: weddingCakeUUID });

        if (!weddingCake) {
            return res.status(404).json({ error: "Wedding cake not found" });
        }

        weddingCake.name = name;
        weddingCake.description = description;
        weddingCake.price = price;

        if (imagePath) {
            weddingCake.photo = imagePath;
        }

        await weddingCake.save();
       
        return res.status(200).json({ weddingCake });
    } catch (error) {
        console.log("Error in updateWeddingCake controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

export const updateLiveBand = async (req: Request, res: Response): Promise<any> => {
    try {
        const { id } = req.params;
        const { liveBandUUID, name, price, hour, details } = req.body;

        const liveBand = await LiveBand.findOne({ liveBandUUID: liveBandUUID });

        if (!liveBand) {
            return res.status(404).json({ error: "Live band not found" });
        }

        liveBand.name = name;
        liveBand.price = price;
        liveBand.hour = hour;
        liveBand.details = details;
        await liveBand.save();
       
        return res.status(200).json({ liveBand });
    } catch (error) {
        console.log("Error in updateLiveBand controller", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }

};

export const addImageToWedding = async (req: Request, res: Response): Promise<any> => {
    try {
      const { weddingUUID, name, date, location, images } = req.body;
  
      const wedding = await Wedding.findOne({ weddingUUID });
      if (!wedding) {
        return res.status(404).json({ success: false, message: "Wedding not found" });
      }
  
      wedding.name = name;
      wedding.date = date;
      wedding.location = location;
  
      let newImages: string[] = [];
      if (images) {
          if (typeof images === 'string') {
              newImages = JSON.parse(images);
          } else if (Array.isArray(images)) {
              newImages = images;
          }
      }
  
      let imageUrl: string | undefined;

    if (req.file) {
    const blob = await put(
        `weddings/${Date.now()}-${req.file.originalname}`,
        req.file.buffer,
        {
        access: "public",
        contentType: req.file.mimetype,
        }
    );

    imageUrl = blob.url;
    }

    if (imageUrl) {
    newImages.push(imageUrl);
    }
  
      wedding.images = Array.from(new Set([...wedding.images, ...newImages]));
  
      await wedding.save();
  
      res.json({ success: true, wedding });
    } catch (err) {
      console.error(err);
      res.status(500).json({ success: false, message: "Server error" });
    }
  };  
  
