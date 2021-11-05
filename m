Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD3C433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:09:05 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web12.6058.1636121343828380437
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:09:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id AC3D431E034C;
	Fri,  5 Nov 2021 15:09:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Fri,  5 Nov 2021 15:09:01 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 8B86C31E033F;
	Fri,  5 Nov 2021 15:09:01 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Fri, 5 Nov 2021 15:09:01 +0100
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
Thread-Index: AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgA==
Date: Fri, 5 Nov 2021 14:09:00 +0000
Message-ID: <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
In-Reply-To: <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3D0EA0C9262F145A4AFCD8BDA9127D0@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:09:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12897

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkFjdHVh
bGx5LCBJIGRvbid0IGJlbGlldmUgdGhpcyB0byBiZSBhbiBpc3N1ZSBmb3IgdGhlIGZvbGxvd2lu
Zw0KcmVhc29uczoNCg0KMS4gVGhlIHJlY2lwZSBkb2VzIG5vdGhpbmcgbW9yZSB0aGFuIHRha2lu
ZyB0aGUgd3JhcHBlciBzY3JpcHQgYXMgaXMNCmFuZCBjb3B5aW5nIGl0IHRvIHRoZSBzeXNyb290
LiBBcyB0aGUgcmVwbyBiaW5hcnkgaXMgbmV2ZXIgY2FsbGVkIHdoZW4NCmJ1aWxkaW5nLCBpdCBk
b2VzIG5vdCBoYXZlIHRoZSAiY2hhbmNlIiB0byBsb29rIGZvciBhbiB1cGRhdGUgZHVyaW5nDQp0
aGUgeW9jdG8gb2ZmbGluZSBidWlsZCBwcm9jZXNzLiBUaGUgb3V0Y29tZSBvZiBhbiBvZmZsaW5l
IGJ1aWxkIGlzDQp0aGVyZWZvcmUgcHJlZGljdGFibGUuDQoNCjIuIFdoZW4gdXNpbmcgcmVwbyB3
aXRoaW4gdGhlIHlvY3RvIGJ1aWxkIGl0c2VsZiAod2l0aCB0aGUgcmVwbw0KZmV0Y2hlciksIHRo
ZSByZXBvIGJpbmFyeSBpcyBvbmx5IGV2ZXIgY2FsbGVkIGR1cmluZyB0aGUgZG9fZmV0Y2ggc3Rl
cCwNCndoaWNoIG9idmlvdXNseSBoYXMgbm8gaXNzdWVzIHdpdGggYW55IG5ldHdvcmsgYWNjZXNz
Lg0KDQotIC0tIA0KV2l0aCBiZXN0IHJlZ2FyZHMNCg0KSmFzcGVyIE9yc2NodWxrbw0KRGV2T3Bz
IEVuZ2luZWVyDQoNClRlbC4gKzQ5IDMwIDU4IDU4IDE0IDI2NQ0KRmF4ICs0OSAzMCA1OCA1OCAx
NCA5OTkNCkphc3Blci5PcnNjaHVsa29AaXJpcy1zZW5zaW5nLmNvbQ0KDQrigKIg4oCiIOKAoiDi
gKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiDQoNCmlyaXMtR21iSA0KaW5mcmFyZWQg
JiBpbnRlbGxpZ2VudCBzZW5zb3JzDQpTY2huZWxsZXJzdHJhw59lIDEtNSB8IDEyNDM5IEJlcmxp
bg0KDQpodHRwczovL2lyaXMtc2Vuc2luZy5jb20vDQoNCg0KDQoNCg0KT24gRnJpLCAyMDIxLTEx
LTA1IGF0IDE0OjQ3ICswMTAwLCBKYXNwZXIgT3JzY2h1bGtvIHdyb3RlOg0KPiBIaSBLb25yYWQs
DQo+IA0KPiB0aGF0IG1pZ2h0IGJlIGEgZ29vZCBwb2ludC4gSSBwYXRjaGVkIHRoZSBSRVBPX1JF
ViB0byBhIGZpeGVkIHJlZnNwZWMNCj4gd2l0aGluIHRoZSB3cmFwcGVyIHRvb2wsIGFzIHRvIHN0
b3AgcmVwbyBmcm9tIHVzaW5nIHRoZSBsYXRlc3Qgc3RhYmxlDQo+IHJlbGVhc2UuIEJ1dCB5b3Ug
YXJlIHJpZ2h0LCBhbmQgdGhpcyBtaWdodCBub3QgYmUgZW5vdWdoLiBXaWxsIGRvDQo+IHNvbWUN
Cj4gbW9yZSBkaWdnaW5nIG9uIHRoaXMuDQo+IA0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0t
LS0NCg0KaVFFekJBRUJDQUFkRmlFRTRXeVBNSUM1QXA0K09vbzFZZ3FldzA3Vk1OVUZBbUdGT3Zz
QUNna1FZZ3FldzA3Vg0KTU5WZnhRZi9WWkxuakt2N1RvMVZhcU02ZE1JWC9SM1A5Y1dRdHVUeE9n
NkcwNVppb29pemFvNVZnUURVWEVJeQ0KWnMzaDVsQ0ZNdVhkSmxFWmM5cTJBSlFDNTVCSUdxdFc4
TmpvNmxOUURQSTBJejUxSHBYaE5nc1dkb0MzRTdxQg0KdHBoZncrSDBXTm5JaHRETWtLLytoVUFa
V0FzSEhVYjdJM3JBeXJ1RTM0R0txdkVtYkJ3SG80NUIwTnBnZUNxRg0Kck5QSDdGZUk5VnZlaGxv
WkIvNStqbkpicm5teVdXb2dYQ054M1BYUGxneXJueHlSRHVpYk9VaXZXNlIvTVJHZA0KUmtTZFl2
bGxNZ1M5YWpCTHlLL1BFeWVBNnJ1cEVWUXF1S3YwbjlnaHhaRE96Vm02bWJvQ3ZCTWNqeHNhU0Nw
Ug0KVWxGUCtoKzRzWXcwRFRmQU45SjRVSUdXcTRWbUpBPT0NCj1QL3hHDQotLS0tLUVORCBQR1Ag
U0lHTkFUVVJFLS0tLS0NCg==

