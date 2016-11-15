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
		setid.options[0]=new Option('��ѡ��','');
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
						alert('����ѡ��һ��'+fieldinfo[i][1]);
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
						alert('��������'+fieldinfo[i][1]);
					} else if(fieldinfo[i][2] == 'img' || fieldinfo[i][2] == 'flash' || fieldinfo[i][2] == 'file' || fieldinfo[i][2] == 'timestamp') {
						objvalue = document.getElementById(fieldinfo[i][0]+'_value');
						if(obj && strLen(objvalue.value) < 1) {
							alert('��δ����'+fieldinfo[i][1]+',����ȷ��');
						} else {
							ischoose = true;
						}
					} else {
						alert("����ѡ��һ��"+fieldinfo[i][1]);
					}
				}
				if(obj && obj.value != '') {
					if(fieldinfo[i][2] == 'text' || (fieldinfo[i][2] == 'textarea' && fieldinfo[i][3] != 0)) {
						if(fieldinfo[i][5] != 'TEXT' && fieldinfo[i][5] != 'MEDIUMTEXT' && fieldinfo[i][5] != 'LONGTEXT' && fieldinfo[i][5] != 'FLOAT' && fieldinfo[i][5] != 'DOUBLE') {
							if(fieldinfo[i][0]== 'tel'){
								if(!checkmobile(obj.value)){
									ischoose = false;
									alert('��������ȷ���ֻ���');
								}
							}else if(fieldinfo[i][0]== 'idcard'){									
									if(!checkCard(obj.value)){
										ischoose = false;
										//alert('��������ȷ�����֤����');
									}
								}else if(fieldinfo[i][0]== 'email'){
										if(!checkemail(obj.value)){
											ischoose = false;
											alert('��������ȷ�ĵ�������');
										}
									}else{
										if (strLen(obj.value) > fieldinfo[i][3]) {
											ischoose = false;
											alert('�������'+fieldinfo[i][1]+'���Ȳ�����Ҫ��,Ŀǰ����Ϊ'+strLen(obj.value)+'�ַ�,�뱣֤��'+fieldinfo[i][3]+'�ַ�����');
										}
							}
						}
					} else if(fieldinfo[i][2] == 'img' || fieldinfo[i][2] == 'flash') {
						if (!isfileext(obj.value, (fieldinfo[i][2] == 'img' ? imageext : flashext))) {
							ischoose = false;
							alert('�������'+fieldinfo[i][1]+'��ʽ����ȷ,����ȷ��');
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
			"��֤ͨ��!",   
			"���֤����λ������!",   
			"���֤����������ڳ�����Χ���зǷ��ַ�!",   
			"���֤����У�����!",   
			"���֤�����Ƿ�!");   
	  
		// �õ�������������   
		var area = getArea();   
		var card_array=card.split("");   
		// sΪ1λ���Ա���룬�����������ԣ�ż������Ů��   
		   
		var ereg, JYM, S, Y;   
		// ��֤���֤�����Ƿ�Ϸ�   
		if (area[card.substring(0, 2)] == null){
			alert(Errors[4]);    
			return false;
		}
		switch (card.length) {   
			// 15λ���֤��֤   
			case 15:   
				if ((parseInt(card.substr(6, 2)) + 1900) % 4 == 0   
						|| ((parseInt(card.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(card   
								.substr(6, 2)) + 1900) % 4 == 0)) {   
					ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2] [0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9])) [0-9]{3}$/;// ���Գ������ڵĺϷ���   
				} else {
					ereg = /^[1-9][0-9]{5}[0-9]{2} ((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]| [1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;// ���Գ������ڵĺϷ���   
				}   
				if (ereg.test(card)){   
					return true;
				}
				else{   
					alert(Errors[2]);
					return false;
				}
				break;   
			// 18λ���֤��֤   
			case 18:   
				// 18λ��ݺ�����   
				// �������ڵĺϷ��Լ��   
				// ��������:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|   
				// (04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))   
				// ƽ������:   
				// ((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))   
				var currentTime = new Date();
				
				if (parseInt(card.substr(6, 4)) >= currentTime.getFullYear()) {
					alert("���֤����ݲ��Ϸ�,��������!");    
					return false;
				}
				if (parseInt(card.substr(6, 4)) % 4 == 0   
						|| (parseInt(card.substr(6, 4)) % 100 == 0 && parseInt(card   
								.substr(6, 4)) % 4 == 0)) {
					// /^[1-9][0-9]{5}19[0-9]{2}
					ereg = /^[1-9][0-9]{5}[1-2][0|9][0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;// ����������ڵĺϷ���������ʽ   
				} else {   
					ereg = /^[1-9][0-9]{5}[1-2][0|9][0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;// ƽ��������ڵĺϷ���������ʽ   
				}   
				if (ereg.test(card)) {// ���Գ������ڵĺϷ���   
					// ����У��λ   
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
					M = JYM.substr(Y, 1);// �ж�У��λ
					
					if (M == card_array[17].toUpperCase()){
						return true; // ���ID��У��λ   
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
			11 :"����",   
			12 :"���",   
			13 :"�ӱ�",   
			14 :"ɽ��",   
			15 :"���ɹ�",   
			21 :"����",   
			22 :"����",   
			23 :"������",   
			31 :"�Ϻ�",   
			32 :"����",   
			33 :"�㽭",   
			34 :"����",   
			35 :"����",   
			36 :"����",   
			37 :"ɽ��",   
			41 :"����",   
			42 :"����",   
			43 :"����",   
			44 :"�㶫",   
			45 :"����",   
			46 :"����",   
			50 :"����",   
			51 :"�Ĵ�",   
			52 :"����",   
			53 :"����",   
			54 :"����",   
			61 :"����",   
			62 :"����",   
			63 :"�ຣ",   
			64 :"����",   
			65 :"�½�",   
			71 :"̨��",   
			81 :"���",   
			82 :"����",   
			91 :"����"   
		};
		return area;   
	}


var fieldinfo = new Array(
new Array('realname', '����', 'text', '80', '1', 'CHAR'),
new Array('sex', '�Ա�', 'select', '6', '1', 'SMALLINT'),
new Array('pic', '��Ƭ', 'img', '80', '0', 'CHAR'),
new Array('birdate', '��������', 'text', '10', '1', 'INT'),
new Array('minzu', '����', 'text', '10', '1', 'VARCHAR'),
new Array('xueli', 'ѧ��', 'select', '20', '1', 'VARCHAR'),
new Array('mianmao', '������ò', 'text', '10', '1', 'VARCHAR'),
new Array('idcard', '���֤��', 'text', '18', '1', 'VARCHAR'),
new Array('zhiye', 'ְҵ', 'text', '10', '1', 'VARCHAR'),
new Array('jingli', '���о���', 'select', '10', '1', 'VARCHAR'),
new Array('tel', '�ֻ�', 'text', '11', '1', 'VARCHAR'),
new Array('email', '����', 'text', '50', '1', 'VARCHAR'),
new Array('work', '������λ/����ԺУ', 'text', '50', '1', 'VARCHAR'),
new Array('fangshi', '������ʽ', 'radio', '50', '1', 'VARCHAR'),
new Array('jieshao', '���ҽ���', 'textarea', '0', '1', 'MEDIUMTEXT'),
new Array('huojiang', '������ؾ����������', 'textarea', '0', '1', 'MEDIUMTEXT'),
new Array('seccode','��֤��','text','4','1','VARCHAR')
);
