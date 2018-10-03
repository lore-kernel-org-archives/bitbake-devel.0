Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 7238 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 03 Oct 2018 15:36:46 UTC
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
	by mail.openembedded.org (Postfix) with ESMTP id 2E437795E9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bUMysIS+xDILECMOjIOANAA6DJOzI1zzWbV7oVNR/3E=;
	b=pbUtqUYhp6gHx0U9q1VE7Qh0st68EOgkev1wZphhhQtkcFVcSULUKqiZOYF0LAgbHdG3Rdk2+hQJO6eWZXLoywT4x+f3rt2MXCuOhYZZFnvUE+PNHwxlrrEHBmVSkr8y3ZthiWSznY5ixml66O0/lUODuucanzybDXM9g88V/9g=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:04:06 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:06 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 2/7] fetch2/git: improve readability of method need_update
Thread-Index: AQHUWxEvCJy5er6w2kq39hrm/WR8wg==
Date: Wed, 3 Oct 2018 12:04:06 +0000
Message-ID: <20181003120346.3523-3-urs.fassler@bbv.ch>
References: <20181003120346.3523-1-urs.fassler@bbv.ch>
In-Reply-To: <20181003120346.3523-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.0
x-clientproxiedby: VI1PR0102CA0083.eurprd01.prod.exchangelabs.com
	(2603:10a6:803:15::24) To DB7PR03MB3834.eurprd03.prod.outlook.com
	(2603:10a6:5:30::20)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.160.33.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR03MB3754;
	6:0d4CmM9O74GEzZqIsAs9bSNrRwLGh2YcjN4T0NhO0KOnwpcemD1z/LL1jgsDy15WpKL6MlwefYUGggnXJqr+fPykY/9OyQap3Frn5uBhD/fkDU8JSDmgDmJfn1IsPaAvdduZUOx7pxdy3xGwKred1u3e00oB32Z/h9hTzWmrDGItqP3N6CuleMga77ZCqMhREIAQ4lfLm0GyHdSGvaJeWKBrML6wCjWEOmC3DtfklibmqhG1TNzSyR79T+8zbwS9puKd0ePqbz9yDvb/ojkxjpPoN4t03edcZSRaDCGQFoTH0LOKkSg2wKpopjJxIjSK5L7H8KzlfaBDNQzC0CS2u8oTS54kutTHNhACYXvQgOrOD5en0mmhmFLPxlyeF69Y8tP6YBQdmXIIv9CBwl5nEtYDM8hhdVpdxv3osfACoH4rboQbIE6VVtZ3GvrtQLPsy93eaYe+NJWQST356JkUbg==;
	5:kcKDxyCezOT3QpenH4BayM6dpAsWB7uo3rAZ+LBSwYr+YeGadJFSh7qB6z+wQLSsjE4y3KPGd+1msAFR4u8mW2PO1l1LubDOt4lLussJHf/oz35VywbSIIGxs+czQPuaCCqyf8Itxd0EwheCsOEkhLL5By7l95R9n6VcqepSXGo=;
	7:Ry8XFeeDgGmVSqGY+vvX+8bE3qfWt70qk07YfA2KykjIT97TvMSJhm8OoTfxb5ybvuv7QiZDrim70408zc23Eywn8OLUuuO+Jb+M8LlghvR2JjqrL8W5qE4MHXoFNa5TrRybZ7gAn1FWFWJxPz41V9AH5AzIZZvf4o5iVEB3qpLcBfm8is8kRCsrLbOqC6EG5NswOF4+TZfBBCk164tgkb82J5fzQXViEL6Ka02ONgfp5k5kIYZxWYGtyAlVJF/G
x-ms-office365-filtering-correlation-id: c0d4e84b-bed1-4fc9-a69e-08d629285193
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
x-ms-traffictypediagnostic: DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB3754C01A231D6DF700D5E4128FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(6436002)(86362001)(6916009)(5640700003)(2900100001)(54906003)(74482002)(5660300001)(14444005)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(66574008)(52116002)(36756003)(11346002)(33896004)(305945005)(386003)(6506007)(486006)(76176011)(7736002)(25786009)(71200400001)(446003)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: NWfQO1oDqQwnDnu83PYQj7WhROJ/s69ReNRcl7lFN/VrtFNEVUK80NqADPx0TQ3fUzR5jKG8UOQcsSzhkBpuz1YIjIqW/HBg4n4R5dO3EOtrHqEbOidwP2EPJ1MLbVpVRkbTnNiTCYyvz/Bd6W+x7Zr5gNcG/nFR0GfTF0GJI7XUFkOdzXwUwptS9GMsyK9H5Mlq42gR8BtZ8IHR3HUNHv1YPF8dkNh5SKVNVw3ChuvRBS2gKKJCJw55rJevJBcsAKbzoNTEoQjkiSWSo1tqa0BxuWTR0nK4DfE9EMqv1dLfU6xzaGwVnLWeoFxDAZjDbOTbTCww8tHhZZQYaKj1XTRycNfh+RYlJ1vXbu6yfEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d4e84b-bed1-4fc9-a69e-08d629285193
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:06.6317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
Subject: [PATCH 2/7] fetch2/git: improve readability of method need_update
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
X-List-Received-Date: Wed, 03 Oct 2018 15:36:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <54DE3962D864A947A5ED5BFD08FADA76@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VG8gaW1wcm92ZSB0aGUgcmVhZGFiaWxpdHkgd2UgZXh0cmFjdCB0aGUgZGlmZmVyZW50IHNjZW5h
cmlvcyBvZiB3aHkNCnRoZSBjbG9uZWRpciBuZWVkcyBhbiB1cGRhdGUuDQoNClNpZ25lZC1vZmYt
Ynk6IFVycyBGw6Rzc2xlciA8dXJzLmZhc3NsZXJAYmJ2LmNoPg0KU2lnbmVkLW9mZi1ieTogUGFz
Y2FsIEJhY2ggPHBhc2NhbC5iYWNoQHNpZW1lbnMuY29tPg0KLS0tDQogbGliL2JiL2ZldGNoMi9n
aXQucHkgfCAxMyArKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5IGIv
bGliL2JiL2ZldGNoMi9naXQucHkNCmluZGV4IGI3YTU2YzRjLi42M2M0MzNhNCAxMDA2NDQNCi0t
LSBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQorKysgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KQEAg
LTI5OSwxNyArMjk5LDIyIEBAIGNsYXNzIEdpdChGZXRjaE1ldGhvZCk6DQogICAgICAgICByZXR1
cm4gdWQuY2xvbmVkaXINCiANCiAgICAgZGVmIG5lZWRfdXBkYXRlKHNlbGYsIHVkLCBkKToNCisg
ICAgICAgIHJldHVybiBzZWxmLmNsb25lZGlyX25lZWRfdXBkYXRlKHVkLCBkKSBvciBzZWxmLnNo
YWxsb3dfdGFyYmFsbF9uZWVkX3VwZGF0ZSh1ZCkgb3Igc2VsZi50YXJiYWxsX25lZWRfdXBkYXRl
KHVkKQ0KKw0KKyAgICBkZWYgY2xvbmVkaXJfbmVlZF91cGRhdGUoc2VsZiwgdWQsIGQpOg0KICAg
ICAgICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKHVkLmNsb25lZGlyKToNCiAgICAgICAgICAgICBy
ZXR1cm4gVHJ1ZQ0KICAgICAgICAgZm9yIG5hbWUgaW4gdWQubmFtZXM6DQogICAgICAgICAgICAg
aWYgbm90IHNlbGYuX2NvbnRhaW5zX3JlZih1ZCwgZCwgbmFtZSwgdWQuY2xvbmVkaXIpOg0KICAg
ICAgICAgICAgICAgICByZXR1cm4gVHJ1ZQ0KLSAgICAgICAgaWYgdWQuc2hhbGxvdyBhbmQgdWQu
d3JpdGVfc2hhbGxvd190YXJiYWxscyBhbmQgbm90IG9zLnBhdGguZXhpc3RzKHVkLmZ1bGxzaGFs
bG93KToNCi0gICAgICAgICAgICByZXR1cm4gVHJ1ZQ0KLSAgICAgICAgaWYgdWQud3JpdGVfdGFy
YmFsbHMgYW5kIG5vdCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsbWlycm9yKToNCi0gICAgICAgICAg
ICByZXR1cm4gVHJ1ZQ0KICAgICAgICAgcmV0dXJuIEZhbHNlDQogDQorICAgIGRlZiBzaGFsbG93
X3RhcmJhbGxfbmVlZF91cGRhdGUoc2VsZiwgdWQpOg0KKyAgICAgICAgcmV0dXJuIHVkLnNoYWxs
b3cgYW5kIHVkLndyaXRlX3NoYWxsb3dfdGFyYmFsbHMgYW5kIG5vdCBvcy5wYXRoLmV4aXN0cyh1
ZC5mdWxsc2hhbGxvdykNCisNCisgICAgZGVmIHRhcmJhbGxfbmVlZF91cGRhdGUoc2VsZiwgdWQp
Og0KKyAgICAgICAgcmV0dXJuIHVkLndyaXRlX3RhcmJhbGxzIGFuZCBub3Qgb3MucGF0aC5leGlz
dHModWQuZnVsbG1pcnJvcikNCisNCiAgICAgZGVmIHRyeV9wcmVtaXJyb3Ioc2VsZiwgdWQsIGQp
Og0KICAgICAgICAgIyBJZiB3ZSBkb24ndCBkbyB0aGlzLCB1cGRhdGluZyBhbiBleGlzdGluZyBj
aGVja291dCB3aXRoIG9ubHkgcHJlbWlycm9ycw0KICAgICAgICAgIyBpcyBub3QgcG9zc2libGUN
Ci0tIA0KMi4xOS4wDQoNCg==

