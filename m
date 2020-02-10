Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id C949B60213
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 15:01:24 +0000 (UTC)
IronPort-SDR: CiKv3DI7Y5D+eeT+p/Rr638QC9UGE9//Biz2obcUMV5xxxirpuIacu1SZ8K/RQZdHHOMTl6bHt
	zau2jirqzhNxMQ4YCnvHxmpHI15vAdNh4acIIDic6wj8QHBUhDJ4au+ec0HcKvFgdp0l7jm3JL
	Rw0wHRxNHGGqB0pmqpI/8T3e8F/fYYXqxKvM2k2517MuE2HBCDiF7NuWyfH9sH85qFqiAc863c
	c2DQuzMa+KMKo1/o7aIcUZ9myv5YgORmcZbeRhvW1BUSlIU4irvbxtDRT8Vmctyd+XVmHAyITy
	qc8=
X-IronPort-AV: E=Sophos;i="5.70,425,1574118000"; 
   d="scan'208";a="5116064"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [master][zeus][PATCH] uihelper: Track scene
	tasks again
Thread-Index: AQHV4Bzc9xFX8di2zEWzwAbvgkavfKgUg8ig
Date: Mon, 10 Feb 2020 15:01:24 +0000
Message-ID: <68698044e91d4c4dbaa60d63260ac7f7@XBOX03.axis.com>
References: <20200209085034.16349-1-pkj@axis.com>
	<29677f1ba34d00b61ad1375b38f56b20c3e98d50.camel@linuxfoundation.org>
In-Reply-To: <29677f1ba34d00b61ad1375b38f56b20c3e98d50.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [master][zeus][PATCH] uihelper: Track scene tasks again
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
X-List-Received-Date: Mon, 10 Feb 2020 15:01:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDEwIGZlYnJ1YXJp
IDIwMjAgMTU6MTgNCj4gVG86IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0
QGF4aXMuY29tPjsgYml0YmFrZS0NCj4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFttYXN0ZXJdW3pldXNdW1BBVENIXSB1aWhlbHBl
cjogVHJhY2sgc2NlbmUNCj4gdGFza3MgYWdhaW4NCj4gDQo+IE9uIFN1biwgMjAyMC0wMi0wOSBh
dCAwOTo1MCArMDEwMCwgUGV0ZXIgS2plbGxlcnN0ZWR0IHdyb3RlOg0KPiA+IFRyYWNrIGJvdGgg
c2NlbmUgdGFza3MgYW5kIHJ1biB0YXNrcyB0byBwcm92aWRlIGEgY29tcGxldGUgcHJvZ3Jlc3MN
Cj4gPiBpbmZvcm1hdGlvbiBmb3IgYWxsIHRhc2tzLiBUaGlzIGF2b2lkcyB0aGUgcHJvZ3Jlc3Mg
YmFyIGZyb20gc3RhdGluZw0KPiA+ICJDdXJyZW50bHkgWFggcnVubmluZyB0YXNrcyAoMCBvZiAw
KSIgd2hpbGUgcHJvZ3Jlc3NpbmcgdGhyb3VnaA0KPiA+IHRob3VzYW5kcyBvZiBzZXRzY2VuZSB0
YXNrcywgb2J2aW91c2x5IGNvbmZ1c2luZyB0aGUgdXNlci4NCj4gDQo+IFRoZXJlIHdhcyBhIHJl
YXNvbiB0aGlzIHdhcyByZW1vdmVkLCB0aGlzIGNhbid0IHdvcmsgdW5mb3J0dW5hdGVseS4NCj4g
DQo+IFRoZSBjb2RlIHdhcyBjaGFuZ2VkIHN1Y2ggdGhhdCBzZXRzY2VuZSB0YXNrcyBjYW4gcG90
ZW50aWFsbHkgYmUgcmVydW4NCj4gc28gd2UgaGF2ZSBubyBpZGVhIHdoYXQgImNvbXBsZXRlIiBs
b29rcyBsaWtlIG9yIGhvdyBtYW55IHdpbGwgYWN0dWFsbHkNCj4gcnVuLiBJJ20gbm90IGhhcHB5
IGFib3V0IHRoYXQgYnV0IHRoZXJlIHdhc24ndCBhbiBhbHRlcm5hdGl2ZS4NCj4gDQo+IENoZWVy
cywNCj4gDQo+IFJpY2hhcmQNCg0KSWYgYSBzZXRzY2VuZSB0YXNrIGlzIHJlcnVuLCB3b24ndCB0
aGF0IGp1c3QgbWVhbiB0aGF0IHRoZSBjb3VudGVycyANCmRvbid0IGNoYW5nZSBkdWUgdG8gdGhp
cz8gU28gaW4gdGhpcyBjYXNlIHRoZXJlIHdvbid0IGJlIGFueSBwcm9ncmVzcyANCnRvIHRoZSB0
b3RhbCBwcm9ncmVzcyBiYXIgZXZlbiBpZiBhIHRhc2sgaXMgcnVubmluZz8gVGhhdCBzaG91bGQg
c3RpbGwgDQpiZSBiZXR0ZXIgdGhhbiB0aGUgY3VycmVudCBzaXR1YXRpb24gd2hlbiB0aGV5IGFy
ZSBuZXZlciBjb3VudGVkLg0KDQovL1BldGVyDQoNCg==

