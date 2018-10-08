Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0085.outbound.protection.outlook.com [104.47.2.85])
	by mail.openembedded.org (Postfix) with ESMTP id DC1C8799AD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Oct 2018 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jqBrLCvx3oQA83LR8mVunOhR0AWGUAQULVvqei4007A=;
	b=MPurUj+uhaqx8/GAw5fp5yBM7HWROT/9aDlmSgoeHDZOZ9u/5eF485NMUoOsVH4t/6VofVKAgTqYPiGlnjKEkStuG3CAwRnOEVPwL65yuCMfM9AcsYx58oyXhNcDGCIoaKNZs2A1FhltFbgMDDbbzHrPYhbkXbB78rBcHiYgVXE=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB3624.eurprd03.prod.outlook.com (52.134.114.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Mon, 8 Oct 2018 07:20:23 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b%4]) with mapi id 15.20.1207.024;
	Mon, 8 Oct 2018 07:20:23 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 5/7] fetch2/git: prevent access to
	non-existing clonedir
Thread-Index: AQHUWxEweYYjrZ6cDEO93JMOCkmttqUOzoqAgAYqEoA=
Date: Mon, 8 Oct 2018 07:20:23 +0000
Message-ID: <5ebf80a96fefba676f6a436b0cb958cb1abb607b.camel@bbv.ch>
References: <20181003120346.3523-1-urs.fassler@bbv.ch>
	<20181003120346.3523-6-urs.fassler@bbv.ch>
	<32e34671e86114fcff1d18ea5acfe610a2a049ac.camel@linuxfoundation.org>
In-Reply-To: <32e34671e86114fcff1d18ea5acfe610a2a049ac.camel@linuxfoundation.org>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0206.eurprd07.prod.outlook.com
	(2603:10a6:802:3f::30) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.194.183.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB3624;
	6:k4XE/gXUEtUNEIx2WuHslAsD/jq2AbLucYxDsvCMIoo0Qc7EV8E2ZTk/zw20PxRB/fZSvY6v/Oi/CnguWLrMWnQsIqZPF4LjcT8Q/VLU7Ee5JDZ51IuB93RQyi3z0rjccW/kF95+ol9gCrFLCT0GtsSE+dlH1R0HjzR/XkaSpf7qboysYHRmHSz05pqarVP/riLvgmIJblQ6+Spr9P4KLX4yLKJFPFMFWJoUKm+IAAdLYLXu9eFThv+drob/yAWzS5NefA1MfmNE9I70Va7PZdg4Nm3sNs5/EEAuY8xzC6REuXskRBv7AqLRL+7oHrArUPvIw4HacNlXigdGwH7fNJWZagwePXZtOlhPjlR6XD2gsj82zrOiNsMvdLEFP122PBsu8Y5yQURdb6n2GIByS6vs1dnQnko1oYYldCNeGIqaA1DVll3871gENV6lUY4BQJZIMTKrm9nstTa259viLA==;
	5:73b2N9uLArUgcdoTSsi1UKQ//9VuKGT+JOIwBlCalr5r6nTx0ZpIOCxgjt9cQvcIOXAiAe5WfY7XgzXG2L0cbgF6hf/xYEk5H/WAvi18qqIRftZ507MZ1AjTU81RMypKEjx1t9mZvIiTXBxKan7FRiyQ36ThAtIGpaZKHjl5NIo=;
	7:ZuT1Tua7Srd79RWCPKZZUjDvI0Envatd+w6OHLeqQ4kZ47rg2EmIOfmEPbK5+Fp0W8V7PVpMkAunKEWvKTBLQ73BRRRHBL5NSMayfYqNreap/FvucmHM/PXugIZN/jkYfnPvSgQEy8JlJEH+7B4WG/bP3cqEQG2lWxvE7nLYdvNoBwNAMYfgKFbrOPTyCDk8CjqzDbwK3qgsQSK+DHZblvXYtPH9XvtoX/3P3AAHSM/3faGP4ph8EM5+PjYgYtX3
x-ms-office365-filtering-correlation-id: 781417d6-b898-4b48-b559-08d62cee830a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB3624; 
x-ms-traffictypediagnostic: AM6PR03MB3624:
x-microsoft-antispam-prvs: <AM6PR03MB3624FC1886663E72B9CBE3318FE60@AM6PR03MB3624.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB3624; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB3624; 
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39840400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(2900100001)(52116002)(316002)(36756003)(6246003)(6506007)(8676002)(8936002)(386003)(76176011)(33896004)(81166006)(81156014)(71190400001)(71200400001)(66066001)(99286004)(6436002)(5660300001)(478600001)(6486002)(110136005)(6512007)(229853002)(3846002)(118296001)(6116002)(2616005)(85202003)(106356001)(305945005)(2906002)(2501003)(86362001)(476003)(486006)(186003)(105586002)(5250100002)(85182001)(14444005)(256004)(446003)(97736004)(11346002)(7736002)(66574009)(68736007)(25786009)(53936002)(102836004)(74482002)(26005)(14454004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB3624;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: Tp5hcSPP/2lei4iWIUQ50uhd6STQ9QBqhhH+m8al0510gzhbz+oRMlbauwl4W7EZJmqKu1+8Kc5ZcgRKK6X24r8V252obZHjr/AuvpL0Wb4XUQyGCMHBJFoATTnCWJ/XMoT8ldGoRWhIVkIh/i48NPYmKdO1SK+u+beD706LBLHdhh9IBH5YOh9JcjxpRz9D/3kICjbeZ2+obuclyAMt8mhtgKGIr91tajgYoa4tkDZJJS1qjRKhzvXuxsH/LBxF9o6Bn2l6M3A3FbJhK+YKt+O3IhtOuAjroYNz3PeT0iLDGAostlR9B/Yo2CuqBJ+VI/rxqsdJ7DH1sMICxnQim9VDWMnJzSZUpxAbRblcp6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 781417d6-b898-4b48-b559-08d62cee830a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 07:20:23.5602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3624
Subject: Re: [PATCH 5/7] fetch2/git: prevent access to non-existing clonedir
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
X-List-Received-Date: Mon, 08 Oct 2018 16:53:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F41896D4801F94E9B3E177C80A86A25@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDE4LTEwLTA0IGF0IDEwOjEyICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDE4LTEwLTAzIGF0IDEyOjA0ICswMDAwLCBVcnMgRsOkc3NsZXIgd3JvdGU6
DQo+ID4gQSB1c2VyIGZyaWVuZGx5IGVycm9yIGlzIHRocm93IHdoZW4gbmVpdGhlciB0aGUgY2xv
bmVkaXIgbm9yDQo+ID4gZnVsbHNoYWxsb3cgZXhpc3QuIFdpdGhvdXQgdGhlIGNoZWNrLCBhIGRp
ZmZpY3VsdCB0byBpbnRlcnByZXQNCj4gPiBlcnJvcg0KPiA+IGlzIHRocm93IGZyb20gd2l0aGlu
IHRoZSBmZXRjaCBjb21tYW5kLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFVycyBGw6Rzc2xl
ciA8dXJzLmZhc3NsZXJAYmJ2LmNoPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhc2NhbCBCYWNoIDxw
YXNjYWwuYmFjaEBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL2JiL2ZldGNoMi9naXQu
cHkgIHwgIDQgKysrLQ0KPiA+ICBsaWIvYmIvdGVzdHMvZmV0Y2gucHkgfCAxMyArKysrKysrKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5weSBiL2xpYi9iYi9m
ZXRjaDIvZ2l0LnB5DQo+ID4gaW5kZXggZjEzYTI1ZjkuLmZiZDMwMDExIDEwMDY0NA0KPiA+IC0t
LSBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQo+ID4gKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkN
Cj4gPiBAQCAtNDc5LDggKzQ3OSwxMCBAQCBjbGFzcyBHaXQoRmV0Y2hNZXRob2QpOg0KPiA+ICAg
ICAgICAgIGlmIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3RzKHVkLmZ1bGxzaGFsbG93KSBh
bmQNCj4gPiBzZWxmLmNsb25lZGlyX25lZWRfdXBkYXRlKHVkLCBkKToNCj4gPiAgICAgICAgICAg
ICAgYmIudXRpbHMubWtkaXJoaWVyKGRlc3RkaXIpDQo+ID4gICAgICAgICAgICAgIHJ1bmZldGNo
Y21kKCJ0YXIgLXh6ZiAlcyIgJSB1ZC5mdWxsc2hhbGxvdywgZCwNCj4gPiB3b3JrZGlyPWRlc3Rk
aXIpDQo+ID4gLSAgICAgICAgZWxzZToNCj4gPiArICAgICAgICBlbGlmIG5vdCBzZWxmLmNsb25l
ZGlyX25lZWRfdXBkYXRlKHVkLCBkKToNCj4gPiAgICAgICAgICAgICAgcnVuZmV0Y2hjbWQoIiVz
IGNsb25lICVzICVzLyAlcyIgJSAodWQuYmFzZWNtZCwNCj4gPiB1ZC5jbG9uZWZsYWdzLCB1ZC5j
bG9uZWRpciwgZGVzdGRpciksIGQpDQo+ID4gKyAgICAgICAgZWxzZToNCj4gPiArICAgICAgICAg
ICAgYmIuZmF0YWwoIm5vIHVwIHRvIGRhdGUgc291cmNlIGZvdW5kIikNCj4gDQo+IEkgYXBwcmVj
aWF0ZSB0aGVyZSBhcmUgb3RoZXIgcGxhY2VzIHRoZSBmZXRjaGVyIGNvZGUgY2FsbHMgYmIuZmF0
YWwoKQ0KPiBidXQgdGhpcyBpcyBwcm9ibGVtYXRpYy4NCj4gDQo+IFRoZSBpbnRlbnQgaXMgdG8g
bWFrZSB0aGUgZmV0Y2hlciBjb2RlIGEgbGlicmFyeSB3aGljaCBvdGhlciBjb2RlDQo+IGNhbGwN
Cj4gY2FsbCBpbnRvIGFuZCB0aGlzIGlzIGFscmVhZHkgaG93IE9FIHRyZWF0cyBpdC4gUHl0aG9u
IGxpYnJhcmllcw0KPiBzaG91bGQNCj4gcmFpc2UgZXhjZXB0aW9ucyBvbiBlcnJvcnMgYW5kIGFs
bG93IHRoZSBwYXJlbnQgY29kZSB0byBoYW5kbGUgaXQsDQo+IG5vdA0KPiByYWlzZSBTeXN0ZW1F
eGl0KCkgZXhjZXB0aW9ucy4NCj4gDQo+IElzIHRoZXJlIHNvbWUgb3RoZXIgd2F5IHdlIGNhbiBy
YWlzZSBhIGRlY2VudCBlcnJvciBldmVuIGlmIG1lYW5zDQo+IGFkZGluZyBhIG5ldyBleGNlcHRp
b24gKHdoaWNoIGNhbiBzdWJjbGFzcyBvbmUgb2YgdGhlIG90aGVyIGZldGNoDQo+IGV4Y2VwdGlv
bnMpPw0KDQpUaGVyZSBpcyB0aGUgVW5wYWNrRXJyb3IgZXhjZXB0aW9uIGZvciAiR2VuZXJhbCBm
ZXRjaGVyIGV4Y2VwdGlvbiB3aGVuDQpzb21ldGhpbmcgaGFwcGVucyBpbmNvcnJlY3RseSB3aGVu
IHVucGFja2luZyIgSSBjYW4gdXNlLg0KDQpXaGVuIEkgdXNlIGV4Y2VwdGlvbnMsIEkgZG9uJ3Qg
bmVlZCB0aGUgTG9nUmVjb3JkIGNsYXNzIEkgZXh0cmFjdGVkIGluDQpwYXRjaCAiW1BBVENIIDQv
N10gdGVzdHMvZGF0YTogZXh0cmFjdCBMb2dSZWNvcmQgaW50byBvd24gZmlsZSINCmFueW1vcmUu
DQpJIGFtIG5vdCBzdXJlIGlmIEkgc2hvdWxkIHJlbW92ZSB0aGF0IGZyb20gdGhlIHBhdGNoLXNl
dCBzaW5jZSBpdCBpcw0KdW5yZWxhdGVkLiBCdXQgaXQgaW1obyBpbXByb3ZlcyB0aGUgY29kZSBi
YXNlIGEgYml0Lg0KDQpSZWdhcmRzDQpVcnMNCg0KDQo=

