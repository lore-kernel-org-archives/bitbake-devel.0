Return-Path: <urs.fassler@bbv.ch>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
	by mail.openembedded.org (Postfix) with ESMTP id CB53D795E9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OvWliSxb2hQZze0TVQ23cKSABVfeArEp3NhYmMGXl9A=;
	b=Lkbd+0vNuO2zauT6SizKMFwnCONUBfHguTjcL2j0jLgCoXXmFZXYEo/iMntpM5KI2Yrvy5My5RbxHvx3a7KrsdhaQ78sn2/7AGelgJmIKzpRcXxJiiq3yLgtmJ/QjFvF2eK0qi+/829kMqQv12TZf5q4+aE89cZriYE5dOGNpjw=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:03:57 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:03:57 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 0/7] fetch2/git: Check fullshallow tarball and clonedir
	before access
Thread-Index: AQHUWxEpqahFX948QUS2A8EBKxRHtQ==
Date: Wed, 3 Oct 2018 12:03:57 +0000
Message-ID: <20181003120346.3523-1-urs.fassler@bbv.ch>
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
	6:Pj/Ze93S+61RrDoSaIwv6mVX3kN+AhiMojPG+YmCKclyHXrngwOIEJ1jHmsJ0FDrOjLlc+6AzoNMapUaF+XhHhmTE4qsuyfio/TkWpBw4TnbSRlgZSQL52Me56GS39RbORo50AnoOf4fyg3qXdYzYJe9G6mDi7o6Vi2zm30gsAphSdmLCuYjgtOsgm413jA4gXP0xVBKcglvHNsARiWaOYUORsnLAj7k7SSCRKpFqv892SvQ0n5jwZOoXmWBf/pB6feyVnsNpMVXWUYvEw5upo62f+p6aXvJu+sSoM4EzqemfQRjeM57iJOpffhp+mwvPD95uRT2TQwJifzyFHXvKBrCAhy3v2ZhFJWL6iRoHRT+BGbR5erf+z/mA1zJbuK/HW95R8703Lwb8Br3OvzE/Kv0kYvAgczglxXcN+gc2/2lJjabzBP4swgm+NrjyZIGizO4p/NU8OwuaEhljx4uig==;
	5:J1rC5cRGyMrRL/77hj7O+JTYjQmIO7BrWcccHOt/wpxfMTyU5tZgAdZ4eeneaTYGEY7vCHVEj1OCS084Z9HPrKYjSl+NrtTdYLkkqZjhvijtxcDkTI7rELLCVscuhQ5CFlwbpg/PM9EsexcoOtnA/qXvOgyv4l6Yf0ciRwcOWMg=;
	7:O2GoDJsbvhMggmDRepKTQmCbjRoGalTqy7HVvQ/5b3Pvd08U8yaINwzGheLI7OjzPirY87VTZVIiQKzo9zrbxxVXK+PDvzB/qMJNIyMp2JgwMo8j72k+pierOFQnBp3XNnNAzd5HkO4nNe+LDZoBxPyKs6whuX8Xnp2dp1apFBUZJSJdbwNdoTqu3SvIzdi61iorgqIZmnaJr+chykKtEBYH4PheCh64vjirlxdPORUjeH4Il7FLC2MbvMqDF6bf
x-ms-office365-filtering-correlation-id: 8f2b7c5a-9b1f-47a6-c412-08d629284be7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
x-ms-traffictypediagnostic: DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB375426B027012D2F06B652608FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(6436002)(86362001)(6916009)(5640700003)(2900100001)(74482002)(5660300001)(14444005)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(66574008)(52116002)(36756003)(33896004)(305945005)(386003)(6506007)(486006)(7736002)(25786009)(71200400001)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: gSk/b4vPJgjWzAt1q17BER6chnDhyw5AtD9EGhyITncc5VWHJVmIqeS14WAbH02O/h5R9uIX9mnuJl3cFvsxh9DnUxaCwnJDoTsWA2eXTpF+lSQclBNfpFN0FLKjZYQ3fpqTKAJPblTgEIkijYqYNAHeUA2f0AWB+my+t6JbnX9nP5eF2ZB4Bl4lffwAZvsKgWYUqrVQ9e8MMugPz+bg5rJhZTcNmmAB30ovo93Ka0ml3xUc0ynwrn4TELbU6n/e8v+m9wMVH8EFw7DQucaRGaZOjBDJmUZ0hfKL8U7QPWfu0EovRsGRM4UTZBjNvx9fV8EKE4xchb2TbDtbVZGPI/ameamEsvImQdLp43jaOr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b7c5a-9b1f-47a6-c412-08d629284be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:03:57.2908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
Subject: [PATCH 0/7] fetch2/git: Check fullshallow tarball and clonedir before access
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
X-List-Received-Date: Wed, 03 Oct 2018 15:36:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <193CB68C64B20E4AA685FCD4DFB80861@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

QWRkIGNoZWNrcyBpZiBhIHNvdXJjZSBleGlzdHMgYmVmb3JlIHVucGFja2luZyBpdC4gVGhyb3cg
YW4NCnVuZGVyc3RhbmRhYmxlIGVycm9yIHdoZW4gdGhlIHNvdXJjZSBkb2VzIG5vdCBleGlzdC4N
Cg0KVGhpcyBpcyBhIGZvbGxvdyB1cCBlcnJvciB0aGF0IGhhcHBlbnMgaW4gc29tZSBjYXNlcyB3
aXRoIG1pcnJvcg0KcmV3cml0ZSBydWxlcy4gV2Ugb25seSBmaXggdGhlIGZvbGxvdyB1cCBlcnJv
ciB3aXRoIHRoaXMgcGF0Y2hlcy4NClRoZSBmaXggZm9yIHRoZSByb290IG9mIHRoZSBlcnJvciB3
aWxsIGZvbGxvdy4NCg0KVXJzIEbDpHNzbGVyICg3KToNCiAgZmV0Y2gyL2dpdDogcHJldmVudCBh
Y2Nlc3MgdG8gbm9uLWV4aXN0aW5nIGZ1bGxzaGFsbG93IHRhcmJhbGwNCiAgZmV0Y2gyL2dpdDog
aW1wcm92ZSByZWFkYWJpbGl0eSBvZiBtZXRob2QgbmVlZF91cGRhdGUNCiAgZmV0Y2gyL2dpdDog
dXNlIGNvcnJlY3QgY2hlY2sgdG8gZGVjaWRlIGlmIHRoZSBzaGFsbG93IHRhcmJhbGwgc2hvdWxk
DQogICAgYmUgdW5wYWNrZWQNCiAgdGVzdHMvZGF0YTogZXh0cmFjdCBMb2dSZWNvcmQgaW50byBv
d24gZmlsZQ0KICBmZXRjaDIvZ2l0OiBwcmV2ZW50IGFjY2VzcyB0byBub24tZXhpc3RpbmcgY2xv
bmVkaXINCiAgZmV0Y2gyL2dpdDogZXhwbGljaXRseSBzaG93IHRoZSBkZWNpc2lvbiBsb2dpYyB0
byBzZWxlY3QgdGhlIHNvdXJjZSBpbg0KICAgIGNvZGUNCiAgZmV0Y2gyL2dpdDogcHJvdmlkZSBp
bmZvcm1hdGlvbiBhYm91dCBtaXNzaW5nIHNvdXJjZXMNCg0KIGxpYi9iYi9mZXRjaDIvZ2l0LnB5
ICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCiBsaWIvYmIvdGVzdHMv
ZGF0YS5weSAgICAgIHwgMjUgKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGxpYi9iYi90ZXN0cy9mZXRj
aC5weSAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKysrDQogbGliL2JiL3Rlc3RzL2xvZ3Jl
Y29yZC5weSB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDQg
ZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBsaWIvYmIvdGVzdHMvbG9ncmVjb3JkLnB5DQoNCi0tIA0KMi4xOS4wDQoN
Cg==

