Return-Path: <urs.fassler@bbv.ch>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr50048.outbound.protection.outlook.com [40.107.5.48])
	by mail.openembedded.org (Postfix) with ESMTP id 5C29C79670
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lWe4SIZfELbapiHc0KC9MB6b61/IUDtHKnrkSTMLygg=;
	b=kXAj+e95x3hbLNgDbF6pEQXiuk+f78wR3diSMlpKlSjRdLuFnWlGPGdBayeINFtjTiZrmW5LqHocuR9xKUKs5atW3pF4XSRO8zOfUz1RIyZf6lqMMgP7lgFKv8gTS7EE7iGVVMlfcpjQYrxZ5bPj96czxbPgbEPxf4Vv/m36yWw=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:21 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:21 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 5/7] fetch2: extract the function which
	ensures that a valid symlink exists
Thread-Index: AQHUZI0J9+e8EjajrECFjVnpJfRqNg==
Date: Mon, 15 Oct 2018 13:43:21 +0000
Message-ID: <20181015134255.4634-6-urs.fassler@bbv.ch>
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
	6:t/NX1uUfuCF7JbLpX0l/ajQo/NJebXhcxBnMHyUu7Fbv4G9FbwNLGHHsSiCw49r8oBqBbuBRp58Wsznh0hnvbFJ+6ACH9+Jp0uXgtMJgkfaWCbKu57A8k0X1VJvoObeMemYBTpz0ee1Fgk25tMQpEDfMbjUJ65btLpbaY5BvW9qDnOQLOOqd6n5jFg0mZFdfR8LjGSVtmE2+/JxywbLZ/xre3gBSvqMkkN78pJms3JE9ZGgZ/HZvXjJBm5t9F3JYlWpTzfzp1W8HXrWAtrwx7EL/4GkEbUX1Lgr2F1NxLaRlLpDkWRpuF+veD91SnXbnz3MuENQZed3SC/o7jQ8u+GmdcAiibfh1XQVIodnfqRxumisVQlToYT1bc9ikcuImorgvQzpYftLFUTaPFc7L/Cz3ltTIFVZe9hLqtdHdk+B/dY6WH5WjyR3PufrtVuq3fTzgIq0sNG+9I2W+gYiwpg==;
	5:JrrTjwkywPhpFn2J6qrLnnYloGANLsx1SypqvlG1k3t9AiDnbyBSoTiMx20lc/QBo0imTfMaBdgINxkQlieGGSVXWJcb7LsY7tLM8e5NkUFGmLYr0LaXhtJupqidZNqSvLNEkR1s6XHZluYgFY/5jkoY46pIGqK6WAecCKUSTvU=;
	7:VMltTqUk/w9YwWzylALY6esJxAv33/cAjiXpb65DUfDxN/MS8JAA5o93j41B3JKnCLQ0ci2j+y/MuFugxKTiBa0lxBlRxHNHJinUvA5mwAsSSOLHOqVULuTXOnPiWZhY/p1PysbB17NAe2ygkFQSoaFP6FGebpFB9AZ4ZA+9gEmemavn/BBjUclOHg3HeQ/9egAaiXauFnLIqB45o4K0CTGi94+sbEA4MkkKcL7gUvRAin+Xsd24G8HsCh+4xgcO
x-ms-office365-filtering-correlation-id: dc947784-2beb-4195-04d9-08d632a42ba8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB442136CB40F989E4296F64438FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(14444005)(81156014)(1076002)(6916009)(76176011)(66574009)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: fT5noNh7EqkV3iytHudy3VXUnChf9Dv/CVjxETMQWBlWquhr6nmjCvQdLMDKVVQKdCEXmjPlGpgRAChUwmvawW0QINtk7Z6rQOYwBsWzTBDSO++0BheF/wRuD+ojmpXL8K1S6//XTR+5cI2ZOQ0p1il5IY3exc4OueHoXExYP+AJ7vOk0jkm6tYql0fTJ7cOlD7zkfbq1t/eHIH9pz15/UH2g1TC6Z9Am1gJJkiiIOmj4wl5Co+1GtEebXIfZNda7I3lXP4deYHUuNSCRTQftD54rOQ9lct+IYWxpEhoJoiF8gJ5XBPyM4CFo8ycFgsWB3h6oJCwaL5+W5CIOWs67X6X/k0FgmBbbkXQyCwmM8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: dc947784-2beb-4195-04d9-08d632a42ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:21.2648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 5/7] fetch2: extract the function which ensures that a valid symlink exists
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
X-List-Received-Date: Mon, 15 Oct 2018 15:15:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <10611B3067A98942975362F5D742E0CB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

Rm9yIGJldHRlciByZWFkYWJpbGl0eSBhbmQgZnV0dXJlIHVzZSwgd2UgZXh0cmFjdCB0aGUgZnVu
Y3Rpb24gd2hpY2gNCmVuc3VyZXMgdGhhdCBhIGdpdmVuIHN5bWxpbmsgZXhpc3RzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBVcnMgRsOkc3NsZXIgPHVycy5mYXNzbGVyQGJidi5jaD4NClNpZ25lZC1vZmYt
Ynk6IFBhc2NhbCBCYWNoIDxwYXNjYWwuYmFjaEBzaWVtZW5zLmNvbT4NCi0tLQ0KIGxpYi9iYi9m
ZXRjaDIvX19pbml0X18ucHkgfCAyNyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5w
eQ0KaW5kZXggYTgzNTI2YTUuLjQ1OGYzMTA3IDEwMDY0NA0KLS0tIGEvbGliL2JiL2ZldGNoMi9f
X2luaXRfXy5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KQEAgLTEwMTYsMTYg
KzEwMTYsNyBAQCBkZWYgdHJ5X21pcnJvcl91cmwoZmV0Y2gsIG9yaWd1ZCwgdWQsIGxkLCBjaGVj
ayA9IEZhbHNlKToNCiAgICAgICAgICAgICAgICAgICAgIG9yaWd1ZC5tZXRob2QuYnVpbGRfbWly
cm9yX2RhdGEob3JpZ3VkLCBsZCkNCiAgICAgICAgICAgICByZXR1cm4gb3JpZ3VkLmxvY2FscGF0
aA0KICAgICAgICAgIyBPdGhlcndpc2UgdGhlIHJlc3VsdCBpcyBhIGxvY2FsIGZpbGU6Ly8gYW5k
IHdlIHN5bWxpbmsgdG8gaXQNCi0gICAgICAgIGlmIG5vdCBvcy5wYXRoLmV4aXN0cyhvcmlndWQu
bG9jYWxwYXRoKToNCi0gICAgICAgICAgICBpZiBvcy5wYXRoLmlzbGluayhvcmlndWQubG9jYWxw
YXRoKToNCi0gICAgICAgICAgICAgICAgIyBCcm9rZW4gc3ltYm9saWMgbGluaw0KLSAgICAgICAg
ICAgICAgICBvcy51bmxpbmsob3JpZ3VkLmxvY2FscGF0aCkNCi0NCi0gICAgICAgICAgICAjIEFz
IHBlciBhYm92ZSwgaW4gY2FzZSB0d28gdGFza3MgZW5kIHVwIGhlcmUgc2ltdWx0YW5lb3VzbHku
DQotICAgICAgICAgICAgdHJ5Og0KLSAgICAgICAgICAgICAgICBvcy5zeW1saW5rKHVkLmxvY2Fs
cGF0aCwgb3JpZ3VkLmxvY2FscGF0aCkNCi0gICAgICAgICAgICBleGNlcHQgRmlsZUV4aXN0c0Vy
cm9yOg0KLSAgICAgICAgICAgICAgICBwYXNzDQorICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5s
b2NhbHBhdGgsIG9yaWd1ZC5sb2NhbHBhdGgpDQogICAgICAgICB1cGRhdGVfc3RhbXAob3JpZ3Vk
LCBsZCkNCiAgICAgICAgIHJldHVybiB1ZC5sb2NhbHBhdGgNCiANCkBAIC0xMDU5LDYgKzEwNTAs
MjIgQEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQsIHVkLCBsZCwgY2hlY2sgPSBG
YWxzZSk6DQogICAgICAgICAgICAgYmIudXRpbHMudW5sb2NrZmlsZShsZikNCiANCiANCitkZWYg
ZW5zdXJlX3N5bWxpbmsodGFyZ2V0LCBsaW5rX25hbWUpOg0KKyAgICBpZiBub3Qgb3MucGF0aC5l
eGlzdHMobGlua19uYW1lKToNCisgICAgICAgIGlmIG9zLnBhdGguaXNsaW5rKGxpbmtfbmFtZSk6
DQorICAgICAgICAgICAgIyBCcm9rZW4gc3ltYm9saWMgbGluaw0KKyAgICAgICAgICAgIG9zLnVu
bGluayhsaW5rX25hbWUpDQorDQorICAgICAgICAjIEluIGNhc2UgdGhpcyBpcyBleGVjdXRpbmcg
d2l0aG91dCBhbnkgZmlsZSBsb2NrcyBoZWxkIChhcyBpcw0KKyAgICAgICAgIyB0aGUgY2FzZSBm
b3IgZmlsZTovLyBVUkxzKSwgdHdvIHRhc2tzIG1heSBlbmQgdXAgaGVyZSBhdCB0aGUNCisgICAg
ICAgICMgc2FtZSB0aW1lLCBpbiB3aGljaCBjYXNlIHdlIGRvIG5vdCB3YW50IHRoZSBzZWNvbmQg
dGFzayB0bw0KKyAgICAgICAgIyBmYWlsIHdoZW4gdGhlIGxpbmsgaGFzIGFscmVhZHkgYmVlbiBj
cmVhdGVkIGJ5IHRoZSBmaXJzdCB0YXNrLg0KKyAgICAgICAgdHJ5Og0KKyAgICAgICAgICAgIG9z
LnN5bWxpbmsodGFyZ2V0LCBsaW5rX25hbWUpDQorICAgICAgICBleGNlcHQgRmlsZUV4aXN0c0Vy
cm9yOg0KKyAgICAgICAgICAgIHBhc3MNCisNCisNCiBkZWYgdHJ5X21pcnJvcnMoZmV0Y2gsIGQs
IG9yaWd1ZCwgbWlycm9ycywgY2hlY2sgPSBGYWxzZSk6DQogICAgICIiIg0KICAgICBUcnkgdG8g
dXNlIGEgbWlycm9yZWQgdmVyc2lvbiBvZiB0aGUgc291cmNlcy4NCi0tIA0KMi4xOS4xDQoNCg==

