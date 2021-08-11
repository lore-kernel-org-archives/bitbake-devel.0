Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.9146.1628696382931573520
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Aug 2021 08:39:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=dbJPRr9p;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1628696383;
  x=1660232383;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=g5JsoNl1UIQkhBFwJNXsSU3AAwedZ/K9jOluThIntrQ=;
  b=dbJPRr9pS/kVA20mxKkP2HK48KiXuZJgSDVtS3qCX1C3jA5APxKwR0RJ
   RvI7zYmIQ+STkInCcokq6ITWMaMxzhaHZTlx/q21Miq9c9RZGk5ZkK6ef
   pFeuozjPgNhFz3EIvBkyBowWKuCtYSK1DbHlJH9ApfGkNXnyLc9grZj+Q
   a+hoM+yEwFw9Z2XPj19o4BxoFjnzS3WyI9eFcGMn+/Db26UlKXeKHHUjQ
   +FSo+ztWi0nCKTU+VzFpjiUJX4lp4JZhKybNXPGDDi9KhqHOHf/mX9Ur2
   OSgg8YjnlAlHasNrqaorVjiSlohtnrxHIV5PuQCrS5FDR2JI8o5tONgh/
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, Ross Burton
	<ross@burtonini.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 4/4] fetch2/wget: fetch securely by default
Thread-Topic: [bitbake-devel] [PATCH v3 4/4] fetch2/wget: fetch securely by
 default
Thread-Index: AQHXjgiG6+hm810x7UaNnvNzhCbWdqtuMOeAgAA/1BA=
Date: Wed, 11 Aug 2021 15:39:39 +0000
Message-ID: <b44fa24ccf5747b58fc7902c9c8487ec@axis.com>
References: <20210810165509.19121-1-ross.burton@arm.com>
 <20210810165509.19121-4-ross.burton@arm.com>
 <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
In-Reply-To: <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IE9uIEJlaGFsZiBPZiBNaWNoYWVsIE9wZGVuYWNrZXINCj4gU2VudDogZGVuIDExIGF1Z3Vz
dGkgMjAyMSAxNTo0Ng0KPiBUbzogUm9zcyBCdXJ0b24gPHJvc3NAYnVydG9uaW5pLmNvbT47IGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJh
a2UtZGV2ZWxdIFtQQVRDSCB2MyA0LzRdIGZldGNoMi93Z2V0OiBmZXRjaCBzZWN1cmVseSBieQ0K
PiBkZWZhdWx0DQo+IA0KPiBIaSBSb3NzLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2hlcyEN
Cj4gDQo+IE9uIDgvMTAvMjEgNjo1NSBQTSwgUm9zcyBCdXJ0b24gd3JvdGU6DQo+ID4gRnJvbTog
Um9zcyBCdXJ0b24gPHJvc3NAYnVydG9uaW5pLmNvbT4NCj4gPg0KPiA+IFRoZSBkYXlzIG9mIGJy
b2tlbiBjZXJ0aWZpY2F0ZXMgYXJlIGJlaGluZCB1cyBub3csIHNvIGluc3RlYWQgb2YgYWx3YXlz
DQo+ID4gcGFzc2luZyAtLW5vLWNoZWNrLWNlcnRpZmljYXRlIHRvIHdnZXQsIGRvbid0IHBhc3Mg
aXQgYnkgZGVmYXVsdCBhbmQNCj4gPiBpbnN0ZWFkIG9ubHkgcGFzcyBpdCBCQl9DSEVDS19TU0xf
Q0VSVFMgPSAiMCIuDQo+ID4NCj4gPiBbIFlPQ1RPICMxNDEwOCBdDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSb3NzIEJ1cnRvbiA8cm9zcy5idXJ0b25AYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2JpdGJha2UtdXNlci1tYW51YWwtZmV0Y2hpbmcucnN0ICAgICAgICAgIHwgIDQgKysrKw0K
PiA+ICAuLi4vYml0YmFrZS11c2VyLW1hbnVhbC1yZWYtdmFyaWFibGVzLnJzdCAgICAgfCAgNCAr
KysrDQo+ID4gIGJpdGJha2UvbGliL2JiL2ZldGNoMi93Z2V0LnB5ICAgICAgICAgICAgICAgICB8
IDE5ICsrKysrKysrKysrKysrKystLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2JpdGJha2UvZG9j
L2JpdGJha2UtdXNlci1tYW51YWwvYml0YmFrZS11c2VyLW1hbnVhbC0NCj4gZmV0Y2hpbmcucnN0
IGIvYml0YmFrZS9kb2MvYml0YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItbWFudWFsLQ0K
PiBmZXRjaGluZy5yc3QNCj4gDQo+IFRoaXMgcGF0Y2ggbG9va3MgZ29vZCwgYnV0IHlvdXIgcGF0
Y2hlcyBzZWVtIHRvIGFwcGx5IHRvIHRoZSBQb2t5IHJlcG8sDQo+IG5vdCBCaXRCYWtlLiBXb3Vs
ZG4ndCBiZSBlYXNpZXIgZm9yIFJpY2hhcmQgaWYgeW91IHN1Ym1pdHRlZCBwYXRjaGVzIGZvcg0K
PiB0aGUgQml0QmFrZSByZXBvIGluc3RlYWQ/IFRoYXQncyB3aGVyZSB0aGUgcGF0Y2hlcyBuZWVk
IHRvIGdvLCBpZiBJDQo+IHVuZGVyc3Rvb2QgY29ycmVjdGx5LiBVbmxlc3MgdGhlcmUncyBhIHdv
cmtmbG93IEknbSBub3QgZmFtaWxpYXIgd2l0aC4uLg0KPiANCj4gQ2hlZXJzLA0KPiBNaWNoYWVs
Lg0KDQpGb3IgdGhvc2Ugb2YgdXMgdGhhdCBhY3R1YWxseSB1c2UgUG9reSwgaXQgaXMgYSBsb3Qg
ZWFzaWVyIHRvIGdlbmVyYXRlIHBhdGNoZXMgDQp2cyBQb2t5LCB0aGFuIHRoZSB1bmRlcmx5aW5n
IHJlcG9zaXRvcmllcyAoYXMgdGhleSBhcmUgbm90IGF2YWlsYWJsZSkuIFRoaXMgaXMgDQpub3Jt
YWxseSBub3QgYSBwcm9ibGVtLCBhbmQgUlAgaGFuZGxlcyBpdC4gVGhlIG9ubHkgY2F2ZWF0IGlz
IHRvIHJlbWVtYmVyIHRvIA0Kc3BsaXQgdGhlIHBhdGNoZXMgYW5kIHNlbmQgdGhlbSB0byBkaWZm
ZXJlbnQgbWFpbCBhZGRyZXNzZXMgd2hlbiBhIGJpZ2dlciBjaGFuZ2UgDQpyZXF1aXJlcyBjaGFu
Z2VzIHRvIGJvdGggT0UtQ29yZSBhbmQgQml0YmFrZS4NCg0KLy9QZXRlcg0KDQo=
