import { v2 as cloudinary } from "cloudinary";

cloudinary.config({
  cloud_name: "daa80b8pt",
  api_key: "485139197932338",
  api_secret: "-dmUnBBsOTT2TD2SCcpj8byXGa4",
});

export function uploadImage(imageUploaded) {
  return new Promise((resolve, reject) => {
    cloudinary.uploader.upload(
      imageUploaded,
      { width: 470, height: 600, crop: "fit", quality: 70 },
      (err, res) => {
        if (err) reject(err);
        resolve(res);
      }
    );
  });
}

export function uploadProfilePhoto(imageUploaded) {
  return new Promise((resolve, reject) => {
    cloudinary.uploader.upload(
      imageUploaded,
      { width: 150, height: 150, crop: "fit", quality: 70 },
      (err, res) => {
        if (err) reject(err);
        resolve(res);
      }
    );
  });
}
