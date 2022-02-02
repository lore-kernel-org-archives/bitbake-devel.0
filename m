Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA35FC433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Feb 2022 02:17:45 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.58387.1643768262468085252
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Feb 2022 18:17:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=gfRfEjDf;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643768262;
  x=1675304262;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ezH5U+v3lvrdTXvCjl3sRpWSGSprBMwjJPH+2JdK3yU=;
  b=gfRfEjDfAOzJpH/cycX2RxN2pJVxR87uKw98eltl2fQpuh/Ys4HFZwvU
   j64teXny42cNouZ8fJN+WSs0G1y59rNE3qIs+oaG4YINT0jcEpNzpFkog
   Zj0XfC6WGzuZvH/XSplaD9Zg+pey+ZZ/df5CQj4EMIT6jYKTXTaEXJtB6
   /3llmIkStw0bRjQTN3CgdvroIbH+IC2BjsIsYLljFidYL9d3a5rdQJScM
   YzQc5Rrfrm2o1mmMGMTlihJMFlp/hNCEzqyIHKROLUJ7qL0u+Vqoc3/VF
   7QG+TSCivOyZ8NrEv9jUqHwsmVl8mlKtrnP+qshWwjq8/UNbGO+lIvryH
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "michael.opdenacker@bootlin.com" <michael.opdenacker@bootlin.com>,
	"Richard Purdie" <richard.purdie@linuxfoundation.org>, Trevor Woerner
	<twoerner@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v3] knotty: improve the UI information
Thread-Topic: [bitbake-devel] [PATCH v3] knotty: improve the UI information
Thread-Index: AQHYE7+51s1jcezwWEyLLa2zSnZM4Kx+S2IAgABpHYCAANWC8A==
Date: Wed, 2 Feb 2022 02:17:39 +0000
Message-ID: <a6a4328b56974ad8804f4a2e1cc570a0@axis.com>
References: <20220127205138.29159-1-twoerner@gmail.com>
 <6dd771e81db2c09c606c298b452850c16818be5c.camel@linuxfoundation.org>
 <19b4a25b-42d6-ed7c-1c48-b9cccdd5eb0b@bootlin.com>
In-Reply-To: <19b4a25b-42d6-ed7c-1c48-b9cccdd5eb0b@bootlin.com>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Feb 2022 02:17:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13305

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIE1pY2hhZWwgT3BkZW5hY2tlciB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zw0KPiBTZW50OiBkZW4gMSBmZWJydWFyaSAyMDIyIDE1OjE3DQo+IFRvOiBSaWNoYXJkIFB1cmRp
ZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz47IFRyZXZvciBXb2VybmVyIDx0
d29lcm5lckBnbWFpbC5jb20+OyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggdjNdIGtub3R0eTogaW1wcm92
ZSB0aGUgVUkgaW5mb3JtYXRpb24NCj4gDQo+IEhpIFJpY2hhcmQsDQo+IA0KPiBPbiAyLzEvMjIg
MDk6MDAsIFJpY2hhcmQgUHVyZGllIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMi0wMS0yNyBhdCAx
NTo1MSAtMDUwMCwgVHJldm9yIFdvZXJuZXIgd3JvdGU6DQo+ID4+IER1cmluZyBhIGJ1aWxkIHlv
dSBtaWdodCBlbmQgdXAgd2l0aCBiaXRiYWtlIHRlbGxpbmcgeW91Og0KPiA+Pg0KPiA+PiAJQ3Vy
cmVudGx5IDMwIHJ1bm5pbmcgdGFza3MgKDI3NTcgb2YgMjc1Ny8zNDc2IG9mIDYzOTApDQo+ID4+
DQo+ID4+IFdoaWNoLCB0byBtZSwgaXMgcmVhbGx5IGNvbmZ1c2luZy4gVGhlIGZvcndhcmQgc2xh
c2ggc2VwYXJhdG9yIGFuZCB0aGUgdHdvDQo+ID4+IG51bWJlcnMgaW1tZWRpYXRlbHkgb24gZWFj
aCBzaWRlIG9mIHdoaWNoIGFyZSBsaWtlbHkgdG8gYmUgaW50ZXJwcmV0ZWQgYXMNCj4gPj4gYmVp
bmcgb25lIHVuaXQgKGkuZS4gMjc1Ny8zNDc2KSBidXQgdGhleSdyZSBub3QuIEFsc28gbm90aGlu
ZyBpcyBsYWJlbGVkLA0KPiA+PiBsZWF2aW5nIHRoZSB1c2VyIHRvIHdvbmRlciB3aGF0IHRoZXNl
IG51bWJlcnMgYXJlLg0KPiA+Pg0KPiA+PiBBZGQgbGFiZWxzLCBzcGFjZXMsIGV0Yy4gdG8gaGVs
cCBjbGFyaWZ5IHRoZSBpbmZvcm1hdGlvbiBiaXRiYWtlIGlzIHRyeWluZyB0bw0KPiA+PiBjb252
ZXkuIFRoZSByZXN1bHRpbmcgbGluZSB3b3VsZCBhcHBlYXIgYXM6DQo+ID4+DQo+ID4+IAkzMCBy
dW5uaW5nIHRhc2tzIChzZXRzY2VuZToyNzU3LzI3NTcgdGFza3M6MzQ3Ni82MzkwKQ0KPiA+IEkg
YWdyZWUgd2Ugc2hvdWxkbid0IGhhdmUgdXNlZCAvIGFzIGEgc2VwYXJhdG9yLCBteSBmYXVsdCBv
biB0aGF0Lg0KPiA+DQo+ID4gSWYgd2UncmUgZ29pbmcgdG8gY2hhbmdlIHRoaXMgYWdhaW4gd2Ug
bmVlZCB0byBnZXQgaXQgcmlnaHQgYW5kIEkgZmVlbCB3ZSdyZSBub3QNCj4gPiBxdWl0ZSB0aGVy
ZSB5ZXQuIEkgd2FzIHdvbmRlcmluZyBhYm91dDoNCj4gPg0KPiA+ICAgMzAgcnVubmluZyB0YXNr
cyAoMzQ3NiBvZiA2MzkwKSwgKFNldHNjZW5lOiAyNzU3IG9mIDI3NTcpDQo+IA0KPiBJIGFncmVl
IHRoYXQgdGhpcyB3b3VsZCBiZSBhbiBpbXByb3ZlbWVudC4NCj4gDQo+ID4gd2hpY2ggbW92ZXMg
dGhlICJ0YXNrcyIgY2xvc2VyIHRvZ2V0aGVyIGhvd2V2ZXIgbXkgb3RoZXIgd29ycnkgaXMgdGhh
dCBwZW9wbGUNCj4gPiBkb24ndCBrbm93IHdoYXQgc2V0c2NlbmUgdGFza3MgYXJlIGFuZCB0aGF0
IHRoZSBzZXRzY2VuZSBwaWVjZSBpcyB0aGVuIG5vdA0KPiA+IG9yZGVyZWQgYmVmb3JlIHRhc2tz
Lg0KPiANCj4gWWVzLCB0aGlzIGNvdWxkIGJlIGNvbmZ1c2luZyBmb3IgcGVvcGxlIHdobyBkb24n
dCBrbm93IHdoYXQgc2V0c2NlbmUNCj4gdGFza3MgYXJlLg0KDQpJIGFtIG5vdCBzdXJlIHRoYXQg
YWN0dWFsbHkgbWF0dGVycyB0aGF0IG11Y2guIE15IGd1ZXNzIGlzIHRoYXQgdG8gbWFueSANCnBl
b3BsZSBydW5uaW5nIGJpdGJha2UsIGl0IGlzIGRvaW5nIGJsYWNrIG1hZ2ljLiBBbmQgbm9uZSBv
ZiB0aGUgbnVtYmVycyANCnJlYWxseSBtZWFuIGFueXRoaW5nIHRvIHRoZW0uIEFzIGxvbmcgYXMg
dGhlIG51bWJlcnMga2VlcCBpbmNyZWFzaW5nLCBhbmQgDQp0aGUgYnVpbGQgZmluaXNoZXMgd2hl
biB0aGV5IHJlYWNoIG1heCwgdGhleSB3aWxsIGJlIGhhcHB5Lg0KDQo+ID4gVGhlICJvZiIga2V5
d29yZCBkb2VzIGNsZWFybHkgaW5kaWNhdGUgc29tZXRoaW5nIHRvIHNvbWUNCj4gPiBzdWJncm91
cCBvZiB1c2VycywgSSB0aGluayBJIHdhcyBvbmNlIGFkdmlzZWQgYWJvdXQgdGhhdC4NCg0KSSBj
YW5ub3QgcmVhbGx5IHNlZSB3aHk6DQoNCjMwIHJ1bm5pbmcgdGFza3MgKDM0NzYvNjM5MCksIChT
ZXRzY2VuZTogMjc1Ny8yNzU3KQ0KDQp3b3VsZCBiZSBoYXJkZXIgdG8gdW5kZXJzdGFuZCB0aGFu
Og0KDQozMCBydW5uaW5nIHRhc2tzICgzNDc2IG9mIDYzOTApLCAoU2V0c2NlbmU6IDI3NTcgb2Yg
Mjc1NykNCg0KYnV0IHdpdGggdGhpcyBmb3JtYXR0aW5nLCBlaXRoZXIgdmFyaWFudCBpcyBmaW5l
IHRvIG1lLg0KDQo+ID4gV2UgY291bGQgY29uc2lkZXI6DQo+ID4NCj4gPiAgIFNldHNjZW5lIHRh
c2tzOiAyNzU3IG9mIDI3NTcNCj4gPiAgIDMwIHJ1bm5pbmcgdGFza3M6IDM0NzYgb2YgNjM5MA0K
PiA+DQo+ID4gd2hpY2ggd291bGQgYnJlYWsgdGhlIGNvZGUgYXNzdW1wdGlvbnMgYWJvdXQgYSBz
aW5nbGUgbGluZSBidXQgd2UgY2FuIGxpa2VseSBmaXgNCj4gPiB0aGF0Li4uDQo+IA0KPiBUaGlz
IHdvdWxkIGJlIG11Y2ggY2xlYXJlciBpbmRlZWQuIEkgdm90ZSBmb3IgdGhpcyBzb2x1dGlvbi4N
Cj4gSnVzdCBteSAyIGNlbnRzLg0KDQpJIGRvbid0IHNlZSBhbnkgcmVhbCBiZW5lZml0IGluIHNw
bGl0dGluZyB0aGUgbGluZSBpbiB0d28sIHRvIGJlIGhvbmVzdC4gDQpJdCBqdXN0IHNvdW5kcyBs
aWtlIGEgbG90IG9mIHdvcmsgZm9yIHZlcnkgbGl0dGxlIGdhaW4uDQoNCj4gQ2hlZXJzDQo+IE1p
Y2hhZWwuDQoNCi8vUGV0ZXINCg0K

