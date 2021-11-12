Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE044C433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 12:22:58 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web08.14937.1636719777657270645
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Nov 2021 04:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 6C3D131E034B;
	Fri, 12 Nov 2021 13:22:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Fri, 12 Nov 2021 13:22:54 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id C182731E0355;
	Fri, 12 Nov 2021 13:22:53 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Fri, 12 Nov 2021 13:22:53 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	"kweihmann@outlook.com" <kweihmann@outlook.com>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: 
 AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIABSAqAgATTzgCAAmPRAIAAqg6AgAAZFICAAAoTAIAAIckAgAAP84CAAEZSAIABHcAA
Date: Fri, 12 Nov 2021 12:22:52 +0000
Message-ID: <9cc55c0f408862bfcd23fe5f154c4b4a7f3ee2c8.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
	 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
	 <dd07e5137044429f805caf23114a2e72@axis.com>
	 <c1b45d484d3f55f9522cfa85c58e2acfa7d0e3f1.camel@iris-sensing.com>
	 <83886954b53b47eb93b6ab8a7feebf19@axis.com>
	 <e0ac884bc63e94e0c01a020ef178b7358779776b.camel@iris-sensing.com>
	 <64e41080db7642d0b54818bdcf916dac@axis.com>
	 <699b2927411dbdfdfd01e64ffb16dc057d5bb320.camel@iris-sensing.com>
	 <CANNYZj9LXZjLq9mTxJ7g0T1Zz0XzZHhjiNud9o_kAbuyVb76UA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9LXZjLq9mTxJ7g0T1Zz0XzZHhjiNud9o_kAbuyVb76UA@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F61CA1A677024F44BB5FF4138ACCDD19@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 12:22:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13034

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkhpIEFs
ZXgsDQoNCnRoYW5rcyBmb3IgeW91ciBpbnB1dC4gWW91IGFyZSBhYnNvbHV0ZWx5IGNvcnJlY3Qs
IHRoaXMgY3VycmVudGx5IGRvZXMNCm5vdCB3b3JrLiBXZSdsbCBsb29rIGludG8gdGhpcy4NCg0K
LSAtLSANCldpdGggYmVzdCByZWdhcmRzDQoNCkphc3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdp
bmVlcg0KDQpUZWwuICs0OSAzMCA1OCA1OCAxNCAyNjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5
DQpKYXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vuc2luZy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAog0KDQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50
ZWxsaWdlbnQgc2Vuc29ycw0KU2NobmVsbGVyc3RyYcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0K
aHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0KDQoNCg0KDQoNCk9uIFRodSwgMjAyMS0xMS0xMSBh
dCAyMDoyMCArMDEwMCwgQWxleGFuZGVyIEthbmF2aW4gd3JvdGU6DQo+IE9uIFRodSwgMTEgTm92
IDIwMjEgYXQgMTY6MDgsIEphc3BlciBPcnNjaHVsa28NCj4gPEphc3Blci5PcnNjaHVsa29AaXJp
cy1zZW5zaW5nLmNvbT4gd3JvdGU6DQo+ID4gU28gaWYgeW91IGhhdmUgZG9uZSB0aGlzIGluaXRp
YWwgZmV0Y2ggb2YgeW91ciBzb3VyY2VzIGFuZCBzdGFzaA0KPiA+IHlvdXINCj4gPiB3b3JraW5n
IGRpciBhd2F5LCB5b3UgY2FuIGRvIGFuIG9mZmxpbmUgYnVpbGQuDQo+IA0KPiBCdXQgY2FuIHlv
dSBkbyBhbiBvZmZsaW5lIGJ1aWxkIHdpdGhvdXQgYSBwcmVwb3B1bGF0ZWQgd29ya2luZyBkaXI/
DQo+IFRoYXQncyB0aGUgY3J1Y2lhbCBwb2ludDogb2ZmbGluZSBidWlsZCBzaG91bGQgd29yayBp
biBhIGZyZXNobHkgc2V0DQo+IHVwIGJ1aWxkIGRpcmVjdG9yeSwgd2l0aG91dCBzc3RhdGUgY2Fj
aGUsIGFuZCB3aXRoIHByZXBvcHVsYXRlZA0KPiBETF9ESVIgb25seS4NCj4gDQo+IEFsZXgNCi0t
LS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tDQoNCmlRRXpCQUVCQ0FBZEZpRUU0V3lQTUlDNUFw
NCtPb28xWWdxZXcwN1ZNTlVGQW1HT1hKd0FDZ2tRWWdxZXcwN1YNCk1OWGF4d2YrTkRPeDVUWVI0
ZFk0aUNzYjBJZmRmb0IwMStIN1VEWlIyczVHWktLQTlUeU1LYkVxQmRackhCZGoNClBUcVpKMzM5
SU9YQmxrczFLUEFVY2kwVk9YQmR3SG95YlIyWEZNR0VOVG5yajZYQSs5WXI5Nm9mU1BIcVFUV3IN
CmFtRC9sb3cwY0Z2ZnFaQ2xiK21kL0ZjeGhuVks0NXJGaGZMSmNrS0VsUGlZbUtqY2docy9QWEFX
YmgrVHc2UzcNCm01S0NxOGFnUHFYbmFVL2JXRG1qMmVDOXQ2dCtWVC8wT25DMHRRdG9oTWJZVmQ4
d3VsNGNmNUljM0ppbGVjakkNCnFDSDRySzdFQkZmeldoczFXVFlER2VYWDVpV05tWk9zZHVmcFhG
MFVSSmE1Y3BqR0E1YmhqZnlYam9VWlB6Q1INCld4RXJEMWNuUVNOUXF5c3FXbG5CNUVnTTN5K2NC
Zz09DQo9cTB6Wg0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=

