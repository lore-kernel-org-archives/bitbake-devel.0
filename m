Return-Path: <ernst.sjostrand@verisure.com>
X-Greylist: delayed 9431 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 02 Jul 2019 12:57:56 UTC
Received: from mx08-00271601.pphosted.com (mx07-00271601.pphosted.com
	[91.207.212.217])
	by mail.openembedded.org (Postfix) with ESMTP id 216367EAF0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 12:57:55 +0000 (UTC)
Received: from pps.filterd (m0107397.ppops.net [127.0.0.1])
	by mx08-00271601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x62AICEI012536 for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Jul 2019 12:20:45 +0200
Received: from eur01-he1-obe.outbound.protection.outlook.com
	(mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57])
	by mx08-00271601.pphosted.com with ESMTP id 2tg4698bs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jul 2019 12:20:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=verisure.onmicrosoft.com; s=selector2-verisure-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SNaJmW5MGsnO3IYH3WtBMecZVLr/7n2P3SHfc+M99Oo=;
	b=J7Z6985aVrFpovPsXAyJSUVC7Ks6/z9AfZA5++jd85FMyPJvJwz2nyEKeYDYfHfdfgwJPSEYZpiS87VYlU79+VF/wVwmJLu3taSl128JPJZre50iu6o1pvHlriFcKolUJHRR/jVOSqZ97pPd6rcRiX+pq9U7ObqlmlNDvMojIh0=
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM (52.134.85.19) by
	AM0PR10MB2450.EURPRD10.PROD.OUTLOOK.COM (20.177.110.225) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2032.20; Tue, 2 Jul 2019 10:19:46 +0000
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::31d2:4497:8c1d:d69a]) by
	AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::31d2:4497:8c1d:d69a%3]) with mapi id 15.20.2052.010;
	Tue, 2 Jul 2019 10:19:46 +0000
From: =?utf-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernst.sjostrand@verisure.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [bitbake-devel, 1.42, 1.40] git.py: Handle space
	in git repo name
Thread-Index: AQHVML+sGlEw3atmHUe6O2QE1G8G7A==
Date: Tue, 2 Jul 2019 10:19:46 +0000
Message-ID: <d86c3787f5e287b397f96be56c8f680c5c16f564.camel@verisure.com>
References: <20190702090710.1411-1-ankur.tyagi85@gmail.com>
In-Reply-To: <20190702090710.1411-1-ankur.tyagi85@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.170.189.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95b9bb2a-ddeb-4b75-f98a-08d6fed6cf02
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR10MB2450; 
x-ms-traffictypediagnostic: AM0PR10MB2450:
x-microsoft-antispam-prvs: <AM0PR10MB2450C5F0546C7F6BBD84D87394F80@AM0PR10MB2450.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:148;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(2616005)(5660300002)(99286004)(316002)(86362001)(6916009)(25786009)(486006)(11346002)(118296001)(476003)(446003)(5640700003)(6512007)(6116002)(3846002)(102836004)(229853002)(8936002)(36756003)(2501003)(85202003)(2906002)(6506007)(14454004)(8676002)(26005)(256004)(186003)(2351001)(91956017)(66556008)(64756008)(66446008)(66066001)(53936002)(73956011)(66476007)(76116006)(66946007)(76176011)(305945005)(85182001)(6486002)(7736002)(81166006)(478600001)(6436002)(81156014)(71200400001)(71190400001)(6246003)(68736007);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR10MB2450;
	H:AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: verisure.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i6BLXxFhP0M9b9OxBizgwx28FDR32awndcwMmER5jIg6VqJtL3AnGzujRt/CnlJ17Dq4uAM2dB/XjKb1tC5t1piBNynxLJB9fxzpZfPqOzGSoyHxLxRU5yq0Bn8bnlCFqpoi4G61OYIfVyDWuLSHUbg1jfwL2L514yKrXkZtpzMELXAg+0qGyvq74uGJZmh3da9XzImGXH1AhXJuB08nON+9N+vHWTGC3/ozpZugJf5qi9dRoCZh0+YfkVPjSU/spFeVp7lE0YXwIzGRQbMTgHD+ir8a1C5BMtTkSIMDhE2KKf7dc0O5EuAnuzr7QBPnxMWsOHqUCH4XIipH3hNjhYqyCMYCLJyM/ar/b+ijzqTEA4kBx7MwFAvHyrJdTNzVZ3bN5Hr16OTV12KjUPXbgEZPJtmORrtu4sS0ngjsD/A=
MIME-Version: 1.0
X-OriginatorOrg: verisure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b9bb2a-ddeb-4b75-f98a-08d6fed6cf02
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:19:46.7689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3055fa7f-a944-4927-801e-a62b63119e43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ernst.sjostrand@verisure.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2450
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-02_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907020121
Subject: Re: [bitbake-devel, 1.42, 1.40] git.py: Handle space in git repo name
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 02 Jul 2019 12:57:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA060D91629FE4AB6A88B5681A2F0ED@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

SGksDQoNCndvdWxkbid0IHRoaXMgYnJlYWsgdGhlIG5vbi1odHRwIHByb3RvY29scz8NCg0KUmVn
YXJkcw0KLy9Fcm5zdA0KDQp0aXMgMjAxOS0wNy0wMiBrbG9ja2FuIDIxOjA3ICsxMjAwIHNrcmV2
IEFua3VyIFR5YWdpOg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmt1ciBUeWFnaSA8DQo+IGFua3VyLnR5
YWdpODVAZ21haWwuY29tDQo+ID4NCj4gLS0tDQo+ICBsaWIvYmIvZmV0Y2gyL2dpdC5weSB8IDYg
KysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5IGIvbGliL2JiL2ZldGNo
Mi9naXQucHkNCj4gaW5kZXggZTE3MWFhN2UuLjUzMDBmYThmIDEwMDY0NA0KPiAtLS0gYS9saWIv
YmIvZmV0Y2gyL2dpdC5weQ0KPiArKysgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KPiBAQCAtMjM2
LDcgKzIzNiw3IEBAIGNsYXNzIEdpdChGZXRjaE1ldGhvZCk6DQo+ICAgICAgICAgICAgICAgICAg
ICAgIHVkLnVucmVzb2x2ZWRyZXZbbmFtZV0gPSB1ZC5yZXZpc2lvbnNbbmFtZV0NCj4gICAgICAg
ICAgICAgICAgICB1ZC5yZXZpc2lvbnNbbmFtZV0gPSBzZWxmLmxhdGVzdF9yZXZpc2lvbih1ZCwg
ZCwNCj4gbmFtZSkNCj4gIA0KPiAtICAgICAgICBnaXRzcmNuYW1lID0gJyVzJXMnICUgKHVkLmhv
c3QucmVwbGFjZSgnOicsICcuJyksDQo+IHVkLnBhdGgucmVwbGFjZSgnLycsICcuJykucmVwbGFj
ZSgnKicsICcuJykpDQo+ICsgICAgICAgIGdpdHNyY25hbWUgPSAnJXMlcycgJSAodWQuaG9zdC5y
ZXBsYWNlKCc6JywgJy4nKSwNCj4gdWQucGF0aC5yZXBsYWNlKCcvJywgJy4nKS5yZXBsYWNlKCcq
JywgJy4nKS5yZXBsYWNlKCIgIiwgIiUyMCIpKQ0KPiAgICAgICAgICBpZiBnaXRzcmNuYW1lLnN0
YXJ0c3dpdGgoJy4nKToNCj4gICAgICAgICAgICAgIGdpdHNyY25hbWUgPSBnaXRzcmNuYW1lWzE6
XQ0KPiAgDQo+IEBAIC00NTksNyArNDU5LDcgQEAgY2xhc3MgR2l0KEZldGNoTWV0aG9kKToNCj4g
ICAgICAgICAgICAgIHJlYWRwYXRoc3BlYyA9ICIiDQo+ICAgICAgICAgICAgICBkZWZfZGVzdHN1
ZmZpeCA9ICJnaXQvIg0KPiAgDQo+IC0gICAgICAgIGRlc3RzdWZmaXggPSB1ZC5wYXJtLmdldCgi
ZGVzdHN1ZmZpeCIsIGRlZl9kZXN0c3VmZml4KQ0KPiArICAgICAgICBkZXN0c3VmZml4ID0gdWQu
cGFybS5nZXQoImRlc3RzdWZmaXgiLA0KPiBkZWZfZGVzdHN1ZmZpeCkucmVwbGFjZSgiICIsICIl
MjAiKQ0KPiAgICAgICAgICBkZXN0ZGlyID0gdWQuZGVzdGRpciA9IG9zLnBhdGguam9pbihkZXN0
ZGlyLCBkZXN0c3VmZml4KQ0KPiAgICAgICAgICBpZiBvcy5wYXRoLmV4aXN0cyhkZXN0ZGlyKToN
Cj4gICAgICAgICAgICAgIGJiLnV0aWxzLnBydW5lZGlyKGRlc3RkaXIpDQo+IEBAIC01NzQsNyAr
NTc0LDcgQEAgY2xhc3MgR2l0KEZldGNoTWV0aG9kKToNCj4gICAgICAgICAgICAgIHVzZXJuYW1l
ID0gdWQudXNlciArICdAJw0KPiAgICAgICAgICBlbHNlOg0KPiAgICAgICAgICAgICAgdXNlcm5h
bWUgPSAiIg0KPiAtICAgICAgICByZXR1cm4gIiVzOi8vJXMlcyVzIiAlICh1ZC5wcm90bywgdXNl
cm5hbWUsIHVkLmhvc3QsDQo+IHVkLnBhdGgpDQo+ICsgICAgICAgIHJldHVybiAiJXM6Ly8lcyVz
JXMiICUgKHVkLnByb3RvLCB1c2VybmFtZSwgdWQuaG9zdCwNCj4gdWQucGF0aC5yZXBsYWNlKCIg
IiwgIiUyMCIpKQ0KPiAgDQo+ICAgICAgZGVmIF9yZXZpc2lvbl9rZXkoc2VsZiwgdWQsIGQsIG5h
bWUpOg0KPiAgICAgICAgICAiIiINCj4gLS0gDQo+IDIuMjIuMC53aW5kb3dzLjENCj4gDQo=

