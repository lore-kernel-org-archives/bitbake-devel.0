Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 47D6C6011B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Mar 2016 15:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 802CF18093;
	Fri,  4 Mar 2016 16:20:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 5q8UP2OvIzVi; Fri,  4 Mar 2016 16:20:12 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 7899E18091;
	Fri,  4 Mar 2016 16:20:12 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 33B921185;
	Fri,  4 Mar 2016 16:20:12 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 284D9153C;
	Fri,  4 Mar 2016 16:20:12 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id 25DC9FB7;
	Fri,  4 Mar 2016 16:20:12 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Fri, 4 Mar 2016 16:20:12 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%22]) with mapi id
	15.00.1156.000; Fri, 4 Mar 2016 16:20:12 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>, Joshua G Lock
	<joshua.g.lock@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH] xmlrpc: fix bug in setting
	XMLRPCServer.single_use
Thread-Index: AQHRdgDgdPy0Ktpsl0a3v+ZvtV3PIp9JZeGw
Date: Fri, 4 Mar 2016 15:20:12 +0000
Message-ID: <6accf51a177b4b4b9d7452f14b03b610@XBOX02.axis.com>
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
	<1457087406.3285.3.camel@linux.intel.com>
In-Reply-To: <1457087406.3285.3.camel@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 04 Mar 2016 15:20:17 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyBbbWFpbHRvOmJpdGJha2UtDQo+IGRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZ10gT24gQmVoYWxmIE9mIEpvc2h1YSBHIExvY2sNCj4g
U2VudDogZGVuIDQgbWFycyAyMDE2IDExOjMwDQo+IFRvOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIHht
bHJwYzogZml4IGJ1ZyBpbiBzZXR0aW5nDQo+IFhNTFJQQ1NlcnZlci5zaW5nbGVfdXNlDQo+IA0K
PiBPbiBGcmksIDIwMTYtMDMtMDQgYXQgMTA6MTMgKzAyMDAsIEVkIEJhcnRvc2ggd3JvdGU6DQo+
ID4gWE1MUlBDU2VydmVyLnNpbmdsZV91c2UgYXR0cmlidXRlIHdhcyBhbHdheXMgc2V0IHRvIEZh
bHNlLg0KPiA+IFRoaXMgY2F1c2VkIHhtbHJwYyBzZXJ2ZXIgdG8ga2VlcCBydW5uaW5nIGFmdGVy
IGJ1aWxkIGlzIGRvbmUgYXMNCj4gPiBCaXRCYWtlU2VydmVyQ29tbWFuZHMucmVtb3ZlQ2xpZW50
IG9ubHkgc2h1dHMgZG93biBzZXJ2ZXIgaWYgaXRzDQo+ID4gc2luZ2xlX3VzZSBhdHRyaWJ1dGUg
aXMgc2V0IHRvIFRydWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFZCBCYXJ0b3NoIDxlZC5i
YXJ0b3NoQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGJpdGJha2UvbGliL2JiL3Nl
cnZlci94bWxycGMucHkgfCAzICsrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2Ji
L3NlcnZlci94bWxycGMucHkNCj4gPiBiL2JpdGJha2UvbGliL2JiL3NlcnZlci94bWxycGMucHkN
Cj4gPiBpbmRleCAxY2VjYTUxLi5kNjI3NTUwIDEwMDY0NA0KPiA+IC0tLSBhL2JpdGJha2UvbGli
L2JiL3NlcnZlci94bWxycGMucHkNCj4gPiArKysgYi9iaXRiYWtlL2xpYi9iYi9zZXJ2ZXIveG1s
cnBjLnB5DQo+ID4gQEAgLTE5Myw2ICsxOTMsOCBAQCBjbGFzcyBYTUxSUENTZXJ2ZXIoU2ltcGxl
WE1MUlBDU2VydmVyLA0KPiA+IEJhc2VJbXBsU2VydmVyKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqBCYXNlSW1wbFNlcnZlci5fX2luaXRfXyhzZWxmKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChpbnRlcmZhY2VbMV0gPT0gMCk6wqDCoMKgwqDCoCMgYW5vbnltb3VzIHBvcnQsIG5vdCBnZXR0
aW5nDQo+ID4gcmV1c2VkDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZWxmLnNpbmds
ZV91c2UgPSBUcnVlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqBlbHNlOg0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzZWxmLnNpbmdlX3VzZSA9IEZhbHNlDQo+IA0KPiBUaGlzIHdvbid0IHdv
cmssIHJpZ2h0PyBUeXBvLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEpvc2h1YQ0KDQpPciB5b3Ug
Y2FuIHNpbXBsaWZ5IGl0IGFzOg0KDQogICAgICAgICAgICBzZWxmLnNpbmdsZV91c2UgPSBpbnRl
cmZhY2VbMV0gPT0gMA0KDQovL1BldGVyDQoNCg==

