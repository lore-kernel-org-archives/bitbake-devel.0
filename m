Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0074.outbound.protection.outlook.com [104.47.2.74])
	by mail.openembedded.org (Postfix) with ESMTP id 9595274739
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ADn0BbXmVV91l7bOBOO0ZHJutIL40fNq7vVQxxiu+9U=;
	b=Ihzm9Y2bnQCYbOuiTfQqspCl1DafV3I2nmE7KtRJyttIDIaqlOPCPpwkVY3+cQzLLzbvgiJ6zsxFsKV7ZngBUXnIR4OTFkQUTLgLHLTfyS+hZ6iCHv1v5J3bjnQLrTySK4MVct+1+Qw1GxNd1OflCF1SpGv0Eiy79Vn7VSL9UXY=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:20 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:20 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 4/7] fetch2/git: use intention revealing
	names for premirror tests
Thread-Index: AQHUZI0IgLFg+k/OHEWXdic4ewttBA==
Date: Mon, 15 Oct 2018 13:43:20 +0000
Message-ID: <20181015134255.4634-5-urs.fassler@bbv.ch>
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
	6:E4sUiXsUo0WuEczp30c39mzKZQE7aUPTKRib0EzTQuMuG1KvNxDfv7PT5nospqAdjTgEeQN60LNm5s+AIx47wozXBj4lYUnvmYqPjrkWwrbM4wJwdJJbSsufOApNcitkXsrDgzGXV6ZfsW7GtPq2WRRWx4vV1iTULXHZjbB0VyDPaWY9uHIjS5ccKskrffWNCWNl5Ut6/Sta40s/of9ucKs8KJ1ksW9gh5BZV/HN+KLhrqUHMg6dIILlLFuz+dwT9ZwLwWTkUJtMtQ5eAQGYNMVjTU3PJhG29lheXvgnHUXyoCQ0upJeyaqgyUeahGYXKSt31J6L+4PAFLJXcyQGzt4JwKkyPPwEuZ6wOAjxeC26xjV0ZDSki7HMME6fXwLurMxOjsNun7kW+Dj+kaegGZgFEFB4NWrlpUWFSP3x3JdAGG8YkM5YW4EqdsxcLVSa06UIHx6VPKfl+JPnyiFwZQ==;
	5:w0pAzd2LPJF+ZTP5mRImRkU92Z6gsZJ4FTg8RVZHunxY9eKOmwOFR3fcCkuWn4wuYuGc8jUXxX/OrPHR1wwWbyoWqKEMnVMWKwd2agB53tqVx8P7VqfS0wv1tbPzD/M/otY3rCNCqhSfdVWWmm95KhXKXF6jSPW8iqv9De7Pxoo=;
	7:RsuVXJ3egyjaqaGFDnsktVqjKsD9QQntc4mLJiKdoi1WjvRh7q/1bCdYeTaDR8Ib/BTCHtbqbN9J+CF1bjex5uoyL+CeZnZU29znk3UgYxuZINn/siS+B1ObUJR5q1x0G/6J73S4jrz3XJ7USs85KkadcnfFjxQWyjpSgiZZkk6a/sTy65Drjhg/8PTqbVv+srbbA210mlzgpZQoVjGU6Xf1FwIyGAuCK6KMGc1YRzJxHkC41NIcBvHGdPIyjruu
x-ms-office365-filtering-correlation-id: 904ba1dd-9414-47b7-58d6-08d632a42b3a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB44211FE4110174108DDD8E258FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(126837547833334)(181554191321653)(33711482430040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(81156014)(1076002)(6916009)(76176011)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: rz+yLFjIVlWH3Mv4MWgZshItFiTVVlNauy5cC56WXPMu5vXx437P1BjwHgCqWy+ozDjl+PH895uCv4pyCwfXbhWHCw0BtJR3PDB3awEPAm4FBZUkMor2BBfSeArtSE4HyDWM8EKa9zYgHjSOQDxu98DIPOoWohquk+3637cmx/Ue8AeX+EmWSVfgtKxdezSGr0tTrXrkCAfUk2uiSbe/rR8BLcs9JCAqh2OlVKxDgpo1tHeoCGVsT6sbqH7irHNUmnm7BTwoCWiWnTSOjFIWaUHFtD8mSwIqrtmVXMbLCfTRc0No0rRkePBB5WXHqJ1x3qQLeHb+9pYCp5e6nvkJjqGI0HRUIvxx6IuijD8Jq6Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ba1dd-9414-47b7-58d6-08d632a42b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:20.5617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 4/7] fetch2/git: use intention revealing names for premirror tests
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
X-List-Received-Date: Mon, 15 Oct 2018 16:16:41 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BD5DBB6E2DC7847A3C308758FD9962E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQt
b2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIv
YmIvdGVzdHMvZmV0Y2gucHkgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
bGliL2JiL3Rlc3RzL2ZldGNoLnB5IGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQppbmRleCA3OWJl
MWJlMC4uOWJlZDA2YmEgMTAwNjQ0DQotLS0gYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCisrKyBi
L2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KQEAgLTg2OSwyNyArODY5LDI3IEBAIGNsYXNzIEZldGNo
ZXJOZXR3b3JrVGVzdChGZXRjaGVyVGVzdCk6DQogICAgICAgICBzZWxmLmFzc2VydFJhaXNlcyhi
Yi5mZXRjaC5QYXJhbWV0ZXJFcnJvciwgc2VsZi5naXRmZXRjaGVyLCB1cmwsIHVybCkNCiANCiAg
ICAgQHNraXBJZk5vTmV0d29yaygpDQotICAgIGRlZiB0ZXN0X2dpdGZldGNoX3ByZW1pcnJvcihz
ZWxmKToNCi0gICAgICAgIHVybDEgPSAiZ2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFr
ZSINCi0gICAgICAgIHVybDIgPSAiZ2l0Oi8vc29tZXNlcnZlci5vcmcvYml0YmFrZSINCisgICAg
ZGVmIHRlc3RfZ2l0ZmV0Y2hfZmluZHNfbG9jYWxfdGFyYmFsbF9mb3JfbWlycm9yZWRfdXJsX3do
ZW5fcHJldmlvdXNfZG93bmxvYWRlZF9ieV90aGVfcmVjaXBlX3VybChzZWxmKToNCisgICAgICAg
IHJlY2lwZXVybCA9ICJnaXQ6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlIg0KKyAgICAg
ICAgbWlycm9ydXJsID0gImdpdDovL3NvbWVzZXJ2ZXIub3JnL2JpdGJha2UiDQogICAgICAgICBz
ZWxmLmQuc2V0VmFyKCJQUkVNSVJST1JTIiwgImdpdDovL3NvbWVzZXJ2ZXIub3JnL2JpdGJha2Ug
Z2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFrZSBcbiIpDQotICAgICAgICBzZWxmLmdp
dGZldGNoZXIodXJsMSwgdXJsMikNCisgICAgICAgIHNlbGYuZ2l0ZmV0Y2hlcihyZWNpcGV1cmws
IG1pcnJvcnVybCkNCiANCiAgICAgQHNraXBJZk5vTmV0d29yaygpDQotICAgIGRlZiB0ZXN0X2dp
dGZldGNoX3ByZW1pcnJvcjIoc2VsZik6DQotICAgICAgICB1cmwxID0gdXJsMiA9ICJnaXQ6Ly9z
b21lc2VydmVyLm9yZy9iaXRiYWtlIg0KKyAgICBkZWYgdGVzdF9naXRmZXRjaF9maW5kc19sb2Nh
bF90YXJiYWxsX3doZW5fcHJldmlvdXNfZG93bmxvYWRlZF9mcm9tX2FfcHJlbWlycm9yKHNlbGYp
Og0KKyAgICAgICAgcmVjaXBldXJsID0gImdpdDovL3NvbWVzZXJ2ZXIub3JnL2JpdGJha2UiDQog
ICAgICAgICBzZWxmLmQuc2V0VmFyKCJQUkVNSVJST1JTIiwgImdpdDovL3NvbWVzZXJ2ZXIub3Jn
L2JpdGJha2UgZ2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFrZSBcbiIpDQotICAgICAg
ICBzZWxmLmdpdGZldGNoZXIodXJsMSwgdXJsMikNCisgICAgICAgIHNlbGYuZ2l0ZmV0Y2hlcihy
ZWNpcGV1cmwsIHJlY2lwZXVybCkNCiANCiAgICAgQHNraXBJZk5vTmV0d29yaygpDQotICAgIGRl
ZiB0ZXN0X2dpdGZldGNoX3ByZW1pcnJvcjMoc2VsZik6DQorICAgIGRlZiB0ZXN0X2dpdGZldGNo
X2ZpbmRzX2xvY2FsX3JlcG9zaXRvcnlfd2hlbl9wcmVtaXJyb3JfcmV3cml0ZXNfdGhlX3JlY2lw
ZV91cmwoc2VsZik6DQogICAgICAgICByZWFsdXJsID0gImdpdDovL2dpdC5vcGVuZW1iZWRkZWQu
b3JnL2JpdGJha2UiDQotICAgICAgICBkdW1teXVybCA9ICJnaXQ6Ly9zb21lc2VydmVyLm9yZy9i
aXRiYWtlIg0KKyAgICAgICAgcmVjaXBldXJsID0gImdpdDovL3NvbWVzZXJ2ZXIub3JnL2JpdGJh
a2UiDQogICAgICAgICBzZWxmLnNvdXJjZWRpciA9IHNlbGYudW5wYWNrZGlyLnJlcGxhY2UoInVu
cGFja2VkIiwgInNvdXJjZW1pcnJvci5naXQiKQ0KICAgICAgICAgb3MuY2hkaXIoc2VsZi50ZW1w
ZGlyKQ0KICAgICAgICAgYmIucHJvY2Vzcy5ydW4oImdpdCBjbG9uZSAlcyAlcyAyPiAvZGV2L251
bGwiICUgKHJlYWx1cmwsIHNlbGYuc291cmNlZGlyKSwgc2hlbGw9VHJ1ZSkNCi0gICAgICAgIHNl
bGYuZC5zZXRWYXIoIlBSRU1JUlJPUlMiLCAiJXMgZ2l0Oi8vJXM7cHJvdG9jb2w9ZmlsZSBcbiIg
JSAoZHVtbXl1cmwsIHNlbGYuc291cmNlZGlyKSkNCi0gICAgICAgIHNlbGYuZ2l0ZmV0Y2hlcihk
dW1teXVybCwgZHVtbXl1cmwpDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCJQUkVNSVJST1JTIiwg
IiVzIGdpdDovLyVzO3Byb3RvY29sPWZpbGUgXG4iICUgKHJlY2lwZXVybCwgc2VsZi5zb3VyY2Vk
aXIpKQ0KKyAgICAgICAgc2VsZi5naXRmZXRjaGVyKHJlY2lwZXVybCwgcmVjaXBldXJsKQ0KIA0K
ICAgICBAc2tpcElmTm9OZXR3b3JrKCkNCiAgICAgZGVmIHRlc3RfZ2l0X3N1Ym1vZHVsZShzZWxm
KToNCi0tIA0KMi4xOS4xDQoNCg==

