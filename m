Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SboXU-00042u-Qi
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 09:50:53 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 05 Jun 2012 00:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151694437"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 05 Jun 2012 00:40:26 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 5 Jun 2012 00:40:26 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.56]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.93]) with mapi id
	14.01.0355.002; Tue, 5 Jun 2012 15:40:18 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Kang Kai <Kai.Kang@windriver.com>
Thread-Topic: [PATCH 2/2] hob2: create a standalone deploy image tool
Thread-Index: AQHNQultyYp1nIpdfkaYoeuT+1rQ+JbrVnAw
Date: Tue, 5 Jun 2012 07:40:18 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BCA684@SHSMSX102.ccr.corp.intel.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
	<4FCDAF89.8000803@windriver.com>
In-Reply-To: <4FCDAF89.8000803@windriver.com>
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
X-List-Received-Date: Tue, 05 Jun 2012 07:50:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpLYW5nIEthaSB3cm90ZSBvbsKgMjAxMi0wNi0wNToNCg0KPiBPbiAyMDEy5bm0MDbmnIgwNeaX
pSAxNDo0MiwgV2FuZywgU2hhbmUgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBLYW5nIEthaSBbbWFpbHRvOmthaS5rYW5nQHdpbmRyaXZlci5jb21dDQo+
Pj4gU2VudDogVHVlc2RheSwgSnVuZSAwNSwgMjAxMiAxMTozNyBBTQ0KPj4+IFRvOiBkdmhhcnRA
bGludXguaW50ZWwuY29tDQo+Pj4gQ2M6IFdhbmcsIFNoYW5lOyB6aGVuZmVuZy56aGFvQHdpbmRy
aXZlci5jb207DQo+Pj4gYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+Pj4g
U3ViamVjdDogW1BBVENIIDIvMl0gaG9iMjogY3JlYXRlIGEgc3RhbmRhbG9uZSBkZXBsb3kgaW1h
Z2UgdG9vbA0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9iaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMv
dXRpbHMucHkNCj4+PiBiL2JpdGJha2UvbGliL2JiL3VpL2NydW1icy91dGlscy5weQ0KPj4+IGlu
ZGV4IGNkMDFhMDQuLjkzOTg2NGYgMTAwNjQ0DQo+Pj4gLS0tIGEvYml0YmFrZS9saWIvYmIvdWkv
Y3J1bWJzL3V0aWxzLnB5DQo+Pj4gKysrIGIvYml0YmFrZS9saWIvYmIvdWkvY3J1bWJzL3V0aWxz
LnB5DQo+Pj4gQEAgLTIyLDYgKzIyLDcgQEANCj4+PiAgICMgYml0YmFrZSB3aGljaCB3aWxsIGFs
bG93IG1vcmUgZmxleGliaWxpdHkuDQo+Pj4gICANCj4+PiAgIGltcG9ydCBvcw0KPj4+ICtpbXBv
cnQgYmINCj4+IFdoeSBpcyB0aGlzIG5lZWRlZD8gSSBkb24ndCBzZWUgYW55IGNoYW5nZSB5b3Ug
bWFkZSBpbiB1dGlscy5weS4NCj4+IElzIHRoYXQgdG8gc2F5IHdpdGhvdXQgdGhpcyBsaW5lLCB0
aGUgZnVuY3Rpb25zIGluIHV0aWxzLnB5IGRvbid0IHdvcms/DQo+IA0KPiBXaXRob3V0IHRoZSBp
bXBvcnQsIGl0IGp1c3QgY29tcGxhaW5zIHRoYXQNCj4gDQo+IE5hbWVFcnJvcjogZ2xvYmFsIG5h
bWUgJ2JiJyBpcyBub3QgZGVmaW5lZA0KPiANCj4gUmVnYXJkcywNCj4gS2FpDQoNCk9LLCBJdCBz
ZWVtcyBTYXVsIGRpZG4ndCB0ZXN0IGl0IHdoZW4gaGUgY3JlYXRlZCB1dGlscy5weTstKQ0KDQot
LQ0KU2hhbmUNCg==


