Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id DF60073057
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Feb 2017 08:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id F0C052E3D7;
	Mon, 27 Feb 2017 09:22:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id a8TkCkgHFOIz; Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bes.se.axis.com (Postfix) with ESMTPS id 83F4E2E3D1;
	Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BEFA1E064;
	Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C851E060;
	Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 54D8320A;
	Mon, 27 Feb 2017 09:22:01 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Mon, 27 Feb 2017 09:22:01 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Mon, 27 Feb 2017 09:22:01 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] Make use of the new
	bb.utils.filter() function
Thread-Index: AQHSjuaJ2VcN/lblLUKpMcSCDRUEnqF8huhA
Date: Mon, 27 Feb 2017 08:22:01 +0000
Message-ID: <c4c76fdf78db42fd8160c7350436d3af@XBOX02.axis.com>
References: <cover.1487690243.git.pkj@axis.com>
	<00321a9f25646b839353eca39092ac2d0a2da225.1487690243.git.pkj@axis.com>
	<1487971470.30253.14.camel@linuxfoundation.org>
In-Reply-To: <1487971470.30253.14.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 2/2] Make use of the new bb.utils.filter() function
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
X-List-Received-Date: Mon, 27 Feb 2017 08:22:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSBbbWFp
bHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IGRlbiAyNCBm
ZWJydWFyaSAyMDE3IDIyOjI1DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQ7IGJpdGJha2UtZGV2
ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxd
IFtQQVRDSCAyLzJdIE1ha2UgdXNlIG9mIHRoZSBuZXcNCj4gYmIudXRpbHMuZmlsdGVyKCkgZnVu
Y3Rpb24NCj4gDQo+IE9uIFR1ZSwgMjAxNy0wMi0yMSBhdCAxNjoxOSArMDEwMCwgUGV0ZXIgS2pl
bGxlcnN0ZWR0IHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEtqZWxsZXJzdGVkdCA8
cGV0ZXIua2plbGxlcnN0ZWR0QGF4aXMuY29tPg0KPiANCj4gVGhpcyByZWFsbHkgbmVlZHMgdG8g
Z28gdG8gdGhlIG9wZW5lbWJlZGRlZC1jb3JlIGxpc3QuIEl0IGFsc28gbWVhbnMgd2UNCj4gaGF2
ZSB0byBidW1wIHRoZSBtaW5pbXVtIGJpdGJha2UgdmVyc2lvbi4gSSBoYXZlIHF1ZXVlZCB0aGlz
IGluIG1hc3Rlci0NCj4gbmV4dCBhbG9uZyB3aXRoIGEgdmVyc2lvbiBidW1wLg0KPiANCj4gU2lu
Y2UgT0UtQ29yZSBkb2VzIGNoYW5nZSBxdWl0ZSBxdWlja2x5IGFuZCB0aGVyZSBoYXZlIGJlZW4g
Y2hhbmdlcywNCj4gdGhlIHBhdGNoIGFsc28gZGlkbid0IDEwMCUgYXBwbHkuIENvdWxkIHlvdSBj
aGVjayBmb3IgdGhlIHJlY2lwZXMgd2hlcmUNCj4gdGhlIGNoYW5nZXMgZGlkbid0IGFwcGx5IGFu
ZCBzZW5kIGFuIHVwZGF0ZWQgYWdhaW5zdCBtYXN0ZXItbmV4dCB0byB0aGUNCj4gb2UtY29yZSBs
aXN0IHBsZWFzZT8NCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0KSSB3aWxsIHNlbmQg
YW4gdXBkYXRlZCB2ZXJzaW9uIHRvIHRoZSBPRS1Db3JlIGxpc3QuDQoNCi8vUGV0ZXINCg0K

