Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SChU9-0004Lm-4A
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 03:15:37 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2012 18:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124064082"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 27 Mar 2012 18:06:34 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 27 Mar 2012 18:06:34 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Wed, 28 Mar 2012 09:06:32 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 0/4] More Hob tweaks
Thread-Index: AQHNDEljeOM9MZHb50a7YExsTUFVIpZ+5T6A
Date: Wed, 28 Mar 2012 01:06:31 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFC100@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AFB733@SHSMSX102.ccr.corp.intel.com>
	<4F720A1D.5080006@linux.intel.com>
In-Reply-To: <4F720A1D.5080006@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/4] More Hob tweaks
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
X-List-Received-Date: Wed, 28 Mar 2012 01:15:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Sm9zaHVhIExvY2sgd3JvdGUgb27CoDIwMTItMDMtMjg6DQoNCj4gT24gMjcvMDMvMTIgMDc6MTQs
IFdhbmcsIFNoYW5lIHdyb3RlOg0KPj4gQUNLLg0KPj4gDQo+PiBCdXQgSSBhbHNvIHBlcnNpc3Qg
aW4gbXkgb3BpbmlvbiBmb3IgdGhlIGZpeCB0aGF0IHRoZXJlIHdvdWxkIGJlIG9ubHkgb25lDQo+
IGJ1dHRvbiAiQ2xvc2UiIGZvciBsYXllciBkaWFsb2c7LSkNCj4gDQo+IFlvdSBtZWFuIHRoZSB1
c2luZyBDYW5jZWwvU2F2ZSBvbiB0aGUgbGF5ZXIgZGlhbG9ndWU/IEl0IHNlZW1zIHRoZXJlJ3Mg
YQ0KPiBjb25zZW5zdXMgZm9yIHRoYXQgYXBwcm9hY2ggYW5kIEknbSBwbGFubmluZyBvbiBzdWJt
aXR0aW5nIGEgZm9sbG93IG9uLg0KWWVzLiBUaGFuayB5b3UgZm9yIGV4cGxhbmF0aW9ucy4gVGhh
dCBpcyBPSyB3aXRoIG1lLg0KDQo+IA0KPiBJJ20gaG9waW5nIHRvIG9ubHkgc3VibWl0IHNtYWxs
IHBhdGNoZXMgd2l0aCBtaW5vciB0d2Vha3Mgbm93IHRoYXQgd2UncmUNCj4gaW4gdGhlIHN0YWJp
bGlzYXRpb24gcGhhc2UgYW5kIHRoZSBkaWFsb2d1ZSBidXR0b25zIHBhdGNoIHdhcyBnZXR0aW5n
DQo+IGxhcmdlIGVub3VnaCB0aGF0IEkgd291bGQgbGlrZSB0byBzZWUgaXQgbWVyZ2VkIGFzYXAg
YW5kIG5vdCBoYXZlIHRvDQo+IGNodXJuIG9uIGl0IGFueSBtb3JlLg0KPiANCj4gVGhhbmtzIGZv
ciB0aGUgYWNrLCBleHBlY3QgbW9yZSBwYXRjaGVzIGluIGEgZmV3IGhvdXJzLg0KPiANCj4gQ2hl
ZXJzLA0KPiBKb3NodWENCg0KLS0NClNoYW5lDQo=


