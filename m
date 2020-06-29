Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web10.17974.1593435298340235437
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 05:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.100, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: xWU7GFLCn9iIbAfW5Gv/JusXTUfVYxRqNbok9QaLGv25r5i1H/lNWaBqm8ao/Aka4ot0UxlXtI
 Ws3BtT6v64Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211032670"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="211032670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 05:54:57 -0700
IronPort-SDR: LHXyCrG0RMBsorBmfDqAIEXmYwCLhKnUoi2DkdJ5j5BbXPafgesQLO4JP1N/GcprG7aYtY/+lt
 jCRE25MY994w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="454181610"
Received: from kmsmsx155.gar.corp.intel.com ([172.21.73.106])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2020 05:54:56 -0700
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.140]) by
 KMSMSX155.gar.corp.intel.com ([169.254.15.69]) with mapi id 14.03.0439.000;
 Mon, 29 Jun 2020 20:54:55 +0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: Switch from git.infradead.org to a YP mirror
Thread-Topic: [bitbake-devel] [PATCH] tests/fetch: Switch from
 git.infradead.org to a YP mirror
Thread-Index: AQHWSMy8uj7l2tAX40GEDnGheRCFi6jvEUCA
Date: Mon, 29 Jun 2020 12:54:54 +0000
Message-ID: <9fb2637ecedb143f09453529f4716ea8c64ccf19.camel@intel.com>
References: <20200622193832.571813-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20200622193832.571813-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.155.219]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE21FD0757FFC458813FF1818122850@intel.com>
Content-Transfer-Encoding: base64

SGkgUmljaGFyZA0KDQpPbiBNb24sIDIwMjAtMDYtMjIgYXQgMjA6MzggKzAxMDAsIFJpY2hhcmQg
UHVyZGllIHdyb3RlOg0KPiBVcHN0cmVhbSBpcyB1bmF2YWlsYWJsZSwgYnJlYWtpbmcgdGVzdHMu
IFN3aXRjaCB0byBhIFlQIG1pcnJvciBzaW5jZQ0KPiBpZiB3ZSBjYW4ndCByZWFjaCB0aGF0IHRo
ZXJlIGFyZSBiaWdnZXIgcHJvYmxlbXMuIFRoaXMgc2hvdWxkIHJlbW92ZQ0KPiBhIHNvdXJjZSBv
ZiBpbnRlcm1pdHRlbnQgZmFpbHVyZXMgb24gdGhlIGF1dG9idWlsZGVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQoNCkNvdWxkIHlvdSBwbGVhc2UgbWVyZ2UgdGhpcyBpbiAxLjQ0L3pldXMgYXMgd2VsbD8N
Cg0KVGhhbmtzLA0KDQpBbnVqDQoNCj4gLS0tDQo+ICBsaWIvYmIvdGVzdHMvZmV0Y2gucHkgfCAz
ICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9m
ZXRjaC5weQ0KPiBpbmRleCBkMGMxNjFhN2Y2Li40Njk3ZWY1OWI1IDEwMDY0NA0KPiAtLS0gYS9s
aWIvYmIvdGVzdHMvZmV0Y2gucHkNCj4gKysrIGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQo+IEBA
IC0xMTUyLDcgKzExNTIsOCBAQCBjbGFzcyBGZXRjaExhdGVzdFZlcnNpb25UZXN0KEZldGNoZXJU
ZXN0KToNCj4gICAgICAgICAgKCJteC0xLjAiLCAiZ2l0Oi8vZ2l0aHViLmNvbS9jbHV0dGVyLQ0K
PiBwcm9qZWN0L214LmdpdDticmFuY2g9bXgtMS40IiwNCj4gIjliMWRiNmI4MDYwYmQwMGIxMjFh
NjkyZjk0MjQwNGEyNGFlMjk2MGYiLCAiIikNCj4gICAgICAgICAgICAgIDogIjEuOTkuNCIsDQo+
ICAgICAgICAgICMgdmVyc2lvbiBwYXR0ZXJuICJ2WC5ZIg0KPiAtICAgICAgICAoIm10ZC11dGls
cyIsICJnaXQ6Ly9naXQuaW5mcmFkZWFkLm9yZy9tdGQtdXRpbHMuZ2l0IiwNCj4gImNhMzllYjFk
OThlNzM2MTA5YzY0ZmY5YzFhYTJhNmVjY2EyMjJkOGYiLCAiIikNCj4gKyAgICAgICAgIyBtaXJy
b3Igb2YgZ2l0LmluZnJhZGVhZC5vcmcgc2luY2UgbmV0d29yayBpc3N1ZXMNCj4gaW50ZXJmZXJl
ZCB3aXRoIHRlc3RpbmcNCj4gKyAgICAgICAgKCJtdGQtdXRpbHMiLCAiZ2l0Oi8vZ2l0LnlvY3Rv
cHJvamVjdC5vcmcvbXRkLXV0aWxzLmdpdCIsDQo+ICJjYTM5ZWIxZDk4ZTczNjEwOWM2NGZmOWMx
YWEyYTZlY2NhMjIyZDhmIiwgIiIpDQo+ICAgICAgICAgICAgICA6ICIxLjUuMCIsDQo+ICAgICAg
ICAgICMgdmVyc2lvbiBwYXR0ZXJuICJwa2dfbmFtZS1YLlkiDQo+ICAgICAgICAgICgicHJlc2Vu
dHByb3RvIiwNCj4gImdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2dpdC94b3JnL3Byb3Rv
L3ByZXNlbnRwcm90byIsDQo+ICIyNGYzYTU2ZTU0MWIwYTllNmM2ZWU3NjA4MWY0NDEyMjFhMTIw
ZWY5IiwgIiIpDQo+IA0K
