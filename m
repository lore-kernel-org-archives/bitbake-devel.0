Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 21712 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 03 Oct 2018 18:20:59 UTC
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr30064.outbound.protection.outlook.com [40.107.3.64])
	by mail.openembedded.org (Postfix) with ESMTP id 32A5E747F3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Y13mzl2h1eWzq/WcTyzt5QWSvzinvcX3OAGjykVUlCs=;
	b=EiK+osTf5nPpycvSBpbQIakGkbIsBf3WGDsC+2/xWaiE5CwjNyRig8CUYMqz+aIu43PzlvHThY+cLwdeAwV6wzqyK1dMJj01w4AThdzf+K7BL2gTadXhnmrcALMxAHoSVcpZJlmqWk39wp0XZS9OlQnipcnn5kh0l+jnmLa4sSk=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:04:08 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:08 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 4/7] tests/data: extract LogRecord into own file
Thread-Index: AQHUWxEvd6eLJ5V3Uk+/R5VbeRUGYw==
Date: Wed, 3 Oct 2018 12:04:07 +0000
Message-ID: <20181003120346.3523-5-urs.fassler@bbv.ch>
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
	6:bVYlwIuN5i5nNBDdvZfXdpu5E4Tvk4RBwSK6Nm+H3nyc4W3G95VYiBUTZTJNxcdItG/483PKyLrxTWQ7qpQsz2m9HgYEBR/gAi7zWDVyLAz7d1h2iL68UYlJM6XGgmz3BuLuCi8B4oQAHSgZgneHzc7NG/3oWe8x3NH8b39yqBOsngcCCtNs+AT7Jy8Hm4wLjb2TNk3zfdGgNWhlGA7/98Nlo1Yo3tuTQ7CHvudoOwjiRBCp1zjqZh/bi0jcSoA5g8mo5XXG8UDGWywM73EwED0MW4/Ypfl5aQVVBRO7xV+TyMwnOTZ7qEMAdcRu2mKl1OAREarLOCxg7AgvRMBq221Akw4QthEImaqvWeuei2w7DnY0F0Nnxby1/8iMz9+jYKE4tt6eKZa6I6Ek9FAgcQ8HrNeazlOeCtrRn9mWrsbXC7p30HosRKppN9GHO1vYpysPabr4EOOgyuQsx2LgLg==;
	5:yow2XM9TBs5y/lvPyp0hL7TiCd33Qt6C1fkXa9btEtbv7bjBKHuYHWnIaZeLJBWuA2KvMDJA/8zFEquZl9WXqoBrq4XD2+/ao1TqrwDR3Zde0gnCvT9KinFY7RsWusZ49aDwPDTpUphYN6dLy8XPLJVPmBKfdVZJCT/0dso8zFk=;
	7:hf3U2FJyweyL3uLbqSkjPnUuz12zYyQqyuzJ42BmAZLhmVmWZFExrXJqNGxS7YGUl5GBIhzFGCkXoxZ10W1t6/ilHi1MZjxL3XrdJLxO8k3iTTpuK6b5Np9EGm5oR/mrbGjJHDHufQ+ohieCwTej4dlwGFvQWVOjEetOODCkn7UgELA+faleBH/pEu++bzA5FIGoFxcolj/84kxo2vUzLE+cWumK/++2lfp/CbSzWCaSQVpWJjq0WL10HK/hYWmp
x-ms-office365-filtering-correlation-id: f07417e1-bdd4-4a4b-cf0a-08d62928524b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
X-MS-TrafficTypeDiagnostic: DB7PR03MB3754:|DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB3754B6AE9CB736241AEA4ECC8FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(6436002)(86362001)(6916009)(5640700003)(2900100001)(54906003)(74482002)(5660300001)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(52116002)(36756003)(11346002)(33896004)(305945005)(386003)(6506007)(486006)(76176011)(7736002)(25786009)(71200400001)(446003)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002)(2004002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: rNt6P6Z9EEC/hlvQYb588EK/34bXBkWjqusfRs9jnHZJ813Bhg0IFXzNQZDfXDWLcpeTUSDsN6PMQ+eHkW545Ba075kyQQ4otM/CQ0GfvIMUIQtfnHPBSABqRF+mWbbhIwBDnQ2ht05T3xHS3C6aShkdsh+z36V4QafoMFjhGepdWbkSn/ODBYsOohbijDip9W2irtxySuQJotCsoi6vjyLWTRbPbC53/uc8fOJFfGT+/CAv1ujGvBxq4clOx0rtMZOtPziZdBLmG9+Eidxw3xbeuEwboRLA2/qZjlfQxXj5vYccUqe7khixIv258HmGGSLV0OeLjnP3igrj/HJoN6BoBebLF6X5ZRIUtk+Ng7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f07417e1-bdd4-4a4b-cf0a-08d62928524b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:07.8866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3754;
	23:IiDX5LkwZ/F4Ewm9DUF2eT5cbPpGhHYkAR0hEflw9lEpbR6Nb2wlMQnlQhyfJpe50AJsDAmdyBdhC+9YPqFMzVh2LS1JVcli4VXBcsGGK9v7J8bwoW6Urx1VyDSVqthCAMGhDKLauh201NlvXNREtg==
X-OriginatorOrg: bbv.ch
Subject: [PATCH 4/7] tests/data: extract LogRecord into own file
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
X-List-Received-Date: Wed, 03 Oct 2018 18:20:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <86CAF5832AC6CC41A1419688FC2A54F7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

TG9nUmVjb3JkIGlzIGEgbWVjaGFuaXNtIHRvIGNhcHR1cmUgdGhlIGxvZyBvdXRwdXQuIEl0IGlz
IHVzZWQgaW4gdGhlDQpkYXRhIHRlc3RzLiBJdCBpcyBtb3ZlZCBpbnRvIGl0cyBvd24gZmlsZSB0
byBiZSB1c2VkIGJ5IG90aGVyIHRlc3RzLg0KDQpTaWduZWQtb2ZmLWJ5OiBVcnMgRsOkc3NsZXIg
PHVycy5mYXNzbGVyQGJidi5jaD4NClNpZ25lZC1vZmYtYnk6IFBhc2NhbCBCYWNoIDxwYXNjYWwu
YmFjaEBzaWVtZW5zLmNvbT4NCi0tLQ0KIGxpYi9iYi90ZXN0cy9kYXRhLnB5ICAgICAgfCAyNSAr
LS0tLS0tLS0tLS0tLS0tLS0tDQogbGliL2JiL3Rlc3RzL2xvZ3JlY29yZC5weSB8IDUxICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNTIg
aW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi9i
Yi90ZXN0cy9sb2dyZWNvcmQucHkNCg0KZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0cy9kYXRhLnB5
IGIvbGliL2JiL3Rlc3RzL2RhdGEucHkNCmluZGV4IGE0YTlkZDMwLi5lODEyMWEyMSAxMDA2NDQN
Ci0tLSBhL2xpYi9iYi90ZXN0cy9kYXRhLnB5DQorKysgYi9saWIvYmIvdGVzdHMvZGF0YS5weQ0K
QEAgLTI0LDMwICsyNCw3IEBAIGltcG9ydCB1bml0dGVzdA0KIGltcG9ydCBiYg0KIGltcG9ydCBi
Yi5kYXRhDQogaW1wb3J0IGJiLnBhcnNlDQotaW1wb3J0IGxvZ2dpbmcNCi0NCi1jbGFzcyBMb2dS
ZWNvcmQoKToNCi0gICAgZGVmIF9fZW50ZXJfXyhzZWxmKToNCi0gICAgICAgIGxvZ3MgPSBbXQ0K
LSAgICAgICAgY2xhc3MgTG9nSGFuZGxlcihsb2dnaW5nLkhhbmRsZXIpOg0KLSAgICAgICAgICAg
IGRlZiBlbWl0KHNlbGYsIHJlY29yZCk6DQotICAgICAgICAgICAgICAgIGxvZ3MuYXBwZW5kKHJl
Y29yZCkNCi0gICAgICAgIGxvZ2dlciA9IGxvZ2dpbmcuZ2V0TG9nZ2VyKCJCaXRCYWtlIikNCi0g
ICAgICAgIGhhbmRsZXIgPSBMb2dIYW5kbGVyKCkNCi0gICAgICAgIHNlbGYuaGFuZGxlciA9IGhh
bmRsZXINCi0gICAgICAgIGxvZ2dlci5hZGRIYW5kbGVyKGhhbmRsZXIpDQotICAgICAgICByZXR1
cm4gbG9ncw0KLSAgICBkZWYgX19leGl0X18oc2VsZiwgdHlwZSwgdmFsdWUsIHRyYWNlYmFjayk6
DQotICAgICAgICBsb2dnZXIgPSBsb2dnaW5nLmdldExvZ2dlcigiQml0QmFrZSIpDQotICAgICAg
ICBsb2dnZXIucmVtb3ZlSGFuZGxlcihzZWxmLmhhbmRsZXIpDQotICAgICAgICByZXR1cm4NCi0N
Ci1kZWYgbG9nQ29udGFpbnMoaXRlbSwgbG9ncyk6DQotICAgIGZvciBsIGluIGxvZ3M6DQotICAg
ICAgICBtID0gbC5nZXRNZXNzYWdlKCkNCi0gICAgICAgIGlmIGl0ZW0gaW4gbToNCi0gICAgICAg
ICAgICByZXR1cm4gVHJ1ZQ0KLSAgICByZXR1cm4gRmFsc2UNCitmcm9tIGJiLnRlc3RzLmxvZ3Jl
Y29yZCBpbXBvcnQgTG9nUmVjb3JkLCBsb2dDb250YWlucw0KIA0KIGNsYXNzIERhdGFFeHBhbnNp
b25zKHVuaXR0ZXN0LlRlc3RDYXNlKToNCiAgICAgZGVmIHNldFVwKHNlbGYpOg0KZGlmZiAtLWdp
dCBhL2xpYi9iYi90ZXN0cy9sb2dyZWNvcmQucHkgYi9saWIvYmIvdGVzdHMvbG9ncmVjb3JkLnB5
DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAuLjI2OTNlNGZmDQotLS0gL2Rl
di9udWxsDQorKysgYi9saWIvYmIvdGVzdHMvbG9ncmVjb3JkLnB5DQpAQCAtMCwwICsxLDUxIEBA
DQorIyBleDp0cz00OnN3PTQ6c3RzPTQ6ZXQNCisjIC0qLSB0YWItd2lkdGg6IDQ7IGMtYmFzaWMt
b2Zmc2V0OiA0OyBpbmRlbnQtdGFicy1tb2RlOiBuaWwgLSotDQorIw0KKyMgQml0QmFrZSBUZXN0
cyBmb3IgdGhlIERhdGEgU3RvcmUgKGRhdGEucHkvZGF0YV9zbWFydC5weSkNCisjDQorIyBDb3B5
cmlnaHQgKEMpIDIwMTAgQ2hyaXMgTGFyc29uDQorIyBDb3B5cmlnaHQgKEMpIDIwMTIgUmljaGFy
ZCBQdXJkaWUNCisjDQorIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KKyMgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCisjIHB1Ymxpc2hlZCBi
eSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KKyMNCisjIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KKyMgYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YN
CisjIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZSB0aGUNCisjIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
DQorIw0KKyMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYWxvbmcNCisjIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdy
aXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sDQorIyA1MSBGcmFua2xp
biBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBLg0KKyMNCisN
CitpbXBvcnQgbG9nZ2luZw0KKw0KKw0KK2NsYXNzIExvZ1JlY29yZCgpOg0KKyAgICBkZWYgX19l
bnRlcl9fKHNlbGYpOg0KKyAgICAgICAgbG9ncyA9IFtdDQorDQorICAgICAgICBjbGFzcyBMb2dI
YW5kbGVyKGxvZ2dpbmcuSGFuZGxlcik6DQorICAgICAgICAgICAgZGVmIGVtaXQoc2VsZiwgcmVj
b3JkKToNCisgICAgICAgICAgICAgICAgbG9ncy5hcHBlbmQocmVjb3JkKQ0KKw0KKyAgICAgICAg
bG9nZ2VyID0gbG9nZ2luZy5nZXRMb2dnZXIoIkJpdEJha2UiKQ0KKyAgICAgICAgaGFuZGxlciA9
IExvZ0hhbmRsZXIoKQ0KKyAgICAgICAgc2VsZi5oYW5kbGVyID0gaGFuZGxlcg0KKyAgICAgICAg
bG9nZ2VyLmFkZEhhbmRsZXIoaGFuZGxlcikNCisgICAgICAgIHJldHVybiBsb2dzDQorDQorICAg
IGRlZiBfX2V4aXRfXyhzZWxmLCB0eXBlLCB2YWx1ZSwgdHJhY2ViYWNrKToNCisgICAgICAgIGxv
Z2dlciA9IGxvZ2dpbmcuZ2V0TG9nZ2VyKCJCaXRCYWtlIikNCisgICAgICAgIGxvZ2dlci5yZW1v
dmVIYW5kbGVyKHNlbGYuaGFuZGxlcikNCisgICAgICAgIHJldHVybg0KKw0KKw0KK2RlZiBsb2dD
b250YWlucyhpdGVtLCBsb2dzKToNCisgICAgZm9yIGwgaW4gbG9nczoNCisgICAgICAgIG0gPSBs
LmdldE1lc3NhZ2UoKQ0KKyAgICAgICAgaWYgaXRlbSBpbiBtOg0KKyAgICAgICAgICAgIHJldHVy
biBUcnVlDQorICAgIHJldHVybiBGYWxzZQ0KLS0gDQoyLjE5LjANCg0K

