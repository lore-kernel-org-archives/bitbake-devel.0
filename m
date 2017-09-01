Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 370DE78482
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Sep 2017 15:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 99109180D1;
	Fri,  1 Sep 2017 17:44:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id gAUBh5edat1t; Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 9C43618177;
	Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BB0B1E080;
	Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803951E07D;
	Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id 7412A2446;
	Fri,  1 Sep 2017 17:44:24 +0200 (CEST)
Received: from xbox11.axis.com (10.0.5.25) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Fri, 1 Sep 2017 17:44:24 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox11.axis.com (10.0.5.25) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Fri, 1 Sep 2017 17:44:24 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1263.000; Fri, 1 Sep 2017 17:44:24 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Fred Lamer <fred@rogue-research.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "poky@yoctoproject.org"
	<poky@yoctoproject.org>
Thread-Topic: [bitbake-devel] CVS support on Yocto 2.3 (Pyro) and bitbake 1.34
Thread-Index: AQHTIzaTRuBMlSjyI0motnzESmW0w6KgKEDQ
Date: Fri, 1 Sep 2017 15:44:24 +0000
Message-ID: <4ef85854c4b44bc48a381838801fd2c2@XBOX02.axis.com>
References: <e380fe57-2ad0-787d-1ea0-b02411480121@rogue-research.com>
In-Reply-To: <e380fe57-2ad0-787d-1ea0-b02411480121@rogue-research.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: CVS support on Yocto 2.3 (Pyro) and bitbake 1.34
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
X-List-Received-Date: Fri, 01 Sep 2017 15:44:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyBbbWFpbHRvOmJpdGJha2UtDQo+IGRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZ10gT24gQmVoYWxmIE9mIEZyZWQgTGFtZXINCj4gU2Vu
dDogZGVuIDQgYXVndXN0aSAyMDE3IDE2OjAwDQo+IFRvOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmc7IHBva3lAeW9jdG9wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbYml0YmFr
ZS1kZXZlbF0gQ1ZTIHN1cHBvcnQgb24gWW9jdG8gMi4zIChQeXJvKSBhbmQgYml0YmFrZQ0KPiAx
LjM0DQo+IA0KPiBIaSwNCj4gDQo+IEknbSB0cnlpbmcgdG8gYnJpbmcgYSBwcm9qZWN0IGZyb20g
WW9jdG8gMi4xIChLcm9nb3RoKSB0byAyLjMgKFB5cm8pLiBJDQo+IGhhdmUgYSBwcm9ibGVtIHdp
dGggb25lIG9mIG15IHJlY2lwZSB0aGF0IHRyaWVzIHRvIGZldGNoIGZyb20gYSBjdnMNCj4gcmVw
b3NpdG9yeS4gVGhlIHJlY2lwZSB3b3JrIHBlcmZlY3RseSBvbiBZb2N0byAyLjEgKHVzaW5nIGJp
dGJha2UNCj4gMS4zMCksDQo+IGJ1dCBub3Qgb24gWW9jdG8gMi4zICh1c2luZyBiaXRiYWtlIDEu
MzQpLg0KPiANCj4gSXQgc2VlbXMgbGlrZSAnY3ZzJyBpcyBub3QgaW5zdGFsbGVkIG9uIHRoZSBo
b3N0IHN5c3RlbT8gSSBnZXQgdGhlDQo+IGZvbGxvd2luZyBlcnJvcjoNCj4gDQo+ICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqDQo+IA0KPiBGZXRjaGVyIGZhaWx1cmU6IEZldGNoIGNvbW1hbmQgZXhwb3J0DQo+IFBB
VEg9Ii9tZWRpYS95b2N0by95b2N0by12ZXRyb2JvdC1uZXh0LmdpdC9idWlsZC90bXAvc3lzcm9v
dHMtDQo+IHVuaW5hdGl2ZS94ODZfNjQtbGludXgvdXNyL2JpbjovbWVkaWEveW9jdG8veW9jdG8t
dmV0cm9ib3QtDQo+IG5leHQuZ2l0L3Bva3kvc2NyaXB0czovbWVkaWEveW9jdG8veW9jdG8tdmV0
cm9ib3QtDQo+IG5leHQuZ2l0L2J1aWxkL3RtcC93b3JrL2NvcmVpNy02NC1wb2t5LWxpbnV4L2xp
YmV2LzQuMTUtcjAvcmVjaXBlLQ0KPiBzeXNyb290LW5hdGl2ZS91c3IvYmluL3g4Nl82NC1wb2t5
LWxpbnV4Oi9tZWRpYS95b2N0by95b2N0by12ZXRyb2JvdC0NCj4gbmV4dC5naXQvYnVpbGQvdG1w
L3dvcmsvY29yZWk3LTY0LXBva3ktbGludXgvbGliZXYvNC4xNS1yMC9yZWNpcGUtDQo+IHN5c3Jv
b3QvdXNyL2Jpbi9jcm9zc3NjcmlwdHM6L21lZGlhL3lvY3RvL3lvY3RvLXZldHJvYm90LQ0KPiBu
ZXh0LmdpdC9idWlsZC90bXAvd29yay9jb3JlaTctNjQtcG9reS1saW51eC9saWJldi80LjE1LXIw
L3JlY2lwZS0NCj4gc3lzcm9vdC1uYXRpdmUvdXNyL3NiaW46L21lZGlhL3lvY3RvL3lvY3RvLXZl
dHJvYm90LQ0KPiBuZXh0LmdpdC9idWlsZC90bXAvd29yay9jb3JlaTctNjQtcG9reS1saW51eC9s
aWJldi80LjE1LXIwL3JlY2lwZS0NCj4gc3lzcm9vdC1uYXRpdmUvdXNyL2JpbjovbWVkaWEveW9j
dG8veW9jdG8tdmV0cm9ib3QtDQo+IG5leHQuZ2l0L2J1aWxkL3RtcC93b3JrL2NvcmVpNy02NC1w
b2t5LWxpbnV4L2xpYmV2LzQuMTUtcjAvcmVjaXBlLQ0KPiBzeXNyb290LW5hdGl2ZS9zYmluOi9t
ZWRpYS95b2N0by95b2N0by12ZXRyb2JvdC0NCj4gbmV4dC5naXQvYnVpbGQvdG1wL3dvcmsvY29y
ZWk3LTY0LXBva3ktbGludXgvbGliZXYvNC4xNS1yMC9yZWNpcGUtDQo+IHN5c3Jvb3QtbmF0aXZl
L2JpbjovbWVkaWEveW9jdG8veW9jdG8tdmV0cm9ib3QtDQo+IG5leHQuZ2l0L3Bva3kvYml0YmFr
ZS9iaW46L21lZGlhL3lvY3RvL3lvY3RvLXZldHJvYm90LQ0KPiBuZXh0LmdpdC9idWlsZC90bXAv
aG9zdHRvb2xzIjsNCj4gZXhwb3J0IEhPTUU9Ii9ob21lL2ZyZWQiOyAvdXNyL2Jpbi9lbnYgY3Zz
DQo+ICctZDpwc2VydmVyOmFub255bW91c0BjdnMuc2NobW9ycC5kZTovc2NobW9ycGZvcmdlJyBj
byAtciByZWwtNF8xNQ0KPiBsaWJldg0KPiBmYWlsZWQgd2l0aCBleGl0IGNvZGUgMTI3LCBvdXRw
dXQ6DQo+IA0KPiAvdXNyL2Jpbi9lbnY6IOKAmGN2c+KAmTogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQ0KPiANCj4gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gDQo+IFNvLCBpdCBzZWVtcyBsaWtlIGN2cyBp
cyBlaXRoZXIgbm90IGluc3RhbGxlZCBvciBub3QgaW4gdGhlIFBBVEguDQo+IEFueW9uZSBldmVy
IGhhZCB0aGlzIHByb2JsZW0/DQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBpZiBJIGNvcHkvcGFzdGUg
dGhpcyBjb21tYW5kIG91dHNpZGUgb2YgdGhlIGJpdGJha2UNCj4gZW52aXJvbm5lbWVudDoNCj4g
DQo+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqDQo+IA0KPiAvdXNyL2Jpbi9lbnYgY3ZzICctZDpwc2VydmVyOmFu
b255bW91c0BjdnMuc2NobW9ycC5kZTovc2NobW9ycGZvcmdlJyBjbyAtciByZWwtNF8xNSBsaWJl
dg0KPiANCj4gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNCj4gDQo+IGl0IHdvcmtzIHBlcmZlY3RseSAoc28gaXQn
cyBub3QgYSBmZXRjaCBlcnJvciBmcm9tIHRoZSByZXBvKS4NCj4gDQo+IFRoYW5rcw0KPiANCj4g
RnJlZA0KDQpUaGlzIGlzIGR1ZSB0byB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBIT1NUVE9PTFMg
YW5kIEhPU1RUT09MU19OT05GQVRBTCANCnZhcmlhYmxlcyBpbiBQeXJvLiBPbmx5IGV4ZWN1dGFi
bGVzIGluY2x1ZGVkIGluIHRoZXNlIHZhcmlhYmxlcyB3aWxsIGJlIA0KYXZhaWxhYmxlIGZyb20g
dGhlIGhvc3QgZW52aXJvbm1lbnQgd2hlbiBiaXRiYWtlIGlzIHJ1bm5pbmcuIFRoZSANCmV4ZWN1
dGFibGVzIGluIEhPU1RUT09MUyBtdXN0IGV4aXN0IG9yIGJpdGJha2Ugd2lsbCBhYm9ydC4gVGhl
IGV4ZWN1dGFibGVzIA0KaW4gSE9TVFRPT0xTX05PTkZBVEFMIHdpbGwgYmUgYXZhaWxhYmxlIGlm
IHRoZXkgZXhpc3QuDQoNClNvIGlmIHlvdSBhZGQgY3ZzIHRvIEhPU1RUT09MU19OT05GQVRBTCwg
dXNpbmcgY3ZzIHRvIGZldGNoIGEgcmVwb3NpdG9yeSANCnNob3VsZCBzdGFydCB0byB3b3JrIGFn
YWluLg0KDQovL1BldGVyDQoNCg==

