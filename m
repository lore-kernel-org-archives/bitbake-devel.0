Return-Path: <juro.bystricky@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 5F95A71DA3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 17:01:59 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga105.fm.intel.com with ESMTP; 13 Jan 2017 09:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,222,1477983600"; d="scan'208";a="1082627982"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
	by orsmga001.jf.intel.com with ESMTP; 13 Jan 2017 09:01:59 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
	ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Fri, 13 Jan 2017 09:01:59 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
	ORSMSX155.amr.corp.intel.com ([169.254.7.181]) with mapi id
	14.03.0248.002; Fri, 13 Jan 2017 09:01:58 -0800
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] cookerdata.py: check for existence of configuration files
Thread-Index: AQHSbS3MF4OkEWe6YkOBLLR06o+YVaE2wqMA///esFA=
Date: Fri, 13 Jan 2017 17:01:58 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118F34AD@ORSMSX112.amr.corp.intel.com>
References: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
	<1484304882.4367.252.camel@linuxfoundation.org>
In-Reply-To: <1484304882.4367.252.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>
Subject: Re: [PATCH] cookerdata.py: check for existence of configuration files
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
X-List-Received-Date: Fri, 13 Jan 2017 17:02:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBzZWUgeW91ciBwb2ludC4gVGhlIHJvdXRlIHZpYSBhIGR1bW15IGRlZmF1bHQuY29uZiB3b3Vs
ZCByZXF1aXJlIGhhdmluZyANCnRoZSBmb2xkZXIgY29uZi9tdWx0aWNvbmZpZyBwcmVzZW50IGV2
ZW4gZm9yIHVzZXJzIG5vdCByZWFsbHkgaW50ZXJlc3RlZCBpbiANCm11bHRpY29uZmlnLiBOb3Qg
YSBzaG93IHN0b3BwZXIsIGl0IHdvdWxkIGJlIGp1c3QgYW5vdGhlciBmaWxlIGNyZWF0ZWQgYnkN
Cm9lLWluaXQtYnVpbGQtZW52LiAoQW5vdGhlciBwb3NzaWJpbGl0eSBpcyB0byBoYXZlIHRoZSBl
cnJvciBjaGVjayBhcyBwYXJ0IA0Kb2Ygc2FuaXR5IGNoZWNraW5nKQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgUHVyZGllIFttYWlsdG86cmljaGFyZC5w
dXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEzLCAy
MDE3IDI6NTUgQU0NCj4gVG86IEJ5c3RyaWNreSwgSnVybyA8anVyby5ieXN0cmlja3lAaW50ZWwu
Y29tPjsgYml0YmFrZS0NCj4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBDYzoganVy
b2J5c3RyaWNreUBob3RtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjb29rZXJkYXRh
LnB5OiBjaGVjayBmb3IgZXhpc3RlbmNlIG9mIGNvbmZpZ3VyYXRpb24NCj4gZmlsZXMNCj4gDQo+
IE9uIFRodSwgMjAxNy0wMS0xMiBhdCAxNTo0MCAtMDgwMCwgSnVybyBCeXN0cmlja3kgd3JvdGU6
DQo+ID4gUHJlc2VudGx5IHRoZXJlIGlzIG5vIGNoZWNrIHRvIHZlcmlmeSB0aGUgZXhpc3RlbmNl
IG9mIGNvbmZpZ3VyYXRpb24NCj4gPiBmaWxlcyBhcyBsaXN0ZWQgaW4gQkJNVUxUSUNPTkZJRy4g
Rm9yIGV4YW1wbGUsIEJCTVVMVElDT05GSUcgPQ0KPiA+ICJmb29iYXIiIGluIGxvY2FsLmNvbmYN
Cj4gPiBkb2VzIG5vdCB0cmlnZ2VyIGFuIGVycm9yIHdoZW4gdGhlcmUgaXMgbm8NCj4gPiBjb25m
L211bHRpY29uZmlnL2Zvb2Jhci5jb25mLg0KPiA+IFRoZSBtaXNzaW5nIGZpbGUgaXMgc2lsZW50
bHkgaWdub3JlZC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdmVyaWZpZXMgdGhlIGV4aXN0ZW5jZSBv
ZiBjb25maWcgZmlsZXMgYW5kIGVycm9ycy1vdXQgd2l0aA0KPiA+IHRoZSBtZXNzYWdlOg0KPiA+
DQo+ID4gRVJST1I6IEJCTVVMVElDT05GSUc9ImZvb2JhciIgYnV0IHRoZSBjb25maWd1cmF0aW9u
IGZpbGUNCj4gPiAnLi9jb25mL211bHRpY29uZmlnL2Zvb2Jhci5jb25mJyBkb2VzIG5vdCBleGlz
dCENCj4gPg0KPiA+IHdoZW4gdGhlIGZpbGUgZG9lcyBub3QgZXhpc3QuDQo+ID4NCj4gPiBbWU9D
VE8jMTA5MTddDQo+IA0KPiBTb3JyeSBidXQgd2UgY2FuJ3QgZG8gdGhpcy4gT25lIHJlYXNvbiBm
b3Igc29tZSBvZiB0aGUgcmVjZW50IGNoYW5nZXMNCj4gd2FzIHRvIG1vdmUgdGhlIGhhbmRsaW5n
IG9mIHRoaXMgdG8gdGhlIG1ldGFkYXRhIGFuZCBvdXQgb2YgYml0YmFrZS4NCj4gV2UndmUgdGhl
cmVmb3JlIG5vdyBnb3Q6DQo+IA0KPiBpbmNsdWRlIGNvbmYvbXVsdGljb25maWcvJHtCQl9DVVJS
RU5UX01DfS5jb25mDQo+IA0KPiBpbiBiaXRiYWtlLmNvbmYgYW5kIHRoZSBzeXN0ZW0gbG9va3Mg
Zm9yIHRoZSBmaWxlIHRoYXQgd2F5LiBUaGUgdXNlciBpcw0KPiBmcmVlIHRvIGFkZCBvdGhlciBm
aWxlcyBpbiBvdGhlciBwYXRocyBhbmQgYml0YmFrZSBkb2Vzbid0IGtub3cvY2FyZQ0KPiBhYm91
dCB0aGUgZGlyZWN0b3J5IGxheW91dC4NCj4gDQo+IElmIHdlIHJlYWxseSB3YW50IHRvIG1ha2Ug
dGhpcyBlcnJvciwgd2UnZCBuZWVkIHRvIGFkZCBhbiBlbXB0eQ0KPiBjb25mL211bHRpY29uZmln
L2RlZmF1bHQuY29uZiBhbmQgdGhlbiBjaGFuZ2UgdGhpcyB0byBhIHJlcXVpcmUgaW5zdGVhZA0K
PiBvZiBhbiBpbmNsdWRlLiBCaXRiYWtlJ3Mgc3RhbmRhcmQgZXJyb3IgbWVzc2FnZXMgd291bGQg
dGhlbiBraWNrIGluLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0K

