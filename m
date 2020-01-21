Return-Path: <rasmus.villemoes@prevas.dk>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr130097.outbound.protection.outlook.com [40.107.13.97])
	by mail.openembedded.org (Postfix) with ESMTP id 158FB7FD98
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 09:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=HJuRyS3N8v8iCbvh5BBdKsoxO2i/eMwxA7o9znhhxZlozg3Ub1sHq6Il7C625MBkkYxnBNHluVibUG+AJXfoQl/OC6qOASxKGW0U/bUlxvnmtcxNzNrTv1ypYgD9K/zz0F/im9QN6vwi3bdthmxHIvjXhFxoVZMQCo6mATtp/FlkwfQjBzNyDlxLUx0gFRJBDt2x8nGaigP/Gzm0ywrtmdoQcOlKKoPe6uzw2R8W/rsn/Jd/ilwwomSaxbzqH+O8YgHWpa2hY7+5zEaLmlGxWn4B91KF43BV22yatL46ApwZtIHfVPHg7BzwdEJf7wrk7QorUBlT597bGncQBD9kCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=liNTzXTyuOMUWG8Un4MYEXh8oYAIX+QbvHvCQXdM2Cg=;
	b=D84y0d/KmK25hoilcrfXkbHr+oAeLkRSaTutIt+8ZZGphnaq8jHMouu1ff4eB0ptI8nIRrb+DFmJUuDhRhu7okpi5GmvatoZxWaiLVG0k4YHJJyHJ+13O22Yxg9/engi/PVx+Mc1InQJuJvxoVuu4gAAY09b1WPfhSmPQ9VzoTA1XaM8UCQ7kzqbLikhE1RU1x6xqsW1PA9Jb3JJIkQopo+FwA4D/zcKAr4kDG5LadP+I04jeA71Wjps4CQJOEw+oHjOkWpujBzDwzrHv0I6Wzkm/WQQdRzBr4IpFIeyT0xmizWaa3BUOQDp0HZAePnKKvzO4qNk3VS0tE/7DQc3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk; 
	dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=liNTzXTyuOMUWG8Un4MYEXh8oYAIX+QbvHvCQXdM2Cg=;
	b=K0JWEG900ihFMlg1xWLzWbevTsNoRkm+A4PpSCMndYpeUHGYbT6GmFSd6S7foin4tcjveQRu3O1MT1c1eS5uuvHiZRLWunz7ajXkuM7SqE9LGrOSLfp6BBChjQFbnqh4ul5QLVZh8bXA/PuHdxLY81bvgiDmcNclDcHpktb+f6I=
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
	VI1PR10MB3488.EURPRD10.PROD.OUTLOOK.COM (10.186.160.200) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.20; Tue, 21 Jan 2020 09:05:28 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d]) by
	VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d%6]) with mapi id 15.20.2644.026;
	Tue, 21 Jan 2020 09:05:28 +0000
Received: from prevas-ravi.prevas.se (81.216.59.226) by
	AM0PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:208:ab::37)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20
	via Frontend Transport; Tue, 21 Jan 2020 09:05:27 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH v2] build.py: record time spent executing each function
Thread-Index: AQHV0DnspRRJEQaaikilhMpKPfiqoQ==
Date: Tue, 21 Jan 2020 09:05:27 +0000
Message-ID: <20200121090519.24674-1-rasmus.villemoes@prevas.dk>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0024.eurprd06.prod.outlook.com
	(2603:10a6:208:ab::37) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:803:e1::21)
x-mailer: git-send-email 2.23.0
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b344347b-54b7-4756-4ed8-08d79e510eff
x-ms-traffictypediagnostic: VI1PR10MB3488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB3488FCC9F6E62F11B0B3FAE0930D0@VI1PR10MB3488.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(346002)(39850400004)(376002)(136003)(396003)(199004)(189003)(6506007)(5660300002)(6916009)(107886003)(186003)(16526019)(2616005)(956004)(6486002)(8676002)(81166006)(8936002)(81156014)(26005)(6512007)(8976002)(54906003)(71200400001)(4326008)(2906002)(316002)(52116002)(1076003)(478600001)(66556008)(64756008)(86362001)(36756003)(66476007)(66446008)(66946007)(44832011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR10MB3488;
	H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: prevas.dk does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTBYdMO46BKO9maRp1Btxo4oTI5H7LW2HriV8eVTMw7YiEIGigjmkvIxmOO0AaU4C4+FcPtjW9uWaz6Z2t5/lvI+wSJuB6XFpcR05pK1DAmgbGR+G84CRhXPpesDEs7dsdQpcFAUzObpsvAP5CECU+a9YB0I3xAS0ZFoJyDye7XKZFyO9YAPlHOKOdP8tj3x2alHRD0jF8sEpW9HWpO79eJia+ksd4D48E0QUpxJXEvcTfEcw1+i4eoMoDUN5P8cyzdrl5KRdCJzZpRO7LgguwZfSl+Q+iyZ5GmzIm6+Y9XK16QUdmn+ct4kH236jAILsaMgmau5YD1azSqN/PgWsRocTeQEgzqkZMGEk6s5D4+Zoi4hILNvGIC9sFuQEos7UUUlW5KiXzyVdsz0xWHIN7sy7Td0vVf8YePaMyYqd9OoaRvlgwAsMS6/3E1DXHtF
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b344347b-54b7-4756-4ed8-08d79e510eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:05:27.9615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gi9YxG7fprYWc7SGiOgWS4+JuNZKmuPMNQDZ7vswxRWrF5JSnVA2N9UCL8az4zsfJMUn+7KiiI7kajUG5i6yRaTz0z8Onnx3UmVgi2WE14M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3488
Subject: [PATCH v2] build.py: record time spent executing each function
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
X-List-Received-Date: Tue, 21 Jan 2020 09:05:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In order to have a quick way to see if optimizing some task function
actually has an effect, append a little information to each
"Python/Shell function foo finished" line listing the wallclock,
system and user time spent. That can also help figure out which parts
of a recipe is taking the longest and hence find places that might be
worth looking at.

bitbake already has the --profile/-P option, but that produces an
enourmous amount of output. If the above reveals that a certain python
function is slow, that detailed profiling can of course be useful, but
having the above more coarse-grained (and quite lightweight) info
available by default can help one know where to start looking. Also,
in some cases it is immediately obvious what one can do once one knows
that it's some specific postfunc that causes do_foobar to take
forever.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
v2:
- avoid "self" and "sys" as names of local variables.
- fold the info into the "function ... finished" line

 lib/bb/build.py | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3d9cc10c..de51aebe 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -19,6 +19,7 @@ import shlex
 import glob
 import time
 import stat
+import resource
 import bb
 import bb.msg
 import bb.process
@@ -172,6 +173,23 @@ class StdoutNoopContextManager:
     def name(self):
         return sys.stdout.name
=20
+def _get_times():
+    try:
+        walltime =3D time.monotonic()
+        res_self =3D resource.getrusage(resource.RUSAGE_SELF)
+        res_children =3D resource.getrusage(resource.RUSAGE_CHILDREN)
+        usertime =3D res_self.ru_utime + res_children.ru_utime
+        systime =3D  res_self.ru_stime + res_children.ru_stime
+
+        return (walltime, usertime, systime)
+    except:
+        return None
+
+def _delta_times(start):
+    stop =3D _get_times()
+    if start is None or stop is None:
+        return (-1, -1, -1)
+    return (stop[0]-start[0], stop[1]-start[1], stop[2]-start[2])
=20
 def exec_func(func, d, dirs =3D None):
     """Execute a BB 'function'"""
@@ -281,6 +299,7 @@ def exec_func_python(func, d, runfile, cwd=3DNone):
             olddir =3D None
         os.chdir(cwd)
=20
+    start =3D _get_times()
     bb.debug(2, "Executing python function %s" % func)
=20
     try:
@@ -292,7 +311,9 @@ def exec_func_python(func, d, runfile, cwd=3DNone):
         comp =3D utils.better_compile(code, func, "exec_python_func() auto=
generated")
         utils.better_exec(comp, {"d": d}, code, "exec_python_func() autoge=
nerated")
     finally:
-        bb.debug(2, "Python function %s finished" % func)
+        delta =3D _delta_times(start)
+        bb.debug(2, "Python function %s finished (wall %.3f; user %.3f; sy=
s %.3f)" %
+                 ((func,) + delta))
=20
         if cwd and olddir:
             try:
@@ -444,6 +465,7 @@ exit $ret
     if os.path.exists(fifopath):
         os.unlink(fifopath)
     os.mkfifo(fifopath)
+    start =3D _get_times()
     with open(fifopath, 'r+b', buffering=3D0) as fifo:
         try:
             bb.debug(2, "Executing shell function %s" % func)
@@ -452,7 +474,9 @@ exit $ret
         finally:
             os.unlink(fifopath)
=20
-    bb.debug(2, "Shell function %s finished" % func)
+    delta =3D _delta_times(start)
+    bb.debug(2, "Shell function %s finished (wall %.3f; user %.3f; sys %.3=
f)" %
+             ((func,) + delta))
=20
 def _task_data(fn, task, d):
     localdata =3D bb.data.createCopy(d)
--=20
2.23.0


