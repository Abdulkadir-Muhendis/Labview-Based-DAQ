var lang = new Array();
lang['checkemail'] = 'Please check your email address.\nYour email addresses should look like';
lang['bookm'] = 'AddThis Social Bookmarking Widget';
lang['notice_12_22'] = '<strong>IMPORTANT NOTICE:</strong> Dear Customers, after <strong>Sunday 21 Dec 17:00 (PST)</strong> we can no longer guarantee items ordered from heywholesale.com will arrive before Christmas Day. We are still working hard over the Holidays to source, pack and ship the best quality products, so you are invited to browse now for 2009. <br />Merry Christmas and a Happy New Year from everyone at heywholesale!';
lang['notice_1_22'] = '<strong>5%</strong> Off Promotion for the Chinese New Year. Order between <strong>Jan 22</strong> and <strong>Feb 1 (PST)</strong> to receive a <strong>5% discount on all items</strong> at . For more details on this exclusive offer, <a href="" class="u">click here</a>.'
lang['pageText']='Displaying';
lang['ADDART']='Add to Cart';
lang['ATTRIBUTESELECT']='Please Select';
lang['WIN_OPEN_TITLE']='Help heywholesale to serve you better. ';
lang['WIN_OPEN_CON']='Please take 2 mins to answer a few short questions about our website. Thank you! ';
lang['WIN_OPEN_BUTTON_NEVER']='Never';
lang['WIN_OPEN_BUTTON_LATER']='Later';
lang['WIN_OPEN_BUTTON_NOW']='Now';

var cW,cH,bW,bH,sW,sH;
function MouseEvent(e) {this.x = e.pageX;this.y = e.pageY;this.l=e.clientX;this.t=e.clientY;}

//list
(function($){
	$.fn.jqList = function(options){
		var sets = {size:8,number:0,total:0,cid:0,no:0}, isSub=false;;
		if(options) {$.extend(sets, options);};	
		sets.current=Math.floor(sets.number/sets.size);
		sets.pages=Math.ceil(sets.total/sets.size);
		page(Math.floor(sets.no/sets.size));
		function page(t){		
			var current=sets.current;
			switch (t) {
				case -1:	
					current=current<1?(sets.pages-1):(current-1);
					break;
				case 1:				
					current=current<(sets.pages-1)?(current+1):0;
					break;
				default:				
					current=t;
					break;
			}
			sets.current=current;
			$(sets.id+"Page").html((sets.current+1)+"/"+(sets.pages));
			get();
		}

		function get(){
			var mx=0,cn="#cell_name",ci="#cell_img";
			for(var i = sets.current*sets.size;i<(sets.current+1)*sets.size;i++){
				var p = [],s = productArr[i];			
				if(s){
				
								
					p.push(s.id,s.name,s.img,s.attr.count,s.attr.soldOut,s.attr.wholesale,s.attr.almost,s.salePrice,s.price,s.subName,s.attr.stockout);
					
					$(sets.id+" li").eq(mx).replaceWith($(".proList").html().replace(/{%pPrice%}/ig,p[8]).replace(/{%salePrice%}/ig,p[7]).replace(/{%pAlt%}/ig,p[1]).replace(/{%i%}/ig,i).replace(/{%pName%}/ig,p[9]).replace(/{%pOff%}/ig,p[3]));				
					if(p[3]!=-1) $("#b_arr_"+i).html(p[3]);
					$(cn+i).attr("href",rewrite_url(p[1],p[0]));
					$("#cell_link"+i).attr("href",rewrite_url(p[1],p[0]));
					loadImage(imgURL+p[2],chUrl,ci+i);
					if(p[0]==productid) {$(ci+i).addClass("allborder");}
					function showHide(a){for(var k=0;k<a.length;k++){a[k].a=="0"||a[k].a=="-1"?$(a[k].b+i).hide():$(a[k].b+i).show();}}			
					showHide([{a:p[4],b:"#a_arr_"},{a:p[3],b:"#b_arr_"},{a:p[6],b:"#c_arr_"},{a:p[5],b:"#d_arr_"},{a:p[10],b:"#e_arr_"},{a:sets.cid,b:cn},{a:sets.cid,b:"#cell_source_price"}]);
				}else{
					$(sets.id+" li").eq(mx).html("");
				}
				mx++;
			}
		}
		if(sets.pages>1){$(".recent_flash_prev").click(function(){if(isSub) return;subOk();page(-1);});$(".recent_flash_next").click(function(){if(isSub) return;subOk();page(1);});}
		function subOk(){isSub=true;window.setTimeout(function(){isSub=false;},500);};
	}
})(jQuery);


// Marquee
(function($){
	var methods = {
        marquee: function marquee(user_settings) {
            var self = $(this);            
			var sch = self.attr('scrollHeight');
			self.append(self.html());
            var settings = {
                timeout: null,                
                events: {
                    play: function(evt) {
                        var self = $(this);						
						var sct = self.scrollTop();
						if(sct>=sch)self.scrollTop(sct=sct-sch);
						self.animate({scrollTop:sct+settings.step-sct%settings.step},2000,function(){
							if(settings.timeout) clearTimeout(settings.timeout);
							settings.timeout = setTimeout(function(){self.marqueePlay()},settings.time);
						});
                    },
                    stop: function(evt) {
                        var self = $(this);
                        clearTimeout(settings.timeout);self.stop();
                    }
                }
            };
            if(self.data("marquee.settings")) {
                settings = self.data("marquee.settings");
            }
            settings = $.extend(user_settings, settings);            
            for(var event in settings.events) {
                var evt = "marquee." + event;
                self.unbind(evt);
                self.bind(evt, settings.events[event]);
            }            
            self.data("marquee.settings", settings);
			self.marqueePlay();
            return self;
        },
        marqueePlay: function() {
            $(this).trigger("marquee.play");         
        },
        marqueeStop: function() {
            $(this).trigger("marquee.stop");
        }
    };
    $.each(methods, function(i) {
        $.fn[i] = this;
    });
})(jQuery);

$(function(){
	 $(".use_round_border").each(function(){$(this).html('<em><b></b></em><div class="use_round_border_con">'+$(this).html()+'</div><b><em></em></b>')});	
	 //for product center
	  $(".attr_table_1 tr").find('td:first:not([class])').each(function(){$(this).addClass('blue_bg').width(100)});
	  var tdArr=[];
	  $(".attr_table_yellow tr").find('td:first:not([class])').each(function(n){var row=$(this).attr("rowspan");if(row>1){for(var i=1;i<row;i++){tdArr.push(n+i);}};if(jQuery.inArray(n, tdArr)==-1) {$(this).addClass('yellow_bg g_t_l')}});
	  $(".attr_table_yellow tr").find('td:even:not([colspan]):not(:first)').each(function(){$(this).addClass('lit_gray_bg')});
});
/**********************************/

function show(a){$("#"+a).show();}function hide(a){$("#"+a).hide();}
function back(num){history.go(num);return false;}
function findPos(obj){return[$(obj).offset().left,$(obj).offset().top];}
function loadImage(url, callback,id) {var img = new Image();img.src = url;if (img.complete) { callback.call(img,id);}else{$(img).bind("load", function(){callback.call(img,id);});}}
function rewrite_url(pname,pid){if(pid==null||pid=="undefined"){return""};var re=/[^a-zA-Z0-9]/ig;var url="";if(FRIENDLY_URLS!=null&&FRIENDLY_URLS=='true'){url=baseURL+pname.replace(re,"-")+"_p"+pid+".html";}else{url=linkURL+pid;}return url;}
function chUrl(id){$(id).attr({src:this.src});};
function isNone(str){return str==null||$.trim(str)==""?true:false;};
String.prototype.trim=function(){return this.replace(/(^[\s]*)|([\s]*$)/g,"");};String.prototype.inc=function(k1,k2){if(k2==null){k2=","};return(k2+this+k2).indexOf(k2+k1+k2)>-1?true:false;};String.prototype.sub=function(k1,k2){if(k2==null){k2=","};var tmp=k2+this+k2;var size=tmp.indexOf(k1);if(size==-1){return 0;}var i=0;while(tmp.charAt(size+3+i)!='/'){i++;}return tmp.substring(size+3,size+3+i);};
function efocu(obj){try{$(obj).focus();}catch(e){}};
function insHtm(obj,code,pos){obj=$(obj)[0];if($.browser.msie){obj.parentNode.insertAdjacentHTML(pos==null?"beforeend":"afterbegin",code);}else{var r=obj.ownerDocument.createRange();r.setStartBefore(obj);eval("obj.parentNode."+(pos==null?"appendChild":"insertBefore")+"(r.createContextualFragment(code),obj.parentNode.firstChild)");}}
function checkEmail(id){var email=$("#"+id)[0]==null?'':$("#"+id).val();if(!/(\,|^)([\w+._]+@\w+\.(\w+\.){0,3}\w{2,4})/.test(email.replace(/-|\//g,""))){$(id).focus();alert(lang['checkemail']);return false;}else{return true;}}
function popupwin(url,name,width,height,options){if($.browser.msie){var win=window.showModelessDialog(url,window,"status:false;dialogWidth:"+(width)+"px;dialogHeight:"+(height+30)+"px;edge:Raised; help: 0; resizable: 0; status: 0;scroll:0;");}
else{xposition=0;yposition=0;if((parseInt(navigator.appVersion)>=4)){xposition=(screen.width-width)/2;yposition=(screen.height-height)/2;}
theproperty="width="+width+","+"height="+height+","+"screenx="+xposition+","+"screeny="+yposition+","+"left="+xposition+","+"top="+yposition+","+options;
var win=window.open(url,name,theproperty);win.focus();}
return false;}

var openShow=false;
function show_chat_div(obj){
	
	if(openShow){close_chat_div();return;}
	openShow=true;
	$('#nav_chat_sales').marqueeStop()
	var msn=$(obj).attr("msn"),skype=$(obj).attr("skype"),email=$(obj).attr("email"),yahoo=$(obj).attr("yahoo");
	var str="",s1="<li><span class='big black b'>",s2="</span><BR/> <span class='pad_1em'>",s3="</span></li>";
	str+="<ul class='gray_trangle_list'>";
	function setStr(a){for(var i=0;i<a.length;i++){if(a[i].a!=null&&a[i].a!=""){str+=s1+a[i].b+s2+a[i].a+s3;}}};
	setStr([{a:email,b:"Email"},{a:msn,b:"MSN"},{a:skype,b:"SKYPE"},{a:yahoo,b:"YAHOO"}]);
	str+="</ul>";
	
	$('#chat_div_name').html(str);
	$('#chat_div').show();
	hide_select(0,"rel","dropdown");
}
function close_chat_div(){$('#chat_div').hide();$('#nav_chat_sales').marqueePlay();openShow=false;}

function hide_select(a,b,c){
	$("select").each(function(i){
		var t=a==0?"hidden":"visible";
		var r=b==0?"":"["+b+"*='"+c+"']";
		if($.browser.version==6.0) $("select"+r).css({visibility:t});
	});
}

function toggle(el){if($("#"+el).css("display")=="none"){$("#"+el).show();}else{$("#"+el).hide();}}

function layerswich(){
	$("#boxswitch div").click(function(){
		$(this).removeClass().addClass('on').siblings().removeClass().addClass('off');		
		$("#"+$(this).attr("title")).removeClass().addClass('show').siblings().removeClass().addClass('hide');
	});
}
function readCookie(name){var nameEQ=name+"=";var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++)
{var c=ca[i];while(c.charAt(0)==' ')c=c.substring(1,c.length);if(c.indexOf(nameEQ)==0)return c.substring(nameEQ.length,c.length);}
return null;}

function trackingChat(){
	var _loc=window.location.href;
	var _http="http";
	if(_loc.substr(0,5) == 'https') _http="https";
	var img=new Image();
	img.src = _http+'://www.heywholesale.com/click_to_live_chat/?url='+_loc;
}

function createElem(tagName,intObject){
	intObject=intObject||{};
	var newTag = document.createElement(tagName);
	for (var i in intObject) {
		newTag[i] = intObject[i];
	}
	return newTag;
}
var cookiedomain = '.heywholesale.com',cookiepath = '/';
function setCookie(cookieName, cookieValue, seconds, path, domain, secure) {
	if(seconds){
		var expires = new Date();
		expires.setTime(expires.getTime() + seconds * 1000);
	}
	domain = !domain ? cookiedomain : domain;
	path = !path ? cookiepath : path;
	document.cookie = escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toGMTString() : '')
		+ (path ? '; path=' + path : '/')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
}
function delCookie(name){
	setCookie(name,"",-60);
};
function getCookie(name) {
	var cookie_start = document.cookie.indexOf(name);
	var cookie_end = document.cookie.indexOf(";", cookie_start);
	return cookie_start == -1 ? '' : unescape(document.cookie.substring(cookie_start + name.length + 1, (cookie_end > cookie_start ? cookie_end : document.cookie.length)));
}
function preImages(arr){
	for(i=0;i<arr.length;i++){
		var img=new Image();
		img.src=arr[i];
	}
}

function getClientSize(){
	var dd=document.documentElement,db=document.body;
	cW=dd.clientWidth;
	cH=dd.clientHeight;
	bW=db.offsetWidth;
	bH=db.offsetHeight;
	sH=dd.scrollHeight;
	sW=dd.scrollWidth;
}
function getScrollTop(){function ieTrueBody(){return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body;}return $.browser.msie ? ieTrueBody().scrollTop : window.pageYOffset;}

function loginCheckLog(options){
	var me=this,url="";
	this.sets={};
	if(options) {$.extend(me.sets, options)};
	$.each(getSum(me.sets), function(i, n){
		if(n[0]!="action") url += n[0] + "=" + n[1] + "&";
	}); 
	var len=url.length;
	url=url.substr(0,len-1);
	var bodyId=$(document.body).attr("id");
	var _loc=window.location.href;
	var _http="http";
	if(_loc.substr(0,5) == 'https') _http="https";
	var img=new Image();
	img.src = _http+'://'+window.location.host+'/'+me.sets.action+'/?'+url;
}

function getSum(properties){
		var p=[];
		for(var i in properties){ 
			if(typeof(i)=="string") {
				var arr=[i,properties[i]]
				p.push(arr);
			}
		}
		return p;
}

function fixPng(obj){
	if ($.browser.version==6.0 && document.body.filters) {
		var imgs="http://image.heywholesale.com/includes/templates/dev_v2/images/tran.gif";
		var len=$(obj)[0].getElementsByTagName("img");
		for (var i=0; i<len.length; i++){
			var obj = len[i];
			var bg = obj.currentStyle.backgroundImage;
			var img = document.images[i];
			if (bg && bg.match(/\.png/i) != null) {
				var img = bg.substring(5,bg.length-2);
				var offset = obj.style["background-position"];
				obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+img+"', sizingMethod='crop')";
				obj.style.backgroundImage = "url('"+imgs+"')";
				obj.style["background-position"] = offset; 
			} else if (img && img.src.match(/\.png$/i) != null) {
				var src = img.src;
			//	img.style.width = img.width + "px";
			//	img.style.height = img.height + "px";
				img.style.filter ="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='crop')";
				img.src = imgs;
			}
		}
	}
}

function winOpenBox(){
	this.sets = {width:500,height:300,classs:"winHtmlDiv",close:"show"};
	var me=this , _win="" , _bg="" ,_div=".winHtmlDiv",_bg=".winHtmlBg", _skins="",_w="",_h="",_con=".winHtmlCon",_close="winHtmlClose",_pw="pngWidth",_ph="pngHeight",_ok="button_ok",sty1="height:30px;width:25px;",sty2="height:30px;width:5px;",sty3="height:46px;width:46px;";
	this.create = function(){
		var winHtmlStr='<table width="100%" border="0" cellspacing="0" cellpadding="0" class="winHtmlTable">';
		winHtmlStr+='<tr><td width="25" height="30"><img src="'+_skins+'bg01.png" style="'+sty1+'"/></td><td width="5"><img src="'+_skins+'bg02.png" style="'+sty2+'"/></td><td><img src="'+_skins+'bg03.png" class="'+_pw+'"/></td><td width="5"><img src="'+_skins+'bg04.png" style="'+sty2+'"/></td><td width="25"><img src="'+_skins+'bg05.png" style="'+sty1+'"/></td></tr>';
		winHtmlStr+='<tr><td><img src="'+_skins+'bg06.png" class="'+_ph+'"/></td><td class="'+me.sets.skin+'"></td><td class="'+me.sets.skin+'"><div class="winHtmlCon pad_10px flow"></div></td><td class="'+me.sets.skin+'"></td><td><img src="'+_skins+'bg07.png" class="'+_ph+'" /></td></tr>';
		winHtmlStr+='<tr><td height="30"><img src="'+_skins+'bg08.png" style="'+sty1+'"/></td><td><img src="'+_skins+'bg09.png" style="'+sty2+'"/></td><td><img src="'+_skins+'bg10.png" class="'+_pw+'"/></td><td><img src="'+_skins+'bg11.png" style="'+sty2+'"/></td><td><img src="'+_skins+'bg12.png" style="'+sty1+'"/></td>';
		winHtmlStr+='</tr></table><span class="'+_close+'"><img src="'+_skins+'close.png"  style="'+sty3+'"/></span>';
		_win=createElem("DIV",{className:"winHtmlDiv absolute flow"});
		_bg=createElem("DIV",{className:"winHtmlBg"});
		$(_win).html(winHtmlStr);
		$(document.body).prepend(_win).prepend(_bg);
	};
	this.show = function(options){
		if(options) {$.extend(me.sets, options)};
		_skins="http://"+window.location.host+"/includes/templates/dev_v2/css/images/imgBox/"+me.sets.skin+"/";
		this.create();
		getClientSize();
		_w=me.sets.width+60,_h=me.sets.height+60;
		hide_select(0,0);
		$(_div).css({left:(cW-_w)/2,top:Math.max((cH-_h)/2+getScrollTop(),getScrollTop()),width:_w,height:_h}).find("."+_pw).css({width:me.sets.width,height:30}).end().find("."+_ph).css({width:25,height:me.sets.height}).end().show();
		$("."+_close).removeClass().addClass(_close+" "+me.sets.close).click(function(){me.close();});
		$(_con).css({width:me.sets.width-20,height:me.sets.height-20}).html(me.sets.html);
		fixPng(_div);
		$(_bg).css({height:Math.max(cH,bH,sH),width:Math.max(cW,bW,sW)}).css({opacity: 0}).animate({ opacity: 0.25 });
	};
	this.close = function(){
		$(_div).remove(); ;
		$(_bg).fadeOut(200,function(){$(this).remove(); });
		hide_select(1,0);
	};
	window.onresize=function(){	
		if($(_bg)[0]){
			getClientSize();
			$(_bg).css({height:Math.max(cH,bH,sH),width:Math.max(cW,bW,sW)});
			$(_div).css({left:(cW-_w)/2,top:Math.max((cH-_h)/2+getScrollTop(),getScrollTop())})
		}
	};
	this.alert = function(options){
		me.show(options);
		$(_con).append('<table width="100%"><tr><td class="g_t_c"><button type="button" id="'+_ok+'" class="margin_t b"><span>&nbsp;Ok&nbsp;</span></button></td></tr></table>'); 
		$("#"+_ok).click(function(){me.close();});
	};
}

function showCountdown(){
	var me=this;
	this.sets = {};
	this.create = function(){
		var htmlStr='<div style="position:relative;clear:both;background:url('+me.sets.bg+');width:'+me.sets.width+'px;height:'+me.sets.height+'px;"><ul style="padding:0px 0px 0px '+me.sets.padding+'px;font-size:22px;color:#000;">';
		for(var i=0;i<4;i++){var w=i<2?36:35;htmlStr+='<li class="white fl g_t_c line_30px" id="'+me.sets.id+i+'" style="width:'+w+'px;padding:13px 4px 0px 0px;">00</li>';}
		if(me.sets.link) htmlStr+='<a href="'+me.sets.link.href+'" style="display:block;background:#000;position:absolute;left:'+me.sets.link.left+'px;top:'+me.sets.link.top+'px;width:'+me.sets.link.width+'px;height:'+me.sets.link.height+'px;">ddddd</a>';
		htmlStr+='</ul></div>';
		document.write(htmlStr);
	};
	this.show = function(options){
		if(options) {$.extend(me.sets, options)};
		me.create();
		showBackTime(new Date(me.sets.endTime));
	};
	function showBackTime(endTime){
			var date=new Date();
			var startTime=new Date(date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds());
			var timer;
			var addTime = startTime - new Date(setHs);
			var t = (endTime-startTime+addTime)/1000 + 1;
			if(t<1){return;}
			(function (){
				if (--t>0){
					for(var i=0;i<4;i++){
						$("#time"+i).html(minToBackTime(t)["t"+i]);

					}
				}else{
					clearTimeout(timer);
					for(var i=0;i<4;i++){
						$("#time"+i).html("00");
					}
				}
				timer = window.setTimeout(arguments.callee,1000);
			})();
		}
		function minToBackTime(min){
			var t = Math.floor(min/86400);
			min -= 86400*t;
			var s = Math.floor(min/3600);
			min -= 3600*s;
			var f = Math.floor(min/60);
			min -= 60*f;
			return {t0:padLeft(t,10),t1:padLeft(s,10),t2:padLeft(f,10),t3:padLeft(min,10)};
		}
		function padLeft(t,l){t=(t<l)?("0"+t):t;return t;}
}

$.fn.fillet= function(options) {
	var b_arr=[],$_this=$(this),sets = {border:"#ddd",background:"#fff",noBorder:false};
	for(var i=0;i<5;i++){var _w=i==1?" w2":"";b_arr.push("<b class=\"b"+i+_w+"\"></b>");}
	var conDiv = createElem("DIV",{className:"fillet_con"});
	$(conDiv).html($_this.html());
	$_this.html("");
	var $_width=$_this.width();
	$_this.append(b_arr.join("")).append(conDiv).append(b_arr.reverse().join("")); 
	if(options) {$.extend(sets, options)};	
	sets.border=sets.noBorder?sets.background:sets.border;
	$("b",this).css({borderColor:sets.border,backgroundColor:sets.background});
	$(".b0",this).css({backgroundColor:sets.border});
	$(".fillet_con",this).css({borderColor:sets.border,backgroundColor:sets.background,width:$_width-22,padding:"5px 10px",overflow:"hidden"});
	$_this.show();
}
