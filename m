Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 65128 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 19 Oct 2018 07:19:24 UTC
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
	by mail.openembedded.org (Postfix) with ESMTP id 197DC79C9F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=51fFsX82Gut3CXY5yERuCFmsVQg1Cn4VbnXtp41GNsc=;
	b=LosoiZKb6pykCGT0SYyYs9XRVPaBR+jTYlcs1m6BkMKJpf+NI4CXEHQrH9Am9vM1+kh26SOSrC4na+rfJzog2HTx59Zsj2uNmT2nQQyr5kIkvw+zPtQYIbnTYPHd0cQCVtOPkWNxmUrrYyuuH6bsPnRIOEy3rL+kQLXwJtLcIt0=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4039.eurprd03.prod.outlook.com (20.177.38.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.24; Thu, 18 Oct 2018 09:41:00 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.032;
	Thu, 18 Oct 2018 09:41:00 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 0/2] Add symlinks for git (shallow)
	tarballs when name differs due to mirror rewrite rules
Thread-Index: AQHUZsatRUWHRFUrTUWvD1NB0QNjug==
Date: Thu, 18 Oct 2018 09:41:00 +0000
Message-ID: <20181018094051.20530-1-urs.fassler@bbv.ch>
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
	6:BAdIH6qjM6KqBkOQSblkUhanHvnSw0CL/fY/nmQwMctB81osjznw3U0e5GFGUyzH9tDpI2sRRanVsV+skN1IS09Faj9T3azRxpmW0VftmKNyL2xWXkP2nOKbzAU8BPsSEzZeMEvei2Ep9Xanb6pozzJtJn3rAepmtt9vCx9n7lo5Gt8n7gDo2DY8ccDgLJnUOWTEF/cFt6UwYVWjmxOehulpOX5Nvu9FoXvVeNeeR3QZMc49EeqpYKs23g2sppRGCKtrduKzQt5qgPuwcwQ8qHYCv8lTWyYGUAIMY0Xcu631vJWeN7lKMS9OtWQCNZirWwPxiq1uJ1hIV2drwj8ifxEx5Pc/9aSvlO7Y8JMLQdOiwBlSXNtz/lwSh2D7M0jc8beBrLPjfoXYwm3rcpMBFQudBhVZfmQPqlZMhQusRI15BEYRr0+v9rJnqV91+JGX5qra6N//wfB+aXZ5oWdEeQ==;
	5:trExxnTvpe61wIhGM1GmqjMq9MmAAS23HQGnPe/C2g+6XQVOgbZGOa1iR3az/zW7b66kyD3t/3rF6KW1S6ScZrvwBzxptlw62RZCcfvGZUo6ByyJ+uxu2IBkSeIKzWRzt45Pnyf0jN48KXmLFRMZJ0IYMJsKV+Pqwg7BEKjZZa4=;
	7:d4S1xwEqMTTTFJ2G6iD4wgZOn7ae8NoChTcYQURLr2McE2Munjt3ZfVNSLgfjX2PScHlvETBQ2podDIl12kS0E8oK7jmYg5ZICxBFaZ/tqXQ05GK7zc0Yetq+2cY2gqW36gLeEE3L+CAQvWacf7GY5ZQog2HzL9U5JFB44M71adhaj3uj0+Xoy9vyeaEwd/0iSla1sRDv5NJBGRME6JgTC+B8EKiNmyeeAx/g1/KGUiXxQqOdOHS3yRhSIGkUQ7g
x-ms-office365-filtering-correlation-id: 962be817-e893-491c-1215-08d634ddcfbd
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4039; 
X-MS-TrafficTypeDiagnostic: AM6PR03MB4039:|AM6PR03MB4039:
x-microsoft-antispam-prvs: <AM6PR03MB40392A29F9432F954651785B8FF80@AM6PR03MB4039.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
	SRVR:AM6PR03MB4039; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4039; 
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(39850400004)(376002)(366004)(136003)(199004)(189003)(2501003)(8936002)(71190400001)(25786009)(316002)(6512007)(71200400001)(86362001)(54906003)(4326008)(5660300001)(66574009)(1076002)(68736007)(50226002)(36756003)(478600001)(85202003)(81166006)(99286004)(2351001)(105586002)(106356001)(6486002)(8676002)(386003)(305945005)(33896004)(6506007)(7736002)(6916009)(5640700003)(14454004)(52116002)(486006)(6436002)(102836004)(186003)(1857600001)(97736004)(2900100001)(74482002)(2616005)(66066001)(476003)(26005)(85182001)(6116002)(2906002)(14444005)(3846002)(256004)(53936002)(5250100002)(81156014);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4039;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: tfHFhcH9xhybQ/L4k+uTc4fOEmiGwD2NPqTdVpqnIB9YMerQdMtlEPpr0GV/DOkipa9xLGeG2dv98W+HjxKHIGHEL1KzwUaA0j8hm26u3umpYFaKYV/yxQtx0ZUhd9jtOJBv0Nk+GMSjjcMnl9GrwzygWnpqwX2r6BC+9jg00wqx7JYUNku9o2kMWZWuXbCTMbNfYBJ8w3hECV5bLMcEOfaAWImGs2PLqgrIIYcWTlEoygT37Ed+3f3GPMgSH/7STPgz4Z2aHXTgQErZN8tBCr+XkW8SK012WTbqMckugIxIkMdcpcqgfZeFH8qoLbzBqd4SPcOFH6Qc8/QX4q2911YFM4SlQM+K5SwQGaD5fUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 962be817-e893-491c-1215-08d634ddcfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 09:41:00.2351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4039
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB4039;
	23:OOTgVPJX5HA7k9P3FAjpxFw9/wYKpuToF7wADGIb3QORa5b5uXkTwkAP4l8JZipr+53UzU5Qvnp0kfHSX1jWiByZcxQm2CSx8peJ5zZD+Vza9FLKY9jbkpKAetZS3xbFkYsk8f2kHCPkTBmOB3g93A==
X-OriginatorOrg: bbv.ch
Subject: [PATCH v2 0/2] Add symlinks for git (shallow) tarballs when name differs due to mirror rewrite rules
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
X-List-Received-Date: Fri, 19 Oct 2018 07:19:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDDF19182193C94EB58759C1F21B7E72@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

djI6IENoZWNrIGlmIGZ1bGxtaXJyb3IgYW5kIHNoYWxsb3cgcHJvcGVydHkgZXhpc3RzIGJlZm9y
ZSBjcmVhdGluZyBzeW1saW5rcyBmb3INCnRoZW0uIFRoaXMgcHJldmVudHMgZXJyb3JzIHdpdGgg
ZmV0Y2hlcnMgdGhhdCBkb24ndCBzdXBwb3J0IHRhcmJhbGwgY3JlYXRpb24uDQoNClRoZSBwYXRj
aGVzIGFyZSBiYXNlZCBvbiBtYXN0ZXItbmV4dCAoNTQ2M2MxNmUzNjE5ZDMyNGFlZDEzN2Y0N2Y5
M2YwOTk3YTIyN2QyOSkuDQoNClRoZSBnaXQgKHNoYWxsb3cpIHRhcmJhbGxzIGFyZSBub3QgZm91
bmQgd2hlbiBjZXJ0YWluIG1pcnJvciByZXdyaXRlIHJ1bGVzIGFyZQ0KaW4gdXNlLiBUaGlzIGlz
IGR1ZSB0byB0aGUgZmFjdCB0aGF0IHRoZSB0YXJiYWxsIGlzIG5hbWVkIGFjY29yZGluZyB0byB0
aGUgdXJsDQp3aGVyZSBpdCBpcyBkb3dubG9hZGVkIGZyb20uIFRoZSBlcnJvciBvY2N1cnMgaW4g
dGhlIHVucGFjayBzdGVwIHdoZXJlIEJpdEJha2UNCmxvb2tzIGZvciBhIHRhcmJhbGwgbmFtZWQg
YWZ0ZXIgdGhlIHVybCBhcyBzcGVjaWZpZWQgaW4gdGhlIHJlY2lwZS4gQnkgYWRkaW5nDQp0aGUg
c3ltbGlua3MgQml0QmFrZSBmaW5kcyB0aGUgdGFyYmFsbHMgaW4gdGhlIHVucGFjayBzdGVwLg0K
DQpSZWdhcmRzDQpVcnMNCg0KVXJzIEbDpHNzbGVyICgyKToNCiAgZmV0Y2gyOiBhZGQgc3ltbGlu
a3MgZm9yIG1pcnJvciB0YXJiYWxscw0KICBmZXRjaDI6IGFkZCBzeW1saW5rIGZvciBzaGFsbG93
IG1pcnJvciB0YXJiYWxscw0KDQogbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8ICAgNiArKysN
CiBsaWIvYmIvdGVzdHMvZmV0Y2gucHkgICAgIHwgMTAyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxMDcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQotLSANCjIuMTkuMQ0KDQo=

