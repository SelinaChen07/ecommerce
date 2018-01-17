//Image Slider

//Create slider class
const sliderFactory = (imgNum) => {
	
	var imgIdx = 0; //imgIdx from 0, 1, 2, ... imgNum-1 for all the images. The first onshow image in the slider is image0

	//show image with provided index, and also update current imgIdx. If index is not provided, show image with current imgIndx.
	const showImg = (idx) => {
		if(idx === undefined){
			idx = imgIdx;
		}
		imgIdx = idx;	
		$("#images_container").css("left", ""+imgIdx*-100+"%");
	};

	const updatePreviewButton = (idx) =>{
		if(idx === undefined){
			idx = imgIdx;
		}
		$(".preview_button").css('background-color','transparent');
		$(".preview_button:nth-child("+(idx+1)+')').css('background-color','black');
	};
	
	//Slide to the next image on the right
	const slideToNxt = function(){
		if($("#images_container").css("right") === "0px"){
			imgIdx = 0; //reset the position
		}else{
			imgIdx++;
		}
		showImg();
		updatePreviewButton();	
	};

	//Slide to the previous image on the left
	const slideToPre = function(){
		if($("#images_container").css("left") === "0px"){
			imgIdx = imgNum-1; //reset the position
		}else{
			imgIdx--;
		}
		showImg();
		updatePreviewButton();
	};

	//show the preview of the image with the provided index
	const showPreview = (idx)=>{
		$(".preview_button:nth-child("+(idx+1)+')').children().last().addClass("d-block");
	};

	//hide the preview of the image with the provided index
	const hidePreview = (idx)=>{
		$(".preview_button:nth-child("+(idx+1)+')').children().last().removeClass("d-block");
	};
    
    return { imgNum, slideToNxt, slideToPre, showImg, updatePreviewButton, showPreview, hidePreview};
}

//Only create slider object when there is slider in the page
$(document).ready(function(){

	if($("#slider").length){
		//Initialize slider
		var imgNum = $(".image_preview").length;
		var slider = sliderFactory(imgNum);
		
		//bundle slideToNxt event handler to next button
		$("#next_button").on('click',function(event){
			event.preventDefault();
			slider.slideToNxt();
			console.log(slider);
		});

		//bundle slideToPre event handler to previous button
		$("#pre_button").on('click',function(event){
			event.preventDefault();
			slider.slideToPre();
		});

		//adding slide suport to mobile device
		$("#slider").on('swiperight',slider.slideToPre);

		$("#slider").on('swipeleft', slider.slideToNxt);

		//bundle preview event to preview bar
		$('#preview_bar').on('click','.preview_button',function(event){
			event.preventDefault();
			var idx = $(event.target).index();
			slider.showImg(idx);
			slider.updatePreviewButton(idx);
		});

		//Show preview of the image when mouse hover on the preview button
		$('#preview_bar').on('mouseenter','.preview_button',function(event){
			var idx = $(event.target).index(); 
			slider.showPreview(idx);
		});
		$('#preview_bar').on('mouseleave','.preview_button',function(event){
			var idx = $(event.target).index(); 
			slider.hidePreview(idx);
		});

	}
});