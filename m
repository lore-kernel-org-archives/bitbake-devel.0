Return-Path: <rebecca.swee.fun.chang@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id F07717017D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Jun 2017 06:40:54 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2017 23:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,299,1493708400"; d="scan'208";a="270229422"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
	by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2017 23:40:50 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.82]) by
	KMSMSX151.gar.corp.intel.com ([169.254.10.60]) with mapi id
	14.03.0319.002; Mon, 5 Jun 2017 14:40:50 +0800
From: "Chang, Rebecca Swee Fun" <rebecca.swee.fun.chang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Bitbake dev Mailing
	List" <bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCHv2] bitbake-layers: check layer
	dependencies before adding
Thread-Index: AQHS2BSfIfEDk2YACUi4w/5ivdOlMqIJ8xQAgApQC4CAAZfrIA==
Date: Mon, 5 Jun 2017 06:40:49 +0000
Message-ID: <50B33AC5ED75F74F991980326F1C438D1F051098@PGSMSX103.gar.corp.intel.com>
References: <1496018646-92426-1-git-send-email-rebecca.swee.fun.chang@intel.com>
	<1496018646-92426-2-git-send-email-rebecca.swee.fun.chang@intel.com>
	<1496585591.6630.163.camel@linuxfoundation.org>
In-Reply-To: <1496585591.6630.163.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.102.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
MIME-Version: 1.0
Cc: "Phoong, Stanley Cheong Kwan" <stanley.cheong.kwan.phoong@intel.com>,
	"Eggleton, Paul" <paul.eggleton@intel.com>
Subject: Re: [PATCHv2] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Mon, 05 Jun 2017 06:40:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KVGhhbmtzISBXZSBoYXZlIGZvdW5kIG91dCB3aHkgaXQgZmFpbGVkLg0K
V2Ugd2VyZSB1c2luZyAiLWYiIHRvIGZvcmNlIGFkZCBhIGxheWVyIHdpdGhvdXQgZ29pbmcgdGhy
b3VnaCByZWNpcGUgcGFyc2UuDQpJIGp1c3QgcmVhbGl6ZWQgdGhlIGJpdGJha2Ugc2VsZnRlc3Rz
IHdlcmUgdXNpbmcgIi1mIiBpbiBiaXRiYWtlLWxheWVycyBzaG93LXJlY2lwZXMuDQpUaGUgYXJn
dW1lbnQgZmxhZ3Mgd2VyZSBvdmVycmlkaW5nIGVhY2ggb3RoZXIuDQpJIHdpbGwgZml4IHRoYXQg
aW4gdjMgcGF0Y2guDQoNClJlZ2FyZHMsDQpSZWJlY2NhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBQdXJkaWUgW21haWx0bzpyaWNoYXJkLnB1cmRpZUBs
aW51eGZvdW5kYXRpb24ub3JnXQ0KPiBTZW50OiBTdW5kYXksIEp1bmUgNCwgMjAxNyAxMDoxMyBQ
TQ0KPiBUbzogQ2hhbmcsIFJlYmVjY2EgU3dlZSBGdW4gPHJlYmVjY2Euc3dlZS5mdW4uY2hhbmdA
aW50ZWwuY29tPjsgQml0YmFrZQ0KPiBkZXYgTWFpbGluZyBMaXN0IDxiaXRiYWtlLWRldmVsQGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmc+DQo+IENjOiBQaG9vbmcsIFN0YW5sZXkgQ2hlb25nIEt3YW4g
PHN0YW5sZXkuY2hlb25nLmt3YW4ucGhvb25nQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFti
aXRiYWtlLWRldmVsXSBbUEFUQ0h2Ml0gYml0YmFrZS1sYXllcnM6IGNoZWNrIGxheWVyDQo+IGRl
cGVuZGVuY2llcyBiZWZvcmUgYWRkaW5nDQo+IA0KPiBPbiBNb24sIDIwMTctMDUtMjkgYXQgMDg6
NDQgKzA4MDAsIENoYW5nIFJlYmVjY2EgU3dlZSBGdW4gd3JvdGU6DQo+ID4gSW4gdGhlIG9yaWdp
bmFsIGltcGxlbWVudGF0aW9uLCAiYml0YmFrZS1sYXllcnMgYWRkLWxheWVycyA8bGF5ZXI+Ig0K
PiA+IHN1Y2NlZWRlZCB3aXRob3V0IGVycm9yIGNoZWNraW5nLiBUaGlzIHdpbGwgZnVydGhlciBp
bnRyb2R1Y2UgZmFpbHVyZXMNCj4gPiBpbiByZWNpcGUgcGFyc2luZyBvbmx5IHdoZW4gImJpdGJh
a2UiIGNvbW1hbmQgaXMgZXhlY3V0ZWQuDQo+ID4gQWRkaW5nIGEgbWV0YSBsYXllciB3aXRob3V0
IGl0cyBkZXBlbmRlbmN5IGxheWVyKHMpIHNob3VsZCBmYWlsZWQgYW5kDQo+ID4gZXhpdCB0aGUg
cHJvY2VzcyBncmFjZWZ1bGx5Lg0KPiA+DQo+ID4gQWRkZWQgZXh0cmEgYXJndW1lbnQgIi1mIiB0
byBmb3JjZSBhZGQgYSBsYXllciB3aXRob3V0IGNoZWNraW5nIGxheWVyDQo+ID4gZGVwZW5kZW5j
eS4NCj4gPg0KPiA+IFtZT0NUTyAjMTA5MTNdDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaG9v
bmcgU3RhbmxleSBDaGVvbmcgS3dhbiA8c3RhbmxleS5jaGVvbmcua3dhbi5waG9vbmcNCj4gPiBA
aW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoYW5nIFJlYmVjY2EgU3dlZSBGdW4gPHJl
YmVjY2Euc3dlZS5mdW4uY2hhbmdAaW50ZWwuYw0KPiA+IG9tPg0KPiA+IC0tLQ0KPiA+IMKgYmlu
L2JpdGJha2UtbGF5ZXJzwqDCoMKgwqDCoHzCoMKgMSArDQo+ID4gwqBsaWIvYmJsYXllcnMvYWN0
aW9uLnB5IHwgMjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiDCoDIgZmlsZXMgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IFRoaXMgcGF0Y2gg
c2VlbXMgdG8gcmVzdWx0IGluIHRoaXM6DQo+IA0KPiBodHRwczovL2F1dG9idWlsZGVyLnlvY3Rv
LmlvL2J1aWxkZXJzL25pZ2h0bHktb2UtDQo+IHNlbGZ0ZXN0L2J1aWxkcy8zMjAvc3RlcHMvUnVu
bmluZyUyMG9lLXNlbGZ0ZXN0L2xvZ3Mvc3RkaW8NCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hh
cmQNCg==

