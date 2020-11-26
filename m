Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web10.12429.1606433506045446332
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Nov 2020 15:31:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: 1btA3jyvXtMPcOWgPEoLDpmbXUmsxQguIN1t7P3i7h67yVH9ReK+CguYOW4iWmuO1SnSjJ4iRf
 iws/aDEnRJjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="151588436"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="151588436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 15:31:45 -0800
IronPort-SDR: 3Oksm4XqvGf6iZJAH0SRUm2qlGWDqq9THeN4TaDysEpYZYWxvF0Oad9Em1/CiCzjfKaCnzb2UU
 +avxHeK63nQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="433367069"
Received: from kmsmsx601.gar.corp.intel.com ([172.21.219.141])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2020 15:31:44 -0800
Received: from pgsmsx601.gar.corp.intel.com (10.108.199.136) by
 kmsmsx601.gar.corp.intel.com (172.21.219.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Nov 2020 07:31:43 +0800
Received: from pgsmsx601.gar.corp.intel.com ([10.108.199.136]) by
 pgsmsx601.gar.corp.intel.com ([10.108.199.136]) with mapi id 15.01.1713.004;
 Fri, 27 Nov 2020 07:31:43 +0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: "JPEWhacker@gmail.com" <JPEWhacker@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake: hashserve: Add async client
Thread-Topic: [bitbake-devel][PATCH 1/2] bitbake: hashserve: Add async client
Thread-Index: AQHWt3IsGwOjeO3lK0ak5ksLMKnLZ6nZg/AAgACgmoCAAH8MAA==
Date: Thu, 26 Nov 2020 23:31:43 +0000
Message-ID: <e6a6cab19e8935351ebe9099b45bac7062e1e40d.camel@intel.com>
References: <20201110145956.1518964-1-JPEWhacker@gmail.com>
	 <20201110145956.1518964-2-JPEWhacker@gmail.com>
	 <48c57013bc2141c0cfbbb0ca5440071955428840.camel@intel.com>
	 <CAJdd5GYbEFSnTjv_CN2NG=Zv5qJ1ABdRskSon8wiE+nySF6Z4Q@mail.gmail.com>
In-Reply-To: <CAJdd5GYbEFSnTjv_CN2NG=Zv5qJ1ABdRskSon8wiE+nySF6Z4Q@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.32.68]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ABEC52B888EB246AF901A4C3B9F3379@intel.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIwLTExLTI2IGF0IDA5OjU2IC0wNjAwLCBKb3NodWEgV2F0dCB3cm90ZToNCj4g
DQo+IA0KPiBPbiBUaHUsIE5vdiAyNiwgMjAyMCwgMTI6MjIgQU0gQW51aiBNaXR0YWwgPGFudWou
bWl0dGFsQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gSGkgSm9zaHVhLA0KPiA+IA0KPiA+IEkg
dGhpbmsgdGhpcyBpcyBjYXVzaW5nIGlzc3VlcyB3aGVuIHRoZSBwYXRoIGV4Y2VlZHMgMTA4IGNo
YXJzOg0KPiA+IA0KPiA+IHN0ZXAxYjogV0FSTklORzogRXJyb3IgY29udGFjdGluZyBIYXNoIEVx
dWl2YWxlbmNlIFNlcnZlcg0KPiA+IHVuaXg6Ly8vaG9tZS9wb2t5YnVpbGQveW9jdG8tYXV0b2J1
aWxkZXItbmV3L3lvY3RvLXdvcmtlci9pbnRlbC0NCj4gPiBjb3JlMi0NCj4gPiAzMi1hbHRjZmct
bGludXgteW9jdG8vYnVpbGQvYnVpbGQvaGFzaHNlcnZlLnNvY2s6IEFGX1VOSVggcGF0aCB0b28N
Cj4gPiBsb25nDQo+IA0KPiBPZGQuIEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGF0IGxpbWl0IHRv
IGJlIGEgcHJvYmxlbSB3aXRoIHRoZSBvbGQNCj4gKG5vbi1hc3luYykgY2xpZW50IGFzIHdlbGwN
Cj4gDQoNCkkgc2VlIGEgY29tbWVudCBpbiB0aGUgb2xkIGNvZGUgdGhhdCBzYXlzOg0KDQo+ICMg
QUZfVU5JWCBoYXMgcGF0aCBsZW5ndGggaXNzdWVzIHNvIGNoZGlyIGhlcmUgdG8NCj4gd29ya2Fy
b3VuZA0KDQpTbyBwZXJoYXBzIHRoZSBvbGQgY2xpZW50IHdhcyBleHBsaWNpdGx5IGhhbmRsaW5n
IHRoaXMgY2FzZT8NCg0KVGhhbmtzLA0KDQpBbnVqDQo=
