Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0076.outbound.protection.outlook.com [104.47.2.76])
	by mail.openembedded.org (Postfix) with ESMTP id 4A8C874FD0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Oct 2018 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Xyjbrnqgq4GWhycv856AIG8TmoNYcZGM8en4UO/bz10=;
	b=kPLVyNUDM24i5yMqlV0u+SRRlSLlnkcguzYLkK7PnzATHT2w7ci7xrFlW+JKzDQsT/M0shRmhmLwLgRFjHq1HyREAEkQThpHaobBOw8lLiZxYvGhIMlP28uv/khDFEalqF8vr0ofGqucoMfQ8lOLlr5iKAGjUAVxhTRLtlzGG5Y=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4278.eurprd03.prod.outlook.com (20.177.32.147) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Mon, 8 Oct 2018 08:15:09 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b%4]) with mapi id 15.20.1207.024;
	Mon, 8 Oct 2018 08:15:09 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 0/3] fetch2/git: Check fullshallow
	tarball and clonedir before access 
Thread-Index: AQHUXt8HEizPdN0i4ECViwFD4HVmOg==
Date: Mon, 8 Oct 2018 08:15:09 +0000
Message-ID: <20181008081455.16384-1-urs.fassler@bbv.ch>
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
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4278;
	6:o33Xp2TzB5KgbwOsOtRWIqVvIXlqwLz0ofbPl2PP3ywoVqtHouIpmGHjVTMsLLAxY+fI7vNxn+yh2ToodJL1bBAXa4lwYYTapzCSv3RFTK1H2yonifCXaMGs2unlQMe9RdX4FX6uF56Mf5q/lD9SXdW99NC8Xv9ZRufqGyiTcAVyTDTX5DwehCkMNFbApJXBUMWPIgRzArSCqzP5ihYfABdhAWRm3yEmVP65m8nYpsgdC8JN1dNwgMu367TgZE9J/7wCVEXpzNV6edA1X43xB6hEZQr3xxWJuiz+hXSGkv5srBS9o75vOlbAE3Kt9yThHtuvFW3Kt/roTQcz8hHMNLwsSOwClaiFI1Dw0riRqNT7TvWgqShTDy+VPx7p435p5YEVZv7vqD6R0aymV8xMrrTW6RkWMGhzgR4x3yG5vHarzgtAE73+uaNmuI3aQTAegqwlpLj00Hm18+olJoQDVw==;
	5:jl35+nCCyk3mGk3T+bCfNaOO1cy/gUlFK++A3qsLAlocwSWhzFNIS8672vSsYc4WjRNKTaq15OhC+Ekumv4WMoay4O+vtZMap5HMwcVJA35L7Z5vBTTDx1oWMAgWT2dHr+5OgdPmCmW58/S/T5bbNbL0ZuCOK/+4ALGqDRL2a1Q=;
	7:28Mqe6aoXYoCheTI1PKlUXdwoRUtQqeM0jgNLCGCBI8YGpC0U+dnT7T6Fu/TMRGAt0vM5qv5Z39MS3lBJOGyOB3cFagStQegnRyedRKtOH8/46GPPxOpIyKSCOeshdXkw6fuG/bYVSXFC4qyNvM7ALKc6gaKkpD1bJsLhPWiy2d5o/JacX/oVU7pMOT7quXPtkSn/ZG6GdCploAWjZp2AR7CZprNZTQMYT+tZUzT6m1Df2zcXZy3M5/nru81KYtO
x-ms-office365-filtering-correlation-id: de13bc8e-843c-4750-2a02-08d62cf629a3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4278; 
x-ms-traffictypediagnostic: AM6PR03MB4278:
x-microsoft-antispam-prvs: <AM6PR03MB427876D23632891A89ADAB898FE60@AM6PR03MB4278.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);
	SRVR:AM6PR03MB4278; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4278; 
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(39830400003)(376002)(346002)(396003)(136003)(189003)(199004)(14444005)(2501003)(105586002)(6486002)(25786009)(8676002)(6436002)(478600001)(5640700003)(6116002)(256004)(3846002)(1076002)(99286004)(2906002)(8936002)(2351001)(2900100001)(4743002)(81156014)(81166006)(71190400001)(71200400001)(85202003)(6916009)(106356001)(5250100002)(5660300001)(2616005)(36756003)(305945005)(85182001)(50226002)(7736002)(66066001)(6506007)(386003)(66574009)(102836004)(68736007)(1857600001)(186003)(26005)(74482002)(97736004)(86362001)(486006)(4326008)(52116002)(19627235002)(53936002)(6512007)(316002)(476003)(14454004)(33896004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4278;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: c0uh1zwWMfqrwL67h/VQ//TMLK0KxRK8j52ATwgIuHuy7gUJCzfG+fi9P3iMX4BqHS5Zr1/5FJbziufHW5aCNuTI1XdmiubMHEY4MdG91+q/rmlCDPdOSyIhQKjFgr9eZhwR9d3lp8PM8kltOfm+UnhJap+jdzei9fa3qEHIPkxges+vLeoZCA6V0LIwgFz+XeMOX/ug11PWJ5quJTV53l2ckHnOkvPXDXVE2ZUtgR7Rn9ybDCGPCnFpywA1aHJIVNxdq9pdWGJTymOwkAlfYF3wRXYlvtmTtrcbI2yyem4Ga7/12CHAASFfdy54x1aQzdRhqKsmTiMWJOA++hrGvD9DtC+JmUzzjlNcjrXEgtA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: de13bc8e-843c-4750-2a02-08d62cf629a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 08:15:09.6563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4278
Subject: [PATCH v2 0/3] fetch2/git: Check fullshallow tarball and clonedir before access
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
X-List-Received-Date: Mon, 08 Oct 2018 14:48:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC5E510E187D6848B71C811F13F9C646@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SW4gY29udHJhc3QgdG8gdGhlIGZpcnN0IHZlcnNpb24gb2YgdGhlIHBhdGNoZXMsIHdlIGRvbid0
IHVzZSBiYi5mYXRhbCB0byBzaWduYWwNCmFuIGVycm9yIGJ1dCByYWlzZSBhbiBiYi5mZXRjaDIu
VW5wYWNrRXJyb3IgZXhjZXB0aW9uLg0KDQpMb2dSZWNvcmQgaXMgbm90IGluY2x1ZGVkIGluIHRo
ZSBwYXRjaGVzIHNpbmNlIGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuDQoNClVycyBGw6Rzc2xlciAo
Myk6DQogIGZldGNoMi9naXQ6IHByZXZlbnQgYWNjZXNzIHRvIG5vbi1leGlzdGluZyBjbG9uZWRp
cg0KICBmZXRjaDIvZ2l0OiBleHBsaWNpdGx5IHNob3cgdGhlIGRlY2lzaW9uIGxvZ2ljIHRvIHNl
bGVjdCB0aGUgc291cmNlIGluDQogICAgY29kZQ0KICBmZXRjaDIvZ2l0OiBwcm92aWRlIGluZm9y
bWF0aW9uIGFib3V0IG1pc3Npbmcgc291cmNlcw0KDQogbGliL2JiL2ZldGNoMi9naXQucHkgIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCiBsaWIvYmIvdGVzdHMvZmV0Y2gucHkgfCAx
MyArKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMTkuMA0KDQo=

