Return-Path: <prvs=0312be7c04=alan.levy@plextek.com>
Received: from mailgate.plextek.co.uk (mailgate.plextek.co.uk [62.254.222.163])
	by mail.openembedded.org (Postfix) with ESMTP id 5746B77F2C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 May 2017 12:44:25 +0000 (UTC)
Received: from plextek-exch1.plextek.lan ([10.10.0.152]:17212)
	by mailgate.plextek.co.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <alan.levy@plextek.com>)
	id 1dBhGZ-00040t-0R; Fri, 19 May 2017 13:44:23 +0100
Received: from PLEXTEK-EXCH1.plextek.lan (10.10.0.152) by
	PLEXTEK-EXCH1.plextek.lan (10.10.0.152) with Microsoft SMTP Server
	(TLS) id 15.0.847.32; Fri, 19 May 2017 13:44:22 +0100
Received: from PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f]) by
	PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f%18]) with mapi id
	15.00.0847.030; Fri, 19 May 2017 13:44:22 +0100
From: Alan Levy <alan.levy@plextek.com>
To: Alexander Kanavin <alexander.kanavin@linux.intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Problem using Subversion in Pyro
Thread-Index: AdLP4VEXB/+GGF2XTGCDVOUoQEsY6QAm1/WAAAIiq2D///THAP//xefA
Date: Fri, 19 May 2017 12:44:21 +0000
Message-ID: <1501a694c3424e3198d31e65d0611b5a@PLEXTEK-EXCH1.plextek.lan>
References: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
	<1495187311.27342.149.camel@linuxfoundation.org>
	<ef364375f4c24847ae8d5b64b1905700@PLEXTEK-EXCH1.plextek.lan>
	<225ccc08-9962-d92a-309a-dd9c14417928@linux.intel.com>
In-Reply-To: <225ccc08-9962-d92a-309a-dd9c14417928@linux.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.12.154]
MIME-Version: 1.0
Subject: Re: Problem using Subversion in Pyro
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
X-List-Received-Date: Fri, 19 May 2017 12:44:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T0ssIEkgaGF2ZSBhbiBpZGVhIGhvdyB0byBkbyBpdCBjbGVhbmx5IGFuZCBlbGVnYW50bHkgd2l0
aG91dCBicmVha2luZyB0aGUgZXhpc3Rpbmcgc2NoZW1lIGJ1dCBpdCdsbCB0YWtlIHRpbWUgSSBo
YXZlbid0IGdvdCByaWdodCBub3cgc28gaXQgbWF5IGJlIGEgd2hpbGUuDQoNCkFsYW4NCg0KQUxB
TiBMRVZZLCBMZWFkIENvbnN1bHRhbnQsIEVtYmVkZGVkIFN5c3RlbXMNCg0KUGxleHRlayBDb25z
dWx0aW5nLCBUaGUgUGxleHRlayBCdWlsZGluZywgTG9uZG9uIFJvYWQsIEdyZWF0IENoZXN0ZXJm
b3JkLCBTYWZmcm9uIFdhbGRlbiwgQ0IxMCAxTlksIFVLDQpUOiArNDQgKDApIDE3OTkgNTMzMjAw
ICAgIEU6IGFsYW4ubGV2eUBwbGV4dGVrLmNvbSAgVzogd3d3LnBsZXh0ZWsuY29tDQoNCg0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiBbbWFp
bHRvOmFsZXhhbmRlci5rYW5hdmluQGxpbnV4LmludGVsLmNvbV0gDQpTZW50OiAxOSBNYXkgMjAx
NyAxMToxMA0KVG86IEFsYW4gTGV2eTsgUmljaGFyZCBQdXJkaWU7IGJpdGJha2UtZGV2ZWxAbGlz
dHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBQcm9ibGVt
IHVzaW5nIFN1YnZlcnNpb24gaW4gUHlybw0KDQpPbiAwNS8xOS8yMDE3IDEyOjU3IFBNLCBBbGFu
IExldnkgd3JvdGU6DQoNCj4gSSBjYW4gc2VlIHRoYXQgeW91IGRvbid0IHdhbnQgdG8gZm9yY2Ug
dGhlIGhvc3Qgc3lzdGVtIHRvIHN1cHBvcnQgDQo+IHN1YnZlcnNpb24gYW5kIEkgY29uY3VyIHRo
YXQgdGhlIHJlc3VsdGluZyBlcnJvciBtZXNzYWdlIGlzIHVuaGVscGZ1bC4NCj4NCj4gSG93ZXZl
ciB1bmRlciBNb3J0eSB0aGlzIHdvcmtlZCBqdXN0IGZpbmUgc28gUHlybyBicmVha3MgZXhpc3Rp
bmcgDQo+IHJlY2lwZXMgaW4gYSB3YXkgdGhhdCdzIHZlcnkgaGFyZCB0byB1bmRlcnN0YW5kLCBl
dmVuIGlmIHRoZSBzb2x1dGlvbiANCj4gaXMgZWFzeSBvbmNlIHlvdSBrbm93IGhvdy4gIEkgd291
bGQgc3VnZ2VzdCB0aGF0IGFzIHdlbGwgYXMgcHJvdmlkaW5nIA0KPiBhIGhlbHBmdWwgZXJyb3Ig
bWVzc2FnZSB0aGUgZG9jdW1lbnRhdGlvbiBzaG91bGQgYWxzbyBleHBsYWluIHdoYXQncyANCj4g
Z29pbmcgb24gYW5kIGhvdyB0byBmaXggaXQuDQoNCkFsYW4sIG1heSBJIHN1Z2dlc3QgdGhhdCB5
b3Ugd3JpdGUgdGhlIG5lY2Vzc2FyeSBwYXRjaGVzIGZvciB0aGlzIGFuZCBzZW5kIHRoZW0gaW4/
DQoNClRoYW5rcywNCkFsZXgNCg==

