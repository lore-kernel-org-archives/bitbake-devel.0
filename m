Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Qy2oh-0002vj-9l
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 16:27:59 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Aug 2011 07:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,296,1312182000"; d="scan'208";a="46094800"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2011 07:21:57 -0700
Received: from pgsmsx509.gar.corp.intel.com (172.30.13.17) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 29 Aug 2011 22:21:57 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 29 Aug 2011 22:21:56 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Mon, 29 Aug 2011 22:21:56 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 29 Aug 2011 22:21:54 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of expand
	cache in getVar()
Thread-Index: AcxmTXVTg+/R781VQfGNUqFK1DTTPAAADCZgAAIF5xA=
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9FC@shsmsx501.ccr.corp.intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
	<a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
	<1314622519.5939.286.camel@rex>
	<D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
	<1314623585.5939.295.camel@rex> 
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
X-List-Received-Date: Mon, 29 Aug 2011 14:27:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYdSwg
RG9uZ3hpYW8NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjksIDIwMTEgOToxNiBQTQ0KPiBUbzog
UmljaGFyZCBQdXJkaWUNCj4gQ2M6IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zw0KPiBTdWJqZWN0OiBSRTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGRhdGFfc21hcnQu
cHk6IG1ha2UgdXNlIG9mIGV4cGFuZA0KPiBjYWNoZSBpbiBnZXRWYXIoKQ0KPiANCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJpY2hhcmQgUHVyZGllIFttYWlsdG86
cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyOSwgMjAxMSA5OjEzIFBNDQo+ID4gVG86IFh1LCBEb25neGlhbw0KPiA+IENjOiBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiBTdWJqZWN0OiBSRTogW2JpdGJh
a2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGRhdGFfc21hcnQucHk6IG1ha2UgdXNlIG9mDQo+ID4gZXhw
YW5kIGNhY2hlIGluIGdldFZhcigpDQo+ID4NCj4gPiBPbiBNb24sIDIwMTEtMDgtMjkgYXQgMjE6
MDcgKzA4MDAsIFh1LCBEb25neGlhbyB3cm90ZToNCj4gPiA+IEhpIFJpY2hhcmQsDQo+ID4gPg0K
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBSaWNoYXJk
IFB1cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+ID4g
PiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI5LCAyMDExIDg6NTUgUE0NCj4gPiA+ID4gVG86IFh1
LCBEb25neGlhbw0KPiA+ID4gPiBDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnDQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDEvMV0gZGF0
YV9zbWFydC5weTogbWFrZSB1c2UNCj4gPiA+ID4gb2YgZXhwYW5kIGNhY2hlIGluIGdldFZhcigp
DQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgMjAxMS0wOC0yOSBhdCAxNTozMyArMDgwMCwgRG9u
Z3hpYW8gWHUgd3JvdGU6DQo+ID4gPiA+ID4gQ3VycmVudGx5IGlmIHBhc3NpbmcgZXhwYW5kPVRy
dWUgdG8gZ2V0VmFyKCkgZnVuY3Rpb24sIGl0IHdpbGwNCj4gPiA+ID4gPiBwYXNzIHRoZSBoYW5k
bGluZyB0byBnZXRWYXJGbGFnKCksIHdoaWNoIGRvZXNuJ3QgZ2V0IGFueSBiZW5lZml0DQo+ID4g
PiA+ID4gZnJvbSB0aGUgZXhwYW5kIGNhY2hlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2FsbCB0
aGUgZXhwYW5kKCkgZnVuY3Rpb24gc2VwYXJhdGVseSBpbiBnZXRWYXIoKSB0byBtYWtlIHVzZSBv
Zg0KPiA+ID4gPiA+IHRoZSBleHBhbmQgY2FjaGUsIHdoaWNoIGNhbiBkZWNyZWFzZSB0aGUgcGFy
c2luZyB0aW1lIGJ5IDQwJS4NCj4gPiA+ID4gPiAoZnJvbSBjdXJyZW50IDQ5cyB0byAyN3MpDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25neGlhbyBYdSA8ZG9uZ3hpYW8u
eHVAaW50ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBsaWIvYmIvZGF0YV9zbWFy
dC5weSB8ICAgIDcgKysrKysrLQ0KPiA+ID4gPiA+ICAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9saWIvYmIvZGF0YV9zbWFydC5weSBiL2xpYi9iYi9kYXRhX3NtYXJ0LnB5IGluZGV4DQo+ID4g
PiA+ID4gMzAxZjllMy4uZDhiYTI0ZiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9saWIvYmIvZGF0
YV9zbWFydC5weQ0KPiA+ID4gPiA+ICsrKyBiL2xpYi9iYi9kYXRhX3NtYXJ0LnB5DQo+ID4gPiA+
ID4gQEAgLTI2OCw3ICsyNjgsMTIgQEAgY2xhc3MgRGF0YVNtYXJ0KE11dGFibGVNYXBwaW5nKToN
Cj4gPiA+ID4gPiAgICAgICAgICBzZWxmLmRpY3RbdmFyXVsiY29udGVudCJdID0gdmFsdWUNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgZGVmIGdldFZhcihzZWxmLCB2YXIsIGV4cGFuZD1GYWxz
ZSwgbm93ZWFrZGVmYXVsdD1GYWxzZSk6DQo+ID4gPiA+ID4gLSAgICAgICAgcmV0dXJuIHNlbGYu
Z2V0VmFyRmxhZyh2YXIsICJjb250ZW50IiwgZXhwYW5kLCBub3dlYWtkZWZhdWx0KQ0KPiA+ID4g
PiA+ICsgICAgICAgIHZhbHVlID0gc2VsZi5nZXRWYXJGbGFnKHZhciwgImNvbnRlbnQiLCBGYWxz
ZSwNCj4gPiA+ID4gPiArIG5vd2Vha2RlZmF1bHQpDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsg
ICAgICAgICMgQ2FsbCBleHBhbmQoKSBzZXBhcmF0ZWx5IHRvIG1ha2UgdXNlIG9mIHRoZSBleHBh
bmQgY2FjaGUNCj4gPiA+ID4gPiArICAgICAgICBpZiBleHBhbmQgYW5kIHZhbHVlOg0KPiA+ID4g
PiA+ICsgICAgICAgICAgICByZXR1cm4gc2VsZi5leHBhbmQodmFsdWUsIHZhcikNCj4gPiA+ID4g
PiArICAgICAgICByZXR1cm4gdmFsdWUNCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBXaHkg
Y2FuJ3Qgd2UgaGF2ZSBnZXRWYXJGbGFnIHVzZSB0aGUgZXhwYW5kIGNhY2hlPw0KPiA+ID4NCj4g
PiA+IEZvciBleHBhbmQgY2FjaGUsIHRoZSBmb3JtYXQgaXMgYSBsaXN0OiBleHBhbmRfY2FjaGVb
dmFybmFtZV0uDQo+ID4gPiBJdCBkb2Vzbid0IGNvbnRhaW4gaW5mb3JtYXRpb24gb2YgZmxhZyB2
YWx1ZXMuDQo+ID4NCj4gPiBHb29kIHBvaW50Lg0KPiA+DQo+ID4gSSdtIGxlZnQgd29uZGVyaW5n
IHdoeSB3ZSBkb24ndCBrZXkgdGhhdCBjYWNoZSBvbiB0aGUgdW5leHBhbmRlZCB2YWx1ZQ0KPiA+
IHJhdGhlciB0aGFuIGEgc3BlY2lmaWMgdmFyaWFibGUgbmFtZSAob3IgbmFtZStmbGFnKS4NCj4g
Pg0KPiA+IEknbGwgdGFrZSB0aGlzIHBhdGNoIGJ1dCBpdHMgc29tZXRoaW5nIHdlIHNob3VsZCBj
b25zaWRlci4uLg0KPiANCj4gVGhhbmtzLCBJIHdpbGwgc3RlcCBpbnRvIHRoaXMgcG9pbnQgZnVy
dGhlciBhbmQgc2VlIGlmIChuYW1lK2ZsYWcpIHR5cGUgb2YgY2FjaGUNCj4gY291bGQgYmVuZWZp
dCB1cyBtb3JlLg0KDQpTb3JyeSBJIG11c3QgbWlzdW5kZXJzdGFuZCB5b3VyIHBvaW50IGp1c3Qg
bm93Li4uDQoNCkZvciBjYWNoaW5nIG9mIHVuZXhwYW5kZWQgdmFsdWUsIHRoZXJlIGFyZSB0b28g
bWFueS91bmNlcnRhaW50eSBvZiB0eXBlcywgbGlrZToNCg0KJHtUVU5FX0FSQ0h9DQoke0BiYi5w
YXJzZS5CQkhhbmRsZXIudmFyc19mcm9tX2ZpbGUoYmIuZGF0YS5nZXRWYXIoJ0ZJTEUnLGQpLGQp
WzBdIG9yICdkZWZhdWx0cGtnbmFtZSd9DQoke0BiYi51dGlscy5jb250YWlucygiVFVORV9GRUFU
VVJFUyIsICJtMzIiLCAiJHtYODZBUkNIMzJ9IiwgIiIgLGQpfSR7QGJiLnV0aWxzLmNvbnRhaW5z
KCJUVU5FX0ZFQVRVUkVTIiwgIm14MzIiLCAiJHtYODZBUkNINjR9IiwgIiIgLGQpfSR7QGJiLnV0
aWxzLmNvbnRhaW5zKCJUVU5FX0ZFQVRVUkVTIiwgIm02NCIsICIke1g4NkFSQ0g2NH0iLCAiIiAs
ZCl9DQoNCkZvciBzaW1wbGUgdmFyaWFibGVzLCBpdCBpcyBlYXN5IHRvIGNhY2hlLCBob3dldmVy
IGZvciB0aGUgZXhwcmVzc2lvbnMsIGl0IG1heSBub3Qgc3VpdGFibGUgdG8gY2FjaGUuDQoNCkJl
c2lkZXMsIEkgYWxzbyB0cmllZCB0aGUgKG5hbWUrZmxhZykgdHlwZXMgb2YgY2FjaGUsIGJ1dCBp
dCBkb2Vzbid0IGJyaW5nIGJlbmVmaXQgKGZyb20gMjdzIHRvIDI4cykuIFRoZXJlZm9yZSBpdCBp
cyBzdXBwb3NlIHRoYXQgbW9zdCBvZiB0aGUgY2FsbGluZyBzaG91bGQgYmUgZ2V0VmFyKCkuIFRo
b3NlIHNwZWNpZmljYWxseSBnZXR0aW5nIGZsYWcgdmFsdWUgc2hvdWxkIGJlIG5vdCBtdWNoLg0K
DQpUaGFua3MsDQpEb25neGlhbw0KDQo+IA0KPiBUaGFua3MsDQo+IERvbmd4aWFvDQo+IA0KPiA+
DQo+ID4gQ2hlZXJzLA0KPiA+DQo+ID4gUmljaGFyZA0KPiA+DQo+ID4NCg0K


