Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7656071D9E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 17:08:28 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP; 13 Jan 2017 09:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,222,1477983600"; d="scan'208";a="52678187"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by orsmga005.jf.intel.com with ESMTP; 13 Jan 2017 09:08:07 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
	ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Fri, 13 Jan 2017 09:08:07 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
	ORSMSX155.amr.corp.intel.com ([169.254.7.181]) with mapi id
	14.03.0248.002; Fri, 13 Jan 2017 09:08:06 -0800
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] cookerdata.py: check for existence of configuration files
Thread-Index: AQHSbS3MF4OkEWe6YkOBLLR06o+YVaE2wqMA///esFCAAIkOAP//ejJA
Date: Fri, 13 Jan 2017 17:08:06 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118F34D4@ORSMSX112.amr.corp.intel.com>
References: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
	<1484304882.4367.252.camel@linuxfoundation.org>
	<6E51916E4A1F32428260031F4C7CD2B6118F34AD@ORSMSX112.amr.corp.intel.com>
	<1484327160.4367.258.camel@linuxfoundation.org>
In-Reply-To: <1484327160.4367.258.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>
Subject: Re: [PATCH] cookerdata.py: check for existence of configuration files
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
X-List-Received-Date: Fri, 13 Jan 2017 17:08:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWxsIHJpZ2h0LCBJJ2xsIGdldCBvbiBpdCB0aGVuLi4uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBQdXJkaWUgW21haWx0bzpyaWNoYXJkLnB1cmRpZUBs
aW51eGZvdW5kYXRpb24ub3JnXQ0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTMsIDIwMTcgOTow
NiBBTQ0KPiBUbzogQnlzdHJpY2t5LCBKdXJvIDxqdXJvLmJ5c3RyaWNreUBpbnRlbC5jb20+OyBi
aXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBqdXJvYnlzdHJp
Y2t5QGhvdG1haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNvb2tlcmRhdGEucHk6IGNo
ZWNrIGZvciBleGlzdGVuY2Ugb2YgY29uZmlndXJhdGlvbg0KPiBmaWxlcw0KPiANCj4gT24gRnJp
LCAyMDE3LTAxLTEzIGF0IDE3OjAxICswMDAwLCBCeXN0cmlja3ksIEp1cm8gd3JvdGU6DQo+ID4g
SSBzZWUgeW91ciBwb2ludC4gVGhlIHJvdXRlIHZpYSBhIGR1bW15IGRlZmF1bHQuY29uZiB3b3Vs
ZCByZXF1aXJlDQo+ID4gaGF2aW5nDQo+ID4gdGhlIGZvbGRlciBjb25mL211bHRpY29uZmlnIHBy
ZXNlbnQgZXZlbiBmb3IgdXNlcnMgbm90IHJlYWxseQ0KPiA+IGludGVyZXN0ZWQgaW4NCj4gPiBt
dWx0aWNvbmZpZy4gTm90IGEgc2hvdyBzdG9wcGVyLCBpdCB3b3VsZCBiZSBqdXN0IGFub3RoZXIg
ZmlsZQ0KPiA+IGNyZWF0ZWQgYnkNCj4gPiBvZS1pbml0LWJ1aWxkLWVudi4gKEFub3RoZXIgcG9z
c2liaWxpdHkgaXMgdG8gaGF2ZSB0aGUgZXJyb3IgY2hlY2sgYXMNCj4gPiBwYXJ0DQo+ID4gb2Yg
c2FuaXR5IGNoZWNraW5nKQ0KPiANCj4gV2UgY2FuIHB1dCB0aGlzIGluIG1ldGEvY29uZi9tdWxp
dGNvbmZpZywgaXQgZG9lc24ndCBoYXZlIHRvIGJlIGluIHRoZQ0KPiBidWlsZCBkaXJlY3Rvcnku
DQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQo=

