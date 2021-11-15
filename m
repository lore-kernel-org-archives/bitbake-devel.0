Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C41C4332F
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 12:59:49 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web10.21772.1636981187965248396
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 04:59:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id F403331E0348;
	Mon, 15 Nov 2021 13:59:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Mon, 15 Nov 2021 13:59:44 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id D6B3E31E033F;
	Mon, 15 Nov 2021 13:59:44 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Mon, 15 Nov 2021 13:59:44 +0100
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
 AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIABSAqAgATTzgCAAmPRAIAAqg6AgAAZFICAAAoTAIAAIckAgAAP84CAAEZSAIAF3wiA
Date: Mon, 15 Nov 2021 12:59:43 +0000
Message-ID: <2a8ac0a3f85436df2651d4388569dda36a7bfca8.camel@iris-sensing.com>
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
Content-ID: <CB1864C904315C428CB0DB9CEAD5D95C@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Nov 2021 12:59:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13045

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkhpIEFs
ZXhhbmRlciwNCg0KIltQQVRDSCB2M10gZmV0Y2gyL3JlcG86IEltcGxlbWVudCBBVVRPUkVWIGZv
ciByZXBvIGZldGNoZXIiIGNvbnRhaW5zIGENCmZpeCBmb3IgdGhpcyBpc3N1ZS4gUmVwcm9kdWNp
bmcgYSBidWlsZCBvZmZsaW5lIHdpdGggb25seSB0aGUgRExfRElSDQpzaG91bGQgd29yayBub3cu
DQoNCldlIGFyZSBjdXJyZW50bHkgc3RpbGwgbGFja2luZyB0aGUgYXBwcm9wcmlhdGUgdGVzdHMg
Zm9yIHRoZSBmZXRjaGVyLg0KVGhlc2Ugd2lsbCBmb2xsb3cgc29vbi4NCg0KLSAtLSANCldpdGgg
YmVzdCByZWdhcmRzDQoNCkphc3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdpbmVlcg0KDQpUZWwu
ICs0OSAzMCA1OCA1OCAxNCAyNjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5DQpKYXNwZXIuT3Jz
Y2h1bGtvQGlyaXMtc2Vuc2luZy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAog0KDQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50ZWxsaWdlbnQgc2Vu
c29ycw0KU2NobmVsbGVyc3RyYcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0KaHR0cHM6Ly9pcmlz
LXNlbnNpbmcuY29tLw0KDQoNCg0KDQoNCk9uIFRodSwgMjAyMS0xMS0xMSBhdCAyMDoyMCArMDEw
MCwgQWxleGFuZGVyIEthbmF2aW4gd3JvdGU6DQo+IE9uIFRodSwgMTEgTm92IDIwMjEgYXQgMTY6
MDgsIEphc3BlciBPcnNjaHVsa28NCj4gPEphc3Blci5PcnNjaHVsa29AaXJpcy1zZW5zaW5nLmNv
bT4gd3JvdGU6DQo+ID4gU28gaWYgeW91IGhhdmUgZG9uZSB0aGlzIGluaXRpYWwgZmV0Y2ggb2Yg
eW91ciBzb3VyY2VzIGFuZCBzdGFzaA0KPiA+IHlvdXINCj4gPiB3b3JraW5nIGRpciBhd2F5LCB5
b3UgY2FuIGRvIGFuIG9mZmxpbmUgYnVpbGQuDQo+IA0KPiBCdXQgY2FuIHlvdSBkbyBhbiBvZmZs
aW5lIGJ1aWxkIHdpdGhvdXQgYSBwcmVwb3B1bGF0ZWQgd29ya2luZyBkaXI/DQo+IFRoYXQncyB0
aGUgY3J1Y2lhbCBwb2ludDogb2ZmbGluZSBidWlsZCBzaG91bGQgd29yayBpbiBhIGZyZXNobHkg
c2V0DQo+IHVwIGJ1aWxkIGRpcmVjdG9yeSwgd2l0aG91dCBzc3RhdGUgY2FjaGUsIGFuZCB3aXRo
IHByZXBvcHVsYXRlZA0KPiBETF9ESVIgb25seS4NCj4gDQo+IEFsZXgNCi0tLS0tQkVHSU4gUEdQ
IFNJR05BVFVSRS0tLS0tDQoNCmlRRXpCQUVCQ0FBZEZpRUU0V3lQTUlDNUFwNCtPb28xWWdxZXcw
N1ZNTlVGQW1HU1diNEFDZ2tRWWdxZXcwN1YNCk1OVlVZUWdBZ0E2KzhYSStKeHRBNTMyRk5OSU1B
Wkc1WkdaMTJHS3ZWa2pvSkVybnpSZjBSWnhVRzNVeU5ZbW0NCnBTRGNmYnVvZEJtQmJIeERCcE44
VnNwVG9LWnk4ZEtjbS9qZmU5VVk3ZjlVMzliWlNOWFNTM2hOUHFrcUtQNUoNCmpDZzF6UWZ4amJX
MWFWU0hKa1FCNU1vWS9FRGVvUVZ2N1JJNlJtY1ZzTEpaeG96UGVZYU9RV1NkVE5HLzdjemcNCm9G
aktyNmp0U09ZTzQ1dGVNR3QzKzIrQXRBWGhselRnS1pvMzNyWC90a25TN2YxK2treU5HTHYwc3NT
UDVKY2YNCkJkOFliY2RHOWxxWEtVbzBBN3JuOVE4M1lCZHBJeUE2K0J5MTU5enpQeTdiUDhqOWFx
TUg4bk5XYXVhaGhjRlMNCnNZMzlmaWt5NTdhRWdNZTdnMU9aWDhvUk9Eb3dQQT09DQo9aHBBSw0K
LS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=

