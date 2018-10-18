Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0045.outbound.protection.outlook.com [104.47.2.45])
	by mail.openembedded.org (Postfix) with ESMTP id D0BA779C5F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AoRxmWsDjYT0wuO3vPjlt3Lbaj4pEE5S0HN1LgSkqFk=;
	b=k5HrtkwdIzMkaj/gUBvvbWpBnnw3MLefP/+PR78TeWFy/fXKKt3rF982W3b+YIQI/BLaBrhFnPQPbm4S5Ob2/+Gfy6InOcpt2Iv6Xnmt5kH5k0l13Joh05neneQsbVcfmB+q4PmIwZOaZqPTPy+qTqCo9epxlXJdTTp5Ag1diuU=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4039.eurprd03.prod.outlook.com (20.177.38.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.24; Thu, 18 Oct 2018 09:41:01 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.032;
	Thu, 18 Oct 2018 09:41:01 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 2/2] fetch2: add symlink for shallow
	mirror tarballs
Thread-Index: AQHUZsauYzglkNfwyUuIiP+yua7X+w==
Date: Thu, 18 Oct 2018 09:41:01 +0000
Message-ID: <20181018094051.20530-3-urs.fassler@bbv.ch>
References: <20181018094051.20530-1-urs.fassler@bbv.ch>
In-Reply-To: <20181018094051.20530-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: AM5PR0601CA0046.eurprd06.prod.outlook.com
	(2603:10a6:203:68::32) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.194.219.88]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4039;
	6:uLkG3HpQFdFCr30Oi8QKkE1bFxBRhxi29nugi67YrKrXLXzxhVyT1xYVPaPIkIDzLC5zSQtQu9/LTbor8REAsPV729UUMfDtDS4zmqYm3xFdChrNiNmOB/3A4LIerZ7dWZ1GRyLDdODkMzZnYAodp9E0mR4Fb64a+ujRpLznS0/PBvnxkCMBozWIiGxCnvvzVaE7cyksHib8u23ZFKKZ/VIkJT0u+qxYxbd4YYZ0d1yMTGZz8YORJmdg2Su0jDs3bMFAD1TfSheEn+7ayQbid7pa1LBCJ8hmHLpd7wVi8oViFM2y2KWF4l84UsNW6afmVQeO5Xh7LJC+NXqqODqK+LdxrPE40WIZVkPCGvJw3GH+SbAwWTk4VssENZ4RZC8Qlmm1rXY6rnunb2yDDkiOfQLJ0R8+9aWtE5v91dQ7HLYBlw8Nc39B5iehilPrflWhH/D18KpVi5Yii31MuyreVg==;
	5:6yr2EXNFLficCkQc6/Pe9vt+HCgRvUeXrxLEHYmOyLuP1KhqXgyKsRwpqhGVhlB1Xv4iUawu79+WlK2tPmZYnqnCcJsV0jM2Zm2dN0JVuW7T2ocYFZcjLuq6wbhuR/x3P8xYrom4KjqQSuKc75dJV6ss0I4QlN1NiaigPEL0pLw=;
	7:g0n8RND6a46tnpoXaG4Ly/b+0YwMz9xTMG36AS+tuROiJxGkTgZT2mDd+GHueaIV40DOS4RsKOgVdE9vwsUQimTp/YZw7Hbjw/cokLybPMGfv8Qc0CGKBIyti/lql3HL6xgHge8ow/ii+1jvuv/Y1IVBqNp19JsSC0rSxw6SufIlHsP6kUv/0VGq5n5DVbiItYE+iR0plZF5JZnm7COtoN1oAHts9bbmEfP1sbbryIBwtRRyTfuaNKI3O9mcob2e
x-ms-office365-filtering-correlation-id: 9545bd06-655c-4628-7db1-08d634ddd0ab
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4039; 
x-ms-traffictypediagnostic: AM6PR03MB4039:
x-microsoft-antispam-prvs: <AM6PR03MB4039BA2D782B052AC39B30AF8FF80@AM6PR03MB4039.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
	SRVR:AM6PR03MB4039; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4039; 
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(396003)(346002)(39850400004)(376002)(366004)(136003)(199004)(189003)(2501003)(8936002)(71190400001)(25786009)(316002)(6512007)(71200400001)(86362001)(575784001)(54906003)(4326008)(5660300001)(66574009)(1076002)(68736007)(50226002)(36756003)(478600001)(85202003)(76176011)(81166006)(99286004)(2351001)(105586002)(106356001)(6486002)(8676002)(386003)(305945005)(33896004)(6506007)(7736002)(6916009)(5640700003)(14454004)(52116002)(486006)(6436002)(102836004)(186003)(1857600001)(97736004)(2900100001)(11346002)(74482002)(2616005)(66066001)(476003)(26005)(85182001)(6116002)(2906002)(14444005)(3846002)(256004)(53936002)(5250100002)(81156014)(446003)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4039;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: jgl6OpPmwcizVUsHgFi7Yl+MZvA8TIB3nku93ePJV45dK0xKBewl2TL9uds18Hyu/K1hskk8u7ExlKHS/40hy+ptlbS0gPu8wo+gp3mFSUWCGcTMIIJITqSz6LOI7BLQVr6GuO7LY0uqimNn36wn42RDjhoQmvlTrn1HOfRYAbtaHHqqhA1rDsXU7yiOvZEPOATq3sfEuA0ClBMg/7rg9EdUg5DMI3+hpg8lLpWfq7ySDjJQU8nAwmbuSWtJENR5NJr7gAEyy2I5lnYJ3xFXIuYWgwE1ql1aHi1hAY2GYVy4UyNrTpGemBz0FhsxfSXeGeaEMVqkhLobw++X3lHv+0nkXINfk4BMNJ/IVdZmiOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 9545bd06-655c-4628-7db1-08d634ddd0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 09:41:01.5476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4039
Subject: [PATCH v2 2/2] fetch2: add symlink for shallow mirror tarballs
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
X-List-Received-Date: Fri, 19 Oct 2018 00:12:10 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5E5C1FAF033942A5B3FA184C643808@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SW4gdGhlIHVucGFjayBzdGVwIHRoZSBzaGFsbG93IG1pcnJvciB0YXJiYWxsIGlzIG5vdCBmb3Vu
ZCB3aGVuIHRoZQ0KbWlycm9yZWQgdGFyYmFsbCBpcyBuYW1lZCBkaWZmZXJlbnRseSB0aGFuIHRo
ZSBvcmlnaW5hbCB0YXJiYWxsLiBUaGlzDQpoYXBwZW5zIGR1ZSB0byBtaXJyb3IgcmV3cml0ZSBy
dWxlcy4gVG8gc29sdmUgdGhlIHByb2JsZW0gd2UgYWRkDQpzeW1saW5rcyBmb3IgdGhlIGRpZmZl
cmVudGx5IG5hbWVkIHRhcmJhbGxzLg0KDQpTaWduZWQtb2ZmLWJ5OiBVcnMgRsOkc3NsZXIgPHVy
cy5mYXNzbGVyQGJidi5jaD4NClNpZ25lZC1vZmYtYnk6IFBhc2NhbCBCYWNoIDxwYXNjYWwuYmFj
aEBzaWVtZW5zLmNvbT4NCi0tLQ0KIGxpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgfCAgMiArKw0K
IGxpYi9iYi90ZXN0cy9mZXRjaC5weSAgICAgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgYi9saWIvYmIvZmV0Y2gyL19faW5p
dF9fLnB5DQppbmRleCA4NGQyYWY3My4uOTk1MjBlODIgMTAwNjQ0DQotLS0gYS9saWIvYmIvZmV0
Y2gyL19faW5pdF9fLnB5DQorKysgYi9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQpAQCAtMTAy
Miw2ICsxMDIyLDggQEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQsIHVkLCBsZCwg
Y2hlY2sgPSBGYWxzZSk6DQogDQogICAgICAgICBpZiBoYXNhdHRyKHVkLCAiZnVsbG1pcnJvciIp
IGFuZCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsbWlycm9yKToNCiAgICAgICAgICAgICBlbnN1cmVf
c3ltbGluayh1ZC5mdWxsbWlycm9yLCBvcmlndWQuZnVsbG1pcnJvcikNCisgICAgICAgIGlmIGhh
c2F0dHIodWQsICJzaGFsbG93IikgYW5kIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3RzKHVk
LmZ1bGxzaGFsbG93KToNCisgICAgICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5mdWxsc2hhbGxv
dywgb3JpZ3VkLmZ1bGxzaGFsbG93KQ0KIA0KICAgICAgICAgdXBkYXRlX3N0YW1wKG9yaWd1ZCwg
bGQpDQogICAgICAgICByZXR1cm4gdWQubG9jYWxwYXRoDQpkaWZmIC0tZ2l0IGEvbGliL2JiL3Rl
c3RzL2ZldGNoLnB5IGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQppbmRleCAwYzYzODJhMi4uZmMx
NWVlNDcgMTAwNjQ0DQotLS0gYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCisrKyBiL2xpYi9iYi90
ZXN0cy9mZXRjaC5weQ0KQEAgLTU5NSw2ICs1OTUsMjEgQEAgY2xhc3MgR2l0U2hhbGxvd1RhcmJh
bGxOYW1pbmdUZXN0KEZldGNoZXJUZXN0KToNCiAgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2Vs
Zi5kbGRpcikNCiAgICAgICAgIHNlbGYuYXNzZXJ0SW4oc2VsZi5taXJyb3JfdGFyYmFsbCwgZGly
KQ0KIA0KKyAgICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF90YXJiYWxs
X2V4aXN0c19mb3JfbWlycm9yZWRfdXJsX2FuZF9yZWNpcGVfdXJsX3doZW5fbWlycm9yaW5nX2lz
X3VzZWRfYW5kX3RoZV9taXJyb3JlZF90YXJiYWxsX2FscmVhZHlfZXhpc3RzKHNlbGYpOg0KKyAg
ICAgICAgc2VsZi5zZXR1cF9taXJyb3JfcmV3cml0ZSgpDQorICAgICAgICBmZXRjaGVyID0gYmIu
ZmV0Y2guRmV0Y2goW3NlbGYubWlycm9yX3VybF0sIHNlbGYuZCkNCisgICAgICAgIGZldGNoZXIu
ZG93bmxvYWQoKQ0KKyAgICAgICAgYmIudXRpbHMucHJ1bmVkaXIoc2VsZi5kbGRpciArICcvZ2l0
MicpDQorICAgICAgICBiYi51dGlscy5wcnVuZWRpcihzZWxmLnVucGFja2RpcikNCisgICAgICAg
IGZldGNoZXIgPSBiYi5mZXRjaC5GZXRjaChbc2VsZi5yZWNpcGVfdXJsXSwgc2VsZi5kKQ0KKw0K
KyAgICAgICAgZmV0Y2hlci5kb3dubG9hZCgpDQorDQorICAgICAgICBkaXIgPSBvcy5saXN0ZGly
KHNlbGYuZGxkaXIpDQorICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYubWlycm9yX3RhcmJhbGws
IGRpcikNCisgICAgICAgIHNlbGYuYXNzZXJ0SW4oc2VsZi5yZWNpcGVfdGFyYmFsbCwgZGlyKQ0K
Kw0KIA0KIGNsYXNzIEZldGNoZXJMb2NhbFRlc3QoRmV0Y2hlclRlc3QpOg0KICAgICBkZWYgc2V0
VXAoc2VsZik6DQpAQCAtMTc4MSwzICsxNzk2LDMyIEBAIGNsYXNzIEdpdFNoYWxsb3dUZXN0KEZl
dGNoZXJUZXN0KToNCiANCiAgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi51bnBhY2tkaXIg
KyAiL2dpdC8iKQ0KICAgICAgICAgc2VsZi5hc3NlcnRJbigiZnN0ZXN0cy5kb2FwIiwgZGlyKQ0K
Kw0KKyAgICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF91bnBhY2tfdXNl
c190aGVfZ2l0X3NoYWxsb3dfdGFyYmFsbF93aGVuX3VzaW5nX21pcnJvcl9yZXdyaXRlX3J1bGVz
X2FuZF90aGVfZ2l0X2Nsb25lX2RvZXNfbm90X2V4aXN0KHNlbGYpOg0KKyAgICAgICAgc2VsZi5k
LnNldFZhcignU1JDUkVWJywgJ2U1OTM5ZmY2MDhiOTVjZGQ0ZDBhYjBlMTkzNTc4MWFiOWEyNzZh
YzAnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignQkJfR0lUX1NIQUxMT1cnLCAnMScpDQorICAg
ICAgICBzZWxmLmQuc2V0VmFyKCdCQl9HRU5FUkFURV9TSEFMTE9XX1RBUkJBTExTJywgJzEnKQ0K
KyAgICAgICAgc2VsZi5kLnNldFZhcignUFJFTUlSUk9SUycsICdnaXQ6Ly9naXQueW9jdG9wcm9q
ZWN0Lm9yZy8uKiBnaXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9naXQvUEFUSDtwcm90b2NvbD1o
dHRwcyBcbicpDQorICAgICAgICBmZXRjaGVyID0gYmIuZmV0Y2guRmV0Y2goWyJnaXQ6Ly9naXQu
eW9jdG9wcm9qZWN0Lm9yZy9mc3Rlc3RzIl0sIHNlbGYuZCkNCisgICAgICAgIGZldGNoZXIuZG93
bmxvYWQoKQ0KKyAgICAgICAgYmIudXRpbHMucmVtb3ZlKHNlbGYuZGxkaXIgKyAnL2dpdDInLCBy
ZWN1cnNlPVRydWUpDQorDQorICAgICAgICBmZXRjaGVyLnVucGFjayhzZWxmLnVucGFja2RpcikN
CisNCisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi51bnBhY2tkaXIgKyAiL2dpdC8iKQ0K
KyAgICAgICAgc2VsZi5hc3NlcnRJbigiZnN0ZXN0cy5kb2FwIiwgZGlyKQ0KKw0KKyAgICBAc2tp
cElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF9ub19icm9rZW5fc3ltbGlua3NfZXhp
c3Rfd2hlbl91c2luZ19taXJyb3JfcmV3cml0ZV9ydWxlc19hbmRfbWlycm9yX3RhcmJhbGxfaXNf
Y29uZmlndXJlZChzZWxmKToNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ1NSQ1JFVicsICdlNTkz
OWZmNjA4Yjk1Y2RkNGQwYWIwZTE5MzU3ODFhYjlhMjc2YWMwJykNCisgICAgICAgIHNlbGYuZC5z
ZXRWYXIoJ0JCX0dJVF9TSEFMTE9XJywgJzEnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignQkJf
R0VORVJBVEVfTUlSUk9SX1RBUkJBTExTJywgJzEnKQ0KKyAgICAgICAgc2VsZi5kLmRlbFZhcign
QkJfR0VORVJBVEVfU0hBTExPV19UQVJCQUxMUycpDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdQ
UkVNSVJST1JTJywgJ2dpdDovL2dpdC55b2N0b3Byb2plY3Qub3JnLy4qIGdpdDovL2dpdC55b2N0
b3Byb2plY3Qub3JnL2dpdC9QQVRIO3Byb3RvY29sPWh0dHBzIFxuJykNCisgICAgICAgIGZldGNo
ZXIgPSBiYi5mZXRjaC5GZXRjaChbImdpdDovL2dpdC55b2N0b3Byb2plY3Qub3JnL2ZzdGVzdHMi
XSwgc2VsZi5kKQ0KKw0KKyAgICAgICAgZmV0Y2hlci5kb3dubG9hZCgpDQorDQorICAgICAgICBi
cm9rZW5fc3ltbGlua3MgPSBnZXRfYnJva2VuX3N5bWxpbmtzKHNlbGYuZGxkaXIpDQorICAgICAg
ICBzZWxmLmFzc2VydEVxdWFsKFtdLCBicm9rZW5fc3ltbGlua3MpDQotLSANCjIuMTkuMQ0KDQo=

