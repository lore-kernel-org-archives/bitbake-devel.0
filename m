Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id D208F6C4F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 16:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 1C3A018539;
	Wed, 19 Dec 2018 17:12:38 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id wERK0J6lkKyA; Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id CB8C518512;
	Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B58261E078;
	Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D9A1E070;
	Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by thoth.se.axis.com (Postfix) with ESMTP id 9DFEE1128;
	Wed, 19 Dec 2018 17:12:34 +0100 (CET)
Received: from XBOX04.axis.com (10.0.5.18) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Wed, 19 Dec 2018 17:12:34 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Wed, 19 Dec 2018 17:12:34 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/3] data_smart: Allow numeric characters
	in	overrides
Thread-Index: AQHUk7WvxWtdnWml2k+9C69VBfTzvaWE/b0Q///4DACAAPN7cP///keAgABaBmA=
Date: Wed, 19 Dec 2018 16:12:34 +0000
Message-ID: <e1b2cb22e101463f8afa8a4fe084f869@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
	<ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
	<eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
	<0963d345ec074cbfac6a7e79ccbb0a9e@XBOX04.axis.com>
	<ab481f529628568941f4790a2cad883ac00b6384.camel@linuxfoundation.org>
In-Reply-To: <ab481f529628568941f4790a2cad883ac00b6384.camel@linuxfoundation.org>
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
X-List-Received-Date: Wed, 19 Dec 2018 16:12:38 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiByaWNoYXJkLnB1cmRpZUBsaW51
eGZvdW5kYXRpb24ub3JnDQo+IDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBkZW4gMTkgZGVjZW1iZXIgMjAxOCAxMjo0Mg0KPiBUbzogUGV0ZXIgS2plbGxlcnN0
ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+OyBiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENI
IDIvM10gZGF0YV9zbWFydDogQWxsb3cgbnVtZXJpYw0KPiBjaGFyYWN0ZXJzIGluIG92ZXJyaWRl
cw0KPiANCj4gT24gV2VkLCAyMDE4LTEyLTE5IGF0IDEwOjU1ICswMDAwLCBQZXRlciBLamVsbGVy
c3RlZHQgd3JvdGU6DQo+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBjb21taXQgbWVzc2FnZSBl
aXRoZXIuIEl0IHNheXMgdGhhdCB0aGVyZSBhcmUNCj4gPiBwcm9ibGVtcyB3aXRoIHg4Ni02NCBi
ZWNhdXNlIGl0IGNvbnRhaW5zIGRpZ2l0cywgYnV0IHg4NiAod2hpY2ggdGhlDQo+ID4gY29tbWl0
IG1lc3NhZ2Ugc2F5cyB3b3JrcykgY29udGFpbnMgZGlnaXRzIHRvbywgc28gdGhhdCBjYW5ub3QN
Cj4gPiByZWFsbHkNCj4gPiBiZSB0aGUgY2FzZS4gSWYgaXQgaXMgYWN0dWFsbHkgdGhlIGRhc2gg
aW4geDg2LTY0IHRoYXQgaXMgc3VwcG9zZWRseQ0KPiA+IGEgY2F1c2Ugb2YgcHJvYmxlbXMsIHRo
ZW4gaXNsb3dlcigpIGlnbm9yZXMgYm90aCBkaWdpdHMgYW5kIG5vbi0NCj4gPiBhbHBoYQ0KPiA+
IGNoYXJhY3RlcnMgbGlrZSB0aGUgZGFzaCBzbyB0aGF0IGNhbm5vdCByZWFsbHkgYmUgYSByZWFz
b24gdG8gY2hhbmdlDQo+ID4gdGhlIGNvZGUgZWl0aGVyLiBBbGwgaW4gYWxsIEknbSBjb25mdXNl
ZCBieSB0aGlzIGNvbW1pdCBhbmQgd2hhdCBpdA0KPiA+IGlzIHRyeWluZyB0byBzb2x2ZS4uLg0K
PiANCj4gQ29uc2lkZXIgdGhpcyBvdXRwdXQgZnJvbSBweXRob246DQo+IA0KPiA+Pj4gIjY0Ii5p
c2xvd2VyKCkNCj4gRmFsc2UNCj4gPj4+ICJ4NjQiLmlzbG93ZXIoKQ0KPiBUcnVlDQo+ID4+PiAi
eDY0QSIuaXNsb3dlcigpDQo+IEZhbHNlDQo+ID4+Pg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhh
dCAiNjQiLmlzbG93ZXIoKSByZXR1cm5zIEZhbHNlIHdoZW4gd2UgbmVlZCBUcnVlDQo+IChvdmVy
cmlkZXMgZ2V0IHNwbGl0IGJ5ICdfJyBzbyB4ODZfNjQgdHVybnMgaW50byAieDg2IiBhbmQgIjY0
IiBpbiB0aGUNCj4gY29kZSBpbiBxdWVzdGlvbikuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNo
YXJkDQoNCk9rLCB0aGF0IG1ha2VzIG1vcmUgc2Vuc2UsIGV4Y2VwdCBmb3Igb25lIHRoaW5nOiB3
aGVyZS93aGVuIGlzIF94ODZfNjQgDQp1c2VkIGFzIG92ZXJyaWRlKHMpPyBUaGUgb25seSByZWxh
dGVkIG92ZXJyaWRlcyBJIGNhbiBmaW5kIGluIE9FLUNvcmUgDQphbGwgdXNlIF94ODYtNjQsIHdo
aWNoIG1hdGNoZXMgJHtUUkFOU0xBVEVEX1RBUkdFVF9BUkNIfSBmb3IsIGUuZy4sIA0KcWVtdXg4
Ni02NC4NCg0KLy9QZXRlcg0KDQo=

