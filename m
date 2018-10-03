Return-Path: <urs.fassler@bbv.ch>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr30064.outbound.protection.outlook.com [40.107.3.64])
	by mail.openembedded.org (Postfix) with ESMTP id DC371747F3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MmXR1SsA7aBD6wj6M9BwEAaQ3DfmKZ0/Vsg9729XoEs=;
	b=VKpz51AYLJ/QeTuQ7AhuSBjGT3DwnqmwTcnn5vXlOPRP/Un9EjkAWk83l68apHpccd+b+rRmLTMTUbRgm92eWQrZYvxe7GW15aoGGtJHIbMCtVYCAHC/pKbZa2cv0zfwOsTaSWR/A8hwkbRzkThwbVdzR0H1chdALIWB12aij9Q=
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
Thread-Topic: [PATCH 1/7] fetch2/git: prevent access to non-existing
	fullshallow tarball
Thread-Index: AQHUWxEuDEe1HRBASkapjpGtPd6adg==
Date: Wed, 3 Oct 2018 12:04:06 +0000
Message-ID: <20181003120346.3523-2-urs.fassler@bbv.ch>
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
	6:A8pY+4nPWpl/H56QyTil2baZUMufhqfGiv0jTDVBVjiWVyigSIRU7ALuuxx1N16i5YXRfv5JtvWOrF0ehRhkYhU7AMKuFPPYjR3UR7S2UNR9QWzCKEWm5Tmg31uLLv169BUgT2hjSmvtneK3trA3n+49EIzY4Vs5nWVYCFaonBtwrDtt1xMPw7Y8bi1RJd2bPcZ5hJpoBLUHabRtwZV1ImowZZ+9la/Z0D1TH60Hzr3AgPcdjQwUgTYckL2vdnWeWaXA3QTTRVHi0OYzaK1rxfbbBkGtA40ZacmEwBHoypdq5s3jhscwCyIOOCcis6qkhtloFjFpH/jKGRj7Yhsi+E5koh/VbM7l6/RuI7AfsesPeZ/wOyXkPszr7dRlM+7MkU1lfGxXklgTwTCAb4o2DfxPGS5b6XAQXznNDVelmpYNWYqcRa2mtiUKLaaG7+aw99qm6a4ukgrBHfXL9eW+dw==;
	5:LaYLnB2FAcDjg670J4fqk1oXGEhhheGm5Wf86UdBWZtbEgINVH7D9ZsJsVCY2SV+mZ927Y9FA26/em9P5rlfz/sa32ZO70lyyrO16/G7fX6Ty59DVnh3vIfHMZS6odLHyxRMKrTueJsHaiNrqROeOjXxCXtiHO0WiMlVhBCzx58=;
	7:hs7OMgYZkMLWwH0bshuUPsizby5xB1xG386rhgZQ7+sLXrRsjL2Nv1s/REOKrG2HfyF+wzAjBuGFHZNFBiiQHQoUsQ7kTxZypjMYlexqSuCbAofjOogcggnK/PLLlyP2MBRKbiiU+hostnVHtIKFPxnnmleUpDzSAoDQidfCemuyCNjxy1N5RVSkTvofQJbANc6iaqOkj8XdnlGHVGIyQ35aCZR9SKxy82GTUx8cUwkj+yIW7bxQ8+7/928Weh74
x-ms-office365-filtering-correlation-id: e5e7d1bc-5dbf-4af9-d691-08d629285132
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
X-MS-TrafficTypeDiagnostic: DB7PR03MB3754:|DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB3754D0287FB68CB5E29FA6718FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(575784001)(6436002)(86362001)(6916009)(5640700003)(2900100001)(54906003)(74482002)(5660300001)(14444005)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(66574008)(52116002)(36756003)(11346002)(33896004)(305945005)(386003)(6506007)(486006)(76176011)(7736002)(25786009)(71200400001)(446003)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: YNdefvIXLxAWTU4gO8cg42gbiQwHYla0QV0iN1VsoVeg8M46BmY7WWjVqNCD2kjKHTcaVCRmfTEf5XJ3ABBvrYNqpxwRc0HEpmD25gOsWR4R/bU5GS4cPoUqe+wL/h59SC1EeUzNXOvGkpqQAERNbBE1eGEHEpMsKUGYPjJ95Tex54UzMxaCOhQkGNf6bTI/Ivl5RxU9k2dINI62D87UB9rglXshzZ20wN/SbmctxXozH0uiDm9tBkYf2DZXJcJdrErqVSXjkwbW8cm7VihF9mlUMVze2qWgHuDykPCZQ07WyBYc95wNjnqlgNH24xGkBv2SUL5QggEZeY4e0WXW3J5Dz20H0DjacVBfXbY+Pok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e7d1bc-5dbf-4af9-d691-08d629285132
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:06.0493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3754;
	23:VILR6soWy/ZU8T3xw73Gkl1zLt2H8QUk+LdS3p6+QYHRWHxOy78aentPKjv20lm3g+72NMitw+4ssUWBgruJ4q/EZ6u0pMDuGFqzQyZsw8oDbXqk/TXey63XWe3FMFGFfq6gBX7/k2A2OtvUkCfSqQ==
X-OriginatorOrg: bbv.ch
Subject: [PATCH 1/7] fetch2/git: prevent access to non-existing fullshallow tarball
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
X-List-Received-Date: Wed, 03 Oct 2018 18:21:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F42C8747367248B061D16335080AAF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQt
b2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIv
YmIvZmV0Y2gyL2dpdC5weSAgfCAgMiArLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8IDE0ICsr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5weSBiL2xpYi9iYi9mZXRj
aDIvZ2l0LnB5DQppbmRleCAzNWRhMTRkNy4uYjdhNTZjNGMgMTAwNjQ0DQotLS0gYS9saWIvYmIv
ZmV0Y2gyL2dpdC5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkNCkBAIC00NzEsNyArNDcx
LDcgQEAgY2xhc3MgR2l0KEZldGNoTWV0aG9kKToNCiAgICAgICAgIGlmIG9zLnBhdGguZXhpc3Rz
KGRlc3RkaXIpOg0KICAgICAgICAgICAgIGJiLnV0aWxzLnBydW5lZGlyKGRlc3RkaXIpDQogDQot
ICAgICAgICBpZiB1ZC5zaGFsbG93IGFuZCBzZWxmLm5lZWRfdXBkYXRlKHVkLCBkKToNCisgICAg
ICAgIGlmIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3RzKHVkLmZ1bGxzaGFsbG93KSBhbmQg
c2VsZi5uZWVkX3VwZGF0ZSh1ZCwgZCk6DQogICAgICAgICAgICAgYmIudXRpbHMubWtkaXJoaWVy
KGRlc3RkaXIpDQogICAgICAgICAgICAgcnVuZmV0Y2hjbWQoInRhciAteHpmICVzIiAlIHVkLmZ1
bGxzaGFsbG93LCBkLCB3b3JrZGlyPWRlc3RkaXIpDQogICAgICAgICBlbHNlOg0KZGlmZiAtLWdp
dCBhL2xpYi9iYi90ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KaW5kZXgg
OWM1NjAxYWEuLjJlZmVmMDc4IDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQor
KysgYi9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCkBAIC0xNTgwLDMgKzE1ODAsMTcgQEAgY2xhc3Mg
R2l0U2hhbGxvd1Rlc3QoRmV0Y2hlclRlc3QpOg0KICAgICAgICAgc2VsZi5hc3NlcnROb3RFcXVh
bChvcmlnX3JldnMsIHJldnMpDQogICAgICAgICBzZWxmLmFzc2VydFJlZnMoWydtYXN0ZXInLCAn
b3JpZ2luL21hc3RlciddKQ0KICAgICAgICAgc2VsZi5hc3NlcnRSZXZDb3VudChvcmlnX3JldnMg
LSAxNzU4KQ0KKw0KKyAgICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF91
bnBhY2tfZG9lc193b3JrX3doZW5fdXNpbmdfZ2l0X3NoYWxsb3dfdGFyYmFsbF9idXRfdGFyYmFs
bF9pc19ub3RfYXZhaWxhYmxlKHNlbGYpOg0KKyAgICAgICAgc2VsZi5kLnNldFZhcignU1JDUkVW
JywgJ2U1OTM5ZmY2MDhiOTVjZGQ0ZDBhYjBlMTkzNTc4MWFiOWEyNzZhYzAnKQ0KKyAgICAgICAg
c2VsZi5kLnNldFZhcignQkJfR0lUX1NIQUxMT1cnLCAnMScpDQorICAgICAgICBzZWxmLmQuc2V0
VmFyKCdCQl9HRU5FUkFURV9TSEFMTE9XX1RBUkJBTExTJywgJzEnKQ0KKyAgICAgICAgZmV0Y2hl
ciA9IGJiLmZldGNoLkZldGNoKFsiZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvZnN0ZXN0cyJd
LCBzZWxmLmQpDQorICAgICAgICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGJiLnV0
aWxzLnJlbW92ZShzZWxmLmRsZGlyICsgIi8qLnRhci5neiIpDQorICAgICAgICBmZXRjaGVyLnVu
cGFjayhzZWxmLnVucGFja2RpcikNCisNCisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi51
bnBhY2tkaXIgKyAiL2dpdC8iKQ0KKyAgICAgICAgc2VsZi5hc3NlcnRJbigiZnN0ZXN0cy5kb2Fw
IiwgZGlyKQ0KLS0gDQoyLjE5LjANCg0K

