Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDVCc-0004Wz-2L
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 08:20:50 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Mar 2012 23:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83399331"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Mar 2012 23:11:43 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 29 Mar 2012 23:11:43 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 30 Mar 2012 14:11:25 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 5/8] runqueue.py: check results[0] in
	keys of build_pids before being used to avoid exceptions
Thread-Index: AQHNDeciyuC+v2+TYE6gxJpW5XqPfpaCWchQgAACEpA=
Date: Fri, 30 Mar 2012 06:11:24 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFEFE9@SHSMSX102.ccr.corp.intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
	<b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
	<1333051449.18082.10.camel@ted> 
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
X-List-Received-Date: Fri, 30 Mar 2012 06:20:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QnkgdGhlIHdheSwgSSBoYXZlIG5ldmVyIG1ldCB0aGUgZXhjZXB0aW9uIHdoZW4gSSBkbyAibm9y
bWFsbHkgc3RvcCIgdGhlIGJpdGJha2UuDQoNCi0tDQpTaGFuZQ0KDQpXYW5nLCBTaGFuZSB3cm90
ZSBvbsKgMjAxMi0wMy0zMDoNCg0KPiBSaWNoYXJkIFB1cmRpZSB3cm90ZSBvbsKgMjAxMi0wMy0z
MDoNCj4gDQo+PiBPbiBUaHUsIDIwMTItMDMtMjkgYXQgMjA6NTQgKzA4MDAsIFNoYW5lIFdhbmcg
d3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gbmUud2FuZ0BpbnRlbC5jb20+DQo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFRvOg0KPj4+IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVt
YmVkZGVkLm9yZw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgU3ViamVjdDoNCj4+PiBb
Yml0YmFrZS1kZXZlbF0gW1BBVENIIDUvOF0NCj4+PiBydW5xdWV1ZS5weTogY2hlY2sgcmVzdWx0
c1swXSBpbg0KPj4+IGtleXMgb2YgYnVpbGRfcGlkcyBiZWZvcmUgYmVpbmcNCj4+PiB1c2VkIHRv
IGF2b2lkIGV4Y2VwdGlvbnMNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERhdGU6
DQo+Pj4gVGh1LCAyOSBNYXIgMjAxMiAyMDo1NDo1NCArMDgwMA0KPj4+ICgyOS8wMy8xMiAxMzo1
NDo1NCkNCj4+PiANCj4+PiANCj4+PiBbWW9jdG8gIzIxODZdDQo+Pj4gDQo+Pj4gU2lnbmVkLW9m
Zi1ieTogU2hhbmUgV2FuZyA8c2hhbmUud2FuZ0BpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGJp
dGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5IHwgICAyMCArKysrKysrKysrKystLS0tLS0tLQ0KPj4+
ICAxIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+PiAN
Cj4+IFRoaXMga2luZCBvZiBjaGFuZ2Ugc2V0cyBvZmYgYWxhcm0gYmVsbHMuIFRoZSBiaWcgcXVl
c3Rpb24gaXMgd2h5IGFyZQ0KPj4geW91IHNlZWluZyBleGNlcHRpb25zPyBJIHN1c3BlY3QgeW91
J3JlIGZvcmtpbmcgb2ZmIHByb2Nlc3NlcyB3aXRoaW4gaG9iDQo+PiB3aGljaCBhcmUgdGhlbiBj
b25mdXNpbmcgdGhlIHdhaXRwaWQgY29kZS4gSSdkIGhhdmUgdG8gYXNrIHdoeSB0aGUgVUkgaXMN
Cj4+IGZvcmtpbmcgcHJvY2Vzc2VzIHdoZW4gYSBidWlsZCBpcyBydW5uaW5nIGFuZCB3aHkgd2Un
cmUgc3VkZGVubHkgc3RhcnRlZA0KPj4gc2VlaW5nIHRoaXMuLi4NCj4gVGhlIHN0ZXBzIEkgZGlk
IGlzIHRvICJGb3JjZSBzdG9wIiBhIGJ1aWxkIGFuZCBjbGljayAiYnVpbGQgcGFja2FnZXMiIHRv
IHJlYnVpbGQuDQo+IFRoZW4gSSBzYXcgdGhlIGV4Y2VwdGlvbnMuDQo+IEluIHRoZSBjb21tYW5k
IG1vZGUsIHRoZXJlIGlzIG5vIGlzc3VlIGJlY2F1c2UgdGhlIHByb2Nlc3MgZXhpdHMuDQo+IA0K
PiBJbiBmaW5pc2hfbm93KCkgaW4gcnVucXVldWUucHksIG9zLmtpbGwoKSBraWxscyBhbGwgc3Vi
LXByb2Nlc3NlcyBidXQNCj4gdGhleSBkb24ndCBleGl0LiB3aGVuIEkgc3RhcnQgYSBuZXcgYnVp
bGQsIHNlbGYuYnVpbGRfcGlkcyBpcyBlbXB0eSwgYnV0DQo+IGR1ZSB0byB0aGUgYWJvdmUgcmVh
c29uLCBvcy53YWl0cGlkIHN0aWxsIGNhbiBnZXQgdGhlIHZhbHVlIG9mIHBpZHMuDQo+IA0KPiAN
Cj4+IA0KPj4gU28gY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB0aGUgcHJvYmxlbSBmdXJ0aGVyIHNv
IHdlIGNhbiBmaXggdGhlIHJlYWwNCj4+IHByb2JsZW0/IEkgZGlkIGxvb2sgYXQgIzIxODYgYnV0
IHRoYXQgZG9lc24ndCBoZWxwIG1lIGVpdGhlciA6KA0KPiBPSywgSSBhbSBnb2luZyB0byBzdWJt
aXQgYW5vdGhlciBwYXRjaCwgYnV0IEkgdGhpbmsgdGhlIGNvbmRpdGlvbiBjaGVjaw0KPiBpcyBh
bHNvIG5lZWRlZC4gT3RoZXJ3aXNlLCBpbiB0aGUgY3VycmVudCBjb2RlIG9mDQo+IHJ1bnF1ZXVl
X3Byb2Nlc3Nfd2FpdHBpZCgpLCB3aHkgZG8gd2UgaGF2ZToNCj4gICAgICAgICBpZiByZXN1bHRb
MF0gaW4gc2VsZi5idWlsZF9zdGFtcHMua2V5cygpOg0KPiAgICAgICAgICAgICBkZWwgc2VsZi5i
dWlsZF9zdGFtcHNbcmVzdWx0WzBdXQ0KPiANCj4+IA0KPj4gQ2hlZXJzLA0KPj4gDQo+PiBSaWNo
YXJkDQo+DQoNCg0K


