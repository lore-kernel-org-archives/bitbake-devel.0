Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841FC43219
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 20:37:09 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.649.1649967639594393660
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 13:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=mhoPwsvu;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649967639;
  x=1681503639;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=LdbA7ZDGBbC0ZP4mOEv04I2AQfq2A+ekeZM9CvtlIx4=;
  b=mhoPwsvu3j4eqS55WItRI2Zg7ymZKlCWsmAoGvY9NWyL4P7T39553pDd
   NVFchlKF9+2QJ5n42lNeF2cEmFryIbukWY930NUOf+FBxmIblKZHd7AMi
   44gUbvCDHggtD9hhSCTZR0sFyrpVhn+We5pD4OoirR5iyceYmZ5fmJqCh
   5KyI1pdrBZ1Yq4PXskehv2HRsbvij1WycpBdfUIZ8i8D+UQeUzmGh6FLI
   Hsz/zNmvGPZhhGBpZsd94jnIdzGg7JZRYe7DvOLLSHbfdSi9pS0J6AlHx
   H6vmm0uaTYsOr/jT8fSrJyrqKznBAfXV5wQzwb2vHrihfX5PRPAhGyUu4
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/git: Simplify the validation of
 SHA-1 revisions
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git: Simplify the validation of
 SHA-1 revisions
Thread-Index: AQHYUBySS0qfJtCjHUalHKZtb0eHbqzv2Hrw
Date: Thu, 14 Apr 2022 20:20:36 +0000
Message-ID: <a51df30aaebc4da1bb6c02f519ede9be@axis.com>
References: <20220414154207.25999-1-pkj@axis.com>
 <083ca178f3da30a8f3f21c641606a7f5267b41b3.camel@linuxfoundation.org>
In-Reply-To: 
 <083ca178f3da30a8f3f21c641606a7f5267b41b3.camel@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 20:37:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13625

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDE0IGFwcmlsIDIw
MjIgMTg6MjgNCj4gVG86IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0QGF4
aXMuY29tPjsgYml0YmFrZS0NCj4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gZmV0Y2gyL2dpdDogU2ltcGxpZnkgdGhl
IHZhbGlkYXRpb24NCj4gb2YgU0hBLTEgcmV2aXNpb25zDQo+IA0KPiBPbiBUaHUsIDIwMjItMDQt
MTQgYXQgMTc6NDIgKzAyMDAsIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToNCj4gPiBBbHNvIGNv
cnJlY3QgdHdvIGNvbW1lbnRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgS2plbGxl
cnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+DQo+ID4gLS0tDQo+ID4gIGJpdGJh
a2UvbGliL2JiL2ZldGNoMi9naXQucHkgfCAxMSArKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2JpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkgYi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIv
Z2l0LnB5DQo+ID4gaW5kZXggYjNlYjgyNDhkMC4uOTAxMDRhYzM4MyAxMDA2NDQNCj4gPiAtLS0g
YS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQo+ID4gKysrIGIvYml0YmFrZS9saWIvYmIv
ZmV0Y2gyL2dpdC5weQ0KPiA+IEBAIC0yNDgsOSArMjQ4LDEwIEBAIGNsYXNzIEdpdChGZXRjaE1l
dGhvZCk6DQo+ID4NCj4gPiAgICAgICAgICB1ZC5zZXR1cF9yZXZpc2lvbnMoZCkNCj4gPg0KPiA+
ICsgICAgICAgIHNoYTFfcmUgPSByZS5jb21waWxlKHInXlswLTlhLWZdezQwfSQnKQ0KPiANCj4g
cmUuY29tcGlsZSgpIGlzIGV4cGVuc2l2ZSBzbyBpbiBnZW5lcmFsIHdlIHNob3VsZCBjYWNoZSB0
aGF0IG9yIGRvIGl0IGF0DQo+IHRoZSBtb2R1bGUgdG9wIGxldmVsLi4uDQoNClN1cmUsIEkgY2Fu
IG1vdmUgaXQgdG8gdGhlIG1vZHVsZSB0b3AgbGV2ZWwuDQoNCkkgYmFzZWQgdGhlIHVzZSBvZiBy
ZS5jb21waWxlKCkgaW4gdGhhdCBjbGFzcyBvbiBob3cgaXQgd2FzIGRvbmUgaW4gDQp0aGUgX3Jl
dmlzaW9uX2tleSgpIGZ1bmN0aW9uLiBEbyB5b3Ugd2FudCBtZSB0byBtb3ZlIGl0cyBzbGFzaF9y
ZSBhcyANCndlbGw/DQoNCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KDQovL1BldGVyDQoNCg==

