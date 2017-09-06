Return-Path: <prvs=415dbfde3=Mikko.Rapeli@bmw.de>
Received: from esa2.bmw.c3s2.iphmx.com (esa2.bmw.c3s2.iphmx.com
	[68.232.133.169])
	by mail.openembedded.org (Postfix) with ESMTP id 772F271D97
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1504714565; x=1536250565;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=TEZ5m5v/a/6uzdelROM/3EfWQ/m3YT/sqSqenLucQa8=;
	b=fpiAMhEazLDWayF+upJvAOk3uxkHJ+6v/ILGXXY87olEvNfJjk1Hmxkn
	BLvo13fzp4H2jjvmG6JnKoUZUGNIIxcXe5h+LbyKAVT81J5sqwawj0fO0
	MiDQDNYf0BuUuz0VFbPPY5snKVB4cHvBE5uQMPPnk2S6of8Z8K8wkCu7I E=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
	esa2.bmw.c3s2.iphmx.com with ESMTP/TLS; 06 Sep 2017 18:16:03 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw6.muc with ESMTP/TLS;
	06 Sep 2017 18:16:03 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp)
	([160.48.96.47])
	by esabb3.muc with ESMTP/TLS; 06 Sep 2017 18:16:03 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10k.europe.bmw.corp
	(160.48.96.47) with Microsoft SMTP Server (TLS;
	Wed, 6 Sep 2017 18:16:02 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1320.000;
	Wed, 6 Sep 2017 18:16:02 +0200
From: <Mikko.Rapeli@bmw.de>
To: <mark.hatle@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK
	during do_unpack
Thread-Index: AQHTJwxiYwJLU+ClSE2tjwTzRY8twKKn2MQAgAAGf4CAAAGQAIAABmoA
Date: Wed, 6 Sep 2017 16:16:02 +0000
Message-ID: <20170906161602.5bqda6gbuduf2aht@hiutale>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
	<CABcZANnvs4pZ5Ziuh3zNJjy1vbO4mk14+VNyOw_XaQnN+E0YFQ@mail.gmail.com>
	<20170906154729.hz4z5od5nc2g62ul@hiutale>
	<5d06b973-f7ca-f900-fa95-8afcbb789e95@windriver.com>
In-Reply-To: <5d06b973-f7ca-f900-fa95-8afcbb789e95@windriver.com>
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
X-List-Received-Date: Wed, 06 Sep 2017 16:16:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9BE1F361AF4B74BBE82DC445F2839F3@bmwmail.corp>
Content-Transfer-Encoding: base64

T24gV2VkLCBTZXAgMDYsIDIwMTcgYXQgMTA6NTM6MDRBTSAtMDUwMCwgTWFyayBIYXRsZSB3cm90
ZToNCj4gT24gOS82LzE3IDEwOjQ3IEFNLCBNaWtrby5SYXBlbGlAYm13LmRlIHdyb3RlOg0KPiA+
IE9uIFdlZCwgU2VwIDA2LCAyMDE3IGF0IDA4OjI0OjE0QU0gLTA3MDAsIENocmlzdG9waGVyIExh
cnNvbiB3cm90ZToNCj4gPj4gT24gV2VkLCBTZXAgNiwgMjAxNyBhdCA1OjMzIEFNLCBNaWtrbyBS
YXBlbGkgPG1pa2tvLnJhcGVsaUBibXcuZGU+IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gJ2dpdCBzdWJt
b2R1bGUgdXBkYXRlIC0taW5pdCAtcmVjdXJzaXZlJyB3aWxsIGNsb25lIHJlbW90ZSByZXBvc2l0
b3JpZXMNCj4gPj4+IGlmIGxvY2FsIHRyZWUgZG9lcyBub3QgaGF2ZSB0aGUgcmVmZXJlbmNlZCBj
b21taXRzLiBBZGQgLS1uby1mZXRjaA0KPiA+Pj4gdG8gZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgaWYg
QkJfTk9fTkVUV09SSyBpcyBkZWZpbmVkIGFuZCBvbmx5IGxvY2FsDQo+ID4+PiBkb3dubG9hZCBj
YWNoZXMgc2hvdWxkIGJlIHVzZWQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWlra28g
UmFwZWxpIDxtaWtrby5yYXBlbGlAYm13LmRlPg0KPiA+Pj4NCj4gPj4NCj4gPj4gSWYgd2XigJly
ZSB1bnBhY2tpbmcsIHRoZXJl4oCZcyBubyByZWFzb24gdG8gYmUgY29udGFjdGluZyBhbnl0aGlu
ZyByZW1vdGUNCj4gPj4gcmVnYXJkbGVzcyBvZiB0aGUgdmFsdWUgb2YgQkJfTk9fTkVUV09SSy4g
V2Ugc2hvdWxkIGJlIHBhc3Npbmcg4oCUbm8tZmV0Y2gNCj4gPj4gYWxsIHRoZSB0aW1lLiBXZSBh
bHNvIG5lZWQgdG8gYmUgcnVubmluZyBhIHN1Ym1vZHVsZSBzeW5jIHRvIHVwZGF0ZSBhbnkNCj4g
Pj4gY2hhbmdlcyB1cmxzIGluIHRoZSBzdWJtb2R1bGUgcmVtb3RlcywgYnV0IHRoZXJlIGFyZSBv
dGhlciBpc3N1ZXMgdG8gYmUNCj4gPj4gcmVzb2x2ZWQgYmV5b25kIHRoYXQuDQo+ID4gDQo+ID4g
WWVzLCBJIHRob3VnaHQgYWJvdXQgdGhpcyBidXQgZGVjaWRlZCBub3QgdG8gY2hhbmdlIGN1cnJl
bnQgYmVoYXZpb3IuDQo+ID4gU2hvdWxkIGhhdmUgbWVudGlvbmVkIHRoYXQgaW4gdGhlIGNvbW1p
dCBtZXNzYWdlLg0KPiA+IA0KPiA+IEkgY2FuIHNlbmQgYSBuZXcgdmVyc2lvbiB3aGVyZSAtLW5v
LWZldGNoIGlzIHRoZSBkZWZhdWx0IGJ1dCBpdCBtaWdodCBicmVhaw0KPiA+IGluIHNvbWUgc2V0
dXBzLCBlc3BlY2lhbGx5IHdoZW4gdGhlIERMX0RJUiBjYWNoZSBpcyBub3QgdXNlZCBmb3Igc3Vi
bW9kdWxlcy4uLg0KPiANCj4gKHdpdGhvdXQgdHJ1ZWx5IHVuZGVyc3RhbmRpbmcgdGhlIHJhbWlm
aWNhdGlvbnMpLCBJIHdvdWxkIHByZWZlciB0aGUgc3lzdGVtIHRvDQo+IGZhaWwgd2l0aCBhbiBl
cnJvciB0aGVuIGF0dGVtcHQgdG8gY29udGFjdCBhIG5ldHdvcmsgcmVzb3VyY2VzIGlmIEJCX05P
X05FVFdPUksNCj4gaXMgc2V0Lg0KDQpZZXMsIHRoYXQgaXMgY2xlYXIuIFRoZSBjb21tZW50IGZy
b20gQ2hyaXN0b3BoZXIgd2FzIGFib3V0IHVzaW5nIC0tbm8tZmV0Y2gNCmJ5IGRlZmF1bHQgaW4g
ZG9fdW5wYWNrIGFsc28gZm9yIGJ1aWxkcyB3aXRoIG5ldHdvcmsgY29ubmVjdGl2aXR5Lg0KDQpU
aGlzIGNvdWxkIHdvcmsgZm9yIGZyZXNoIGNsb25lcyBvZiB0aGUgc291cmNlIHRyZWUgd2hpY2gg
Y2FsbCBkb3dubG9hZA0KLT4gdXBkYXRlX3N1Ym1vZHVsZXMgLT4gImdpdCBzdWJtb2R1bGUgdXBk
YXRlIC0taW5pdCAtLXJlY3Vyc2l2ZSIuIFRoZW4gdGhlDQp0cmVlIHdvdWxkIGJlIGNvcGllZCB0
byBETF9ESVIgY2FjaGUuDQoNCkEgc3Vic2VxdWVudCB1cGRhdGUgdG8gdGhlIHJlY2lwZSB3b3Vs
ZCBleHRyYWN0IHRoZSByZXBvIGZyb20gRExfRElSIGFuZA0KY2FsbCB1bnBhY2sgd2hpY2ggd291
bGQgY2FsbCBvbmx5ICJnaXQgc3VibW9kdWxlIHVwZGF0ZSAtLW5vLWZldGNoIC0taW5pdA0KLS1y
ZWN1cnNpdmUiLg0KDQpUaGlzIHdvdWxkIHdvcmsgaWYgYW55IHJlY2lwZSBjaGFuZ2VzIHdoaWNo
IHVwZGF0ZSB0aGUgY29tbWl0IGhhcyBhbHNvIGNhbGwNCmZldGNoIG9uIHRoZSBiYXNlIHJlcG8g
KGJpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkgPykgYW5kIGRvd25sb2FkDQpmcm9tIGdpdHNt
LnB5IHdoaWNoIHdvdWxkIGNhbGwgdXBkYXRlX3N1Ym1vZHVsZXMgLT4NCiJnaXQgc3VibW9kdWxl
IHVwZGF0ZSAtLWluaXQgLS1yZWN1cnNpdmUiLg0KDQpEaWQgSSBtaXNzIHNvbWV0aGluZz8gQXJl
IHRoZXJlIHNvbWUgdGVzdHMgZm9yIGdpdHNtLnB5IGFscmVhZHk/DQoNCj4gQW4gZXJyb3IgKHdp
dGggYSByZXNvbHV0aW9uIG9mIHNvbWVob3cgZ2V0dGluZyB0aGUgaXRlbSBsb2NhbCBlaXRoZXIg
aW4gdGhlDQo+IERMX0RJUiBvciBhIGZpbGU6Ly8gbWlycm9yIHNlZW1zIGxpa2UgdGhlIGJlc3Qg
YWx0ZXJuYXRpdmUgZm9yIGEgdXNlciB3aG8gbmVlZHMNCj4gdG8gcHJldmVudCBuZXR3b3JrIGFj
Y2Vzcy4NCg0KQW5kIHRoaXMgaXMgd2hlcmUgdGhlIGRlcGVuZGVuY3kgdG8gdXNpbmcgRExfRElS
IGNhY2hlIGZvciBnaXQgc3VibW9kdWxlcw0KYW5kIGZpcnN0IHBhdGNoIGluIHRoZSBzZXJpZXMg
YmVjb21lcyBpbnRvIHBsYXkuLi4NCg0KLU1pa2tv

