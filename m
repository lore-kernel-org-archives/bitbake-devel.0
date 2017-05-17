Return-Path: <prvs=931019f85a=michael.davis@essvote.com>
Received: from m2.essvote.com (m2.essvote.com [66.37.226.14])
	by mail.openembedded.org (Postfix) with ESMTP id 7B8E177E6B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 May 2017 20:35:37 +0000 (UTC)
X-AuditID: 0a00029b-70bff70000003f55-cd-591cb416e895
Received: from ESS-EX01.essvote.corp.local (Unknown_Domain [172.16.110.40])
	by m2.essvote.com (Symantec Messaging Gateway) with SMTP id
	74.A1.16213.614BC195; Wed, 17 May 2017 15:35:37 -0500 (CDT)
Received: from ESS-EX01.essvote.corp.local ([::1]) by
	ESS-EX01.essvote.corp.local ([::1]) with mapi id 14.03.0301.000;
	Wed, 17 May 2017 15:35:34 -0500
From: "Davis, Michael" <michael.davis@essvote.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/fetch2: Fix npm tarball fetch
Thread-Index: AQHSzY8pyBNEjmAWFEmvs8X/rUTRaqH4/E4g
Date: Wed, 17 May 2017 20:35:33 +0000
Message-ID: <655290B7709079438B7932553958E60DA13058FB@ESS-EX01.essvote.corp.local>
References: <20170512205203.20459-1-michael.davis@essvote.com>
	<1494861784.27342.18.camel@linuxfoundation.org>
In-Reply-To: <1494861784.27342.18.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.20.77]
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRiBPQ1dyi0ykweFNkhbXj4Za/Hg2kdWB
	yWP/3DXsHuc2rmAMYIritklKLCkLzkzP07dL4M64cXcWc8Ea+YpzHY9ZGhiPyHUxcnJICJhI
	3P96nq2LkYtDSOAoo8THz+cYIZxZjBKPuk8wgVSxCRhJnLu+CSwhItDBKHH2+W12kISwgKfE
	6Un9bCC2iICXxPa3J1khbCOJp51tzCA2i4CqROvfA2A1vAJBEg0zp4HZQgIFElfWL2ABsTkF
	bCQO/zsAZjMKiEl8P7UGbDGzgLjErSfzmSBOFZBYsuc8M4QtKvHy8T9WCFtO4l1TG5DNAVSv
	KbF+lz5Eq6LElO6H7BBrBSVOznzCMoFRZBaSqbMQOmYh6ZiFpGMBI8sqRr5cI73U4uKy/JJU
	veT83E2MwAjgYmCavYNxzwSHQ4wCHIxKPLwXxKQihVgTy4orcw8xSnOwKInzPlvJHCkkkJ5Y
	kpqdmlqQWhRfVJqTWnyIkYmD8xCjBAeXlEhxal5KalFiaUlGPCiq4ouBcSXVwJji3v1p5a6y
	+O/mRjNf9lp3nPp14I9+ks/ys/JVF27cyV9dXF0k8jhS5aJqpNP6BAf7PsNII6HUXfPnfmG9
	lPf/a8a65N13/+hcvZMZ2X+4fnO6NjObYuzSZ6orMmzscjmav84rvMRaFct2TOC8HGPVGom6
	B2Hb3/jqHsnoPhqks7Gg+fqziUosxRmJhlrMRcWJACeyivF8AgAA
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
X-List-Received-Date: Wed, 17 May 2017 20:35:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBjcmVhdGVkIGEgcGF0Y2ggdGhhdCBpcyBhIGxpdHRsZSBsZXNzIHVnbHksIGJ1dCBpdCBpcyBz
dGlsbCBmZXRjaGVyIHNwZWNpZmljIHVybCBoYW5kbGluZy4NClRoZSBiYXNpYyBpc3N1ZSBpcyB0
aGF0IHRoZSBwYXRoIGlzIHNldCB0byBibGFuayBmb3IgYW4gbnBtIGxpbmsuDQpXaGVuIHRoaXMg
Y29tcGFyZSAiZWxpZiAocmUubWF0Y2gocmVnZXhwLCB1cmlfZGVjb2RlZFtsb2NdKSk6IiBoYXBw
ZW5zIGl0IGlzIGNvbXBhcmluZyAiLyoiIHRvICIiLg0KU2luY2UgdGhleSBkb24ndCBtYXRjaCBp
dCBlbmRzIHVwIHNraXBwaW5nIHRoZSBjaGVjayBmb3IgYSBtaXJyb3IgdGFyYmFsbC4NCg0KVGhl
IGVsaWYgbGluZSBjb3VsZCB0ZXN0IGlmIHVyaV9kZWNvZGVkW2xvY10gaXMgZW1wdHkgb3IgbWF0
Y2hlcy4NCkl0IGNvdWxkIGFsc28gc3RyaXAgb2ZmIHRoZSBsZWFkaW5nICIvIiBmcm9tIHBhdGgg
YW5kIGNvbXBhcmUgIioiIHRvICIiIHdoaWNoIEkgYXNzdW1lIHdvdWxkIHBhc3MuDQpNeSBtYWlu
IGNvbmNlcm4gaXMgZWl0aGVyIG9mIHRob3NlIG1pZ2h0IGJyZWFrIHNvbWV0aGluZyBlbHNlIHVu
cmVsYXRlZC4NCkkgYW0gdHJ5aW5nIHRvIGZpbmQgdGhlIHNtYWxsZXN0IGNoYW5nZSB0aGF0IHdv
bid0IHJ1biB0aGUgcmlzayBvZiBicmVha2luZyBldmVyeXRoaW5nIGVsc2UuDQoNClN0aWxsIG9w
ZW4gdG8gbW9yZSBzdWdnZXN0aW9ucyBvbiBhIGJldHRlciBzb2x1dGlvbiwgYnV0IGlmIHlvdSBs
aWtlIHRoaXMgb25lIEkgY2FuIHNlbmQgYSBmdWxsIGVtYWlsIGRpZmYuDQoNClRoYW5rcywNCk1p
a2UNCg0KDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIvbGliL2Ji
L2ZldGNoMi9fX2luaXRfXy5weQ0KaW5kZXggNzlhODkwNi4uMDk3NTQwOCAxMDA2NDQNCi0tLSBh
L2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCisrKyBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18u
cHkNCkBAIC0zNzMsNiArMzczLDkgQEAgZGVmIGRlY29kZXVybCh1cmwpOg0KICAgICBlbGlmIHR5
cGUubG93ZXIoKSA9PSAnZmlsZSc6DQogICAgICAgICBob3N0ID0gIiINCiAgICAgICAgIHBhdGgg
PSBsb2NhdGlvbg0KKyAgICBlbGlmIHR5cGUubG93ZXIoKSA9PSAnbnBtJzoNCisgICAgICAgIGhv
c3QgPSBsb2NhdGlvbg0KKyAgICAgICAgcGF0aCA9ICIvKiINCiAgICAgZWxzZToNCiAgICAgICAg
IGhvc3QgPSBsb2NhdGlvbg0KICAgICAgICAgcGF0aCA9ICIiDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJkIFB1cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxp
bnV4Zm91bmRhdGlvbi5vcmddIA0KU2VudDogTW9uZGF5LCBNYXkgMTUsIDIwMTcgMTA6MjMgQU0N
ClRvOiBEYXZpcywgTWljaGFlbDsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
DQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gbGliL2JiL2ZldGNoMjogRml4
IG5wbSB0YXJiYWxsIGZldGNoDQoNCk9uIEZyaSwgMjAxNy0wNS0xMiBhdCAyMDo1MiArMDAwMCwg
RGF2aXMsIE1pY2hhZWwgd3JvdGU6DQo+IFRhcmJhbGxzIGdlbmVyYXRlZCBieSBlbmFibGluZyBt
aXJyb3IgdGFyYmFsbHMgY291bGQgbm90IGJlIGZvdW5kIGJ5DQo+IHRoZQ0KPiBmZXRjaCBmb3Ig
dGhlIG5wbS7CoMKgVGhpcyBmaXhlcyBzZXR0aW5nIHRoZSBwYXRoIHZhcmlhYmxlIGluIGRlY29k
ZQ0KPiB1cmwNCj4gc28gdGhleSBjYW4gYmUgbWF0Y2hlZC4NCg0KV291bGQgeW91IGJlIGFibGUg
dG8gcHJvdmlkZSBhbiBleGFtcGxlIG9mIGEgdXJsIHdoaWNoIGlzIGluY29ycmVjdCBhbmQNCndo
YXQgdGhlIGNvcnJlY3QgdmVyc2lvbiB3b3VsZCBiZT8NCg0KSSBnZXQgd29ycmllZCBhYm91dCBm
ZXRjaGVyIHNwZWNpZmljIHVybCBoYW5kbGluZyBhbmQgd2UgcHJvYmFibHkgY291bGQNCmRvIHdp
dGggYWRkaW5nIGEgdGVzdCBjYXNlIGZvciB0aGlzIHRvbyBidXQgaXRzIGhhcmQgdG8gdW5kZXJz
dGFuZA0Kd2l0aG91dCBzZWVpbmcgYW4gZXhhbXBsZSBmYWlsdXJlLg0KDQpDaGVlcnMsDQoNClJp
Y2hhcmQNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIERhdmlzIDxtaWNoYWVsLmRhdmlzQGVz
c3ZvdGUuY29tPg0KPiAtLS0NCj4gwqBsaWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgMiArKw0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9s
aWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiBp
bmRleCAxMzZmYzI5Li4xMTdjODkwIDEwMDY0NA0KPiAtLS0gYS9saWIvYmIvZmV0Y2gyL19faW5p
dF9fLnB5DQo+ICsrKyBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gQEAgLTM5Myw2ICsz
OTMsOCBAQCBkZWYgZGVjb2RldXJsKHVybCk6DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJhaXNlIE1hbGZvcm1lZFVybCh1cmwsICJUaGUgVVJMOiAnJXMnIGlz
DQo+IGludmFsaWQ6IHBhcmFtZXRlciAlcyBkb2VzIG5vdCBzcGVjaWZ5IGEgdmFsdWUgKG1pc3Np
bmcgJz0nKSIgJSAodXJsLA0KPiBzKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHMxLCBzMiA9IHMuc3BsaXQoJz0nKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcFtzMV0gPSBzMg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiB0
eXBlID09ICducG0nIGFuZCBzMSA9PSAnbmFtZSc6DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGF0aCA9ICcvJyArIHMyDQo+IMKgDQo+IMKgwqDCoMKgwqByZXR1
cm4gdHlwZSwgaG9zdCwgdXJsbGliLnBhcnNlLnVucXVvdGUocGF0aCksIHVzZXIsIHBzd2QsIHAN
Cj4gwqANCj4gLS3CoA0KPiAyLjkuMw0K

