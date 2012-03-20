Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S9zWA-0008B8-FQ
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 14:54:30 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 06:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="79584023"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Mar 2012 06:44:36 -0700
Received: from azsmsx604.amr.corp.intel.com (10.2.161.34) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 06:44:35 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx604.amr.corp.intel.com (10.2.161.34) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 06:44:36 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 20 Mar 2012 21:44:34 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 02/12] Hob: use HobNotebook to
	implement a notebook in build details page
Thread-Index: AQHNBir3u8y5qha/XESlHAi9eK2hx5ZzMbdw
Date: Tue, 20 Mar 2012 13:44:33 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF259F@SHSMSX102.ccr.corp.intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<8565670d713978a93a57a96c55b4815a144af3e5.1331910234.git.shane.wang@intel.com>
	<4F67C607.50806@linux.intel.com>
In-Reply-To: <4F67C607.50806@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 02/12] Hob: use HobNotebook to implement a notebook in build details page
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
X-List-Received-Date: Tue, 20 Mar 2012 13:54:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Sm9zaHVhIExvY2sgd3JvdGUgb27CoDIwMTItMDMtMjA6DQoNCj4gT24gMTYvMDMvMTIgMDg6MTAs
IFNoYW5lIFdhbmcgd3JvdGU6DQo+PiAgIGNsYXNzIFJ1bm5pbmdCdWlsZE1vZGVsIChndGsuVHJl
ZVN0b3JlKToNCj4+IEBAIC00MCw2ICs0MSwzMiBAQCBjbGFzcyBSdW5uaW5nQnVpbGRNb2RlbCAo
Z3RrLlRyZWVTdG9yZSk6DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ29i
amVjdC5UWVBFX1NUUklORywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
b2JqZWN0LlRZUEVfSU5UKQ0KPj4gKyAgICBkZWYgY29uZmlnX21vZGVsX2ZpbHRlcihzZWxmLCBt
b2RlbCwgaXQpOg0KPj4gKyAgICAgICAgbXNnID0gbW9kZWwuZ2V0KGl0LCBzZWxmLkNPTF9NRVNT
QUdFKVswXQ0KPj4gKyAgICAgICAgaWYgbXNnID09IE5vbmUgb3IgdHlwZShtc2cpICE9IHN0cjoN
Cj4+ICsgICAgICAgICAgICByZXR1cm4gRmFsc2UNCj4+ICsgICAgICAgIGlmIG1zZy5zdGFydHN3
aXRoKCJcbk9FIEJ1aWxkIENvbmZpZ3VyYXRpb246XG4iKToNCj4+ICsgICAgICAgICAgICByZXR1
cm4gVHJ1ZQ0KPj4gKyAgICAgICAgcmV0dXJuIEZhbHNlDQo+IA0KPiBJIHRoaW5rIEkgY29tbWVu
dGVkIG9uIHRoaXMgYmVmb3JlLCB0aGlzIHNlZW1zIGxpa2UgYSBoZWF2eSB3YXkgdG8NCj4gYWNo
aWV2ZSB0aGlzIGZ1bmN0aW9uYWxpdHkuIElzIHRoZXJlIG5vdCBhbm90aGVyIHdheSB3ZSBjYW4g
ZGlzcGxheSB0aGUNCj4gQnVpbGQgQ29uZmlndXJhdGlvbiB0byB0aGUgdXNlciB3aXRob3V0IGhh
dmluZyB0byBmaWx0ZXIgZXZlcnkgbWVzc2FnZQ0KPiBlbWl0dGVkPw0KSSBhbSBnb2luZyB0byBz
dWJtaXQgYSBidWcgaW4gYnVnemlsbGEgdG8gYWRkcmVzcyBpdCBsYXRlciwgc2luY2UgdGhlIHNl
cmllcyBvZiBwYXRjaGVzIGJsb2NrIGEgbG90IG9mIHBhdGNoIHN1Ym1pc3Npb25zLg0KDQo+IA0K
PiBGdXJ0aGVyLCBpZiB3ZSdyZSBnb2luZyB0byBkaXNwbGF5IHRoaXMgaW5mb3JtYXRpb24gaW4g
YSBzZXBhcmF0ZSBwYWdlDQo+IG9mIHRoZSBub3RlYm9vayB3b3VsZCBpdCBub3QgbWFrZSBzZW5z
ZSB0byBub3Qgc2hvdyBpdCBpbiB0aGUgYnVpbGQgbG9nDQo+IHBhZ2U/DQpPSywgaWYgeW91IHdh
bnQgSSBjYW4gcmVtb3ZlIGl0LiBCdXQgSSBzdWdnZXN0IHRvIGtlZXAgaXQgYmVjYXVzZSBvZiB5
b3VyIGFib3ZlIGNvbW1lbnQuDQpUaGF0IGlzIHRoZSBjb25maWd1cmF0aW9uIGluZm9ybWF0aW9u
IGluIENvbmZpZ3VyYXRpb24gVGFiIGNvbWVzIGZyb20gZGlmZmVyZW50IHNvdXJjZXMuDQoNCi0t
DQpTaGFuZQ0KDQo+IA0KPiBDaGVlcnMsDQo+IEpvc2h1YQ0KDQoNCg==


