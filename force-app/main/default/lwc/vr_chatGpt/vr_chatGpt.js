import { LightningElement } from 'lwc';

//apex
import chatGptImages from '@salesforce/apex/VR_ChatGptController.getImages'; 

//jsUtil
import { parseJSON } from 'c/vr_jsUtils';

export default class Vr_chatGpt extends LightningElement {

    returnedImages = [];
    showSpinner = false;
    
    get searchedImages() {
        if (this.returnedImages && this.returnedImages.length > 0) {
            console.log('searchedImages::',this.returnedImages );//TODO: Remove after Dev    
        }
        return this.returnedImages;
    }

    get imagesReturned() {
        return (this.returnedImages && this.returnedImages.length > 0)? true : false;
    }


    errorCallback(error, stack) {
        console.log('Vr_chatGpt::Error:', error, ' stack::',stack);//TODO: Remove after Dev
    }

    handleSubmit(event) {
            this.showSpinner = true;
            event.preventDefault();
            let prompt = this.template.querySelector('[data-id="prompt"]').value;
            console.log('Vr_chatGpt::handleSubmit', prompt);//TODO: Remove after Dev
            chatGptImages({
                imageQueryString: prompt,
                numberOfImages: 3,
                imageSize: '1024x1024'
            }).then(result => {
                console.log('handleSubmit::result', result);//TODO: Remove after Dev
                if (result?.success && result?.imageResponse) {
                    this.showSpinner = false;
                    console.log('handleSubmit::images', result.imageResponse.data);//TODO: Remove after Dev
                    this.returnedImages = parseJSON(this.returnedImages);
                    this.returnedImages = result.imageResponse.data;
                    console.log('handleSubmit::returnedImages', this.returnedImages);//TODO: Remove after Dev
                } else {
                    this.showSpinner = false;
                    console.log('handleSubmit::result', result);//TODO: Remove after Dev
                }
            }).catch(error => {
                console.log('Error::', error);//TODO: Remove after Dev
            }) ;
    }
}