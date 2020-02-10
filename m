Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id C7BE260CC7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 15:36:12 +0000 (UTC)
IronPort-SDR: odgY3ioI9XtZUHCvzMiiBcEt/6R5OyoTzdweTG/KKYVxWRN5LL96eClzLZOm//OGLmzQihhqBQ
	E45Z4H+lWDKkTvhDdkxUtLJaOrJLJrp3Rx0dZggf9aP2xmP7vNjTYRkHCqBtPUJ5Voy1Z+Du7H
	Qcuhd+j/ivZpcEXJKWs+Cx1cmI1rEIZGgf3Hi1s0FP4m9fyH0ooZIHXQMSObAwcdCLgOL0QCvg
	FVd5Cs38Kct6F5KNSv2ocF7zoCh/owWdV8kJ/UEvS0elA0iy1lBfxbBFdtgrjtDWKNZ0cDctJX
	jdw=
X-IronPort-AV: E=Sophos;i="5.70,425,1574118000"; 
   d="scan'208";a="5260458"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [master][zeus][PATCH] uihelper: Track scene
	tasks again
Thread-Index: AQHV4Bzc9xFX8di2zEWzwAbvgkavfKgUg8ig///1vACAABQkgA==
Date: Mon, 10 Feb 2020 15:36:12 +0000
Message-ID: <63038209783f4414ab6f3ed7b08ff1d8@XBOX03.axis.com>
References: <20200209085034.16349-1-pkj@axis.com>
	<29677f1ba34d00b61ad1375b38f56b20c3e98d50.camel@linuxfoundation.org>
	<68698044e91d4c4dbaa60d63260ac7f7@XBOX03.axis.com>
	<a65f29e07265027e7a057b450d9009745389d5df.camel@linuxfoundation.org>
In-Reply-To: <a65f29e07265027e7a057b450d9009745389d5df.camel@linuxfoundation.org>
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
X-List-Received-Date: Mon, 10 Feb 2020 15:36:14 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDEwIGZlYnJ1YXJp
IDIwMjAgMTY6MTgNCj4gVG86IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0
QGF4aXMuY29tPjsgYml0YmFrZS0NCj4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFttYXN0ZXJdW3pldXNdW1BBVENIXSB1aWhlbHBl
cjogVHJhY2sgc2NlbmUNCj4gdGFza3MgYWdhaW4NCj4gDQo+IE9uIE1vbiwgMjAyMC0wMi0xMCBh
dCAxNTowMSArMDAwMCwgUGV0ZXIgS2plbGxlcnN0ZWR0IHdyb3RlOg0KPiA+IElmIGEgc2V0c2Nl
bmUgdGFzayBpcyByZXJ1biwgd29uJ3QgdGhhdCBqdXN0IG1lYW4gdGhhdCB0aGUgY291bnRlcnMN
Cj4gPiBkb24ndCBjaGFuZ2UgZHVlIHRvIHRoaXM/IFNvIGluIHRoaXMgY2FzZSB0aGVyZSB3b24n
dCBiZSBhbnkNCj4gPiBwcm9ncmVzcyAgdG8gdGhlIHRvdGFsIHByb2dyZXNzIGJhciBldmVuIGlm
IGEgdGFzayBpcyBydW5uaW5nPyBUaGF0DQo+ID4gc2hvdWxkIHN0aWxsICBiZSBiZXR0ZXIgdGhh
biB0aGUgY3VycmVudCBzaXR1YXRpb24gd2hlbiB0aGV5IGFyZQ0KPiA+IG5ldmVyIGNvdW50ZWQu
DQo+IA0KPiBObywgdGhhdCBpc24ndCBob3cgdGhlIGNvZGUgaXMgd3JpdHRlbi4gWW91J2Qgc2Vl
ICJ0YXNrIDEwMDAgb2YgNTAwIi4NCj4gV2UgZ290IHNvbWUgcHJldHR5IGhvcnJpYmxlIG51bWJl
cnMgd2hlbiB0ZXN0aW5nIHRoaXMgb3JpZ2luYWxseSwgSSBnb3QNCj4gbG90cyBvZiBjb21wbGFp
bnRzIGFuZCBpdHMgd2h5IGl0IHdhcyByZW1vdmVkLg0KPiANCj4gVGhlIGNvZGUgaGFzIGNoYW5n
ZWQgYSBiaXQgc2luY2UgYW5kIHdlIHByb2JhYmx5IGRvbid0IHJlcnVuIGFzIG11Y2gNCj4gYnV0
IHdlIGdldCBjb21wbGFpbnMgd2hlbiB3ZSBwcmludCBhbnkgaW52YWxpZCBpbmZvLi4uDQo+IA0K
PiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCkhtbSwgb2suIEkgZ2V0IGxvdWQgY29tcGxhaW50
cyB0aGF0IHdlIGFyZSBwcmludGluZyAiKDAgb2YgMCkiIHdoaWxlIA0KdGhvdXNhbmRzIG9mIHNl
dHNjZW5lIHRhc2tzIGFyZSBiZWluZyBwcm9jZXNzZWQsIHNvIHRoYXQgaXMgdW5mb3J0dW5hdGVs
eSANCm5vdCBtdWNoIGJldHRlci4uLiANCg0KV291bGQgaXQgYmUgcG9zc2libGUgdG8gY2hhbmdl
IHRoZSBhY2NvdW50aW5nIHNvIHRoYXQgd2UgZG8gbm90IGVuZCANCnVwIHdpdGggInRhc2sgMTAw
MCBvZiA1MDAiPw0KDQpGb3IgdGhlIHJlY29yZCwgd2UgYXJlIG5vdCB1c2luZyB0aGUgaGFzaCBl
cXVpdmFsZW5jZSBzZXJ2ZXIsIHNvIEkgDQpndWVzcyB3ZSBzaG91bGQgbm90IGhhdmUgYW55IHNl
dHNjZW5lIHRhc2tzIHRoYXQgYXJlIGJlaW5nIHJlcnVuLCBidXQgSSANCmhhdmUgYSBmZWVsaW5n
IHlvdSBkbyBub3Qgd2FudCB0byB0cmVhdCB0aGUgdHdvIGNhc2VzIGRpZmZlcmVudGx5Lg0KDQov
L1BldGVyDQoNCg==

