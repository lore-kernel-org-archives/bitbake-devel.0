Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C885C433FE
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 23:56:02 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.3644.1636588560172782996
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 15:56:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=m5GNscsa;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636588560;
  x=1668124560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgXb3wo5NFLVA4nhnfD96FfbDPsmL4eykGPt0QOOw34=;
  b=m5GNscsacUv+BWR2kLC3n36hu0ruFNfisQZK/yfM3UMjZTW7fCxRpOtc
   UzRu/OHJhchcSXzobLVKeqcudWv49AgnpOw+UHQx7nLk4fhWXLbXUJ7DJ
   VCXe7FlpLBnYfIJ5eKeay75llW3HxmGlJWcqAUq8hTpvOeLGechQ0kX9z
   AqGUNn680fUIfJy11R6IJvlB5IXjjdwsujtcsaIlXycbHXuheGl7pj2Ln
   beF8XflYJQpuMq3aSq1yc0SAMNIfiJzNoIUKHPRATEBEn8OycxXk8057Z
   HmmdXeEFFZLBVc+bOO+SmWl9ThM864cgW/M4W6Zjcqh71ABBxF+0DZ/E0
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	<kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.net"
	<Daniel.Baumgart@iris-sensing.net>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: 
 AQHX0klyDNlqBsVJg0ODnUI5/vjSvKv03rAAgAADRwCAAAYOAIABSAmAgATTzYCAAnMggA==
Date: Wed, 10 Nov 2021 23:55:58 +0000
Message-ID: <dd07e5137044429f805caf23114a2e72@axis.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
In-Reply-To: <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 23:56:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12996

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IE9uIEJlaGFsZiBPZiBKYXNwZXIgT3JzY2h1bGtvDQo+IFNlbnQ6IGRlbiA5IG5vdmVtYmVy
IDIwMjEgMTI6MjYNCj4gVG86IHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc7IG9w
ZW5lbWJlZGRlZC0NCj4gY29yZUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnOyBrd2VpaG1hbm5Ab3V0
bG9vay5jb207IGphc3BlckBmYW5jeWRvbWFpbi5ldQ0KPiBDYzogbWFydGluQG1rby5kZXY7IERh
bmllbC5CYXVtZ2FydEBpcmlzLXNlbnNpbmcubmV0OyBiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW29lLWNvcmVd
W1BBVENIIDEvMl0gZGV2dG9vbHM6IEluaXRpYWwgcmVjaXBlDQo+IGZvciByZXBvIDIuMTcuMw0K
PiANCj4gLS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KPiBIYXNoOiBTSEEyNTYN
Cj4gDQo+IEhpIFJpY2hhcmQsDQo+IA0KPiBJIHRoaW5rIG91ciBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgcmVwbyBmZXRjaGVyIGNoZWNrcyB0aGUgKHdoYXQgSQ0KPiBiZWxpZXZlIHRvIGJlKSBtb3N0
IHJlbGV2YW50IHBhcnRzIG9mIHlvdXIgY2hlY2tsaXN0ICh0aGFua3MgZm9yIHRoZQ0KPiB3cml0
ZS11cCkuIE1hcnRpbiwgcGxlYXNlIGNvcnJlbnQgbWUgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5n
Og0KPiANCj4gPiBhKSBuZXR3b3JrIGFjY2VzcyBmb3Igc291cmNlcyBpcyBvbmx5IGV4cGVjdGVk
IHRvIGhhcHBlbiBpbiB0aGUNCj4gPiBkb19mZXRjaCBzdGVwLg0KPiA+IFRoaXMgaXMgbm90IGVu
Zm9yY2VkIG9yIHRlc3RlZCBidXQgaXMgcmVxdWlyZWQgc28gdGhhdCB3ZSBjYW46DQo+ID4NCj4g
PiDCoGkpIGF1ZGl0IHRoZSBzb3VyY2VzIHVzZWQgKGkuZS4gZm9yIGxpY2Vuc2UvbWFuaWZlc3Qg
cmVhc29ucykNCj4gPiDCoGlpKSBzdXBwb3J0IG9mZmxpbmUgYnVpbGRzIHdpdGggYSBzdWl0YWJs
ZSBjYWNoZQ0KPiA+IMKgaWlpKSBhbGxvdyB3b3JrIHRvIGNvbnRpbnVlIGV2ZW4gd2l0aCBkb3du
dGltZSB1cHN0cmVhbQ0KPiA+IMKgaXYpIGFsbG93IGZvciBjaGFuZ2VzIHVwc3RyZWFtIGluIGlu
Y29tcGF0aWJsZSB3YXlzDQo+ID4gwqB2KSBhbGxvdyByZWJ1aWxkaW5nIG9mIHRoZSBzb2Z0d2Fy
ZSBpbiBYIHllYXJzIHRpbWUNCj4gDQo+IGNoZWNrDQo+IA0KPiA+IGIpIG5ldHdvcmsgYWNjZXNz
IGlzIG5vdCBleHBlY3RlZCBpbiBkb191bnBhY2sNCj4gDQo+IGNoZWNrDQoNCkhvdyBkbyB5b3Ug
YXZvaWQgdGhlIHJlcG8gd3JhcHBlciBmZXRjaGluZyB0aGUgcmVwbyBzb3VyY2UgaXRzZWxmIA0K
YW5kIGluc3RlYWQgZmV0Y2ggaXQgdXNpbmcgdGhlIGJpdGJha2UgZmV0Y2hlcj8gSSBoYXZlIHNl
ZW4gbm90aGluZyANCnRvIHRoYXQgZXh0ZW50IGluIHRoZSBwYXRjaGVzIHNvIGZhci4NCg0KLy9Q
ZXRlcg0KDQo=

