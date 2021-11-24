Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595EFC433FE
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 23:40:45 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web09.5628.1637797243878338386
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 15:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id C001831E035B;
	Thu, 25 Nov 2021 00:40:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Thu, 25 Nov 2021 00:40:40 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id 9D1F431E033F;
	Thu, 25 Nov 2021 00:40:40 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Thu, 25 Nov 2021 00:40:39 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "jasper@fancydomain.eu"
	<jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [eo-core][PATCH v6 1/2] repo: Add recipe for
 2.17.3
Thread-Topic: [bitbake-devel] [eo-core][PATCH v6 1/2] repo: Add recipe for
 2.17.3
Thread-Index: AQHX4WIpliR8RsheV0W5hXawn2b41awTPHcAgAAJYIA=
Date: Wed, 24 Nov 2021 23:40:39 +0000
Message-ID: <3fac5cb6694938b352a74b2a66984226ae645c36.camel@iris-sensing.com>
References: <20211124183540.39312-1-jasper@fancydomain.eu>
	 <49d29bc20a378e9fb8fd57b940f4a914f6a2eb83.camel@linuxfoundation.org>
In-Reply-To: 
 <49d29bc20a378e9fb8fd57b940f4a914f6a2eb83.camel@linuxfoundation.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <97838F83D3BAAC498D05DDAA47213C6D@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Nov 2021 23:40:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13104

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNClNvcnJ5
IGFib3V0IHRoYXQuIFNlZW1zIEkgZ290IHNsb3BweSBkdXJpbmcgb25lIG9mIHRoZSBwYXRjaCBy
ZXZpc2lvbnMNCmFuZCBhY2NpZGVudGx5IGZvcm1hdHRlZCBvbmUgb2YgdGhlIHBhdGNoZXMgZnJv
bSB0aGUgd3JvbmcgcmVwbw0KcmV2aXNpb24uDQoNClNob3VsZCBub3cgd29yayB3aXRoIHY3IG9u
IHRoZSBNTC4NCg0KLSAtLSANCldpdGggYmVzdCByZWdhcmRzDQoNCkphc3BlciBPcnNjaHVsa28N
CkRldk9wcyBFbmdpbmVlcg0KDQpUZWwuICs0OSAzMCA1OCA1OCAxNCAyNjUNCkZheCArNDkgMzAg
NTggNTggMTQgOTk5DQpKYXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vuc2luZy5jb20NCg0K4oCiIOKA
oiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAog0KDQppcmlzLUdtYkgNCmlu
ZnJhcmVkICYgaW50ZWxsaWdlbnQgc2Vuc29ycw0KU2NobmVsbGVyc3RyYcOfZSAxLTUgfCAxMjQz
OSBCZXJsaW4NCg0KaHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0KDQoNCg0KDQoNCk9uIFdlZCwg
MjAyMS0xMS0yNCBhdCAyMzowNyArMDAwMCwgUmljaGFyZCBQdXJkaWUgd3JvdGU6DQo+IE9uIFdl
ZCwgMjAyMS0xMS0yNCBhdCAxOTozNSArMDEwMCwgSmFzcGVyIE9yc2NodWxrbyB2aWENCj4gbGlz
dHMub3BlbmVtYmVkZGVkLm9yZw0KPiB3cm90ZToNCj4gPiBGcm9tOiBKYXNwZXIgT3JzY2h1bGtv
IDxKYXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vuc2luZy5jb20+DQo+ID4gDQo+ID4gQWRkIGEgcmVj
aXBlIGZvciByZXBvIDIuMTcuMywgcHJlcmVxdWlzaXRlIGZvciB0aGUgcmVwbyBmZXRjaGVyLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc3BlciBPcnNjaHVsa28gPEphc3Blci5PcnNjaHVs
a29AaXJpcy1zZW5zaW5nLmNvbT4NCj4gPiAtLS0NCj4gPiDCoG1ldGEvY29uZi9kaXN0cm8vaW5j
bHVkZS9tYWludGFpbmVycy5pbmPCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoC4uLi8wMDAxLVNl
dC1SRVBPX1JFVi10by12Mi4xNy4zLnBhdGNowqDCoMKgwqDCoMKgwqAgfCAzNQ0KPiA+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiDCoC4uLi9yZXBvL3JlcG8vMDAwMS1weXRob24zLXNoZWJhbmcu
cGF0Y2jCoMKgwqDCoMKgIHwgMjYgKysrKysrKysrKysrKysNCj4gPiDCoG1ldGEvcmVjaXBlcy1k
ZXZ0b29scy9yZXBvL3JlcG9fMi4xNy4zLmJiwqDCoMKgwqAgfCAyOCArKysrKysrKysrKysrKysN
Cj4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IG1ldGEvcmVjaXBlcy1kZXZ0b29scy9yZXBvL3JlcG8tMi4xNy4zLzAwMDEtDQo+
ID4gU2V0LVJFUE9fUkVWLXRvLXYyLjE3LjMucGF0Y2gNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBtZXRhL3JlY2lwZXMtZGV2dG9vbHMvcmVwby9yZXBvLzAwMDEtcHl0aG9uMy0NCj4gPiBzaGVi
YW5nLnBhdGNoDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgbWV0YS9yZWNpcGVzLWRldnRvb2xz
L3JlcG8vcmVwb18yLjE3LjMuYmINCj4gPiANCj4gPiANCj4gDQo+IEkgdGhvdWdodCBJJ2QgdHJ5
IHRlc3RpbmcgdGhpcy4gVW5mb3J0dW5hdGVseSBpdCBkb2Vzbid0IGJ1aWxkOg0KPiANCj4gaHR0
cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3R5cGhvb24vIy9idWlsZGVycy8xMTUv
YnVpbGRzLzEwMDQvc3RlcHMvMTMvbG9ncy9zdGRpbw0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmlj
aGFyZA0KPiANCj4gDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQppUUV6QkFFQkNB
QWRGaUVFNFd5UE1JQzVBcDQrT29vMVlncWV3MDdWTU5VRkFtR2V6WGNBQ2drUVlncWV3MDdWDQpN
TlZOMGdnQWhnQ1VZV09kdlJ0MWs1N2RIUDJhUzJFR3hMTDl2dDlMWjZCZjJPTVhBRGluWVBnZldB
bTJnWjJTDQphU2RvM0kwVmpsa2gvcnhCMXVPbU5wV1BGTDBZaXR6czY5NnZNODdKY3hsbDlRMnhY
a0hCRGE1TGozWjRzVWFaDQpqQ2h6WFZldUttckFMRlRoTXNYYlBjSk8vS1hZWkpSaDYxUGw5dkx3
NEZXcGR3ZXpjUTBtWEo0dUtHQ1NWaHZSDQp5aS9BbEVhb2gwVEMvanNpVS9WeGFxSFVNYXZpSS8x
cmt1L0lkemtNV2ZzS3kvUnQzaWxTTlEwUDZDYlVJNmtZDQptYktkM2FZek1Nc1lCdzlwcGgweUhq
SzNRVnU2THIrR25ISDE1RlE0SkZPaHM4eVhDSzFGZTFXemE5Uk52RTMyDQpoR21lZDFtT3dISHdQ
RzRDb1VWMlRid0QwS0QvM0E9PQ0KPTBtOXYNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

