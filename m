Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1RtB3Q-0006zu-2g
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Feb 2012 05:47:20 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 02 Feb 2012 20:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="102745728"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by azsmga001.ch.intel.com with ESMTP; 02 Feb 2012 20:38:15 -0800
Received: from pgsmsx103.gar.corp.intel.com (10.221.44.82) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 3 Feb 2012 12:38:13 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX103.gar.corp.intel.com (10.221.44.82) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 3 Feb 2012 12:38:13 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 3 Feb 2012 12:38:11 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] [V2] bitbake: add description
	cache into cache_extra
Thread-Index: AQHM4b9I3dxGL92ZZ0S/xEwYYMV1i5Yql65g
Date: Fri, 3 Feb 2012 04:38:10 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC0FCEBE29@SHSMSX102.ccr.corp.intel.com>
References: <cover.1328162622.git.shane.wang@intel.com>
	<213886d7dc877c93686c896fe4584011bb4ce2ec.1328162622.git.shane.wang@intel.com>
	<1328196487.13744.193.camel@ted>
In-Reply-To: <1328196487.13744.193.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] [V2] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Fri, 03 Feb 2012 04:47:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T0ssIHRoYW5rcy4gU29ycnkgZm9yIHRoYXQsIHdpbGwga2VlcCBpbiBtaW5kLg0KDQotLQ0KU2hh
bmUNCg0KUmljaGFyZCBQdXJkaWUgd3JvdGUgb27CoDIwMTItMDItMDI6DQoNCj4gT24gVGh1LCAy
MDEyLTAyLTAyIGF0IDE0OjA1ICswODAwLCBTaGFuZSBXYW5nIHdyb3RlOg0KPj4gRW5hYmxlIGJp
dGJha2UgdG8gY2FjaGUgZGVzY3JpcHRpb24gaW50byB0aGUgZXh0cmEgY2FjaGUgZmlsZSBhbmQg
SG9iMg0KPj4gd2lsbCBnZXQgaXRzIHZhbHVlIGZvciBjb3JlLWltYWdlLWZvby4NCj4+IA0KPj4g
U2lnbmVkLW9mZi1ieTogU2hhbmUgV2FuZyA8c2hhbmUud2FuZ0BpbnRlbC5jb20+DQo+PiAtLS0N
Cj4+ICBiaXRiYWtlL2xpYi9iYi9jYWNoZS5weSAgICAgICB8ICAgIDkgLS0tLS0tLS0tDQo+PiAg
Yml0YmFrZS9saWIvYmIvY2FjaGVfZXh0cmEucHkgfCAgICAzICsrKw0KPj4gIGJpdGJha2UvbGli
L2JiL2Nvb2tlci5weSAgICAgIHwgICAgMiArKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gSSd2ZSBtZXJnZWQgdGhpcyBwYXRjaCB0
aGFua3MuDQo+IA0KPiBJbiBmdXR1cmUgcGxlYXNlIHdvcmsgb24gYmV0dGVyIGNvbW1pdCBtZXNz
YWdlcyBzaW5jZSB0aGlzIG9uZSBkb2Vzbid0DQo+IG1lbnRpb24gdGhlIHJlbW92YWwgb2YgdGhl
IGR1cGxpY2F0ZSBjYWNoZSBlbnRyaWVzLiBXaGVuIEkgdG9vayB0aGUNCj4gcGF0Y2ggSSd2ZSB0
d2Vha2VkIHRoZSBjb21taXQgbWVzc2FnZSBpbiB0aGlzIGNhc2UuDQo+IA0KPiBDaGVlcnMsDQo+
IA0KPiBSaWNoYXJkDQoNCg0K


