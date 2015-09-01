Return-Path: <benjamin.esquivel@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 24F6476B7C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Sep 2015 17:25:45 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 01 Sep 2015 10:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,450,1437462000"; d="scan'208";a="795968517"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
	by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2015 10:25:17 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
	ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Tue, 1 Sep 2015 10:25:16 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
	ORSMSX112.amr.corp.intel.com (10.22.240.13) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Tue, 1 Sep 2015 10:25:16 -0700
Received: from fmsmsx103.amr.corp.intel.com ([169.254.2.229]) by
	FMSMSX152.amr.corp.intel.com ([169.254.6.63]) with mapi id
	14.03.0224.002; Tue, 1 Sep 2015 10:25:15 -0700
From: "Esquivel, Benjamin" <benjamin.esquivel@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [Fwd: [PATCH] utils.movefile: specify dest file name]
Thread-Index: AQHQ5NsqALKPHQb/Ek2YFlP3Q6hhow==
Date: Tue, 1 Sep 2015 17:25:15 +0000
Message-ID: <1441128323.3828.8.camel@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.8.224]
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 01 Sep 2015 19:42:54 +0000
Subject: [Fwd: [PATCH] utils.movefile: specify dest file name]
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
X-List-Received-Date: Tue, 01 Sep 2015 17:25:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E72668E8128DC47B7A7A89EDB11DAAD@intel.com>
Content-Transfer-Encoding: base64

U2VuZGluZyB0aGlzIHRvIHRoZSByaWdodCBsaXN0Lg0KDQpCZW5qYW1pbg0KDQotLS0tLS0tLSBG
b3J3YXJkZWQgTWVzc2FnZSAtLS0tLS0tLQ0KRnJvbTogQmVuamFtaW4gRXNxdWl2ZWwgPGJlbmph
bWluLmVzcXVpdmVsQGxpbnV4LmludGVsLmNvbT4NClRvOiBvcGVuZW1iZWRkZWQtY29yZUBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnDQpDYzogcGF1bC5lZ2dsZXRvbkBsaW51eC5pbnRlbC5jb20sIEJl
bmphbWluIEVzcXVpdmVsIDwNCmJlbmphbWluLmVzcXVpdmVsQGxpbnV4LmludGVsLmNvbT4NClN1
YmplY3Q6IFtQQVRDSF0gdXRpbHMubW92ZWZpbGU6IHNwZWNpZnkgZGVzdCBmaWxlIG5hbWUNCkRh
dGU6IFRodSwgMjAgQXVnIDIwMTUgMTM6NTk6NTggKzAwMDANCg0KPiAgV2hlbiBtb3ZpbmcgYSBm
aWxlIHZpYSB0aGUgb3MucmVuYW1lIGZ1bmN0aW9uLCBpdCB3YXMgbWlzc2luZyB0aGUNCj4gIGRl
c3RpbmF0aW9uIGZpbGUgbmFtZSB3aGljaCBjYXVzZWQgYW4gT1NFcnJvcg0KPiANCj4gIFtZT0NU
TyM4MTgwXQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gRXNxdWl2ZWwgPGJlbmphbWlu
LmVzcXVpdmVsQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBiaXRiYWtlL2xpYi9iYi91dGls
cy5weSB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL3V0aWxzLnB5IGIvYml0
YmFrZS9saWIvYmIvdXRpbHMucHkNCj4gaW5kZXggNWI5NDQzMi4uNWVlYzc4NyAxMDA2NDQNCj4g
LS0tIGEvYml0YmFrZS9saWIvYmIvdXRpbHMucHkNCj4gKysrIGIvYml0YmFrZS9saWIvYmIvdXRp
bHMucHkNCj4gQEAgLTc0MSw3ICs3NDEsOSBAQCBkZWYgbW92ZWZpbGUoc3JjLCBkZXN0LCBuZXdt
dGltZSA9IE5vbmUsIHNzdGF0ID0NCj4gTm9uZSk6DQo+ICAgICAgcmVuYW1lZmFpbGVkID0gMQ0K
PiAgICAgIGlmIHNzdGF0W3N0YXQuU1RfREVWXSA9PSBkc3RhdFtzdGF0LlNUX0RFVl06DQo+ICAg
ICAgICAgIHRyeToNCj4gLSAgICAgICAgICAgIG9zLnJlbmFtZShzcmMsIGRlc3QpDQo+ICsgICAg
ICAgICAgICAjIG9zLnJlbmFtZSBuZWVkcyB0byBrbm93IHRoZSBkZXN0aW5hdGlvbiBwYXRoIHdp
dGggZmlsZQ0KPiBuYW1lDQo+ICsgICAgICAgICAgICBkZXN0ZmlsZSA9IG9zLnBhdGguam9pbihk
ZXN0LCBvcy5wYXRoLmJhc2VuYW1lKHNyYykpDQo+ICsgICAgICAgICAgICBvcy5yZW5hbWUoc3Jj
LCBkZXN0ZmlsZSkgDQo+ICAgICAgICAgICAgICByZW5hbWVmYWlsZWQgPSAwDQo+ICAgICAgICAg
IGV4Y2VwdCBFeGNlcHRpb24gYXMgZToNCj4gICAgICAgICAgICAgIGlmIGVbMF0gIT0gZXJybm8u
RVhERVY6DQo+IC0tIA0KPiAyLjMuMA0KPiA=

