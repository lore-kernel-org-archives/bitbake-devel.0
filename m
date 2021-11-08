Return-Path: <Jasper.Orschulko@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6FC433FE
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 12:44:31 +0000 (UTC)
Received: from mail.irisgmbh.de (mail.irisgmbh.de [81.169.172.79])
 by mx.groups.io with SMTP id smtpd.web08.44306.1636375460152053088
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 04:44:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=temperror, err=temporary DNS error (domain: iris-sensing.com,
 ip: 81.169.172.79, mailfrom: jasper.orschulko@iris-sensing.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.irisgmbh.de (Postfix) with ESMTP id 1229A31E0357;
	Mon,  8 Nov 2021 13:44:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at irisgmbh.de
Received: from mail.irisgmbh.de ([127.0.0.1])
	by localhost (s15324379.rootmaster.info [127.0.0.1]) (amavisd-new,
 port 10027)
	with ESMTP; Mon,  8 Nov 2021 13:44:11 +0100 (CET)
Received: from ERDE.irisgmbh.local (unknown [213.61.209.158])
	by mail.irisgmbh.de (Postfix) with ESMTPS id EC5DD31E0355;
	Mon,  8 Nov 2021 13:44:11 +0100 (CET)
Received: from ERDE.irisgmbh.local ([172.30.10.11]) by ERDE.irisgmbh.local
 ([172.30.10.11]) with mapi id 14.03.0513.000; Mon, 8 Nov 2021 13:44:11 +0100
From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>, "mac@mcrowe.com"
	<mac@mcrowe.com>, "stefan.herbrechtsmeier-oss@weidmueller.com"
	<stefan.herbrechtsmeier-oss@weidmueller.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>, "cal@brightsign.biz"
	<cal@brightsign.biz>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Thread-Topic: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Thread-Index: AQHX0Xen6HV5VooQfU+dD24h/zH3OavzRsIAgANkloCAAo6ggIAATvsA
Date: Mon, 8 Nov 2021 12:44:10 +0000
Message-ID: <5b0e441cbb16215ed77df38b7734a2d38c4dc266.camel@iris-sensing.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
	 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
	 <YYa0NeCHOjBXYsxA@mcrowe.com>
	 <b9029131-1a0e-99e5-01fb-183930a36c87@weidmueller.com>
In-Reply-To: <b9029131-1a0e-99e5-01fb-183930a36c87@weidmueller.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.10.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABC14EE3DD02A044AFAF387159A88CFB@irisgmbh.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 12:44:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12940

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCkhpIFN0
ZWZhbiwNCg0Kd291bGQgeW91IChhbmQgYW55IG90aGVyIGludGVyZXN0ZWQgcGFydHkpIGJlIGlu
dGVyZXN0ZWQgaW4gYQ0KY29uZmVyZW5jZSBjYWxsIHdpdGggTWFydGluIGFuZCBJPyBXZSBhcmUg
Z3JlYXRseSBpbnRlcmVzdGVkIGluIHlvdXINCmN1cnJlbnQgcHJvdG90eXBlcywgaG93IHRoZXkg
cGVyZm9ybSBmb3IgdGhlIHZhcmlvdXMgdXNlY2FzZXMgYW5kDQppZi9ob3cgd2UgY2FuIGhlbHAg
eW91IHdpdGggdGhlIGltcGxlbWVudGF0aW9uLg0KDQotIC0tIA0KV2l0aCBiZXN0IHJlZ2FyZHMN
Cg0KSmFzcGVyIE9yc2NodWxrbw0KRGV2T3BzIEVuZ2luZWVyDQoNClRlbC4gKzQ5IDMwIDU4IDU4
IDE0IDI2NQ0KRmF4ICs0OSAzMCA1OCA1OCAxNCA5OTkNCkphc3Blci5PcnNjaHVsa29AaXJpcy1z
ZW5zaW5nLmNvbQ0KDQrigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCi
IOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg4oCiIOKAoiDigKIg
4oCiDQoNCmlyaXMtR21iSA0KaW5mcmFyZWQgJiBpbnRlbGxpZ2VudCBzZW5zb3JzDQpTY2huZWxs
ZXJzdHJhw59lIDEtNSB8IDEyNDM5IEJlcmxpbg0KDQpodHRwczovL2lyaXMtc2Vuc2luZy5jb20v
DQoNCg0KDQoNCg0KT24gTW9uLCAyMDIxLTExLTA4IGF0IDA5OjAxICswMTAwLCBTdGVmYW4gSGVy
YnJlY2h0c21laWVyIHdyb3RlOg0KPiBBbSAwNi4xMS4yMDIxIHVtIDE3OjU4IHNjaHJpZWIgTWlr
ZSBDcm93ZToNCj4gPiBPbiBUaHVyc2RheSAwNCBOb3ZlbWJlciAyMDIxIGF0IDE0OjA5OjQyICsw
MTAwLCBBbGV4YW5kZXIgS2FuYXZpbg0KPiA+IHdyb3RlOg0KPiA+ID4gVG8gdGhlIGJlc3Qgb2Yg
bXkga25vd2xlZGdlLCBubyBvdGhlciBjb21wYW5pZXMgYXQgdGhlIG1vbWVudCBhcmUNCj4gPiA+
IHVzaW5nDQo+ID4gPiBZb2N0byB0byBpbnRlZ3JhdGUgbnBtLWJhc2VkIGl0ZW1zIGludG8gYSBw
cm9kdWN0Lg0KPiA+IA0KPiA+IFdlIG1ha2UgbGlnaHQgdXNlIG9mIG5wbSBpbiB0aGUgcHJvZHVj
dGlvbiBvZiB0aGUgcm9vdGZzIGZvciBvdXINCj4gPiBwcm9kdWN0cy4NCj4gPiBUaGUgdXBncmFk
ZSB0byBEdW5mZWxsIHdhcyBhIGJpdCBwYWluZnVsLCBhbmQgdGhlIHNsb3duZXNzIGlzDQo+ID4g
YW5ub3lpbmcgdG9vLA0KPiA+IGJ1dCBJIHRoaW5rIHRoYXQgd2UndmUgZW5kZWQgdXAgd2l0aCB0
aGluZ3MgYmVpbmcgYmV0dGVyIGluIHRoZSBlbmQNCj4gPiBiZWNhdXNlDQo+ID4gd2UgY2FuIG5v
dyBiZSBzdXJlIHRoYXQgYWxsIHRoZSBzb3VyY2VzIGFyZSBjYXB0dXJlZCBjb3JyZWN0bHkuDQo+
IA0KPiBXZSBoYXZlIGEgc2ltaWxhciBwcm9ibGVtLg0KPiANCj4gPiBXZSBkaWQgcnVuIGludG8g
YSBmZXcgYnVncyBhbmQgc29tZSBvZiBvdXIgZml4ZXMgZm9yIHRob3NlIGhhdmUNCj4gPiBsYW5k
ZWQuIFRoZQ0KPiA+IG5wbSBmZXRjaGVyIHNlZW1zIHRvIGJlIGZpZ2h0aW5nIHdpdGggdGhlIHVz
dWFsIHdheSB0aGF0IEJpdGJha2UNCj4gPiBleHBlY3RzDQo+ID4gZmV0Y2hlcnMgdG8gd29yayB0
aGF0IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgZW5vdWdoIChmcm9tIGVpdGhlcg0KPiA+IHNp
ZGUpDQo+ID4gdG8ga25vdyBob3cgdG8gZml4LiAoZS5nLg0KPiA+IGh0dHBzOi8vYnVnemlsbGEu
eW9jdG9wcm9qZWN0Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTQzODPCoHdoaWNoDQo+ID4gZG9lc24n
dA0KPiA+IGRpcmVjdGx5IGFmZmVjdCB1cywgYnV0IHRoZSB1bmRlcmx5aW5nIGNhdXNlIG1lYW50
IHRoYXQgb3VyIHVzdWFsDQo+ID4gbWV0aG9kDQo+ID4gZm9yIGNhcHR1cmUgc291cmNlcyBuZWVk
ZWQgc29tZSBleHRyYSB3b3JrYXJvdW5kcy4pDQo+IA0KPiBUaGUgbnBtc3cgZmV0Y2hlciBpcyB0
aGUgb25seSBvbmUgdGhhdCBmZXRjaCBtdWx0aXBsZSBzb3VyY2VzIGZyb20NCj4gb25lIA0KPiBh
bmQgdHJhbnNsYXRlIGl0IGludG8gbXVsdGlwbGUgZmV0Y2ggY29tbWFuZHMuDQo+IA0KPiBJIHRo
aW5rIHRoaXMgaXMgYSB3cm9uZyBhcHByb2FjaCBhbmQgbWFrZXMgbW9yZSBwcm9ibGVtcyBhcyBp
dCBzb2x2ZS4NCj4gSSANCj4gc3VnZ2VzdCB0byBtb3ZlIHRoZSBsb2dpYyB0byB0aGUgcmVjaXBl
dG9vbCBhbmQgZGlyZWN0IHVzZSB0aGUgbnBtIA0KPiBmZXRjaGVyIHBlciBucG0gcGFja2FnZSAo
ZGVwZW5kZW5jeSkuIEV2ZW4gdGhlIG5wbSBmZXRjaGVyIGNvdWxkIGJlIA0KPiBhdm9pZCBpZiB3
ZSBkb2Vzbid0IHJlcXVpcmUgYW4gYXV0b3JldiBmZWF0dXJlIGZvciBhbiBucG0gcGFja2FnZS4N
Cj4gDQo+IFRoaXMgc29sdXRpb24gaGFzIHRoZSBhZHZhbnRhZ2UgdGhhdCB5b3UgY291bGQgbWFu
aXB1bGF0ZSB0aGUgDQo+IGRlcGVuZGVuY2llcyBpbnNpZGUgYSByZWNpcGUgYW5kIHlvdSBjb3Vs
ZCByZXBsYWNlIGEgbnBtIHBhY2thZ2Ugd2l0aA0KPiBhbiANCj4gb3RoZXIgb2UgcGFja2FnZSAo
REVQRU5EUyAvIFJERVBFTkRTKS4NCj4gDQo+IFRoZSBkaXNhZHZhbnRhZ2UgaXMgYSBiaWcgcmVj
aXBlIGluc3RlYWQgb2YgYSBiaWcgZm9yZWlnbg0KPiBjb25maWd1cmF0aW9uIA0KPiBmaWxlIGFu
ZCBpdCBpcyBpbXBvc3NpYmxlIHRvIHVzZSBhIGZvcmVpZ24gY29uZmlndXJhdGlvbiBmaWxlIGRp
cmVjdCANCj4gZnJvbSBhIGdpdCByZXBvc2l0b3J5LiBCdXQgSSB0aGluayB0aGlzIHVzZSBjYXNl
IGRvZXNuJ3QgbWF0Y2ggd2l0aA0KPiB0aGUgDQo+IG9lIHJlcXVpcmVtZW50cyBhbmQgd2Ugc2hv
dWxkIGltcHJvdmUgdGhlIHJlY2lwZSBnZW5lcmF0aW9uIHNvIHRoYXQNCj4gdGhpcyANCj4gY291
bGQgYmUgZG9uZSBhdXRvbWF0aWNhbGx5Lg0KPiANCj4gUmVnYXJkcw0KPiDCoMKgIFN0ZWZhbg0K
LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBRUJDQUFkRmlFRTRXeVBNSUM1
QXA0K09vbzFZZ3FldzA3Vk1OVUZBbUdKRzVvQUNna1FZZ3FldzA3Vg0KTU5WVERnZi9kNmVZL0Fs
bm5IZzNPa0hQMUdmS29SRG1NS051UzFzamJ4N3hNeUdzWkJwV1JyUEdQd3BMV2E2VA0KcmRTM3Fj
R3lWbk1CYkhlVFJEcDJ5dVl4eEZDckJxeWlTR3BIZlF3bVVMOXU5NFNpM3VqVGRLWktwUVNZcXVU
Mw0KRkRaVzRXRElMUDZMQ3lmVkZuTGRMeUx5VkpkNjJYMnRIZDhqZkc4Yys3MHhRNUliaDBDRHBF
c2xIdnFXYi9uUw0KMzBwS0ozRlgvVm5NaXQ2QklZNG5kaWlkVytVWC9ybnU1K3cyQWVxRWs5SDl0
MVpjakNKeUVQM1RnRitmM2ljTg0KNlM2dW01RUcrQTlZSjdxZXVXVkR3eEd5RGtXb2Q3VGtYTVR4
WUFkaHVkOFNmbzBna3gzY0oxekxyMTBzekdJag0KYlNwRW42aW01Y2Njb2VhRnRhV3BpTFVtdXdw
RXpnPT0NCj11Tm5hDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

