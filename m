Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3HPu-0000vL-Ko
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 02:36:18 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Mar 2012 17:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116763639"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by orsmga002.jf.intel.com with ESMTP; 01 Mar 2012 17:26:40 -0800
Received: from pgsmsx151.gar.corp.intel.com (172.30.236.41) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 09:24:11 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX151.gar.corp.intel.com (172.30.236.41) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 09:24:10 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 09:23:51 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Joshua Lock
	<josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 00/32] Hob related fixes
Thread-Index: AQHM98EXZ4A4x4BI3E6ONxntEbkMapZWMl/A
Date: Fri, 2 Mar 2012 01:23:51 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADF616@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
	<1330616130.31767.21.camel@ted>
In-Reply-To: <1330616130.31767.21.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Fri, 02 Mar 2012 01:36:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Sm9zaCwgSSBhbSBzb3JyeSBmb3IgbWlzc2luZyB0byBhZGQgRnJvbTogWFhYPHh4eD4gaW4geW91
ciBzaXggcGF0Y2hlcy4NCkkgb3JpZ2luYWxseSB0aGluayAiU2lnbmVkLW9mZi1ieTogSm9zaCIg
aXMgZW5vdWdoLg0KDQpCZWNhdXNlIEkgaGF2ZSBzb21lIGNsZWFudXBzIHRvIHJlbW92ZSBjbGFz
cyBtZXRob2RzIGZvciBIb2JXaWRnZXQgZm9yIGNsZWFuIE9iamVjdCBPcmllbnRlZCBkZXNpZ24s
IHdoaWNoIGNoYW5nZWQgdGhlIGNvZGUgYSBsb3QuDQpTbywgc29tZSBvZiBteSBwYXRjaGVzIGp1
bXBlZCB0aGUgcXVldWUgdG8gc2F2ZSBtZXJnaW5nIGFuZCByZWJhc2luZyBlZmZvcnRzLg0KDQpT
b3JyeSBmb3IgdGhhdC4NCi0tDQpTaGFuZQ0KDQpSaWNoYXJkIFB1cmRpZSB3cm90ZSBvbsKgMjAx
Mi0wMy0wMToNCj4gDQo+IEkgYWxzbyBqdXN0IHJlYWxpc2VkIHNvbWUgb2YgdGhlc2UgcGF0Y2hl
cyB3ZXJlIGF1dGhvcmVkIGJ5IEpvc2h1YS4NCj4gUGxlYXNlIGVuc3VyZSB0aGVyZSBpcyBhOg0K
PiANCj4gRnJvbTogWFhYIDx4eHg+DQo+IA0KPiBhdCB0aGUgaGVhZCBvZiBzdWNoIHBhdGNoZXMg
c28gdGhlIGF1dGhvciBpbmZvcm1hdGlvbiBnZXRzIGNvcnJlY3RseQ0KPiByZWNvcmRlZC4gVW5m
b3J0dW5hdGVseSBJIHJlYWxpc2VkIHRvIGxhdGUgd2l0aCB0aGlzIHB1c2ggdG8gYmUgYWJsZSB0
bw0KPiBjb3JyZWN0IGl0IDooDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCg0K


