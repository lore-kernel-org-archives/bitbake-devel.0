Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id C38507F8CB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 16:54:27 +0000 (UTC)
IronPort-SDR: xgT5HFH1tJaOBwp1U/GUc05uAUWaC5DKSkbdT8tA4/bp70V32MBkK/5IKV1cIRf/q9/vwNUNjK
	kbXhs06Rg6qyLnt4o5eXH4UY/A6WclhkMg4jecIX8cKEUsUuWGHn3mLDPB3I8vHwXXkfGCH2LT
	Y6rsmzOn5yRoZKIKc3iR2tvvI/oQv7GyiWp2aX4mWi3ZHb2GMfXnGGEF4fwTf07YiE5Q0Plzc3
	915SUAIcRgi59LSJ5zOAkH1887C4MMChgLzRvXzGBROzSNzJEsQ9ltRjfi6SkBqcD693tgLYMM
	Tq0=
X-IronPort-AV: E=Sophos;i="5.68,304,1569276000"; 
   d="scan'208";a="2440866"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Khem Raj <raj.khem@gmail.com>, =?utf-8?B?QW7DrWJhbCBMaW3Ds24=?=
	<anibal.limon@linaro.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb: Add
	BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
Thread-Index: AQHVmpcBhD3fXmQv8ku7PxxVHSyoGaeK4oQQ
Date: Thu, 14 Nov 2019 16:54:25 +0000
Message-ID: <3ba6b1a5788f453aa1974a13342d148c@XBOX03.axis.com>
References: <20191113232303.29047-1-anibal.limon@linaro.org>
	<CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
In-Reply-To: <CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.20.13.13]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Thu, 14 Nov 2019 16:54:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8Yml0YmFrZS1kZXZlbC0NCj4gYm91bmNlc0BsaXN0
cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgS2hlbSBSYWoNCj4gU2VudDogZGVuIDE0
IG5vdmVtYmVyIDIwMTkgMDM6NTUNCj4gVG86IEFuw61iYWwgTGltw7NuIDxhbmliYWwubGltb25A
bGluYXJvLm9yZz4NCj4gQ2M6IGJpdGJha2UtZGV2ZWwgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIGxp
Yi9iYjogQWRkDQo+IEJCX1NJR05BVFVSRV9MT0NBTF9ESVJTX0VYQ0xVREUgdG8gc3BlZWQtdXAg
dGFza2hhc2ggb24gZGlyZWN0b3JpZXMNCj4gDQo+IE9uIFdlZCwgTm92IDEzLCAyMDE5IGF0IDM6
MjMgUE0gQW7DrWJhbCBMaW3Ds24gPGFuaWJhbC5saW1vbkBsaW5hcm8ub3JnPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IFRoZSBuZXcgQkJfU0lHTkFUVVJFX0xPQ0FMX0RJUlNfRVhDTFVERSBhbGxvd3Mg
eW91IHRvIHNwZWNpZnkgYSBsaXN0DQo+ID4gb2YgZGlyZWN0b3JpZXMgdG8gZXhjbHVkZSB3aGVu
IG1ha2luZyB0YXNraGFzaCwgb3VyIHNwZWNpZmljIGNhc2UNCj4gPiBpcyB1c2luZyBTUkNfVVJJ
IHRoYXQgcG9pbnRzIGxvY2FsIFZDUyBkaXJlY3RvcnkuDQo+ID4NCj4gPiBJbiBPRS1Db3JlIHRo
aXMgdmFyaWFibGUgY291bGQgYmUgc2V0IGJ5IGRlZmF1bHQgdG86DQo+ID4NCj4gPiBCQl9TSUdO
QVRVUkVfTE9DQUxfRElSU19FWENMVURFID0gIi5jdnMgLmdpdCAuc3ZuIg0KDQpUaGF0IHNob3Vs
ZCBiZToNCg0KQkJfU0lHTkFUVVJFX0xPQ0FMX0RJUlNfRVhDTFVERSA9ICJDVlMgLmdpdCAuc3Zu
Ig0KDQo+IEkgbGlrZSB0aGUgYXBwcm9hY2guICBwZXJoYXBzIGEgc2FuZSBkZWZhdWx0IHdvdWxk
IGJlIG5pY2UuDQoNCi8vUGV0ZXINCg0K

