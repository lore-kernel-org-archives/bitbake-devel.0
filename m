Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1THXOr-00052a-Mk
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 12:02:25 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 28 Sep 2012 02:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,501,1344236400"; d="scan'208";a="150207731"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by AZSMGA002.ch.intel.com with ESMTP; 28 Sep 2012 02:49:30 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.138]) by
	IRSMSX104.ger.corp.intel.com ([169.254.5.154]) with mapi id
	14.01.0355.002; Fri, 28 Sep 2012 10:49:27 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH v2] hob/settings: implement a new tab
	in settings dialog to show SSTATE_MIRRORS
Thread-Index: AQHNm9PKBiOEmstTb0CteIzCyXakmZeeRToAgAE/uSA=
Date: Fri, 28 Sep 2012 09:49:24 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE19396846@IRSMSX101.ger.corp.intel.com>
References: <1348656248-5807-1-git-send-email-cristiana.voicu@intel.com>
	<1348760602.11186.4.camel@ted>
In-Reply-To: <1348760602.11186.4.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] hob/settings: implement a new tab in settings dialog to show SSTATE_MIRRORS
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
X-List-Received-Date: Fri, 28 Sep 2012 10:02:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgc2F3IHRoZSBjaGFuZ2VzIGluIGNvZGUgd2VyZSBtZXJnZWQsIGJ1dCBJIGhh
dmUgY2hhbmdlZCBhbHNvIDIgaW1hZ2VzKGJpdGJha2UvbGliL2JiL3VpL2ljb25zL2luZm8vaW5m
b19kaXNwbGF5LnBuZyAmIGJpdGJha2UvbGliL2JiL3VpL2ljb25zL2luZm8vaW5mb19ob3Zlci5w
bmcpLiBUaG9zZSBhcmUgbm90IGNoYW5nZWQgaW4gbWFzdGVyIG5vdy4NCg0KQ2FuIHlvdSBwbGVh
c2UgY2hlY2sgd2hhdCBoYXBwZW5lZD8NClRoYW5rIHlvdSwNCkNyaXN0aWFuYQ0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJkIFB1cmRpZSBbbWFpbHRvOnJpY2hh
cmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddIA0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAyNywgMjAxMiA2OjQzIFBNDQpUbzogVm9pY3UsIENyaXN0aWFuYQ0KQ2M6IGJpdGJha2UtZGV2
ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBb
UEFUQ0ggdjJdIGhvYi9zZXR0aW5nczogaW1wbGVtZW50IGEgbmV3IHRhYiBpbiBzZXR0aW5ncyBk
aWFsb2cgdG8gc2hvdyBTU1RBVEVfTUlSUk9SUw0KDQpPbiBXZWQsIDIwMTItMDktMjYgYXQgMTM6
NDQgKzAzMDAsIENyaXN0aWFuYSBWb2ljdSB3cm90ZToNCj4gQWRkIGEgbmV3IHRhYiB0byBzaG93
IGNvcnJlY3RseSBTU1RBVEVfTUlSUk9SUyB2YXJpYWJsZS4gTm93IHlvdSBjYW4gDQo+IGFkZCBu
ZXcgbWlycm9ycyBvciBkZWxldGUgbWlycm9yLiAiaW5mbyIgaW1hZ2Ugd2FzIGFsc28gY2hhbmdl
ZCggaXQgaXMgDQo+IHNtYWxsZXIsIHNvIGl0IGNhbiBiZSBuZXh0IHRvIGxhYmVscykuDQo+IEZy
b20gIkJ1aWxkIGVudmlyb25tZW50IiB0YWIsIFNTVEFURV9ESVIgYW5kIFNTVEFURV9NSVJST1JT
IHZhcnMgd2VyZSByZW1vdmVkLg0KPiANCj4gW1lPQ1RPICMyODkzXQ0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ3Jpc3RpYW5hIFZvaWN1IDxjcmlzdGlhbmEudm9pY3VAaW50ZWwuY29tPg0KPiAtLS0N
Cj4gIGJpdGJha2UvbGliL2JiL3VpL2NydW1icy9idWlsZGVyLnB5ICAgICAgICAgICB8ICAgIDgg
Ky0NCj4gIGJpdGJha2UvbGliL2JiL3VpL2NydW1icy9oaWcucHkgICAgICAgICAgICAgICB8ICAx
ODAgKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgYml0YmFrZS9saWIvYmIvdWkvY3J1bWJz
L2hvYmV2ZW50aGFuZGxlci5weSAgIHwgICAgNiArLQ0KPiAgYml0YmFrZS9saWIvYmIvdWkvY3J1
bWJzL3RlbXBsYXRlLnB5ICAgICAgICAgIHwgICAgMiArLQ0KPiAgYml0YmFrZS9saWIvYmIvdWkv
aWNvbnMvaW5mby9pbmZvX2Rpc3BsYXkucG5nIHwgIEJpbiA0NTU4IC0+IDQxMTcgYnl0ZXMNCj4g
IGJpdGJha2UvbGliL2JiL3VpL2ljb25zL2luZm8vaW5mb19ob3Zlci5wbmcgICB8ICBCaW4gNDY1
MCAtPiA0MTY3IGJ5dGVzDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspLCAy
MSBkZWxldGlvbnMoLSkNCg0KTWVyZ2VkIHRvIG1hc3RlciwgdGhhbmtzLg0KDQpSaWNoYXJkDQoN
Cg==


