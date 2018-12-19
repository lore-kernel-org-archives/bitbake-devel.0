Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 967167BFFC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 10:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2FD0618507;
	Wed, 19 Dec 2018 11:55:32 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id fYEwTXE8Ve33; Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id D32101844C;
	Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB911A072;
	Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B30221A06B;
	Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by thoth.se.axis.com (Postfix) with ESMTP id A6E0430A5;
	Wed, 19 Dec 2018 11:55:29 +0100 (CET)
Received: from xbox11.axis.com (10.0.5.25) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Wed, 19 Dec 2018 11:55:29 +0100
Received: from XBOX04.axis.com (10.0.5.18) by xbox11.axis.com (10.0.5.25) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Wed, 19 Dec 2018 11:55:29 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Wed, 19 Dec 2018 11:55:29 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/3] data_smart: Allow numeric characters
	in	overrides
Thread-Index: AQHUk7WvxWtdnWml2k+9C69VBfTzvaWE/b0Q///4DACAAPN7cA==
Date: Wed, 19 Dec 2018 10:55:29 +0000
Message-ID: <0963d345ec074cbfac6a7e79ccbb0a9e@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
	<ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
	<eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
In-Reply-To: <eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 2/3] data_smart: Allow numeric characters in	overrides
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
X-List-Received-Date: Wed, 19 Dec 2018 10:55:33 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiByaWNoYXJkLnB1cmRpZUBsaW51
eGZvdW5kYXRpb24ub3JnDQo+IDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBkZW4gMTggZGVjZW1iZXIgMjAxOCAyMjoxNw0KPiBUbzogUGV0ZXIgS2plbGxlcnN0
ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+OyBiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENI
IDIvM10gZGF0YV9zbWFydDogQWxsb3cgbnVtZXJpYw0KPiBjaGFyYWN0ZXJzIGluIG92ZXJyaWRl
cw0KPiANCj4gT24gVHVlLCAyMDE4LTEyLTE4IGF0IDIxOjA1ICswMDAwLCBQZXRlciBLamVsbGVy
c3RlZHQgd3JvdGU6DQo+ID4gSSBkbyBub3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1pdC4gVGhlIGNv
bW1pdCBleHBsYW5hdGlvbiBhbmQgdGhlIGNvZGUNCj4gY2hhbmdlDQo+ID4gZG9uJ3QgbWF0Y2gg
dXAuIFRoZSBtb3RpdmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSBpcyB0aGF0IHRoZXJlDQo+
IHdhcw0KPiA+IHByb2JsZW1zIHdpdGggb3ZlcnJpZGVzIHN1Y2ggYXMgeDg2LTY0IGNvbnRhaW5p
bmcgZGlnaXRzIGFuZCB0aGF0IHRoZQ0KPiA+IGNvZGUgc2hvdWxkIGJlIGNoYW5nZWQgdG8gYWxs
b3cgb3ZlcnJpZGVzIHRvIGJlIGxvd2VyIGNhc2UgYW5kDQo+IG51bWVyaWMuDQo+ID4gSG93ZXZl
ciwgdGhlIG1vZGlmaWVkIGNvZGUgY2hhbmdlcyB0aGUgdGVzdCBmcm9tIHVzaW5nIGlzbG93ZXIo
KSwNCj4gd2hpY2ggYXMNCj4gPiBmYXIgYXMgSSBjYW4gdGVsbCBvbmx5IHZhbGlkYXRlcyB0aGUg
YWxwaGEtY2hhcmFjdGVycyBpbiB0aGUgc3RyaW5nDQo+IGFuZA0KPiA+IGlnbm9yZXMgYWxsIGVs
c2UsIHRvIHVzaW5nIGEgcmVndWxhciBleHByZXNzaW9uIHInW2EtejAtOV0rJywgd2hpY2gNCj4g
d2lsbA0KPiA+IG1hdGNoIGFzIGxvbmcgYXMgdGhlIGZpcnN0IGNoYXJhY3RlciBpcyBhIGxvd2Vy
IGNhc2UgY2hhcmFjdGVyIG9yIGENCj4gbnVtZXJpYw0KPiA+IGNoYXJhY3RlciAobm90ZSB0aGF0
IHRoZXJlIGlzIG5vICQgYXQgdGhlIGVuZCBvZiB0aGUgcmVndWxhcg0KPiBleHByZXNzaW9uKS4N
Cj4gPg0KPiA+IEhlcmUgYXJlIHRlc3RzIHdpdGggaXNsb3dlcigpLCB3aGljaCBjb3JyZWN0bHkg
dmFsaWRhdGVzICJ4ODYiIGFuZA0KPiA+ICJ4ODYtNjQiDQo+ID4gYXMgbG93ZXIgY2FzZSBvdmVy
cmlkZXMsIGJ1dCBub3QgImZvb0JhciI6DQo+ID4NCj4gPiA+ID4gPiAieDg2Ii5pc2xvd2VyKCkN
Cj4gPiBUcnVlDQo+ID4gPiA+ID4gIng4Ni02NCIuaXNsb3dlcigpDQo+ID4gVHJ1ZQ0KPiA+ID4g
PiA+ICJmb29CYXIiLmlzbG93ZXIoKQ0KPiA+IEZhbHNlDQo+ID4NCj4gPiBIZXJlIGFyZSB0aGUg
Y29ycmVzcG9uZGluZyB0ZXN0cyB1c2luZyB0aGUgcidbYS16MC05XSsnIHJlZ3VsYXINCj4gPiBl
eHByZXNzaW9uLg0KPiA+IE5vdGUgdGhhdCBpdCBvbmx5IG1hdGNoZXMgIng4NiIgZnJvbSAieDg2
LTY0IiBhbmQgImZvbyIgZnJvbQ0KPiA+ICJmb29CYXIiLCBhbmQNCj4gPiB3aWxsIGluY29ycmVj
dGx5IGFsbG93ICJmb29CYXIiIGFzIGFuIG92ZXJyaWRlOg0KPiA+DQo+ID4gPiA+ID4gcmUubWF0
Y2gocidbYS16MC05XSsnLCAieDg2IikNCj4gPiA8X3NyZS5TUkVfTWF0Y2ggb2JqZWN0OyBzcGFu
PSgwLCAzKSwgbWF0Y2g9J3g4Nic+DQo+ID4gPiA+ID4gcmUubWF0Y2gocidbYS16MC05XSsnLCAi
eDg2LTY0IikNCj4gPiA8X3NyZS5TUkVfTWF0Y2ggb2JqZWN0OyBzcGFuPSgwLCAzKSwgbWF0Y2g9
J3g4Nic+DQo+ID4gPiA+ID4gcmUubWF0Y2gocidbYS16MC05XSsnLCAiZm9vQmFyIikNCj4gPiA8
X3NyZS5TUkVfTWF0Y2ggb2JqZWN0OyBzcGFuPSgwLCAzKSwgbWF0Y2g9J2Zvbyc+DQo+ID4NCj4g
PiBTbyB3aHkgY2hhbmdlIGZyb20gaXNsb3dlcigpLCB3aGljaCBhcyBmYXIgYXMgSSBjYW4gdGVs
bCBkaWQgdGhlDQo+ID4gcmlnaHQgdGhpbmcgZnJvbSB0aGUgYmVnaW5uaW5nPw0KPiANCj4gVGhl
IGNvbW1pdCBpcyBjbGVhcmx5IHdyb25nLiBUaGUgaW50ZW50IG9mIHRoZSBjb21taXQgbWVzc2Fn
ZSBpcw0KPiBjb3JyZWN0LCBpdCBkb2Vzbid0IG1hdGNoIHdoYXQgdGhhdCByZWdleCBhY3R1YWxs
eSBkb2VzIDooDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCkkgZG9uJ3QgdW5kZXJz
dGFuZCB0aGUgY29tbWl0IG1lc3NhZ2UgZWl0aGVyLiBJdCBzYXlzIHRoYXQgdGhlcmUgYXJlIA0K
cHJvYmxlbXMgd2l0aCB4ODYtNjQgYmVjYXVzZSBpdCBjb250YWlucyBkaWdpdHMsIGJ1dCB4ODYg
KHdoaWNoIHRoZSANCmNvbW1pdCBtZXNzYWdlIHNheXMgd29ya3MpIGNvbnRhaW5zIGRpZ2l0cyB0
b28sIHNvIHRoYXQgY2Fubm90IHJlYWxseSANCmJlIHRoZSBjYXNlLiBJZiBpdCBpcyBhY3R1YWxs
eSB0aGUgZGFzaCBpbiB4ODYtNjQgdGhhdCBpcyBzdXBwb3NlZGx5IA0KYSBjYXVzZSBvZiBwcm9i
bGVtcywgdGhlbiBpc2xvd2VyKCkgaWdub3JlcyBib3RoIGRpZ2l0cyBhbmQgbm9uLWFscGhhIA0K
Y2hhcmFjdGVycyBsaWtlIHRoZSBkYXNoIHNvIHRoYXQgY2Fubm90IHJlYWxseSBiZSBhIHJlYXNv
biB0byBjaGFuZ2UgDQp0aGUgY29kZSBlaXRoZXIuIEFsbCBpbiBhbGwgSSdtIGNvbmZ1c2VkIGJ5
IHRoaXMgY29tbWl0IGFuZCB3aGF0IGl0IA0KaXMgdHJ5aW5nIHRvIHNvbHZlLi4uDQoNCi8vUGV0
ZXINCg0K

