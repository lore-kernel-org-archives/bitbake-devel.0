Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SGT4D-0001Hs-ES
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 12:40:25 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 07 Apr 2012 03:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128166449"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 07 Apr 2012 03:31:10 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sat, 7 Apr 2012 03:31:09 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Sat, 7 Apr 2012 18:31:07 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, "Cui, Dexuan"
	<dexuan.cui@intel.com>, "Xu, Dongxiao" <dongxiao.xu@intel.com>, Saul Wold
	<sgw@linux.intel.com>, Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] hob2: make xterm automatically exit after qemu
	exits?
Thread-Index: AQHNFIrEQdAjTgM2Sk6CBrD+uIlqyJaPKMEl
Date: Sat, 7 Apr 2012 10:31:07 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD3164F@SHSMSX102.ccr.corp.intel.com>
References: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
	<A25F549E4D43CD42B4C02DF47A1913230FCFCF0F@SHSMSX102.ccr.corp.intel.com>,
	<3AB6CE7F274E534CAFD089D127A8A1FC23B15B7F@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23B15B7F@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.137]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: =?UTF-8?B?562U5aSNOiBob2IyOiBtYWtlIHh0ZXJtIGF1dG9tYXRpY2FsbHkgZXhpdCBhZnRlciBxZW11CWV4aXRzPw==?=
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
X-List-Received-Date: Sat, 07 Apr 2012 10:40:25 -0000
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SSdtIGFmcmFpZCB3ZSBoYXZlIHRoZSBzYW1lIHByb2JsZW0uIEhhdmUgeW91IHRyaWVkIGFwcGVu
ZCAiO2V4aXQiIHRvIHRoZSBydW4tcWVtdSBjb21tYW5kPw0KDQpTb3JyeSBmb3IgdGhlIGF1dG9t
YXRpYyBDaGluZXNlIHRyYW5zbGF0aW9uLiBJIGhhdmUgdG8gdXNlIHdlYm1haWwgbGlnaHQgdG8g
YWNjZXNzIHRoZSBlbWFpbCwgSSBkb24ndCBrbm93IHdoeSB0aGUgVlBOIGNvbm5lY3Rpb24gdG9k
YXkgaXMgc28gc2xvdyB0aGF0IG15IE91dGxvb2sgZG9lc24ndCB3b3JrIGF0IGFsbC4NCg0KLUxp
YW5oYW8NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjL
OiBXYW5nLCBTaGFuZQ0Kt6LLzcqxvOQ6IDIwMTLE6jTUwjfI1SAxNDo1MA0Ktb06IEN1aSwgRGV4
dWFuOyBYdSwgRG9uZ3hpYW87IFNhdWwgV29sZDsgUGF1bCBFZ2dsZXRvbg0KQ2M6IGJpdGJha2Ut
ZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZzsgWmhhbmcsIEplc3NpY2E7IEx1LCBMaWFuaGFv
DQrW98ziOiBSRTogW2JpdGJha2UtZGV2ZWxdIGhvYjI6IG1ha2UgeHRlcm0gYXV0b21hdGljYWxs
eSBleGl0IGFmdGVyIHFlbXUgIGV4aXRzPw0KDQpDdWksIERleHVhbiB3cm90ZSBvbiAyMDEyLTA0
LTA2Og0KDQo+IEN1aSwgRGV4dWFuIHdyb3RlIG9uIDIwMTItMDQtMDU6DQo+PiBIaSBhbGwsIEkn
bSB0ZXN0aW5nIGhvYjIncyAiUnVuIGltYWdlIiBmdW5jdGlvbmFsaXR5IGFuZCBmb3VuZCB0aGUg
eHRlcm0NCj4+IHdpbmRvdyBkb2Vzbid0IGV4aXQgYXV0b21hdGljYWxseSBhZnRlciB0aGUgcWVt
dSBleGl0cy4NCj4+DQo+PiBBcyBhIHJlc3VsdCwgZXZlcnkgdGltZSB3aGVuIEkgdHJ5ICJSdW4g
aW1hZ2UiLCBhIG5ldyB4dGVybSB3aW5kb3cgaXMNCj4+IGNyZWF0ZWQuIEFmdGVyIHNvbWUgcm91
bmRzIG9mIHRlc3RpbmcsIEkgaGF2ZSB0byBtYW51YWxseSB0ZXJtaW5hdGUNCj4+IG1hbnkgd2lu
ZG93cyBvbmUgYnkgb25lLi4uIElzIHRoaXMgdGhlIGludGVuZGVkIGJlaGF2aW9yPyBJZiBubywg
SQ0KPj4gdGhpbmsgd2Ugc2hvdWxkIHJlbW92ZSB0aGUgIjsgYmFzaCIgZnJvbSBidWlsZGVyLnB5
KHNlZSB0aGUgZ3JlcCByZXN1bHQNCj4+IGF0IHRoZSBlbmQgb2YgdGhlIG1haWwpPw0KSW50ZW5k
ZWQgdG8gYmUuIFJlbW92aW5nICJiYXNoIiBkb2Vzbid0IGZpeCB0aGUgcHJvYmxlbS4gSSB0cmll
ZCB0aGF0IGJlZm9yZS4NCldlIGZvbGxvd2VkIHdoYXQgQURUIGRpZC4gTGlhbmhhbyB0b2xkIG1l
IHdoZW4gdGhlIHVzZXIgbmVlZHMgdG8gbGF1bmNoIHFlbXUgdG8gZGVidWcgaW4gQURUIEVjbGlw
c2UgcGx1Z2luLCB0aGUgQURUIHRlYW0gdXNlcyB4dGVybSwgc2luY2UgdGhhdCBpcyB0aGUgbWlu
aW1hbCB0ZXJtaW5hbC4gU28gSSBkaWRuJ3QgaW52ZXN0aWdhdGUgb3RoZXIgYXBwcm9hY2hlcyBi
dXQgc3Rvb2Qgb24gdGhlIHNob3VsZGVyIG9mIHRoZSBBRFQgdGVhbS4NCg0KSSBzdXNwZWN0IHRo
YXQgd2lsbCBvY2N1ciBvbiBBRFQncyBzaWRlLiBKZXNzaWNhLCBMaWFuaGFvLCBkbyB5b3UgaGF2
ZSBiZXR0ZXIgc29sdXRpb24/DQoNCj4+DQo+PiBCVFcsIEkgdGhpbmsgdGhlIGhpZy5weSAodGhl
IGRlcGxveSB0b29sKSBoYXMgdGhlIHNhbWUgaXNzdWU/DQo+Pg0KPj4gJCBncmVwICI7IGJhc2gi
IGJpdGJha2UvIC1uciBiaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvYnVpbGRlci5weTo5Mzc6DQo+
PiBjbWRsaW5lICs9ICJydW5xZW11ICIgKyBrZXJuZWxfcGF0aCArICIgIiArIGltYWdlX3BhdGgg
KyAiOyBiYXNoXCIiDQo+PiBiaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvaGlnLnB5Ojc0MTogY21k
bGluZSArPSAiXCJzdWRvIGRkIGlmPSIgKw0KPj4gc2VsZi5pbWFnZV9wYXRoICsgIiBvZj0iICsg
Y29tYm9faXRlbSArICI7IGJhc2hcIiINClllcy4NCg0KPg0KPiBBIG5ldyBxdWVzdGlvbjoNCj4g
V2h5IGRvIHdlIHVzZSAvdXNyL2Jpbi94dGVybSBoZXJlIGJ5IGhhcmRjb2RlPw0KPiBDYW4gd2Ug
Y2hhbmdlIGl0IHRvIG1hdGNoYm94LXRlcm1pbmFsPyBPciwgY2FuIHdlIHVzZSBzb21lIGtpbmQg
b2YNCj4gYWxnb3JpdGhtIHRvIGRldGVybWluZSB0aGUgYXZhaWxhYmxlIHRlcm1pbmFsPw0KSXMg
bWF0Y2hib3gtdGVybWluYWwgdGhlIG1pbmltYWwgdGVybWluYWwgb24gTGludXggZGlzdHJpYnV0
aW9ucywgY29tcGFyZWQgd2l0aCB4dGVybT8gSWYgc28sIHdlIGNhbiByZXBsYWNlIHh0ZXJtIHdp
dGggdGhhdC4NClllcywgd2UgY2FuLCBmZWF0dXJlIGVuaGFuY2VtZW50Lg0KDQo+DQo+IEkgYXNr
ZWQgdGhlIHF1ZXN0aW9uIGJlY2F1c2UgaW4gdGhlIHNlbGYtaG9zdGVkLWltYWdlIG9mIHBva3ks
DQo+IHdlIGRvbid0IGhhdmUgeHRlcm0gKHBva3kgZG9lc24ndCBoYXZlIGEgcmVjaXBlIGZvciB4
dGVybSkgYW5kIEkNCj4gdGhpbmsgaXQgbWF5IG5vdCBkZXNlcnZlIHRoZSBlZmZvcnQgdG8gYWRk
IGEgcmVjaXBlIGZvciB4dGVybSBvbmx5DQo+IGZvciB0aGlzIHNwZWNpZmljIHVzYWdlIGluIHNl
bGYtaG9zdGVkLWltYWdlLg0KSSBzZWUuIE15IGNvbmNlcm4gaXMgd2hldGhlciBtYXRjaGJveC10
ZXJtaW5hbCBpcyBhdmFpbGFibGUgb24gVWJ1bnR1L0ZlZG9yYS9PcGVuU3VzZS9DZW50T1MsIGFu
ZCBzbyBvbi4NCg0KPg0KPiBUaGFua3MsDQo+IC0tIERleHVhbg0KPg==


