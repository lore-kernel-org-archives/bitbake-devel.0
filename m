Return-Path: <prvs=415dbfde3=Mikko.Rapeli@bmw.de>
Received: from esa3.bmw.c3s2.iphmx.com (esa3.bmw.c3s2.iphmx.com
	[68.232.133.150])
	by mail.openembedded.org (Postfix) with ESMTP id D361771D97
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1504712857; x=1536248857;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=sNwBYcqnSXmrW4nlIEaFypNlv6MwqjZ5AJqaLWJsJYE=;
	b=IJnBzYbcxejm7WmuiyvdBvquELrMwuf7WWDBYFx/kXJVYoEKjnBXhvmo
	m7OREU4f2tnnJ7V6yWBzwRCqW3QN6IVVObnylcMnQHGn+RIPOCv5q/fTM
	a8S18LM/7pp6oSz4NZDxcvKLBXFkKhihQ4JuJGhk3nzMh+yzJv0T5H8Vc o=;
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
	esa3.bmw.c3s2.iphmx.com with ESMTP/TLS; 06 Sep 2017 17:47:35 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw2.muc with ESMTP/TLS;
	06 Sep 2017 17:47:35 +0200
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp)
	([160.48.96.46])
	by esabb3.muc with ESMTP/TLS; 06 Sep 2017 17:47:35 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10j.europe.bmw.corp
	(160.48.96.46) with Microsoft SMTP Server (TLS;
	Wed, 6 Sep 2017 17:47:34 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1320.000;
	Wed, 6 Sep 2017 17:47:34 +0200
From: <Mikko.Rapeli@bmw.de>
To: <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK
	during do_unpack
Thread-Index: AQHTJwxiYwJLU+ClSE2tjwTzRY8twKKn2MQAgAAGf4A=
Date: Wed, 6 Sep 2017 15:47:34 +0000
Message-ID: <20170906154729.hz4z5od5nc2g62ul@hiutale>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
	<CABcZANnvs4pZ5Ziuh3zNJjy1vbO4mk14+VNyOw_XaQnN+E0YFQ@mail.gmail.com>
In-Reply-To: <CABcZANnvs4pZ5Ziuh3zNJjy1vbO4mk14+VNyOw_XaQnN+E0YFQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.44.101]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK during do_unpack
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
X-List-Received-Date: Wed, 06 Sep 2017 15:47:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE04A6B92408043B89773AF02DAB8C4@bmwmail.corp>
Content-Transfer-Encoding: base64

T24gV2VkLCBTZXAgMDYsIDIwMTcgYXQgMDg6MjQ6MTRBTSAtMDcwMCwgQ2hyaXN0b3BoZXIgTGFy
c29uIHdyb3RlOg0KPiBPbiBXZWQsIFNlcCA2LCAyMDE3IGF0IDU6MzMgQU0sIE1pa2tvIFJhcGVs
aSA8bWlra28ucmFwZWxpQGJtdy5kZT4gd3JvdGU6DQo+IA0KPiA+ICdnaXQgc3VibW9kdWxlIHVw
ZGF0ZSAtLWluaXQgLXJlY3Vyc2l2ZScgd2lsbCBjbG9uZSByZW1vdGUgcmVwb3NpdG9yaWVzDQo+
ID4gaWYgbG9jYWwgdHJlZSBkb2VzIG5vdCBoYXZlIHRoZSByZWZlcmVuY2VkIGNvbW1pdHMuIEFk
ZCAtLW5vLWZldGNoDQo+ID4gdG8gZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgaWYgQkJfTk9fTkVUV09S
SyBpcyBkZWZpbmVkIGFuZCBvbmx5IGxvY2FsDQo+ID4gZG93bmxvYWQgY2FjaGVzIHNob3VsZCBi
ZSB1c2VkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlra28gUmFwZWxpIDxtaWtrby5yYXBl
bGlAYm13LmRlPg0KPiA+DQo+IA0KPiBJZiB3ZeKAmXJlIHVucGFja2luZywgdGhlcmXigJlzIG5v
IHJlYXNvbiB0byBiZSBjb250YWN0aW5nIGFueXRoaW5nIHJlbW90ZQ0KPiByZWdhcmRsZXNzIG9m
IHRoZSB2YWx1ZSBvZiBCQl9OT19ORVRXT1JLLiBXZSBzaG91bGQgYmUgcGFzc2luZyDigJRuby1m
ZXRjaA0KPiBhbGwgdGhlIHRpbWUuIFdlIGFsc28gbmVlZCB0byBiZSBydW5uaW5nIGEgc3VibW9k
dWxlIHN5bmMgdG8gdXBkYXRlIGFueQ0KPiBjaGFuZ2VzIHVybHMgaW4gdGhlIHN1Ym1vZHVsZSBy
ZW1vdGVzLCBidXQgdGhlcmUgYXJlIG90aGVyIGlzc3VlcyB0byBiZQ0KPiByZXNvbHZlZCBiZXlv
bmQgdGhhdC4NCg0KWWVzLCBJIHRob3VnaHQgYWJvdXQgdGhpcyBidXQgZGVjaWRlZCBub3QgdG8g
Y2hhbmdlIGN1cnJlbnQgYmVoYXZpb3IuDQpTaG91bGQgaGF2ZSBtZW50aW9uZWQgdGhhdCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UuDQoNCkkgY2FuIHNlbmQgYSBuZXcgdmVyc2lvbiB3aGVyZSAtLW5v
LWZldGNoIGlzIHRoZSBkZWZhdWx0IGJ1dCBpdCBtaWdodCBicmVhaw0KaW4gc29tZSBzZXR1cHMs
IGVzcGVjaWFsbHkgd2hlbiB0aGUgRExfRElSIGNhY2hlIGlzIG5vdCB1c2VkIGZvciBzdWJtb2R1
bGVzLi4uDQoNCi1NaWtrbw==

