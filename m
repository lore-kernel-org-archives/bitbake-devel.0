Return-Path: <raphael.lisicki@siemens.com>
X-Greylist: delayed 100992 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 16 Mar 2019 09:47:14 UTC
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr00057.outbound.protection.outlook.com [40.107.0.57])
	by mail.openembedded.org (Postfix) with ESMTP id 9F6756C10B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Mar 2019 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=siemens.onmicrosoft.com; s=selector1-siemens-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=smCPFEKhTdOyYMo6/R87i4YFfmOHGBvmdbIJ3+Q6E3Q=;
	b=g6I85jBcdNh93nvQ4A6QgDo0pofHqUydAl5646vgDPO4tJSGL1WTNEeYxTfstTRa3CazuB9AhU2NVBT8GNKVjIAop4emgDNRIH80kNbpYl7JnrAnpa2G52r8KbkawZ0+AU4G1lcnaBiuplCz8F3OhwRzuM1Uvzfut8xlFNkvyGw=
Received: from AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM (10.161.65.156) by
	AM5PR10MB1587.EURPRD10.PROD.OUTLOOK.COM (10.161.64.140) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1709.13; Thu, 14 Mar 2019 12:34:35 +0000
Received: from AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM
	([fe80::2d6f:54fd:9102:60c2]) by
	AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM
	([fe80::2d6f:54fd:9102:60c2%5]) with mapi id 15.20.1709.011;
	Thu, 14 Mar 2019 12:34:35 +0000
From: "Lisicki, Raphael" <raphael.lisicki@siemens.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 4/5] fetch2/gitsm: Add clean function
Thread-Index: AQHU2kWzjFyNZAaxT0OCkhQHkIDTGKYLD4aA
Date: Thu, 14 Mar 2019 12:34:35 +0000
Message-ID: <AM5PR10MB18437E4D46F44792D2685E9AEC4B0@AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
In-Reply-To: <8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=raphael.lisicki@siemens.com; 
x-originating-ip: [80.146.228.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb05fa91-07d7-4dfc-16d1-08d6a8796ac1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR10MB1587; 
X-MS-TrafficTypeDiagnostic: AM5PR10MB1587:|AM5PR10MB1587:|AM5PR10MB1587:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM5PR10MB15870BCDDCAA6ECE6D3544D5EC4B0@AM5PR10MB1587.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(13464003)(33656002)(53936002)(25786009)(3846002)(6116002)(106356001)(66066001)(2906002)(6436002)(99286004)(9686003)(105586002)(52536014)(5660300002)(6306002)(2501003)(55016002)(71200400001)(229853002)(6246003)(74316002)(110136005)(316002)(478600001)(186003)(26005)(102836004)(305945005)(256004)(7696005)(76176011)(6506007)(486006)(53546011)(966005)(476003)(11346002)(14444005)(446003)(86362001)(7736002)(14454004)(71190400001)(8936002)(81156014)(81166006)(8676002)(68736007)(97736004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR10MB1587;
	H:AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: siemens.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: frx8qEpn9P8POB4k4ahyXEHQuyzys7xgFt60zEvhOc90S4LIsQn1xk3XrVweFNWVlGbWSH19M/udX6IfDDOEEqLJ3+8rPHMomlrTSgY3uzVekLmukuMpGloQWu6wHdOD5FBUdYZ7tn8tfIWptTrj9sst3QonQAO+LS5Kfq1b5gbi0w87gN7IwVtg465bDaMDfWgXWaVoRbZ8uGD9c0t/q5H0EGmQg8RzsXw9z6+pTgqjRRH66MMtgSxAU5GRyAOC1l7OVstZWXQtXXul+Bcd9jdGYv+GI73wvx6plvtTv5+GetUkTRQ8b/ghfyWcc02ycwT2oKVydHrysrTvx7DFdFSf2tFe+aCSQkDshjlpb85kWfRziHwpGwXy4z95zpJCiB9QbpIhqTHfyV88mx8wezOH/cvkOcLg6HXWArXysRY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb05fa91-07d7-4dfc-16d1-08d6a8796ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 12:34:35.3311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1587
X-OriginatorOrg: siemens.com
Subject: Re: [PATCH 4/5] fetch2/gitsm: Add clean function
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
X-List-Received-Date: Sat, 16 Mar 2019 09:47:15 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBoYXZlIG5vdCBmdWxseSB1bmRlcnN0YW5kIHRoZSBsb2dpYyBidXQgSSBhbSB3b25kZXJpbmcg
d2hhdCBoYXBwZW5zIGhlcmUgaXMgYSBzdWJtb2R1bGUgaXMgbG9jYXRlZCBpbiB0d28gZGlmZmVy
ZW50IHJlcG9zaXRvcmllcz8gV291bGRuJ3QgYSBjbGVhbiBvZiBvbmUgbW9kdWxlIGRlbGV0ZSBz
dWJtb2R1bGVzIG9mIHRoZSBvdGhlciBvbmUgYXMgd2VsbD8NCg0KQmVzdCByZWdhcmRzDQpSYXBo
YWVsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYml0YmFrZS1kZXZl
bC1ib3VuY2VzQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWwtDQo+IGJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gT24gQmVoYWxmIE9mIFJvYmVydCBZYW5nDQo+IFNl
bnQ6IFRodXJzZGF5LCBNYXJjaCAxNCwgMjAxOSAxMDoyOCBBTQ0KPiBUbzogYml0YmFrZS1kZXZl
bEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFtiaXRiYWtlLWRldmVsXSBbUEFU
Q0ggNC81XSBmZXRjaDIvZ2l0c206IEFkZCBjbGVhbiBmdW5jdGlvbg0KPiANCj4gVGhlIGdpdCdz
IGNsZWFuIGNhbiBvbmx5IHJlbW92ZSBwYXJlbnQgZ2l0IHJlcG8gZnJvbSBETF9ESVIsIGJ1dCBk
b2Vzbid0DQo+IHJlbW92ZQ0KPiBzdWJtb2R1bGVzLCB0aGlzIHBhdGNoIGZpeGVzIHRoZSBwcm9i
bGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IFlhbmcgPGxpZXpoaS55YW5nQHdpbmRy
aXZlci5jb20+DQo+IC0tLQ0KPiAgYml0YmFrZS9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5IHwgMTUg
KysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0
c20ucHkgYi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0c20ucHkNCj4gaW5kZXggYjIxZmVkMi4u
YmI2MTA5MyAxMDA2NDQNCj4gLS0tIGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5DQo+
ICsrKyBiL2JpdGJha2UvbGliL2JiL2ZldGNoMi9naXRzbS5weQ0KPiBAQCAtNzYsOCArNzYsOCBA
QCBjbGFzcyBHaXRTTShHaXQpOg0KPiAgICAgICAgICBmb3IgbmFtZSBpbiB1ZC5uYW1lczoNCj4g
ICAgICAgICAgICAgIHRyeToNCj4gICAgICAgICAgICAgICAgICBnaXRtb2R1bGVzID0gcnVuZmV0
Y2hjbWQoIiVzIHNob3cgJXM6LmdpdG1vZHVsZXMiICUNCj4gKHVkLmJhc2VjbWQsIHVkLnJldmlz
aW9uc1tuYW1lXSksIGQsIHF1aWV0PVRydWUsIHdvcmtkaXI9d29ya2RpcikNCj4gLSAgICAgICAg
ICAgIGV4Y2VwdDoNCj4gLSAgICAgICAgICAgICAgICAjIE5vIHN1Ym1vZHVsZXMgdG8gdXBkYXRl
DQo+ICsgICAgICAgICAgICBleGNlcHQgRXhjZXB0aW9uIGFzIGVzYzoNCj4gKyAgICAgICAgICAg
ICAgICBsb2dnZXIuaW5mbygiTm8gc3VibW9kdWxlcyBmb3VuZDogJXMiICUgd29ya2RpcikNCj4g
ICAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiANCj4gICAgICAgICAgICAgIGZvciBtLCBtZCBp
biBwYXJzZV9naXRtb2R1bGVzKGdpdG1vZHVsZXMpLml0ZW1zKCk6DQo+IEBAIC0xNjQsNiArMTY0
LDE3IEBAIGNsYXNzIEdpdFNNKEdpdCk6DQo+ICAgICAgICAgIEdpdC5kb3dubG9hZChzZWxmLCB1
ZCwgZCkNCj4gICAgICAgICAgc2VsZi5wcm9jZXNzX3N1Ym1vZHVsZXModWQsIHVkLmNsb25lZGly
LCBkb3dubG9hZF9zdWJtb2R1bGUsIGQpDQo+IA0KPiArICAgIGRlZiBjbGVhbihzZWxmLCB1ZCwg
ZCk6DQo+ICsgICAgICAgIGRlZiBjbGVhbl9zdWJtb2R1bGUodWQsIHVybCwgbW9kdWxlLCBtb2Rw
YXRoLCBkKToNCj4gKyAgICAgICAgICAgIHRyeToNCj4gKyAgICAgICAgICAgICAgICBuZXdmZXRj
aCA9IEZldGNoKFt1cmxdLCBkLCBjYWNoZT1GYWxzZSkNCj4gKyAgICAgICAgICAgICAgICBuZXdm
ZXRjaC5jbGVhbigpDQo+ICsgICAgICAgICAgICBleGNlcHQgRXhjZXB0aW9uIGFzIGU6DQo+ICsg
ICAgICAgICAgICAgICAgbG9nZ2VyLndhcm4oJ2dpdHNtOiBzdWJtb2R1bGUgY2xlYW4gZmFpbGVk
OiAlcyAlcycgJQ0KPiAodHlwZShlKS5fX25hbWVfXywgc3RyKGUpKSkNCj4gKw0KPiArICAgICAg
ICBzZWxmLnByb2Nlc3Nfc3VibW9kdWxlcyh1ZCwgdWQuY2xvbmVkaXIsIGNsZWFuX3N1Ym1vZHVs
ZSwgZCkNCj4gKyAgICAgICAgR2l0LmNsZWFuKHNlbGYsIHVkLCBkKQ0KPiArDQo+ICAgICAgZGVm
IHVucGFjayhzZWxmLCB1ZCwgZGVzdGRpciwgZCk6DQo+ICAgICAgICAgIGRlZiB1bnBhY2tfc3Vi
bW9kdWxlcyh1ZCwgdXJsLCBtb2R1bGUsIG1vZHBhdGgsIGQpOg0KPiAgICAgICAgICAgICAgdXJs
ICs9ICI7YmFyZWNsb25lPTE7bm9icmFuY2g9MSINCj4gLS0NCj4gMi43LjQNCj4gDQo+IC0tDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGJpdGJh
a2UtZGV2ZWwgbWFpbGluZyBsaXN0DQo+IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBodHRwOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Jp
dGJha2UtZGV2ZWwNCg==

