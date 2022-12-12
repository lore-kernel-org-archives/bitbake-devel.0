Return-Path: <S.Mueller-Klieser@phytec.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE732C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 11:33:29 +0000 (UTC)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 by mx.groups.io with SMTP id smtpd.web11.40842.1670844801018876265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 03:33:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@phytec.de header.s=a4 header.b=SY/RCRBb;
 spf=pass (domain: phytec.de, ip: 91.26.50.163, mailfrom: s.mueller-klieser@phytec.de)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1670844798; x=1673436798;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mMUqmqEhufGyk33leHYnF7N2d34/7pjajxoETRA/jIk=;
	b=SY/RCRBb7pNdZELVS/1PlHwzRmy9NIYv+WuPHZQXr7n956VR0rgs05OCgzmcN1WX
	1nX/ABO6ycwQ72/R1azEBmretnYy8CFKhRq9384buz6gofQW9iRhQjQr4Dibsu1T
	Scbk2Xw88OIumI/JVzm38V4TEOlTQGBN2jALVWZKlDU=;
X-AuditID: ac14000a-83bf370000003940-74-6397117d8c19
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E0.3C.14656.D7117936; Mon, 12 Dec 2022 12:33:17 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 12 Dec
 2022 12:33:17 +0100
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 12 Dec 2022 12:33:17 +0100
From: =?utf-8?B?U3RlZmFuIE3DvGxsZXItS2xpZXNlcg==?=
	<S.Mueller-Klieser@phytec.de>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Ensure layers use
 LAYERSERIES_COMPAT fairly
Thread-Topic: [bitbake-devel] [PATCH] cookerdata: Ensure layers use
 LAYERSERIES_COMPAT fairly
Thread-Index: AQHZCjpZrtTmL7HvLU6UbbRFvH7Saq5lV4QAgAAH+oCABLYiAA==
Date: Mon, 12 Dec 2022 11:33:17 +0000
Message-ID: <a98b447a4e7e4c5503760177ce50c564fb1e0d35.camel@phytec.de>
References: <20221207124913.2108579-1-richard.purdie@linuxfoundation.org>
	 <34f25e412b1d1f277e3f5e0915106f07ab0387b8.camel@phytec.de>
	 <36bdfd79eb715671f4e298b3ab5004a986ff8394.camel@linuxfoundation.org>
In-Reply-To: <36bdfd79eb715671f4e298b3ab5004a986ff8394.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B1556602C87C4D89E2D19DF0711E50@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWyRpKBT7dWcHqywa7f1hbXj4Za/Hg2kdWB
	yWP/3DXsHuc2rmAMYIrisklJzcksSy3St0vgypj73bFgj2rF30PLGRsYD6h0MXJySAiYSGzr
	bGAFsYUE1jJJXJjm3cXIBWQ/YZT49PwzM4SzkVHi+J09bF2MHBxsAkESm74Lg8RFBOYxSuyZ
	u4oJpFtYIE7i5qkWdhBbRCBeYtf7B2wQtpNE35rljCA2i4CqxPIz7Ywgc3gF3CRmnCuCWHye
	UeL2UgUQm1MgUGLznPnMIDajgKzEhg3nwWxmAXGJTc++s0IcLSCxZA9EXEJAVOLl439QcXmJ
	E7emMYGMZxbQlFi/Sx+i1ULi+YHt7BC2osSU7odgNq+AoMTJmU9YJjCKzUKyYRZC9ywk3bOQ
	dM9C0r2AkXUVo1BuZnJ2alFmtl5BRmVJarJeSuomRlAkiTBw7WDsm+NxiJGJg/EQowQHs5II
	r6rGtGQh3pTEyqrUovz4otKc1OJDjNIcLErivPd7mBKFBNITS1KzU1MLUotgskwcnFINjO5F
	5VcW9Pukb5mo430lakLnuevO8yurZV88ior+f9qUeVrI119/A5da5f2/zu8aJb3V6KCS9P+U
	OX+dtp6peML9ZFP3WqcQvgud3mwab/7Zi7z3Tju/Su/unk2y8b1xN9Y+Z+e+mqiocCNac8d/
	hVVhbgosec0v46YWyTCumvosiyVe8sH1E0osxRmJhlrMRcWJAJwl/1OSAgAA
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 11:33:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14180

QW0gRnJlaXRhZywgZGVtIDA5LjEyLjIwMjIgdW0gMTE6MzUgKzAwMDAgc2NocmllYiBSaWNoYXJk
IFB1cmRpZToNCj4gSGkgU3RlZmFuLA0KPiANCj4gT24gRnJpLCAyMDIyLTEyLTA5IGF0IDExOjA3
ICswMDAwLCBTdGVmYW4gTcO8bGxlci1LbGllc2VyIHdyb3RlOg0KPiA+IEFtIE1pdHR3b2NoLCBk
ZW0gMDcuMTIuMjAyMiB1bSAxMjo0OSArMDAwMCBzY2hyaWViIFJpY2hhcmQgUHVyZGllOg0KPiA+
ID4gPiBTb21lIGxheWVycyB0aGluayB0aGV5J3JlIGdvaW5nIHRvIGJlICdjbGV2ZXInIGFuZCBj
b3B5IHRoZSB2YWx1ZXMgZnJvbQ0KPiA+IA0KPiA+IGFzIEkgYW0gb25lIG9mIHRob3NlICJjbGV2
ZXIiIGd1eXMuLi4NCj4gDQo+IE9uZSBvZiB0aGVtLCB5ZXMuIFlvdSdyZSBub3QgdGhlIG9ubHkg
b25lcyBhbmQgdGhlIHdpZGVzcHJlYWQgYWRvcHRpb24NCj4gb2YgdGhpcyB3YXMgYSBiaWcgcGFy
dCBvZiB0aGUgY29uY2Vybi4NCj4gDQo+ID4gDQo+ID4gPiA+IGFub3RoZXIgbGF5ZXIsIGUuZy4g
dXNpbmcgJHtMQVlFUlNFUklFU19DT01QQVRfY29yZX0uIFRoZSB3aG9sZSBwb2ludCBvZg0KPiA+
ID4gPiB0aGlzIG1lY2hhbmlzbSBpcyB0byBtYWtlIGl0IGNsZWFyIHdoaWNoIHJlbGVhc2VzIGEg
bGF5ZXIgc3VwcG9ydHMgYW5kDQo+ID4gDQo+ID4gRllJIHdlICJkaXNhYmxlZCIgdGhlIG1lY2hh
bmlzbSBiZWNhdXNlIGl0cyBub3QgaGVscGluZyB1cy4gU3VwcG9ydCBmb3IgdXMNCj4gPiBtZWFu
cyBjb21taXQgbGV2ZWwgdmVyaWZpY2F0aW9uIGZvciBodytzdywgc28gd2UgaGFkIHRvIGltcGxl
bWVudCBzb21ldGhpbmcNCj4gPiBlbHNlIGFueXdheS4NCj4gDQo+IFdoYXQgeW91IGRpZCB3YXMg
cmVtb3ZlIHRoZSBpbmRpY2F0aW9ucyBvZiB3aGljaCByZWxlYXNlcyB5b3VyDQo+IGxheWVyL2Jy
YW5jaCB3YXMgY29tcGF0aWJsZSB3aXRoLiBJIHVuZGVyc3RhbmQgeW91IG1heSB3YW50IHRvIGRv
IG90aGVyDQo+IHRoaW5ncyBhcyB3ZWxsIGJ1dCBieXBhc3NpbmcgdGhlIGNoZWNrcyByZWFsbHkg
aXNuJ3QgaW4gdGhlIHNwaXJpdCBvZg0KPiB3aGF0IHdlIHdlcmUgdHJ5aW5nIHRvIGRvLg0KPiAN
Cj4gPiA+ID4gc2hvdyB3aGVuIGEgbGF5ZXIgbWFzdGVyIGJyYW5jaCBpcyBiaXRyb3R0aW5nIGFu
ZCBpcyB1bm1haW50YWluZWQuDQo+ID4gDQo+ID4gSSB1bmRlcnN0YW5kIHRoZSBhcmd1bWVudCBl
c3BlY2lhbGx5IGZvciBtYXN0ZXINCj4gDQo+IFRoZXJlIGFyZSBhIGxvdCBvZiBsYXllcnMgb3V0
IHRoZXJlIHdoaWNoIGl0IGlzIHVuY2xlYXIgd2hhdCB0aGV5J3JlDQo+IGNvbXBhdGlibGUgd2l0
aCBhbmQgSSBkbyB0aGluayBoYXZpbmcgbGF5ZXJzIGNsZWFybHkgaW5kaWNhdGUNCj4gY29tcGF0
aWJpbGl0eSAob3Igbm90KSB3aXRoIGEgZ2l2ZW4gcmVsZWFzZSBzZXJpZXMgaXMgYSBnb29kIHRo
aW5nLg0KPiANCj4gPiA+ID4gVGhlcmVmb3JlIGFkZCBzb21lIGNvZGUgdG8gYXZvaWQgcGVvcGxl
IGRvaW5nIHRoaXMuIEkgd2lzaCB3ZSBkaWRuJ3QgaGF2ZQ0KPiA+ID4gPiB0byBidXQuLi4NCj4g
PiANCj4gPiBJIGp1c3Qgbm90aWNlZCBpbiB0aGUgZG9jdW1lbnRhdGlvbiB0aGUgcmVxdWlyZW1l
bnQgZm9yIGxheWVyDQo+ID4gY29tcGF0aWJsZSAyLjAsIGVuZm9yY2luZyB0aGF0IG1lY2hhbmlz
bS4gSSB3aWxsIGZpeCBpdCBhc2FwLg0KPiA+IA0KPiA+IEFzLCBJIGd1ZXNzLCB0aGVyZSBhcmUg
bW9yZSBjYXNlcyBsaWtlIHRoYXQgaW4gb3VyIGxheWVyLCBmb3INCj4gPiB0aGUgZnV0dXJlLCBp
bnN0ZWFkIG9mIGVuZm9yY2luZyBydWxlcyBvbiB0aGUgY29kZSBsZXZlbCwgaXQgd291bGQNCj4g
PiBoZWxwIHVzIG1vcmUgdG8gbWFrZSB0aGUgeW9jdG8gY29tcGF0aWJpbGl0eSBsYXllciBwcm9n
cmFtIG1vcmUNCj4gPiBhY2Nlc3NpYmxlLiBJIHRyaWVkIHNldmVyYWwgdGltZXMgb24gdGhlIG1h
bmFnZW1lbnQgbGV2ZWwgdG8NCj4gPiBnZXQgaW50byB0aGUgcHJvZ3JhbSwgd2l0aG91dCBzdWNj
ZXNzLiBPdXIgY29tcGFueSBkaWQNCj4gPiBub3QgZml0IGludG8gdGhlIGV4aXN0aW5nIGNhdGVn
b3JpZXMuIElmIHlvdSBoYXZlIGFuIGlkZWEgaW4gdGhhdA0KPiA+IGRpcmVjdGlvbiwgYSBQTSB3
b3VsZCBiZSBhcHByZWNpYXRlZC4NCj4gDQo+IFRvIHVzZSB0aGUgWW9jdG8gUHJvamVjdCBDb21w
YXRpYmxlIGJyYW5kaW5nL2JhZGdlIHlvdSBuZWVkIHRvIGJlIGENCj4gbWVtYmVyIGhvd2V2ZXIg
eW91IGRvIG5vdCBuZWVkIHRvIGJlIGEgbWVtYmVyIHRvIHJ1biB0aGUgeW9jdG8tY2hlY2stDQo+
IGxheWVyIHNjcmlwdCB5b3Vyc2VsZi4gWW91IGNhbiBzYXkgdGhhdCB0aGUgc2NyaXB0IHBhc3Nl
cywgb3IgdG8gcnVuIGl0DQo+IGluIGF1dG9tYXRlZCBDSSBhbmQgcHVibGlzaCB0aGUgcmVzdWx0
IHdpdGhvdXQgYW55IG1lbWJlcnNoaXANCj4gcmVxdWlyZW1lbnQuwqANCj4gDQo+IElzIHRoZXJl
IHNvbWV0aGluZyBlbHNlIHdlIHNob3VsZCBiZSBkb2luZyB0byBtYWtlIHRoaXMgbW9yZQ0KPiBh
Y2Nlc3NpYmxlPyBJJ2QgYmUgaW50ZXJlc3RlZCBpbiB3aGF0IG9wdGlvbnMgY291bGQgbWFrZSBt
ZW1iZXJzaGlwDQo+IG1vcmUgYXR0cmFjdGl2ZSB0byB5b3VyIG1hbmFnZW1lbnQgaWYgeW91IGhh
dmUgYW55IGlkZWFzLg0KDQpUaGFua3MsIFJpY2hhcmQuIEkganVzdCBsb29rZWQgdXAgdGhlIHJ1
bGVzIGFnYWluLiBPdXIgaXNzdWUgaXMgdGhhdCB3ZSBhcmUNCnRvbyBzbWFsbCBmb3IgYSBMRitZ
b2N0byBNZW1iZXJzaGlwLCBub3QgcGxheWluZyBpbiB0aGF0IGxlYWd1ZS4gVGhlIFlvY3RvDQpQ
YXJ0aWNpcGFudCBwcm9ncmFtIHdvdWxkIGJlIGEgcGVyZmVjdCBmaXQsIGJ1dCBpdHMgbGltaXRl
ZCB0byA4MCBlbXBsb3llZXMNCmZvciBhIGNvbXBhbnkuIFdlIGFyZSBhIHZlcnRpY2FsbHkgaW50
ZWdyYXRlZCBjb21wYW55IHdpdGggNDAwIHBlb3BsZSwgbW9zdA0Kd29ya2luZyBpbiBtYW51ZmFj
dHVyaW5nIHdpdGggYSBzbWFsbCBkZXZlbG9wbWVudCB0ZWFtIGZvY3VzZWQgb24gSFcuIFNvDQp3
ZSBmYWxsIGluIGJldHdlZW4gdGhlIGdhcCBwYXJ0aWNpcGFudC9zaWx2ZXIgbWVtYmVyIGFuZCBh
cmUgY3VycmVudGx5IG5vbmUuDQoNClNvbWV0aGluZyAib2ZmaWNpYWwiIGFuZCBiYWRnZXMgYXJl
IHJlYWxseSBpbXBvcnRhbnQgdG8gYWxsb2NhdGUgcmVzb3VyY2VzIGluDQphIGNvbXBhbnkuIFRo
ZXJlIG5lZWRzIHRvIGJlIGEgY29tbXVuaWNhdGlvbiBjaGFubmVsIHRvIHByb2R1Y3QgbWFuYWdl
bWVudC8NCm1hcmtldGluZyBzbyBpdCBkb2VzIG5vdCBlbmQgdXAgYmVpbmcgYSBob2JieSBwcm9q
ZWN0IGZvciBzb21lIGRldmVsb3BlcnMuDQoNCkFueSB3YXksIHdlIHRyeSBvdXIgYmVzdCB0byBr
ZWVwIHVwIHdpdGggdXBzdHJlYW0gZGV2ZWxvcG1lbnQuIFRoYW5rcw0KZm9yIHlvdSB3b3JrIGFu
ZCBsZXRzIHN0YXkgaW4gdG91Y2guDQoNClJlZ2FyZHMsIFN0ZWZhbg0KDQoNCj4gDQo+IENoZWVy
cywNCj4gDQo+IFJpY2hhcmQNCj4gDQo+IA0K

