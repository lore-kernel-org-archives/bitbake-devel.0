Return-Path: <prvs=0312be7c04=alan.levy@plextek.com>
Received: from mailgate.plextek.co.uk (mailgate.plextek.co.uk [62.254.222.163])
	by mail.openembedded.org (Postfix) with ESMTP id 8F84277F4E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 May 2017 09:57:49 +0000 (UTC)
Received: from plextek-exch1.plextek.lan ([10.10.0.152]:8905)
	by mailgate.plextek.co.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <alan.levy@plextek.com>)
	id 1dBefL-0003b8-3C; Fri, 19 May 2017 10:57:48 +0100
Received: from PLEXTEK-EXCH1.plextek.lan (10.10.0.152) by
	PLEXTEK-EXCH1.plextek.lan (10.10.0.152) with Microsoft SMTP Server
	(TLS) id 15.0.847.32; Fri, 19 May 2017 10:57:41 +0100
Received: from PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f]) by
	PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f%18]) with mapi id
	15.00.0847.030; Fri, 19 May 2017 10:57:41 +0100
From: Alan Levy <alan.levy@plextek.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Problem using Subversion in Pyro
Thread-Index: AdLP4VEXB/+GGF2XTGCDVOUoQEsY6QAm1/WAAAIiq2A=
Date: Fri, 19 May 2017 09:57:40 +0000
Message-ID: <ef364375f4c24847ae8d5b64b1905700@PLEXTEK-EXCH1.plextek.lan>
References: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
	<1495187311.27342.149.camel@linuxfoundation.org>
In-Reply-To: <1495187311.27342.149.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.12.154]
MIME-Version: 1.0
Subject: Re: Problem using Subversion in Pyro
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
X-List-Received-Date: Fri, 19 May 2017 09:57:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UmljaGFyZCwNCg0KSSBjYW4gc2VlIHRoYXQgeW91IGRvbid0IHdhbnQgdG8gZm9yY2UgdGhlIGhv
c3Qgc3lzdGVtIHRvIHN1cHBvcnQgc3VidmVyc2lvbiBhbmQgSSBjb25jdXIgdGhhdCB0aGUgcmVz
dWx0aW5nIGVycm9yIG1lc3NhZ2UgaXMgdW5oZWxwZnVsLg0KDQpIb3dldmVyIHVuZGVyIE1vcnR5
IHRoaXMgd29ya2VkIGp1c3QgZmluZSBzbyBQeXJvIGJyZWFrcyBleGlzdGluZyByZWNpcGVzIGlu
IGEgd2F5IHRoYXQncyB2ZXJ5IGhhcmQgdG8gdW5kZXJzdGFuZCwgZXZlbiBpZiB0aGUgc29sdXRp
b24gaXMgZWFzeSBvbmNlIHlvdSBrbm93IGhvdy4gIEkgd291bGQgc3VnZ2VzdCB0aGF0IGFzIHdl
bGwgYXMgcHJvdmlkaW5nIGEgaGVscGZ1bCBlcnJvciBtZXNzYWdlIHRoZSBkb2N1bWVudGF0aW9u
IHNob3VsZCBhbHNvIGV4cGxhaW4gd2hhdCdzIGdvaW5nIG9uIGFuZCBob3cgdG8gZml4IGl0Lg0K
DQpSZWdhcmRzDQoNCkFsYW4NCg0KQUxBTiBMRVZZLCBMZWFkIENvbnN1bHRhbnQsIEVtYmVkZGVk
IFN5c3RlbXMNCg0KUGxleHRlayBDb25zdWx0aW5nLCBUaGUgUGxleHRlayBCdWlsZGluZywgTG9u
ZG9uIFJvYWQsIEdyZWF0IENoZXN0ZXJmb3JkLCBTYWZmcm9uIFdhbGRlbiwgQ0IxMCAxTlksIFVL
DQpUOiArNDQgKDApIDE3OTkgNTMzMjAwICAgIEU6IGFsYW4ubGV2eUBwbGV4dGVrLmNvbSAgVzog
d3d3LnBsZXh0ZWsuY29tDQoNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBSaWNoYXJkIFB1cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5v
cmddIA0KU2VudDogMTkgTWF5IDIwMTcgMTA6NDkNClRvOiBBbGFuIExldnk7IGJpdGJha2UtZGV2
ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBQ
cm9ibGVtIHVzaW5nIFN1YnZlcnNpb24gaW4gUHlybw0KDQpPbiBUaHUsIDIwMTctMDUtMTggYXQg
MTQ6MjIgKzAwMDAsIEFsYW4gTGV2eSB3cm90ZToNCj4gLS1saW1pdCAxIC0tbm8tYXV0aC1jYWNo
ZSAhIGh0dHA6Ly9zZXJ2ZXIvcGF0aC9teV9tb2R1bGUvIGZhaWxlZCB3aXRoIA0KPiBleGl0IGNv
ZGUgMTI3LCBvdXRwdXQ6DQo+IC91c3IvYmluL2VudjogJ3N2bic6IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkNCj4gwqANCj4gSWYgSSBjb21tZW50IG91dCB0aGUgbGluZSBjb250YWluaW5nIFNS
Q1BWLCBhbGwgaXMgd2VsbC4gRGlnZ2luZyBpbnRvIA0KPiB0aGUgY29kZSBpdCBhcHBlYXJzIHRo
YXQgc3ZuIGlzIG1pc3NpbmcgZnJvbSAke0hPU1RUT09MU30gaW4gDQo+IGJpdGJha2UuY29uZi4N
Cg0KSSBjYW4gdW5kZXJzdGFuZCBob3cgd2UgZW5kIHVwIGluIHRoaXMgc2l0dWF0aW9uLg0KDQpJ
biBnZW5lcmFsLCBzdWJ2ZXJzaW9uLW5hdGl2ZSBpcyBidWlsdCBiZWZvcmUgdGhlIHJlY2lwZSdz
IGRvX2ZldGNoIHNvIHRoaW5ncyB3b3JrLg0KDQpXaGVuIHlvdSB1c2UgU1JDUkVWID0gIiR7QVVU
T1JFVn0iLCBpdCBuZWVkcyBzdWJ2ZXJzaW9uIGF0IHBhcnNlIHRpbWUgYW5kIGl0cyBvYnZpb3Vz
bHkgbm90IGJ1aWx0IGl0LiBZb3UgdGhlcmVmb3JlIG5lZWQgdG8gdXNlIHRoZSBob3N0IHZlcnNp
b24uIFlvdSBjYW4gZW5hYmxlIHRoYXQgd2l0aDoNCg0KSE9TVFRPT0xTX2FwcGVuZCA9ICIgc3Zu
Ig0KDQppbiB5b3VyIGNvbmZpZy4gSSdtIG5vdCBzdXJlIEkgc2VlIGFueSB3YXkgYXJvdW5kIHRo
YXQuIFdlIGRvbid0IHJlYWxseSB3YW50IHRvIHJlcXVpcmUgc3VidmVyc2lvbiBpbiBnZW5lcmFs
LCBpdHMgb25seSBuZWVkZWQgaWYgeW91J3JlIHVzaW5nIGF1dG9yZXYgc3ZuIHJlY2lwZXMuDQoN
Ck9idmlvdXNseSB3ZSBjb3VsZCBkbyB3aXRoIGltcHJvdmluZyB0aGUgZmFpbHVyZSBtZXNzYWdl
cyB0aG91Z2guLi4NCg0KQ2hlZXJzLA0KDQpSaWNoYXJkDQo=

