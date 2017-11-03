Return-Path: <Javier.Viguera@digi.com>
X-Greylist: delayed 403 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 03 Nov 2017 11:23:45 UTC
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.9])
	by mail.openembedded.org (Postfix) with ESMTP id EF13470016
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Nov 2017 11:23:45 +0000 (UTC)
Received: from [216.82.249.147] by server-9.bemta-12.messagelabs.com id
	BE/03-02035-F205CF95; Fri, 03 Nov 2017 11:17:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleJIrShJLcpLzFFi42Jx8l0noKsf8Cf
	SYO5bYYvrR0MdGD3ObVzBGMAYxZqZl5RfkcCacW2yfsE2pYovr04wNjD+Uexi5OIQEljJKHF4
	zRuWLkZOIGcxo8TlH/IgNpuAocSET5/YQGwRgSCJTx9bwGqEBVIkJn55zggRT5VY8/83K4RtJ
	LH+9EGwGhYBFYl3De/Zuxg5OHgFfCXWvLWBGB8jMf3OH2YQm1PAROL7+Wlg4xkFZCW+NK4Giz
	MLiEvcejKfCcSWEBCQWLLnPDOELSrx8vE/VghbQWJhxzlmkPHMApoS63fpQ7QqSkzpfsgOYvM
	KCEqcnPkE6isViQ03fjNNYBSZhWTDLITuWUi6ZyHpXsDIsopRozi1qCy1SNfYUC+pKDM9oyQ3
	MTNH19DQSC83tbg4MT01JzGpWC85P3cTIzAa6hkYGHcw/vnie4hRkoNJSZT37sZfkUJ8Sfkpl
	RmJxRnxRaU5qcWHGGU4OJQkeA39/0QKCRalpqdWpGXmAOMSJi3BwaMkwnvODyjNW1yQmFucmQ
	6ROsVoyfHoxt0/TBxPrs37y8TxbObrBmYhlrz8vFQpcV4rkHkCIA0ZpXlw42Cp4xKjrJQwLyM
	DA4MQT0FqUW5mCar8K0ZxDkYlYd4okCk8mXklcFtfAR3EBHTQbA6wg0oSEVJSDYxNLzvywxxF
	e8/wbm7LkuQ3d158aHHQNidT07173/eHtRqnWO36Y7b7afhtlVDXyQFPWv93Pnj6WmOWxH6Z5
	/kiUxb5JP+VdLv12m1V1M7n/AKRxdx3vvxv4V1zmW+vyscdf/ZPeqBbl+R2LjNA9MtRo22367
	pDen5m66U+2LI1c6r7eQXDfTuUWIozEg21mIuKEwG+EeYxGAMAAA==
X-Env-Sender: Javier.Viguera@digi.com
X-Msg-Ref: server-11.tower-29.messagelabs.com!1509707822!72966507!1
X-Originating-IP: [66.77.174.16]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26010 invoked from network); 3 Nov 2017 11:17:03 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
	by server-11.tower-29.messagelabs.com with SMTP;
	3 Nov 2017 11:17:03 -0000
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MCL-VMS-XCH01.digi.com
	(10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.361.1;
	Fri, 3 Nov 2017 06:17:00 -0500
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
	DOR-VMS-XCH01.digi.com ([::1]) with mapi id 14.03.0361.001;
	Fri, 3 Nov 2017 12:16:58 +0100
From: "Viguera, Javier" <Javier.Viguera@digi.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [1.34][PATCH] Replace deprecated git branch
	parameter "--set-upstream"
Thread-Index: AQHTR92T0SA8DKRYsEaj4kKOEp20UqMCmHPg
Date: Fri, 3 Nov 2017 11:16:57 +0000
Message-ID: <DA8287CC96892A4EB4FCF4FB3FBDA1AB016B4688@dor-sms-xch01.digi.com>
References: <20171017133121.19524-1-git@andred.net>
	<20171018065135.22771-1-git@andred.net>
In-Reply-To: <20171018065135.22771-1-git@andred.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.2.195]
MIME-Version: 1.0
Subject: Re: [1.34][PATCH] Replace deprecated git branch	parameter "--set-upstream"
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
X-List-Received-Date: Fri, 03 Nov 2017 11:23:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpMYXN0IG5pZ2h0IFVidW50dSAxNiB1cGRhdGVkIGdpdCB0byB2ZXJzaW9uIDIu
MTUsIGFuZCBub3cgdGhpcyBpcyBiaXRpbmcgdXMgKGFuZCBJIGd1ZXNzIG1hbnkgb3RoZXIgcGVv
cGxlIGluIHRoZSB3aWxkKSBvbiByZWxlYXNlcyBiYXNlZCBvbiBNb3J0eSBhbmQgSmV0aHJvLg0K
DQpJIGRpZCBhIGJhc2ljIHRlc3QgYW5kIGZvciBiaXRiYWtlIDEuMzIgKFBva3kgTW9ydHkpIGFu
ZCAxLjM0IChQb2t5IFB5cm8pICBhIHNpbXBsZSBjaGVycnktcGljayB3b3JrcyBqdXN0IGZpbmUg
d2l0aG91dCBjb25mbGljdHM6DQoNCmdpdCBjaGVycnktcGljayAteCAyYWI1MDA3NGMxYTZjNTZh
OGExNzg3NTVkZTEwODQ0N2Q3YjdhY2FmDQoNClNvIGNvdWxkIHNvbWVvbmUgZG8gdGhvc2UgY2hl
cnJ5LXBpY2tzIGluIGJpdGJha2UgYW5kIHRoZW4gbW92ZSB0aG9zZSBmaXhlcyB0byBQb2t5IFB5
cm8gYW5kIE1vcnR5IHN0YWJsZSBicmFjaGVzPw0KDQpGb3IgcHJldmlvdXMgdmVyc2lvbnMgdGhl
IGNoZXJyeS1waWNrIGRvZXMgbm90IGFwcGx5IGNsZWFubHkuIEknbGwgdHJ5IHRvIGZpbmQgdGhl
IHRpbWUgYW5kIHNlbmQgYSBwcm9wZXIgcGF0Y2ggZm9yIDEuMzAgKEtyb2dvdGgpIGFuZCAxLjI4
IChKZXRocm8pLg0KDQpUaGFua3MgaW4gYWR2YW5jZS4NCg0KLS0NCkphdmllciBWaWd1ZXJhDQpT
b2Z0d2FyZSBFbmdpbmVlcg0KRGlnaSBJbnRlcm5hdGlvbmFswq4gU3BhaW4gUy5BLlUuDQoNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGJpdGJha2UtZGV2ZWwtYm91bmNlc0Bs
aXN0cy5vcGVuZW1iZWRkZWQub3JnIFttYWlsdG86Yml0YmFrZS1kZXZlbC1ib3VuY2VzQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmddIE9uIEJlaGFsZiBPZiBBbmRyw6kgRHJhc3ppaw0KU2VudDogV2Vk
bmVzZGF5LCBPY3RvYmVyIDE4LCAyMDE3IDg6NTIgQU0NClRvOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNClN1YmplY3Q6IFtiaXRiYWtlLWRldmVsXSBbMS4zNF1bUEFUQ0hd
IFJlcGxhY2UgZGVwcmVjYXRlZCBnaXQgYnJhbmNoIHBhcmFtZXRlciAiLS1zZXQtdXBzdHJlYW0i
DQoNCkZyb206IEFuZHJlIFJvc2EgPGFuZHJlLnJvc2FAbGdlLmNvbT4NCg0KU2luY2UgMjAxNy0w
OC0xNyAoZ2l0IHZlcnNpb24gMi4xNC4xLjQ3My5nM2VjN2Q3MDJhKSB1c2luZyBkZXByZWNhdGVk
IGdpdCBicmFuY2ggcGFyYW1ldGVyICItLXNldC11cHN0cmVhbSIgY2F1c2VzIGEgZmV0Y2hlciBl
cnJvci4gUmVwbGFjZSBpdCBieSAiLS1zZXQtdXBzdHJlYW0tdG8iLg0KDQpodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vZ2l0L2dpdC5naXQvY29tbWl0Lz9pZD01MjY2ODg0NmVhMmQ0MWZm
YmQ4N2NkYTdjYjhlNDkyZGVhOWYyYzRkDQpzYXlzLCBpdCdzIGRlcHJlY2F0ZWQgc2luY2UgMjAx
Mi0wOC0zMCBzbyBob3BlZnVsbHkgYWxsIHN0aWxsIHN1cHBvcnRlZCBob3N0IGRpc3RyaWJ1dGlv
bnMgaGF2ZSBuZXcgZW5vdWdoIGdpdCB0byBzdXBwb3J0ICItLXNldC11cHN0cmVhbS10byIuDQoN
CkVSUk9SOiBQQUNLQUdFIGRvX3VucGFjazogRmV0Y2hlciBmYWlsdXJlOiAuLi47IGdpdCAtYyBj
b3JlLmZzeW5jb2JqZWN0ZmlsZXM9MCBicmFuY2ggLS1zZXQtdXBzdHJlYW0gbWFzdGVyIG9yaWdp
bi9tYXN0ZXIgZmFpbGVkIHdpdGggZXhpdCBjb2RlIDEyOCwgb3V0cHV0Og0KZmF0YWw6IHRoZSAn
LS1zZXQtdXBzdHJlYW0nIG9wdGlvbiBpcyBubyBsb25nZXIgc3VwcG9ydGVkLiBQbGVhc2UgdXNl
ICctLXRyYWNrJyBvciAnLS1zZXQtdXBzdHJlYW0tdG8nIGluc3RlYWQuDQoNCkVSUk9SOiBQQUNL
QUdFIGRvX3VucGFjazogRnVuY3Rpb24gZmFpbGVkOiBiYXNlX2RvX3VucGFjaw0KDQpTaWduZWQt
b2ZmLWJ5OiBBbmRyZSBSb3NhIDxhbmRyZS5yb3NhQGxnZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBN
YXJ0aW4gSmFuc2EgPE1hcnRpbi5KYW5zYUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCg0KKGNoZXJy
eSBwaWNrZWQgZnJvbSBjb21taXQgMmFiNTAwNzRjMWE2YzU2YThhMTc4NzU1ZGUxMDg0NDdkN2I3
YWNhZikNClNpZ25lZC1vZmYtYnk6IEFuZHLDqSBEcmFzemlrIDxhZHJhc3ppa0B0eWNvaW50LmNv
bT4NCi0tLQ0KIGxpYi9iYi9mZXRjaDIvZ2l0LnB5IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNo
Mi9naXQucHkgYi9saWIvYmIvZmV0Y2gyL2dpdC5weSBpbmRleCAyNTUwYmRlOC4uNzQ0MmY4NDQg
MTAwNjQ0DQotLS0gYS9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9n
aXQucHkNCkBAIC0zMjYsNyArMzI2LDcgQEAgY2xhc3MgR2l0KEZldGNoTWV0aG9kKToNCiAgICAg
ICAgICAgICAgICAgYnJhbmNobmFtZSA9ICB1ZC5icmFuY2hlc1t1ZC5uYW1lc1swXV0NCiAgICAg
ICAgICAgICAgICAgcnVuZmV0Y2hjbWQoIiVzIGNoZWNrb3V0IC1CICVzICVzIiAlICh1ZC5iYXNl
Y21kLCBicmFuY2huYW1lLCBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVkLnJldmlz
aW9uc1t1ZC5uYW1lc1swXV0pLCBkLCB3b3JrZGlyPWRlc3RkaXIpDQotICAgICAgICAgICAgICAg
IHJ1bmZldGNoY21kKCIlcyBicmFuY2ggLS1zZXQtdXBzdHJlYW0gJXMgb3JpZ2luLyVzIiAlICh1
ZC5iYXNlY21kLCBicmFuY2huYW1lLCBcDQorICAgICAgICAgICAgICAgIHJ1bmZldGNoY21kKCIl
cyBicmFuY2ggJXMgLS1zZXQtdXBzdHJlYW0tdG8gb3JpZ2luLyVzIiANCisgJSAodWQuYmFzZWNt
ZCwgYnJhbmNobmFtZSwgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmFuY2huYW1l
KSwgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KICAgICAgICAgICAgIGVsc2U6DQogICAgICAgICAgICAg
ICAgIHJ1bmZldGNoY21kKCIlcyBjaGVja291dCAlcyIgJSAodWQuYmFzZWNtZCwgdWQucmV2aXNp
b25zW3VkLm5hbWVzWzBdXSksIGQsIHdvcmtkaXI9ZGVzdGRpcikNCi0tDQoyLjE1LjAucmMxDQoN
Ci0tDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYml0
YmFrZS1kZXZlbCBtYWlsaW5nIGxpc3QNCmJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KaHR0cDovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbWFpbG1hbi9saXN0aW5mby9iaXRi
YWtlLWRldmVsDQo=

