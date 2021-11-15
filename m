Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D0C433FE
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 13:13:22 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web09.22167.1636981981981853953
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 05:13:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 0216131E034B;
	Mon, 15 Nov 2021 14:13:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Mon, 15 Nov 2021 14:12:59 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id DA47131E02E9;
	Mon, 15 Nov 2021 14:12:59 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Mon, 15 Nov 2021 14:12:59 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	"kweihmann@outlook.com" <kweihmann@outlook.com>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: 
 AQHX0klmUmLVPFJtF0Ob3PuHG3t8+6v03rAAgAADSACAAAYMgIABSAqAgATTzgCAAmPRAIAAqg6AgAAZFICAAAoTAIAAIckAgAAP84CAAEZSAIAF3wiAgAABtICAAAH/AA==
Date: Mon, 15 Nov 2021 13:12:57 +0000
Message-ID: <11fb4cda62bcc685bd45378071e28f40ce8e8f0e.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
	 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
	 <dd07e5137044429f805caf23114a2e72@axis.com>
	 <c1b45d484d3f55f9522cfa85c58e2acfa7d0e3f1.camel@iris-sensing.com>
	 <83886954b53b47eb93b6ab8a7feebf19@axis.com>
	 <e0ac884bc63e94e0c01a020ef178b7358779776b.camel@iris-sensing.com>
	 <64e41080db7642d0b54818bdcf916dac@axis.com>
	 <699b2927411dbdfdfd01e64ffb16dc057d5bb320.camel@iris-sensing.com>
	 <CANNYZj9LXZjLq9mTxJ7g0T1Zz0XzZHhjiNud9o_kAbuyVb76UA@mail.gmail.com>
	 <2a8ac0a3f85436df2651d4388569dda36a7bfca8.camel@iris-sensing.com>
	 <CANNYZj_J1XaShxLv1d3vsjMV7qdy=L-6a4KvZ0RXDF0A8xRqKg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_J1XaShxLv1d3vsjMV7qdy=L-6a4KvZ0RXDF0A8xRqKg@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E89D45593C83B43B6DDA6B0A026C59E@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Nov 2021 13:13:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13047

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCldpbGwg
ZG8hIDopDQoNClRoaXMgb25seSBhZmZlY3RzIHRoZSBvdGhlciBwYXRjaCBzZXJpZXMgdGhvdWdo
LCB0aGUgcmVjaXBlIGl0c2VsZg0Kc2hvdWxkIGJlIGZpbmUgbm93Lg0KDQpJdCBzZWVtcyB0aGUg
b25seSBxdWVzdGlvbiBsZWZ0IG9wZW4gaXMgdGhpczoNCg0KPiA+IEkgdGhpbmsgd2UgY2FuIHJl
cGxhY2UgdGhlIHBhdGNoIDAwMDEtU2V0LVJFUE9fUkVWLXRvLXYyLjE3LjMucGF0Y2gNCj4gPiB3
aXRoIGEgcG9zdCBmdW5jdGlvbg0KPiA+IGFuZCB3aXRoIGl0IHdlIGNhbiByZXVzZSB0aGUgU1JD
UkVWIG9mIHRoZSByZWNpcGUuIFNvbWV0aGluZyBsaWtlOg0KPiA+IA0KPiA+IGRvX2ZpeF9yZXYo
KXsNCj4gPiAgICAgc2VkIC1pICJzL1JFUE9fUkVWID0gJ3N0YWJsZScvUkVQT19SRVYgPSAnJHtT
UkNSRVZ9JyIgJHtTfS9yZXBvDQo+ID4gfQ0KPiA+IA0KPiA+IGRvX3BhdGNoW3Bvc3RmdW5jc10g
Kz0gImRvX2ZpeF9yZXYiDQo+IA0KPiBZZWFoLi4uIHdhcyB0aGlua2luZyBhYm91dCB0aGF0IGFz
IHdlbGwuIFdhc24ndCBzdXJlIHRob3VnaCBpZiB0aGlzDQo+IHdvdWxkIGJlIGNvbnNpZGVyZWQg
YmFkIHByYWN0aXNlLiBXaGF0IGRvIHRoZSBvdGhlcnMgdGhpbmsgYWJvdXQNCj4gdGhpcz8NCg0K
U29tZSBmZWVkYmFjayBvbiB0aGlzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLiBUaGFua3MhDQoNCi0g
LS0gDQpXaXRoIGJlc3QgcmVnYXJkcw0KDQpKYXNwZXIgT3JzY2h1bGtvDQpEZXZPcHMgRW5naW5l
ZXINCg0KVGVsLiArNDkgMzAgNTggNTggMTQgMjY1DQpGYXggKzQ5IDMwIDU4IDU4IDE0IDk5OQ0K
SmFzcGVyLk9yc2NodWxrb0BpcmlzLXNlbnNpbmcuY29tDQoNCuKAoiDigKIg4oCiIOKAoiDigKIg
4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDi
gKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKINCg0KaXJpcy1HbWJIDQppbmZyYXJlZCAmIGludGVs
bGlnZW50IHNlbnNvcnMNClNjaG5lbGxlcnN0cmHDn2UgMS01IHwgMTI0MzkgQmVybGluDQoNCmh0
dHBzOi8vaXJpcy1zZW5zaW5nLmNvbS8NCg0KDQoNCg0KDQpPbiBNb24sIDIwMjEtMTEtMTUgYXQg
MTQ6MDUgKzAxMDAsIEFsZXhhbmRlciBLYW5hdmluIHdyb3RlOg0KPiBUaGFua3MsIG1heWJlIHlv
dSBzaG91bGQgd3JpdGUgYSB0ZXN0IGZvciBvZmZsaW5lIGJ1aWxkcyBhcyB3ZWxsIHRoZW4NCj4g
OikNCj4gDQo+IEFsZXgNCj4gDQo+IE9uIE1vbiwgMTUgTm92IDIwMjEgYXQgMTM6NTksIEphc3Bl
ciBPcnNjaHVsa28NCj4gPEphc3Blci5PcnNjaHVsa29AaXJpcy1zZW5zaW5nLmNvbT4gd3JvdGU6
DQo+ID4gLS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KPiA+IEhhc2g6IFNIQTI1
Ng0KPiA+IA0KPiA+IEhpIEFsZXhhbmRlciwNCj4gPiANCj4gPiAiW1BBVENIIHYzXSBmZXRjaDIv
cmVwbzogSW1wbGVtZW50IEFVVE9SRVYgZm9yIHJlcG8gZmV0Y2hlciINCj4gPiBjb250YWlucw0K
PiA+IGENCj4gPiBmaXggZm9yIHRoaXMgaXNzdWUuIFJlcHJvZHVjaW5nIGEgYnVpbGQgb2ZmbGlu
ZSB3aXRoIG9ubHkgdGhlDQo+ID4gRExfRElSDQo+ID4gc2hvdWxkIHdvcmsgbm93Lg0KPiA+IA0K
PiA+IFdlIGFyZSBjdXJyZW50bHkgc3RpbGwgbGFja2luZyB0aGUgYXBwcm9wcmlhdGUgdGVzdHMg
Zm9yIHRoZQ0KPiA+IGZldGNoZXIuDQo+ID4gVGhlc2Ugd2lsbCBmb2xsb3cgc29vbi4NCj4gPiAN
Cj4gPiAtIC0tIA0KPiA+IFdpdGggYmVzdCByZWdhcmRzDQo+ID4gDQo+ID4gSmFzcGVyIE9yc2No
dWxrbw0KPiA+IERldk9wcyBFbmdpbmVlcg0KPiA+IA0KPiA+IFRlbC4gKzQ5IDMwIDU4IDU4IDE0
IDI2NQ0KPiA+IEZheCArNDkgMzAgNTggNTggMTQgOTk5DQo+ID4gSmFzcGVyLk9yc2NodWxrb0Bp
cmlzLXNlbnNpbmcuY29tDQo+ID4gDQo+ID4g4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAog0KPiA+IA0KPiA+IGlyaXMtR21iSA0KPiA+IGluZnJhcmVkICYgaW50
ZWxsaWdlbnQgc2Vuc29ycw0KPiA+IFNjaG5lbGxlcnN0cmHDn2UgMS01IHwgMTI0MzkgQmVybGlu
DQo+ID4gDQo+ID4gaHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0KPiA+IA0KPiA+IA0KPiA+IA0K
PiA+IA0KPiA+IA0KPiA+IE9uIFRodSwgMjAyMS0xMS0xMSBhdCAyMDoyMCArMDEwMCwgQWxleGFu
ZGVyIEthbmF2aW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDExIE5vdiAyMDIxIGF0IDE2OjA4LCBK
YXNwZXIgT3JzY2h1bGtvDQo+ID4gPiA8SmFzcGVyLk9yc2NodWxrb0BpcmlzLXNlbnNpbmcuY29t
PiB3cm90ZToNCj4gPiA+ID4gU28gaWYgeW91IGhhdmUgZG9uZSB0aGlzIGluaXRpYWwgZmV0Y2gg
b2YgeW91ciBzb3VyY2VzIGFuZA0KPiA+ID4gPiBzdGFzaA0KPiA+ID4gPiB5b3VyDQo+ID4gPiA+
IHdvcmtpbmcgZGlyIGF3YXksIHlvdSBjYW4gZG8gYW4gb2ZmbGluZSBidWlsZC4NCj4gPiA+IA0K
PiA+ID4gQnV0IGNhbiB5b3UgZG8gYW4gb2ZmbGluZSBidWlsZCB3aXRob3V0IGEgcHJlcG9wdWxh
dGVkIHdvcmtpbmcNCj4gPiA+IGRpcj8NCj4gPiA+IFRoYXQncyB0aGUgY3J1Y2lhbCBwb2ludDog
b2ZmbGluZSBidWlsZCBzaG91bGQgd29yayBpbiBhIGZyZXNobHkNCj4gPiBzZXQNCj4gPiA+IHVw
IGJ1aWxkIGRpcmVjdG9yeSwgd2l0aG91dCBzc3RhdGUgY2FjaGUsIGFuZCB3aXRoIHByZXBvcHVs
YXRlZA0KPiA+ID4gRExfRElSIG9ubHkuDQo+ID4gPiANCj4gPiA+IEFsZXgNCj4gPiAtLS0tLUJF
R0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KPiA+IA0KPiA+IGlRRXpCQUVCQ0FBZEZpRUU0V3lQTUlD
NUFwNCtPb28xWWdxZXcwN1ZNTlVGQW1HU1diNEFDZ2tRWWdxZXcwN1YNCj4gPiBNTlZVWVFnQWdB
Nis4WEkrSnh0QTUzMkZOTklNQVpHNVpHWjEyR0t2Vmtqb0pFcm56UmYwUlp4VUczVXlOWW1tDQo+
ID4gcFNEY2ZidW9kQm1CYkh4REJwTjhWc3BUb0taeThkS2NtL2pmZTlVWTdmOVUzOWJaU05YU1Mz
aE5QcWtxS1A1Sg0KPiA+IGpDZzF6UWZ4amJXMWFWU0hKa1FCNU1vWS9FRGVvUVZ2N1JJNlJtY1Zz
TEpaeG96UGVZYU9RV1NkVE5HLzdjemcNCj4gPiBvRmpLcjZqdFNPWU80NXRlTUd0MysyK0F0QVho
bHpUZ0tabzMzclgvdGtuUzdmMStra3lOR0x2MHNzU1A1SmNmDQo+ID4gQmQ4WWJjZEc5bHFYS1Vv
MEE3cm45UTgzWUJkcEl5QTYrQnkxNTl6elB5N2JQOGo5YXFNSDhuTldhdWFoaGNGUw0KPiA+IHNZ
MzlmaWt5NTdhRWdNZTdnMU9aWDhvUk9Eb3dQQT09DQo+ID4gPWhwQUsNCj4gPiAtLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0NCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tDQoNCmlRRXpC
QUVCQ0FBZEZpRUU0V3lQTUlDNUFwNCtPb28xWWdxZXcwN1ZNTlVGQW1HU1hOa0FDZ2tRWWdxZXcw
N1YNCk1OVUttUWYvVVlUVVJQS1owaVkyTUtQRkI2MFdkbm1zVEtKTWpvdFFsY1ZCVXBpd1E2TGhT
cGtmV1JxT0ZMcE4NCm5hOWNOWmJZakdGZUROZEwzZDBJTE9FUStvVmhMWTdiUXBqNVhiMm5Ec0lX
c3BqbEhnMUlra3ZDVkdhOXpGYjMNClhBTGFEckdCcmxhZDlLTmhJNEMyQ21YamRKWmd4M3lCdXV2
SzZtU2lnYTVmczQ0UUIvbEJiOUpPUUdZdWNSdCsNClFlTGtJYXR2Rm8xSnh6bWM2dE5rUnIzb3Nn
YWNRcm9hZ0hqNENJU2g1VytleldxdGRXSEE1bmRmNEh2Q053SlYNCmhrcHlYdHhlUURJTkdWR0Jz
TW5Ka09JV1JTU3RPdmlMNjZRMWg1L2RnYkoyM0ZYUXVFa005Q3lEMTlrWFdTSVcNClpTSTZhczRi
empEcURWUHpDUFdIRG1RZFNuSnlYUT09DQo9YU5LNg0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0t
LS0tDQo=

