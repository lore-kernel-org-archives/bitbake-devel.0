Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web11.2479.1611713850090730076
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jan 2021 18:17:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: fYqFJMQrutwj4Gsc79sWzl0vUwiTO+s+YOujjelQLH6JJA7i92vq+cGIQ9/OSU7NXOX0amUyP+
 Qu1RFz9swVsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167101770"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="167101770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 18:17:28 -0800
IronPort-SDR: Q/umDpgqa1HY7XMDm57WiqWderRGpbUq9j0bEHEKmIec1kfxDkX524S6O8UKGU7YZ0nCJixwl0
 ZuOzolTkMrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="350851377"
Received: from pgsmsx603.gar.corp.intel.com ([10.108.199.138])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2021 18:17:27 -0800
Received: from pgsmsx601.gar.corp.intel.com (10.108.199.136) by
 pgsmsx603.gar.corp.intel.com (10.108.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Jan 2021 10:17:27 +0800
Received: from pgsmsx601.gar.corp.intel.com ([10.108.199.136]) by
 pgsmsx601.gar.corp.intel.com ([10.108.199.136]) with mapi id 15.01.1713.004;
 Wed, 27 Jan 2021 10:17:27 +0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: "steve@sakoman.com" <steve@sakoman.com>, "peter.kjellerstedt@axis.com"
	<peter.kjellerstedt@axis.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Topic: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Index: AdbzSs9iIwSRISEBSdmT28Djb0vF7gAxLBsA
Date: Wed, 27 Jan 2021 02:17:26 +0000
Message-ID: <0c8d88d78b54493a64b67fad737a0aed0ca18437.camel@intel.com>
References: <d5882aa4c29d4f268dd9312d597538ce@XBOX03.axis.com>
In-Reply-To: <d5882aa4c29d4f268dd9312d597538ce@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.32.68]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5161DC59158E02439E62288A1F2D4A5A@intel.com>
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDE4OjU0ICswMDAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3Jv
dGU6DQo+IENhbiB5b3UgcGxlYXNlIGJhY2twb3J0IDI2Y2NmMTU3NWFlZjJkNmUyZDc3MTdkM2Jk
MTBiMWVkMGQ1YTc3N2QNCj4gKGRhdGFfc21hcnQ6IEVuc3VyZSBoYXNoIHJlZmxlY3RzIHZhcmRl
cHZhbHVlIGZsYWdzIGNvcnJlY3RseSkgdG8gDQo+IER1bmZlbGwgYW5kIEdhdGVzZ2FydGg/DQo+
IA0KPiBJIGFtIHNlZWluZyBlcnJvcnMgd2hlbiBidWlsZGluZyBhbiBTREsgd2l0aCAzLjEuNSBi
ZWNhdXNlIGNvbW1pdCANCj4gY2MyZTJjMmQwNjU1MzBhNWFiMzNmZWQxMzlkMTZmZTFkY2RjYTRk
OSAobWV0YWRhdGFfc2NtOiBGaXggc2lnbmF0dXJlDQo+IGhhbmRsaW5nIG9mIE1FVEFEQVRBX1JF
VklTSU9OIGFuZCBNRVRBREFUQV9CUkFOQ0gpIHdhcyBiYWNrcG9ydGVkIA0KPiB0byBEdW5mZWxs
IGluIE9FLUNvcmUuIEZvciBHYXRlc2dhcnRoLCB0aGUgbGF0dGVyIGNvbW1pdCBzaG91bGQgYWxz
byANCj4gYmUgYmFja3BvcnRlZCAob25jZSB0aGUgY29tbWl0IGluIGJpdGJha2UgaGFzIGJlZW4g
YmFja3BvcnRlZCkuDQoNCkxvb2tzIGxpa2UgUmljaGFyZCBoYXMgYWxyZWFkeSBtZXJnZWQgaXQg
aW4gMS40OCBhbmQgMS40Ni4gVGhhbmtzDQpSaWNoYXJkIQ0KDQpUaGFua3MsDQoNCkFudWoNCg==
