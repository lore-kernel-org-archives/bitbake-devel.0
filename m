Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86124C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 16:01:04 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.28212.1646668862845050899
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 08:01:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=JQczolL9;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646668863;
  x=1678204863;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=F8byRXfYpv8qNsffsuBINuUqeHfQbJvmd3yaCWypwTA=;
  b=JQczolL9rIFWpMgdFkSITlmwpHOuOUqrz7R3kxQh65wJbUdjuvYInpxl
   eQhJ4p3yUNCewIIQjiwQ6U5HfqUspld5R4SNmtygQYD02VIubBCMZI5bh
   dGcW/6ZfDQ67HoeMgDLkbz5hVpiwL7OcaBSucZUWjFfSL82meQEJirFBZ
   Hgqv4nUl0cx7gdTQR5fy+kcGp1BO6CWBQJGdAMpdLOTRwmeDWQlNeYvIk
   ypGeTbrucrKPujJJ6WqaSjg2WyLvmESm4otaJmIsMCVT+OLCS64+Cbbo8
   RssBtlL5XLe/hJirJBTxKEKTbLYSkYE1IMbKgog8IpZJXcwc0j/Dd0Trx
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/3] knotty.py: Separate the display of
 main tasks from running tasks
Thread-Topic: [bitbake-devel] [PATCH 3/3] knotty.py: Separate the display of
 main tasks from running tasks
Thread-Index: AQHYMjp5sPNxsA2e6U6vDVUkYEQnQay0EOEQ
Date: Mon, 7 Mar 2022 16:01:01 +0000
Message-ID: <ae09826d6386494eb2bd939f05b8c4b1@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
	 <20220307133620.12404-3-pkj@axis.com>
 <de7c81bffbc020841e3fd956f64288cb1a91297f.camel@linuxfoundation.org>
In-Reply-To: 
 <de7c81bffbc020841e3fd956f64288cb1a91297f.camel@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 16:01:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13434

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDcgbWFycyAyMDIy
IDE2OjQ2DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlz
LmNvbT47IGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVj
dDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggMy8zXSBrbm90dHkucHk6IFNlcGFyYXRlIHRo
ZSBkaXNwbGF5DQo+IG9mIG1haW4gdGFza3MgZnJvbSBydW5uaW5nIHRhc2tzDQo+IA0KPiBPbiBN
b24sIDIwMjItMDMtMDcgYXQgMTQ6MzYgKzAxMDAsIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToN
Cj4gPiBGcm9tOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlzLmNv
bT4NCj4gPg0KPiA+IEl0IGNhbiBiZSBjb25mdXNpbmcgdGhhdCB0aGUgY291bnQgb2YgcnVubmlu
ZyB0YXNrcyBzaG93biB0b2dldGhlciB3aXRoDQo+ID4gdGhlIHByb2dyZXNzIGJhciBmb3IgdGhl
IG1haW4gdGFza3MgYWxzbyBpbmNsdWRlcyBhbnkgcnVubmluZyBzZXRzY2VuZQ0KPiA+IHRhc2tz
Lg0KPiA+DQo+ID4gU2VwYXJhdGUgdGhlIGRpc3BsYXkgc28gdGhhdCB0aGUgbWVzc2FnZSBmb3Ig
dGhlIG1haW4gdGFza3MnIHByb2dyZXNzDQo+ID4gYmFyIG9ubHkgaW5jbHVkZXMgaW5mb3JtYXRp
b24gb24gdGhlIG1haW4gdGFza3MsIGFuZCB0aGUgZGlzcGxheSBvZiB0aGUNCj4gPiBjb3VudCBv
ZiBjdXJyZW50bHkgcnVubmluZyB0YXNrcyBnZXRzIGl0IG93biBsaW5lLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5j
b20+DQo+ID4gLS0tDQo+ID4NCj4gPiBUaGlzIHNob3VsZCBiZSBjb25zaWRlcmVkIGFuIFJGQy4g
V2l0aCB0aGlzIGNoYW5nZSwgdGhlIHByb2dyZXNzIGxpbmVzDQo+ID4gZm9yIHRoZSBzZXRzY2Vu
ZSB0YXNrcyBhbmQgdGhlIG1haW4gdGFza3MgKGlzIHRoYXQgYSBnb29kIG5hbWUgZm9yDQo+ID4g
dGhvc2UgdGFza3M/KSBsb29rIHRoZSBzYW1lLiBUaGUgZHJhd2JhY2sgaXMgdGhhdCBpdCBhZGRz
IGEgbGluZSB0bw0KPiA+IHRoZSBkaXNwbGF5Lg0KPiANCj4gSSdtIG5vdCBrZWVuLiBUaGUgcHJv
Z3Jlc3MgYmFyIG9ubHkgcmVsYXRlcyB0byAicmVhbCIgdGFza3MsIG5vdCBzZXRzY2VuZQ0KPiBv
bmVzLiBJIGtub3cgc29tZSBvZiB0aGUgcnVubmluZyB0YXNrcyBtaWdodCBiZSBzZXRzY2VuZSBv
bmVzIGJ1dCB0aGF0IHdhcyANCj4gYSBjb21wcm9taXNlIGluIHRoZSBwcmV2aW91cyBwYXRjaGVz
IHRvIGtlZXAgdGhlIG51bWJlciBvZiBsaW5lcyBtaW5pbWFsLiANCj4gSSB3YXNuJ3QgY29udmlu
Y2VkIHRoYXQgaXNzdWUgbWF0dGVyZWQgdGhhdCBtdWNoIGluIHJlYWxpdHkuDQoNCkFzIEkgc2Fp
ZCwgdGhpcyB3YXMganVzdCBhbiBSRkMuIEkgY2FuIGxpdmUgd2l0aG91dCBpdC4NCg0KPiANCj4g
Q2hlZXJzLA0KPiANCj4gUmljaGFyZA0KDQovL1BldGVyDQoNCg==

