Return-Path: <stefanx.stanacar@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 29AFD6F7E0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 07:42:32 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 13 Mar 2014 00:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,645,1389772800"; d="scan'208";a="491074990"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2014 00:40:47 -0700
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.87]) by
	IRSMSX101.ger.corp.intel.com ([163.33.3.153]) with mapi id
	14.03.0123.003; Thu, 13 Mar 2014 07:40:45 +0000
From: "Stanacar, StefanX" <stefanx.stanacar@intel.com>
To: "Burton, Ross" <ross.burton@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] toaster: fix timezone detection
Thread-Index: AQHPPfjuDVnPEMYLGkOzNRq8HrLhOprdnhSAgAEFHwA=
Date: Thu, 13 Mar 2014 07:40:44 +0000
Message-ID: <1394696458.15199.0.camel@firebird.rb.intel.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
	<CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
In-Reply-To: <CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.105.60]
MIME-Version: 1.0
Cc: "Damian, Alexandru" <alexandru.damian@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] toaster: fix timezone detection
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 13 Mar 2014 07:42:34 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <97862EBE82235F46A08C9B4FC8792DB2@intel.com>
Content-Transfer-Encoding: base64

DQoNCg0KT24gV2VkLCAyMDE0LTAzLTEyIGF0IDE2OjA2ICswMDAwLCBCdXJ0b24sIFJvc3Mgd3Jv
dGU6DQo+IE9uIDEyIE1hcmNoIDIwMTQgMTM6NDEsIEFsZXggREFNSUFOIDxhbGV4YW5kcnUuZGFt
aWFuQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCByZXBsYWNlcyBmYXVsdHkgdGlt
ZXpvbmUgZGV0ZWN0aW9uIHdpdGggYSB2ZXJzaW9uDQo+ID4gdGhhdCBzaW1wbHkgcmVhZHMgdGhl
IFRaIGVudmlyb25tZW50IHZhcmlhYmxlIGlmIGl0IGlzIHNldC4NCj4gDQo+IE15IERlYmlhbiBz
eXN0ZW0gZG9lc24ndCBoYXZlIGEgVFogZW52aXJvbm1lbnQgdmFyaWFibGUgYnV0IGRvZXMgaGF2
ZQ0KPiAvZXRjL2xvY2FsdGltZSB3aGljaCBpcyB0aGUgY3VycmVudCB0aW1lem9uZSBkYXRhLiBZ
ZXMsIGRldGVybWluaW5nDQo+IHRoZSBsb2NhbCB0aW1lem9uZSBpcyBhIHBhaW4uICA6KQ0KPiAN
Cj4gUm9zcw0KDQpGV0lXLCBteSBGZWRvcmEgMjAgc3lzdGVtIGRvZXNuJ3QgaGF2ZSBhIFRaIGVu
dmlyb25tZW50IHZhcmlhYmxlLiBJdA0KdXNlcyB0aGUgc2FtZSAvZXRjL2xvY2FsdGltZSBzeW1i
b2xpYyBsaW5rIGFzIERlYmlhbi4NCg0KQ2hlZXJzLA0KU3RlZmFuDQo=

