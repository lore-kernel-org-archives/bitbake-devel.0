Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF73BC433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 15:35:06 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web08.7272.1636126505524289016
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 08:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 8A09931E034C;
	Fri,  5 Nov 2021 16:34:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Fri,  5 Nov 2021 16:34:53 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 6F08A31E033F;
	Fri,  5 Nov 2021 16:34:53 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Fri, 5 Nov 2021 16:34:52 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	<kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIAAA0EAgAAUvYA=
Date: Fri, 5 Nov 2021 15:34:52 +0000
Message-ID: <1472bf47a85ba1f628e7a7e0359f56e3003b7a25.camel@iris-sensing.com>
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
Content-ID: <EF68B58ECCE187408EF982E73D810E0B@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 15:35:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12910

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNClNIQSBy
ZXYgc2V0IGluIHYyIG9mIHRoZSBwYXRjaCBzZXJpZXMgOikNCg0KLSAtLSANCldpdGggYmVzdCBy
ZWdhcmRzDQoNCkphc3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdpbmVlcg0KDQpUZWwuICs0OSAz
MCA1OCA1OCAxNCAyNjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5DQpKYXNwZXIuT3JzY2h1bGtv
QGlyaXMtc2Vuc2luZy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg
4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDi
gKIg4oCiIOKAog0KDQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50ZWxsaWdlbnQgc2Vuc29ycw0K
U2NobmVsbGVyc3RyYcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0KaHR0cHM6Ly9pcmlzLXNlbnNp
bmcuY29tLw0KDQoNCg0KDQoNCk9uIEZyaSwgMjAyMS0xMS0wNSBhdCAxNToyMCArMDEwMCwgS29u
cmFkIFdlaWhtYW5uIHdyb3RlOg0KPiANCj4gDQo+IE9uIDA1LjExLjIxIDE1OjA5LCBKYXNwZXIg
T3JzY2h1bGtvIHdyb3RlOg0KPiA+IEFjdHVhbGx5LCBJIGRvbid0IGJlbGlldmUgdGhpcyB0byBi
ZSBhbiBpc3N1ZSBmb3IgdGhlIGZvbGxvd2luZw0KPiA+IHJlYXNvbnM6DQo+ID4gDQo+ID4gMS4g
VGhlIHJlY2lwZSBkb2VzIG5vdGhpbmcgbW9yZSB0aGFuIHRha2luZyB0aGUgd3JhcHBlciBzY3Jp
cHQgYXMNCj4gPiBpcw0KPiA+IGFuZCBjb3B5aW5nIGl0IHRvIHRoZSBzeXNyb290LiBBcyB0aGUg
cmVwbyBiaW5hcnkgaXMgbmV2ZXIgY2FsbGVkDQo+ID4gd2hlbg0KPiA+IGJ1aWxkaW5nLCBpdCBk
b2VzIG5vdCBoYXZlIHRoZSAiY2hhbmNlIiB0byBsb29rIGZvciBhbiB1cGRhdGUNCj4gPiBkdXJp
bmcNCj4gPiB0aGUgeW9jdG8gb2ZmbGluZSBidWlsZCBwcm9jZXNzLiBUaGUgb3V0Y29tZSBvZiBh
biBvZmZsaW5lIGJ1aWxkIGlzDQo+ID4gdGhlcmVmb3JlIHByZWRpY3RhYmxlLg0KPiA+IA0KPiA+
IDIuIFdoZW4gdXNpbmcgcmVwbyB3aXRoaW4gdGhlIHlvY3RvIGJ1aWxkIGl0c2VsZiAod2l0aCB0
aGUgcmVwbw0KPiA+IGZldGNoZXIpLCB0aGUgcmVwbyBiaW5hcnkgaXMgb25seSBldmVyIGNhbGxl
ZCBkdXJpbmcgdGhlIGRvX2ZldGNoDQo+ID4gc3RlcCwNCj4gPiB3aGljaCBvYnZpb3VzbHkgaGFz
IG5vIGlzc3VlcyB3aXRoIGFueSBuZXR3b3JrIGFjY2Vzcy4NCj4gPiANCj4gwqA+DQo+IA0KPiBP
a2F5IGZpbmUgdGhhdCBtYWtlcyBzZW5zZSwgZXZlbiBpZiBpdCBpcyBzdGlsbCBwaG9uaW5nIGhv
bWUuDQo+IEFub3RoZXIgdGhpbmcsIGNvdWxkIHlvdSBwbGVhc2UgZXhjaGFuZ2UgIitSRVBPX1JF
ViA9ICd2Mi4xNy4zJyIgZm9yDQo+IGEgDQo+IFNIQSByZXZpc2lvbiwgYXMgSSB3b3VsZG4ndCBi
ZXQgbXkgbGlmZSBvbiBnb29nbGUgbm90DQo+IGRlbGV0aW5nL3JlbW92aW5nIA0KPiB0YWdzIGZy
b20gdGhlaXIgcmVwb3MgLSBhbmQgdW5wbGVhc2FudGx5IHdlIHdvdWxkbid0IGV2ZW4gbm90aWNl
IHRoYXQNCj4gZWFzaWx5DQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQppUUV6QkFF
QkNBQWRGaUVFNFd5UE1JQzVBcDQrT29vMVlncWV3MDdWTU5VRkFtR0ZUeHNBQ2drUVlncWV3MDdW
DQpNTlcydWdmL1JTNHpDaXRrUGU5WkVESnZBcGRaR2llMWRKbWMzZ0d2Y3dlTnY2ZDZrZDFiRmQy
YlM0QllkYmlLDQpCT2hIRjNrTXRkem5hSk55UWxBSEJTbXlzZnZUVVd5bXFVYWhSVDNmNytrRXVI
cXJ3UWNZSkZvRHFNM3RYUjRzDQo0VktZcGJSbzhrbHc2MlhqdUJIZHdKOEx4Sml6NUVXUWRRRjhn
ZFFUbDNUaW9qcDZ5MktHRHJqbzNqL01ZakFrDQo2S2Z3UDBiQWNhNm8vdk1GN0pqaGJzOXNJbENx
T2tVWHJOUmJrdEVvbk83aFBaeGRwZ2lFQzZRUEhDcTlPTmlODQozaEhQaFYxM2dkK0JUYS83azFH
TlBTTFc0WFY2eWU3cWMyNkNwcU1EaW5nOGR4ejRSSm56cGsySXhUTkZIUTBtDQo5NW1MZEhBeWdv
N285UkpZZHo4TklPNGhYVnFiN1E9PQ0KPW5RVksNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0t
LQ0K

