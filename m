Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web10.5876.1619573412880915305
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 18:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.100, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: tXPMglTtl4mSsmbUDfAzaW7CJXknr8tVmONHaN4S4AlG2AP8dhKQSdzR9ZGNrIX/VgNKE74ScQ
 vgKUdK7N3ZHw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="260582779"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="260582779"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:30:11 -0700
IronPort-SDR: CD4pKqF6fxjoCdXneDmjnhNQROIEXtQcSRFi6+6o9RJq6NatOsvHh2yruca0L2SlR0uVWP12/j
 bVoY03zx4vsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="403482226"
Received: from pgsmsx603.gar.corp.intel.com ([10.108.199.138])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2021 18:30:10 -0700
Received: from pgsmsx601.gar.corp.intel.com (10.108.199.136) by
 pgsmsx603.gar.corp.intel.com (10.108.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 09:30:09 +0800
Received: from pgsmsx601.gar.corp.intel.com ([10.108.199.136]) by
 pgsmsx601.gar.corp.intel.com ([10.108.199.136]) with mapi id 15.01.2106.013;
 Wed, 28 Apr 2021 09:30:09 +0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: "mark.hatle@kernel.crashing.org" <mark.hatle@kernel.crashing.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [1.50][PATCH 1/5] runqueue: Fix deferred task issues
Thread-Topic: [bitbake-devel] [1.50][PATCH 1/5] runqueue: Fix deferred task
 issues
Thread-Index: AQHXO4ZYP2QEuZnj/0+E7pZI05H+XarInuSA
Date: Wed, 28 Apr 2021 01:30:09 +0000
Message-ID: <67fe3ac5c9e2e836880a57f31abdbad3d58f9b24.camel@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
	 <c09436f7c719c4341611bb4df91524738d272440.1619407547.git.anuj.mittal@intel.com>
	 <d773e5f2-947b-c1a6-f015-f465f42e207c@kernel.crashing.org>
In-Reply-To: <d773e5f2-947b-c1a6-f015-f465f42e207c@kernel.crashing.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.32.68]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D580FE9089F335429FD14062705CBD4F@intel.com>
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIxLTA0LTI3IGF0IDExOjU3IC0wNTAwLCBNYXJrIEhhdGxlIHdyb3RlOg0KPiBU
aGlzIGNoYW5nZSBhbHNvIGZpeGVzIHRoZSBzYW1lIGlzc3VlIGluICdnYXRlc2dhcnRoJyB3b3Jr
IGFzIHdlbGwuwqANCj4gQ2FuIHdlIGdldA0KPiB0aGlzIGFkZGVkIHRoZXJlIGFzIHdlbGwuwqAg
KEknbSBoYXBweSB0byBzdWJtaXQgc29tZXRoaW5nLCBqdXN0DQo+IHdhbnRlZCB0byBjaGVjaw0K
PiBpZiBpdCB3YXMgYWxyZWFkeSBpbiBwbGFuLikNCg0KWWVzLCB3aWxsIGluY2x1ZGUgaXQgaW4g
bmV4dCBwdWxsIHJlcXVlc3QuDQoNClRoYW5rcywNCg0KQW51ag0KDQo=
