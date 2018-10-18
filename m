Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 28780 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 18 Oct 2018 22:14:24 UTC
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
	(mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
	by mail.openembedded.org (Postfix) with ESMTP id 303DB78DEC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 22:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=6XYraH294TdPar6VEz4DS8vKe4S1WIzoOt2VEGt438M=;
	b=rR4cXWQfD9N0ssOgGcdlZZpLYdWlizrhXp1xddHDBRYPpxCdf6dOIn8nriyKBMKIYmMtC7BMZlPLIqGnyVFYRr55Sqnl8QkxLY8brJS/xfPitAx1HQc5pQWg4nF5H/NBX8yJp0E/Ug3lps5RXvEH6T9hMvvk84Q98+ZMyTppxxc=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4039.eurprd03.prod.outlook.com (20.177.38.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.24; Thu, 18 Oct 2018 09:41:01 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.032;
	Thu, 18 Oct 2018 09:41:01 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 1/2] fetch2: add symlinks for mirror
	tarballs
Thread-Index: AQHUZsatEkik8sRbakyDSIToQ6ePaA==
Date: Thu, 18 Oct 2018 09:41:01 +0000
Message-ID: <20181018094051.20530-2-urs.fassler@bbv.ch>
References: <20181018094051.20530-1-urs.fassler@bbv.ch>
In-Reply-To: <20181018094051.20530-1-urs.fassler@bbv.ch>
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
	6:U7SMbHlRq1kAXx7V9zj+5KyF0QR+PNpUt8rIM7IsSI2VAFJ8FdiF5qRfCvJ5zdr07QeIztLWiIXEbHzyysuOHGmSojsKXNtvKh8WE+FiV8wbhtgCxDg+Px9zBsNg56OUqz70nuOMmiHhNNat14p467UcQQG2wAi1aonFLfYT9epzgBVndIb47P3khmPH7izWckOg1MNOfSemZWpbAsZhSSgswjbSaoGwi9SQYV37n/oi7aAn1RfhSMWQ42u2J37KE6of5HgOOK35WFIEeMYQI5GeH/+e22yzmln/9YcF2geQ6F5V2W9CILZKLD+R/B24qvnDMtw+R8xqZMsUXEF4/e4Em+b3iufoUFPsubt2suIjW3o9UZkNztcZQEV0iKDS5AwcjXFE++Az5q8L5GvlG63se4pyuU9ymH60t4cvCPpo3BcHQsPYbgF3N3/e32es5W4bKNb+mWfIaGA4OoQjLQ==;
	5:Z77pZEQ4NWjhIYL+uhPNC49wEuri33L0Jg9lkGzTHQ15LrzGk/UnuNC651Hux9LwDT2Z1JGI+xIctitVyni5OM29cvWI5b+0+ADk19T3OOLfBsTXm6nVwv0LDbdO2X4zGHVRZyHP25cX/bGdtXNg7R7MxIYmMvpA2l46lvGVNoA=;
	7:I8s3FG+AxEFlCEXKyrpNuvxcoJI+kci4aGgXrlHuaLgYVhLHNWb7C584CZDWvdVLMrBF5fp1PLtjFGQL/O0H6GXuLOwP5nOO4ln2J/MgInyX6RMpMCK7X6D02Ly2N4l2hkmsCPH42u0nj98HFcKZqYAKjaFTFdGeJ/ij5/kJ2wv0MFgdXLlKOPb4JojVpdgg0roxQytVqyZQhTIiShnss7BPnIwzqW0xtWmif0idTtLdKG4P3wmXU4feI7TpWe/R
x-ms-office365-filtering-correlation-id: cf5c0b4c-9ce1-44dc-5c20-08d634ddd028
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4039; 
x-ms-traffictypediagnostic: AM6PR03MB4039:
x-microsoft-antispam-prvs: <AM6PR03MB4039FF87E7A472A52F83111F8FF80@AM6PR03MB4039.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
	SRVR:AM6PR03MB4039; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4039; 
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(396003)(346002)(39850400004)(376002)(366004)(136003)(199004)(189003)(6306002)(2501003)(8936002)(71190400001)(25786009)(316002)(6512007)(71200400001)(86362001)(575784001)(54906003)(4326008)(5660300001)(66574009)(1076002)(68736007)(50226002)(36756003)(478600001)(85202003)(76176011)(81166006)(99286004)(2351001)(105586002)(106356001)(966005)(6486002)(8676002)(386003)(305945005)(33896004)(6506007)(7736002)(6916009)(5640700003)(14454004)(52116002)(486006)(6436002)(102836004)(186003)(1857600001)(97736004)(2900100001)(11346002)(74482002)(2616005)(66066001)(476003)(26005)(19273905006)(85182001)(6116002)(2906002)(14444005)(3846002)(256004)(53936002)(5250100002)(81156014)(446003)(403724002)(563064011)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4039;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: bmype/k+RxEvAROFAERBVh624LlD+SNpkINltIafOCwGKYp2MMiPudqY/dR0seb76ngIFzIQR8q/qyd0s7vOfJS+fL0S7dO2Jn0O+OH3rkPAywYyyGf4RoZldSdfr1fedE+74IhRRaL0CCgvbz6Xh63zRHzKd8r2myp7QDwL+z1QZGMNpn3DzPA/nyfzJh9fRSXZ6gjL1VCmLecFy1dfo/DnmJ+e75vMJ0b1NLbN3bo0Ccb1PP8p7ul6oh5S1uhi9Lzex7zPfMk09/mFkXS4RucjGMWL+ijuoL9nNiyI/9nt5ZAqfoh5nRlQ6EgVkj3rF0osnU7E6vN7B7/sM0t+C3MEBfjGPsfSLVgwmuzTW+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5c0b4c-9ce1-44dc-5c20-08d634ddd028
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 09:41:01.1101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4039
Subject: [PATCH v2 1/2] fetch2: add symlinks for mirror tarballs
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
X-List-Received-Date: Thu, 18 Oct 2018 22:14:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <68DFC94AEFFAE647BD0C2B8511BACE28@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SW4gdGhlIHVucGFjayBzdGVwIHRoZSBtaXJyb3IgdGFyYmFsbCBpcyBub3QgZm91bmQgd2hlbiB0
aGUgbWlycm9yZWQNCnRhcmJhbGwgaXMgbmFtZWQgZGlmZmVyZW50bHkgdGhhbiB0aGUgb3JpZ2lu
YWwgdGFyYmFsbC4gVGhpcyBoYXBwZW5zDQpkdWUgdG8gbWlycm9yIHJld3JpdGUgcnVsZXMuIFRv
IHNvbHZlIHRoZSBwcm9ibGVtIHdlIGFkZCBzeW1saW5rcyBmb3INCnRoZSBkaWZmZXJlbnRseSBu
YW1lZCB0YXJiYWxscy4NCg0KU2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xl
ckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVu
cy5jb20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgIDQgKysrDQogbGliL2Ji
L3Rlc3RzL2ZldGNoLnB5ICAgICB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSBiL2xpYi9iYi9mZXRj
aDIvX19pbml0X18ucHkNCmluZGV4IDJiNjJiNDE2Li44NGQyYWY3MyAxMDA2NDQNCi0tLSBhL2xp
Yi9iYi9mZXRjaDIvX19pbml0X18ucHkNCisrKyBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkN
CkBAIC0xMDE5LDYgKzEwMTksMTAgQEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQs
IHVkLCBsZCwgY2hlY2sgPSBGYWxzZSk6DQogICAgICAgICAgICAgcmV0dXJuIG9yaWd1ZC5sb2Nh
bHBhdGgNCiAgICAgICAgICMgT3RoZXJ3aXNlIHRoZSByZXN1bHQgaXMgYSBsb2NhbCBmaWxlOi8v
IGFuZCB3ZSBzeW1saW5rIHRvIGl0DQogICAgICAgICBlbnN1cmVfc3ltbGluayh1ZC5sb2NhbHBh
dGgsIG9yaWd1ZC5sb2NhbHBhdGgpDQorDQorICAgICAgICBpZiBoYXNhdHRyKHVkLCAiZnVsbG1p
cnJvciIpIGFuZCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsbWlycm9yKToNCisgICAgICAgICAgICBl
bnN1cmVfc3ltbGluayh1ZC5mdWxsbWlycm9yLCBvcmlndWQuZnVsbG1pcnJvcikNCisNCiAgICAg
ICAgIHVwZGF0ZV9zdGFtcChvcmlndWQsIGxkKQ0KICAgICAgICAgcmV0dXJuIHVkLmxvY2FscGF0
aA0KIA0KZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9m
ZXRjaC5weQ0KaW5kZXggMTc5MDllYzYuLjBjNjM4MmEyIDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rl
c3RzL2ZldGNoLnB5DQorKysgYi9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCkBAIC0yOSw2ICsyOSwy
MCBAQCBmcm9tIGJiLmZldGNoMiBpbXBvcnQgVVJJDQogZnJvbSBiYi5mZXRjaDIgaW1wb3J0IEZl
dGNoTWV0aG9kDQogaW1wb3J0IGJiDQogDQorDQorZGVmIGdldF9icm9rZW5fc3ltbGlua3MoZGly
ZWN0b3J5KToNCisgICAgcmVzdWx0ID0gW10NCisNCisgICAgZGlyID0gb3MubGlzdGRpcihkaXJl
Y3RvcnkpDQorICAgIGZvciBmaWxlbmFtZSBpbiBkaXI6DQorICAgICAgICBmdWxsbmFtZSA9IGRp
cmVjdG9yeSArICcvJyArIGZpbGVuYW1lDQorICAgICAgICBicm9rZW4gPSAobm90IG9zLnBhdGgu
ZXhpc3RzKGZ1bGxuYW1lKSkgYW5kIG9zLnBhdGguaXNsaW5rKGZ1bGxuYW1lKQ0KKyAgICAgICAg
aWYgYnJva2VuOg0KKyAgICAgICAgICAgIHJlc3VsdCArPSBbZmlsZW5hbWVdDQorDQorICAgIHJl
dHVybiByZXN1bHQNCisNCisNCiBkZWYgc2tpcElmTm9OZXR3b3JrKCk6DQogICAgIGlmIG9zLmVu
dmlyb24uZ2V0KCJCQl9TS0lQX05FVFRFU1RTIikgPT0gInllcyI6DQogICAgICAgICByZXR1cm4g
dW5pdHRlc3Quc2tpcCgiTmV0d29yayB0ZXN0cyBiZWluZyBza2lwcGVkIikNCkBAIC01MzYsNyAr
NTUwLDcgQEAgY2xhc3MgVGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hlclRlc3QpOg0KICAgICAgICAg
c2VsZi5hc3NlcnRJbihzZWxmLnJlY2lwZV90YXJiYWxsLCBkaXIpDQogDQogICAgIEBza2lwSWZO
b05ldHdvcmsoKQ0KLSAgICBkZWYgdGVzdF90aGF0X3RoZV9taXJyb3JfdGFyYmFsbF9pc19jcmVh
dGVkX3doZW5fbWlycm9yaW5nX2lzX3VzZWQoc2VsZik6DQorICAgIGRlZiB0ZXN0X3RoYXRfdGFy
YmFsbF9mb3JfbWlycm9yZWRfdXJsX2FuZF9yZWNpcGVfdXJsX2V4aXN0c193aGVuX21pcnJvcmlu
Z19pc191c2VkKHNlbGYpOg0KICAgICAgICAgc2VsZi5zZXR1cF9taXJyb3JfcmV3cml0ZSgpDQog
ICAgICAgICBmZXRjaGVyID0gYmIuZmV0Y2guRmV0Y2goW3NlbGYucmVjaXBlX3VybF0sIHNlbGYu
ZCkNCiANCkBAIC01NDQsNiArNTU4LDcgQEAgY2xhc3MgVGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hl
clRlc3QpOg0KIA0KICAgICAgICAgZGlyID0gb3MubGlzdGRpcihzZWxmLmRsZGlyKQ0KICAgICAg
ICAgc2VsZi5hc3NlcnRJbihzZWxmLm1pcnJvcl90YXJiYWxsLCBkaXIpDQorICAgICAgICBzZWxm
LmFzc2VydEluKHNlbGYucmVjaXBlX3RhcmJhbGwsIGRpcikNCiANCiANCiBjbGFzcyBHaXRTaGFs
bG93VGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hlclRlc3QpOg0KQEAgLTY0Nyw2ICs2NjIsMTEgQEAg
Y2xhc3MgRmV0Y2hlckxvY2FsVGVzdChGZXRjaGVyVGVzdCk6DQogICAgICAgICB3aXRoIHNlbGYu
YXNzZXJ0UmFpc2VzKGJiLmZldGNoMi5VbnBhY2tFcnJvcik6DQogICAgICAgICAgICAgc2VsZi5m
ZXRjaFVucGFjayhbJ2ZpbGU6Ly9hO3N1YmRpcj0vYmluL3NoJ10pDQogDQorICAgIGRlZiB0ZXN0
X2xvY2FsX21pcnJvcl9vZl9odHRwKHNlbGYpOg0KKyAgICAgICAgc2VsZi5kLnNldFZhcigiUFJF
TUlSUk9SUyIsICIgaHR0cDovLy4qLy4qIGZpbGU6Ly8iICsgc2VsZi5sb2NhbHNyY2RpciArICIg
XG4gIikNCisgICAgICAgIHRyZWUgPSBzZWxmLmZldGNoVW5wYWNrKFsiaHR0cDovL2Rvd25sb2Fk
cy55b2N0b3Byb2plY3Qub3JnL3JlbGVhc2VzL2EiXSkNCisgICAgICAgIHNlbGYuYXNzZXJ0RXF1
YWwodHJlZSwgWydhJ10pDQorDQogY2xhc3MgRmV0Y2hlck5vTmV0d29ya1Rlc3QoRmV0Y2hlclRl
c3QpOg0KICAgICBkZWYgc2V0VXAoc2VsZik6DQogICAgICAgICBzdXBlcigpLnNldFVwKCkNCkBA
IC04ODEsNiArOTAxLDEyIEBAIGNsYXNzIEZldGNoZXJOZXR3b3JrVGVzdChGZXRjaGVyVGVzdCk6
DQogICAgICAgICBzZWxmLmQuc2V0VmFyKCJQUkVNSVJST1JTIiwgImdpdDovL3NvbWVzZXJ2ZXIu
b3JnL2JpdGJha2UgZ2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFrZSBcbiIpDQogICAg
ICAgICBzZWxmLmdpdGZldGNoZXIocmVjaXBldXJsLCByZWNpcGV1cmwpDQogDQorICAgIEBza2lw
SWZOb05ldHdvcmsoKQ0KKyAgICBkZWYgdGVzdF9naXRmZXRjaF9maW5kc19sb2NhbF90YXJiYWxs
X3doZW5fcHJldmlvdXNfZG93bmxvYWRlZF9mcm9tX2FfbWlycm9yKHNlbGYpOg0KKyAgICAgICAg
cmVjaXBldXJsID0gImdpdDovL2dpdC53cm9uZy5vcmcvYml0YmFrZSINCisgICAgICAgIHNlbGYu
ZC5zZXRWYXIoIk1JUlJPUlMiLCAiZ2l0Oi8vZ2l0Lndyb25nLm9yZy9iaXRiYWtlIGdpdDovL2dp
dC5vcGVuZW1iZWRkZWQub3JnL2JpdGJha2UgXG4iKQ0KKyAgICAgICAgc2VsZi5naXRmZXRjaGVy
KHJlY2lwZXVybCwgcmVjaXBldXJsKQ0KKw0KICAgICBAc2tpcElmTm9OZXR3b3JrKCkNCiAgICAg
ZGVmIHRlc3RfZ2l0ZmV0Y2hfZmluZHNfbG9jYWxfcmVwb3NpdG9yeV93aGVuX3ByZW1pcnJvcl9y
ZXdyaXRlc190aGVfcmVjaXBlX3VybChzZWxmKToNCiAgICAgICAgIHJlYWx1cmwgPSAiZ2l0Oi8v
Z2l0Lm9wZW5lbWJlZGRlZC5vcmcvYml0YmFrZSINCkBAIC04OTEsNiArOTE3LDM2IEBAIGNsYXNz
IEZldGNoZXJOZXR3b3JrVGVzdChGZXRjaGVyVGVzdCk6DQogICAgICAgICBzZWxmLmQuc2V0VmFy
KCJQUkVNSVJST1JTIiwgIiVzIGdpdDovLyVzO3Byb3RvY29sPWZpbGUgXG4iICUgKHJlY2lwZXVy
bCwgc2VsZi5zb3VyY2VkaXIpKQ0KICAgICAgICAgc2VsZi5naXRmZXRjaGVyKHJlY2lwZXVybCwg
cmVjaXBldXJsKQ0KIA0KKyAgICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfZ2l0
ZmV0Y2hfdXNlc190aGVfZ2l0X3RhcmJhbGxfd2hlbl91c2luZ19taXJyb3JfcmV3cml0ZV9ydWxl
c19hbmRfdGhlX2dpdF9jbG9uZV9kb2VzX25vdF9leGlzdChzZWxmKToNCisgICAgICAgIHNlbGYu
ZC5zZXRWYXIoJ1NSQ1JFVicsICdlNTkzOWZmNjA4Yjk1Y2RkNGQwYWIwZTE5MzU3ODFhYjlhMjc2
YWMwJykNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ0JCX0dFTkVSQVRFX01JUlJPUl9UQVJCQUxM
UycsICcxJykNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ1BSRU1JUlJPUlMnLCAnZ2l0Oi8vZ2l0
LnlvY3RvcHJvamVjdC5vcmcvLiogZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvZ2l0L1BBVEg7
cHJvdG9jb2w9aHR0cHMgXG4nKQ0KKyAgICAgICAgZmV0Y2hlciA9IGJiLmZldGNoLkZldGNoKFsi
Z2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvZnN0ZXN0cyJdLCBzZWxmLmQpDQorICAgICAgICBm
ZXRjaGVyLmRvd25sb2FkKCkNCisgICAgICAgIGJiLnV0aWxzLnBydW5lZGlyKHNlbGYuZGxkaXIg
KyAnL2dpdDInKQ0KKyAgICAgICAgYmIudXRpbHMucHJ1bmVkaXIoc2VsZi51bnBhY2tkaXIpDQor
ICAgICAgICBzZWxmLmQuc2V0VmFyKCdQUkVNSVJST1JTJywgJycpDQorICAgICAgICBzZWxmLmQu
c2V0VmFyKCdCQl9GRVRDSF9QUkVNSVJST1JPTkxZJywgJzEnKQ0KKw0KKyAgICAgICAgZmV0Y2hl
ci5kb3dubG9hZCgpDQorDQorICAgICAgICBmZXRjaGVyLnVucGFjayhzZWxmLnVucGFja2RpcikN
CisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi51bnBhY2tkaXIgKyAiL2dpdC8iKQ0KKyAg
ICAgICAgc2VsZi5hc3NlcnRJbigiZnN0ZXN0cy5kb2FwIiwgZGlyKQ0KKw0KKyAgICBAc2tpcElm
Tm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF9ub19icm9rZW5fc3ltbGlua3NfZXhpc3Rf
d2hlbl91c2luZ19taXJyb3JfcmV3cml0ZV9ydWxlc19hbmRfbm9fdGFyYmFsbChzZWxmKToNCisg
ICAgICAgIHNlbGYuZC5zZXRWYXIoJ1NSQ1JFVicsICdlNTkzOWZmNjA4Yjk1Y2RkNGQwYWIwZTE5
MzU3ODFhYjlhMjc2YWMwJykNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ0JCX0dFTkVSQVRFX01J
UlJPUl9UQVJCQUxMUycsICcwJykNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ1BSRU1JUlJPUlMn
LCAnZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvLiogZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5v
cmcvZ2l0L1BBVEg7cHJvdG9jb2w9aHR0cHMgXG4nKQ0KKyAgICAgICAgZmV0Y2hlciA9IGJiLmZl
dGNoLkZldGNoKFsiZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvZnN0ZXN0cyJdLCBzZWxmLmQp
DQorDQorICAgICAgICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGJyb2tlbl9zeW1s
aW5rcyA9IGdldF9icm9rZW5fc3ltbGlua3Moc2VsZi5kbGRpcikNCisgICAgICAgIHNlbGYuYXNz
ZXJ0RXF1YWwoW10sIGJyb2tlbl9zeW1saW5rcykNCisNCiAgICAgQHNraXBJZk5vTmV0d29yaygp
DQogICAgIGRlZiB0ZXN0X2dpdF9zdWJtb2R1bGUoc2VsZik6DQogICAgICAgICBmZXRjaGVyID0g
YmIuZmV0Y2guRmV0Y2goWyJnaXRzbTovL2dpdC55b2N0b3Byb2plY3Qub3JnL2dpdC1zdWJtb2R1
bGUtdGVzdDtyZXY9ZjEyZTU3ZjJlZGYwYWE1MzRjZjE2MTZmYTk4M2QxNjVhOTJiMDg0MiJdLCBz
ZWxmLmQpDQotLSANCjIuMTkuMQ0KDQo=

