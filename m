Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDVBG-0004Vd-N3
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 08:19:26 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Mar 2012 23:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83398915"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Mar 2012 23:10:13 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 29 Mar 2012 23:10:13 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 30 Mar 2012 14:10:07 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 5/8] runqueue.py: check results[0] in
	keys of build_pids before being used to avoid exceptions
Thread-Index: AQHNDeciyuC+v2+TYE6gxJpW5XqPfpaCWchQ
Date: Fri, 30 Mar 2012 06:10:07 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFEFBD@SHSMSX102.ccr.corp.intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
	<b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
	<1333051449.18082.10.camel@ted>
In-Reply-To: <1333051449.18082.10.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 5/8] runqueue.py: check results[0] in keys of build_pids before being used to avoid exceptions
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
X-List-Received-Date: Fri, 30 Mar 2012 06:19:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UmljaGFyZCBQdXJkaWUgd3JvdGUgb27CoDIwMTItMDMtMzA6DQoNCj4gT24gVGh1LCAyMDEyLTAz
LTI5IGF0IDIwOjU0ICswODAwLCBTaGFuZSBXYW5nIHdyb3RlOg0KPj4gDQo+PiANCj4+IG5lLndh
bmdAaW50ZWwuY29tPg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRvOg0KPj4g
Yml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFN1YmplY3Q6DQo+PiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDUvOF0NCj4+IHJ1
bnF1ZXVlLnB5OiBjaGVjayByZXN1bHRzWzBdIGluDQo+PiBrZXlzIG9mIGJ1aWxkX3BpZHMgYmVm
b3JlIGJlaW5nDQo+PiB1c2VkIHRvIGF2b2lkIGV4Y2VwdGlvbnMNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRGF0ZToNCj4+IFRodSwgMjkgTWFyIDIwMTIgMjA6NTQ6NTQgKzA4MDAN
Cj4+ICgyOS8wMy8xMiAxMzo1NDo1NCkNCj4+IA0KPj4gDQo+PiBbWW9jdG8gIzIxODZdDQo+PiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYW5lIFdhbmcgPHNoYW5lLndhbmdAaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiAgYml0YmFrZS9saWIvYmIvcnVucXVldWUucHkgfCAgIDIwICsrKysrKysrKysrKy0t
LS0tLS0tDQo+PiAgMSBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiANCj4gVGhpcyBraW5kIG9mIGNoYW5nZSBzZXRzIG9mZiBhbGFybSBiZWxscy4gVGhl
IGJpZyBxdWVzdGlvbiBpcyB3aHkgYXJlDQo+IHlvdSBzZWVpbmcgZXhjZXB0aW9ucz8gSSBzdXNw
ZWN0IHlvdSdyZSBmb3JraW5nIG9mZiBwcm9jZXNzZXMgd2l0aGluIGhvYg0KPiB3aGljaCBhcmUg
dGhlbiBjb25mdXNpbmcgdGhlIHdhaXRwaWQgY29kZS4gSSdkIGhhdmUgdG8gYXNrIHdoeSB0aGUg
VUkgaXMNCj4gZm9ya2luZyBwcm9jZXNzZXMgd2hlbiBhIGJ1aWxkIGlzIHJ1bm5pbmcgYW5kIHdo
eSB3ZSdyZSBzdWRkZW5seSBzdGFydGVkDQo+IHNlZWluZyB0aGlzLi4uDQpUaGUgc3RlcHMgSSBk
aWQgaXMgdG8gIkZvcmNlIHN0b3AiIGEgYnVpbGQgYW5kIGNsaWNrICJidWlsZCBwYWNrYWdlcyIg
dG8gcmVidWlsZC4gVGhlbiBJIHNhdyB0aGUgZXhjZXB0aW9ucy4NCkluIHRoZSBjb21tYW5kIG1v
ZGUsIHRoZXJlIGlzIG5vIGlzc3VlIGJlY2F1c2UgdGhlIHByb2Nlc3MgZXhpdHMuDQoNCkluIGZp
bmlzaF9ub3coKSBpbiBydW5xdWV1ZS5weSwgb3Mua2lsbCgpIGtpbGxzIGFsbCBzdWItcHJvY2Vz
c2VzIGJ1dCB0aGV5IGRvbid0IGV4aXQuDQp3aGVuIEkgc3RhcnQgYSBuZXcgYnVpbGQsIHNlbGYu
YnVpbGRfcGlkcyBpcyBlbXB0eSwgYnV0IGR1ZSB0byB0aGUgYWJvdmUgcmVhc29uLCBvcy53YWl0
cGlkIHN0aWxsIGNhbiBnZXQgdGhlIHZhbHVlIG9mIHBpZHMuDQoNCg0KPiANCj4gU28gY2FuIHlv
dSBwbGVhc2UgZXhwbGFpbiB0aGUgcHJvYmxlbSBmdXJ0aGVyIHNvIHdlIGNhbiBmaXggdGhlIHJl
YWwNCj4gcHJvYmxlbT8gSSBkaWQgbG9vayBhdCAjMjE4NiBidXQgdGhhdCBkb2Vzbid0IGhlbHAg
bWUgZWl0aGVyIDooDQpPSywgSSBhbSBnb2luZyB0byBzdWJtaXQgYW5vdGhlciBwYXRjaCwgYnV0
IEkgdGhpbmsgdGhlIGNvbmRpdGlvbiBjaGVjayBpcyBhbHNvIG5lZWRlZC4NCk90aGVyd2lzZSwg
aW4gdGhlIGN1cnJlbnQgY29kZSBvZiBydW5xdWV1ZV9wcm9jZXNzX3dhaXRwaWQoKSwgd2h5IGRv
IHdlIGhhdmU6DQogICAgICAgIGlmIHJlc3VsdFswXSBpbiBzZWxmLmJ1aWxkX3N0YW1wcy5rZXlz
KCk6DQogICAgICAgICAgICBkZWwgc2VsZi5idWlsZF9zdGFtcHNbcmVzdWx0WzBdXQ0KDQoNCj4g
DQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0KLS0NClNoYW5lDQo=


