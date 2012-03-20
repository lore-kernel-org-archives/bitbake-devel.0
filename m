Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA0Jg-0002sX-7w
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:45:40 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 07:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121102229"
Received: from azsmsx603.amr.corp.intel.com ([10.2.161.23])
	by azsmga001.ch.intel.com with ESMTP; 20 Mar 2012 07:34:39 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx603.amr.corp.intel.com (10.2.161.23) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 07:34:39 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 20 Mar 2012 22:34:38 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 00/11] [V4]Hob Notebook Implementation
	and Others
Thread-Index: AQHNBqY0CZg9K6lgEE+DODGOtCt34JZzP8wg
Date: Tue, 20 Mar 2012 14:34:38 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF2706@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
	<1332253885.9740.91.camel@ted>
In-Reply-To: <1332253885.9740.91.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/11] [V4]Hob Notebook Implementation and Others
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
X-List-Received-Date: Tue, 20 Mar 2012 14:45:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U2VlIHRoZW0uIFRoYW5rcy4NCg0KLS0NClNoYW5lDQoNClJpY2hhcmQgUHVyZGllIHdyb3RlIG9u
wqAyMDEyLTAzLTIwOg0KDQo+IE9uIFR1ZSwgMjAxMi0wMy0yMCBhdCAyMjo0MCArMDgwMCwgU2hh
bmUgV2FuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2hzZXQgaXMNCj4+ICAtIHRvIGltcGxlbWVudCBI
b2Igc2VsZi1kZWZpbmVkIG5vdGVib29rLCBhbmQgdXNlIGl0IGluIHRoZSBidWlsZA0KPj4gIGRl
dGFpbHMgcGFnZS4gLSB0byBjbGVhbiB1cCB0aGUgY29kZSBwZXIgdGhlIGNvbW1lbnRzIGZyb20g
dGhlDQo+PiAgY29tbXVuaXR5Lg0KPj4gICAgKEluIG9yZGVyIHRvIG1ha2UgaXQgcmVhZGFibGUs
IHdlIGRpZCB0aGVtIGluIHNlcGFyYXRlIHBhdGNoZXMpDQo+PiBDb21wYXJlZCB3aXRoIFYzIHZl
cnNpb24sIHRoaXMgdmVyc2lvbiB0ZW1wb3JhcmlseSByZW1vdmVkIHRoZSBwYXRjaGVzDQo+IGZv
cg0KPj4gIC0gdG8gaW1wcm92ZSB0aGUgYnVpbGQgbG9nIHdpdGggdGhlIGFuaW1hdGlvbiBvZiB0
aGUgcmVmcmVzaCBpY29uLg0KPj4gIC0gdG8gYWRkIHByb3h5IHN1cHBvcnQgaW4gdGhlIFNldHRp
bmdzIGRpYWxvZy4NCj4+IEJlY2F1c2UgdGhlIHVwZGF0ZWQgcGF0Y2hlcyBhcmUgbm90IHJlYWR5
IHNvIGZhciBwZXIgdGhlIGNvbW1lbnRzIGZyb20NCj4gdGhlIGNvbW11bml0eS4NCj4gDQo+IE1l
cmdlZCB0byBtYXN0ZXIsIHRoYW5rcyENCj4gDQo+IFJpY2hhcmQNCg0KDQo=


