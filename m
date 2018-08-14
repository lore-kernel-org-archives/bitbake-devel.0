Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C008078FCF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 10:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 22772182AA;
	Tue, 14 Aug 2018 12:29:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id a3JpaOxyT-6a; Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 5E3BC18355;
	Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CAB1A06D;
	Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E151A067;
	Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 285002F24;
	Tue, 14 Aug 2018 12:28:59 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Tue, 14 Aug 2018 12:28:58 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1365.000; Tue, 14 Aug 2018 12:28:58 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Alexander Kanavin
	<alex.kanavin@gmail.com>, "Mikko.Rapeli@bmw.de" <Mikko.Rapeli@bmw.de>, 
	=?utf-8?B?QW5kcmVhcyBNw7xsbGVy?= <schnitzeltony@gmail.com>, Martin Jansa
	<martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 2/2] runqueue: Introduce load balanced
	task spawning
Thread-Index: AQHUM0uGudpsZxnOZ0qzjRhMO9+KWqS+T0uAgABZngCAABq5gIAAGs6AgAAAc4CAACvtQA==
Date: Tue, 14 Aug 2018 10:28:58 +0000
Message-ID: <75dc7178b6204b0d898f136ab9cceeb4@XBOX02.axis.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<8ac13026f3f66ce8a652d760162bb4cf74e13ebd.camel@linuxfoundation.org>
In-Reply-To: <8ac13026f3f66ce8a652d760162bb4cf74e13ebd.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 10:29:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8Yml0YmFrZS1kZXZlbC0NCj4gYm91bmNlc0BsaXN0
cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgUmljaGFyZCBQdXJkaWUNCj4gU2VudDog
ZGVuIDE0IGF1Z3VzdGkgMjAxOCAxMTo0NQ0KPiBUbzogQWxleGFuZGVyIEthbmF2aW4gPGFsZXgu
a2FuYXZpbkBnbWFpbC5jb20+OyBNaWtrby5SYXBlbGlAYm13LmRlOw0KPiBBbmRyZWFzIE3DvGxs
ZXIgPHNjaG5pdHplbHRvbnlAZ21haWwuY29tPjsgTWFydGluIEphbnNhDQo+IDxtYXJ0aW4uamFu
c2FAZ21haWwuY29tPg0KPiBDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDIvMl0gcnVucXVldWU6IElu
dHJvZHVjZSBsb2FkDQo+IGJhbGFuY2VkIHRhc2sgc3Bhd25pbmcNCj4gDQo+IE9uIFR1ZSwgMjAx
OC0wOC0xNCBhdCAxMDo0MyArMDEwMCwgUmljaGFyZCBQdXJkaWUgd3JvdGU6DQo+ID4gT24gVHVl
LCAyMDE4LTA4LTE0IGF0IDEwOjA3ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90ZToNCj4g
PiA+IDIwMTgtMDgtMTQgODozMiBHTVQrMDI6MDAgIDxNaWtrby5SYXBlbGlAYm13LmRlPjoNCj4g
PiA+ID4gSnVzdCBteSAyIOKCrCBjZW50cyB0byB0aGUgZGlzY3Vzc2lvbjoNCj4gPiA+ID4NCj4g
PiA+ID4gd2UgaGFkIHRvIGxpbWl0IG51bWJlciBvZiB0aHJlYWRzIGJlY2F1c2UgaGVhdnkgQysr
IHByb2plY3RzIA0KPiA+ID4gPiB3ZXJlIHVzaW5nIGFsbCBvZiBSQU0gYW5kIGNhdXNpbmcgaGVh
dnkgc3dhcHBpbmcuIFNpbmdsZSBnKysgDQo+ID4gPiA+IHByb2Nlc3NlcyB3ZXJlIGVhdGluZyB1
cCB0byAyMCBnaWdhYnl0ZXMgb2YgcGh5c2ljYWwgcmFtLiANCj4gPiA+ID4gSXQncyBub3QganVz
dCB0aGUgQ1BVIHdoaWNoIGlzIHRoZSBsaW1pdGluZyBmYWN0b3IgdG8gDQo+ID4gPiA+IHBhcmFs
bGVsIHRhc2sgZXhlY3V0aW9uLg0KPiA+ID4NCj4gPiA+IEkgZG8gYmVsaWV2ZSBzb21lIGtpbmQg
b2YgY2xldmVyIGR5bmFtaWMgbGltaXRlciB3b3VsZCBiZQ0KPiA+ID4gdXNlZnVsIGhlcmUuIE9i
dmlvdXNseSBpdCdzIGFuIGFic3VyZCBzaXR1YXRpb24gd2hlbiBvbiBhIDMyIA0KPiA+ID4gY29y
ZSBwcm9jZXNzb3IgdGhlcmUgYXJlIDMyIGRvX2NvbXBpbGUgYysrIHRhc2tzLCBlYWNoIHJ1bm5p
bmcgDQo+ID4gPiAzMiBpbnN0YW5jZXMgb2YgZysrIC0gd2hpY2ggaXMgdGhlIGRlZmF1bHQgY29u
ZmlndXJhdGlvbi4gT24gDQo+ID4gPiB0aGUgb3RoZXIgaGFuZCBydW5uaW5nIHRoaW5ncyBsaWtl
IGRvX2NvbmZpZ3VyZSBvciBkb19pbnN0YWxsIA0KPiA+ID4gc2hvdWxkIGhhcHBlbiBpbiBwYXJh
bGxlbC4gSSBsaWtlIEFuZHJlJ3MgaWRlYSwgYnV0IGl0IHNob3VsZCANCj4gPiA+IGFsc28gd2F0
Y2ggdGhlIGF2YWlsYWJsZSBSQU0uDQo+ID4NCj4gPiBJZiBwZW9wbGUgd2FudCB0byBwbGF5LCBJ
IGRpZCBleHBlcmltZW50IHdpdGggInByb3BlciIgdGhyZWFkDQo+ID4gcG9vbGluZzoNCj4gPg0K
PiA+IGh0dHA6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9jZ2l0LmNnaS9wb2t5LWNvbnRyaWIvY29t
bWl0Lz9oPXJwdXJkaWUvd2lwcXVldWU0JmlkPWQ2NmEzMjdmYjYxODlkYjVkZThiYzQ4OTg1OTIz
NWRjYmEzMDYyMzcNCj4gDQo+IE1vcmUgcmVjZW50IHZlcnNpb24gb2YgdGhlIHBhdGNoOg0KPiAN
Cj4gaHR0cDovL2dpdC55b2N0b3Byb2plY3Qub3JnL2NnaXQuY2dpL3Bva3ktY29udHJpYi9jb21t
aXQvP2g9cnB1cmRpZS93aXBxdWV1ZTcmaWQ9MjM2Y2E4YmUxMjhiYTdhNGVkYjlmYjJjOWU1MTJk
MTgxNjc5ZWVlOA0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KDQpFdmVuIHRob3VnaCBt
YWtlIGlzIHRoZSBwcmV2YWxlbnQgdG9vbCB1c2VkIHRvIGJ1aWxkIGNvZGUsIHdlIGhhdmUgDQp0
byBjb25zaWRlciBvdGhlcnMgc3VjaCBhcyBjbWFrZSBhbmQgbWVzb24uLi4gQW55IGlkZWEgaWYg
dGhlaXIgDQpwYXJhbGxlbGlzbSBjYW4gYmUgY29udHJvbGxlZCBpbiBzb21lIHNpbWlsYXIgd2F5
Pw0KDQovL1BldGVyDQoNCg==

