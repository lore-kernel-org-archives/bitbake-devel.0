Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69524C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 10:04:49 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web09.8659.1636625087596107230
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 02:04:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 2507531E033F;
	Thu, 11 Nov 2021 11:04:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Thu, 11 Nov 2021 11:04:39 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 0E19031E02E9;
	Thu, 11 Nov 2021 11:04:39 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Thu, 11 Nov 2021 11:04:38 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	<kweihmann@outlook.com>, "peter.kjellerstedt@axis.com"
	<peter.kjellerstedt@axis.com>, "jasper@fancydomain.eu"
	<jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: 
 AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIABSAqAgATTzgCAAmPRAIAAqg6A
Date: Thu, 11 Nov 2021 10:04:38 +0000
Message-ID: <c1b45d484d3f55f9522cfa85c58e2acfa7d0e3f1.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
	 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
	 <dd07e5137044429f805caf23114a2e72@axis.com>
In-Reply-To: <dd07e5137044429f805caf23114a2e72@axis.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB84FCC80815604E8CEF67D551128466@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 10:04:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13002

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkhpIFBl
dGVyLA0KDQo+IEhvdyBkbyB5b3UgYXZvaWQgdGhlIHJlcG8gd3JhcHBlciBmZXRjaGluZyB0aGUg
cmVwbyBzb3VyY2UgaXRzZWxmIA0KPiBhbmQgaW5zdGVhZCBmZXRjaCBpdCB1c2luZyB0aGUgYml0
YmFrZSBmZXRjaGVyPyBJIGhhdmUgc2VlbiBub3RoaW5nDQo+IHRvIHRoYXQgZXh0ZW50IGluIHRo
ZSBwYXRjaGVzIHNvIGZhci4NCg0Kd2UgZG9uJ3QuIFRoaXMgcmVjaXBlIG9ubHkgaW5zdGFsbHMg
dGhlIHJlcG8gd3JhcHBlci4gVGhlIHNvdXJjZSBjb2RlDQppcyBkb3dubG9hZGVkIGFuZCBpbnN0
YWxsZWQgd2hlbiBydW5uaW5nIGByZXBvIGluaXRgLg0KDQpIb3dldmVyLCBpbiBvdXIgb3Bpbmlv
biB0aGlzIGlzIG5vdCBhbiBpc3N1ZS4gV2hlbiBpbnN0YWxsaW5nIHJlcG8gYXMgYQ0KcGFja2Fn
ZSB0byBhIHRhcmdldCwgdGhpcyBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3VyLiBUaGUgdGFyZ2V0
IHdvdWxkDQpvbmx5IGhhdmUgdGhlIHJlcG8gd3JhcHBlciBpbnN0YWxsZWQsIGp1c3QgbGlrZSBv
biBhbnkgb3RoZXIgbGludXgNCmRpc3Ryb2J1dGlvbi4gVGhlIGFjdHVhbCB1c2FnZSBvZiByZXBv
IG9uIHRoZSB0YXJnZXQgaXMgZGVjb3VwbGVkIGZyb20NCnRoZSBiaXRiYWtlIGJ1aWxkIHByb2Nl
c3MuDQoNCldoZW4gdXNpbmcgdGhlIHJlcG8gZmV0Y2hlciwgdGhlIHJlcG8gc291cmNlIGlzIGZl
dGNoZWQgZHVyaW5nIHRoZQ0KZG9fZmV0Y2ggc3RhZ2UgYnkgcnVubmluZyBgcmVwbyBpbml0YCAo
d2hlbiBTUkNSRVYgPSBBVVRPUkVWLCBjaGFuZ2VzDQp0byB0aGUgcmVjaXBlIG9yIG5vIHByZXZp
b3VzIHNvdXJjZXMgYXZhaWxhYmxlIGluIERMX0RJUikuIEJ5IGV4ZWN1dGluZw0KdGhpcyB3aXRo
aW4gdGhlICJydW5mZXRjaGNtZCIgZnVuY3Rpb24sIHRoaXMgYWxzbyB3b3JrcyB3aXRoIHRoZSB1
c3VhbA0KbmV0d29yayBmZWF0dXJlcyBiaXRiYWtlIHByb3ZpZGVzLCBlLmcuIHByb3h5Lg0KSWYg
dGhlIHJlY2lwZSBoYXMgbm90IGNoYW5nZWQgYW5kIHNvdXJjZXMgYXJlIGFscmVhZHkgYXZhaWxh
YmxlIGZyb20gYQ0KcHJldmlvdXMgcnVuLCByZXBvIHdpbGwgbm90IGJlIHJlcnVuLiBBcyBzdWNo
LCByZXByb2R1Y2luZyBhIGJ1aWxkDQpvZmZsaW5lIGlzIGFsc28gcG9zc2libGUuDQoNCi0gLS0g
DQpXaXRoIGJlc3QgcmVnYXJkcw0KDQpKYXNwZXIgT3JzY2h1bGtvDQpEZXZPcHMgRW5naW5lZXIN
Cg0KVGVsLiArNDkgMzAgNTggNTggMTQgMjY1DQpGYXggKzQ5IDMwIDU4IDU4IDE0IDk5OQ0KSmFz
cGVyLk9yc2NodWxrb0BpcmlzLXNlbnNpbmcuY29tDQoNCuKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg
4oCiIOKAoiDigKIg4oCiIOKAoiDigKINCg0KaXJpcy1HbWJIDQppbmZyYXJlZCAmIGludGVsbGln
ZW50IHNlbnNvcnMNClNjaG5lbGxlcnN0cmHDn2UgMS01IHwgMTI0MzkgQmVybGluDQoNCmh0dHBz
Oi8vaXJpcy1zZW5zaW5nLmNvbS8NCg0KDQoNCg0KDQpPbiBXZWQsIDIwMjEtMTEtMTAgYXQgMjM6
NTUgKzAwMDAsIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToNCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9y
Z8KgPGJpdGJha2UtDQo+ID4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gT24gQmVoYWxm
IE9mIEphc3BlciBPcnNjaHVsa28NCj4gPiBTZW50OiBkZW4gOSBub3ZlbWJlciAyMDIxIDEyOjI2
DQo+ID4gVG86IHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc7IG9wZW5lbWJlZGRl
ZC0NCj4gPiBjb3JlQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc7IGt3ZWlobWFubkBvdXRsb29rLmNv
bTsNCj4gPiBqYXNwZXJAZmFuY3lkb21haW4uZXUNCj4gPiBDYzogbWFydGluQG1rby5kZXY7IERh
bmllbC5CYXVtZ2FydEBpcmlzLXNlbnNpbmcubmV0OyBiaXRiYWtlLQ0KPiA+IGRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtvZS1j
b3JlXVtQQVRDSCAxLzJdIGRldnRvb2xzOiBJbml0aWFsDQo+ID4gcmVjaXBlDQo+ID4gZm9yIHJl
cG8gMi4xNy4zDQo+ID4gDQo+ID4gLS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0K
PiA+IEhhc2g6IFNIQTI1Ng0KPiA+IA0KPiA+IEhpIFJpY2hhcmQsDQo+ID4gDQo+ID4gSSB0aGlu
ayBvdXIgaW1wbGVtZW50YXRpb24gb2YgdGhlIHJlcG8gZmV0Y2hlciBjaGVja3MgdGhlICh3aGF0
IEkNCj4gPiBiZWxpZXZlIHRvIGJlKSBtb3N0IHJlbGV2YW50IHBhcnRzIG9mIHlvdXIgY2hlY2ts
aXN0ICh0aGFua3MgZm9yIHRoZQ0KPiA+IHdyaXRlLXVwKS4gTWFydGluLCBwbGVhc2UgY29ycmVu
dCBtZSBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmc6DQo+ID4gDQo+ID4gPiBhKSBuZXR3b3JrIGFj
Y2VzcyBmb3Igc291cmNlcyBpcyBvbmx5IGV4cGVjdGVkIHRvIGhhcHBlbiBpbiB0aGUNCj4gPiA+
IGRvX2ZldGNoIHN0ZXAuDQo+ID4gPiBUaGlzIGlzIG5vdCBlbmZvcmNlZCBvciB0ZXN0ZWQgYnV0
IGlzIHJlcXVpcmVkIHNvIHRoYXQgd2UgY2FuOg0KPiA+ID4gDQo+ID4gPiDCoGkpIGF1ZGl0IHRo
ZSBzb3VyY2VzIHVzZWQgKGkuZS4gZm9yIGxpY2Vuc2UvbWFuaWZlc3QgcmVhc29ucykNCj4gPiA+
IMKgaWkpIHN1cHBvcnQgb2ZmbGluZSBidWlsZHMgd2l0aCBhIHN1aXRhYmxlIGNhY2hlDQo+ID4g
PiDCoGlpaSkgYWxsb3cgd29yayB0byBjb250aW51ZSBldmVuIHdpdGggZG93bnRpbWUgdXBzdHJl
YW0NCj4gPiA+IMKgaXYpIGFsbG93IGZvciBjaGFuZ2VzIHVwc3RyZWFtIGluIGluY29tcGF0aWJs
ZSB3YXlzDQo+ID4gPiDCoHYpIGFsbG93IHJlYnVpbGRpbmcgb2YgdGhlIHNvZnR3YXJlIGluIFgg
eWVhcnMgdGltZQ0KPiA+IA0KPiA+IGNoZWNrDQo+ID4gDQo+ID4gPiBiKSBuZXR3b3JrIGFjY2Vz
cyBpcyBub3QgZXhwZWN0ZWQgaW4gZG9fdW5wYWNrDQo+ID4gDQo+ID4gY2hlY2sNCj4gDQo+IEhv
dyBkbyB5b3UgYXZvaWQgdGhlIHJlcG8gd3JhcHBlciBmZXRjaGluZyB0aGUgcmVwbyBzb3VyY2Ug
aXRzZWxmIA0KPiBhbmQgaW5zdGVhZCBmZXRjaCBpdCB1c2luZyB0aGUgYml0YmFrZSBmZXRjaGVy
PyBJIGhhdmUgc2VlbiBub3RoaW5nIA0KPiB0byB0aGF0IGV4dGVudCBpbiB0aGUgcGF0Y2hlcyBz
byBmYXIuDQo+IA0KPiAvL1BldGVyDQo+IA0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0N
Cg0KaVFFekJBRUJDQUFkRmlFRTRXeVBNSUM1QXA0K09vbzFZZ3FldzA3Vk1OVUZBbUdNNnJVQUNn
a1FZZ3FldzA3Vg0KTU5VQ0lBZitNWEdwOUhuZnhtdSs4dzNCYXNWc1AyTjd0dFcyRk4zWnJvaXly
L2hLckp6ZXEvcURRd08rL0szVQ0KeldaSjg1SDZMMmVUak9QOGZQYUhiVk1SRDFqVW9ZVnBZVUFF
L2ZONjRGYmhDQm11clZ1V0ZyTG8vdTZHeTJjVQ0KRENkM1NJZWpYaWRCMjVFUVJvUzRCZmwyNWls
MXdHNGlNdzFwQ0ZBNmt1NXJHaGI4cTVqdmZaRUNmMFd1aGg3WA0KRm5NUWxJM1Zac1NrNENha0Yz
Zzg4QUZUTEZyc1FZY04ydkRVc2tkaE1mVFpwdVJBOGR1SXZXNHJWZ092SEpRVA0KdjA3ckFTTlIv
OXl6UFJWa3pwZ1BVSTlWbDJMQTN2RVozUmNjdzNqc2NZSEZ3a3pqMDA5NkRPNCtqZUR3eXphNQ0K
ZkZtMGREVDlIakd1elR6NjZjNUpMOHNkWlppOXB3PT0NCj1BT3lwDQotLS0tLUVORCBQR1AgU0lH
TkFUVVJFLS0tLS0NCg==

