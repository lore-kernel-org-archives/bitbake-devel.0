Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SFnTx-0004rG-C3
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 16:16:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 07:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127472097"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 05 Apr 2012 07:07:00 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 5 Apr 2012 07:06:59 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 5 Apr 2012 22:06:58 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 0/4] Continue Hob fixes
Thread-Index: AQHNEyzuQY+AZCIepkq9n7gsZ7NA0JaMRDjw
Date: Thu, 5 Apr 2012 14:06:57 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B140B4@SHSMSX102.ccr.corp.intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
	<1333631169.6300.17.camel@ted>
In-Reply-To: <1333631169.6300.17.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/4] Continue Hob fixes
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
X-List-Received-Date: Thu, 05 Apr 2012 14:16:13 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IFJpY2hhcmQuDQoNCk9uZSBtb3JlIHBhdGNoc2V0IG1pc3Npbmc6ICJbUEFUQ0gg
MC82XVtSZXNlbmRdIEhvYiBmaXhlcyIsIHNlbnQgYnkgbWUuDQoNClRoYW5rcy4NCi0tDQpTaGFu
ZQ0KDQpSaWNoYXJkIFB1cmRpZSB3cm90ZSBvbsKgMjAxMi0wNC0wNToNCg0KPiBPbiBNb24sIDIw
MTItMDQtMDIgYXQgMjM6MjIgKzA4MDAsIFNoYW5lIFdhbmcgd3JvdGU6DQo+PiBUaGUgcGF0Y2hl
cyBpcyB0byBjb250aW51ZSBTaGFuZSBXYW5nJ3MgcHJldmlvdXMgc3VibWlzc2lvbiB0byBmaXgg
SG9icy4NCj4+IFRoZXkgaW5jbHVkZToNCj4+ICAtIFJlcGxhY2UgYW4gaWNvbg0KPj4gIC0gQWRk
IGxvZ3MgYW5kIGFsbG93IHVzZXJzIHRvIHJldHJpZXZlIHRoZSBsb2dzIGFmdGVyIHN1Y2Nlc3Nm
dWwgYnVpbGQNCj4+ICAtIE1pc2MgZml4ZXMgd2hlbiB0ZXN0aW5nDQo+PiBUaGUgZm9sbG93aW5n
IGNoYW5nZXMgc2luY2UgY29tbWl0DQo+PiBmNGIxMDJjZGYyY2QwMjFhMGI1YWNhY2IwMzRkZDU2
OGE4ZTczODE3Og0KPj4gDQo+PiAgIEhvYjogYSBtaW5vciBmaXggb24gcG1ha2UgKDIwMTItMDQt
MDIgMTY6MjU6NTYgKzA4MDApDQo+PiBhcmUgYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9y
eSBhdDoNCj4+ICAgZ2l0Oi8vZ2l0LnBva3lsaW51eC5vcmcvcG9reS1jb250cmliIHNoYW5lL2hv
Yi1maXhlcy0xDQo+PiAgIGh0dHA6Ly9naXQucG9reWxpbnV4Lm9yZy9jZ2l0LmNnaS9wb2t5LWNv
bnRyaWIvbG9nLz9oPXNoYW5lL2hvYi1maXhlcy0xDQo+PiBTaGFuZSBXYW5nICg0KToNCj4+ICAg
SG9iOiBhZGQgdGhlICJpbmZvIiBpbmRpY2F0aW9uIGljb24gZm9yICJpbmZvcm1hdGlvbiIgaW4g
dGhlIGRpYWxvZ3MuDQo+PiAgIA0KPj4gICBIb2I6IHJlbW92ZSBncmFiX2RlZmF1bHQoKSBmb3Ig
ZGVwbG95IGJ1dHRvbg0KPj4gICBIb2I6IHJlc2V0IGlzc3VlIGluZGljYXRpb24gYW5kIGJ1aWxk
IHN0YXR1cyBiZWZvcmUgYnVpbGQgc3RhcnRzIG9uDQo+PiAgICAgYnVpbGQgZGV0YWlscyBzY3Jl
ZW4NCj4gDQo+IE1lcmdlZCB0byBtYXN0ZXIsIHRoYW5rcy4NCj4gDQo+PiAgSG9iOiBsb2cgZm9y
IEhvYiBhbmQgYWxsb3cgdXNlcnMgdG8gc2hvdyBsb2dzIGFmdGVyIHN1Y2Nlc3NmdWwgYnVpbGQN
Cj4gDQo+IFRoaXMgaGFzIGRpc2N1c3Npb24gc28gSSd2ZSBub3QgbWVyZ2VkIGl0IGZvciBub3cu
DQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCg0K


