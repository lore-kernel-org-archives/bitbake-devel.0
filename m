Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 0B6C07FAAD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 16:29:43 +0000 (UTC)
IronPort-SDR: is5m7NU6a42S0BYiTQpioB7RfvRNG41ArLOo0IZdWeVoUxBtXgjmZ4ewXy5JUbpGj58e+AeOyF
	NIthH3RSI6KcdCMKC5pCfUNB1jFv9vmFKfU4NzPqqKuzwyr/IKzeuN11GWuxH74vB6lE9lGKEL
	QgBdvlmFabVcQzKAfRj6TV0iAvT5FTgp6n0CdlLzwWspYhuiDXhulDAfFTZcZXHUr1Ffb+8CYE
	TV45J+MLRVMGQ+/eL1XhhIAN8PJTIAVSTDnu3trPgm9Z9kGQYP7bN61WcxIV4WDNiaqx0A/P3c
	174=
X-IronPort-AV: E=Sophos;i="5.68,308,1569276000"; 
   d="scan'208";a="2477737"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?utf-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linaro.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCHv2] lib/bb: Add
	BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
Thread-Index: AQHVm8OjHM+PNH1U8kS+3NkVn0hQpqeMZSNw
Date: Fri, 15 Nov 2019 16:29:42 +0000
Message-ID: <401cecf1881048e594574ca4d37c446c@XBOX03.axis.com>
References: <20191115144723.7452-1-anibal.limon@linaro.org>
In-Reply-To: <20191115144723.7452-1-anibal.limon@linaro.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCHv2] lib/bb: Add	BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Fri, 15 Nov 2019 16:29:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8Yml0YmFrZS1kZXZlbC0NCj4gYm91bmNlc0BsaXN0
cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgQW7DrWJhbCBMaW3Ds24NCj4gU2VudDog
ZGVuIDE1IG5vdmVtYmVyIDIwMTkgMTU6NDcNCj4gVG86IGJpdGJha2UtZGV2ZWxAbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIdjJdIGxpYi9i
YjogQWRkDQo+IEJCX1NJR05BVFVSRV9MT0NBTF9ESVJTX0VYQ0xVREUgdG8gc3BlZWQtdXAgdGFz
a2hhc2ggb24gZGlyZWN0b3JpZXMNCj4gDQo+IFRoZSBuZXcgQkJfU0lHTkFUVVJFX0xPQ0FMX0RJ
UlNfRVhDTFVERSBhbGxvd3MgeW91IHRvIHNwZWNpZnkgYSBsaXN0DQo+IG9mIGRpcmVjdG9yaWVz
IHRvIGV4Y2x1ZGUgd2hlbiBtYWtpbmcgdGFza2hhc2gsIG91ciBzcGVjaWZpYyBjYXNlDQo+IGlz
IHVzaW5nIFNSQ19VUkkgdGhhdCBwb2ludHMgbG9jYWwgVkNTIGRpcmVjdG9yeS4NCj4gDQo+IFVz
ZSBiYi5mZXRjaC5tb2R1bGUgdG8gc2V0IGRlZmF1bHQgdG86ICJDVlMgLmJ6ciAuZ2l0IC5oZyAu
b3NjIC5wNCAucmVwbw0KPiAuc3ZuIg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW7DrWJhbCBMaW3D
s24gPGFuaWJhbC5saW1vbkBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGxpYi9iYi9jaGVja3N1bS5w
eSAgICAgICAgfCA1ICsrKy0tDQo+ICBsaWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgNCArKy0t
DQo+ICBsaWIvYmIvc2lnZ2VuLnB5ICAgICAgICAgIHwgNSArKystLQ0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCltjdXRdDQoNCj4gLS0tIGEv
bGliL2JiL3NpZ2dlbi5weQ0KPiArKysgYi9saWIvYmIvc2lnZ2VuLnB5DQo+IEBAIC0xMjMsNiAr
MTIzLDcgQEAgY2xhc3MgU2lnbmF0dXJlR2VuZXJhdG9yQmFzaWMoU2lnbmF0dXJlR2VuZXJhdG9y
KToNCj4gDQo+ICAgICAgICAgIHNlbGYudW5paGFzaF9jYWNoZSA9IGJiLmNhY2hlLlNpbXBsZUNh
Y2hlKCIxIikNCj4gICAgICAgICAgc2VsZi51bml0YXNraGFzaGVzID0gc2VsZi51bmloYXNoX2Nh
Y2hlLmluaXRfY2FjaGUoZGF0YSwgImJiX3VuaWhhc2hlcy5kYXQiLCB7fSkNCj4gKyAgICAgICAg
c2VsZi5sb2NhbGRpcnNleGNsdWRlID0gKGRhdGEuZ2V0VmFyKCJCQl9TSUdOQVRVUkVfTE9DQUxf
RElSU19FWENMVURFIikgb3IgIkNWUyAuYnpyIC5naXQgLmhnIC5vc2MgLnA0IC5yZXBvIC5zdm4i
KS5zcGxpdCgpDQoNCkkgZG9uJ3QgbGlrZSB0aGlzIGNvbnN0cnVjdCwgYmVjYXVzZSBpZiBJIGRv
Og0KDQpCQl9TSUdOQVRVUkVfTE9DQUxfRElSU19FWENMVURFX2FwcGVuZCA9ICIgc29tZV9kaXIi
DQoNCml0IG1lYW5zIHRoYXQgYWxsIG9mIGEgc3VkZGVuIHRoZSBTQ00gZGlyZWN0b3JpZXMgbGlz
dGVkIGFib3ZlIHdpbGwgbm8gDQpsb25nZXIgYmUgZXhjbHVkZWQgc2luY2UgQkJfU0lHTkFUVVJF
X0xPQ0FMX0RJUlNfRVhDTFVERSB3aWxsIG5vdyBiZSANCmRlZmluZWQsIGJ1dCBvbmx5IGNvbnRh
aW4gIiBzb21lX2RpciIuIElzbid0IGl0IGJldHRlciB0byBhZGQ6DQoNCkJCX1NJR05BVFVSRV9M
T0NBTF9ESVJTX0VYQ0xVREUgPz89ICJDVlMgLmJ6ciAuZ2l0IC5oZyAub3NjIC5wNCAucmVwbyAu
c3ZuIg0KDQpzb21ld2hlcmUgaW4gT0UtQ29yZSAoYW5kIGl0IGNhbiB0aGVuIGFsc28gaGF2ZSBh
IHN1aXRhYmxlIA0KQkJfU0lHTkFUVVJFX0xPQ0FMX0RJUlNfRVhDTFVERVtkb2NdLCB0aG91Z2gg
aXQgc2VlbXMgQkJfLXZhcmlhYmxlcyANCmFyZSBvbmx5IGRvY3VtZW50ZWQgaW4gbWV0YS9jb25m
L2RvY3VtZW50YXRpb24uY29uZik/DQoNCkFsdGVybmF0aXZlbHksIHRvIGtlZXAgdGhlIGxpc3Qg
YWJvdmUgd2l0aGluIGJpdGJha2UsIG1ha2UgaXQgdHdvIA0KdmFyaWFibGVzLCBvbmUgZm9yIHRo
ZSBsaXN0IG9mIGRpcmVjdG9yaWVzIGFib3ZlIHRoYXQgaXMgbm90IHJlYWxseSANCmludGVuZGVk
IHRvIGJlIG1vZGlmaWVkLCBhbmQgb25lIGZvciBhZGRpdGlvbmFsIGRpcmVjdG9yaWVzICh3aGlj
aCANCnNob3VsZCBzdGlsbCBiZSBkb2N1bWVudGVkIGluIG1ldGEvY29uZi9kb2N1bWVudGF0aW9u
LmNvbmYpLg0KDQovL1BldGVyDQoNCg==

