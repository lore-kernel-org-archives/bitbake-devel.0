Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0076.outbound.protection.outlook.com [104.47.2.76])
	by mail.openembedded.org (Postfix) with ESMTP id BF60479479
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YVgztFdTNahqt0mli3O+ZlGGoGN57pSwJzYGPUWK7Ls=;
	b=k37K7pcbNJnqA6NLeopG/btkNONm7D4P9pN3a+I3gF6BdoZlkY/dM8wFKbatyruuz1DUOBZgnkKpT/MS2OcWhjDA9kWbvtDEwIr03bSoRKpFtz7/xAP95khe29oWdPUsFnPwzEGXbtdoVbIasnLQhFsDBDiVhVXsOM1tNb2hi34=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:22 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:22 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 7/7] fetch2: add symlink for shallow
	mirror tarballs
Thread-Index: AQHUZI0KLVwxMSkDBE+3aIPErClY+w==
Date: Mon, 15 Oct 2018 13:43:22 +0000
Message-ID: <20181015134255.4634-8-urs.fassler@bbv.ch>
References: <20181015134255.4634-1-urs.fassler@bbv.ch>
In-Reply-To: <20181015134255.4634-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
	(2603:10a6:803:78::18) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.160.33.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4421;
	6:ybUpnSr0AHDGShj4OOzztuP6Rjpx5ImJh3AFfIiDMpJGkzcK4QM8NrQC41DUH40hr9ym0szizz4oOwUzIi7+//lZIjcjqnpoKp86X5jlBMkcZqb4zHs2CBl+J5PN8yyOA1FFp05SUJZOE00eocYUdBNIYscV9+vq5DPg/WBr3XP0LFK8OWqg3vXBRXdXGLmbFOLS7S5cs33UPEPOTtMcJxcImduuOxkv5l/tTVmVBsW+5DSJpB/VT/zIWYK+SoB5jPllmpHaMAPFhJY8Uu8uFxqb9rf/QPIC9KyfPoF9x68W0A/QGzzhATTrs3HpE4Ga8YtpW/xVhY1OHKKodpHiqRvBlPwEI3rKLkzVTo9/3oa/u7D+0XZXJF9sKC+jBdkLfjWDZ1Vct8D5qnEPhZ78BSY0jFnuAIoW9cECTOaHxPbALEcIrmEBWLB+B7tOB9iuifXZRCtblmvg81cjhCteqA==;
	5:cIsPZz5TJC1jS+nPXMPry8a2uymYAru40vJ9v4idwcHbQIjpqiRNV7CqQ02dX2Ny2GES4NIb7ap76xWGKgeHhPhfOKUuLMFX77sNrvPmPvrLF3ue+U2CAWMfGg6ZaJohnrZZimEflXaNbUzfd0xIs72MbbejNpMzyQw2Xbxvg+w=;
	7:Z7Cwpk++5/qlLrQA89jj3Zhi0NlUMB6hix0Jj+zyiTDdgRcPS3s8Pn/uJCny/dPq0s3r3X4OUSJMswskSltMpx6hSK7I75cMtk7+WTnPT5EOGpXDqfhG2tJQGoNdX+435hVn9fzie87eM8X1fuy8U29bZtfXFXXs4isVByiThuXaRp+bN4v7CLggU8z6seB/Hd2VXixU4JvWuyiMHRFH0/jUKVJCB1bF8xL3Li/gXG3eNF+AemgMVvwBQXa0dooo
x-ms-office365-filtering-correlation-id: fb002356-5a36-468b-fc0d-08d632a42c61
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB4421E7D3290D3DD3FE4CA51D8FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(575784001)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(14444005)(81156014)(1076002)(6916009)(76176011)(66574009)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: 41+tTVvIEykM/0jbBKq3SeDLwt6wzKikiK9eW7eGms7FA7/MhkHXpc4IyekthINCS1WDR4niQnVcgGy/yzapCpww3J/HynrZ/8CA8mxLCV3g0BFgHpueNAGtAFRvDGjpT+0HSeHkfTYLpzdckbtDWMwwQsrWH+ClCXW4qg0retc2nFULpp5GTVMpdz20nMno5HVtZYSZLvcwUvUU41rzgRtBd+HGash4LbOlfG8lf/RaKCmPWM4tdKYiC5uzKo4s2BrQkIRsG4UU4ecy+QQ3MBLEJ4e3QvReG80ZB1hX8ff1KZy4sYSHOJYKQQnBUBokXhbItoaaajmh7R/pjs66+C3CpViarNiijJTAp9qM2EE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: fb002356-5a36-468b-fc0d-08d632a42c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:22.4366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 7/7] fetch2: add symlink for shallow mirror tarballs
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
X-List-Received-Date: Mon, 15 Oct 2018 19:16:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <77030EDD42256D4E89DDA529F1D900CE@eurprd03.prod.outlook.com>
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
dF9fLnB5DQppbmRleCBhMWIwM2E5NS4uNmNiYWY0MTMgMTAwNjQ0DQotLS0gYS9saWIvYmIvZmV0
Y2gyL19faW5pdF9fLnB5DQorKysgYi9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQpAQCAtMTAy
MCw2ICsxMDIwLDggQEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQsIHVkLCBsZCwg
Y2hlY2sgPSBGYWxzZSk6DQogDQogICAgICAgICBpZiBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsbWly
cm9yKToNCiAgICAgICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5mdWxsbWlycm9yLCBvcmlndWQu
ZnVsbG1pcnJvcikNCisgICAgICAgIGlmIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3RzKHVk
LmZ1bGxzaGFsbG93KToNCisgICAgICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5mdWxsc2hhbGxv
dywgb3JpZ3VkLmZ1bGxzaGFsbG93KQ0KIA0KICAgICAgICAgdXBkYXRlX3N0YW1wKG9yaWd1ZCwg
bGQpDQogICAgICAgICByZXR1cm4gdWQubG9jYWxwYXRoDQpkaWZmIC0tZ2l0IGEvbGliL2JiL3Rl
c3RzL2ZldGNoLnB5IGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQppbmRleCAxY2Q0YzY1Yy4uYmFk
NDk3YjQgMTAwNjQ0DQotLS0gYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCisrKyBiL2xpYi9iYi90
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
VXAoc2VsZik6DQpAQCAtMTc2MywzICsxNzc4LDMyIEBAIGNsYXNzIEdpdFNoYWxsb3dUZXN0KEZl
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

