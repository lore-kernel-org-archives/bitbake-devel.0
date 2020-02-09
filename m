Return-Path: <Joao.CCabral@parceiros.nos.pt>
Received: from mail.nos.pt (mail.nos.pt [194.79.86.52])
	by mail.openembedded.org (Postfix) with ESMTP id 6A14F60B0E
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Feb 2020 23:33:02 +0000 (UTC)
Received: from PO2EXC012.corporativo.pt (10.227.74.90) by
	LX3EXC013.corporativo.pt (10.228.74.238) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sun, 9 Feb 2020 23:17:54 +0000
Received: from PO2EXC013.corporativo.pt (10.227.74.91) by
	PO2EXC012.corporativo.pt (10.227.74.94) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sun, 9 Feb 2020 23:17:54 +0000
Received: from PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6]) by
	PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6%21]) with mapi id
	15.00.1395.000; Sun, 9 Feb 2020 23:17:54 +0000
From: "Joao Carlos Cabral (P)" <Joao.CCabral@parceiros.nos.pt>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [HELP] Create a new image recipe based on a (changed) existing
	one
Thread-Index: AQHV358opy/+hFiacEiPKhEmZbhQdg==
Date: Sun, 9 Feb 2020 23:17:54 +0000
Message-ID: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
Accept-Language: en-US, pt-PT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.166]
x-tm-snts-smtp: FEAD529367351A20499ACA65F235A592F3A80809B0A76770863B18C677D5C3452000:8
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 10 Feb 2020 14:14:47 +0000
Subject: [HELP] Create a new image recipe based on a (changed) existing one
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
X-List-Received-Date: Sun, 09 Feb 2020 23:33:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA9DF831041C2642A530132CB6767CFC@nos.pt>
Content-Transfer-Encoding: base64

SGksIA0KDQpJJ20gdHJ5aW5nIHRvIGNyZWF0ZSBhIGltYWdlIHJlY2lwZSBiYXNlZCBvbiBhIGV4
aXN0aW5nIG9uZS4NCkkndmUgc2VhcmNoZWQgb25saW5lLCBhbmQgSSBjb3VsZCBmaW5kIHN1Y2gg
YW4gZXhhbXBsZS4NCg0KTXkgcHJvYmxlbSBpcyB0aGF0IHRoZSBpbWFnZSBJIHdoYXQgdG8gc2Vy
dmUgYXMgYSBiYXNlIGlzIGNoYW5nZWQgaW4NCmFub3RoZXIgbGF5ZXIsIGFuZCBJIHdhbnQgdG8g
aW5jbHVkZSB0aGF0IGNoYW5nZXMuDQoNCkV4Og0KDQoodHJlZSkNCg0KUHJqX3Jvb3QNCiAgICAt
PiBsYXllcjENCiAgICAgICAgLT4gcmVjaXBlcy1jb3JlDQogICAgICAgICAgICAtPiBpbWFnZXMN
CiAgICAgICAgICAgICAgICAtPiBteS1pbWFnZS5iYiAgW1RoaXMgaXMgdGhlIGJhc2UgcmVjaXBl
XQ0KICAgIC0+IGxheWVyMg0KICAgICAgICAtPiByZWNpcGVzLWNvcmUNCiAgICAgICAgICAgIC0+
IGltYWdlcw0KICAgICAgICAgICAgICAgIC0+IG15LWltYWdlLmJiYXBwZW5kIFtUaGlzIGlzIHRo
ZSBjaGFuZ2VkIG9uZV0NCiAgICAtPiBsYXllcjMNCiAgICAgICAgLT4gcmVjaXBlcy1jb3JlDQog
ICAgICAgICAgICAtPiBpbWFnZXMNCiAgICAgICAgICAgICAgICAtPiBteS1pbWFnZS1kZXYuYmIg
W3RoaXMgaXMgdGhlIG5ldyBpbWFnZSwgYmFzZWQgb24gbXktDQppbWFnZV0NCg0KbXktaW1hZ2Uu
YmJhcHBlbmQgaXMgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IG15LWltYWdlLmJiYXBwZW5kIC0tLS0tLS0tLQ0KUFJPVklERVMgPSAicHJvZHVjdCINCg0KSU1B
R0VfSU5TVEFMTCArPSAiIFwNCgk8c29tZV9wYWNrYWdlcz4gXA0KIg0KSU1BR0VfSU5TVEFMTF9y
ZW1vdmUgKz0gIiBcDQogICAgICAgIDxvdGhlci1wYWNrZWdlcz4NCiINCg0KKCsgb3RoZXIgZnVu
Y3Rpb25zIHJlbGF0ZWQgd2l0aCBzaWduaW5nIHRoZSBpbWFnZSkNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KVGhlIGZpbmFsIGltYWdlIGlzIGNy
ZWF0ZWQgd2l0aCAnYml0YmFrZSBwcm9kdWN0Jy4NCkFuZCwgSSB3YW50IHRvIGNyZWF0ZSBhIGRl
diBpbWFnZSB0aGF0IG11c3QgYmUgYmFzZWQgb24gdGhlIGN1cnJlbnQNCiJwcm9kdWN0IiBpbWFn
ZSAobXktaW1hZ2UuYmIgKyBteS1pbWFnZS5iYmFwcGVuZCkgd2l0aCBzb21lIGRldg0KcGFja2Fn
ZXMuDQpTbywgSSBuZWVkIHRvIGluY2x1ZGUgdGhlIGNoYW5nZXMgdGhhdCBteS1pbWFnZS5iYmFw
ZW5kIGRvZXMgdG8gdGhpcw0KZGV2IGltYWdlIEknbSB0cnlpbmcgdG8gY3JlYXRlLg0KDQoNClRy
aWVkIHNpbXBsZSBjcmVhdGUgYSBuZXcgaW1hZ2UgdGhhdCBzaG91bGQgYmUgYSBjb3B5IG9mIHRo
ZSB3b3JraW5nDQpvbmUsIGFuZCB0aGVuIGFkZCB0aGUgbmVlZGVkIHBhY2thZ2VzIGZvciBkZXZl
bG9wbWVudC4NClNvIEkgZGlkIHRoZSBmb2xsb3dpbmcuLi4NCg0KLS0tLS0tLS0tLS0tLS0tLSBt
eS1pbWFnZS1kZXYuYmJhcHBlbmQgLS0tLS0tLS0tLQ0KDQpTVU1NQVJZID0gImRldiBJbWFnZSIN
Cg0KcmVxdWlyZSBsYXllcjEvcmVjaXBlcy1jb3JlL2ltYWdlcy9teS1pbWFnZS5iYg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkkgY2FuIHJ1biAn
Yml0YmFrZSBteS1pbWFnZS1kZXYnIGFuZCBpdCBydW5zLCBidXQgZG9lc24ndCBwcm9kdWNlIHRo
ZQ0Kc2FtZSBvdXRwdXQgYXMgJ2JpdGJha2UgcHJvZHVjdCcuDQoNCkFsc28sIElmIEkgcnVuICdi
aXRiYWtlIG15LWltYWdlLWRldicgMXN0LCBpdCBmaW5pc2hlcyBmaW5lLiBSdW5uaW5nDQonYml0
YmFrZSBwcm9kdWN0JyBhZnRlciBtYWtlcyBhIGJ1bmNoIG9mIG90aGVyIHRhc2tzIGFuZCBmaW5p
c2hlcyBmaW5lLg0KUnVubmluZyBhZ2FpbiAnYml0YmFrZSBteS1pbWFnZS1kZXYnIGZpbmlzaGVz
IHdpdGggYW4gZXJyb3Igb24gYQ0Kc3BlY2lmaWMgdGFzay4gKCBJdCBzaG93cyB0aGF0IHRoZXkg
YXJlIG5vdCBidWlsZGluZyB0aGUgc2FtZSB0aGluZykNCg0KSG93IGNhbiBJIGRvIHdoYXQgSSBu
ZWVkPyANCk5PVEU6IEkgY2FuJ3QgY2hhbmdlIGFueXRoaW5nIGluIHRoZSBsYXllcjEgYW5kIGxh
eWVyMi4NCg0KUFMuIEFsc28gdHJpZWQgdG8gcmVxdWlyZSB0aGUgYmJhcHBlbmQgZmlsZSwgYnV0
IGJpdGJha2UgZmFpbHMgc2F5aW5nDQp0aGF0IGl0J3Mgbm90IGEgYml0YmFrZSBmaWxlLg0KICAg
IAkNClRoYW5rcyBpbiBhZHZhbmNlZC4NCg0KSm/Do28gQ2FicmFsDQo=

