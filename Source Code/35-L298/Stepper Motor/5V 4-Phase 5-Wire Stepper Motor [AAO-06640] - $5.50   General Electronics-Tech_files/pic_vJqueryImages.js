var li1="li_img01",li2="li_img02";
// imgbox
function ls(a,b){
	var me=this;
	var wgif="includes/templates/heywholesale/images/tran.gif";
	var class_ul="product_list_li_ul",class_text="product_list_text",pop="pop_window",isImg=$(a)[0]?true:false,isList=b?true:false;
	var tListHtml="<ul><li class=\"wWin_li\"><div class=\"wWin_li_l\" next=\"l\" title=\"Back\"></div><div class=\"wWin_li_c\"><ul class=\""+class_ul+"\"></ul></div><div class=\"wWin_li_r\" next=\"r\" title=\"Next\"></div><li/><span class=\"g_t_c pr210\">"+lang['pageText']+" <span class=\""+class_text+"\"></span></span></ul>";
	this.starl=this.start=this.starw=this.starh=this.state=this.starc=this.imgsrclist=this.imgin=this.winin=this.srcArr=[];
	var $win,$pho,$bp,$bg,$wlist,$close;
	function getScrollTop(){function ieTrueBody(){return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body;}return $.browser.msie ? ieTrueBody().scrollTop : window.pageYOffset;}
	function getPos(e){
		var $e=$(e);
		return {t:$e.offset().top,l:$e.offset().left,w:$e.width(),h:$e.height()};
	}
	function getTag(name,obj){var oo=obj||document.body;return oo.getElementsByTagName(name);}
	window.onresize=function(){
		$("div").each(function(){
			if($(this).hasClass("wBg2")){
				getClientSize();
				setBgStyle($(this));
			}
		});
	}
	function setBgStyle(obj){
		getClientSize();
		obj.css({height:Math.max(cH,bH,sH),width:Math.max(cW,bW,sW)});
	}
	function imgInit(a,b,c,d,e,w){
		var newarr=initList(a,b,c,d,e,w);
		newarr[7].innerHTML=(parseInt(newarr[2])+1)+"/"+(parseInt(newarr[1])+1);
		var b_l=b.length;
		for(var i=0;i<b_l;i++){
			(function(i){
				b[i].onclick=function(){
					b[newarr[8]].className=li2;
					b[i].className=li1;
					me.number=i;
					newarr[8]=i;
					a[0].src=wgif;
					var z=b[i].getAttribute("imgb");
					var y=me.srcArr;
					var s=w?(y[2]+z):(me.state[0]==0?(y[2]+y[1]+z.split(y[0])[1]):(y[2]+y[3]+z.split(y[3])[1]));
					a[0].setAttribute("title",b[i].getAttribute("title"));
					a[0].setAttribute("alt",b[i].getAttribute("alt"));
						loadImage(s,chUrl,a[0]);
					if(me.state[0]==1&&!isList){
						me.img=me.a[me.number];
						var pos=getPos($(me.img)[0]);
						me.starl[0]=pos.l;
						me.start[0]=pos.t;
						me.starw[0]=pos.w;
						me.starh[0]=pos.h;
					}
					return false;
				};
				$(b[i]).hover(function(){b[i].className=li1;},function(){if(i!=newarr[8]) b[i].className=li2;});
			})(i);
		}
		var c_l=c.length;
		for(var n=0;n<c_l;n++){
			(function(n){
				if(parseInt(newarr[1])<1) return;
				if(c[n].getAttribute("next")=="l") c[n].onclick=function(){showList(1,newarr);}
				if(c[n].getAttribute("next")=="r") c[n].onclick=function(){showList(0,newarr);}
			})(n);
		}
	}
	function initList(a,b,c,d,e,w){
		var rlist,rtext,e_l=e.length,d_l=d.length;
		for(var u=0;u<e_l;u++){
			if(e[u].className==class_ul) rlist=e[u];
		}
		for(var i=0;i<d_l;i++){
			if(d[i].className==class_text) rtext=d[i];
		}
		if(w){
			me.imgin=[0,Math.floor((me.imgsrclist.length-1)/5),0,270,0,0,rlist,rtext,0,5,10];
			return me.imgin;
		}else{
			me.winin=[0,Math.floor((me.imgsrclist.length-1)/7),0,420,0,0,rlist,rtext,0,7,20];
			return me.winin;
		}
	}
	function setImglist(){
		var _list=isList?me.b:me.a;
		var liHtml="";
		$(_list).each(function(){
			var sc=$(this).attr("src").split(me.srcArr[0])[1];
			liHtml+="<li><img title=\""+$(this).attr("title")+"\" imgb=\""+me.srcArr[3]+$(this).attr("imgb").split(me.srcArr[1])[1]+"\" src=\""+me.srcArr[2]+me.srcArr[0]+sc+"\" class=\""+li2+"\"/></li>";
			me.imgsrclist.push(sc);
		});
		var eul=getTag("ul",me.wlist);
		$wlist.find("ul").each(function(){if($(this).hasClass(class_ul)) $(this).html(liHtml);});
		me.f=getTag("div",me.wlist);
		me.g=getTag("span",me.wlist);
		me.i=getTag("ul",me.wlist);
		me.j=getTag("img",me.wlist);
		me.k=getTag("img",me.win);
		imgInit(me.k,me.j,me.f,me.g,me.i,false);
	}
	function create(){
		me.win=createElem("DIV",{className:"wWin"});	
		me.close=createElem("DIV",{className:"winclose hide"});
		me.win.onclick=me.close.onclick=function(){
			if(me.startt==1) return;
			winOnclick();
			return false;
		};
		me.close.onmouseover = function(){$close.show();};
		me.pho=createElem("IMG");
                
		me.pho.setAttribute("src",wgif);
		me.wlist=createElem("DIV",{className:"wList hide"});	
		me.wlist.innerHTML=tListHtml;
		me.bg=createElem("DIV",{className:"wBg2"});
		me.bp=createElem("DIV",{className:"wBp hide"});
		for(var i=1;i<8;i++){var bpb=createElem("B",{className:"o"+i,id:"bpb"+i});me.bp.appendChild(bpb);}
		document.write('<span id="wPop_'+$(a)[0].id+'" class="wPop"></span>');
		me.win.appendChild(me.pho);
		$win=$(me.win),$pho=$(me.pho),$bp=$(me.bp),$bg=$(me.bg),$wlist=$(me.wlist),$close=$(me.close);
		$("#wPop_"+$(a)[0].id).append(me.bg);
		$("#wPop_"+$(a)[0].id).append(me.win);
		$("#wPop_"+$(a)[0].id).append(me.wlist);
		$("#wPop_"+$(a)[0].id).append(me.bp);
		$("#wPop_"+$(a)[0].id).append(me.close);
	}
	function winOnclick(){
		$bp.stop();
		$wlist.stop().hide().css({height:0});
		$close.hide();
		$win.removeClass("lbg");
		$bp.find("b").stop().each(function(i){if(i>1&&i<5){$(this).css({height:me.maxh-20});}}).end().hide().css({height:me.maxh+20});	
		show();           
	}
	function imgLoad(){
		var _a=me.a,_a_l=_a.length;
                
		for(var i=0;i<_a_l;i++){
			(function(i){
				_a[i].onclick=function(){
					if(me.state[0]==1) return false;
					if(me.startt==1) return false;
					me.img=_a[i];
					if(me.state[0]==0&&!isList) me.number=i;
					getClientSize;
					setContent();
					me.pho.src=wgif;
					show();
					return false;
				}
			})(i);
		}
	}
	function setContent(){
		var pos=getPos($(me.img)[0]);
		$win.css({height:pos.h,width:pos.w,left:pos.l,top:pos.t});
		setBgStyle($bg);
		var mt=(getScrollTop()+(cH-me.maxh-70)/2);
		me.maxt=mt>0?mt:10;
		me.maxl=(cW-me.maxw)/2;
		me.starl=[me.maxl,pos.l];
		me.start=[me.maxt,pos.t];
		me.starw=[me.maxw,pos.w];
		me.starh=[me.maxh,pos.h];
		me.starc=[0.1,1];
	}
	function show(){
            
		me.state[0]==0?$bg.show():$bg.hide();
		hide_select(0,0);
		me.startt=1;
		$win.show().css({opacity: me.starc[0]}).animate({opacity: me.starc[1],top:me.start[0],left:me.starl[0],width:me.starw[0],height:me.starh[0]}, 500,function(){actShow();});
		$pho.show().css({opacity: me.starc[0]}).animate({opacity: me.starc[1],width:me.starw[0],height:me.starh[0]}, 500);

		function actShow(){
			var z=me.img.getAttribute("imgb");
			var y=me.srcArr;
			var imgrc=isList?(y[2]+y[3]+me.img.src.split("/l/")[1]):(y[2]+y[1]+z.split(y[0])[1]);
			me.pho.setAttribute("title",me.img.getAttribute("title"));
			loadImage(imgrc,chUrl,me.pho);
			me.startt=0;
			var al=[me.starl,me.start,me.starw,me.starh,me.starc,me.state],al_l=al.length;
			for(var i=0;i<al_l;i++){al[i].reverse();}
			if(me.state[0]==0){
				$win.hide();
				$bg.hide();
				hide_select(1,0);
			}else{
				var l=me.starl[1],t=me.start[1];
				$win.addClass("lbg").hover(function(){if(me.startt==1) return;showClose();},function(){if(me.startt==1) return;$close.hide();});
				$bp.css({left:l-10,top:t-10}).show().animate({height:"590"}, 600);
				$wlist.css({left:l,top:t+me.maxw}).show().animate({height:"70"}, 600,function(){setBgStyle($bg);showClose();});
				$bp.find("b").each(function(i){if(i>1&&i<5){$(this).animate({height:"550"},300);}});
				function showClose(){$close.css({left:($win.offset().left+me.maxw-20),top:($win.offset().top+5)}).show();}
			}
			setContact();
		}
	}
	function setContact(){
		if(me.state[0]==1){
			contacts(me.winin,me.j);
		}else{
			if(isList){
				contacts(me.imgin,me.b);
				me.a[0].src=wgif;
				var s=me.srcArr[2]+me.srcArr[1]+me.b[me.number].src.split(me.srcArr[0])[1];
				me.a[0].setAttribute("title",me.b[me.number].getAttribute("title"));
				loadImage(s,chUrl,me.a[0]);
			}
		}
		function contacts(m,z){
			m[2]= Math.floor(me.number/m[9]);
			m[6].style.left=-m[3]*m[2]+"px";
			m[0]=-m[3]*m[2];
			m[8]=me.number;
			var z_l=z.length;
			for(var i=0;i<z_l;i++){z[i].className=li2;}
			z[me.number].className=li1;
			m[7].innerHTML=(parseInt(m[2])+1)+"/"+(parseInt(m[1])+1);
		}
	}
	this.init=function(){
		if(!isImg) return;
		me.a=getTag("img",$(a)[0]);
		if(!isList&&me.a.length==0) return;
		if(isList){
			me.b=getTag("img",$(b)[0]);
			me.c=getTag("div",$(b)[0]);
			me.d=getTag("span",$(b)[0]);
			me.e=getTag("ul",$(b)[0]);
		}
		create();
		me.maxw=500,me.maxh=500,me.number=0,me.startt=0,me.state=[0,1];
		getClientSize();
		getSrc();
		imgLoad();
		setImglist();
		if(isList) imgInit(me.a,me.b,me.c,me.d,me.e,true);
	}
	function getSrc(){
		var i="/images/";
		var a=isList?(i+"s/"):i;
		var b=isList?(i+"l/"):i;
		var c=isList?me.b[0].src.split(a)[0]:me.a[0].src.split(a)[0];
		var d=isList?(i+"v/"):i;
		me.srcArr=[a,b,c,d];
	}
}

function showList(t,m){
	if(m[4]==1) return;
	var x=t==0?-m[3]:m[3];
	if(t==0&&m[2]==m[1]){ rolling(1);cycleShow(1);}else if(t==1&&m[2]==0) {rolling(2);cycleShow(0);}else{ rolling();}
	function rolling(e){
		m[4]=1;
		$(m[6]).animate({left:parseInt($(m[6]).css("left"))+x},300,function(){pageSet(e);m[4]=0;});
	}
	function cycleShow(y){
		$(m[6]).after($(m[6]).clone(true).css({left:(y==1?(m[3]):(-m[3]*(m[1]+1)))}));
		$(m[6]).next("ul").animate({left:parseInt($(m[6]).next("ul").css('left'))+x},300,function(){
			m[0]=y==1?0:-m[3]*m[1];
			$(m[6]).addClass("hide").css({left:m[0]}).next("ul").css({left:m[0]}).end().removeClass("hide").next("ul").remove();
		}); 
	}
	function pageSet(h){if(h){m[2]=h==1?0:m[1];}else{t==0?m[2]++:m[2]--;}$(m[7]).html((parseInt(m[2])+1)+"/"+(parseInt(m[1])+1));}
}

///////////////zoom image
 // constants
var viewportWidth = 380,viewportHeight = 500,tileSize = 250;

var imageBaseName,imageDatePath;

// START:globalstate
var zoom = 0;
var zoomPath = ["s","m","l"];
var zoomSizes = [ [ "500px", "500px" ],[ "1000px", "1000px" ], [ "1500px", "1500px" ] ];
// END:globalstate

var scaleMode = "out";
// used to control moving the map div
var dragging = false;
var pDragging = false;
var is1500=true;

var offTop = 0,offLeft = 0;
var oT,oL,dragStartTop,dragStartLeft,dragST,dragSL;

function init() {
	imageDatePath = getRegExp($("#zoomBg")[0].src,0);
	imageBaseName = getRegExp($("#zoomBg")[0].src,1);
    // make inner div big enough to display the map
    // START:innerDivSize
    setInnerDivSize(zoomSizes[zoom][0], zoomSizes[zoom][1]);
    // END:innerDivSize
    // wire up the mouse listeners to do dragging                
	$("#outerDiv").bind("mousedown",startMove);
	$("#outerDiv").bind("mousemove",processMove);
	$("#outerDiv").bind("mouseup",stopMove);
	$("#outerDiv").bind("dblclick",scaleMove);				
	$("#pointer").bind("mousedown",pStartMove);
	$("#pointer").bind("mousemove",pProcessMove);	
	$("#pointer").fadeTo("slow", 0.6);
    // necessary to enable dragging on IE
	document.getElementById("outerDiv").ondragstart = function() { return false; }				
    document.getElementById("pointer").ondragstart = function() { return false; }
    checkTiles();
	initList();
	if(initBigImg==0){
		var isrc=$("#thumbnail_zoom img")[0].src;
		$("#zoomBg").attr({src:imagePath+"v/"+getRegExp(isrc,0)+"/"+getRegExp(isrc,1)+".jpg"}).siblings().hide();
		is1500=false;
	}
}

function getRegExp(str,exp){
	var regExps=exp==1?/\/s\/[0-9]*\/([A-Za-z0-9]*)/:/\/s\/([0-9]*)/;
	regExps.exec(str);
	return RegExp.$1;
}

function initList(){
	var zl=".zoom_list_";
	var $list={a:$(zl+"ul").get(0),b:$(zl+"text").get(0),c:$(zl+"ul img"),e:$(zl+"ul img"),f:$(zl+"l"),g:$(zl+"r")};
	var newarr=[0,Math.floor(($list.c.length-1)/6),0,325,0,0,$list.a,$list.b,$list.c.hasClass(li1),6,25];
	$(newarr[7]).html((parseInt(newarr[2])+1)+"/"+(parseInt(newarr[1])+1));
	$list.c.each(function(){
		$(this).click(function(){
			$(this).removeClass(li2).addClass(li1);
			$(newarr[8]).removeClass(li1).addClass(li2);
			newarr[8]=$(this);
			sr=$(this).attr("src");
			$("#thumbnail_zoom img").attr({src:sr});
			if($(this).attr("bimg")==0){
				$("#zoomBg").attr({src:imagePath+"v/"+getRegExp(sr,0)+"/"+getRegExp(sr,1)+".jpg"}).siblings().hide();
				is1500=false;
			}else{			
				$("#zoomBg").attr({src:sr});
				imageDatePath = getRegExp($("#zoomBg")[0].src,0);
				imageBaseName = getRegExp($("#zoomBg")[0].src,1);
				is1500=true;
			}
			goZoom('reset');
			return false;
		})
		if($(this).hasClass(li1) ) newarr[8]=$(this);
		$(this).hover(function(){ $(this).removeClass(li2).addClass(li1); }, function(){ if($(this).get(0)!=$(newarr[8]).get(0)) $(this).removeClass(li1).addClass(li2); });
	});
	if(newarr[1]>0){
		$list.f.click( function () { showList(1,newarr); }); 
		$list.g.click( function () { showList(0,newarr);});
	}
}

//keep the drag area
function limitArea(x,y){
	if(y>0)	y=0;
	if(y<-(zoom*viewportHeight)) y=-(zoom*viewportHeight);					
	if(x>-((zoom+1)*60)) x = -((zoom+1)*60);					
	if(x<(viewportWidth - (zoom+1)*440)) x = (viewportWidth - (zoom+1)*440);				
	return {x:x,y:y};		
}

//listener_BOF
function scaleMove(e) {
	if(zoom==2)	return;	
	if(e.target.tagName=="A") return;	
	var cursorOffX = e.clientX - $("#outerDiv").offsetLeft - stripPx($("#innerDiv").css("left"));
	var cursorOffY = e.clientY - $("#outerDiv").offsetTop - stripPx($("#innerDiv").css("top"));
	toggleZoom(cursorOffX,cursorOffY,"out");
}

function startMove(e) {
	if(zoom==0)	return;
	if(e.target.tagName=="DIV")	return;
    dragStartLeft = e.clientX;
    dragStartTop = e.clientY;				
    offTop = stripPx($("#innerDiv").css("top"));
    offLeft = stripPx($("#innerDiv").css("left"));
    dragging = true;
    return false;
}

function processMove(e) {
	if(zoom==0)	return;
	if(e.target.tagName=="DIV")	return;	
    var innerDiv = $("#innerDiv");
    if (dragging) {
		var moveX = offLeft + (e.clientX - dragStartLeft)
		var moveY = offTop + (e.clientY - dragStartTop)
		var offset = limitArea(moveX,moveY); 
		innerDiv.css({ left: offset.x, top: offset.y});		
    }
    //checkTiles();
	updatePointer();
}
// START:checktiles
function checkTiles() {
    // check which tiles should be visible in the inner div
    var visibleTiles = getVisibleTiles();
    // add each tile to the inner div, checking first to see
    // if it has already been added
    var innerDiv = document.getElementById("innerDiv");
    var visibleTilesMap = {};  
	if(!is1500) return; 
    for (i = 0; i < visibleTiles.length; i++) {
        var tileArray = visibleTiles[i];
        // START:imgZoomLevel
		var tileName = imageBaseName + "_" + tileArray[0] + "_" + tileArray[1];
        // END:imgZoomLevel
        visibleTilesMap[tileName] = true;
        var img = document.getElementById(tileName+"_"+zoom);
        if (!img) {
            img = document.createElement("img");
            img.src = imageBasePath + zoomPath[zoom]+"/"+imageDatePath + "/" + tileName + ".jpg";
			img.style.position = "absolute";
			img.style.left = tileArray[0] + "px";
			img.style.top = tileArray[1] + "px";
			img.style.width = tileSize + 0.5 + "px";
            img.style.zIndex = 1;
            img.setAttribute("id", tileName+"_"+zoom);
			innerDiv.appendChild(img);
        }
    }
}
// END:checktiles

function getVisibleTiles() {
    var innerDiv = document.getElementById("innerDiv");
    var mapX = stripPx(innerDiv.style.left);
    var mapY = stripPx(innerDiv.style.top);
    var startX = Math.abs(Math.floor(mapX / tileSize)) - 1;
    var startY = Math.abs(Math.floor(mapY / tileSize)) - 1;
    var tilesX = Math.ceil(viewportWidth / tileSize) + 1;
    var tilesY = Math.ceil(viewportHeight / tileSize) + 1;
    var visibleTileArray = [];
    var counter = 0;
    for (x = startX; x < (tilesX + startX); x++) {
        for (y = startY; y < (tilesY + startY); y++) {						
			var x1 = x*tileSize;
			var y1 = y*tileSize;
			if(x1<0||y1<0)
				continue;
			switch(zoom){
			case 0:
			  if(x1>250||y1>250)
			  	continue;
			  break;    
			case 1:
			  if(x1>750||y1>750)
			  	continue;
			  break;
			case 2:
			  if(x1>1250||y1>1250)
			  	continue;
			  break;
			}
            visibleTileArray[counter++] = [x1, y1];
        }
    }
    return visibleTileArray;
}
function stopMove(e) {
	if(zoom==0)	return;						
    dragging = false;
	pDragging = false;
	checkTiles();
}

//==============move the pointer
function pStartMove(e) {
	if(zoom==0)	return;
    dragSL = e.clientX;
    dragST = e.clientY;
    var pointer = $("#pointer");
    oT = stripPx(pointer.css("top"));
    oL = stripPx(pointer.css("left"));
    pDragging = true;
    return false;
}

function pProcessMove(e) {
	if(zoom==0)	return;
    var pointer = $("#pointer");
    if (pDragging) {
		var moveX = oL + (e.clientX - dragSL);
		var moveY = oT + (e.clientY - dragST);	
	    if(moveX < 6) moveX = 6;
		if(moveY < 0) moveY = 0;
		if(moveY > 50 - pointer.height()) moveY = 50 - pointer.height();
		if(moveX > 44 - pointer.width()) moveX = 44 - pointer.width();
		pointer.css({ left: moveX, top: moveY});	
		//move the image
		var ox = -stripPx(pointer.css("left"))*(zoom+1)*10;				
		var oy = -stripPx(pointer.css("top"))*(zoom+1)*10;
		//fix the deviate
		var offset = limitArea(ox,oy);  
		ox = offset.x;
		oy = offset.y;			
		$("#innerDiv").css({width:500*(zoom+1),height:500*(zoom+1),left:ox,top:oy});		
    }
}
//============== end of move pointer of
function stripPx(value) {
    if (value == "") return 0;
    return parseFloat(value.substring(0, value.length - 2));
}

function setInnerDivSize(width, height, x, y) {
    var innerDiv = $("#innerDiv");
	innerDiv.css({ width: width, height: height});
	var moveX;
	var moveY;
	if(x&&y&&scaleMode == "out"){
			//fix the flow bug
			moveX = offLeft - x/zoom;
			if(zoom==1){
				moveX = offLeft - x/zoom - 60*(zoom+1);
			}
			moveY = offTop - y/zoom;						
	}
	
	if(scaleMode == "in"){
		offLeft = (zoom==0)?0:stripPx(innerDiv.css("left"));
		offTop = (zoom==0)?0:stripPx(innerDiv.css("top"));
		moveX = offLeft/(zoom+1);
		moveY = offTop/(zoom+1);	
	}
	
	if(scaleMode == "reset"){
		moveX = -60;
		moveY = 0;
		offLeft = offTop = 0;
	}
	
	var offset = limitArea(moveX,moveY);					  
	innerDiv.css({ left: offset.x, top: offset.y});	
	updatePointer();
}

function updatePointer(){
	var el = $("#pointer");
	var innerDiv = $("#innerDiv");
	var ox = -stripPx(innerDiv.css("left"))/[(zoom+1)*10];
	var oy = -stripPx(innerDiv.css("top"))/[(zoom+1)*10];
	(zoom==0)?el.css("cursor",""):el.css("cursor","move");
	el.css({width:38/(zoom+1),height:50/(zoom+1),left:ox,top:oy});	
}

function goZoom(type){
	toggleZoom("","",type);
}
// START:toggleZoom
function toggleZoom(clickX,clickY,type) {
	scaleMode = type;
	switch(type){
		case "out":
		zoom++;
		if(zoom>2){
			zoom = 2;
			return;
		}
		break;
		case "in":
		zoom--;
		if(zoom<0){
			zoom = 0;
			return;
		}
		break;
		case "reset":
		zoom = 0;
		break;
	}
	var innerDiv = document.getElementById("innerDiv");
	var posX;
	var posY;
	posX = (clickX)?clickX:(viewportWidth/2 - offLeft);
	posY = (clickY)?clickY:(viewportHeight/2 - offTop);
   //clear images
    var imgs = innerDiv.getElementsByTagName("img");   
	$("#zoomBg").width(zoomSizes[zoom][0]);
	$("#zoomBg").height(zoomSizes[zoom][1]);			
    setInnerDivSize(zoomSizes[zoom][0], zoomSizes[zoom][1], posX, posY);			
	//save the bg
	while (imgs.length > 1) innerDiv.removeChild(imgs[1]);
	//fix the image shake;
	(clickX)?checkTiles():setTimeout(checkTiles,500);			
}
// END:toggleZoom