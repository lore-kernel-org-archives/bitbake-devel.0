Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Qy1dl-00015n-GF
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 15:12:37 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Aug 2011 06:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,296,1312182000"; d="scan'208";a="12087637"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Aug 2011 06:07:43 -0700
Received: from pgsmsx101.gar.corp.intel.com (10.221.44.78) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 29 Aug 2011 21:07:42 +0800
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.323.3; Mon, 29 Aug 2011 21:07:42 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Mon, 29 Aug 2011 21:07:41 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 29 Aug 2011 21:07:40 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of expand
	cache in getVar()
Thread-Index: AcxmSvKKBconh4oMT3ecgsG3v1CSBgAAWU/Q
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
	<a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
	<1314622519.5939.286.camel@rex>
In-Reply-To: <1314622519.5939.286.camel@rex>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] data_smart.py: make use of expand cache in getVar()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Aug 2011 13:12:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNo
YXJkIFB1cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+
IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI5LCAyMDExIDg6NTUgUE0NCj4gVG86IFh1LCBEb25neGlh
bw0KPiBDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6
IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDEvMV0gZGF0YV9zbWFydC5weTogbWFrZSB1c2Ug
b2YgZXhwYW5kDQo+IGNhY2hlIGluIGdldFZhcigpDQo+IA0KPiBPbiBNb24sIDIwMTEtMDgtMjkg
YXQgMTU6MzMgKzA4MDAsIERvbmd4aWFvIFh1IHdyb3RlOg0KPiA+IEN1cnJlbnRseSBpZiBwYXNz
aW5nIGV4cGFuZD1UcnVlIHRvIGdldFZhcigpIGZ1bmN0aW9uLCBpdCB3aWxsIHBhc3MNCj4gPiB0
aGUgaGFuZGxpbmcgdG8gZ2V0VmFyRmxhZygpLCB3aGljaCBkb2Vzbid0IGdldCBhbnkgYmVuZWZp
dCBmcm9tIHRoZQ0KPiA+IGV4cGFuZCBjYWNoZS4NCj4gPg0KPiA+IENhbGwgdGhlIGV4cGFuZCgp
IGZ1bmN0aW9uIHNlcGFyYXRlbHkgaW4gZ2V0VmFyKCkgdG8gbWFrZSB1c2Ugb2YgdGhlDQo+ID4g
ZXhwYW5kIGNhY2hlLCB3aGljaCBjYW4gZGVjcmVhc2UgdGhlIHBhcnNpbmcgdGltZSBieSA0MCUu
DQo+ID4gKGZyb20gY3VycmVudCA0OXMgdG8gMjdzKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RG9uZ3hpYW8gWHUgPGRvbmd4aWFvLnh1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL2Ji
L2RhdGFfc21hcnQucHkgfCAgICA3ICsrKysrKy0NCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2Ji
L2RhdGFfc21hcnQucHkgYi9saWIvYmIvZGF0YV9zbWFydC5weSBpbmRleA0KPiA+IDMwMWY5ZTMu
LmQ4YmEyNGYgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL2JiL2RhdGFfc21hcnQucHkNCj4gPiArKysg
Yi9saWIvYmIvZGF0YV9zbWFydC5weQ0KPiA+IEBAIC0yNjgsNyArMjY4LDEyIEBAIGNsYXNzIERh
dGFTbWFydChNdXRhYmxlTWFwcGluZyk6DQo+ID4gICAgICAgICAgc2VsZi5kaWN0W3Zhcl1bImNv
bnRlbnQiXSA9IHZhbHVlDQo+ID4NCj4gPiAgICAgIGRlZiBnZXRWYXIoc2VsZiwgdmFyLCBleHBh
bmQ9RmFsc2UsIG5vd2Vha2RlZmF1bHQ9RmFsc2UpOg0KPiA+IC0gICAgICAgIHJldHVybiBzZWxm
LmdldFZhckZsYWcodmFyLCAiY29udGVudCIsIGV4cGFuZCwgbm93ZWFrZGVmYXVsdCkNCj4gPiAr
ICAgICAgICB2YWx1ZSA9IHNlbGYuZ2V0VmFyRmxhZyh2YXIsICJjb250ZW50IiwgRmFsc2UsIG5v
d2Vha2RlZmF1bHQpDQo+ID4gKw0KPiA+ICsgICAgICAgICMgQ2FsbCBleHBhbmQoKSBzZXBhcmF0
ZWx5IHRvIG1ha2UgdXNlIG9mIHRoZSBleHBhbmQgY2FjaGUNCj4gPiArICAgICAgICBpZiBleHBh
bmQgYW5kIHZhbHVlOg0KPiA+ICsgICAgICAgICAgICByZXR1cm4gc2VsZi5leHBhbmQodmFsdWUs
IHZhcikNCj4gPiArICAgICAgICByZXR1cm4gdmFsdWUNCj4gPg0KPiANCj4gV2h5IGNhbid0IHdl
IGhhdmUgZ2V0VmFyRmxhZyB1c2UgdGhlIGV4cGFuZCBjYWNoZT8NCg0KRm9yIGV4cGFuZCBjYWNo
ZSwgdGhlIGZvcm1hdCBpcyBhIGxpc3Q6IGV4cGFuZF9jYWNoZVt2YXJuYW1lXS4NCkl0IGRvZXNu
J3QgY29udGFpbiBpbmZvcm1hdGlvbiBvZiBmbGFnIHZhbHVlcy4NCg0KVGhhbmtzLA0KRG9uZ3hp
YW8NCg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KDQo=


