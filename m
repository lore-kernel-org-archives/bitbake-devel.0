Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web12.29101.1610943670786243419
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Jan 2021 20:21:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.100, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: gWmxQtkzUFrYuG8GstdmNeP44TAO4SWfUobE5sXAI/M9cA+L4NdDlDbQIKKvoS78rrzA78M79n
 wPv9iGUDE6XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="242827826"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="242827826"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 20:21:09 -0800
IronPort-SDR: lmV7IRUHYvFVEQ0bJPpe6GNyE8AFugTV8L2dmqdpQxgeschqBQrJuhn+M549umhBvb/OQzEIsG
 W2LVKrsBMHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="573160735"
Received: from pgsmsx601.gar.corp.intel.com ([10.108.199.136])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2021 20:21:08 -0800
Received: from pgsmsx601.gar.corp.intel.com (10.108.199.136) by
 pgsmsx601.gar.corp.intel.com (10.108.199.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 12:21:07 +0800
Received: from pgsmsx601.gar.corp.intel.com ([10.108.199.136]) by
 pgsmsx601.gar.corp.intel.com ([10.108.199.136]) with mapi id 15.01.1713.004;
 Mon, 18 Jan 2021 12:21:07 +0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: "steve@sakoman.com" <steve@sakoman.com>, "peter.kjellerstedt@axis.com"
	<peter.kjellerstedt@axis.com>, "akuster808@gmail.com" <akuster808@gmail.com>
CC: "openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"openembedded-devel@lists.openembedded.org"
	<openembedded-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
Thread-Topic: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME
 to Gatesgarth and Dunfell
Thread-Index: AdbqluypjM9qGzPGT4u0xlyyjXAnKgCd1wYA
Date: Mon, 18 Jan 2021 04:21:07 +0000
Message-ID: <31cbf5fec18960f2bd5c1c0082f89c45f83ee6c0.camel@intel.com>
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
In-Reply-To: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.32.68]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A479CCA312FC8E4CBDF01C1A7355CE17@intel.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIxLTAxLTE0IGF0IDE3OjUwICswMDAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3Jv
dGU6DQo+IEkgZ3Vlc3MgdGhlcmUgbWF5IGJlIHNvbWUgY29udHJvdmVyc3kgcmVnYXJkaW5nIHdo
ZXRoZXIgdGhlc2UgY2hhbmdlcw0KPiBzaG91bGQgDQo+IGJlIGJhY2twb3J0ZWQgdG8gdGhlIHN0
YWJsZSBicmFuY2hlcyBzaW5jZSB0aGV5IG1vZGlmeSB3aGF0DQo+IHB5dGhvbjNuYXRpdmUgDQo+
IGRvZXMgYW5kIG1heSByZXF1aXJlIGV4aXN0aW5nIHJlY2lwZXMgdG8gYmUgbW9kaWZpZWQgdG8g
aW5oZXJpdCB0aGUNCj4gbmV3IA0KPiBweXRob24zdGFyZ2V0Y29uZmlnIGNsYXNzLiBIb3dldmVy
LCBJIGJlbGlldmUgdGhhdCBoYXZpbmcgZGV2dG9vbA0KPiBtb2RpZnkgDQo+IGZhaWwgb24gcmFu
ZG9tIHJlY2lwZXMgd2l0aG91dCBhbiBlYXN5IHNvbHV0aW9uIGZvciB0aGUgdXNlciBpcyBtdWNo
DQo+IHdvcnNlIA0KPiB0aGFuIGhhdmluZyB0byB1cGRhdGUgYSByZWNpcGUgb3IgdHdvIG9uY2Ug
ZHVlIHRvIGEgYnVpbGQgZmFpbHVyZQ0KPiBhZnRlciANCj4gdXBncmFkaW5nIHRvIGEgbmV3IHZl
cnNpb24gb2YgT0UtQ29yZSAoaW4gbXkgYm9vayB0aGF0IGlzIHByZXR0eQ0KPiBub3JtYWwgYW5k
IA0KPiBzb21ldGhpbmcgSSBhbHdheXMgaGF2ZSB0byBkbyBhbnl3YXkgd2hlbiB3ZSB1cGRhdGUg
T0UtQ29yZSkuDQoNCkkgYWdyZWUgdGhhdCBkZXZ0b29sIGZhaWxpbmcgaXMgbm90IGdvb2QgZXNw
ZWNpYWxseSB3aGVuIHdlIHJlY29tbWVuZA0KdGhhdCBwZW9wbGUgcnVuIGl0IGluIHNvbWUgaGVs
cCBtZXNzYWdlcy4NCg0KSXMgdGhlcmUgYSB3YXkgd2UgY2FuIHNob3cgYSBoZWxwZnVsIG1lc3Nh
Z2UgZm9yIHN0YWJsZSBicmFuY2hlcyB3aGVuDQpzdWNoIGEgY2hhbmdlIG1pZ2h0IGJlIG5lZWRl
ZD8NCg0KVGhhbmtzLA0KDQpBbnVqDQo=
