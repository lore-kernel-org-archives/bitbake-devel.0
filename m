Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SFo3q-0005G0-Bm
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 16:53:18 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 07:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85684639"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Apr 2012 07:44:05 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 5 Apr 2012 07:44:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 5 Apr 2012 22:44:03 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] bb.utils.vercmp() not consistent with debian
	rules
Thread-Index: Ac0S9GhCT6tSU6xnTdu2BdFPrMkC3P//e9WA//93ZrCAAOogAIAAC5qA//9ttVA=
Date: Thu, 5 Apr 2012 14:44:01 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D363@SHSMSX102.ccr.corp.intel.com>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
	<20120405062857.GK4181@jama.jama.net>
	<857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
	<1333628280.6300.6.camel@ted> <1333630771.6300.12.camel@ted>
In-Reply-To: <1333630771.6300.12.camel@ted>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: bb.utils.vercmp() not consistent with debian rules
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
X-List-Received-Date: Thu, 05 Apr 2012 14:53:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpSaWNoYXJkIFB1cmRpZSB3cm90ZSBvbiAyMDEyLTA0LTA1Og0KPiBPbiBUaHUsIDIwMTItMDQt
MDUgYXQgMTM6MTggKzAxMDAsIFJpY2hhcmQgUHVyZGllIHdyb3RlOg0KPj4gT24gVGh1LCAyMDEy
LTA0LTA1IGF0IDA2OjQyICswMDAwLCBMdSwgTGlhbmhhbyB3cm90ZToNCj4+PiBNYXJ0aW4gSmFu
c2Egd3JvdGUgb24gMjAxMi0wNC0wNToNCj4+Pj4gT24gVGh1LCBBcHIgMDUsIDIwMTIgYXQgMDY6
MjI6MDBBTSArMDAwMCwgTHUsIExpYW5oYW8gd3JvdGU6DQo+Pj4+PiBIaSBndXlzLA0KPj4+Pj4g
DQo+Pj4+PiBXaGVuIEknbSBsb29raW5nIGF0IHRoZSBZb2N0byBidWcjMjIzMywgSSBmaW5kIHRo
YXQgdGhlIGZ1bmN0aW9uDQo+Pj4+PiBiYi51dGlscy52ZXJjbXAoKSBpcyBub3QgY29uc2lzdGVu
dCB3aXRoIHRoZSBkZWJpYW4gcGFja2FnaW5nDQo+Pj4+PiBydWxlcyhodHRwOi8vd3d3LmRlYmlh
bi5vcmcvZG9jL2RlYmlhbi1wb2xpY3kvY2gtY29udHJvbGZpZWxkcy5odG1sI3MtZi0NCj4+Pj4+
IFZlcnNpb24pLg0KPj4+Pj4gDQo+Pj4+PiBBY2NvcmRpbmcgdG8gZGViaWFuIHJ1bGVzLCAicjAi
IGlzIGVhcmxpZXIgdGhhbiAicjAtZHJlYW0iLCBidXQgdGhlIGJiLnV0aWxzLnZlcmNtcCgpIHRo
aW5rcyAicjAiIGlzIGxhdGVyIHRoYW4gInIwLWRyZWFtIi4NCj4+Pj4gDQo+Pj4+IEFuZCB3aGF0
IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+Pj4+IA0KPj4+PiBWZXJzaW9uOiAzLjItcjEw
DQo+Pj4+IGlzIG9sZGVyIHRoZW4NCj4+Pj4gVmVyc2lvbjogMy4yLXIyLW9lMA0KPj4+IA0KPj4+
IEkgdGhpbmsgdGhpcyBpcyBleGFjdGx5IHdoYXQgdGhlIGRlYmlhbiBydWxlcyB3YW50cywgIjMu
Mi1yMTAiPiIzLjItcjItb2UwIi4gQW5kIG9wa2cgZm9sbG93cyB0aGF0IHJ1bGUuDQo+Pj4gDQo+
Pj4gVGhlIHByb2JsZW0gaXMgdGhhdCBiYi51dGlscy52ZXJjbXAgdGhpbmtzICIzLjItcjIiPiIz
LjItcjItb2UwIiB3aGlsZSBvcGtnIHRoaW5rcyAiMy4yLXIyIjwiMy4yLXIyLW9lMCIuDQo+PiAN
Cj4+IEFsbCB0aGUgdmVyc2lvbiBjb21wYXJpc29ucyBhcmUgbWVhbnQgdG8gZnVuY3Rpb24gdGhl
IHNhbWUgd2F5IGFuZCB0aGUNCj4+IGRlYmlhbiBzb3J0aW5nIGlzIG1lYW50IHRvIGJlIHVzZWQg
YXMgYSBndWlkZS4gSWYgdGhhdCBwYXRjaCBkb2VzIGJyZWFrDQo+PiB0aGluZ3MsIHdlIHNob3Vs
ZCBjb25zaWRlciByZW1vdmluZyAiLSIgYXMgdGhlIHNlcGFyYXRvciBhbmQgb25seSB1c2UNCj4+
ICIuIi4NCj4gDQo+IFNvIGp1c3QgdG8gYmUgY2xlYXIsIHdlIGhhdmUgdmFyaW91cyB2ZXJzaW9u
IHNvcnRpbmcgYWxnb3JpdGhtczoNCj4gDQo+ICogb3BrZw0KPiAqIG9wa2ctY29tcGFyZS12ZXJz
aW9ucyAod2hpY2ggaGFzIGEgQyB2ZXJzaW9uIGFuZCBhIHNoZWxsIHZlcnNpb24hKQ0KPiAqIGJi
LnV0aWxzLnZlcmNtcCgpDQo+ICogYmIudXRpbHMudmVyY21wX3N0cmluZygpDQo+IA0KPiBhbmQg
YWxsIHRoZXNlIGZ1bmN0aW9ucyAqbmVlZCogdG8gYmUgY29uc2lzdGVudC4gQ29uc2lzdGVudCBp
cyBkZWZpbmVkDQo+IGluIHRoaXMgY2FzZSBhcyBmb2xsb3dpbmcgdGhlIERlYmlhbiB2ZXJzaW9u
IHBvbGljeS4gVGhpcyBpcyBpZ25vcmluZw0KPiB0aGUgb3RoZXIgcGFja2FnZSBiYWNrZW5kcy4g
ZHBrZyBzaG91bGQgImp1c3Qgd29yayIsIHJwbSBjYW4gYmUNCj4gcHJvZ3JhbW1lZCB0byB1c2Ug
YW55IGFsZ29yaXRobSBhbmQgaXMgcHJvYmFibHkgbm90IGNvbnNpc3RlbnQgd2l0aCB0aGlzDQo+
IGF0IHRoaXMgcG9pbnQgYnV0IHdlIHNob3VsZCBwcm9iYWJseSBpZ25vcmUgdGhhdCBpbiB0aGUg
ZXF1YXRpb24gYXQgdGhpcw0KPiBwb2ludC4NCj4gDQo+IFNvIHRoZSBxdWVzdGlvbiBpcywgd2hp
Y2ggb2YgdGhlIGFib3ZlIGFyZSBjb25zaXN0ZW50IG9yIGluY29uc2lzdGVudA0KPiB3aXRoIGVh
Y2ggb3RoZXIgKGFuZCBkcGtnKSwgYW5kIGhvdyB0aGV5IGFyZSBpbmNvbnNpc3RlbnQuIFdlIGNh
biB0aGVuDQo+IGNvbnNpZGVyIHdoYXQgdG8gZG8gYWJvdXQgaXQuDQo+IA0KDQpUaGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIHRob3NlIGlzIGhvdyB0byB0cmVhdCAic2VwYXJhdG9ycyIgaW4gdmVyc2lv
biBjb21wYXJlLg0KVGFrZSAyIGV4YW1wbGVzLCB2MT0iMy4yLXIyLW9lMCIsIHYxJz0iMy4yLXIy
IjsgdjI9IjQuNC1yOC1vZTAiLCB2Mic9IjQuNC1yOGEiDQoNClRoZSBEZWJpYW4gdmVyc2lvbiBw
b2xpY3kgc2F5cywgIi4uLnNvIHRoYXQgYWxsIHRoZSBsZXR0ZXJzIHNvcnQgZWFybGllciB0aGFu
IGFsbCANCnRoZSBub24tbGV0dGVycyBhbmQgc28gdGhhdCBhIHRpbGRlIHNvcnRzIGJlZm9yZSBh
bnl0aGluZywgZXZlbiB0aGUgZW5kIG9mIGEgcGFydC4iDQpTbyB2MT52MScsIHYyPnYyJy4NCg0K
VGhlIG9wa2cgZm9sbG93cyB0aGUgRGViaWFuIHJ1bGVzLCBhbmQgcmVwb3J0cyB2MT52MScsIHYy
PnYyJy4gZHBrZyByZXBvcnRzIHRoZSBzYW1lLg0KDQpUaGUgQyB2ZXJzaW9uIG9mIG9wa2ctY29t
cGFyZS12ZXJzaW9ucyByZXBvcnRzIHYxPnYxJywgdjI8djInLiAoVGhlIHNoZWxsIHZlcnNpb24g
ZG8NCk5PVCBoYXZlIHRoZSBmdW5jdGlvbiBvZiBjb21wYXJpc29uKS4NCg0KVGhlIGJiLnV0aWxz
LnZlcmNtcCgpIHJlcG9ydHMgdjE8djEnLCB2Mjx2MicuIEl0IHRyZWF0cyBhbGwgc2VwYXJhdG9y
cyhpLmUuICIuIiBhbmQgIi0iKSBhcyB0aWxkZQ0KaW4gRGViaWFuIHJ1bGVzLiBUaGUgYmIudXRp
bHMudmVyY21wIGlzIHVzZWQgYm90aCBieSBiaXRiYWtlIGludGVybmFsbHkgYW5kIGJiY2xhc3Mu
DQoNClRoZSBiYi51dGlscy52ZXJjbXBfc3RyaW5nKCkgZG9lcyBOT1QgYWNjZXB0IHZlcnNpb24g
c3RyaW5nIGNvbnRhaW5pbmcgc2VnbWVudHMgc3RhcnRpbmcgd2l0aCANCm5vbi1kaWdpdGFsIGNo
YXJhY3Rlci4gYmIudXRpbHMudmVyY21wX3N0cmluZyBzZWVtcyBuZXZlciBiZWluZyBhY3R1YWxs
eSBjYWxsZWQuDQoNClNlZW1zIHdlIGhhdmUgbm90aGluZyBjb25zaXN0ZW50IGhlcmUuIDotKCAg
DQoNCi0gTGlhbmhhbw0KDQoNCg==


