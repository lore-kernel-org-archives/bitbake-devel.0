Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Qy1lc-0001JR-82
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 15:20:44 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Aug 2011 06:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,296,1312182000"; d="scan'208";a="12089757"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Aug 2011 06:15:50 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 29 Aug 2011 21:15:49 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Mon, 29 Aug 2011 21:15:48 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 29 Aug 2011 21:15:47 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of expand
	cache in getVar()
Thread-Index: AcxmTXVTg+/R781VQfGNUqFK1DTTPAAADCZg
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9CA@shsmsx501.ccr.corp.intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
	<a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
	<1314622519.5939.286.camel@rex>
	<D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
	<1314623585.5939.295.camel@rex>
In-Reply-To: <1314623585.5939.295.camel@rex>
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
X-List-Received-Date: Mon, 29 Aug 2011 13:20:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSBbbWFp
bHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IE1vbmRheSwg
QXVndXN0IDI5LCAyMDExIDk6MTMgUE0NCj4gVG86IFh1LCBEb25neGlhbw0KPiBDYzogYml0YmFr
ZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFJFOiBbYml0YmFrZS1k
ZXZlbF0gW1BBVENIIDEvMV0gZGF0YV9zbWFydC5weTogbWFrZSB1c2Ugb2YgZXhwYW5kDQo+IGNh
Y2hlIGluIGdldFZhcigpDQo+IA0KPiBPbiBNb24sIDIwMTEtMDgtMjkgYXQgMjE6MDcgKzA4MDAs
IFh1LCBEb25neGlhbyB3cm90ZToNCj4gPiBIaSBSaWNoYXJkLA0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUmljaGFyZCBQdXJkaWUgW21haWx0bzpy
aWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPiA+ID4gU2VudDogTW9uZGF5LCBB
dWd1c3QgMjksIDIwMTEgODo1NSBQTQ0KPiA+ID4gVG86IFh1LCBEb25neGlhbw0KPiA+ID4gQ2M6
IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6
IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggMS8xXSBkYXRhX3NtYXJ0LnB5OiBtYWtlIHVzZSBvZg0K
PiA+ID4gZXhwYW5kIGNhY2hlIGluIGdldFZhcigpDQo+ID4gPg0KPiA+ID4gT24gTW9uLCAyMDEx
LTA4LTI5IGF0IDE1OjMzICswODAwLCBEb25neGlhbyBYdSB3cm90ZToNCj4gPiA+ID4gQ3VycmVu
dGx5IGlmIHBhc3NpbmcgZXhwYW5kPVRydWUgdG8gZ2V0VmFyKCkgZnVuY3Rpb24sIGl0IHdpbGwN
Cj4gPiA+ID4gcGFzcyB0aGUgaGFuZGxpbmcgdG8gZ2V0VmFyRmxhZygpLCB3aGljaCBkb2Vzbid0
IGdldCBhbnkgYmVuZWZpdA0KPiA+ID4gPiBmcm9tIHRoZSBleHBhbmQgY2FjaGUuDQo+ID4gPiA+
DQo+ID4gPiA+IENhbGwgdGhlIGV4cGFuZCgpIGZ1bmN0aW9uIHNlcGFyYXRlbHkgaW4gZ2V0VmFy
KCkgdG8gbWFrZSB1c2Ugb2YNCj4gPiA+ID4gdGhlIGV4cGFuZCBjYWNoZSwgd2hpY2ggY2FuIGRl
Y3JlYXNlIHRoZSBwYXJzaW5nIHRpbWUgYnkgNDAlLg0KPiA+ID4gPiAoZnJvbSBjdXJyZW50IDQ5
cyB0byAyN3MpDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd4aWFvIFh1IDxk
b25neGlhby54dUBpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgbGliL2JiL2RhdGFf
c21hcnQucHkgfCAgICA3ICsrKysrKy0NCj4gPiA+ID4gIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
bGliL2JiL2RhdGFfc21hcnQucHkgYi9saWIvYmIvZGF0YV9zbWFydC5weSBpbmRleA0KPiA+ID4g
PiAzMDFmOWUzLi5kOGJhMjRmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9saWIvYmIvZGF0YV9zbWFy
dC5weQ0KPiA+ID4gPiArKysgYi9saWIvYmIvZGF0YV9zbWFydC5weQ0KPiA+ID4gPiBAQCAtMjY4
LDcgKzI2OCwxMiBAQCBjbGFzcyBEYXRhU21hcnQoTXV0YWJsZU1hcHBpbmcpOg0KPiA+ID4gPiAg
ICAgICAgICBzZWxmLmRpY3RbdmFyXVsiY29udGVudCJdID0gdmFsdWUNCj4gPiA+ID4NCj4gPiA+
ID4gICAgICBkZWYgZ2V0VmFyKHNlbGYsIHZhciwgZXhwYW5kPUZhbHNlLCBub3dlYWtkZWZhdWx0
PUZhbHNlKToNCj4gPiA+ID4gLSAgICAgICAgcmV0dXJuIHNlbGYuZ2V0VmFyRmxhZyh2YXIsICJj
b250ZW50IiwgZXhwYW5kLCBub3dlYWtkZWZhdWx0KQ0KPiA+ID4gPiArICAgICAgICB2YWx1ZSA9
IHNlbGYuZ2V0VmFyRmxhZyh2YXIsICJjb250ZW50IiwgRmFsc2UsDQo+ID4gPiA+ICsgbm93ZWFr
ZGVmYXVsdCkNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAjIENhbGwgZXhwYW5kKCkgc2Vw
YXJhdGVseSB0byBtYWtlIHVzZSBvZiB0aGUgZXhwYW5kIGNhY2hlDQo+ID4gPiA+ICsgICAgICAg
IGlmIGV4cGFuZCBhbmQgdmFsdWU6DQo+ID4gPiA+ICsgICAgICAgICAgICByZXR1cm4gc2VsZi5l
eHBhbmQodmFsdWUsIHZhcikNCj4gPiA+ID4gKyAgICAgICAgcmV0dXJuIHZhbHVlDQo+ID4gPiA+
DQo+ID4gPg0KPiA+ID4gV2h5IGNhbid0IHdlIGhhdmUgZ2V0VmFyRmxhZyB1c2UgdGhlIGV4cGFu
ZCBjYWNoZT8NCj4gPg0KPiA+IEZvciBleHBhbmQgY2FjaGUsIHRoZSBmb3JtYXQgaXMgYSBsaXN0
OiBleHBhbmRfY2FjaGVbdmFybmFtZV0uDQo+ID4gSXQgZG9lc24ndCBjb250YWluIGluZm9ybWF0
aW9uIG9mIGZsYWcgdmFsdWVzLg0KPiANCj4gR29vZCBwb2ludC4NCj4gDQo+IEknbSBsZWZ0IHdv
bmRlcmluZyB3aHkgd2UgZG9uJ3Qga2V5IHRoYXQgY2FjaGUgb24gdGhlIHVuZXhwYW5kZWQgdmFs
dWUgcmF0aGVyDQo+IHRoYW4gYSBzcGVjaWZpYyB2YXJpYWJsZSBuYW1lIChvciBuYW1lK2ZsYWcp
Lg0KPiANCj4gSSdsbCB0YWtlIHRoaXMgcGF0Y2ggYnV0IGl0cyBzb21ldGhpbmcgd2Ugc2hvdWxk
IGNvbnNpZGVyLi4uDQoNClRoYW5rcywgSSB3aWxsIHN0ZXAgaW50byB0aGlzIHBvaW50IGZ1cnRo
ZXIgYW5kIHNlZSBpZiAobmFtZStmbGFnKSB0eXBlIG9mIGNhY2hlIGNvdWxkIGJlbmVmaXQgdXMg
bW9yZS4NCg0KVGhhbmtzLA0KRG9uZ3hpYW8NCg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFy
ZA0KPiANCj4gDQoNCg==


