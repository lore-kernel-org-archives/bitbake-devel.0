Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239CC54EBF
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 17:04:32 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.69480.1672765471524526948
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jan 2023 09:04:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Ez909+lp;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672765472;
  x=1704301472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=624BsFoZNk1kWjYG+x52m9kxP9uH28DYU2Oey5t00GY=;
  b=Ez909+lpeAgULimXMZnGH/uT25tNLU5veNGKmYgrebERXkaoqtHYZl9W
   ymW2Ei91m1gn/B3A80joxPjs6L6T/VNKUYVKweOs4PrYKZX7ob53t0Qn4
   0uOLTjWmKb6ltIj7ZItOVNtO3lzYGKlCd/XqRuaZsxM44+W0UosMNlSQT
   FoQFQu/HWl9k93Snf0XP633If+0uUbJ/KZwSAA21JKeX3oLO0NfRG6t8V
   Hp6g3TAIzqvtH/K5T/b5xt6TNVu+Cls/D6q6INSUEXT84bviFi7Ev2+9T
   26/zUg+3fo1jQKf1N9RO5dtx3mkzwJDmRHtxmKZHUGuALAeobLiPRacH3
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "quentin.schulz@theobroma-systems.com"
	<quentin.schulz@theobroma-systems.com>, "than.matos+bitbake@gmail.com"
	<than.matos+bitbake@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: RE: [docs] [bitbake-devel] Typo on the BitBake Documentation
Thread-Topic: [docs] [bitbake-devel] Typo on the BitBake Documentation
Thread-Index: AQHZGjZUEnqxbAO9SEeIyue6LZH2MK6Mw9uAgAAxekA=
Date: Tue, 3 Jan 2023 17:04:29 +0000
Message-ID: <4ddb01e14e304e96b10598b72ae05911@axis.com>
References: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
 <10502f22-575d-3917-374a-8c60a7e9bf32@theobroma-systems.com>
In-Reply-To: <10502f22-575d-3917-374a-8c60a7e9bf32@theobroma-systems.com>
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
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 17:04:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14282

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBkb2NzQGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPGRvY3NAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmDQo+IE9mIFF1
ZW50aW4gU2NodWx6IHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IFNlbnQ6IGRlbiAzIGph
bnVhcmkgMjAyMyAxNjowMw0KPiBUbzogdGhhbi5tYXRvcytiaXRiYWtlQGdtYWlsLmNvbTsgYml0
YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBZUCBkb2NzIG1haWxpbmcg
bGlzdCA8ZG9jc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPg0KPiBTdWJqZWN0OiBSZTogW2RvY3Nd
IFtiaXRiYWtlLWRldmVsXSBUeXBvIG9uIHRoZSBCaXRCYWtlIERvY3VtZW50YXRpb24NCj4gDQo+
IEhpLA0KPiANCj4gT24gMTIvMjcvMjIgMjI6MDAsIHRoYW4ubWF0b3MrYml0YmFrZUBnbWFpbC5j
b20gd3JvdGU6DQo+ID4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgdGhlIHJpZ2h0IHBsYWNlIHRv
IHJlcG9ydCBhbmQgaWYgSSdtIHdyaXRpbmcgaW4NCj4gPiB0aGUgd3JvbmcgcGxhY2UsIHBsZWFz
ZSBmZWVsIGZyZWUgdG8gcmVtb3ZlIHRoaXMgcG9zdC4NCj4gDQo+IFRoaXMgaXMgYWN0dWFsbHkg
cXVpdGUgYSBnb29kIGd1ZXNzLCBqdXN0IGFkZGluZyB0aGUgeW9jdG8tZG9jcyBNTCB0byBDYw0K
PiByZWNpcGllbnRzIHRvIG5vdGlmeSBwZW9wbGUgZ2VuZXJhbGx5IGludGVyZXN0ZWQgaW4gZG9j
cy4NCj4gDQo+ID4gSSdtIGFsc28gbm90IGEgbmF0aXZlIG9mIEVuZ2xpc2gsIGJ1dCBJIHRoaW5r
IHRoZXJlIGlzIGEgdHlwbyBvbiB0aGUNCj4gPiBCaXRCYWtlIGRvY3VtZW50YXRpb24gcGFnZS4N
Cj4gPg0KPiA+PiBZb3UgY2FuIG9idGFpbiBCaXRCYWtlIHNldmVyYWwgZGlmZmVyZW50IHdheXM6
DQo+ID4NCj4gPiBJIGZlZWwgbGlrZSB0aGVyZSBpcyBhIG1pc3NpbmcgYGluYCBiZWZvcmUgdGhl
IHdvcmQgYHNldmVyYWxgLg0KPiANCj4gQm90aCBmZWVsIG9kZCB0byBtZSwgeW91ciBzdWdnZXN0
aW9uIG1vcmUgdGhhbiB0aGUgY3VycmVudCBwaHJhc2luZw0KPiB0aG91Z2guIEknbSBub3QgYSBu
YXRpdmUgc3BlYWtlciBlaXRoZXIgeW91J2QgaGF2ZSBndWVzc2VkIDopDQo+IA0KPiA+IFNvcnJ5
IHRvIGJvdGhlciB5b3UhDQo+IA0KPiBUaGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXBv
cnQgdGhpcywgSSdsbCBsZXQgbmF0aXZlIHNwZWFrZXJzDQo+IGNoaW1lIGluIGFuZCBkZWNpZGUg
Zm9yIHVzIDopDQoNCldlbGwsIEkgYW0gbm90IGEgbmF0aXZlIEVuZ2xpc2ggc3BlYWtlciBlaXRo
ZXIsIGJ1dCBJIGFncmVlIHdpdGggVGhhbiANCnRoYXQgImluIHNldmVyYWwiIHdvdWxkIGltcHJv
dmUgdGhlIHNlbnRlbmNlLiBBbHRlcm5hdGl2ZWx5LCBpdCBjYW4gYmUgDQpyZXdyaXR0ZW4gYXM6
DQoNCiAgVGhlcmUgYXJlIHNldmVyYWwgZGlmZmVyZW50IHdheXMgdGhhdCBCaXRCYWtlIGNhbiBi
ZSBvYnRhaW5lZDoNCg0KPiANCj4gQ2hlZXJzLA0KPiBRdWVudGluDQoNCi8vUGV0ZXINCg0K

