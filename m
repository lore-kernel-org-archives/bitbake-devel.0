Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0049.outbound.protection.outlook.com [104.47.2.49])
	by mail.openembedded.org (Postfix) with ESMTP id C794979164
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Oct 2018 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=W/TwubiA4ZR3na7vkDaiBqXCbpdacF09XB1Hx9iroqw=;
	b=VHaMidAswybfXxI2Gez77uXTfjpSpDB6VavHv2Wl1deW+Yn+4u4cXd3EcjDe5ApXW6rvhEIyhDn+pdLcnBbJ1Bg/t4C6SZUZSyFqFOLJz+MzLZokKkP8AMqBl9HvAUj5Q+WgOL11hoaIs9AiXnW1KK6f1OJ7R+ChDdf2JLEC3qI=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4488.eurprd03.prod.outlook.com (20.177.34.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Mon, 8 Oct 2018 08:15:10 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b%4]) with mapi id 15.20.1207.024;
	Mon, 8 Oct 2018 08:15:10 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 1/3] fetch2/git: prevent access to
	non-existing clonedir
Thread-Index: AQHUXt8HnN3EhUBeGkmUEBtEMQjQ5w==
Date: Mon, 8 Oct 2018 08:15:10 +0000
Message-ID: <20181008081455.16384-2-urs.fassler@bbv.ch>
References: <20181008081455.16384-1-urs.fassler@bbv.ch>
In-Reply-To: <20181008081455.16384-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.0
x-clientproxiedby: HE1PR07CA0012.eurprd07.prod.outlook.com
	(2603:10a6:7:67::22) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.194.183.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4488;
	6:5Hi7aZGsWvwa3QFPJqwFDZ1qu3qhEdNEwkbbNmzeFb5oNUKiBWz+ZNZ5T7wIA78blYwCEwAKUBhCrP1P8dUC9YH9zSBDITDjLrKHE3zwaWdB2sAzKegd43NMD3K3yMaEbL2OeFbJRWrlowhOINzCyon+9bXHHc0bC+eUVNylIhk4erTwOLgNTqjns+nYe8sCKPoYxoCmRodrOMWOw4FUp0Fgf6hgHq7hzuN1wiI+sxQ1gCly/OmJDdujbAWbrPxySyQFz3nYvlMtpTgn9kDIDyu64XGwZRRJwKhxgSEDUOOKVgnbDqaRwHXgHW347kkspm/VYlbCRucQVGglZdH6JZsdkiP51AoKDc549dZFPpJ+/4JIsTLbn3wHIgnEg03W7RyBghtp+9LTzHgSbWji2QoHzYYTywwIQHIFelc5kBFfvXAzgHj3ktgG0ToJ9VGkm5IWBZF/cTlVzEot8h10aw==;
	5:0AZW7zUgTnsyruz5R83vEJUC7K1dwNZpYDNrlwmfAP3Ga/CyWcxafKml0LxTRAXMscdOocOyWDTikrjCZSdq0YQ7HXr/cvWMPed6z8q7Y8GuKCmTttQC5/9GQkFvih8uyknTvCvbUsIUOG+U16ctMd2vVEYAQTOv7XJ32cDTSEA=;
	7:jaZV0jqdEdc47KsGOoyAUmJFy77bN7fxQmAipCAVJRCC8baGSYSFs83G09ktqTKv5E7SYer3FAm3Su3ZwGzh7d4uLWTIUPLeQHCZvih73V5UQqpqMTfUEh4POFQio7OECneBEKchx8PEw9GZJn9vFdTL8Doio1dTdogH13m7hmp7U+2ZoJlq+A2aU6lF5vCxw3RF3/7BgI7fClWCe7DOysKYoUTdCm8oo1KBPRjDpUJPj5yB411YM0o3FhCNC4sY
x-ms-office365-filtering-correlation-id: 8fc87fdd-f26f-47b1-ce7d-08d62cf62a38
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4488; 
x-ms-traffictypediagnostic: AM6PR03MB4488:
x-microsoft-antispam-prvs: <AM6PR03MB4488BCCA1667EE292D7F81258FE60@AM6PR03MB4488.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);
	SRVR:AM6PR03MB4488; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4488; 
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(39840400004)(396003)(376002)(346002)(136003)(189003)(199004)(14444005)(2501003)(6486002)(25786009)(8676002)(6436002)(478600001)(5640700003)(6116002)(256004)(3846002)(1076002)(99286004)(2906002)(8936002)(105586002)(2351001)(2900100001)(54906003)(81156014)(81166006)(71190400001)(71200400001)(85202003)(106356001)(5250100002)(5660300001)(6916009)(1857600001)(2616005)(36756003)(305945005)(85182001)(50226002)(7736002)(66066001)(6506007)(386003)(102836004)(66574009)(68736007)(186003)(26005)(74482002)(97736004)(575784001)(86362001)(486006)(52116002)(4326008)(53936002)(76176011)(11346002)(446003)(6512007)(316002)(476003)(14454004)(33896004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4488;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: 9QKMMjYulClFHQ1VtWy6j8XdDu5OfTiO2xdvWBtMXPCKfwJrnX9mycqe1hZ1qNYeOy78evdj+jNpkXiGxjJFYipj1QaLF+JyAmbDSJciQGcG1cXehPnt98W0/aiFkKv4yhxpyR9Q9G4A5iZ0KXRP2H7sKyf1Hz+EGj9A/QSJBRo0/JB4WW1d2eUmIskFfdlmrcdvUrQ9fcZT2K0u8YAo9G1NNNa+u5v01DBAsNEzNnr+52JONLAXpI3U1KTuKc3RrODZEbJQgNRHntM4YtCoAItG7RptQjr5ISHxGQWnPrB1NehAubMVBIsDnYBmwweUyjEId9L689Ua682K64cGY/QqTpqWIZUZHVcQ/2w28sk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc87fdd-f26f-47b1-ce7d-08d62cf62a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 08:15:10.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4488
Subject: [PATCH v2 1/3] fetch2/git: prevent access to non-existing clonedir
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
X-List-Received-Date: Mon, 08 Oct 2018 09:48:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F8FC2164A3AC34BB08FA9B63259B6B0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

QSB1c2VyIGZyaWVuZGx5IGVycm9yIGlzIHRocm93IHdoZW4gbmVpdGhlciB0aGUgY2xvbmVkaXIg
bm9yDQpmdWxsc2hhbGxvdyBleGlzdC4gV2l0aG91dCB0aGUgY2hlY2ssIGEgZGlmZmljdWx0IHRv
IGludGVycHJldCBlcnJvcg0KaXMgdGhyb3cgZnJvbSB3aXRoaW4gdGhlIGZldGNoIGNvbW1hbmQu
DQoNClNpZ25lZC1vZmYtYnk6IFVycyBGw6Rzc2xlciA8dXJzLmZhc3NsZXJAYmJ2LmNoPg0KU2ln
bmVkLW9mZi1ieTogUGFzY2FsIEJhY2ggPHBhc2NhbC5iYWNoQHNpZW1lbnMuY29tPg0KLS0tDQog
bGliL2JiL2ZldGNoMi9naXQucHkgIHwgIDQgKysrLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8
IDExICsrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5weSBiL2xpYi9iYi9m
ZXRjaDIvZ2l0LnB5DQppbmRleCBmMTNhMjVmOS4uM2UzN2Y3NmYgMTAwNjQ0DQotLS0gYS9saWIv
YmIvZmV0Y2gyL2dpdC5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkNCkBAIC00NzksOCAr
NDc5LDEwIEBAIGNsYXNzIEdpdChGZXRjaE1ldGhvZCk6DQogICAgICAgICBpZiB1ZC5zaGFsbG93
IGFuZCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsc2hhbGxvdykgYW5kIHNlbGYuY2xvbmVkaXJfbmVl
ZF91cGRhdGUodWQsIGQpOg0KICAgICAgICAgICAgIGJiLnV0aWxzLm1rZGlyaGllcihkZXN0ZGly
KQ0KICAgICAgICAgICAgIHJ1bmZldGNoY21kKCJ0YXIgLXh6ZiAlcyIgJSB1ZC5mdWxsc2hhbGxv
dywgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KLSAgICAgICAgZWxzZToNCisgICAgICAgIGVsaWYgbm90
IHNlbGYuY2xvbmVkaXJfbmVlZF91cGRhdGUodWQsIGQpOg0KICAgICAgICAgICAgIHJ1bmZldGNo
Y21kKCIlcyBjbG9uZSAlcyAlcy8gJXMiICUgKHVkLmJhc2VjbWQsIHVkLmNsb25lZmxhZ3MsIHVk
LmNsb25lZGlyLCBkZXN0ZGlyKSwgZCkNCisgICAgICAgIGVsc2U6DQorICAgICAgICAgICAgcmFp
c2UgYmIuZmV0Y2gyLlVucGFja0Vycm9yKCJObyB1cCB0byBkYXRlIHNvdXJjZSBmb3VuZCIsIHVk
LnVybCkNCiANCiAgICAgICAgIHJlcG91cmwgPSBzZWxmLl9nZXRfcmVwb191cmwodWQpDQogICAg
ICAgICBydW5mZXRjaGNtZCgiJXMgcmVtb3RlIHNldC11cmwgb3JpZ2luICVzIiAlICh1ZC5iYXNl
Y21kLCByZXBvdXJsKSwgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KZGlmZiAtLWdpdCBhL2xpYi9iYi90
ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KaW5kZXggZmY2NjMxNWEuLjUx
Y2Y3NTYzIDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQorKysgYi9saWIvYmIv
dGVzdHMvZmV0Y2gucHkNCkBAIC0xNTgxLDYgKzE1ODEsMTcgQEAgY2xhc3MgR2l0U2hhbGxvd1Rl
c3QoRmV0Y2hlclRlc3QpOg0KICAgICAgICAgc2VsZi5hc3NlcnRSZWZzKFsnbWFzdGVyJywgJ29y
aWdpbi9tYXN0ZXInXSkNCiAgICAgICAgIHNlbGYuYXNzZXJ0UmV2Q291bnQob3JpZ19yZXZzIC0g
MTc1OCkNCiANCisgICAgZGVmIHRlc3RfdGhhdF91bnBhY2tfdGhyb3dzX2FuX2Vycm9yX3doZW5f
dGhlX2dpdF9jbG9uZV9ub3Jfc2hhbGxvd190YXJiYWxsX2V4aXN0KHNlbGYpOg0KKyAgICAgICAg
c2VsZi5hZGRfZW1wdHlfZmlsZSgnYScpDQorICAgICAgICBmZXRjaGVyLCB1ZCA9IHNlbGYuZmV0
Y2goKQ0KKyAgICAgICAgYmIudXRpbHMucmVtb3ZlKHNlbGYuZ2l0ZGlyLCByZWN1cnNlPVRydWUp
DQorICAgICAgICBiYi51dGlscy5yZW1vdmUoc2VsZi5kbGRpciwgcmVjdXJzZT1UcnVlKQ0KKw0K
KyAgICAgICAgd2l0aCBzZWxmLmFzc2VydFJhaXNlcyhiYi5mZXRjaDIuVW5wYWNrRXJyb3IpIGFz
IGNvbnRleHQ6DQorICAgICAgICAgICAgZmV0Y2hlci51bnBhY2soc2VsZi5kLmdldFZhcignV09S
S0RJUicpKQ0KKw0KKyAgICAgICAgc2VsZi5hc3NlcnRUcnVlKCJObyB1cCB0byBkYXRlIHNvdXJj
ZSBmb3VuZCIgaW4gY29udGV4dC5leGNlcHRpb24ubXNnKQ0KKw0KICAgICBAc2tpcElmTm9OZXR3
b3JrKCkNCiAgICAgZGVmIHRlc3RfdGhhdF91bnBhY2tfZG9lc193b3JrX3doZW5fdXNpbmdfZ2l0
X3NoYWxsb3dfdGFyYmFsbF9idXRfdGFyYmFsbF9pc19ub3RfYXZhaWxhYmxlKHNlbGYpOg0KICAg
ICAgICAgc2VsZi5kLnNldFZhcignU1JDUkVWJywgJ2U1OTM5ZmY2MDhiOTVjZGQ0ZDBhYjBlMTkz
NTc4MWFiOWEyNzZhYzAnKQ0KLS0gDQoyLjE5LjANCg0K

