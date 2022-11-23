Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DBC4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 04:33:42 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.12846.1669178020517108693
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Nov 2022 20:33:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=jptzubAS;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669178020;
  x=1700714020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FRy9pt4D3fzbySN/mSE9bTIOp9J8r6OfW0xw3CEnnew=;
  b=jptzubASy5WrDnNtlH5woeJZDPJXzppCpAMEFo5smyJlzgmw4927cSSH
   HXwOoiLsVHw7/MKa3MYfcUENyuXkm/Z2Atzw71bDLV3l8VbBS0zaB30MS
   a9yPGNrwpq3hhLw/dLJn/Ij6L1/XJEXZ9zgkIzOusxPL8Se1l2CYuh7Np
   zJlfASIVAnnFLxaNyj0NQzfCBtD+aYlMoJPS2k4NoEyOTlD8W/J+8IUYv
   wk5i6g35+q0i4pyD9tfN/VgnyazD/VmHJRjSq3JSCOL1e/8NWdtBrOXCw
   aj47KoTEORZV7qxxpqhDAaQU8rVIZsHiZD4SmqlyNDJBGv8gQFiourGAx
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
CC: Joshua Watt <JPEWhacker@gmail.com>
Subject: RE: [bitbake-devel] Cache timings with various changes
Thread-Topic: [bitbake-devel] Cache timings with various changes
Thread-Index: AQHY/s+O0U5X7Asx2EKOX4EszlIubK5L3HoQ
Date: Wed, 23 Nov 2022 04:33:37 +0000
Message-ID: <87f9939926fd4a488abb8e6442c6100a@axis.com>
References: <f963c6619df931162db7de468699d2aad0c1b76a.camel@linuxfoundation.org>
In-Reply-To: <f963c6619df931162db7de468699d2aad0c1b76a.camel@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 04:33:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14100

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllDQo+IFNlbnQ6IGRlbiAyMyBub3ZlbWJlciAyMDIy
IDAxOjA3DQo+IFRvOiBiaXRiYWtlLWRldmVsIDxiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmc+DQo+IENjOiBKb3NodWEgV2F0dCA8SlBFV2hhY2tlckBnbWFpbC5jb20+DQo+IFN1
YmplY3Q6IFtiaXRiYWtlLWRldmVsXSBDYWNoZSB0aW1pbmdzIHdpdGggdmFyaW91cyBjaGFuZ2Vz
DQo+IA0KPiBJJ3ZlIHRhbGtlZCBhYm91dCBjaGFuZ2luZyB0aGUgZGF0YSB3ZSBjYWNoZSBpbiB2
YXJpb3VzIGZvcnVtcy4gVGhlc2UNCj4gYXJlIHNvbWUgYWN0dWFsIG51bWJlcnMgZnJvbSBhIGxv
Y2FsIHN5c3RlbSAoODggY29yZSk6DQo+IA0KPiBQYXRjaCAgICAgICAgICAgICAgICAgICBGdWxs
IHJlcGFyc2UgdGltZSAgICBDYWNoZSBsb2FkIHRpbWUgICAgQ2FjaGUgc2l6ZSAoY29tcHJlc3Nl
ZCkgICAgIENhY2hlIHNpemUgKHVuY29tcHJlc3NlZCkNCj4gLS0tLS0gICAgICAgICAgICAgICAg
ICAgLS0tLS0tLS0tLS0tLS0tLS0gICAgLS0tLS0tLS0tLS0tLS0tICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IG1hc3RlciBiYXNlbGlu
ZSAgICAgICAgIDUuNzMycyAgICAgICAgICAgICAgIDIuMjYxcyAgICAgICAgICAgICBOL0EgICAg
ICAgICAgICAgICAgICAgICAgICAgMjRNDQo+IGZyb3plbnNldCBjaGFuZ2VzICAgICAgIDQuMzI2
cyAgICAgICAgICAgICAgIDIuMjg5cyAgICAgICAgICAgICBOL0EgICAgICAgICAgICAgICAgICAg
ICAgICAgMjRNDQo+IHBpY2tsZSBpbiBvbmUgICAgICAgICAgIDQuNTA5cyAgICAgICAgICAgICAg
IDIuMTc3cyAgICAgICAgICAgICBOL0EgICAgICAgICAgICAgICAgICAgICAgICAgMjRNDQo+IGNv
bXByZXNzIHdpdGggenN0ZCAgICAgIDYuMDQwcyAgICAgICAgICAgICAgIDIuMjA0cyAgICAgICAg
ICAgICAzLjRNICAgICAgICAgICAgICAgICAgICAgICAgMjRNDQo+IGFkZCBoYXNoIGRhdGEgdG8g
Y2FjaGUgIDkuNjkzcyAgICAgICAgICAgICAgIDQuMzI3cyAgICAgICAgICAgICAxN00gICAgICAg
ICAgICAgICAgICAgICAgICAgODNNDQo+IA0KPiBJdCBzZWVtcyB0aGUgZnJvemVuc2V0IGltcHJv
dmVtZW50cyBJIGhhdmUgc3BlZWQgdGhpbmdzIHVwIG5pY2VseSBhbmQNCj4gbG9vayBsaWtlIGEg
Z29vZCBjaGFuZ2UuIFRoZSBjb21wcmVzc2lvbiBkb2VzIHNsb3cgdGhpbmdzIGRvd24sIGFzIGRv
ZXMNCj4gcGlja2xpbmcgdGhlIGNhY2hlIGluIG9uZSBnby4NCj4gDQo+IFRoZSBwYXRjaGVzIGFy
ZSBpbiBwb2t5LWNvbnRyaWIgcnB1cmRpZS90MjIyLiBJJ2xsIHBvc3QgdGhlIGZyb3plbnNldA0K
PiBvbmUsIHRoZSBvdGhlcnMgbG9vayBsaWtlIHRoZXkgbmVlZCBtb3JlIHRob3VnaHQuDQo+IA0K
PiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCk5vdCBzdXJlIGhvdyB5b3UgbWVhc3VyZWQgdGhl
IHRpbWVzLCBzbyBJIGp1c3QgbG9va2VkIGF0IHRoZSBwcm9ncmVzcyBiYXJzIA0KZm9yICJMb2Fk
aW5nIGNhY2hlIiBhbmQgIlBhcnNpbmcgcmVjaXBlcyIuIFdpdGggb3VyIGxheWVycyAoNDcxNyBy
ZWNpcGVzKSANCmFuZCBteSBjb21wdXRlciB3aXRoIDggY29yZXMgKDE2IHRocmVhZHMpLCB0aGlz
IGlzIHdoYXQgSSBnb3Q6DQoNCiogV2l0aG91dCBycHVyZGllL3QyMjIgYXBwbGllZCwgaXQgdGFr
ZXMgMC0yIHMgdG8gbG9hZCB0aGUgY2FjaGUsIGl0IHRha2VzIA0KICA0My00NiBzIHRvIHBhcnNl
IHRoZSByZWNpcGVzIGFuZCB0aGUgY2FjaGUgaXMgMTg1IE1CLg0KKiBBZnRlciBhcHBseWluZyB1
cCB0byAiY2FjaGU6IFN3aXRjaCB0byBjb21wcmVzc2luZyB0aGUgY2FjaGUgZmlsZSB3aXRoIA0K
ICB6c3RkIiwgdGhlIGNhY2hlIGxvYWQgYW5kIHJlY2lwZSBwYXJzZSB0aW1lcyByZW1haW5zIHRo
ZSBzYW1lLCBidXQgdGhlIA0KICBzaXplIG9mIHRoZSBjYWNoZSBkZWNyZWFzZXMgdG8gMTcgTUIN
CiogV2l0aCBhbGwgb2YgcnB1cmRpZS90MjIyIGFwcGxpZWQgaXQgdGFrZXMgMi0zIHRvIGxvYWQg
dGhlIGNhY2hlLCA1MS01MyBzIA0KICB0byBwYXJzZSB0aGUgcmVjaXBlcyBhbmQgdGhlIGNhY2hl
IGlzIDU1IE1CLg0KDQovL1BldGVyDQoNCg==

