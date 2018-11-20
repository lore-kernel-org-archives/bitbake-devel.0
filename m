Return-Path: <samuli.piippo@qt.io>
X-Greylist: delayed 23301 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 21 Nov 2018 19:37:29 UTC
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
	(mail-eopbgr80103.outbound.protection.outlook.com [40.107.8.103])
	by mail.openembedded.org (Postfix) with ESMTP id AEF376C4AA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2018 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=l1u82oQtbZujyCSchahrAvDYyAwX97/lxgkRJ/66II4=;
	b=HumljsbY7kQAweukWENP3zRY4Crojr+Xz7y7D+n0A0hMQOsLu1nn2S/Qob2KN2sJp7MNDNQTA0kPvWmj8LxBQ4PgH25NCzpVBtnRI9EAHjvkp8DtWHnloLX9UsT62KgIJwfSR1o3wgXVzD8RWZx4T/cTm3VYrS1eSCqg5prwV/c=
Received: from HE1PR0201MB2265.eurprd02.prod.outlook.com (10.168.145.136) by
	HE1PR0201MB2249.eurprd02.prod.outlook.com (10.168.145.21) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1339.23; Tue, 20 Nov 2018 09:17:33 +0000
Received: from HE1PR0201MB2265.eurprd02.prod.outlook.com
	([fe80::e588:a17c:cfbc:83f9]) by
	HE1PR0201MB2265.eurprd02.prod.outlook.com
	([fe80::e588:a17c:cfbc:83f9%8]) with mapi id 15.20.1294.045;
	Tue, 20 Nov 2018 09:17:33 +0000
From: Samuli Piippo <samuli.piippo@qt.io>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] bitbake-dumpsig: fix dumpsig with task name
Thread-Index: AQHUgLHeQu3F8ZR7V02vjyBSGCz7og==
Date: Tue, 20 Nov 2018 09:17:33 +0000
Message-ID: <20181120091703.32281-1-samuli.piippo@qt.io>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.89.120.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6P193CA0088.EURP193.PROD.OUTLOOK.COM
	(2603:10a6:209:88::29) To HE1PR0201MB2265.eurprd02.prod.outlook.com
	(2603:10a6:3:7f::8)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=samuli.piippo@qt.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0201MB2249;
	6:eGMytla2jurO+Xgrj4YNr1E1GCU5ORhy/TLCJcTsCh2UF5DYoDgkYG5LUbeKPJ/gbLVXZb7kIUsd/585McY09k0FN6U7EqgCa38rwIrMmmrkTBQEbNZ83/PBxDralGNrFoIVTxGqVBQg6ziXgSCUKLGYwpPLDieYWhlgg+COD09pT1n7wnt7vsai+lBfeZe8TCyZYPrJ6ySMqQYaA6P7GCdFlBo++CVrQ1lK6GMw5B9DMEDarz0ULwK8lclFME/Zy+gVdBB691/SXJ760JCxlcxY8OLgdFxand2uqcgUOVMP9MBGtHW97gJ0u4ir+uuXpV3oic24UBNoIy+Xx9nFn8vneO0k3LPWfInYQ7Rho8odTLbCWBFwjpZepYM7aB07cn3HWN1C388oePScuGFa9uOlxzqf6MMpyB8U7d1/upyzZYcyaG/i7c5hvdoSGuKmdzRPKk6Qs6HF6UQj+7b3Vg==;
	5:+Z96Dnl1TuekAm1mCFxosnWxzPgh/RzIKmn7lpxkeeixBBeyvIRd5XLqHNc3M32eapty/8bYgu1g+YWHvrHJjC9g47oHIYVr5wadX/Oqr/7e5ZuloHXoUs6p9DUSZ0d/mN4+sOjGt92/T69In3c7a1C8gg0DlnOLPqY4V0n5U94=;
	7:WcOxA+J9u/+FHO8u1BkH09xdcz2kWk+J+NQRD/HQIRBk4kY4y9A6e1wLQr5dA1XQkQUTOSXTb6N60ypx7KTjZ93RAvL08cJtBvuwApnm1Ts0fJx97XyhKfebrFZh0IO5fB5GYk3uYOb8a5Ye1fCJ6w==
x-ms-office365-filtering-correlation-id: acc81e89-8462-426a-7dc4-08d64ec900c0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:HE1PR0201MB2249; 
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2249:|HE1PR0201MB2249:|HE1PR0201MB2249:|HE1PR0201MB2249:
x-microsoft-antispam-prvs: <HE1PR0201MB2249FAE11EED173769D67DE5E9D90@HE1PR0201MB2249.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
	SRVR:HE1PR0201MB2249; BCL:0; PCL:0; RULEID:;
	SRVR:HE1PR0201MB2249; 
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39850400004)(199004)(189003)(386003)(106356001)(105586002)(6506007)(99286004)(6436002)(52116002)(256004)(305945005)(6486002)(2351001)(7736002)(33896004)(86362001)(50226002)(6512007)(5660300001)(476003)(486006)(44832011)(2616005)(5640700003)(102836004)(66066001)(26005)(2900100001)(53936002)(81166006)(81156014)(8676002)(8936002)(186003)(1857600001)(6916009)(68736007)(478600001)(1076002)(6116002)(97736004)(36756003)(74482002)(2501003)(71200400001)(25786009)(2906002)(316002)(71190400001)(3846002)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0201MB2249;
	H:HE1PR0201MB2265.eurprd02.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: qt.io does not designate permitted
	sender hosts)
x-microsoft-antispam-message-info: j1FieN2zmKJhygPWeFRU6UYyMD/bxpajc7WKvA/CAUv/pAOS1kMkoU/Sn2xgnWDuiSosZtLaojesmGP1UmVRtIPPyn34UncqaV0iwZ99zcFWEaXgUTZbQPnIJs6WbpP0905zIZO/MIlBuhR2HzPmdsU0KgP9mr1/vJahjIsS1V4WPlkVUkxqbmHDnBk/UjNbO2mG1vWYl36pvH8u+iaEo0eVZkI2arxfnpe/xBxjMWDxhn6ChmCDJsZmJQE+tXDwoag6BYJUqb8VErAFlby4e4IibNYQ/YBoQiZLrVRYejcMsECgQfSt0zg6I7c+hLqmmPFOpZ8GS2T2vs7yyMTJW8YQT9hPAslk2zqOBLMWaqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: acc81e89-8462-426a-7dc4-08d64ec900c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:17:33.3296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2249
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0201MB2249;
	23:JwD4rAik7DBIiymylaVMLNY3E1lGmRhxeUXV4JwbkeLfagQZSqkLI5mYG9eV/Xm8cD4EizViOBFy0bu9+wpu1I/13Vgk1olrhbKWqmwm33xvl7DC2MFFIwPK0YJNuP29TBqLzPB2V2xLNVTHB/YJyQ==;
	23:uBZ4Al8bFHPUT9AMet39hJzV03tK+ART3EWrgu5RoTOKRygsyNATEJKZno0n+f5cNDh3O7s9AjJq/yRPQ+t241RAYRDC3U3ykDgV0+MW/D1kJmP0tZVa+gLUcivKmjvpZsImOjKl+juo6cxU7y3wBA==;
	23:OJjfoORmhUHbESHpd4lLarRe3VUHlCUwmlK6IB9KVPpn5Znke9HJe8TggFu0PtEfLWo9ahImLa+fHXj1CWbo0RWpqIwkA+c49Tdg6ef56UA9R1pcYFdm47pzjFKC2CP7ENjb6RcIT9SaGZhl4G3ECg==
X-OriginatorOrg: qt.io
X-Mailman-Approved-At: Thu, 22 Nov 2018 09:55:43 +0000
Subject: [PATCH] bitbake-dumpsig: fix dumpsig with task name
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
X-List-Received-Date: Wed, 21 Nov 2018 19:37:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Use same the same event as bitbake-diffsig since find_siginfo
is not accessible. Fixes error: "Metadata does not support
finding signature data files"

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 bin/bitbake-dumpsig | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-dumpsig b/bin/bitbake-dumpsig
index 95ebd935..a6b461b9 100755
--- a/bin/bitbake-dumpsig
+++ b/bin/bitbake-dumpsig
@@ -33,17 +33,38 @@ import bb.msg
=20
 logger =3D bb.msg.logger_create('bitbake-dumpsig')
=20
+def find_siginfo(tinfoil, pn, taskname, sigs=3DNone):
+    result =3D None
+    tinfoil.set_event_mask(['bb.event.FindSigInfoResult',
+                            'logging.LogRecord',
+                            'bb.command.CommandCompleted',
+                            'bb.command.CommandFailed'])
+    ret =3D tinfoil.run_command('findSigInfo', pn, taskname, sigs)
+    if ret:
+        while True:
+            event =3D tinfoil.wait_event(1)
+            if event:
+                if isinstance(event, bb.command.CommandCompleted):
+                    break
+                elif isinstance(event, bb.command.CommandFailed):
+                    logger.error(str(event))
+                    sys.exit(2)
+                elif isinstance(event, bb.event.FindSigInfoResult):
+                    result =3D event.result
+                elif isinstance(event, logging.LogRecord):
+                    logger.handle(event)
+    else:
+        logger.error('No result returned from findSigInfo command')
+        sys.exit(2)
+    return result
+
 def find_siginfo_task(bbhandler, pn, taskname):
     """ Find the most recent signature file for the specified PN/task """
=20
-    if not hasattr(bb.siggen, 'find_siginfo'):
-        logger.error('Metadata does not support finding signature data fil=
es')
-        sys.exit(1)
-
     if not taskname.startswith('do_'):
         taskname =3D 'do_%s' % taskname
=20
-    filedates =3D bb.siggen.find_siginfo(pn, taskname, None, bbhandler.con=
fig_data)
+    filedates =3D find_siginfo(bbhandler, pn, taskname, None)
     latestfiles =3D sorted(filedates.keys(), key=3Dlambda f: filedates[f])=
[-1:]
     if not latestfiles:
         logger.error('No sigdata files found matching %s %s' % (pn, taskna=
me))
--=20
2.17.1


