Return-Path: <prvs=415dbfde3=Mikko.Rapeli@bmw.de>
Received: from esa1.bmw.c3s2.iphmx.com (esa1.bmw.c3s2.iphmx.com
	[68.232.133.201])
	by mail.openembedded.org (Postfix) with ESMTP id 8167B71D97
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1504712717; x=1536248717;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=CirPQ2doDwVk9fZ/0IIwkHmB7RMnSIjNyZfWkfRdPeg=;
	b=bETJc/cAwB1Asvt66POfLitpLBINPpTJ4jRFUVFzLM9ur9N08tiLwD4W
	fcsIoP+Uqd+vuDtJ/WvlWYJx7u/jP+MSHzub3hEI3Cwh2UHgMG/zapGE/
	0ePkEZ9HbSm7yosPYRd1zSjEAKu8o9O/DM0VsSK1SKFnqn6PDBE0gtxsl Y=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
	esa1.bmw.c3s2.iphmx.com with ESMTP/TLS; 06 Sep 2017 17:45:12 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
	06 Sep 2017 17:45:11 +0200
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp)
	([160.48.96.48])
	by esabb2.muc with ESMTP/TLS; 06 Sep 2017 17:45:11 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10l.europe.bmw.corp
	(160.48.96.48) with Microsoft SMTP Server (TLS;
	Wed, 6 Sep 2017 17:45:11 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1320.000;
	Wed, 6 Sep 2017 17:45:11 +0200
From: <Mikko.Rapeli@bmw.de>
To: <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH v2 1/2] gitsm.py: use download cache for
	git submodules too
Thread-Index: AQHTJwxe1tycDe9d+USF90Df9S22P6Kn15CAgAAHCQA=
Date: Wed, 6 Sep 2017 15:45:11 +0000
Message-ID: <20170906154506.sgehw2rtjdjhl5dk@hiutale>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<CABcZANk9n=tSdGFuWzJRJa8GRWBxLGFvugP_3vFW2HUVC7+=kA@mail.gmail.com>
In-Reply-To: <CABcZANk9n=tSdGFuWzJRJa8GRWBxLGFvugP_3vFW2HUVC7+=kA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.44.101]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 1/2] gitsm.py: use download cache for git submodules too
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
X-List-Received-Date: Wed, 06 Sep 2017 15:45:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <769E8B151DDF80478B1670E4FC404B82@bmwmail.corp>
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFdlZCwgU2VwIDA2LCAyMDE3IGF0IDA4OjE5OjU1QU0gLTA3MDAsIENocmlzdG9w
aGVyIExhcnNvbiB3cm90ZToNCj4gT24gV2VkLCBTZXAgNiwgMjAxNyBhdCA1OjMzIEFNLCBNaWtr
byBSYXBlbGkgPG1pa2tvLnJhcGVsaUBibXcuZGU+IHdyb3RlOg0KPiANCj4gPiBDdXJyZW50bHkg
ZG93bmxvYWQgY2FjaGVzIGZvciByZWNpcGVzIHVzaW5nIGdpdHNtIGFyZSBmaWxsZWQgYWxzbyB3
aXRoDQo+ID4gdGhlIHN1Ym1vZHVsZSByZXBvc2l0b3JpZXMgYnV0IHdoZW4gdGhlIGdpdCBzdWJt
b2R1bGUgdHJlZSBpcyByZXVzZWQgZnJvbQ0KPiA+IGNhY2hlLCBvbmx5IHRoZSBiYXNlIHJlcG9z
aXRvcnkgaXMgY2xvbmVkLiBBZnRlciBhIHNvdXJjZSBVUkwgcmV3cml0ZSwNCj4gPiAnZ2l0IHN1
Ym1vZHVsZSB1cGRhdGUgLS1pbml0IC0tcmVjdXJzaXZlJyBpcyBjYWxsZWQgaW4gdGhlIHRyZWUN
Cj4gPiB3aGljaCBkb3dubG9hZHMgdGhlIG5lZWRlZCBzdWJtb2R1bGVzIGZyb20gdXBzdHJlYW0g
VVJMJ3MuDQo+ID4gVGhpcyB3YXN0ZXMgYmFuZHdpZHRoIHNpbmNlIGRvd25sb2FkIGNhY2hlIGFs
cmVhZHkgaGFkIHRoZSBuZWVkZWQNCj4gPiBjb21taXRzIGZvciB0aGUgc3VibW9kdWxlIHJlcG9z
aXRvcmllcy4NCj4gPg0KPiA+IFdpdGggdGhpcyBjaGFuZ2UsIGFsc28gdGhlIHN1Ym1vZHVsZSBy
ZXBvc2l0b3JpZXMgYXJlIGNvcGllZCB0byB0aGUNCj4gPiB3b3JrIHNwYWNlIGZyb20gZG93bmxv
YWQgY2FjaGUgYW5kIHRoZSBkb3dubG9hZCBmcm9tIHVwc3RyZWFtIGNhbg0KPiA+IGJlIGF2b2lk
ZWQuIFVzaW5nIHBsYWluICdjcCAtYScgc2luY2UgZ2l0IGNsb25pbmcgZG9lc24ndCB3b3JrIGZv
ciB0aGUNCj4gPiBzdWJtb2R1bGUgZGlyZWN0b3JpZXMuDQo+ID4NCj4gDQo+IFRoaXMgYmVoYXZp
b3IgaXMgYm90aCBhbHJlYWR5IHRyYWNrZWQgYnkgYSB5b2N0byBidWcsIGFuZCBibGluZGx5IGNv
cHlpbmcNCj4gd2lsbCByZXN1bHQgaW4gYnJlYWthZ2Ugd2hlbiB0aGUgYnJhbmNoIGNoYW5nZXMg
aW4gc3VjaCBhIHdheSB0aGF0IHRoZQ0KPiBzdWJtb2R1bGVzIGNoYW5nZS4gSSBhbHJlYWR5IHN1
Ym1pdHRlZCBhbiBlcXVpdmFsZW50IHBhdGNoIGEgd2VlayBvciB0d28NCj4gYWdvIGFuZCB0aGVu
IGRlY2lkZWQgYWdhaW5zdCBpdHMgaW5jbHVzaW9uLCBhcyBpdCBqdXN0IHJ1bnMgaW50byBvdGhl
cg0KPiBmYWlsdXJlcywgc3BlY2lmaWNhbGx5IHRoZXJlIHdhcyBhbiBvZS1zZWxmdGVzdCB0aGF0
IGZhaWxzIGlmIHlvdSBoYWQNCj4gcHJldmlvdXNseSBmZXRjaGVkIGEgZGlmZmVyZW50IGJyYW5j
aCBvZiB0aGUgc291cmNlcyBpbiBxdWVzdGlvbiwgYXMgdGhlDQo+IHVwc3RyZWFtIHVybCBvZiBv
bmUgb2YgdGhlIHN1Ym1vZHVsZXMgY2hhbmdlcyBiZXR3ZWVuIGJyYW5jaGVzLCBhbmQgd2UNCj4g
ZG9u4oCZdCByZS1mZXRjaCBleGlzdGluZyBzdWJtb2R1bGVzIHdoZW4gdGhlaXIgdXJscyBjaGFu
Z2UuIFdlIGRlZmluaXRlbHkNCj4gbmVlZCB0byBmaXggdGhpcywgYnV0IHRoaXMgZml4ZXMgb25l
IHByb2JsZW0gYW5kIGludHJvZHVjZXMgb3RoZXJzLg0KDQpJbiBzaG9ydDogZ2l0IHN1Ym1vZHVs
ZXMgc3Vjay4NCg0KZ2l0IGV4cG9zZXMgYWxsIHRoaXMgeXVja3luZXNzIHRvIHVzZXJzIHdobyBh
cmUgY29uZnVzZWQgdG9vIGlmIHRoZWlyIGxvY2FsDQpzdWJtb2R1bGUgcmVwb3NpdG9yaWVzIHN0
b3Agd29ya2luZyBiZXR3ZWVuIGNvbW1pdHMuDQoNCj4gU2VlIGh0dHBzOi8vYnVnemlsbGEueW9j
dG9wcm9qZWN0Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTE4MzAgYW5kDQo+IGh0dHBzOi8vYnVnemls
bGEueW9jdG9wcm9qZWN0Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTE4MzEgZm9yIHJlZmVyZW5jZS4N
Cg0KT2suIEknbGwgdXNlIG15IHBhdGNoIGZvciBub3cgdW50aWwgc29tZXRoaW5nIGJldHRlciBj
b21lcyBhbG9uZw0Kd2hpY2ggYXZvaWRzIGNsb25pbmcgdGVucyBvZiByZXBvc2l0b3JpZXMgb24g
ZXZlcnkgYnVpbGQuDQoNCkFzIGZvciB0ZXN0aW5nLCBpdCdzIHBvc3NpYmxlIHRvIHNldHVwIGZh
a2UgaHR0cF9wcm94eSBlbnZpcm9ubWVudCB2YXJpYWJsZQ0KYW5kIGJyZWFrIGUuZy4gaHR0cCBj
b25uZWN0aW9ucyB0byBnaXRodWIuY29tLCBvciBpbiBjb250YWluZXJzIHRvIGJyZWFrDQpETlMg
cmVzb2x1dGlvbiB1c2luZyAvZXRjL2hvc3RzIG9yIGFsbCBuZXR3b3JrIGNvbm5lY3Rpdml0eS4N
Cg0KVGhhbmtzIGZvciBwdXNoaW5nIHRvIGZpeCB0aGlzIGlzc3VlLg0KDQotTWlra28=

