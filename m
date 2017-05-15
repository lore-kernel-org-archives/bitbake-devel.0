Return-Path: <prvs=93087156de=michael.davis@essvote.com>
Received: from m2.essvote.com (m2.essvote.com [66.37.226.14])
	by mail.openembedded.org (Postfix) with ESMTP id 19B8F72F67
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 May 2017 15:44:20 +0000 (UTC)
X-AuditID: 0a00029b-70bff70000003f55-dd-5919ccd58901
Received: from ESS-EX01.essvote.corp.local (Unknown_Domain [172.16.110.40])
	by m2.essvote.com (Symantec Messaging Gateway) with SMTP id
	35.8A.16213.5DCC9195; Mon, 15 May 2017 10:44:22 -0500 (CDT)
Received: from ESS-EX01.essvote.corp.local ([::1]) by
	ESS-EX01.essvote.corp.local ([::1]) with mapi id 14.03.0301.000;
	Mon, 15 May 2017 10:44:21 -0500
From: "Davis, Michael" <michael.davis@essvote.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/fetch2: Fix npm tarball fetch
Thread-Index: AQHSzY8pyBNEjmAWFEmvs8X/rUTRaqH1iLtw
Date: Mon, 15 May 2017 15:44:21 +0000
Message-ID: <655290B7709079438B7932553958E60DA1301386@ESS-EX01.essvote.corp.local>
References: <20170512205203.20459-1-michael.davis@essvote.com>
	<1494861784.27342.18.camel@linuxfoundation.org>
In-Reply-To: <1494861784.27342.18.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.20.77]
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRiBPQ/faGclIg49HmC2uHw21+PFsIqsD
	k8f+uWvYPc5tXMEYwBTFbZOUWFIWnJmep2+XwJ0xaecv5oIukYqbVy4xNTCeEO5i5OSQEDCR
	OP3sMGsXIxeHkMBRRomrB3qYIJxZjBKXdzaygFSxCRhJnLu+iREkISLQwShx9vltdpCEsICn
	xOlJ/WwgtoiAl8T2tydZIWwjibUTu8GaWQRUJdYtPQUW5xUIkrh28DdYXEigQOLK+gVgNqeA
	jcThfwfAbEYBMYnvp9YwgdjMAuISt57MZ4I4VUBiyZ7zzBC2qMTLx/9YIWw5iXdNbUA2B1C9
	psT6XfoQrYoSU7ofskOsFZQ4OfMJywRGkVlIps5C6JiFpGMWko4FjCyrGPlyjfRSi4vL8ktS
	9ZLzczcxAiOAi4Fp9g7GPRMcDjEKcDAq8fBeMJWMFGJNLCuuzD3EKM3BoiTO+2wlc6SQQHpi
	SWp2ampBalF8UWlOavEhRiYOzkOMEhxcUiLFqXkpqUWJpSUZ8aCoii8GxpVUA2Nhj8xaBYu6
	CBcBhYMd5+ubD1pOfXzB6t6E5py0/ylnXubJ/GkvDQozXRWV1s+c96eit/6qyIcDZrL6tl37
	y3eZL6hY+TsxVExo9hU3z5VX36ZVxFe/LGivYf60d7apmVLx/XsdU6bJfFlwIC/A49a63ulL
	1q4y5mKTTrrDH/nv55cIs/gMbSWW4oxEQy3mouJEAAtmVyJ8AgAA
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
X-List-Received-Date: Mon, 15 May 2017 15:44:21 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSB3aWxsIGFsc28gbWVudGlvbiBJIGFtIGJsb2NraW5nIG5ldHdvcmsgYWNjZXNzIHdpdGggQkJf
Tk9fTkVUV09SSyA9ICIxIi4NCkRpc2Nvbm5lY3RpbmcgdGhlIG5ldHdvcmsgY3JlYXRlcyB0aGUg
c2FtZSBpc3N1ZSB3aGVyZSB0aGUgcGFja2FnZSBjYW4ndCBiZSBkb3dubG9hZGVkIGFuZCBlcnJv
cnMgb3V0Lg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJkIFB1
cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddIA0KU2VudDog
TW9uZGF5LCBNYXkgMTUsIDIwMTcgMTA6MjMgQU0NClRvOiBEYXZpcywgTWljaGFlbDsgYml0YmFr
ZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2
ZWxdIFtQQVRDSF0gbGliL2JiL2ZldGNoMjogRml4IG5wbSB0YXJiYWxsIGZldGNoDQoNCk9uIEZy
aSwgMjAxNy0wNS0xMiBhdCAyMDo1MiArMDAwMCwgRGF2aXMsIE1pY2hhZWwgd3JvdGU6DQo+IFRh
cmJhbGxzIGdlbmVyYXRlZCBieSBlbmFibGluZyBtaXJyb3IgdGFyYmFsbHMgY291bGQgbm90IGJl
IGZvdW5kIGJ5DQo+IHRoZQ0KPiBmZXRjaCBmb3IgdGhlIG5wbS7CoMKgVGhpcyBmaXhlcyBzZXR0
aW5nIHRoZSBwYXRoIHZhcmlhYmxlIGluIGRlY29kZQ0KPiB1cmwNCj4gc28gdGhleSBjYW4gYmUg
bWF0Y2hlZC4NCg0KV291bGQgeW91IGJlIGFibGUgdG8gcHJvdmlkZSBhbiBleGFtcGxlIG9mIGEg
dXJsIHdoaWNoIGlzIGluY29ycmVjdCBhbmQNCndoYXQgdGhlIGNvcnJlY3QgdmVyc2lvbiB3b3Vs
ZCBiZT8NCg0KSSBnZXQgd29ycmllZCBhYm91dCBmZXRjaGVyIHNwZWNpZmljIHVybCBoYW5kbGlu
ZyBhbmQgd2UgcHJvYmFibHkgY291bGQNCmRvIHdpdGggYWRkaW5nIGEgdGVzdCBjYXNlIGZvciB0
aGlzIHRvbyBidXQgaXRzIGhhcmQgdG8gdW5kZXJzdGFuZA0Kd2l0aG91dCBzZWVpbmcgYW4gZXhh
bXBsZSBmYWlsdXJlLg0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIERhdmlzIDxtaWNoYWVsLmRhdmlzQGVzc3ZvdGUuY29tPg0KPiAtLS0NCj4gwqBsaWIv
YmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgMiArKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIv
bGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiBpbmRleCAxMzZmYzI5Li4xMTdjODkwIDEwMDY0
NA0KPiAtLS0gYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+ICsrKyBiL2xpYi9iYi9mZXRj
aDIvX19pbml0X18ucHkNCj4gQEAgLTM5Myw2ICszOTMsOCBAQCBkZWYgZGVjb2RldXJsKHVybCk6
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhaXNlIE1hbGZv
cm1lZFVybCh1cmwsICJUaGUgVVJMOiAnJXMnIGlzDQo+IGludmFsaWQ6IHBhcmFtZXRlciAlcyBk
b2VzIG5vdCBzcGVjaWZ5IGEgdmFsdWUgKG1pc3NpbmcgJz0nKSIgJSAodXJsLA0KPiBzKSkNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHMxLCBzMiA9IHMuc3BsaXQoJz0nKQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcFtzMV0gPSBzMg0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiB0eXBlID09ICducG0nIGFuZCBzMSA9PSAnbmFt
ZSc6DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGF0aCA9ICcv
JyArIHMyDQo+IMKgDQo+IMKgwqDCoMKgwqByZXR1cm4gdHlwZSwgaG9zdCwgdXJsbGliLnBhcnNl
LnVucXVvdGUocGF0aCksIHVzZXIsIHBzd2QsIHANCj4gwqANCj4gLS3CoA0KPiAyLjkuMw0K

