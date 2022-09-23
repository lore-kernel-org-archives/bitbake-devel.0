Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476DC6FA82
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 15:52:24 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.9169.1663948340165539594
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 08:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=AoXEdVlx;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663948341;
  x=1695484341;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=m6FEE/QXWx6BoQF7bFK7hYbD9s3gbdpm6wzBJx+u828=;
  b=AoXEdVlxgBVQBgE7fdJJThrJknEGf5Xotcq8pGxCbufchHBmtVE5NMIq
   jlvyplh93JYp0pyWjHTZNqQHgd2I0evMwMQwb2ipJq5RGSZFOaWRit7xN
   C1sq8dYTLAcCib98BKRvSon1f29jHPYIgHqdUtfZPEnZmM6JJsXuUQHC8
   EiTu0KHZrFl29RbJ06hRZ03cR3/HTd85AGuQyejNdRfC+/z7LuSW9Rh1G
   dUYRo0JA00U2UbUac6YHV0BIRHqBpurEhcqP3d9EMue5SrhRYq3GASHAg
   2T4iihrASa6f/yEnJ9ODt0QEDbTgmrXf3PLRVnkq4+r3TWjMgbxT3y4er
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] utils: Enable the loopback interface in
 disable_network()
Thread-Topic: [bitbake-devel] [PATCH] utils: Enable the loopback interface in
 disable_network()
Thread-Index: AQHYz061DhseqygumU+A9Hhzn9QeYa3tCTAw///vUwCAACyaQA==
Date: Fri, 23 Sep 2022 15:52:17 +0000
Message-ID: <8f7c969baf4e4112ae9e7a2b21ee12a3@axis.com>
References: <20220923101613.1096056-1-pkj@axis.com>
	 <e66ec2ca23ac7ce7e5be44aaacaeb2f6d1ab779b.camel@linuxfoundation.org>
	 <ce3bdf3377094bd6aa9afea17735ec48@axis.com>
 <c88684a7e0becc8137066edfce1c13f493fcdd33.camel@linuxfoundation.org>
In-Reply-To: 
 <c88684a7e0becc8137066edfce1c13f493fcdd33.camel@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Sep 2022 15:52:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13993

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDIzIHNlcHRlbWJl
ciAyMDIyIDE2OjU0DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVk
dEBheGlzLmNvbT47IGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4g
U3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIHV0aWxzOiBFbmFibGUgdGhlIGxv
b3BiYWNrIGludGVyZmFjZQ0KPiBpbiBkaXNhYmxlX25ldHdvcmsoKQ0KPiANCj4gT24gRnJpLCAy
MDIyLTA5LTIzIGF0IDE0OjQyICswMDAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3JvdGU6DQo+ID4g
T2suIEkgaG9wZSBpdCBpcyB0aGVuIG9rIHRoYXQgSSBhZGQgYSBuZXcgdGFzayB2YXJmbGFnICJu
ZXR3b3JrLWxvb3BiYWNrIg0KPiA+IChvciBtYXliZSBldmVuIGp1c3QgImxvb3BiYWNrIj8pIEUu
Zy46DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYml0YmFrZS9iaW4vYml0YmFrZS13b3JrZXIgYi9i
aXRiYWtlL2Jpbi9iaXRiYWtlLXdvcmtlcg0KPiA+IGluZGV4IDdiZTM5MzcwYjMuLjQxMTU2MDRk
OTkgMTAwNzU1DQo+ID4gLS0tIGEvYml0YmFrZS9iaW4vYml0YmFrZS13b3JrZXINCj4gPiArKysg
Yi9iaXRiYWtlL2Jpbi9iaXRiYWtlLXdvcmtlcg0KPiA+IEBAIC0yNjcsNiArMjY3LDggQEAgZGVm
IGZvcmtfb2ZmX3Rhc2soY2ZnLCBkYXRhLCBkYXRhYnVpbGRlciwNCj4gPiB3b3JrZXJkYXRhLCBm
biwgdGFzaywgdGFza25hbWUsIHRhc2toYQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIGJiLnV0aWxzLmlzX2xvY2FsX3VpZCh1aWQpOg0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG9nZ2VyLmRlYnVn
KCJBdHRlbXB0aW5nIHRvIGRpc2FibGUgbmV0d29yayBmb3IgJXMiICUgdGFza25hbWUpDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiYi51dGls
cy5kaXNhYmxlX25ldHdvcmsodWlkLCBnaWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
IGlmIHRoZV9kYXRhLmdldFZhckZsYWcodGFza25hbWUsICduZXR3b3JrLWxvb3BiYWNrJywgRmFs
c2UpOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmIudXRpbHMubG9vcGJhY2tf
dXAoKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2U6
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBs
b2dnZXIuZGVidWcoIlNraXBwaW5nIGRpc2FibGUgbmV0d29yayBmb3IgJXMgc2luY2UgJXMgaXMg
bm90IGEgbG9jYWwgdWlkLiIgJSAodGFza25hbWUsIHVpZCkpDQo+ID4NCj4gPiBXaXRoIHRoYXQg
aW4gcGxhY2UsIEkgc2VlIG5vIGRyYXdiYWNrcyBjb21wYXJlZCB0byBhbHdheXMNCj4gPiBlbmFi
bGluZyB0aGUgbG9vcGJhY2sgaW50ZXJmYWNlIGluIGRpc2FibGVfbmV0d29yaygpIHNpbmNlDQo+
ID4gc2V0dGluZywgZS5nLiwgZG9fY29tcGlsZVtuZXR3b3JrLWxvb3BiYWNrXSA9ICIxIiB3aWxs
IG1ha2UNCj4gPiBzdXJlIGl0IGlzIG9ubHkgZW5hYmxlZCB3aGVuIGFjdHVhbGx5IG5lZWRlZCwg
Y29tcGFyZWQgdG8sDQo+ID4gZS5nLiwgZG9pbmcgaXQgaW4gYW4gYW5vbnltb3VzIFB5dGhvbiBm
dW5jdGlvbi4NCj4gDQo+IFNldHRpbmcgaXQgaW4gYSBwcmVmdW5jIGRvZXNuJ3QgbG9vayB0aGF0
IGJhZCBvbmNlIHlvdSBoYXZlIGEgZnVuY3Rpb24NCj4gZm9yIGl0Pw0KPiANCj4gcHl0aG9uIGVu
YWJsZV9sb29wYmFjayAoKSB7DQo+ICAgICBiYi51dGlscy5sb29wYmFja191cCgpDQo+IH0NCj4g
DQo+IGRvX2NvbXBpbGVbcHJlZnVuY3NdICs9ICJlbmFibGVfbG9vcGJhY2siDQoNCkhtbS4gV2hh
dCB3b3JyaWVzIG1lIGhlcmUgaXMgd2hhdCBoYXBwZW5zIHdoZW4gZW5hYmxlX2xvb3BiYWNrIGlz
IA0KY2FsbGVkIGZvciBhIHRhc2sgdGhhdCBoYXMgbmV0d29yaz0xPyBIb3BlZnVsbHkgaXQgb25s
eSBkb2VzIHNvbWUgDQp1bm5lY2Vzc2FyeSB3b3JrLCBidXQgSSBkbyBub3Qga25vdy4uLiBUaGF0
J3Mgd2h5IEkgZmluZCB0aGUgDQp2YXJmbGFnIHNvbHV0aW9uIG1vcmUgYXBwZWFsaW5nIGFzIEkg
a25vdyBpdCB3aWxsIG9ubHkgZW5hYmxlIHRoZSANCmxvb3BiYWNrIGludGVyZmFjZSB3aGVuIG5l
dHdvcmtpbmcgaGFzIGFjdHVhbGx5IGJlZW4gZGlzYWJsZWQuDQoNCj4gT24gdGhlIHN1YmplY3Qg
b2YgbmFtaW5nLCBpdCBtYXkgYmUgY2xlYXJlciBhcyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IGJi
LnV0aWxzLmVuYWJsZV9sb29wYmFja19uZXR3b3JraW5nKCkNCj4gDQo+IGFzIHdlIG5lZWQgdG8g
dGhpbmsgYWJvdXQgaG93IHRoaXMgbG9va3Mgd2l0aG91dCBjb250ZXh0IHdlIGhhdmUgaW4NCj4g
dGhlc2UgcGF0Y2hlcy4NCg0KQWdyZWVkLg0KDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0K
Ly9QZXRlcg0KDQo=

