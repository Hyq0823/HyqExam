var imageext = new Array('jpg', 'jpeg', 'gif', 'png');
var flashext = new Array('swf');

function strLen(str) {
	var charset = document.charset;
	var len = 0;
	for(var i = 0; i < str.length; i++) {
		len += str.charCodeAt(i) < 0 || str.charCodeAt(i) > 255 ? (charset == 'utf-8' ? 3 : 2) : 1;
	}
	return len;
}

function fileext(filename) {
	if(filename == null || filename == '') {
		return '';
	}
	var ext = null;
	var num = filename.lastIndexOf(".");
	if(num != -1) {
		ext = filename.substring(num + 1);
	} else {
		ext = '';
	}
	return ext;
}

function isfileext(filename, extarr) {
	var ext = fileext(filename).toLowerCase();
	for(var i = 0; i < extarr.length; i++) {
		if(extarr[i] == ext){
			return true;
		}
	}
	return false;
}

function fill(setid, parentid, arr, value) {
	setid = document.getElementById(setid);
	if(setid != null) {
		setid.options[0]=new Option('请选择','');
		opt = 0;
		if(parentid == '') {
			for(i=0;i<arr.length;i++) {
				setid.options[i+1]=new Option(arr[i][1],arr[i][0]);
				if(arr[i][1] == value) {
					opt = i+1;
				}
			}
			setid.options[opt].selected=true;
			setid.length=i+1;
		} else {
			parentcode = document.getElementById(parentid).value;
			count=1;
			if(parentcode != '') {
				for(i=0;i<arr.length;i++) {
					if(arr[i][0].toString().substring(0,parentcode.length)==parentcode.substring(0, parentcode.length)) {
						setid.options[count]=new Option(arr[i][1],arr[i][0]);
						if(value != null && arr[i][1] == value) {
							opt = count;
						}
						count=count+1;
					}
				}
			}
			setid.options[opt].selected=true;
			setid.length=count;
		}
	}
}

function validate(theform) {
	if(fieldinfo.length > 0) {
		for(i = 0; i < fieldinfo.length; i++) {
			obj = null;
			if(fieldinfo[i][2] == 'checkbox' && fieldinfo[i][4] == '1') {
				ischoose = false;
				var nodes = document.getElementsByTagName('input');
				if(nodes) {
					for(j = 0; j < nodes.length; j++) {
						var node = nodes[j];
						if (node.name == fieldinfo[i][0]+'[]') {
							if(obj == null) obj = node;
							if(node.checked == true) {
								ischoose = true;
								break;
							}

						}
					}
					if(!ischoose) {
						alert('请您选择一个'+fieldinfo[i][1]);
						obj.focus();
						return false;
					}
				}
			} else {
				ischoose = true;
				obj = document.getElementById(fieldinfo[i][0]);
				if(fieldinfo[i][4] == '1' && obj && strLen(obj.value) < 1) {
					ischoose = false;
					if(fieldinfo[i][2] == 'text' || fieldinfo[i][2] == 'textarea') {
						alert('请您输入'+fieldinfo[i][1]);
					} else if(fieldinfo[i][2] == 'img' || fieldinfo[i][2] == 'flash' || fieldinfo[i][2] == 'file' || fieldinfo[i][2] == 'timestamp') {
						objvalue = document.getElementById(fieldinfo[i][0]+'_value');
						if(obj && strLen(objvalue.value) < 1) {
							alert('您未设置'+fieldinfo[i][1]+',请检查确认');
						} else {
							ischoose = true;
						}
					} else {
						alert("请您选择一个"+fieldinfo[i][1]);
					}
				}
				if(obj && obj.value != '') {
					if(fieldinfo[i][2] == 'text' || (fieldinfo[i][2] == 'textarea' && fieldinfo[i][3] != 0)) {
						if(fieldinfo[i][5] != 'TEXT' && fieldinfo[i][5] != 'MEDIUMTEXT' && fieldinfo[i][5] != 'LONGTEXT' && fieldinfo[i][5] != 'FLOAT' && fieldinfo[i][5] != 'DOUBLE') {
							if(fieldinfo[i][0]== 'tel'){
								if(!checkmobile(obj.value)){
									ischoose = false;
									alert('请输入正确的手机号');
								}
							}else if(fieldinfo[i][0]== 'idcard'){									
									if(!checkCard(obj.value)){
										ischoose = false;
										//alert('请输入正确的身份证号码');
									}
								}else if(fieldinfo[i][0]== 'email'){
										if(!checkemail(obj.value)){
											ischoose = false;
											alert('请输入正确的电子邮箱');
										}
									}else{
										if (strLen(obj.value) > fieldinfo[i][3]) {
											ischoose = false;
											alert('您输入的'+fieldinfo[i][1]+'长度不符合要求,目前长度为'+strLen(obj.value)+'字符,请保证在'+fieldinfo[i][3]+'字符以内');
										}
							}
						}
					} else if(fieldinfo[i][2] == 'img' || fieldinfo[i][2] == 'flash') {
						if (!isfileext(obj.value, (fieldinfo[i][2] == 'img' ? imageext : flashext))) {
							ischoose = false;
							alert('您输入的'+fieldinfo[i][1]+'格式不正确,请检查确认');
						}
					}
				}
				if(!ischoose) {
					obj.focus();
					return false;
				}
			}
		}
	}

	return true;
}

	function checkmobile(value){
		if(/^13\d{9}$/g.test(value) || (/^15[0-35-9]\d{8}$/g.test(value)) || (/^18[05-9]\d{8}$/g.test(value))) {
			return true;
		}
		return false;			
	}

function checkemail(value) {
	return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value);
}

	function checkCard(card) {   
		var Errors=new Array(   
			"验证通过!",   
			"身份证号码位数不对!",   
			"身份证号码出生日期超出范围或含有非法字符!",   
			"身份证号码校验错误!",   
			"身份证地区非法!");   
	  
		// 得到地区集合数组   
		var area = getArea();   
		var card_array=card.split("");   
		// s为1位的性别代码，奇数代表男性，偶数代表女性   
		   
		var ereg, JYM, S, Y;   
		// 验证身份证地区是否合法   
		if (area[card.substring(0, 2)] == null){
			alert(Errors[4]);    
			return false;
		}
		switch (card.length) {   
			// 15位身份证验证   
			case 15:   
				if ((parseInt(card.substr(6, 2)) + 1900) % 4 == 0   
						|| ((parseInt(card.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(card   
								.substr(6, 2)) + 1900) % 4 == 0)) {   
					ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2] [0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9])) [0-9]{3}$/;// 测试出生日期的合法性   
				} else {
					ereg = /^[1-9][0-9]{5}[0-9]{2} ((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]| [1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;// 测试出生日期的合法性   
				}   
				if (ereg.test(card)){   
					return true;
				}
				else{   
					alert(Errors[2]);
					return false;
				}
				break;   
			// 18位身份证验证   
			case 18:   
				// 18位身份号码检测   
				// 出生日期的合法性检查   
				// 闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|   
				// (04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))   
				// 平年月日:   
				// ((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))   
				var currentTime = new Date();
				
				if (parseInt(card.substr(6, 4)) >= currentTime.getFullYear()) {
					alert("身份证号年份不合法,请检查输入!");    
					return false;
				}
				if (parseInt(card.substr(6, 4)) % 4 == 0   
						|| (parseInt(card.substr(6, 4)) % 100 == 0 && parseInt(card   
								.substr(6, 4)) % 4 == 0)) {
					// /^[1-9][0-9]{5}19[0-9]{2}
					ereg = /^[1-9][0-9]{5}[1-2][0|9][0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;// 闰年出生日期的合法性正则表达式   
				} else {   
					ereg = /^[1-9][0-9]{5}[1-2][0|9][0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;// 平年出生日期的合法性正则表达式   
				}   
				if (ereg.test(card)) {// 测试出生日期的合法性   
					// 计算校验位   
					S = (parseInt(card_array[0]) + parseInt(card_array[10])) * 7   
							+ (parseInt(card_array[1]) + parseInt(card_array[11]))   
							* 9   
							+ (parseInt(card_array[2]) + parseInt(card_array[12]))   
							* 10   
							+ (parseInt(card_array[3]) + parseInt(card_array[13]))   
							* 5   
							+ (parseInt(card_array[4]) + parseInt(card_array[14]))   
							* 8   
							+ (parseInt(card_array[5]) + parseInt(card_array[15]))   
							* 4   
							+ (parseInt(card_array[6]) + parseInt(card_array[16]))   
							* 2 + parseInt(card_array[7]) * 1   
							+ parseInt(card_array[8]) * 6 + parseInt(card_array[9])   
							* 3;   
					Y = S % 11;   
					M = "F";   
					JYM = "10X98765432";   
					M = JYM.substr(Y, 1);// 判断校验位
					
					if (M == card_array[17].toUpperCase()){
						return true; // 检测ID的校验位   
					}
					
					else{   
						alert(Errors[3]);    
						return false;
					}
				} else{   
					alert(Errors[2]);    
					return false;
				}
				break;   
			break;   
		}   
		alert(Errors[1]);
		return false;
	}   
	function getArea() {   
		var area = {   
			11 :"北京",   
			12 :"天津",   
			13 :"河北",   
			14 :"山西",   
			15 :"内蒙古",   
			21 :"辽宁",   
			22 :"吉林",   
			23 :"黑龙江",   
			31 :"上海",   
			32 :"江苏",   
			33 :"浙江",   
			34 :"安徽",   
			35 :"福建",   
			36 :"江西",   
			37 :"山东",   
			41 :"河南",   
			42 :"湖北",   
			43 :"湖南",   
			44 :"广东",   
			45 :"广西",   
			46 :"海南",   
			50 :"重庆",   
			51 :"四川",   
			52 :"贵州",   
			53 :"云南",   
			54 :"西藏",   
			61 :"陕西",   
			62 :"甘肃",   
			63 :"青海",   
			64 :"宁夏",   
			65 :"新疆",   
			71 :"台湾",   
			81 :"香港",   
			82 :"澳门",   
			91 :"国外"   
		};
		return area;   
	}


var fieldinfo = new Array(
new Array('realname', '姓名', 'text', '80', '1', 'CHAR'),
new Array('sex', '性别', 'select', '6', '1', 'SMALLINT'),
new Array('pic', '照片', 'img', '80', '0', 'CHAR'),
new Array('birdate', '出生年月', 'text', '10', '1', 'INT'),
new Array('minzu', '民族', 'text', '10', '1', 'VARCHAR'),
new Array('xueli', '学历', 'select', '20', '1', 'VARCHAR'),
new Array('mianmao', '政治面貌', 'text', '10', '1', 'VARCHAR'),
new Array('idcard', '身份证号', 'text', '18', '1', 'VARCHAR'),
new Array('zhiye', '职业', 'text', '10', '1', 'VARCHAR'),
new Array('jingli', '朗诵经历', 'select', '10', '1', 'VARCHAR'),
new Array('tel', '手机', 'text', '11', '1', 'VARCHAR'),
new Array('email', '邮箱', 'text', '50', '1', 'VARCHAR'),
new Array('work', '工作单位/所在院校', 'text', '50', '1', 'VARCHAR'),
new Array('fangshi', '报名方式', 'radio', '50', '1', 'VARCHAR'),
new Array('jieshao', '自我介绍', 'textarea', '0', '1', 'MEDIUMTEXT'),
new Array('huojiang', '朗诵相关经历及获奖情况', 'textarea', '0', '1', 'MEDIUMTEXT'),
new Array('seccode','验证码','text','4','1','VARCHAR')
);
