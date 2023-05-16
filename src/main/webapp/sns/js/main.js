 		function goURL(url, gid) {
			document.frm1.action=url;
			document.frm1.gid.value=gid;
			document.frm1.submit();
		}
 		function heart(emailpostid){//햇음 하트누르면 하트올라가기
 			const sentence=emailpostid;
 			const [postId,userEmail]=sentence.split(",");
			$.ajax({
			    url: "PostHeartCntServlet", 
			    type: "POST",
			    dataType: "json",
			    data: { postId: postId,
			    		userEmail:userEmail
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
 		}
 		function heartdel(emailpostid){
 			const sentence=emailpostid;
 			const [postId,userEmail]=sentence.split(",");
			$.ajax({
			    url: "PostHeartdeleteServlet", 
			    type: "POST",
			    dataType: "json",
			    data: { postId: postId,
			    		userEmail:userEmail
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
 		}
 		function cdel(postemail){//햇음 코멘트삭제
			const sentence=postemail;
 			const [commentId,postId]=sentence.split(",");
 			$.ajax({
			    url: "cdel", 
			    type: "POST",
			    dataType: "json",
			    data: { commentId: commentId,
			    		postId:postId
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
		}
 		//수정
 		var isInputBoxAdded = false;
 		function cup(commentId) {
 		  const parentElement = document.getElementById("box"+commentId);
 		  if (!isInputBoxAdded) {
 		    const inputBox = document.createElement('input');
 		    inputBox.type = 'text';
 		   	inputBox.style.borderRadius = '30px';
 		   	inputBox.style.width='120px';
 		    const deleteButton = document.createElement('input');
 		    deleteButton.type = 'button';
 		    deleteButton.value = '취소';
 		    deleteButton.style.border='1px solid skyblue';
 		    deleteButton.style.backgroundColor='rgba(0,0,0,0)';
 		   	deleteButton.style.color='skyblue';
 		   	deleteButton.style.borderRadius='5px';
 		   	deleteButton.addEventListener('mouseover', function() {
 		   		deleteButton.style.color = 'white';
 		   		deleteButton.style.backgroundColor = 'skyblue';
		  	});
 		   	deleteButton.addEventListener('mouseout', function() {
		   		deleteButton.style.color = 'skyblue';
		   		deleteButton.style.backgroundColor = 'rgba(0,0,0,0)';
		  	});
 		    deleteButton.onclick = function() {
 		    	parentElement.innerHTML = "수정"; 
 		      	isInputBoxAdded = true;
 		      	location.reload();
 		    };
 		    const saveButton = document.createElement('input');
 		    saveButton.type = 'button';
 		    saveButton.value = '저장';
 		    saveButton.style.border='1px solid skyblue';
 		    saveButton.style.backgroundColor='rgba(0,0,0,0)';
 		    saveButton.style.color='skyblue';
 		   	saveButton.style.borderRadius='5px';
 		   	saveButton.addEventListener('mouseover', function() {
 		   		saveButton.style.color = 'white';
 		   		saveButton.style.backgroundColor = 'skyblue';
		  	});
 		 	saveButton.addEventListener('mouseout', function() {
 		 		saveButton.style.color = 'skyblue';
 		 		saveButton.style.backgroundColor = 'rgba(0,0,0,0)';
		  	});
 		    saveButton.onclick = function() {
 		    	var updatedComment = inputBox.value;
 		      	$.ajax({
 		        	url: 'CommentUpdate',
 		        	type: 'POST',
 		        	data: { commentId: commentId, commentDetail: updatedComment },
 		        	success: function(result) {
 		        	console.log('댓글수정완료');
 		 			location.reload();
 		        },
 		        error: function(xhr, status, error) {
 		        }
 		      });
 		    };
 		   	parentElement.innerHTML = '';
 		    parentElement.appendChild(inputBox);
 		    parentElement.appendChild(saveButton);
 		    parentElement.appendChild(deleteButton);
 		    isInputBoxAdded = true;
 		  }
 		}

 		
 		function hamberger(userEmail){//햄버거 모달 스크립트 완료
			const modal = document.querySelector('.modal');
		    const hams = document.querySelectorAll('.ham');
		    const cancelBtn = document.querySelector('.modal_close');
		    for(var i=0; i<hams.length; i++){
		    hams[i].addEventListener('click', () => {
		    	modal.style.display = 'block';
		    	});
		    }
		    cancelBtn.addEventListener('click', () => {
		        modal.style.display = 'none';
		    });
		}
 		function share(postId){//공유하기모달 반쯤완료
 			const modal = document.querySelector('.modal');
 			const sharebtns=document.querySelectorAll('.sharebtn');
 			const sharecancel=document.querySelector('.sharecancel');
 			const sharemodal=document.querySelector('.sharemodal');
 			for (var i = 0; i <sharebtns.length ; i++) {
 			sharebtns[i].addEventListener('click', () => {
 				sharemodal.style.display='block';
 			 	modal.style.display = 'none';
 			
 			    const currentURL = encodeURIComponent(window.location.href);
 			    const naverShareLink = document.querySelector('.naver-share-link');
 			    naverShareLink.href = 'http://share.naver.com/web/shareView.nhn?url=' + currentURL + '&title=' + encodeURIComponent(document.title);
 			});
			}
 			sharecancel.addEventListener('click', () => {
 				sharemodal.style.display='none';
 			});
		}
 		//카카오공유
 		function postShareKakao() {

 			Kakao.init("22e95823c2f2830c0d276cb7b53d5dad");
 	        Kakao.Link.sendCustom({
 	            templateId: 93282
 	        });
 		}
 		function dofriend(email){//팔로우
 			const sentence=email;
 			const [friendEmail,userEmail]=sentence.split(",");
 			
			const followBtns = document.querySelectorAll(".follow-btn");
			$.ajax({
				    url: "FollowServlet", 
				    type: "POST",
				    data: { friendEmail: friendEmail,
				    		userEmail:userEmail
				    },
				    success: function(result) {
				    	console.log("팔로우신청");
				    	location.reload();
				        },
				    error: function(xhr, status, error) {
				    }
				  });
 		}
 		function friendtext(email){
 			var formData = new FormData();
 			$.ajax({
 				type : "get",
 				url : "reply?boardIdx=${boardInfo.boardIdx}&writer=${boardInfo.userIdx}",
 					dataType : "text",
 					data : formData, 
 					contentType: false, 
 					processData: false, 
 					cache : false,
 					success : function(data) {
 		           		 // C에서 받아온 데이터로 새로 뿌려주기
 						var html = jQuery('<div>').html(data);
 						var contents1 = html.find("div#replyList").html();
 						var contents2 = html.find("div#replyCount").html();
 						$("#replyList").html(contents1);
 						$("#replyCount").html(contents2);
 					},
 					error : function(){
 		                alert("통신실패");
 		            }
 				});
 		}
 		function deletefriend(email){
 			const sentence=email;
 			const [friendEmail,userEmail]=sentence.split(",");
			const followdelbtns = document.querySelectorAll(".followdelbtn");
			$.ajax({
				    url: "DelFollowServlet", 
				    type: "POST",
				    data: { friendEmail: friendEmail,
				    		userEmail:userEmail
				    },
				    success: function(result) {
				    	console.log("팔로우헤제");
				    	location.reload();
				    },
				    error: function(xhr, status, error) {
				    }
			});
 		}
 		
 		var nowUrl = window.location.href;//링크 url따오기 완료
 		function copyUrl(){
 			const modal = document.querySelector('.modal');
 			navigator.clipboard.writeText(nowUrl).then(res=>{
 				  alert("주소가 복사되었습니다!");
 				  modal.style.display='none';
 				})
 		}
 		function report(postId){//신고하기 버튼 누르면 report 숫자올라가기 완료
 			const modal = document.querySelector('.modal');
 			  $.ajax({
 				    url: "postReport", 
 				    type: "POST",
 				    data: { postId: postId },
 				    success: function(result) {
 				    	modal.style.display = 'none';
 				    },
 				    error: function(xhr, status, error) {
 				    }
 				  });
 		}
 		//댓글달기
 		document.addEventListener('DOMContentLoaded', function() {
  		var inputs = document.querySelectorAll('.postTextbox');
  
  		inputs.forEach(function(input) {
    		var postId = input.dataset.postid;
    		var userEmail = '';
    
    		if (input.hasAttribute('data-userEmail')) {
    			userEmail = input.getAttribute('data-userEmail');
    		}
    
    		input.addEventListener('keydown', function(event) {
      			if (event.key === 'Enter') {
        			addComment(postId, userEmail, input.value);
      			}
    		});
  		});
		});

		function addComment(postId, userEmail, commentDetail) {
  		$.ajax({
    		url: "commentAdd",
    		type: "POST",
    		data: {
      		postId: postId,
      		commentDetail: commentDetail,
      		userEmail: userEmail
    	},
    		success: function(result) {
      		var inputs = document.querySelectorAll('.postTextbox');
      		inputs.forEach(function(input) {
        		input.value = "";
      		});
      		location.reload();
    		},
    		error: function(xhr, status, error) {
      		console.error("Error:", error);
    		}
  		});
		}
		//답글
		var isReplyBoxAdded = false;
 		function creply(idemail) {
 			const sentence=idemail;
 			const [commentParrent,userEmail,postId,commentId]=sentence.split(",");
 		  	const parentElement = document.getElementById("rep"+commentId);
 		  	if (!isReplyBoxAdded) {
 		    	const replyBox = document.createElement('input');
 		   		replyBox.type = 'text';
 		   		replyBox.style.borderRadius = '10px';
 		   		replyBox.style.border = 'none';
 		   		replyBox.style.backgroundColor = '#f8f8f8';
 		   		replyBox.style.fontSize = '12px';
 		   		replyBox.style.padding = '2px';
 		   		replyBox.style.width='120px';
 		   		replyBox.onclick = function(event) {
 		       		event.stopPropagation();
 		     	};
 		    	const replydelete = document.createElement('input');
 		   		replydelete.type = 'button';
 		  		replydelete.value = '취소';
 		  		replydelete.style.backgroundColor='rgba(0,0,0,0)';
 		  		replydelete.style.color='#8e8e8e';
 		  		replydelete.style.cursor='pointer';
 		  		replydelete.style.textDecorationLine='underline';
 		  		replydelete.style.border='none';
 		  	    
 		  	    
 	
 		  		
 		 		replydelete.onclick = function() {
 		    		parentElement.innerHTML = "답글"; 
 		    		isReplyBoxAdded = true;
 		    		location.reload();
 		    	};
 		    	const replysave = document.createElement('input');
 		   		replysave.type = 'button';
 		  		replysave.value = '저장';
 		  		replysave.style.backgroundColor='rgba(0,0,0,0)';
 		  		replysave.style.color='#8e8e8e';
 		  		replysave.style.cursor='pointer';
 		  		replysave.style.textDecorationLine='underline';
 		  		replysave.style.border='none';
    
 		 		replysave.onclick = function() {
 		    		var replyDetail = replyBox.value;
 		      		$.ajax({
 		        		url: 'CommentReply',
 		        		type: 'POST',
 		        		data: { 
 		        			commentParrent: commentParrent, 
 		        			commentDetail: replyDetail,
 		        			userEmail: userEmail,
 		        			postId: postId,
 		        			commentId: commentId
 		        			},
 		        		success: function(result) {
 		        		console.log('답글완료');
 		 				location.reload();
 		        	},
 		        	error: function(xhr, status, error) {
 		        	}
 		      	});
 		   	 };
 		   		parentElement.innerHTML = '';
 		    	parentElement.appendChild(replyBox);
 		    	parentElement.appendChild(replysave);
 		   	 	parentElement.appendChild(replydelete);
 		   	 	isInputBoxAdded = true;
 		   		replyBox.focus();
 		  		}
 			}
		
			
 		//만들기버튼 기능들
 		const makePostButton = document.querySelector('#make-post');
 		const overlay = document.querySelector('.overlay');
		const makemodal=document.querySelector('.makemodal');
		const makecancel=document.querySelector('.makecancel');
		const imageposition3=document.querySelector('.imageposition3');
		const imageposition4=document.querySelector('.imageposition4');
		const fixmodal=document.querySelector('.fixmodal');//사진모달
		const videomodal = document.querySelector('.videomodal');//동영상모달
		const makeBackBtn=document.querySelector('.makeBackBtn');//사진뒤로가기
		const makevideoBackBtn=document.querySelector('.makevideoBackBtn');//동영상뒤로가기
		const makepostInsert=document.querySelector('.makepostInsert');//사진완료
		const videopostInsert=document.querySelector('.videopostInsert');//영상완료
		const postcomplete=document.querySelector('.postcomplete');
		const makepostCheck=document.querySelector('.makepostCheck');

	    // 크롭 기능
	    let result = document.querySelector('.result'),
	    img_result = document.querySelector('.choicepicture'),
		img_w = document.querySelector('.img-w'),
		img_h = document.querySelector('.img-h'),
		options = document.querySelector('.options'),
		save = document.querySelector('.save'),
		cropped = document.querySelector('.cropped'),
		dwn = document.querySelector('.download'),
		upload = document.querySelector('.imageInput'),
		cropper = '';
			
		// 파일 업로드 버튼 클릭후 파일 넣을시 이벤트 발생
		$(".imageInput").change(function(){        	
         	if ($(".makePostImage").css("display") == "none" && $(".filebox").css("display") == "none") { 
				$(".makePostImage").show(); // display 속성을 block 으로 바꾼다.
			    $(".filebox").show(); // display 속성을 none 으로 바꾼다. 
				$(".makepostBefore").hide(); // display 속성을 none 으로 바꾼다. 
				$(".makepostAfter").hide(); // display 속성을 none 으로 바꾼다. 
				$(".choicepicture").hide(); // display 속성을 none 으로 바꾼다. 
				$(".choiceafterpicture").hide(); // display 속성을 none 으로 바꾼다. 
				$(".box").hide(); // display 속성을 none 으로 바꾼다. 
				$(".makepostInsert").hide(); // display 속성을 none 으로 바꾼다.				 				 			 				  
			} else{
				$(".makePostImage").hide(); // display 속성을 block 으로 바꾼다.
			    $(".filebox").hide(); // display 속성을 none 으로 바꾼다. 
				$(".makepostBefore").show(); // display 속성을 none 으로 바꾼다. 
				$(".makepostAfter").show(); // display 속성을 none 으로 바꾼다. 
				$(".choicepicture").show(); // display 속성을 none 으로 바꾼다. 
				$(".choiceafterpicture").show(); // display 속성을 none 으로 바꾼다. 
				$(".box").show(); // display 속성을 none 으로 바꾼다. 
				$(".makepostInsert").show(); // display 속성을 none 으로 바꾼다.				
			}

 		});	
			
		// on change show image with crop options
		upload.addEventListener('change', e => {
			if (e.target.files.length) {
			   // start file reader
			   const reader = new FileReader();
			   reader.onload = e => {
			   		if (e.target.result) {
				   		// create new image
			       		let img = document.createElement('img');
			       		img.id = 'image';
			       		img.src = e.target.result;
			      		 // clean result before
			      		 result.innerHTML = '';
			      		 // append new image
			      		 result.appendChild(img);
			      		 // show save btn and options
			      		 save.classList.remove('hide');
			      		 options.classList.remove('hide');
			      		 // init cropper
			      		 cropper = new Cropper(img);
			   		}
				};
				reader.readAsDataURL(e.target.files[0]);
			}
		});
			
		// save on click
		save.addEventListener('click', e => {
			e.preventDefault();
			// get result to data uri			  			  
			let imgSrc = cropper.getCroppedCanvas({
				width: img_w.value // input value
			}).toDataURL();
			// remove hide class of img
			cropped.classList.remove('hide');
			img_result.classList.remove('hide');
			// show image cropped
			cropped.src = imgSrc;
		}); 		
		
										
 		makePostButton.addEventListener('click', () => {
 			overlay.classList.toggle('active');
 		 	overlay.style.display='block';
 		  	makemodal.style.display='block';
 		  	$(".makeimage").attr("src", "./images/mainMakePostTrue.svg");
 		});
 		makecancel.addEventListener('click', ()=>{
 			overlay.classList.toggle('active');
 			overlay.style.display = 'none';
 			makemodal.style.display='none';
 			$(".makeimage").attr("src", "./images/mainMakePostFalse.png");
 		});
 		imageposition3.addEventListener('click', ()=>{
 			makemodal.style.display = 'none';
 			fixmodal.style.display = 'block';
 		});
 		imageposition4.addEventListener('click', ()=>{
 			makemodal.style.display='none';
 			videomodal.style.display='block';
 		});
 		makeBackBtn.addEventListener('click', ()=>{
 			fixmodal.style.display='none';
 			makemodal.style.display='block';
 		});
 		makevideoBackBtn.addEventListener('click',()=>{
 			videomodal.style.display='none';
 			makemodal.style.display='block';
 		})
 		makepostInsert.addEventListener('click', e => {			 			 		 
 			fixmodal.style.display='none';
 			postcomplete.style.display='block';
 			const userEmail = document.getElementsByName('postFrm')[0].elements['userEmail'].value;//유저 이메일 받아오기
 			const croppedFile = dataURLtoFile(cropped.src, 'croppedImage.jpg');
 			const formData = new FormData();
 			formData.append('userEmail', userEmail);
 			formData.append('imageName', croppedFile);
 			$.ajax({
				    url: "PostInsertServlet", 
				    type: "POST",
				    data:formData,
				    contentType: false,
				    processData: false,
				    success: function(result) {
				        //location.reload();
				    },   
				    error: function(xhr, status, error) {
				    }
				  });
 		}); 
 		function dataURLtoFile(dataURL, fileName) {
 			  const arr = dataURL.split(',');
 			  const mime = arr[0].match(/:(.*?);/)[1];
 			  const bstr = atob(arr[1]);
 			  let n = bstr.length;
 			  const u8arr = new Uint8Array(n);
 			  while (n--) {
 			    u8arr[n] = bstr.charCodeAt(n);
 			  }
 			  return new File([u8arr], fileName, { type: mime });
 			}
 		makepostCheck.addEventListener('click',()=>{
 			overlay.classList.toggle('active');
 			overlay.style.display = 'none';
 			$(".makeimage").attr("src", "./images/mainMakePostFalse.png");
 			postcomplete.style.display='none';
 			location.reload();
 		})
 		//영상
 		document.addEventListener('DOMContentLoaded', function() {
    const videopostInsert = document.querySelector('.videopostInsert');
    videopostInsert.addEventListener('click', function() {
        const videomodal = document.querySelector('.videomodal');
        const postcomplete = document.querySelector('.postcomplete');
        const userEmail = document.getElementsByName('postFrm')[0].elements['userEmail'].value;//유저 이메일 받아오기
        const videoElement = document.getElementById('videoElement');
        const videoFile = videoElement.files[0];
        const formData = new FormData();
        formData.append('userEmail', userEmail);
        formData.append('video', videoFile);
        $.ajax({
            url: "VideoPostInsertServlet",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                console.log("action in main");
                location.reload();
            },
            error: function(xhr, status, error) {
            }
        });
    });
});
 		//댓글 보기숨기기
 		function doDisplay(commentId){ 	
            const elements = document.querySelectorAll("#myDIV"+commentId);
            for(var i=0; i<elements.length; i++){
            	if(elements[i].style.display=='none'){ 		
            		elements[i].style.display = 'block';
                }else{ 		
                	elements[i].style.display = 'none'; 	
                } 
            }
        } 
