Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 106063 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 16 Oct 2018 19:44:29 UTC
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr50046.outbound.protection.outlook.com [40.107.5.46])
	by mail.openembedded.org (Postfix) with ESMTP id C8463798B4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 19:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wfnvPpBDjNktLdQtFFD0VzzWPwK/ksqxd9HwdbUPCIw=;
	b=ZMyLz0ERtgCTfObIno+gz6slx5V1AsYMJRDw8TgnwYcwFAWAcrBqobmD+wrmdEV3zygB9dAzjSKHD9d/kEhG9PSigeLo+Z2pgDDJ5PtQAGftL3DOrQ43bHCoy2JVv5dclZzGz6NRYbFt6sCQ8XpnhoP1J7hmnHmVRVzHuf6U2p4=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:18 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:18 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 0/7] Add symlinks for git (shallow)
	tarballs when name differs due to mirror rewrite rules
Thread-Index: AQHUZI0HxkZdRKY6CUyKcR6vsD5UUQ==
Date: Mon, 15 Oct 2018 13:43:18 +0000
Message-ID: <20181015134255.4634-1-urs.fassler@bbv.ch>
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
	6:U7ZG7T0i827bKMe5dv1wDxHxSSx5adBeHfym9jbytcaEUgq8MGrirOmr67RtylqiOSTbS4pupaLmxV/aEABAmJfLUViooUX8qxtrRk1eW+bzZTv6p1FwoxtG6DiXOPqidh/OfNTUtg7r3Jkqb75GyNN22dPKWv7Ezpmzso0UcYkupD4OpxBjl/WEieEKkxl2/H7gpPgMxqupZLIkcJ8iqUQetDpil1+vAv5bR9MG4L8IZu9FYoHZ78uCS+FgLK2fbTsUJz4qblu4nGUkI0HYDyWisq5qN4xMDaWpF4g+xiN1ik2hY7/xf6ol/1GsmW+GQjHrg4dGQz2KMAvR4n1+y/unYhB3NVtoeoWeCxm8g9B8/9lxYIYJPzJRjALBhD2IthPDaqlTJdwAI8pSd0wNY20K+EuM/leICdxe85TB2aMgJe36GRc69Hrj1CgAzbLYSo/97R9IAcuI9HLq4fcTpg==;
	5:azs8q8IqoRvC5igxiVO7hNQdMYsbbBLuKDT8/avswWQGj9bACsOtEPMkrwDX9SmCiKUxGcgwuJdEfircGcQkicM9oQS6V9CIrkbe30+wsTrfM3NgE6Sqc6KMD1QQJqYsuTa3xyMoucK6b8hSU9CCLaEq8/q3lTCIeUvgq0XzSqM=;
	7:jjSm+9VNwmrUbh55B3DR4TyqQkqYAJ3FrG4EeYjGLTLg5te4Sd+gRt4qmpbdAzKXNxJOhVYhy+X6frA7aeco7m95A8Ub8WNeKN/+DyntnqenO8QXpWz69uBjbzZdu7IiDQH7kdPDiLAN2jcdjmDtZeWb9KkwqLBKVhbd8LffjyTJ6FHa8wNvPhQ5LgLdEIZafht28zeI141805eVzln0NoHzsyx53du/aR4VvTwDwCUHgtEsCBV7EDOWnUzTpE5O
x-ms-office365-filtering-correlation-id: 34eaf547-f787-4f3a-ccd5-08d632a429c8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
X-MS-TrafficTypeDiagnostic: AM6PR03MB4421:|AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB4421D698166AB2E77D7629E78FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(81156014)(1076002)(6916009)(66574009)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(486006)(85202003)(106356001)(2900100001)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: IVxVQ6t02cW+QADs7Taf5gXRscjtFk63NPfsLxsJcb5omtqOc/DkcaVXBm9eXwJBhkSLByd3SNi9+T0koG2kzln3sf6XXE+oxZCyzZaKPwqozdGWF4AAIEQDalngQV30rZDgsI9PnHgLaSy6qijbQKEg7cJodFBGuq5swrbgltSdYddoLZH58eJz7o3qwIgUuNDs4T9rZLBBjdclJGKjj/cIZsk+vCihyNhkl824X1f6/xRGBVpjP95+u27fmnLkFNmmF+5Ow5mT3snARkEUCaFSKP7I8lEyjbdnY9WZwuGdKs4X/QNXGtly2uzeJdv4IP+AYDY0dZ6yttkB+cPADFrJflRGZ12L4wZcoZ1snKI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eaf547-f787-4f3a-ccd5-08d632a429c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:18.3117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB4421;
	23:WuBH5FERkh8BgMCyPBe6bfeDMRMbCsJ1O6ya/q5T2gP8mSUUUnjeScTMWM4DV4vdgVRNbDkHONs4KE5WC3GOFi2j8iH/zfwyC6sJyAyKCNjnAZHPfqCNk3TOHWEPCCLV8GG/5PMHgyCuko+MkreYcQ==
X-OriginatorOrg: bbv.ch
Subject: [PATCH 0/7] Add symlinks for git (shallow) tarballs when name differs due to mirror rewrite rules
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
X-List-Received-Date: Tue, 16 Oct 2018 19:44:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <02615389B74EA24098B4843E0390CFDD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhlIGdpdCAoc2hhbGxvdykgdGFyYmFsbHMgYXJlIG5vdCBmb3VuZCB3aGVuIGNlcnRhaW4gbWly
cm9yIHJld3JpdGUgcnVsZXMgYXJlDQppbiB1c2UuIFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRo
YXQgdGhlIHRhcmJhbGwgaXMgbmFtZWQgYWNjb3JkaW5nIHRvIHRoZSB1cmwNCndoZXJlIGl0IGlz
IGRvd25sb2FkZWQgZnJvbS4gVGhlIGVycm9yIG9jY3VycyBpbiB0aGUgdW5wYWNrIHN0ZXAgd2hl
cmUgQml0QmFrZQ0KbG9va3MgZm9yIGEgdGFyYmFsbCBuYW1lZCBhZnRlciB0aGUgdXJsIGFzIHNw
ZWNpZmllZCBpbiB0aGUgcmVjaXBlLiBCeSBhZGRpbmcNCnRoZSBzeW1saW5rcyBCaXRCYWtlIGZp
bmRzIHRoZSB0YXJiYWxscyBpbiB0aGUgdW5wYWNrIHN0ZXAuDQoNClRoaXMgaXMgYW4gYWx0ZXJu
YXRpdmUgdG8gdGhlIHBhdGNoZXMgIkFsd2F5cyB1c2UgdGhlIHVybCBzcGVjaWZpZWQgaW4gdGhl
DQpyZWNpcGUgYXMgYSBiYXNlIGZvciB0aGUgZ2l0IHNoYWxsb3cgdGFyYmFsbCBuYW1pbmciIGZy
b20gdGhlIDIzLjA3LjIwMTguIFRoaXMNCnNvbHV0aW9uIGlzIG1vcmUgYWxpZ25lZCB0byB0aGUg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBCaXRCYWtlLg0KDQpSZWdhcmRzDQpVcnMNCg0KVXJz
IEbDpHNzbGVyICg3KToNCiAgZmV0Y2gyL2dpdDogYWRkIHRlc3RzIHRvIGNhcHR1cmUgZXhpc3Rp
bmcgYmVoYXZpb3Igd3J0LiBuYW1pbmcgb2YNCiAgICBjbG9uZSBkaXJlY3Rvcmllcw0KICBmZXRj
aDIvZ2l0OiBhZGQgdGVzdHMgdG8gY2FwdHVyZSBleGlzdGluZyBiZWhhdmlvciB3cnQuIG5hbWlu
ZyBvZg0KICAgIG1pcnJvciB0YXJiYWxsDQogIGZldGNoMi9naXQ6IGFkZCB0ZXN0cyB0byBjYXB0
dXJlIGV4aXN0aW5nIGJlaGF2aW9yIHdydC4gbmFtaW5nIG9mIGdpdA0KICAgIHNoYWxsb3cgdGFy
YmFsbA0KICBmZXRjaDIvZ2l0OiB1c2UgaW50ZW50aW9uIHJldmVhbGluZyBuYW1lcyBmb3IgcHJl
bWlycm9yIHRlc3RzDQogIGZldGNoMjogZXh0cmFjdCB0aGUgZnVuY3Rpb24gd2hpY2ggZW5zdXJl
cyB0aGF0IGEgdmFsaWQgc3ltbGluayBleGlzdHMNCiAgZmV0Y2gyOiBhZGQgc3ltbGlua3MgZm9y
IG1pcnJvciB0YXJiYWxscw0KICBmZXRjaDI6IGFkZCBzeW1saW5rIGZvciBzaGFsbG93IG1pcnJv
ciB0YXJiYWxscw0KDQogbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8ICAzMSArKystLQ0KIGxp
Yi9iYi90ZXN0cy9mZXRjaC5weSAgICAgfCAyMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDI0NiBpbnNlcnRpb25zKCspLCAyMCBkZWxl
dGlvbnMoLSkNCg0KLS0gDQoyLjE5LjENCg0K

