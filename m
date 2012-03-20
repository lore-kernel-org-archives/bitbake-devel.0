Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S9zFm-0007qy-Lb
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 14:37:34 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 06:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121081536"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 20 Mar 2012 06:27:41 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 06:27:40 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 20 Mar 2012 21:27:39 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 06/12] Hob: allow users to setup the
	proxies
Thread-Index: AQHNBitCFdGss/LFP0WCg3dTPEFYBZZzLa6g
Date: Tue, 20 Mar 2012 13:27:39 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF253A@SHSMSX102.ccr.corp.intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<1a7d9a990627f74a94712aa2ca9f4bece2ed6511.1331910234.git.shane.wang@intel.com>
	<4F67C68A.7010802@linux.intel.com>
In-Reply-To: <4F67C68A.7010802@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 06/12] Hob: allow users to setup the	proxies
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
X-List-Received-Date: Tue, 20 Mar 2012 13:37:34 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Sm9zaHVhIExvY2sgd3JvdGUgb27CoDIwMTItMDMtMjA6DQoNCj4gDQo+IA0KPiBPbiAxNi8wMy8x
MiAwODoxMCwgU2hhbmUgV2FuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggaXMgdG8gc2V0IG9zLmVu
dmlyb24gdG8gYWxsb3cgdXNlcnMgdG8gc2V0IHRoZSBlbnZpcm9ubWVudA0KPiB2YXJpYWJsZXMg
Zm9yIGh0dHBfcHJveHksIGh0dHBzX3Byb3h5IGFuZCBmdHBfcHJveHkuDQo+IA0KPiBJIHRoaW5r
IHdlIG5lZWQgdG8gYmUgY2FyZWZ1bCBhYm91dCBpbXBsZW1lbnRpbmcgdGhpcyBmdW5jdGlvbmFs
aXR5LCBzbw0KPiBJIGhhdmUgdHdvIHN1Z2dlc3Rpb25zDQo+IDEpIEFzIGZhciBhcyBJIGNhbiB0
ZWxsIHRoZSBwcm94eSBzZXR0aW5ncyB3aWxsIG5vdCBiZSByZW1lbWJlcmVkDQo+IGJldHdlZW4g
cnVucyBvZiB0aGUgSG9iLCBJIHRoaW5rIHRoZXkgcHJvYmFibHkgc2hvdWxkIGJlLg0KWWVzLg0K
DQo+IDIpIElmIHRoZSB1c2VyIGFscmVhZHkgaGFzIHNvbWUgb3IgYWxsIG9mIHRoZSBwcm94eSBz
ZXR0aW5ncyBzZXQgaW4NCj4gdGhlaXIgZW52aXJvbm1lbnQgd2Ugc2hvdWxkIHByb2JhYmx5IGRl
dGVjdCB0aG9zZSBhbmQgZGlzcGxheSB0aGVtDQo+IGFwcHJvcHJpYXRlbHkgaW4gdGhlIEdVSS4N
Ck9LLCB3aWxsIGludmVzdGlnYXRlIGFuZCBoYXZlIGEgdHJ5Lg0KDQo+IA0KPiBBcmUgdGhlaXIg
YW55IGRlc2lnbiBkb2N1bWVudHMgZm9yIHRoaXMgZGlhbG9ndWU/DQpOby4NCg0KPiANCj4gQ2hl
ZXJzLA0KPiBKb3NodWENCg==


