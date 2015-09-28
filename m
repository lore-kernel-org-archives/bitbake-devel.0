Return-Path: <tim.jaacks@garz-fricke.com>
Received: from mailout.artfiles.de (mailout.artfiles.de [80.252.97.80])
	by mail.openembedded.org (Postfix) with ESMTP id 1CAE47570D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 08:53:24 +0000 (UTC)
Received: from [89.27.136.47] (helo=mail.garz-fricke.com)
	auth=mx@garz-fricke.com
	by mailout.artfiles.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80.1) id 1ZgUBX-0005n6-2j
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Sep 2015 10:53:23 +0200
Received: from SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7]) by
	SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7%12]) with mapi
	id 14.03.0248.002; Mon, 28 Sep 2015 10:53:21 +0200
From: Tim Jaacks <tim.jaacks@garz-fricke.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Override a "_remove" operator in bbappend file
Thread-Index: AdD5yvv0Hi7mek9LSb+JSmAsm2Uesw==
Date: Mon, 28 Sep 2015 08:53:20 +0000
Message-ID: <32EA6B79577EEF4C84CB32305D45A059289EB14B@SRV24.hamburg.garz-fricke.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.3.9]
MIME-Version: 1.0
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Mon, 28 Sep 2015 08:53:25 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gT3RhdmlvICYgUGF1bCwNCg0KdGhhbmtzIGZvciB5b3VyIHJlcGxpZXMuDQoNCj4gSXQg
c2VlbXMgeW91IGFyZSBpbnRlbmRpbmcgdG8gdXNlIG1lc2EgZm9yIGkuTVg1IFNvQywgdGhlIHdh
eSBJIHdvdWxkIGRvIGl0DQo+IHdvdWxkIGJlIHJlbW92aW5nIHRoZSBteDUgZnJvbSB0aGUgb3Zl
cnJpZGVzIGNvbXBsZXRlbHkuDQoNClllcywgdGhhdCBpcyBleGFjdGx5IHdoYXQgSSB3YW50IHRv
IGRvLiBXZSBkbyBub3Qgd2FudCB0byBtb3ZlIHRvIG1hc3RlciwgYXMgd2UgdXNlIHRoZSAzLjAu
MzUga2VybmVsIGFuZCBoYXZlIHRlc3RlZCBvdXIgc3lzdGVtcyBvbiB0aGlzIHZlcnNpb24sIGFu
ZCBjaGFuZ2luZyB0aGlzIHdvdWxkIHJlc3VsdCBpbiBhIGxvdCBvZiBuZXcgd29yay4NCllvdSBt
ZWFuLCBJIHNob3VsZCByZW1vdmUgIm14NSIgZnJvbSBTT0NfRkFNSUxZPyBXZWxsLCB0aGF0IHdv
dWxkIHdvcmsgb2YgY291cnNlLCBoYXZlbid0IHRob3VnaHQgb2YgdGhhdC4gSG93ZXZlciwgSSB3
b3VsZCBoYXZlIHRvIHJld3JpdGUgbG90cyBvZiBvdGhlciB2YXJpYWJsZSBhc3NpZ25tZW50cyB3
aXRoIG92ZXJyaWRlcyBmb3IgbXkgc3BlY2lmaWMgaGFyZHdhcmUuIEFuZCB0aGlzIHdvdWxkbid0
IGJlIHZlcnkgaW50dWl0aXZlIGF0IGFsbCwgYmVjYXVzZSBteSBoYXJkd2FyZSBJUyBiYXNlZCBv
biBhbiBteDUsIGFuZCB0aHVzIGxvb2tpbmcgaW50byB0aGUgcmVjaXBlcyBJIHdvdWxkIGFzc3Vt
ZSB0aGF0IF9teDUgb3ZlcnJpZGVzIGFyZSBhcHBsaWVkIG9uIG15IGhhcmR3YXJlLg0KDQo+IFdl
IHdlbnQgYmFjayBhbmQgZm9ydGggb24gdGhlIHdheSBpdCB3YXMgaW1wbGVtZW50ZWQsIGJ1dCB0
aGUgY29uY2x1c2lvbiB3ZQ0KPiByZWFjaGVkIHdhcyB0aGF0IHdoYXQgbW9zdCBwZW9wbGUgd2Fu
dCBpcyBhIHJlbW92ZSBvcGVyYXRvciB0aGF0IHJlbW92ZXMgdGhlDQo+IHZhbHVlIG5vIG1hdHRl
ciBob3cgaXQgY29tZXMgaW4uIElmIHdlIHN0YXJ0IGdldHRpbmcgaW50byBvcmRlcmluZyBvZg0K
PiBvcGVyYXRvcnMgdGhlbiBpdCdzIGhhcmRlciBmb3IgdGhlIHVzZXIgdG8gdW5kZXJzdGFuZCB3
aGF0J3MgZ29pbmcgb24sDQo+IHBhcnRpY3VsYXJseSBhcyBfYXBwZW5kLCBfcHJlcGVuZCBhbmQg
X3JlbW92ZSBhcmUgZGVmZXJyZWQgb3BlcmF0aW9ucyAodW5saWtlIA0KPiArPSBvciA9KyB3aGlj
aCBhcmUgaW1tZWRpYXRlKS4NCj4gDQo+IFdoYXQgdGhpcyBkb2VzIG1lYW4gaXMgdGhhdCBfcmVt
b3ZlIHNob3VsZCBiZSB1c2VkIHNwYXJpbmdseSBhbmQgcmVhbGx5IG91Z2h0DQo+IHRvIGJlIHVz
ZWQgb25seSB3aGVyZSBpdCdzIHZlcnkgdW5saWtlbHkgdGhhdCBhbnlvbmUgd291bGQgd2FudCB0
byBvdmVycmlkZSBpdC4NCg0KV2VsbCwgSSB3b3VsZCBzYXkgdGhhdCB0aGlzIGlzIHNvbWV3aGF0
IGNvdW50ZXItaW50dWl0aXZlLiBUaGUgbGF5ZXJzIGFyZSBvbmUgb2YgdGhlIG1haW4gY29uY2Vw
dHMgb2YgQml0YmFrZS4gSWYgSSBjcmVhdGUgYSBsYXllciBhbmQgYXNzaWduIHRoZSBoaWdoZXN0
IHByaW9yaXR5IHRvIGl0LCBpdCBpcyBoYXJkIHRvIHVuZGVyc3RhbmQgdGhhdCBjaGFuZ2VzIEkg
bWFrZSB0byBhIHZhcmlhYmxlIGluIG15IGxheWVyIGFyZSBub3QgYXBwbGllZCBiZWNhdXNlIG9m
IGEgbG93ZXIgcHJpb3JpdHkgbGF5ZXIgYmVpbmcgcHJvY2Vzc2VkIGFmdGVyIG15IGxheWVyLiBI
b3cgY2FuIHlvdSBldmVyIHRlbGwgdGhhdCBpdCBpcyAidW5saWtlbHkiIHRoYXQgc29tZW9uZSB3
YW50cyB0byBvdmVycmlkZSBhIF9yZW1vdmUgb3BlcmF0b3I/IFNob3VsZG4ndCBBTEwgdmFyaWFi
bGVzIGJlIGNoYW5nZWFibGUgaW4gQUxMIHdheXM/IFRoaXMgc2VlbXMgYSB2ZXJ5IHN0cmljdCAo
YW5kIHVuZG9jdW1lbnRlZCkgbGltaXRhdGlvbiB0byBtZS4NCg0KwqANCk1pdCBmcmV1bmRsaWNo
ZW4gR3LDvMOfZW4gLyBCZXN0IHJlZ2FyZHMNCmkuQS4gVGltIEphYWNrcw0KDQpTb2Z0d2FyZSBF
bmdpbmVlcmluZw0KR2FyeiAmIEZyaWNrZSBHbWJIDQpUZW1wb3dlcmtyaW5nIDIsIDIxMDc5IEhh
bWJ1cmcgLSBHZXJtYW55DQpBbXRzZ2VyaWNodCBIYW1idXJnIEhSQiA2MDUxNA0KR2VzY2jDpGZ0
c2bDvGhyZXI6IE1hbmZyZWQgR2FyeiwgTWF0dGhpYXMgRnJpY2tlDQpQaG9uZTogKzQ5IDQwIDc5
MTg5OSAtIDU1DQpGYXg6wqDCoMKgwqAgKzQ5IDQwIDc5MTg5OSDigJMgMzkNCnRpbS5qYWFja3NA
Z2Fyei1mcmlja2UuY29tDQp3d3cuZ2Fyei1mcmlja2UuY29tDQo=

