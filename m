Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Sc8YH-0000Cl-23
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 07:13:01 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 05 Jun 2012 22:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="108375254"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Jun 2012 22:02:21 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 5 Jun 2012 22:02:19 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.56]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.90]) with mapi id
	14.01.0355.002; Wed, 6 Jun 2012 13:01:15 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Kang Kai <Kai.Kang@windriver.com>, Darren Hart <dvhart@linux.intel.com>
Thread-Topic: [PATCH 2/2] hob2: create a standalone deploy image tool
Thread-Index: AQHNQ5R8sLAhht/9+EqNOtpS2dpXa5bsuzCA
Date: Wed, 6 Jun 2012 05:01:15 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BCB4D1@SHSMSX102.ccr.corp.intel.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
	<4FCDAF89.8000803@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA684@SHSMSX102.ccr.corp.intel.com>
	<4FCDC027.5030304@windriver.com> <4FCE40D9.8070107@linux.intel.com>
	<4FCECE80.3090604@windriver.com>
In-Reply-To: <4FCECE80.3090604@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"zhenfeng.zhao@windriver.com" <zhenfeng.zhao@windriver.com>
Subject: Re: [PATCH 2/2] hob2: create a standalone deploy image tool
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
X-List-Received-Date: Wed, 06 Jun 2012 05:13:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

S2FuZyBLYWkgd3JvdGUgb27CoDIwMTItMDYtMDY6DQoNCj4gT24gMjAxMuW5tDA25pyIMDbml6Ug
MDE6MjQsIERhcnJlbiBIYXJ0IHdyb3RlOg0KPj4gDQo+PiBPbiAwNi8wNS8yMDEyIDAxOjE1IEFN
LCBLYW5nIEthaSB3cm90ZToNCj4+PiBPbiAyMDEy5bm0MDbmnIgwNeaXpSAxNTo0MCwgV2FuZywg
U2hhbmUgd3JvdGU6DQo+Pj4+IEthbmcgS2FpIHdyb3RlIG9uIDIwMTItMDYtMDU6DQo+Pj4+IA0K
Pj4+Pj4gT24gMjAxMuW5tDA25pyIMDXml6UgMTQ6NDIsIFdhbmcsIFNoYW5lIHdyb3RlOg0KPj4+
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+PiBGcm9tOiBLYW5nIEthaSBb
bWFpbHRvOmthaS5rYW5nQHdpbmRyaXZlci5jb21dDQo+Pj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1
bmUgMDUsIDIwMTIgMTE6MzcgQU0NCj4+Pj4+Pj4gVG86IGR2aGFydEBsaW51eC5pbnRlbC5jb20N
Cj4+Pj4+Pj4gQ2M6IFdhbmcsIFNoYW5lOyB6aGVuZmVuZy56aGFvQHdpbmRyaXZlci5jb207DQo+
Pj4+Pj4+IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPj4+Pj4+PiBTdWJq
ZWN0OiBbUEFUQ0ggMi8yXSBob2IyOiBjcmVhdGUgYSBzdGFuZGFsb25lIGRlcGxveSBpbWFnZSB0
b29sDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYml0YmFrZS9saWIvYmIvdWkvY3J1
bWJzL3V0aWxzLnB5DQo+Pj4+Pj4+IGIvYml0YmFrZS9saWIvYmIvdWkvY3J1bWJzL3V0aWxzLnB5
DQo+Pj4+Pj4+IGluZGV4IGNkMDFhMDQuLjkzOTg2NGYgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL2Jp
dGJha2UvbGliL2JiL3VpL2NydW1icy91dGlscy5weQ0KPj4+Pj4+PiArKysgYi9iaXRiYWtlL2xp
Yi9iYi91aS9jcnVtYnMvdXRpbHMucHkNCj4+Pj4+Pj4gQEAgLTIyLDYgKzIyLDcgQEANCj4+Pj4+
Pj4gICAgICMgYml0YmFrZSB3aGljaCB3aWxsIGFsbG93IG1vcmUgZmxleGliaWxpdHkuDQo+Pj4+
Pj4+ICAgICANCj4+Pj4+Pj4gICAgIGltcG9ydCBvcw0KPj4+Pj4+PiAraW1wb3J0IGJiDQo+Pj4+
Pj4gV2h5IGlzIHRoaXMgbmVlZGVkPyBJIGRvbid0IHNlZSBhbnkgY2hhbmdlIHlvdSBtYWRlIGlu
IHV0aWxzLnB5Lg0KPj4+Pj4+IElzIHRoYXQgdG8gc2F5IHdpdGhvdXQgdGhpcyBsaW5lLCB0aGUg
ZnVuY3Rpb25zIGluIHV0aWxzLnB5IGRvbid0IHdvcms/DQo+Pj4+PiBXaXRob3V0IHRoZSBpbXBv
cnQsIGl0IGp1c3QgY29tcGxhaW5zIHRoYXQNCj4+Pj4+IA0KPj4+Pj4gTmFtZUVycm9yOiBnbG9i
YWwgbmFtZSAnYmInIGlzIG5vdCBkZWZpbmVkDQo+Pj4+PiANCj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+
PiBLYWkNCj4+Pj4gT0ssIEl0IHNlZW1zIFNhdWwgZGlkbid0IHRlc3QgaXQgd2hlbiBoZSBjcmVh
dGVkIHV0aWxzLnB5Oy0pDQo+Pj4gSSBhbSBub3QgcXVpdCBzdXJlIGJlY2F1c2UgaXQgaXMgZmlu
ZSB3aGVuIGNhbGwgdGhlIGRlcGxveSBpbWFnZSBpbiB0aGUNCj4+PiBob2IuIGxpdHRsZSB3ZWly
ZC4NCj4+PiANCj4+IFByb2JhYmx5IGJlY2F1c2UgYW5vdGhlciBmaWxlIGluIHRoZSBpbXBvcnQg
bGlzdCBpbmNsdWRlcyBiYi4NCj4+IA0KPj4gSG93ZXZlciwgdGhpcyBjaGFuZ2UgaXMgbm90IHNw
ZWNpZmljIHRvIHRoZSBpbWFnZSB0b29sIGFuZCBzaG91bGQgYmUNCj4+IGJyb2tlbiBvdXQgYXMg
YSBzZXBhcmF0ZSBwYXRjaC4gdXRpbHMucHkgbWFrZXMgY2FsbHMgdG8gYmIudXRpbHMud2hpY2go
KQ0KPj4gb24gdGhlIHRoaXJkIHNvdXJjZSBsaW5lLCBzbyBiYiBzaG91bGQgY2VydGFpbmx5IGJl
IGltcG9ydGVkIGluIHV0aWxzLnB5Lg0KPiANCj4gQnV0IEkgaW1wb3J0IGJiIGluIHRoZSBiaXRi
YWtlLWRlcGxveWltYWdlIHRvby4gSXQgc3RpbGwgY29tcGxhaW5zIGxhY2sNCj4gb2YgbW9kdWxl
IGJiLg0KPiANCj4gUmVnYXJkcywNCj4gS2FpDQo+IA0KDQpOZXZlciBtaW5kLiBJIHRoaW5rIHRo
ZSBydWxlIGlzIHlvdSBzaG91bGQgaW1wb3J0IGluIHRoZSBmaWxlIHdoZXJlIHlvdSB1c2UuDQpU
aGVyZSBpcyBubyBhc3N1bXB0aW9uIHRoYXQgb3RoZXJzIGhlbHAgdG8gaW1wb3J0Lg0KDQpEaXR0
byBpbiBDIGxhbmd1YWdlIGZvciBpbmNsdWRpbmcgaGVhZGVyIGZpbGVzLg0KDQotLQ0KU2hhbmUN
Cg==


