Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423EDC433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:53:10 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web11.6674.1636123988845082157
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:53:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id AB61631E0348;
	Fri,  5 Nov 2021 15:53:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Fri,  5 Nov 2021 15:53:05 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 8FA6D31E033F;
	Fri,  5 Nov 2021 15:53:05 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Fri, 5 Nov 2021 15:53:04 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	<kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.net"
	<Daniel.Baumgart@iris-sensing.net>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIAAA0EAgAAJDgA=
Date: Fri, 5 Nov 2021 14:53:03 +0000
Message-ID: <ce7b4cd1e4f0be2c72766fa3098fa03834c3d391.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <AM9PR09MB4642B8B561D87758C3423C60A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
In-Reply-To: 
 <AM9PR09MB4642B8B561D87758C3423C60A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B931F9F55BE9A4D916CD141E9394FB9@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:53:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12904

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCj4gT2th
eSBmaW5lIHRoYXQgbWFrZXMgc2Vuc2UsIGV2ZW4gaWYgaXQgaXMgc3RpbGwgcGhvbmluZyBob21l
Lg0KVHJ1ZS4gQmFkIHNvZnR3YXJlIGRlc2lnbiBhdCBiZXN0LiBCdXQgbHVja2lseSBub3QgYW4g
aXNzdWUgZnJvbSBhDQpidWlsZCBzeXN0ZW0gcGVyc3BlY3RpdmUuIDopDQoNCj4gQW5vdGhlciB0
aGluZywgY291bGQgeW91IHBsZWFzZSBleGNoYW5nZSAiK1JFUE9fUkVWID0gJ3YyLjE3LjMnIiBm
b3INCj4gYSANCj4gU0hBIHJldmlzaW9uLCBhcyBJIHdvdWxkbid0IGJldCBteSBsaWZlIG9uIGdv
b2dsZSBub3QNCj4gZGVsZXRpbmcvcmVtb3ZpbmcgDQo+IHRhZ3MgZnJvbSB0aGVpciByZXBvcyAt
IGFuZCB1bnBsZWFzYW50bHkgd2Ugd291bGRuJ3QgZXZlbiBub3RpY2UgdGhhdA0KPiBlYXNpbHkN
Cg0KRmFpciBwb2ludCwgd2lsbCBkbyENCg0KLSAtLSANCldpdGggYmVzdCByZWdhcmRzDQoNCkph
c3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdpbmVlcg0KDQpUZWwuICs0OSAzMCA1OCA1OCAxNCAy
NjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5DQpKYXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vuc2lu
Zy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg
4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAog0K
DQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50ZWxsaWdlbnQgc2Vuc29ycw0KU2NobmVsbGVyc3Ry
YcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0KaHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0KDQoN
Cg0KDQoNCk9uIEZyaSwgMjAyMS0xMS0wNSBhdCAxNToyMCArMDEwMCwgS29ucmFkIFdlaWhtYW5u
IHdyb3RlOg0KPiANCj4gDQo+IE9uIDA1LjExLjIxIDE1OjA5LCBKYXNwZXIgT3JzY2h1bGtvIHdy
b3RlOg0KPiA+IEFjdHVhbGx5LCBJIGRvbid0IGJlbGlldmUgdGhpcyB0byBiZSBhbiBpc3N1ZSBm
b3IgdGhlIGZvbGxvd2luZw0KPiA+IHJlYXNvbnM6DQo+ID4gDQo+ID4gMS4gVGhlIHJlY2lwZSBk
b2VzIG5vdGhpbmcgbW9yZSB0aGFuIHRha2luZyB0aGUgd3JhcHBlciBzY3JpcHQgYXMgaXMNCj4g
PiBhbmQgY29weWluZyBpdCB0byB0aGUgc3lzcm9vdC4gQXMgdGhlIHJlcG8gYmluYXJ5IGlzIG5l
dmVyIGNhbGxlZA0KPiA+IHdoZW4NCj4gPiBidWlsZGluZywgaXQgZG9lcyBub3QgaGF2ZSB0aGUg
ImNoYW5jZSIgdG8gbG9vayBmb3IgYW4gdXBkYXRlIGR1cmluZw0KPiA+IHRoZSB5b2N0byBvZmZs
aW5lIGJ1aWxkIHByb2Nlc3MuIFRoZSBvdXRjb21lIG9mIGFuIG9mZmxpbmUgYnVpbGQgaXMNCj4g
PiB0aGVyZWZvcmUgcHJlZGljdGFibGUuDQo+ID4gDQo+ID4gMi4gV2hlbiB1c2luZyByZXBvIHdp
dGhpbiB0aGUgeW9jdG8gYnVpbGQgaXRzZWxmICh3aXRoIHRoZSByZXBvDQo+ID4gZmV0Y2hlciks
IHRoZSByZXBvIGJpbmFyeSBpcyBvbmx5IGV2ZXIgY2FsbGVkIGR1cmluZyB0aGUgZG9fZmV0Y2gN
Cj4gPiBzdGVwLA0KPiA+IHdoaWNoIG9idmlvdXNseSBoYXMgbm8gaXNzdWVzIHdpdGggYW55IG5l
dHdvcmsgYWNjZXNzLg0KPiA+IA0KPiDCoD4NCj4gDQo+IE9rYXkgZmluZSB0aGF0IG1ha2VzIHNl
bnNlLCBldmVuIGlmIGl0IGlzIHN0aWxsIHBob25pbmcgaG9tZS4NCj4gQW5vdGhlciB0aGluZywg
Y291bGQgeW91IHBsZWFzZSBleGNoYW5nZSAiK1JFUE9fUkVWID0gJ3YyLjE3LjMnIiBmb3IgYSAN
Cj4gU0hBIHJldmlzaW9uLCBhcyBJIHdvdWxkbid0IGJldCBteSBsaWZlIG9uIGdvb2dsZSBub3Qg
ZGVsZXRpbmcvcmVtb3ZpbmcNCj4gdGFncyBmcm9tIHRoZWlyIHJlcG9zIC0gYW5kIHVucGxlYXNh
bnRseSB3ZSB3b3VsZG4ndCBldmVuIG5vdGljZSB0aGF0DQo+IGVhc2lseQ0KLS0tLS1CRUdJTiBQ
R1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBRUJDQUFkRmlFRTRXeVBNSUM1QXA0K09vbzFZZ3Fl
dzA3Vk1OVUZBbUdGUlU0QUNna1FZZ3FldzA3Vg0KTU5YM3l3ZitNUUF3bUg5VFZGMGl6ZlZWSVlo
d2lUQVNnWkxsRzBwd01CWGZRdzZpSWVXQVhtTzhMY2NKTnJ3Yg0KZmNlVk1GRlhQaTEvMlNqQWRq
aE96emg1WDd1U0diY1ZUMEcxM1JwZXVZZnNudTdIeUozbjZUQWR6b1hpUXROYQ0KUHFKcVBWc1pC
RUlwSGlsVFlFWnFQdS9FTkhOcTc0U2ovc1FYcU0wWGpOTVRhSktLVzdTeWM5amJHZEVkbitNVg0K
Z1U5aU5JUW1ZV0VQU1VTMlRwK2xnRmg5eEMzcVFPUUpaUHBjSjVWM2hXZkFJaWJhUk1lZDRrR2Rk
M21sSnNZag0KL0FvcSs3Z1hlMWlaT1hCN094WFgrYms3dWVvSENucDdRVVB5V0ZWeHNsS3gvci9m
YUgrZitQd0htSkhacDBWRA0KZ09yemJqYUlLMkUyQ1ZuUm9iYU9rU2tuSWZmSnpRPT0NCj1UZnor
DQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

