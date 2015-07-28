Return-Path: <juro.bystricky@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 339B6601F7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 16:06:47 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 28 Jul 2015 09:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,564,1432623600"; d="scan'208";a="614552044"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
	by orsmga003.jf.intel.com with ESMTP; 28 Jul 2015 09:06:40 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
	ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Tue, 28 Jul 2015 09:06:40 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.2.247]) by
	ORSMSX113.amr.corp.intel.com ([169.254.7.99]) with mapi id
	14.03.0224.002; Tue, 28 Jul 2015 09:06:40 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Olof Johansson <olof.johansson@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] wget.py: support for semi-colons in URL
Thread-Index: AQHQxwjZ7FINUjPjhESeHrY/nCojGJ3xMKOA///aqkA=
Date: Tue, 28 Jul 2015 16:06:40 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6101D2AA9@ORSMSX109.amr.corp.intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<1438081047-sup-2928@axis.com>
In-Reply-To: <1438081047-sup-2928@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
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
X-List-Received-Date: Tue, 28 Jul 2015 16:06:48 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSB0ZXN0ZWQgeW91ciBzdWdnZXN0aW9uIChyZXBsYWNpbmcgIjsiIHdpdGggIiYiIGluIHRoZSBT
UkNfVVJJICkgYW5kIGluIG15IGNhc2UgaXQgZGlkIHdvcmsgcHJvcGVybHkuDQpTbyBldmVuIGlm
IHRoaXMgbWF5IG5vdCBzb2x2ZSBldmVyeXRoaW5nLCBJIGJlbGlldmUgdGhpcyBzaG91bGQgYmUg
cHJvcGVybHkgZG9jdW1lbnRlZCBzb21ld2hlcmUNCmFzIHRoaXMgc2VlbXMgdG8gYmUgY3VycmVu
dGx5IHRoZSBvbmx5IHdheSB0byB1c2UgU1JDX1VSSSB3aXRoIHNlbWktY29sb25zIGluIFVSTC4N
Cg0KTm90ZSB0aGF0IG9uZSBzdGlsbCBuZWVkcyB0byBzcGVjaWZ5IHRoZSBkb3dubG9hZGVkIGZp
bGUgbmFtZSBtYW51YWxseSwgaS5lLg0KDQpTUkNfVVJJID0gImh0dHA6Ly9hYmMxMjMuY29tL2dp
dC8/cD1nY2MvZ2NjLmdpdCZhPXNuYXBzaG90Jmg9YTVkZDQ3OyBkb3dubG9hZGZpbGVuYW1lPW15
ZmlsZS5iejIiDQoNClRoYW5rcw0KDQpKdXJvIEJ5c3RyaWNreQ0KDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24gW21haWx0bzpvbG9mLmpvaGFu
c3NvbkBheGlzLmNvbV0NCj4gU2VudDogVHVlc2RheSwgSnVseSAyOCwgMjAxNSA0OjAxIEFNDQo+
IFRvOiBCeXN0cmlja3ksIEp1cm87IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gd2dldC5weTogc3VwcG9y
dCBmb3Igc2VtaS1jb2xvbnMgaW4NCj4gVVJMDQo+IA0KPiBFeGNlcnB0cyBmcm9tIEp1cm8gQnlz
dHJpY2t5J3MgbWVzc2FnZSBvZiAyMDE1LTA3LTI1IDIwOjMyOjQzICswMjAwOg0KPiA+IFNvbWUg
VVJMcyBjb250YWluIHNlbWktY29sb25zLiBGb3IgZXhhbXBsZSwgc29tZSBHSVQgcmVwb3NpdG9y
aWVzDQo+ID4gc3VwcG9ydCBkb3dubG9hZGluZyBzbmFwc2hvdHMgdXNpbmcgVVJMIHN1Y2ggYXM6
DQo+ID4NCj4gPiAiaHR0cDovL2FiYzEyMy5jb20vZ2l0Lz9wPWdjYy9nY2MuZ2l0O2E9c25hcHNo
b3Q7aD1hNWRkNDciDQo+ID4NCj4gPiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gd2F5IHRvIGNvbnN0
cnVjdCBTUkNfVVJJIHdpdGggc3VjaCBVUkxzLg0KPiA+IEJpdGJha2UgdXNlcyBzZW1pLWNvbG9u
cyBpbiBTUkNfVVJJIGFzIGRlbGltaXRlcnMgZm9yIHZhcmlvdXMgcGFyYW1ldGVycy4NCj4gDQo+
IFczQyBfcmVjb21tZW5kc18gWzFdIHRoYXQgSFRUUCBVUkwgY29uc3VtZXJzIHRyZWF0IDsgaW4g
cXVlcnkgc3RyaW5ncyBhcw0KPiBhbiAmOg0KPiANCj4gPiBXZSByZWNvbW1lbmQgdGhhdCBIVFRQ
IHNlcnZlciBpbXBsZW1lbnRvcnMsIGFuZCBpbiBwYXJ0aWN1bGFyLCBDR0kNCj4gPiBpbXBsZW1l
bnRvcnMgc3VwcG9ydCB0aGUgdXNlIG9mICI7IiBpbiBwbGFjZSBvZiAiJiIgdG8gc2F2ZSBhdXRo
b3JzDQo+ID4gdGhlIHRyb3VibGUgb2YgZXNjYXBpbmcgIiYiIGNoYXJhY3RlcnMgaW4gdGhpcyBt
YW5uZXIuDQo+IA0KPiBUaGlzIG1lYW5zIHRoYXQNCj4gDQo+ICAgaHR0cDovL2FiYzEyMy5jb20v
Z2l0Lz9wPWdjYy9nY2MuZ2l0O2E9c25hcHNob3Q7aD1hNWRkNDcNCj4gDQo+IGFuZA0KPiANCj4g
ICBodHRwOi8vYWJjMTIzLmNvbS9naXQvP3A9Z2NjL2djYy5naXQmYT1zbmFwc2hvdCZoPWE1ZGQ0
Nw0KPiANCj4gc2hvdWxkIGJlIGVxdWl2YWxlbnQuIEkgZG9uJ3Qga25vdyBob3cgd2VsbCBzcHJl
YWQgdGhpcyBzdXBwb3J0IGlzLCBvciBpZiBpdA0KPiB3b3JrcyBpbiB5b3VyIGNhc2UsIGJ1dCBp
dCdzIGEgd29ya2Fyb3VuZCBpZiBpdCBkb2VzIGF0IGxlYXN0Lg0KPiANCj4gMTogaHR0cDovL3d3
dy53My5vcmcvVFIvMTk5OS9SRUMtaHRtbDQwMS0NCj4gMTk5OTEyMjQvYXBwZW5kaXgvbm90ZXMu
aHRtbCNoLUIuMi4yDQo+IA0KPiAtLQ0KPiBvbG9mIGpvaGFuc3Nvbg0K

