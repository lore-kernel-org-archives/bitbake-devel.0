Return-Path: <prvs=23085e2c66=michael.davis@essvote.com>
Received: from m2.essvote.com (m2.essvote.com [66.37.226.14])
	by mail.openembedded.org (Postfix) with ESMTP id 8815C72F67
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 May 2017 15:40:55 +0000 (UTC)
X-AuditID: 0a00029b-70bff70000003f55-b0-5919cc042da3
Received: from ESS-EX01.essvote.corp.local (Unknown_Domain [172.16.110.40])
	by m2.essvote.com (Symantec Messaging Gateway) with SMTP id
	02.8A.16213.40CC9195; Mon, 15 May 2017 10:40:55 -0500 (CDT)
Received: from ESS-EX01.essvote.corp.local ([::1]) by
	ESS-EX01.essvote.corp.local ([::1]) with mapi id 14.03.0301.000;
	Mon, 15 May 2017 10:40:52 -0500
From: "Davis, Michael" <michael.davis@essvote.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/fetch2: Fix npm tarball fetch
Thread-Index: AQHSzY8pyBNEjmAWFEmvs8X/rUTRaqH1hRQg
Date: Mon, 15 May 2017 15:40:52 +0000
Message-ID: <655290B7709079438B7932553958E60DA130136F@ESS-EX01.essvote.corp.local>
References: <20170512205203.20459-1-michael.davis@essvote.com>
	<1494861784.27342.18.camel@linuxfoundation.org>
In-Reply-To: <1494861784.27342.18.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.20.77]
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWyRiBPQ5f9jGSkwb5XZhbXj4Za/Hg2kdWB
	yWP/3DXsHuc2rmAMYIritklKLCkLzkzP07dL4M541PmXseCVZEVLXx97A+MUyS5GTg4JAROJ
	jUcbGLsYuTiEBI4ySlxY+5ENwpkF5Czayg5SxSZgJHHu+iawKhGBDkaJs89vgyWEBTwlTk/q
	ZwOxRQS8JLa/PckKYRtJHHg0H8xmEVCV2Dn7I0sXIwcHr0CQxIKFFiBhIYECiSvrF7CA2JwC
	NhKH/x0AsxkFxCS+n1rDBGIzC4hL3HoynwniUgGJJXvOM0PYohIvH/9jhbDlJN41tbGCjGcW
	0JRYv0sfolVRYkr3Q7AreQUEJU7OfMIygVFkFpKpsxA6ZiHpmIWkYwEjyypGvlwjvdTi4rL8
	klS95PzcTYzA8OdiYJq9g3HPBIdDjAIcjEo8vBdMJSOFWBPLiitzDzFKc7AoifM+W8kcKSSQ
	nliSmp2aWpBaFF9UmpNafIiRiYPzEKMEB5eUSHFqXkpqUWJpSUY8KKbii4FRJdXA6Bq82X/j
	kmeGmxt/sO67stYgXsthFvuugwLtwr2rmW9U/N72i4PpoX+AVNBTmfMnN1Xd6bA4pjDp/RlL
	vXUOnEderJperBU/yaf8af6RFv4UvwyeD+EtLGKpLrOYj7+2dEtJX/xTh8dr8fHA4AVWwW8Y
	PdTz3ulm8zkd+Lw5PXDtW46+TNWFSizFGYmGWsxFxYkAbww+tXsCAAA=
Subject: Re: [PATCH] lib/bb/fetch2: Fix npm tarball fetch
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
X-List-Received-Date: Mon, 15 May 2017 15:40:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBhbSBub3QgYSAxMDAlIHN1cmUgdGhpcyBpcyB0aGUgYmVzdCBpbXBsZW1lbnRhdGlvbi4gIEl0
IGlzIG15IGZpcnN0IHdvcmsgaW4gcHl0aG9uIG9yIGJpdGJha2UsIHNvIEkganVzdCB0b29rIG15
IGJlc3Qgc3RhYiBhdCBpdC4NCkJhc2ljYWxseSB0aGUgaXNzdWUgaXMgcmVjcmVhdGVkIGFzIHN1
Y2g6DQoJMS4gIEdlbmVyYXRlIG5wbSB0YXJiYWxscyB1c2luZyBCQl9HRU5FUkFURV9NSVJST1Jf
VEFSQkFMTFMgPSAiMSINCgkyLiAgU2V0IFNPVVJDRV9NSVJST1JfVVJMIHRvIHNvbWUgbG9jYWwg
ZGlyIGNvbnRhaW5pbmcgdGhlIHRhcmJhbGxzLg0KCQlhLiAgZXhhbXBsZTogU09VUkNFX01JUlJP
Ul9VUkwgPz0gImZpbGU6Ly8vYnVpbGQvZG93bmxvYWRzLyINCgkzLiAgVGhlIGZldGNoZXIgaXMg
bm90IGFibGUgdG8gZmluZCB0aGUgdGFyYmFsbHMgYW5kIGluc3RlYWQgYXR0ZW1wdHMgdG8gZG93
bmxvYWQgdGhlbSBhZ2Fpbi4NCgkJYS4gVGhpcyBpcyBkdWUgdG8gdGhlIGZhY3QgdGhhdCBmb3Ig
bnBtcyB0aGUgInBhdGgiIGlzIG5vdCBzZXQgYW5kIGluc3RlYWQgdGhlIHBhY2thZ2UgbmFtZSBp
cyBpbiB0aGUgcGFyYW1zLg0KDQpJIGFtIG9wZW4gdG8gYW55IGJldHRlciB3YXlzIHRvIGRvIGl0
LiAgSSBwcmV0dHkgbXVjaCBjb21wYXJlZCB3aGF0IHdhcyBoYXBwZW5pbmcgd2l0aCBnaXQgYW5k
IHdoYXQgd2FzIGhhcHBlbmluZyB3aXRoIG5wbS4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogUmljaGFyZCBQdXJkaWUgW21haWx0bzpyaWNoYXJkLnB1cmRpZUBsaW51eGZv
dW5kYXRpb24ub3JnXSANClNlbnQ6IE1vbmRheSwgTWF5IDE1LCAyMDE3IDEwOjIzIEFNDQpUbzog
RGF2aXMsIE1pY2hhZWw7IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3Vi
amVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIGxpYi9iYi9mZXRjaDI6IEZpeCBucG0g
dGFyYmFsbCBmZXRjaA0KDQpPbiBGcmksIDIwMTctMDUtMTIgYXQgMjA6NTIgKzAwMDAsIERhdmlz
LCBNaWNoYWVsIHdyb3RlOg0KPiBUYXJiYWxscyBnZW5lcmF0ZWQgYnkgZW5hYmxpbmcgbWlycm9y
IHRhcmJhbGxzIGNvdWxkIG5vdCBiZSBmb3VuZCBieQ0KPiB0aGUNCj4gZmV0Y2ggZm9yIHRoZSBu
cG0uwqDCoFRoaXMgZml4ZXMgc2V0dGluZyB0aGUgcGF0aCB2YXJpYWJsZSBpbiBkZWNvZGUNCj4g
dXJsDQo+IHNvIHRoZXkgY2FuIGJlIG1hdGNoZWQuDQoNCldvdWxkIHlvdSBiZSBhYmxlIHRvIHBy
b3ZpZGUgYW4gZXhhbXBsZSBvZiBhIHVybCB3aGljaCBpcyBpbmNvcnJlY3QgYW5kDQp3aGF0IHRo
ZSBjb3JyZWN0IHZlcnNpb24gd291bGQgYmU/DQoNCkkgZ2V0IHdvcnJpZWQgYWJvdXQgZmV0Y2hl
ciBzcGVjaWZpYyB1cmwgaGFuZGxpbmcgYW5kIHdlIHByb2JhYmx5IGNvdWxkDQpkbyB3aXRoIGFk
ZGluZyBhIHRlc3QgY2FzZSBmb3IgdGhpcyB0b28gYnV0IGl0cyBoYXJkIHRvIHVuZGVyc3RhbmQN
CndpdGhvdXQgc2VlaW5nIGFuIGV4YW1wbGUgZmFpbHVyZS4NCg0KQ2hlZXJzLA0KDQpSaWNoYXJk
DQoNCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBEYXZpcyA8bWljaGFlbC5kYXZpc0Blc3N2b3Rl
LmNvbT4NCj4gLS0tDQo+IMKgbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8IDIgKysNCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2Ji
L2ZldGNoMi9fX2luaXRfXy5weSBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gaW5kZXgg
MTM2ZmMyOS4uMTE3Yzg5MCAxMDA2NDQNCj4gLS0tIGEvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5w
eQ0KPiArKysgYi9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+IEBAIC0zOTMsNiArMzkzLDgg
QEAgZGVmIGRlY29kZXVybCh1cmwpOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByYWlzZSBNYWxmb3JtZWRVcmwodXJsLCAiVGhlIFVSTDogJyVzJyBpcw0KPiBp
bnZhbGlkOiBwYXJhbWV0ZXIgJXMgZG9lcyBub3Qgc3BlY2lmeSBhIHZhbHVlIChtaXNzaW5nICc9
JykiICUgKHVybCwNCj4gcykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
MSwgczIgPSBzLnNwbGl0KCc9JykNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBbczFdID0gczINCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgdHlwZSA9
PSAnbnBtJyBhbmQgczEgPT0gJ25hbWUnOg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHBhdGggPSAnLycgKyBzMg0KPiDCoA0KPiDCoMKgwqDCoMKgcmV0dXJuIHR5
cGUsIGhvc3QsIHVybGxpYi5wYXJzZS51bnF1b3RlKHBhdGgpLCB1c2VyLCBwc3dkLCBwDQo+IMKg
DQo+IC0twqANCj4gMi45LjMNCg==

