Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S0ldJ-0002oH-1D
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 04:15:45 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Feb 2012 19:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120771755"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2012 19:07:19 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 24 Feb 2012 11:06:53 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 24 Feb 2012 11:06:25 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1] Add new option --environment-more
Thread-Index: AQHM8gglUslH3R4QLU+8kKDrRrpcyJZKDKAAgAFQtnA=
Date: Fri, 24 Feb 2012 03:06:25 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FCEBF17@SHSMSX102.ccr.corp.intel.com>
References: <cover.1329986451.git.lianhao.lu@intel.com>
	<1330009022.32110.61.camel@ted>
In-Reply-To: <1330009022.32110.61.camel@ted>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] Add new option --environment-more
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
X-List-Received-Date: Fri, 24 Feb 2012 03:15:45 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UmljaGFyZCBQdXJkaWUgd3JvdGUgb24gMjAxMi0wMi0yMzoNCj4gT24gVGh1LCAyMDEyLTAyLTIz
IGF0IDE2OjQ5ICswODAwLCBMaWFuaGFvIEx1IHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBhZGRzIGEg
bmV3IG9wdGlvbiAtLWVudmlyb25tZW50LW1vcmUgdG8gYml0YmFrZSB0byBkaXNwbGF5DQo+PiBh
ZGRpdGlvbmFsIGZpbGUgZGVwZW5kZW5jeSBpbmZvcm1hdGlvbi4gVGhpcyBraW5kIG9mIGluZm9y
bWF0aW9uIGNhbiBiZSB1c2VkDQo+PiBieSBvdGhlciByZWNpcGUgZWRpdG9ycywgZS5nLiB0aGUg
RWNsaXBzZSBiaXRiYWtlIGNvbW1hbmRlciBwbHVnaW4sIHRvIGRlY2lkZQ0KPj4gd2hlbiB0byBy
ZXBhcnNlIHRoZSByZWNpcGVzLg0KPj4gDQo+PiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IGQ4YjM3MTgzMDNjM2Q1NjM5NGM3MjIwNTlmMWE3M2JkNzkxMzFkMGE6DQo+PiAgIFpo
YWkgRWR3aW4gKDEpOg0KPj4gICAgICAgICB0ZXhpMmh0bWw6IEZpeCBmb3IgbXVsdGlsaWINCj4+
IGFyZSBhdmFpbGFibGUgaW4gdGhlIGdpdCByZXBvc2l0b3J5IGF0Og0KPj4gDQo+PiAgIGdpdDov
L2dpdC5wb2t5bGludXgub3JnL3Bva3ktY29udHJpYiBsbHUvYml0YmFrZV9zaG93bW9yZQ0KPj4g
ICBodHRwOi8vZ2l0LnBva3lsaW51eC5vcmcvY2dpdC5jZ2kvcG9reS1jb250cmliL2xvZy8/aD1s
bHUvYml0YmFrZV9zaG93bW9yZQ0KPj4gTGlhbmhhbyBMdSAoMSk6DQo+PiAgIGJpdGJha2U6IEFk
ZCBuZXcgb3RwaW9uIC0tZW52aXJvbm1lbnQtbW9yZQ0KPiANCj4gUmF0aGVyIHRoYW4gYWRkIGEg
bmV3IG9wdGlvbiBzcGVjaWZpY2FsbHkgZm9yIHRoaXMsIEknbSB0ZW1wdGVkIGp1c3QgdG8NCj4g
YWRkIHRoZSB2YXJpYWJsZXMgdG8gdGhlIC1lIG91dHB1dC4uLg0KPiANCj4gVGhlIHRyb3VibGUg
aXMgdGhhdCB2YXJpYWJsZXMgc3RhcnRpbmcgIl9fIiBhcmUgY29uc2lkZXJlZCBpbnRlcm5hbCB1
c2UNCj4gYnkgYml0YmFrZS4gV291bGQgaXQgd29yayBpZiB3ZSBtZXJnZSBfX2Jhc2VfZGVwZW5k
cyBhbmQgX19kZXBlbmRzIGFuZA0KPiBwcmludCB0aGlzIGFzIHNvbWUgc3BlY2lmaWMgdmFyaWFi
bGUgbGlrZSBCQklOQ0xVREVTID8gSSBjYW4gaW1hZ2luZQ0KPiB0aGF0IGJlaW5nIHVzZWZ1bCBl
bHNld2hlcmUgdG9vIGFuZCB3ZSBkb24ndCBleHBvc2UgdGhlIGludGVybmFsIHNwbGl0DQo+IG9m
IHRoZSB2YXJpYWJsZSB0aGF0IHdheS4uLg0KPiANCg0KSSBhZGRlZCBhIG5ldyB2YXJpYWJsZSBC
QklOQ0xVREVTIGluIHRoZSBvZS1jb3JlIG1ldGEgbGF5ZXIuIFBsZWFzZSBpZ25vcmUgdGhpcyBv
bmUgDQphbmQgc2VlIHRoZSBwYXRjaCBpbiBvZS1jb3JlIG1haWxpbmcgbGlzdCBpbnN0ZWFkLiAN
Cg0KQmVzdCBSZWdhcmRzLA0KTGlhbmhhbw0KDQoNCg==


