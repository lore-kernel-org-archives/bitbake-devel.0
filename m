Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RsOoP-0004Kg-D1
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 02:16:37 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 31 Jan 2012 17:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="102453827"
Received: from pgsmsx603.gar.corp.intel.com ([10.221.43.87])
	by orsmga001.jf.intel.com with ESMTP; 31 Jan 2012 17:08:41 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	pgsmsx603.gar.corp.intel.com (10.221.43.87) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 1 Feb 2012 09:08:19 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Wed, 1 Feb 2012 09:08:17 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: Khem Raj <raj.khem@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] prserv: Do not ping PRService if
	not required
Thread-Index: AQHM4C33Wf5ZoHknOUmWnI9GxDooTZYnOsYQ
Date: Wed, 1 Feb 2012 01:08:17 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FCDFC2E@SHSMSX102.ccr.corp.intel.com>
References: <cover.1327990542.git.lianhao.lu@intel.com>
	<fe0512a8af642c0b23a9fbbb6aa82953b9e17313.1327990542.git.lianhao.lu@intel.com>
	<CAMKF1spcm_oavug_GV15uwnjGcc-saa=xeCxa1mocEMy4iBt9A@mail.gmail.com>
In-Reply-To: <CAMKF1spcm_oavug_GV15uwnjGcc-saa=xeCxa1mocEMy4iBt9A@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] prserv: Do not ping PRService if not required
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
X-List-Received-Date: Wed, 01 Feb 2012 01:16:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

S2hlbSBSYWogd3JvdGUgb24gMjAxMi0wMS0zMToNCj4gT24gTW9uLCBKYW4gMzAsIDIwMTIgYXQg
MTA6MTggUE0sIExpYW5oYW8gTHUgPGxpYW5oYW8ubHVAaW50ZWwuY29tPiB3cm90ZToNCj4+IFtZ
T0NUTyAjMTk0Ml0NCj4+IFBpbmcgdGhlIFBSU2VydmljZSBvbmx5IGlmIFBSU0VSVl9IT1NUIGFu
ZCBQUlNFUlZfUE9SVCBhcmUgc2V0Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuaGFvIEx1
IDxsaWFuaGFvLmx1QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gwqBiaXRiYWtlL2xpYi9wcnNlcnYv
c2Vydi5weSB8IMKgIMKgMiArLQ0KPj4gwqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL3Byc2Vy
di9zZXJ2LnB5IGIvYml0YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkNCj4+IGluZGV4IGZhNDM3Zjku
LjU1NjdjNmYgMTAwNjQ0DQo+PiAtLS0gYS9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weQ0KPj4g
KysrIGIvYml0YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkNCj4+IEBAIC0yNjgsNyArMjY4LDcgQEAg
ZGVmIGlzX2xvY2FsX3NwZWNpYWwoaG9zdCwgcG9ydCk6DQo+PiANCj4+IMKgZGVmIGF1dG9fc3Rh
cnQoZCk6DQo+PiDCoCDCoCBnbG9iYWwgc2luZ2xldG9uDQo+PiAtIMKgIMKgaWYgZC5nZXRWYXIo
J1VTRV9QUl9TRVJWJywgVHJ1ZSkgPT0gJzAnOg0KPj4gKyDCoCDCoGlmIChub3QgZC5nZXRWYXIo
J1BSU0VSVl9IT1NUJywgVHJ1ZSkpIG9yIChub3QgZC5nZXRWYXIoJ1BSU0VSVl9QT1JUJywgVHJ1
ZSkpOg0KPg0KPiANCj4gc2hvdWxkIGl0IHdhcm4gaW4gY2FzZSB3aGVuIFVTRV9QUl9TRVJWIGlz
IHNldCBidXQgb25lIG9mIFBSU0VSVl9IT1NUDQo+IG9yIFBSU0VSVl9QT1JUIGFyZSB1bnNldA0K
DQpVU0VfUFJfU0VSViB3aWxsIGFsc28gYmUgc2V0IGlmIFBSU0VSVl9MT0NLRE9XTiBpcyBzZXQg
aW4gdGhlIGNhc2Ugb2YgcmVsZWFzZSAnbG9ja2Rvd24nLg0KDQo+PiDCoCDCoCDCoCDCoCByZXR1
cm4gVHJ1ZQ0KPj4gDQo+PiDCoCDCoCBpZiBpc19sb2NhbF9zcGVjaWFsKGQuZ2V0VmFyKCdQUlNF
UlZfSE9TVCcsIFRydWUpLCBpbnQoZC5nZXRWYXIoJ1BSU0VSVl9QT1JUJywgVHJ1ZSkpKSBhbmQg
bm90IHNpbmdsZXRvbjoNCj4+IC0tDQo+PiAxLjcuMC40DQo+PiANCj4+IA0KPj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGJpdGJha2UtZGV2ZWwg
bWFpbGluZyBsaXN0DQo+PiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4+
IGh0dHA6Ly9saXN0cy5saW51eHRvZ28ub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9iaXRi
YWtlLWRldmVsDQoNCg==


