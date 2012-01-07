Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RjR4x-0005qM-LJ
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Jan 2012 08:52:39 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 06 Jan 2012 23:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="109712962"
Received: from pgsmsx603.gar.corp.intel.com ([10.221.43.87])
	by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2012 23:45:11 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	pgsmsx603.gar.corp.intel.com (10.221.43.87) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sat, 7 Jan 2012 15:45:10 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.199]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.38]) with mapi id
	14.01.0355.002; Sat, 7 Jan 2012 15:45:09 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 12/16] bitbake: add -B option to bind
	with interface
Thread-Index: AQHMzIr+KOfKL1NarE6+xzgH6OvjH5YAhjtw
Date: Sat, 7 Jan 2012 07:45:08 +0000
Message-ID: <40776A41FC278F40B59438AD47D147A9016A42@SHSMSX102.ccr.corp.intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
	<15703ec8d9b0560b0db97069426c1916e3896a63.1325840050.git.dongxiao.xu@intel.com>
	<1325865050.20759.132.camel@ted>
In-Reply-To: <1325865050.20759.132.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 12/16] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Sat, 07 Jan 2012 07:52:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSBbbWFp
bHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IEZyaWRheSwg
SmFudWFyeSAwNiwgMjAxMiAxMTo1MSBQTQ0KPiBUbzogWHUsIERvbmd4aWFvDQo+IENjOiBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVjdDogUmU6IFtiaXRiYWtl
LWRldmVsXSBbUEFUQ0ggMTIvMTZdIGJpdGJha2U6IGFkZCAtQiBvcHRpb24gdG8gYmluZCB3aXRo
DQo+IGludGVyZmFjZQ0KPiANCj4gT24gRnJpLCAyMDEyLTAxLTA2IGF0IDE3OjAyICswODAwLCBE
b25neGlhbyBYdSB3cm90ZToNCj4gPiBXaGVuIHN0YXJ0IGJpdGJha2UgYXMgYSBzZXJ2ZXIgb25s
eSBwcm9jZXNzLCB3ZSBuZWVkIHRvIGFzc2lnbiBjZXJ0YWluDQo+ID4gaW50ZXJmYWNlIHRvIGl0
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3hpYW8gWHUgPGRvbmd4aWFvLnh1QGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiAgYmluL2JpdGJha2UgICAgICAgICAgICAgfCAgIDE3ICsrKysr
KysrKysrKy0tLS0tDQo+ID4gIGxpYi9iYi9zZXJ2ZXIveG1scnBjLnB5IHwgICAgNiArKystLS0N
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Jpbi9iaXRiYWtlIGIvYmluL2JpdGJha2UgaW5kZXggYzJl
NjgyMi4uNGJmMTMzNSAxMDA3NTUNCj4gPiAtLS0gYS9iaW4vYml0YmFrZQ0KPiA+ICsrKyBiL2Jp
bi9iaXRiYWtlDQo+ID4gQEAgLTE2OCw2ICsxNjgsOCBAQCBEZWZhdWx0IEJCRklMRVMgYXJlIHRo
ZSAuYmIgZmlsZXMgaW4gdGhlIGN1cnJlbnQNCj4gZGlyZWN0b3J5LiIiIikNCj4gPiAgICAgIHBh
cnNlci5hZGRfb3B0aW9uKCIiLCAiLS1zZXJ2ZXItb25seSIsIGhlbHAgPSAiUnVuIGJpdGJha2Ug
d2l0aG91dCBVSSwNCj4gdGhlIGZyb250ZW5kIGNhbiBjb25uZWN0IHdpdGggYml0YmFrZSBzZXJ2
ZXIgaXRzZWxmIiwNCj4gPiAgICAgICAgICAgICAgICAgYWN0aW9uID0gInN0b3JlX3RydWUiLCBk
ZXN0ID0gInNlcnZlcl9vbmx5IiwgZGVmYXVsdCA9DQo+ID4gRmFsc2UpDQo+ID4NCj4gPiArICAg
IHBhcnNlci5hZGRfb3B0aW9uKCItQiIsICItLWJpbmQiLCBoZWxwID0gIkJpbmQgYml0YmFrZSBz
ZXJ2ZXINCj4gPiArIHdpdGggY2VydGFpbiBhZGRyZXNzIiwNCj4gDQo+IEkgZmluZCB0aGVzZSBo
ZWxwIG1lc3NhZ2VzIGNvbmZ1c2luZy4gSG93IGFib3V0ICJUaGUgbmFtZS9hZGRyZXNzIGZvciB0
aGUNCj4gYml0YmFrZSBzZXJ2ZXIgdG8gYmluZCB0byI/DQoNClllcywgSSB0aGluayB5b3VyIHN1
Z2dlc3Rpb24gaXMgYmV0dGVyLg0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBhY3Rpb24gPSAi
c3RvcmUiLCBkZXN0ID0gImJpbmQiLCBkZWZhdWx0ID0gRmFsc2UpDQo+ID4gICAgICBvcHRpb25z
LCBhcmdzID0gcGFyc2VyLnBhcnNlX2FyZ3Moc3lzLmFyZ3YpDQo+ID4NCj4gPiAgICAgIGNvbmZp
Z3VyYXRpb24gPSBCQkNvbmZpZ3VyYXRpb24ob3B0aW9ucykgQEAgLTE4OSw5ICsxOTEsNiBAQA0K
PiA+IERlZmF1bHQgQkJGSUxFUyBhcmUgdGhlIC5iYiBmaWxlcyBpbiB0aGUgY3VycmVudCBkaXJl
Y3RvcnkuIiIiKQ0KPiA+ICAgICAgICAgIHN5cy5leGl0KCJGQVRBTDogSW52YWxpZCBzZXJ2ZXIg
dHlwZSAnJXMnIHNwZWNpZmllZC5cbiINCj4gPiAgICAgICAgICAgICAgICAgICAiVmFsaWQgaW50
ZXJmYWNlczogeG1scnBjLCBwcm9jZXNzIFtkZWZhdWx0XSwgbm9uZS4iDQo+ID4gJSBzZXJ2ZXJ0
eXBlKQ0KPiA+DQo+ID4gLSAgICBpZiBjb25maWd1cmF0aW9uLnNlcnZlcl9vbmx5IGFuZCBjb25m
aWd1cmF0aW9uLnNlcnZlcnR5cGUgIT0gInhtbHJwYyI6DQo+ID4gLSAgICAgICAgc3lzLmV4aXQo
IkZBVEFMOiBJZiAnLS1zZXJ2ZXItb25seScgaXMgZGVmaW5lZCwgd2UgbXVzdCBzZXQgdGhlDQo+
IHNlcnZlcnR5cGUgYXMgJ3htbHJwYycuXG4iKQ0KPiA+IC0NCj4gPiAgICAgICMgU2F2ZSBhIGxv
Z2ZpbGUgZm9yIGNvb2tlciBpbnRvIHRoZSBjdXJyZW50IHdvcmtpbmcgZGlyZWN0b3J5LiBXaGVu
IHRoZQ0KPiA+ICAgICAgIyBzZXJ2ZXIgaXMgZGFlbW9uaXplZCB0aGlzIGxvZ2ZpbGUgd2lsbCBi
ZSB0cnVuY2F0ZWQuDQo+ID4gICAgICBjb29rZXJfbG9nZmlsZSA9IG9zLnBhdGguam9pbihvcy5n
ZXRjd2QoKSwgImNvb2tlci5sb2ciKSBAQA0KPiA+IC0yMTEsOSArMjEwLDE3IEBAIERlZmF1bHQg
QkJGSUxFUyBhcmUgdGhlIC5iYiBmaWxlcyBpbiB0aGUgY3VycmVudA0KPiBkaXJlY3RvcnkuIiIi
KQ0KPiA+ICAgICAgIyBvZiB0aGUgVUlzIChlLmcuIGZvciBESVNQTEFZLCBldGMuKQ0KPiA+ICAg
ICAgYmIudXRpbHMuY2xlYW5fZW52aXJvbm1lbnQoKQ0KPiA+DQo+ID4gLSAgICBzZXJ2ZXIgPSBz
ZXJ2ZXIuQml0QmFrZVNlcnZlcigpDQo+ID4gKyAgICBpZiBjb25maWd1cmF0aW9uLnNlcnZlcl9v
bmx5Og0KPiA+ICsgICAgICAgIGlmIGNvbmZpZ3VyYXRpb24uc2VydmVydHlwZSAhPSAieG1scnBj
IjoNCj4gPiArICAgICAgICAgICAgc3lzLmV4aXQoIkZBVEFMOiBJZiAnLS1zZXJ2ZXItb25seScg
aXMgZGVmaW5lZCwgd2UgbXVzdCBzZXQgdGhlDQo+IHNlcnZlcnR5cGUgYXMgJ3htbHJwYycuXG4i
KQ0KPiA+ICsgICAgICAgIGlmIG5vdCBjb25maWd1cmF0aW9uLmJpbmQ6DQo+ID4gKyAgICAgICAg
ICAgIHN5cy5leGl0KCJGQVRBTDogSWYgJy0tc2VydmVyLW9ubHknIGlzIGRlZmluZWQsIHdlIG5l
ZWQNCj4gPiArIHRvIGJpbmQgdGhlIHNlcnZlciB3aXRoIGNlcnRhaW4gYWRkcmVzcycuXG4iKQ0K
PiANCj4gSG93IGFib3V0ICJGQVRBTDogVGhlICctLXNlcnZlci1vbmx5JyBvcHRpb24gcmVxdWly
ZXMgYSBuYW1lL2FkZHJlc3MgdG8gYmluZCB0bw0KPiB3aXRoIHRoZSAtLWJpbmQgb3B0aW9uIj8N
Cj4gDQo+IFRvIGJlIGhvbmVzdCwgSSdkIGFsc28gZXhwZWN0IC0tYmluZCB0byB3b3JrIHdpdGhv
dXQgLS1zZXJ2ZXItb25seSwgZGVmYXVsdGluZyB0bw0KPiAibG9jYWxob3N0IiBpZiBpdCB3YXNu
J3Qgc2V0IGJ1dCB1c2luZyB0aGUgYWRkcmVzcy9uYW1lIHNwZWNpZmllZCBpZiBpdCB3YXMuIFRo
ZQ0KPiB1c2VjYXNlIHdvdWxkIGJlIHRvIGF0dGFjaCBhIHNlY29uZGFyeSBVSSB0byB0aGUgYml0
YmFrZSBzZXJ2ZXIgZHVyaW5nIHRoZQ0KPiBidWlsZCBwcm9jZXNzIGZvciBtb25pdG9yaW5nL2Nv
bnRyb2wgcHVycG9zZXMuDQoNClllcywgSSBjYW4gcmVtb3ZlIHRoYXQgbGltaXRhdGlvbi4NCg0K
SSBXaWxsIHJldmlzZSB0aGlzIHBhdGNoIGFuZCBzZW5kIG91dCBhZ2Fpbi4NCg0KVGhhbmtzLA0K
RG9uZ3hpYW8NCg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KPiANCj4gDQoNCg==


