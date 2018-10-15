Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 937 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Oct 2018 13:58:55 UTC
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
	by mail.openembedded.org (Postfix) with ESMTP id E2C7D60064
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=piv7gYiUE/qyp9v7PNnf+5xdmPjmF6qmOxpech9JPAA=;
	b=fFKkbfIwSrH80yPPaIN825vfWb8vEGD8vaES0pJLGOOkqMbv+IzGV9qCieqyxe3VCQ1mcu0shQzDCBskDwgP9eDHQl8DR+ybFSo+U9YRST+r50a/xAkLOxSPoQJ84bPIJhqBL3q+F8WrOSSMBfo8DAfJmfr4w593ReZAsz30yH8=
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
Thread-Topic: [bitbake-devel][PATCH 6/7] fetch2: add symlinks for mirror
	tarballs
Thread-Index: AQHUZI0JuLXenmMwR0aX3oqctbcmFA==
Date: Mon, 15 Oct 2018 13:43:21 +0000
Message-ID: <20181015134255.4634-7-urs.fassler@bbv.ch>
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
	6:2CV5okdQ/hDDNrVVc7rHv+BB1OEra/m6GY5+Ss5rqp1BD9Mb7wHmJFccMRXMQ8TBB65xzr7mzw1lL28sACl7lGZu+LrE9vug41brHCK/L695MZoEWSYeg3KfonmQ2JDPyyVRi+q5gODzGnNS/hczcFwaKkacCPxL2KmMy8NE1s6VVIssJVZSoZV1v4RkkUmNLfzFaFtjeTYiKhCNXBNfmEizfac4w+sd11hXtS7JFzpP6p6qS6MS+iz58qkfTeTU74YWQMlR3+lVZuyvg+DaApwlcNHXrAzSCpAnsDYAB8VjDObIaijCA6zNz6gbDj59IktI0JjUVU4GIFlmrfXNWSStUXfPNft7UAA4Dk6P4y5LpDkaVBETVPq0WtxMyvTX2ibdLgNQeWkXtdawXVpVBXIF35qHfYIqeznpdYSMHB+IAbpn1Y4LrtohDwAxKrEKIMroUj2aB22ZNa/SPqKDRw==;
	5:AEi/MLqYYTa3Rm47QGMzcRbJPP2Chy+zBVDvwzUcn1Jy6Sw5qncKA2xm5Em0Krzyx9GDkPOQ35o1SSNNQsKAIH8nHEO5G/YMy/AFrZ8g4zmsHd4poOq1+q/dD3tQh9ESWFfzZPJyQRM2G27dYyvO9lwR+doDNPi+RbcMoBoxUC8=;
	7:f1w5fG8ExS/ihWX/JlK6ES651kgq/RN0yjhjRKfnAvYLuW5+gQ0alpJKPTJbI+RRS04rqVDT/VlH3H5gk/h/9D+SZtA6ZLRHf0fO1OaqJGoaTQhzl6aauYJRDCB0tNMwXWIHPHf7CDBqPYa7UmnqOICfq6IHgoq7iOwqb7ZoK4Xl7Mromg2Up/6X7vRIEHdsvqUMcHnWB+EB/pxNcA9oW9YsuR6rU5GV+4cswE2StMKuQty0OgFcftNC/z2/fhn7
x-ms-office365-filtering-correlation-id: 78b0da8c-d27f-44f9-4e84-08d632a42c13
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB44214C8D3EE340E7B823876F8FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(575784001)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(14444005)(81156014)(1076002)(6916009)(76176011)(66574009)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001)(403724002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: l1+1B6ehI4khq4uGxrXBaytl0SKJFGiIqtY59hgO3HnC2pskp4oxPmnralclQS66Nw13UC4JUosuLT5J7c7pxsSKPPDx2i2KRHnN3yGdSbOHr2eu+OFFgp1YQebXt29WmloXTE/qQLjwbeQv/p/P5NW31w6eTxOHUnAtqVa4a7zdGF+m1hGSafNvVjAszBmnuWoJO5c2oRqU7fRvqr+4DqhokzA+gVhDnjscbR2c6tUfMtjuqq11eRoTOTc7iFoXzwZeSRGorxOwGElgLGeJpC/22xo5SYHXuNrrPkt63FKHhDMAdq+ZjlvIkerO9Zx8r998VUxj6Io/olqa5XOBpZx45eIC5Zxekkkz4IlhSeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b0da8c-d27f-44f9-4e84-08d632a42c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:21.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 6/7] fetch2: add symlinks for mirror tarballs
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
X-List-Received-Date: Mon, 15 Oct 2018 13:58:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C0FEEC1D35DE4419B3A0C316FA6BCC0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SW4gdGhlIHVucGFjayBzdGVwIHRoZSBtaXJyb3IgdGFyYmFsbCBpcyBub3QgZm91bmQgd2hlbiB0
aGUgbWlycm9yZWQNCnRhcmJhbGwgaXMgbmFtZWQgZGlmZmVyZW50bHkgdGhhbiB0aGUgb3JpZ2lu
YWwgdGFyYmFsbC4gVGhpcyBoYXBwZW5zDQpkdWUgdG8gbWlycm9yIHJld3JpdGUgcnVsZXMuIFRv
IHNvbHZlIHRoZSBwcm9ibGVtIHdlIGFkZCBzeW1saW5rcyBmb3INCnRoZSBkaWZmZXJlbnRseSBu
YW1lZCB0YXJiYWxscy4NCg0KU2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xl
ckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVu
cy5jb20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgIDQgKysrDQogbGliL2Ji
L3Rlc3RzL2ZldGNoLnB5ICAgICB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSBiL2xpYi9iYi9mZXRj
aDIvX19pbml0X18ucHkNCmluZGV4IDQ1OGYzMTA3Li5hMWIwM2E5NSAxMDA2NDQNCi0tLSBhL2xp
Yi9iYi9mZXRjaDIvX19pbml0X18ucHkNCisrKyBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkN
CkBAIC0xMDE3LDYgKzEwMTcsMTAgQEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQs
IHVkLCBsZCwgY2hlY2sgPSBGYWxzZSk6DQogICAgICAgICAgICAgcmV0dXJuIG9yaWd1ZC5sb2Nh
bHBhdGgNCiAgICAgICAgICMgT3RoZXJ3aXNlIHRoZSByZXN1bHQgaXMgYSBsb2NhbCBmaWxlOi8v
IGFuZCB3ZSBzeW1saW5rIHRvIGl0DQogICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5sb2NhbHBh
dGgsIG9yaWd1ZC5sb2NhbHBhdGgpDQorDQorICAgICAgICBpZiBvcy5wYXRoLmV4aXN0cyh1ZC5m
dWxsbWlycm9yKToNCisgICAgICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5mdWxsbWlycm9yLCBv
cmlndWQuZnVsbG1pcnJvcikNCisNCiAgICAgICAgIHVwZGF0ZV9zdGFtcChvcmlndWQsIGxkKQ0K
ICAgICAgICAgcmV0dXJuIHVkLmxvY2FscGF0aA0KIA0KZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0
cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KaW5kZXggOWJlZDA2YmEuLjFjZDRj
NjVjIDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQorKysgYi9saWIvYmIvdGVz
dHMvZmV0Y2gucHkNCkBAIC0yOSw2ICsyOSwyMCBAQCBmcm9tIGJiLmZldGNoMiBpbXBvcnQgVVJJ
DQogZnJvbSBiYi5mZXRjaDIgaW1wb3J0IEZldGNoTWV0aG9kDQogaW1wb3J0IGJiDQogDQorDQor
ZGVmIGdldF9icm9rZW5fc3ltbGlua3MoZGlyZWN0b3J5KToNCisgICAgcmVzdWx0ID0gW10NCisN
CisgICAgZGlyID0gb3MubGlzdGRpcihkaXJlY3RvcnkpDQorICAgIGZvciBmaWxlbmFtZSBpbiBk
aXI6DQorICAgICAgICBmdWxsbmFtZSA9IGRpcmVjdG9yeSArICcvJyArIGZpbGVuYW1lDQorICAg
ICAgICBicm9rZW4gPSAobm90IG9zLnBhdGguZXhpc3RzKGZ1bGxuYW1lKSkgYW5kIG9zLnBhdGgu
aXNsaW5rKGZ1bGxuYW1lKQ0KKyAgICAgICAgaWYgYnJva2VuOg0KKyAgICAgICAgICAgIHJlc3Vs
dCArPSBbZmlsZW5hbWVdDQorDQorICAgIHJldHVybiByZXN1bHQNCisNCisNCiBkZWYgc2tpcElm
Tm9OZXR3b3JrKCk6DQogICAgIGlmIG9zLmVudmlyb24uZ2V0KCJCQl9TS0lQX05FVFRFU1RTIikg
PT0gInllcyI6DQogICAgICAgICByZXR1cm4gdW5pdHRlc3Quc2tpcCgiTmV0d29yayB0ZXN0cyBi
ZWluZyBza2lwcGVkIikNCkBAIC01MzYsNyArNTUwLDcgQEAgY2xhc3MgVGFyYmFsbE5hbWluZ1Rl
c3QoRmV0Y2hlclRlc3QpOg0KICAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxmLnJlY2lwZV90YXJi
YWxsLCBkaXIpDQogDQogICAgIEBza2lwSWZOb05ldHdvcmsoKQ0KLSAgICBkZWYgdGVzdF90aGF0
X3RoZV9taXJyb3JfdGFyYmFsbF9pc19jcmVhdGVkX3doZW5fbWlycm9yaW5nX2lzX3VzZWQoc2Vs
Zik6DQorICAgIGRlZiB0ZXN0X3RoYXRfdGFyYmFsbF9mb3JfbWlycm9yZWRfdXJsX2FuZF9yZWNp
cGVfdXJsX2V4aXN0c193aGVuX21pcnJvcmluZ19pc191c2VkKHNlbGYpOg0KICAgICAgICAgc2Vs
Zi5zZXR1cF9taXJyb3JfcmV3cml0ZSgpDQogICAgICAgICBmZXRjaGVyID0gYmIuZmV0Y2guRmV0
Y2goW3NlbGYucmVjaXBlX3VybF0sIHNlbGYuZCkNCiANCkBAIC01NDQsNiArNTU4LDcgQEAgY2xh
c3MgVGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hlclRlc3QpOg0KIA0KICAgICAgICAgZGlyID0gb3Mu
bGlzdGRpcihzZWxmLmRsZGlyKQ0KICAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxmLm1pcnJvcl90
YXJiYWxsLCBkaXIpDQorICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYucmVjaXBlX3RhcmJhbGws
IGRpcikNCiANCiANCiBjbGFzcyBHaXRTaGFsbG93VGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hlclRl
c3QpOg0KQEAgLTg4MSw2ICs4OTYsMTIgQEAgY2xhc3MgRmV0Y2hlck5ldHdvcmtUZXN0KEZldGNo
ZXJUZXN0KToNCiAgICAgICAgIHNlbGYuZC5zZXRWYXIoIlBSRU1JUlJPUlMiLCAiZ2l0Oi8vc29t
ZXNlcnZlci5vcmcvYml0YmFrZSBnaXQ6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlIFxu
IikNCiAgICAgICAgIHNlbGYuZ2l0ZmV0Y2hlcihyZWNpcGV1cmwsIHJlY2lwZXVybCkNCiANCisg
ICAgQHNraXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X2dpdGZldGNoX2ZpbmRzX2xvY2Fs
X3RhcmJhbGxfd2hlbl9wcmV2aW91c19kb3dubG9hZGVkX2Zyb21fYV9taXJyb3Ioc2VsZik6DQor
ICAgICAgICByZWNpcGV1cmwgPSAiZ2l0Oi8vZ2l0Lndyb25nLm9yZy9iaXRiYWtlIg0KKyAgICAg
ICAgc2VsZi5kLnNldFZhcigiTUlSUk9SUyIsICJnaXQ6Ly9naXQud3Jvbmcub3JnL2JpdGJha2Ug
Z2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFrZSBcbiIpDQorICAgICAgICBzZWxmLmdp
dGZldGNoZXIocmVjaXBldXJsLCByZWNpcGV1cmwpDQorDQogICAgIEBza2lwSWZOb05ldHdvcmso
KQ0KICAgICBkZWYgdGVzdF9naXRmZXRjaF9maW5kc19sb2NhbF9yZXBvc2l0b3J5X3doZW5fcHJl
bWlycm9yX3Jld3JpdGVzX3RoZV9yZWNpcGVfdXJsKHNlbGYpOg0KICAgICAgICAgcmVhbHVybCA9
ICJnaXQ6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlIg0KQEAgLTg5MSw2ICs5MTIsMzYg
QEAgY2xhc3MgRmV0Y2hlck5ldHdvcmtUZXN0KEZldGNoZXJUZXN0KToNCiAgICAgICAgIHNlbGYu
ZC5zZXRWYXIoIlBSRU1JUlJPUlMiLCAiJXMgZ2l0Oi8vJXM7cHJvdG9jb2w9ZmlsZSBcbiIgJSAo
cmVjaXBldXJsLCBzZWxmLnNvdXJjZWRpcikpDQogICAgICAgICBzZWxmLmdpdGZldGNoZXIocmVj
aXBldXJsLCByZWNpcGV1cmwpDQogDQorICAgIEBza2lwSWZOb05ldHdvcmsoKQ0KKyAgICBkZWYg
dGVzdF9naXRmZXRjaF91c2VzX3RoZV9naXRfdGFyYmFsbF93aGVuX3VzaW5nX21pcnJvcl9yZXdy
aXRlX3J1bGVzX2FuZF90aGVfZ2l0X2Nsb25lX2RvZXNfbm90X2V4aXN0KHNlbGYpOg0KKyAgICAg
ICAgc2VsZi5kLnNldFZhcignU1JDUkVWJywgJ2U1OTM5ZmY2MDhiOTVjZGQ0ZDBhYjBlMTkzNTc4
MWFiOWEyNzZhYzAnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignQkJfR0VORVJBVEVfTUlSUk9S
X1RBUkJBTExTJywgJzEnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignUFJFTUlSUk9SUycsICdn
aXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy8uKiBnaXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9n
aXQvUEFUSDtwcm90b2NvbD1odHRwcyBcbicpDQorICAgICAgICBmZXRjaGVyID0gYmIuZmV0Y2gu
RmV0Y2goWyJnaXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9mc3Rlc3RzIl0sIHNlbGYuZCkNCisg
ICAgICAgIGZldGNoZXIuZG93bmxvYWQoKQ0KKyAgICAgICAgYmIudXRpbHMucHJ1bmVkaXIoc2Vs
Zi5kbGRpciArICcvZ2l0MicpDQorICAgICAgICBiYi51dGlscy5wcnVuZWRpcihzZWxmLnVucGFj
a2RpcikNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ1BSRU1JUlJPUlMnLCAnJykNCisgICAgICAg
IHNlbGYuZC5zZXRWYXIoJ0JCX0ZFVENIX1BSRU1JUlJPUk9OTFknLCAnMScpDQorDQorICAgICAg
ICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGZldGNoZXIudW5wYWNrKHNlbGYudW5w
YWNrZGlyKQ0KKyAgICAgICAgZGlyID0gb3MubGlzdGRpcihzZWxmLnVucGFja2RpciArICIvZ2l0
LyIpDQorICAgICAgICBzZWxmLmFzc2VydEluKCJmc3Rlc3RzLmRvYXAiLCBkaXIpDQorDQorICAg
IEBza2lwSWZOb05ldHdvcmsoKQ0KKyAgICBkZWYgdGVzdF90aGF0X25vX2Jyb2tlbl9zeW1saW5r
c19leGlzdF93aGVuX3VzaW5nX21pcnJvcl9yZXdyaXRlX3J1bGVzX2FuZF9ub190YXJiYWxsKHNl
bGYpOg0KKyAgICAgICAgc2VsZi5kLnNldFZhcignU1JDUkVWJywgJ2U1OTM5ZmY2MDhiOTVjZGQ0
ZDBhYjBlMTkzNTc4MWFiOWEyNzZhYzAnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignQkJfR0VO
RVJBVEVfTUlSUk9SX1RBUkJBTExTJywgJzAnKQ0KKyAgICAgICAgc2VsZi5kLnNldFZhcignUFJF
TUlSUk9SUycsICdnaXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy8uKiBnaXQ6Ly9naXQueW9jdG9w
cm9qZWN0Lm9yZy9naXQvUEFUSDtwcm90b2NvbD1odHRwcyBcbicpDQorICAgICAgICBmZXRjaGVy
ID0gYmIuZmV0Y2guRmV0Y2goWyJnaXQ6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9mc3Rlc3RzIl0s
IHNlbGYuZCkNCisNCisgICAgICAgIGZldGNoZXIuZG93bmxvYWQoKQ0KKw0KKyAgICAgICAgYnJv
a2VuX3N5bWxpbmtzID0gZ2V0X2Jyb2tlbl9zeW1saW5rcyhzZWxmLmRsZGlyKQ0KKyAgICAgICAg
c2VsZi5hc3NlcnRFcXVhbChbXSwgYnJva2VuX3N5bWxpbmtzKQ0KKw0KICAgICBAc2tpcElmTm9O
ZXR3b3JrKCkNCiAgICAgZGVmIHRlc3RfZ2l0X3N1Ym1vZHVsZShzZWxmKToNCiAgICAgICAgIGZl
dGNoZXIgPSBiYi5mZXRjaC5GZXRjaChbImdpdHNtOi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvZ2l0
LXN1Ym1vZHVsZS10ZXN0O3Jldj1mMTJlNTdmMmVkZjBhYTUzNGNmMTYxNmZhOTgzZDE2NWE5MmIw
ODQyIl0sIHNlbGYuZCkNCi0tIA0KMi4xOS4xDQoNCg==

