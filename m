Return-Path: <Joao.CCabral@parceiros.nos.pt>
Received: from mail.nos.pt (mail.nos.pt [194.79.86.52])
	by mail.openembedded.org (Postfix) with ESMTP id 1F65860C71
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2020 17:34:06 +0000 (UTC)
Received: from PO2EXC013.corporativo.pt (10.227.74.91) by
	LX3EXC013.corporativo.pt (10.228.74.245) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Thu, 13 Feb 2020 17:34:05 +0000
Received: from PO2EXC013.corporativo.pt (10.227.74.96) by
	PO2EXC013.corporativo.pt (10.227.74.96) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Thu, 13 Feb 2020 17:34:05 +0000
Received: from PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6]) by
	PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6%21]) with mapi id
	15.00.1395.000; Thu, 13 Feb 2020 17:34:05 +0000
From: "Joao Carlos Cabral (P)" <Joao.CCabral@parceiros.nos.pt>
To: "armccurdy@gmail.com" <armccurdy@gmail.com>
Thread-Topic: [bitbake-devel] [HELP] Create a new image recipe based on a
	(changed) existing one
Thread-Index: AQHV358opy/+hFiacEiPKhEmZbhQdqgTgT6ogAFtIwCABHn0gA==
Date: Thu, 13 Feb 2020 17:34:05 +0000
Message-ID: <3cb24a9342e09cea61c0bde03c26d165588faf96.camel@parceiros.nos.pt>
References: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
	<1581290815745.54479@parceiros.nos.pt>
	<CAJ86T=VC+8Dd7jb+yPkvvfD8RMCrV6ATHf8etS7YV+krJbeFgA@mail.gmail.com>
In-Reply-To: <CAJ86T=VC+8Dd7jb+yPkvvfD8RMCrV6ATHf8etS7YV+krJbeFgA@mail.gmail.com>
Accept-Language: en-US, pt-PT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.166]
x-tm-snts-smtp: 4924160BC70AC222266ACAD64026BF84DF54F1C332F181C6023ECCDBCBA60EF92000:8
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 15 Feb 2020 09:30:45 +0000
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [HELP] Create a new image recipe based on a (changed) existing one
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
X-List-Received-Date: Thu, 13 Feb 2020 17:34:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA27B475F39CED4197800147E8FF113F@nos.pt>
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB5b3VyIGFuc3dlci4NCg0KVXNpbmcgeW91ciBtZXRob2QsIGhvdyBjb3VsZCBJ
IGNyZWF0ZSB0aGUgbm9ybWFsIGltYWdlIGFuZCB0aGUgZGV2IG9uZT8NCg0KKiBiaXRiYWtlIHBy
b2R1Y3QgLSB3b3VsZCBwcm9kdWNlIHRoZSBub3JtYWwgb25lPw0KKiBiaXRiYWtlIG15LWltYWdl
IC0gd291bGQgcHJvZHVjZSB0aGUgZGV2IG9uZT8NCg0KSSBzdGlsbCBuZWVkIHRvIGNyZWF0ZSB0
aGUgIm5vcm1hbCIgd2hlbiBlbmRpbmcgYSBkZXZlbG9wIHBoYXNlLg0KDQpUaGFua3MNCg0KSm/D
o28gQ2FicmFsIA0KDQpPbiBNb24sIDIwMjAtMDItMTAgYXQgMTM6MTIgLTA4MDAsIEFuZHJlIE1j
Q3VyZHkgd3JvdGU6DQo+IE9uIE1vbiwgRmViIDEwLCAyMDIwIGF0IDY6MTUgQU0gSm9hbyBDYXJs
b3MgQ2FicmFsIChQKQ0KPiA8Sm9hby5DQ2FicmFsQHBhcmNlaXJvcy5ub3MucHQ+IHdyb3RlOg0K
PiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IEknbSB0cnlpbmcgdG8gY3JlYXRlIGEgaW1hZ2UgcmVj
aXBlIGJhc2VkIG9uIGEgZXhpc3Rpbmcgb25lLg0KPiA+IEkndmUgc2VhcmNoZWQgb25saW5lLCBh
bmQgSSBjb3VsZCBmaW5kIHN1Y2ggYW4gZXhhbXBsZS4NCj4gPiANCj4gPiBNeSBwcm9ibGVtIGlz
IHRoYXQgdGhlIGltYWdlIEkgd2hhdCB0byBzZXJ2ZSBhcyBhIGJhc2UgaXMgY2hhbmdlZA0KPiA+
IGluDQo+ID4gYW5vdGhlciBsYXllciwgYW5kIEkgd2FudCB0byBpbmNsdWRlIHRoYXQgY2hhbmdl
cy4NCj4gPiANCj4gPiBFeDoNCj4gPiANCj4gPiAodHJlZSkNCj4gPiANCj4gPiBQcmpfcm9vdA0K
PiA+ICAgICAtPiBsYXllcjENCj4gPiAgICAgICAgIC0+IHJlY2lwZXMtY29yZQ0KPiA+ICAgICAg
ICAgICAgIC0+IGltYWdlcw0KPiA+ICAgICAgICAgICAgICAgICAtPiBteS1pbWFnZS5iYiAgW1Ro
aXMgaXMgdGhlIGJhc2UgcmVjaXBlXQ0KPiA+ICAgICAtPiBsYXllcjINCj4gPiAgICAgICAgIC0+
IHJlY2lwZXMtY29yZQ0KPiA+ICAgICAgICAgICAgIC0+IGltYWdlcw0KPiA+ICAgICAgICAgICAg
ICAgICAtPiBteS1pbWFnZS5iYmFwcGVuZCBbVGhpcyBpcyB0aGUgY2hhbmdlZCBvbmVdDQo+ID4g
ICAgIC0+IGxheWVyMw0KPiA+ICAgICAgICAgLT4gcmVjaXBlcy1jb3JlDQo+ID4gICAgICAgICAg
ICAgLT4gaW1hZ2VzDQo+ID4gICAgICAgICAgICAgICAgIC0+IG15LWltYWdlLWRldi5iYiBbdGhp
cyBpcyB0aGUgbmV3IGltYWdlLCBiYXNlZCBvbg0KPiA+IG15LWltYWdlXQ0KPiA+IA0KPiA+IG15
LWltYWdlLmJiYXBwZW5kIGlzIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tIG15LWltYWdlLmJiYXBwZW5kIC0tLS0tLS0tLQ0KPiA+IFBST1ZJREVT
ID0gInByb2R1Y3QiDQo+ID4gDQo+ID4gSU1BR0VfSU5TVEFMTCArPSAiIFwNCj4gPiAgICAgICAg
IDxzb21lX3BhY2thZ2VzPiBcDQo+ID4gIg0KPiA+IElNQUdFX0lOU1RBTExfcmVtb3ZlICs9ICIg
XA0KPiA+ICAgICAgICAgPG90aGVyLXBhY2tlZ2VzPg0KPiA+ICINCj4gPiANCj4gPiAoKyBvdGhl
ciBmdW5jdGlvbnMgcmVsYXRlZCB3aXRoIHNpZ25pbmcgdGhlIGltYWdlKQ0KPiA+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiANCj4gPiBUaGUg
ZmluYWwgaW1hZ2UgaXMgY3JlYXRlZCB3aXRoICdiaXRiYWtlIHByb2R1Y3QnLg0KPiA+IEFuZCwg
SSB3YW50IHRvIGNyZWF0ZSBhIGRldiBpbWFnZSB0aGF0IG11c3QgYmUgYmFzZWQgb24gdGhlIGN1
cnJlbnQNCj4gPiAicHJvZHVjdCIgaW1hZ2UgKG15LWltYWdlLmJiICsgbXktaW1hZ2UuYmJhcHBl
bmQpIHdpdGggc29tZSBkZXYNCj4gPiBwYWNrYWdlcy4NCj4gPiBTbywgSSBuZWVkIHRvIGluY2x1
ZGUgdGhlIGNoYW5nZXMgdGhhdCBteS1pbWFnZS5iYmFwZW5kIGRvZXMgdG8NCj4gPiB0aGlzDQo+
ID4gZGV2IGltYWdlIEknbSB0cnlpbmcgdG8gY3JlYXRlLg0KPiA+IA0KPiA+IA0KPiA+IFRyaWVk
IHNpbXBsZSBjcmVhdGUgYSBuZXcgaW1hZ2UgdGhhdCBzaG91bGQgYmUgYSBjb3B5IG9mIHRoZQ0K
PiA+IHdvcmtpbmcNCj4gPiBvbmUsIGFuZCB0aGVuIGFkZCB0aGUgbmVlZGVkIHBhY2thZ2VzIGZv
ciBkZXZlbG9wbWVudC4NCj4gPiBTbyBJIGRpZCB0aGUgZm9sbG93aW5nLi4uDQo+ID4gDQo+ID4g
LS0tLS0tLS0tLS0tLS0tLSBteS1pbWFnZS1kZXYuYmJhcHBlbmQgLS0tLS0tLS0tLQ0KPiA+IA0K
PiA+IFNVTU1BUlkgPSAiZGV2IEltYWdlIg0KPiA+IA0KPiA+IHJlcXVpcmUgbGF5ZXIxL3JlY2lw
ZXMtY29yZS9pbWFnZXMvbXktaW1hZ2UuYmINCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiANCj4gPiBJIGNhbiBydW4gJ2JpdGJha2UgbXkt
aW1hZ2UtZGV2JyBhbmQgaXQgcnVucywgYnV0IGRvZXNuJ3QgcHJvZHVjZQ0KPiA+IHRoZQ0KPiA+
IHNhbWUgb3V0cHV0IGFzICdiaXRiYWtlIHByb2R1Y3QnLg0KPiA+IA0KPiA+IEFsc28sIElmIEkg
cnVuICdiaXRiYWtlIG15LWltYWdlLWRldicgMXN0LCBpdCBmaW5pc2hlcyBmaW5lLg0KPiA+IFJ1
bm5pbmcNCj4gPiAnYml0YmFrZSBwcm9kdWN0JyBhZnRlciBtYWtlcyBhIGJ1bmNoIG9mIG90aGVy
IHRhc2tzIGFuZCBmaW5pc2hlcw0KPiA+IGZpbmUuDQo+ID4gUnVubmluZyBhZ2FpbiAnYml0YmFr
ZSBteS1pbWFnZS1kZXYnIGZpbmlzaGVzIHdpdGggYW4gZXJyb3Igb24gYQ0KPiA+IHNwZWNpZmlj
IHRhc2suICggSXQgc2hvd3MgdGhhdCB0aGV5IGFyZSBub3QgYnVpbGRpbmcgdGhlIHNhbWUNCj4g
PiB0aGluZykNCj4gPiANCj4gPiBIb3cgY2FuIEkgZG8gd2hhdCBJIG5lZWQ/DQo+ID4gTk9URTog
SSBjYW4ndCBjaGFuZ2UgYW55dGhpbmcgaW4gdGhlIGxheWVyMSBhbmQgbGF5ZXIyLg0KPiANCj4g
Rm9yIHRoZSBmdXR1cmUsIHRoZSBjbGVhbiB3YXkgdG8gZG8gdGhpcyB3b3VsZCBiZSB0byBmb3Ig
dGhlIGJhc2UNCj4gaW1hZ2UgdG8gaW5jbHVkZSBhIHBhY2thZ2UgZ3JvdXAgZm9yIGRldiB0b29s
cy4gVGhlIGRldiB0b29scyBwYWNrYWdlDQo+IGdyb3VwIHdvdWxkIGJlIGRlZmluZWQgYnkgYSBy
ZWNpcGUgaW4gbGF5ZXIgMSBhbmQgZW1wdHkgYnkgZGVmYXVsdC4NCj4gV2hlbiB5b3Ugd2FudCB0
byBhZGQgZGV2IHRvb2xzIHlvdSBjYW4gY3JlYXRlIGEgLmJiYXBwZW5kIChpbiBsYXllcg0KPiAz
KQ0KPiBmb3IgdGhlIGRldiB0b29scyByZWNpcGUuDQo+IA0KPiBJZiB5b3UgY2FuJ3QgbW9kaWZ5
IGxheWVycyAxIG9yIDIgeW91IGNhbiBhcmNoaWV2ZSBzb21ldGhpbmcgc2ltaWxhcg0KPiB3aXRo
IGEgLmJiYXBwZW5kIGluIGxheWVyIDMgd2hpY2ggYWRkcyB0aGUgZGV2IHRvb2xzIHRvIG9uZSBv
ZiB0aGUNCj4gcGFja2FnZSBncm91cHMgd2hpY2ggX2lzXyBiZWluZyBpbmNsdWRlZCBpbiB0aGUg
aW1hZ2UuIEZvciBleGFtcGxlLA0KPiBpZg0KPiB5b3UgbG9vayBpbiB0aGUgbWFuaWZlc3QgZm9y
IHRoZSBpbWFnZSB5b3Ugc2hvdWxkIHNlZSBhIG51bWJlciBvZg0KPiBwYWNrYWdlIGdyb3VwcyBu
YW1lZCBwYWNrYWdlZ3JvdXAtYmFzZS1pcHY2LCBwYWNrYWdlZ3JvdXAtYmFzZS1uZnMsDQo+IGV0
YyB3aGljaCBhcmUgYmVpbmcgaW5jbHVkZWQgaW4gdGhlIGltYWdlLiBZb3UgY2FuIGFkZCBwYWNr
YWdlcyB0bw0KPiB0aGVzZSBwYWNrYWdlIGdyb3VwcyBieSB1c2luZyBhIC5iYmFwcGVuZCBmb3Ig
dGhlICINCj4gcGFja2FnZWdyb3VwLWJhc2UuYmIiIHJlY2lwZS4NCg==

