Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A73C433F5
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 15:56:29 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web11.38.1636559787625622969
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 07:56:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=SPF record not found (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 10FDD31E0345;
	Wed, 10 Nov 2021 16:56:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Wed, 10 Nov 2021 16:56:25 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id EEBE531E02EA;
	Wed, 10 Nov 2021 16:56:24 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Wed, 10 Nov 2021 16:56:24 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>, "jasper@fancydomain.eu"
	<jasper@fancydomain.eu>
CC: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [oe-core][PATCH v4 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Thread-Topic: [oe-core][PATCH v4 2/2] base.bbclass: Add sysroot deps for
 repo fetcher
Thread-Index: AQHX1ksnivfOdYho30atwptL4IWMXav82auA
Date: Wed, 10 Nov 2021 15:56:24 +0000
Message-ID: <6793926e2e7f7bd2cba642ee7e5a59beed4b1aa6.camel@iris-sensing.com>
References: <20211110155332.578088-1-jasper@fancydomain.eu>
	 <20211110155332.578088-2-jasper@fancydomain.eu>
In-Reply-To: <20211110155332.578088-2-jasper@fancydomain.eu>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4683F661A6273548B1188828FBF29813@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 15:56:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12992

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNClVubGVz
cyB0aGVyZSBhcmUgYW55IG1vcmUgY29tbWVudHMsIEkgYmVsaWV2ZSB0aGlzIHBhdGNoIHNlcmll
cyBzaG91bGQNCmJlIG1lcmdhYmxlIG5vdy4NCg0KLSAtLSANCldpdGggYmVzdCByZWdhcmRzDQoN
Ckphc3BlciBPcnNjaHVsa28NCkRldk9wcyBFbmdpbmVlcg0KDQpUZWwuICs0OSAzMCA1OCA1OCAx
NCAyNjUNCkZheCArNDkgMzAgNTggNTggMTQgOTk5DQpKYXNwZXIuT3JzY2h1bGtvQGlyaXMtc2Vu
c2luZy5jb20NCg0K4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDi
gKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKA
og0KDQppcmlzLUdtYkgNCmluZnJhcmVkICYgaW50ZWxsaWdlbnQgc2Vuc29ycw0KU2NobmVsbGVy
c3RyYcOfZSAxLTUgfCAxMjQzOSBCZXJsaW4NCg0KaHR0cHM6Ly9pcmlzLXNlbnNpbmcuY29tLw0K
DQoNCg0KDQoNCk9uIFdlZCwgMjAyMS0xMS0xMCBhdCAxNjo1MyArMDEwMCwgamFzcGVyQGZhbmN5
ZG9tYWluLmV1IHdyb3RlOg0KPiBGcm9tOiBKYXNwZXIgT3JzY2h1bGtvIDxKYXNwZXIuT3JzY2h1
bGtvQGlyaXMtc2Vuc2luZy5jb20+DQo+IA0KPiBBZGQgZ2l0LW5hdGl2ZSBhbmQgcmVwby1uYXRp
dmUgYXMgcHJlcmVxdWlzaXRlIGZvciB0aGUgcmVwbyBmZXRjaGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSmFzcGVyIE9yc2NodWxrbyA8SmFzcGVyLk9yc2NodWxrb0BpcmlzLXNlbnNpbmcuY29t
Pg0KPiAtLS0NCj4gwqBtZXRhL2NsYXNzZXMvYmFzZS5iYmNsYXNzIHwgNSArKysrKw0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXRhL2Ns
YXNzZXMvYmFzZS5iYmNsYXNzIGIvbWV0YS9jbGFzc2VzL2Jhc2UuYmJjbGFzcw0KPiBpbmRleCBh
NjVmY2M2YzFkLi4zMjk4YmQxOTUyIDEwMDY0NA0KPiAtLS0gYS9tZXRhL2NsYXNzZXMvYmFzZS5i
YmNsYXNzDQo+ICsrKyBiL21ldGEvY2xhc3Nlcy9iYXNlLmJiY2xhc3MNCj4gQEAgLTY2NSw2ICs2
NjUsMTEgQEAgcHl0aG9uICgpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCBlbGlmIHVyaS5zY2hlbWUg
PT0gIm5wbSI6DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkLmFwcGVuZFZhckZsYWcoJ2Rv
X2ZldGNoJywgJ2RlcGVuZHMnLCAnIG5vZGVqcy0NCj4gbmF0aXZlOmRvX3BvcHVsYXRlX3N5c3Jv
b3QnKQ0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqAgZWxpZiB1cmkuc2NoZW1lID09ICJyZXBvIjoN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmVlZHNyY3JldiA9IFRydWUNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZC5hcHBlbmRWYXJGbGFnKCdkb19mZXRjaCcsICdkZXBlbmRzJywgJyBy
ZXBvLQ0KPiBuYXRpdmU6ZG9fcG9wdWxhdGVfc3lzcm9vdCcpDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGQuYXBwZW5kVmFyRmxhZygnZG9fZmV0Y2gnLCAnZGVwZW5kcycsICcgZ2l0LQ0KPiBu
YXRpdmU6ZG9fcG9wdWxhdGVfc3lzcm9vdCcpDQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoCAjICou
bHo0IHNob3VsZCBERVBFTkQgb24gbHo0LW5hdGl2ZSBmb3IgdW5wYWNraW5nDQo+IMKgwqDCoMKg
wqDCoMKgwqAgaWYgcGF0aC5lbmRzd2l0aCgnLmx6NCcpOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZC5hcHBlbmRWYXJGbGFnKCdkb191bnBhY2snLCAnZGVwZW5kcycsICcgbHo0LQ0KPiBu
YXRpdmU6ZG9fcG9wdWxhdGVfc3lzcm9vdCcpDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0t
LQ0KDQppUUV6QkFFQkNBQWRGaUVFNFd5UE1JQzVBcDQrT29vMVlncWV3MDdWTU5VRkFtR0w2NmNB
Q2drUVlncWV3MDdWDQpNTldoT3dmL2M0SVRmQmlqRTRERDJnRk9XajBPTUFRRnJkZVlDOGRRaHNt
NzU2S3VhMW0wbVBjNU9oNjFra0I5DQpvZy9ic2QxcXFudWFiVGNVSFc5Z1ZJOUhxNDV5UFhmQXk1
R3lnNkExMG93RGVDY21OZ2loQ3VUR3Irc1F5NjRXDQpsaTVPY093NTkvb2s2eVBWcUUrQ2FlWW9I
Q0d2MVZkTFIwOXBTZEsxUzlray8zaFZOT1NSYjl1bXRHYjNhUjZMDQpLbXJ0RzcxUVpWVkxCalRy
cHB6SW9seXV5MTE2Y0dmSWV5NXpBVm1yWVBESEx0dndZam50MU5kQkZuN09GTUZWDQo3a0lYeTdh
b0JNWHN1UnhUUjZtdkM5R3hKY3dPVWdzSUxVV0x5UTYyVmNnTkgxM0c1blIwekh3UGFtdElPVDBS
DQplYW9hc1NQa01sMndmZXZPSG9zckk5dGdNSThoSWc9PQ0KPUVEQ0wNCi0tLS0tRU5EIFBHUCBT
SUdOQVRVUkUtLS0tLQ0K

