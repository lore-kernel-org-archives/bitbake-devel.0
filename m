Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02102C433F5
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 15:45:11 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web09.120.1636559109446677133
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 07:45:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 832C931E033F;
	Wed, 10 Nov 2021 16:45:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Wed, 10 Nov 2021 16:45:06 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 6573031E02E9;
	Wed, 10 Nov 2021 16:45:06 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Wed, 10 Nov 2021 16:45:06 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "martin@mko.dev" <martin@mko.dev>, "alex.kanavin@gmail.com"
	<alex.kanavin@gmail.com>
CC: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Daniel.Baumgart@iris-sensing.net"
	<Daniel.Baumgart@iris-sensing.net>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch2: Fix race condition in
 latest_revision
Thread-Topic: [bitbake-devel] [PATCH 2/2] fetch2: Fix race condition in
 latest_revision
Thread-Index: AQHX0klgHv7jZ330QkumxiADoy5WTKv3tO6AgAGr/gCAAAB1AIADfSKA
Date: Wed, 10 Nov 2021 15:45:05 +0000
Message-ID: <9b6d2b451e888f4b8d235aad3c61901c5b14f140.camel@iris-sensing.com>
References: <20211105133048.19879-1-jasper@fancydomain.eu>
	 <20211105133048.19879-2-jasper@fancydomain.eu>
	 <cf04f6c310491ca861ce5073dc14554bcba99ebc.camel@linuxfoundation.org>
	 <5538dd6d-94df-af1f-8141-4d6b63f119d1@mko.dev>
	 <CANNYZj8vpBCLhaUywM-EOSkCMgh0968WbS7BND9U-jHbO4Q=og@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8vpBCLhaUywM-EOSkCMgh0968WbS7BND9U-jHbO4Q=og@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACFB4FDCA1CF3B4A92E0B6DD396AE9F1@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 15:45:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12989

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkkgYmVs
aWV2ZSB0aGUgYmVoYXZpb3VyIHdlIG9ic2VydmVkIHdhcyBhY3R1YWxseSBjYXVzZWQgYnkgYSBi
dWcgaW4gb25lDQpvZiBvdXIgZWFybGllciBwYXRjaCBzZXRzLiBJIHNwZW50IGEgY291cGxlIGhv
dXJzIHRvZGF5IHRyeWluZyB0bw0KcmVjcmVhdGUgdGhlIGlzc3VlLCB3aXRob3V0IGFueSBsdWNr
LiBJJ2QgdGhlcmVmb3JlIHNraXAgdGhpcw0KcGFydGljdWxhciBwYXRjaC4NCg0KLSAtLSANCldp
dGggYmVzdCByZWdhcmRzDQoNCkphc3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdpbmVlcg0KDQpU
ZWwuICs0OSAzMCA1OCA1OCAxNCAyNjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5DQpKYXNwZXIu
T3JzY2h1bGtvQGlyaXMtc2Vuc2luZy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg
4oCiIOKAoiDigKIg4oCiIOKAog0KDQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50ZWxsaWdlbnQg
c2Vuc29ycw0KU2NobmVsbGVyc3RyYcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0KaHR0cHM6Ly9p
cmlzLXNlbnNpbmcuY29tLw0KDQoNCg0KDQoNCk9uIE1vbiwgMjAyMS0xMS0wOCBhdCAxMToyOCAr
MDEwMCwgQWxleGFuZGVyIEthbmF2aW4gd3JvdGU6DQo+IEl0IGhlbHBzIGlmIHlvdSBjYW4gcHJv
dmlkZSBhIHNwZWNpZmljIGV4YW1wbGUvdGVzdCBjYXNlIGZvciB0aGlzLg0KPiANCj4gQWxleA0K
PiANCj4gT24gTW9uLCA4IE5vdiAyMDIxIGF0IDExOjI2LCBNYXJ0aW4gS29wcGVoZWwgPG1hcnRp
bkBta28uZGV2PiB3cm90ZToNCj4gPiAtLSBzbmlwDQo+ID4gPiBJJ20gYWZyYWlkIEkgZG9uJ3Qg
dW5kZXJzdGFuZCB3aHkgdGhpcyBpcyBhIHJhY2UgY29uZGl0aW9uPyBXaGVyZQ0KPiA+IGlzIHRo
ZSB0aW1lb3V0DQo+ID4gPiB0aGF0IHN0b3BzIG9uZSBiZWluZyBzZXQ/DQo+ID4gDQo+ID4gVGhl
IGNvbW1pdCBtZXNzYWdlIGlzIG1pc2xlYWRpbmcgaGVyZSwgd2lsbCBjaGFuZ2UgdGhhdC4gSXQg
aXMNCj4gPiBhY3R1YWxseSANCj4gPiBub3QgYSByYWNlIGNvbmRpdGlvbiBhcyB3ZSBvcmlnaW5h
bGx5IHRob3VnaHQsIGJ1dCBtb3JlIGEgcHJvYmxlbQ0KPiA+IG9mIA0KPiA+IHJlY3Vyc2l2ZSBj
YWxscyB0byBfbGF0ZXN0X3JldmlzaW9uLg0KPiA+IA0KPiA+IFRoZSBnaXQgZmV0Y2hlciBkb2Vz
IHNvbWV0aGluZyBzaW1pbGFyIGluIF9sc3JlbW90ZSwgd2hlcmUgdGhlIGdpdCANCj4gPiBsc3Jl
bW90ZSB3b3VsZCBiZSBjYWxsZWQgcmVjdXJzaXZlbHkgdG8gcG9wdWxhdGUgdGhlIGVudmlyb25t
ZW50LA0KPiA+IGFuZA0KPiA+IHRoZXJlJ3MgY29kZSBpbiBwbGFjZSB0byBwcmV2ZW50IHRoYXQu
DQo+ID4gDQo+ID4gSW4gb3VyIGNhc2UsIHNpbmNlIHdlIHBlcnNpc3QgdGhlIHJldnMsIHdlIGhh
dmUgdG8gZmlsdGVyIG91dCBlbXB0eQ0KPiA+IHJldnMgDQo+ID4gYmVjYXVzZSBvdGhlcndpc2Ug
dGhlIG5leHQgcmVwbyBmZXRjaGVyIGludm9jYXRpb24gd291bGQgYWxzbyB0cnkNCj4gPiB0byAN
Cj4gPiBwb3B1bGF0ZSB0aGUgZW52aXJvbm1lbnQgYnV0IHRoZW4gcmV2c1trZXldIHdvdWxkIGFs
cmVhZHkgYmUgc2V0IHRvDQo+ID4gYW4gDQo+ID4gZW1wdHkgc3RyaW5nLCBjYXVzaW5nIGEgbWV0
YWRhdGEgbWlzbWF0Y2ggbGF0ZXIuDQo+ID4gDQo+ID4gVGhlcmVmb3JlIHdlIG9ubHkgcG9wdWxh
dGUgdGhlIHJldmlzaW9uIGNhY2hlIGlmIF9sYXRlc3RfcmV2aXNpb24gDQo+ID4gYWN0dWFsbHkg
cmV0dXJucyBhIHZhbGlkIHZhbHVlLg0KPiA+IFdlIGRpZCByZXByb2R1Y2UgdGhpcyB3aXRoIG11
bHRpcGxlIHJlY2lwZXMgdGhhdCB1c2VkIHVwIHRoZSBzYW1lIA0KPiA+IFNSQ19VUkkgYW5kIHRo
ZXJlZm9yZSBpbmZsdWVuY2luZyBlYWNoIG90aGVyLCB0aGlzIGNhc2Ugd29ya3MgZmluZQ0KPiA+
IG5vdy4NCj4gPiANCj4gPiBDaGVlcnMsDQo+ID4gTWFydGluDQo+ID4gDQo+ID4gDQo+ID4gLT0t
PS09LT0tPS09LT0tPS09LT0tPS0NCj4gPiBMaW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2Vz
IHNlbnQgdG8gdGhpcyBncm91cC4NCj4gPiBWaWV3L1JlcGx5IE9ubGluZSAoIzEyOTMzKToNCj4g
PiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2Uv
MTI5MzMNCj4gPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zy9tdC84Njg0MDI2NS8xNjg2NDg5DQo+ID4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3du
ZXJAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiA+IFVuc3Vic2NyaWJlOiBodHRwczovL2xpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL3Vuc3ViDQo+ID4gW2FsZXgua2FuYXZp
bkBnbWFpbC5jb21dDQo+ID4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gPiANCi0tLS0tQkVH
SU4gUEdQIFNJR05BVFVSRS0tLS0tDQoNCmlRRXpCQUVCQ0FBZEZpRUU0V3lQTUlDNUFwNCtPb28x
WWdxZXcwN1ZNTlVGQW1HTDZQOEFDZ2tRWWdxZXcwN1YNCk1OVktCUWYvWi9QRTY4Q0kxTDNGMWpl
SG05algrRE5zMWR5QTdJQjZmT0FIZGVxWXZLTktwYmVkcEhYVkhGbHANCm9hbGozaklFREpNS0U4
YjhMbUgvVnJSaExUcjY4UFNFc2hWSWJIT0tRUWZKbXk2Rm5iUXc1VlhUTVpPTjkyQVMNCnBoaVA0
SDRqTXZyOHN4OTQyZCtZb1Z3dGsxaU1PNitvWndVRXgyazV1R2l5VmVheXFNdnMwWHlySFFZNjVH
aFQNCjdSRzlaU09YdXRua0YxTkNIdG80bG41a2I4RytNVWNTM0Q1N0ZSYnNpR1Y0WHZJYU1UcUZi
bjN1YjZOUDJ4NUgNCnFNalF3V1hMckYxZUlRYzZoVkJYeFBubG95UHZaRVNwOTgvclRESGRCUXNK
QjlEYlMyYWtROE1aQk0rRUlpZmYNCnd0VkpSTkphMGpHL3VEdkYzd0xDb08reWNIRjhTUT09DQo9
dm5XMg0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=

