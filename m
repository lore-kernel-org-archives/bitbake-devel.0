Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E1C433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 14:11:30 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.10934.1636639885361208530
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 06:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=Xa//Xgl5;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636639885;
  x=1668175885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oayd5XAeIrg6zXPeo0EvVRS/GGTUEJhz8nqvyckwalY=;
  b=Xa//Xgl5yDmO3Ov/JD+krs8pXSLv+DgOZnaNB+gmOGkU07mRC50G90bm
   vQ3NO2/Z4GDCmGWdf37VFIK5gBehTY5fm+XwKHJIWsmihn3D70U0KzBnh
   bzYjHK20Ea2aab5RCUN2GT7NWDSxlV5MkKTDO3A7dZPQaItuWwirmsQRE
   wfd58yeqo0VO1kft+e2+y+Yq+ynsc3g631/+q7L00o4BzSRKsb3k3yGVt
   rmd9hwiW411nG2R5qg+UnP04SA3cTH2DKZo3DtpuWuPAeHGZgjGxrq2y3
   k/c3EZAs29A+KKg2zdXlePp4eD5Fi2HyDbrLzNMjibYxEz2ZWkWa6mxoi
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	<kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: 
 AQHX0klyDNlqBsVJg0ODnUI5/vjSvKv03rAAgAADRwCAAAYOAIABSAmAgATTzYCAAnMggIAAmsEAgAAm3FD///xLgIAAMIdA
Date: Thu, 11 Nov 2021 14:11:22 +0000
Message-ID: <64e41080db7642d0b54818bdcf916dac@axis.com>
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
In-Reply-To: <e0ac884bc63e94e0c01a020ef178b7358779776b.camel@iris-sensing.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 14:11:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13024

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNwZXIgT3JzY2h1bGtvIDxK
YXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vuc2luZy5jb20+DQo+IFNlbnQ6IGRlbiAxMSBub3ZlbWJl
ciAyMDIxIDEzOjEwDQo+IFRvOiByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnOyBv
cGVuZW1iZWRkZWQtDQo+IGNvcmVAbGlzdHMub3BlbmVtYmVkZGVkLm9yZzsga3dlaWhtYW5uQG91
dGxvb2suY29tOyBQZXRlciBLamVsbGVyc3RlZHQNCj4gPHBldGVyLmtqZWxsZXJzdGVkdEBheGlz
LmNvbT47IGphc3BlckBmYW5jeWRvbWFpbi5ldQ0KPiBDYzogbWFydGluQG1rby5kZXY7IERhbmll
bCBCYXVtZ2FydCA8RGFuaWVsLkJhdW1nYXJ0QGlyaXMtc2Vuc2luZy5jb20+Ow0KPiBiaXRiYWtl
LWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRl
dmVsXSBbb2UtY29yZV1bUEFUQ0ggMS8yXSBkZXZ0b29sczogSW5pdGlhbCByZWNpcGUNCj4gZm9y
IHJlcG8gMi4xNy4zDQo+IA0KPiAtLS0tLUJFR0lOIFBHUCBTSUdORUQgTUVTU0FHRS0tLS0tDQo+
IEhhc2g6IFNIQTI1Ng0KPiANCj4gSGkgUGV0ZXIsDQo+IA0KPiA+IEhvd2V2ZXIsIHRoaXMgbWVh
bnMNCj4gPiB0aGF0IG9ubHkgdGhlIHNvdXJjZSBmb3IgdGhlIHJlcG8gd3JhcHBlciBpcyBhdmFp
bGFibGUgaW4gRExfRElSLiBTbw0KPiA+IHdoZW4gdGhlIHJlcG8gd3JhcHBlciBleGVjdXRlcyBp
dCB3aWxsIHRyeSB0byBnbyBvbiB0aGUgSW50ZXJuZXQgdG8NCj4gPiBmZXRjaCB0aGUgcmVzdCBv
ZiB0aGUgcmVwbyBzb3VyY2UsIHdoaWNoIHdpbGwgZmFpbC4NCj4gDQo+IGp1c3QgdG8gY2xlYXJp
Znk6IEFyZSB3ZSB0YWxraW5nIGFib3V0IGluc3RhbGxpbmcgcmVwbyBvbiBhIHRhcmdldCwgb3IN
Cj4gYXJlIHdlIHRhbGtpbmcgYWJvdXQgdGhlIHJlcG8gZmV0Y2hlcj8NCg0KVGhlIHJlcG8gZmV0
Y2hlciwgaS5lLiwgd2hlbiByZXBvIGlzIHVzZWQgYnkgYml0YmFrZS4NCg0KPiBXaGVuIGluc3Rh
bGxpbmcgcmVwbyBvbiB0aGUgdGFyZ2V0LCB3ZSBkbyBub3QgY2FsbCBhbnkgInJlcG8iIGNvbW1h
bmQNCj4gd2l0aGluIHRoZSBiaXRiYWtlIGJ1aWxkIHByb2Nlc3MuIFdlIGp1c3QgY2xvbmUgdGhl
IGdpdCByZXBvIGNvbnRhaW5pbmcNCj4gdGhlIHdyYXBwZXIgc2NyaXB0IGFuZCBpbnN0YWxsIHRo
ZSB3cmFwcGVyIHNjcmlwdCBpbnRvIHRoZSBzeXNyb290LiBBdA0KPiB0aGF0IHBvaW50IHRoZSBi
aXRiYWtlIGJ1aWxkIHByb2Nlc3MgaXMgZmluaXNoZWQgYW5kIHRoZSB1c2VyIGVuZHMgdXANCj4g
d2l0aCBqdXN0IHRoZSB3cmFwcGVyIHNjcmlwdCBvbiBoaXMgZGV2aWNlLiBKdXN0IGFzIGhlIHdv
dWxkIHdoZW4NCj4gaW5zdGFsbGluZyByZXBvIGZyb20gdGhlIHN5c3RlbSByZXBvc2l0b3JpZXMg
b24gZGViaWFuLCBhcmNoLCBldGMuDQo+IA0KPiBXaGVuIHVzaW5nIHRoZSBmZXRjaGVyLCB0aGUg
cmVwbyBzb3VyY2VzIGFyZSBmZXRjaGVkIGR1cmluZyB0aGUgaW5pdGlhbA0KPiBkb19mZXRjaCAo
dGhpcyBhbHNvIHdvcmtzIHdpdGggYGJpdGJha2UgLS1ydW5vbmx5PWRvX2ZldGNoYCkgYW5kIHBs
YWNlZA0KPiBpbnRvIHRoZSBETF9ESVIgKGluIHRoZSAucmVwbyBmb2xkZXIsIG5leHQgdG8gdGhl
IHNvdXJjZXMgYXMgZGVzY3JpYmVkDQo+IGluIHRoZSByZXBvIG1hbmlmZXN0KS4gU28gdW5sZXNz
IHRoZSB1c2VyIGNoYW5nZXMgc29tZXRoaW5nIGZldGNoZXINCj4gcmVsYXRlZCBpbiB0aGUgcmVj
aXBlIG9yIGRlbGV0ZXMgaGlzIERMX0RJUiwgaGUgY2FuIHVzZSB0aGlzIGJ1aWxkDQo+IGVudmly
b25tZW50IGZvciBhbiBvZmZsaW5lIGJ1aWxkLg0KDQpIb3cgY2FuIGl0IHdvcms/IFRoZSByZXBv
IHNvdXJjZSwgd2hpY2ggaXMgZmV0Y2hlZCBieSB0aGUgcmVwbyB3cmFwcGVyLCANCndpbGwgbm90
IGJlIGluIERMX0RJUiBvciBoYW5kbGVkIGJ5IGJpdGJha2UgYXQgYWxsLiBUaGlzIG1lYW5zIHRo
ZSANCnJlcG8gd3JhcHBlciB3aWxsIHRyeSB0byBjb250YWN0IGdvb2dsZXNvdXJjZS5jb20gZGly
ZWN0bHkgYW5kIGZldGNoIGl0IA0Kd2hlbiBpdCBpcyBydW4gYnkgYml0YmFrZSwgd2hpY2ggY2Fu
bm90IHdvcmsgc2luY2UgdGhlIGhvc3QgaXMgDQpkaXNjb25uZWN0ZWQgZnJvbSB0aGUgbmV0d29y
ay4gSG93IG9yIGZyb20gd2hlcmUgd291bGQgaXQgYmUgYWJsZSB0byANCmdldCB0aGUgc291cmNl
cyBpdCBuZWVkcz8NCg0KPiBZb3UgY2FuIHRyeSB0aGlzIGZvciB5b3Vyc2VsZiwgaWYgeW91IGxp
a2U6DQo+IA0KPiAxKSBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vSmFzcGVyLUJlbi9kZW1vLWth
cw0KPiAyKSAod2l0aCBkb2NrZXIgYW5kIGRvY2tlci1jb21wb3NlIGluc3RhbGxlZCkgcnVuIGBt
YWtlIG9mZmxpbmUtYnVpbGRgDQo+IA0KPiAtIC0tDQo+IFdpdGggYmVzdCByZWdhcmRzDQo+IA0K
PiBKYXNwZXIgT3JzY2h1bGtvDQo+IERldk9wcyBFbmdpbmVlcg0KPiANCj4gVGVsLiArNDkgMzAg
NTggNTggMTQgMjY1DQo+IEZheCArNDkgMzAgNTggNTggMTQgOTk5DQo+IEphc3Blci5PcnNjaHVs
a29AaXJpcy1zZW5zaW5nLmNvbQ0KPiANCj4g4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAog0KPiANCj4gaXJpcy1HbWJIDQo+IGluZnJhcmVkICYgaW50ZWxsaWdl
bnQgc2Vuc29ycw0KPiBTY2huZWxsZXJzdHJhw59lIDEtNSB8IDEyNDM5IEJlcmxpbg0KPiANCj4g
aHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0KDQovL1BldGVyDQoNCg==

