Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id BA86073237
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Jul 2015 18:12:06 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 29 Jul 2015 11:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,572,1432623600"; d="scan'208";a="773736953"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
	by orsmga002.jf.intel.com with ESMTP; 29 Jul 2015 11:12:07 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
	ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Wed, 29 Jul 2015 11:12:06 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.2.247]) by
	ORSMSX153.amr.corp.intel.com ([169.254.12.208]) with mapi id
	14.03.0224.002; Wed, 29 Jul 2015 11:12:05 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] wget.py: support for semi-colons in URL
Thread-Index: AQHQxwjZ7FINUjPjhESeHrY/nCojGJ3xMKOA///aqkCAALXMAIABBKpQ
Date: Wed, 29 Jul 2015 18:12:05 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6101D2D27@ORSMSX109.amr.corp.intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<1438081047-sup-2928@axis.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2AA9@ORSMSX109.amr.corp.intel.com>
	<1438112280.11208.39.camel@linuxfoundation.org>
In-Reply-To: <1438112280.11208.39.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Wed, 29 Jul 2015 18:12:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T0ssIEkgd2lsbCBzZW5kIGluICBhIG5ldyBwYXRjaCBmb3IgYml0YmFrZSBtYW51YWwuIA0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgUHVyZGllIFttYWls
dG86cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gU2VudDogVHVlc2RheSwg
SnVseSAyOCwgMjAxNSAxMjozOCBQTQ0KPiBUbzogQnlzdHJpY2t5LCBKdXJvDQo+IENjOiBPbG9m
IEpvaGFuc3NvbjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSB3Z2V0LnB5OiBzdXBwb3J0IGZvciBzZW1p
LWNvbG9ucyBpbg0KPiBVUkwNCj4gDQo+IE9uIFR1ZSwgMjAxNS0wNy0yOCBhdCAxNjowNiArMDAw
MCwgQnlzdHJpY2t5LCBKdXJvIHdyb3RlOg0KPiA+IEkgdGVzdGVkIHlvdXIgc3VnZ2VzdGlvbiAo
cmVwbGFjaW5nICI7IiB3aXRoICImIiBpbiB0aGUgU1JDX1VSSSApIGFuZCBpbiBteQ0KPiBjYXNl
IGl0IGRpZCB3b3JrIHByb3Blcmx5Lg0KPiA+IFNvIGV2ZW4gaWYgdGhpcyBtYXkgbm90IHNvbHZl
IGV2ZXJ5dGhpbmcsIEkgYmVsaWV2ZSB0aGlzIHNob3VsZCBiZQ0KPiA+IHByb3Blcmx5IGRvY3Vt
ZW50ZWQgc29tZXdoZXJlIGFzIHRoaXMgc2VlbXMgdG8gYmUgY3VycmVudGx5IHRoZSBvbmx5DQo+
IHdheSB0byB1c2UgU1JDX1VSSSB3aXRoIHNlbWktY29sb25zIGluIFVSTC4NCj4gPg0KPiA+IE5v
dGUgdGhhdCBvbmUgc3RpbGwgbmVlZHMgdG8gc3BlY2lmeSB0aGUgZG93bmxvYWRlZCBmaWxlIG5h
bWUgbWFudWFsbHksDQo+IGkuZS4NCj4gPg0KPiA+IFNSQ19VUkkgPSAiaHR0cDovL2FiYzEyMy5j
b20vZ2l0Lz9wPWdjYy9nY2MuZ2l0JmE9c25hcHNob3QmaD1hNWRkNDc7DQo+IGRvd25sb2FkZmls
ZW5hbWU9bXlmaWxlLmJ6MiINCj4gDQo+IEEgcGF0Y2ggYWRkaW5nIHNvbWUgY29tbWVudHMgYWJv
dXQgdGhpcyB0byB3Z2V0LnB5IHdvdWxkIGJlIG5pY2UsIGFzDQo+IHdvdWxkIGEgcGF0Y2ggZG9j
dW1lbnRpbmcgaXQgaW4gdGhlIGJpdGJha2UgbWFudWFsLi4uDQo+IA0KPiBDaGVlcnMsDQo+IA0K
PiBSaWNoYXJkDQoNCg==

