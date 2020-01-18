Return-Path: <rasmus.villemoes@prevas.dk>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60133.outbound.protection.outlook.com [40.107.6.133])
	by mail.openembedded.org (Postfix) with ESMTP id E00397FA42
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Jan 2020 22:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=hfDE9jifs8Gyae/yJKa0/lHyRtlOsQ+PJsQScPGCw3HSULgFSoa5Dszq7XnmudQ/s7vmjJcPuTbxxONCosToR5FApR7/x96FBSELBWfx9aESxv4Y6vKL//egBErv8ywEbzELTjCgMgEG3yy3xM+gwKcc5tEbYAMBLUnvrGLv3BBIKK3G4g9msH/EK+qkKVsb7Kyj9ftie+qHr0RAwIsR9GK4d/MsRkFZopRvPxccjK/0dO6kZD7CPG7LtZ0yePqJfMarSMDHCXKDf4WD+Z6hyzZW5APNb06kkM3s/8QTkuB4D6PHP/5oAugdQdapdHtNUDue6LX7PjNI6FWRjbl4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Dilb3fett9SHQEMPDYm5Kx7WRJA431E6LVkZl1sBJFg=;
	b=JdRKuPaxx64HyM8cpLyiu5qn0B/tluLDPsUlEavwePzeBrlYr4soZ7QIKhPXKudniH3JewTsscPSCsBmJgHpsddcDKLfqR6ArQCd+3L55uiyPVpoqaB3n16j3VnNAdFURA6wICXbsvZZw4Xx/Xl3LZjyP1EM2E0QWq2EVLhBxBQ9ZsJKWtVwVn0A2AWK5OcYBnvg94xB/iwAY1zL7wYRPGB7kdZP3MNNozewjjRO5FDOkWvt85cAqkGrC8FxvqIWl1Zak20UztnEC8qZdsOYH8vMNNp/mEr5TVnvv81M0z8hb372o4cxmRzlnH7uxk9CjY62AgSjQJmfkj1NwU9QOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk; 
	dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Dilb3fett9SHQEMPDYm5Kx7WRJA431E6LVkZl1sBJFg=;
	b=ikuyA5irTF12MqAiW+gE9u+1Wc9sUYamsr3ri8hbUL7y10x6DDBRzXTnoAYkYd3ISAfpV2inTviLUWBchVAyaHeS0w/Ef11GSA2ggfhCvLbUzxtBZQP6r32FW8cbRC6jbyM9jI8Be8zm962JlZdKaZDJdvglrsqhA1oubk/vfJA=
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
	VI1PR10MB3646.EURPRD10.PROD.OUTLOOK.COM (10.186.161.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.19; Sat, 18 Jan 2020 22:37:13 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d]) by
	VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d%6]) with mapi id 15.20.2644.024;
	Sat, 18 Jan 2020 22:37:13 +0000
Received: from prevas-ravi.prevas.se (5.186.115.54) by
	AM6P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::44)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19
	via Frontend Transport; Sat, 18 Jan 2020 22:37:13 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] build.py: record time spent executing each function
Thread-Index: AQHVzk/UviyzOepWnki5zcAR3u5NfA==
Date: Sat, 18 Jan 2020 22:37:13 +0000
Message-ID: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0031.EURP191.PROD.OUTLOOK.COM
	(2603:10a6:209:8b::44) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:803:e1::21)
x-mailer: git-send-email 2.23.0
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.115.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45aa62fc-ef13-4f20-3d18-08d79c66f690
x-ms-traffictypediagnostic: VI1PR10MB3646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB3646FF634F11108D56B9310093300@VI1PR10MB3646.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0286D7B531
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39840400004)(189003)(199004)(107886003)(6916009)(2616005)(956004)(8676002)(86362001)(16526019)(6486002)(1076003)(6512007)(186003)(26005)(478600001)(71200400001)(66446008)(81166006)(81156014)(4326008)(5660300002)(52116002)(44832011)(2906002)(66556008)(66476007)(54906003)(36756003)(6506007)(8936002)(316002)(64756008)(8976002)(66946007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR10MB3646;
	H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: prevas.dk does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeeKAQF7Ejl2SWJLdpYYUNO5kZZB0lvm3Hy8mNa6uMb69Upy1NBbiQk3uiExmEriYG2eU1Jg2c+ld3O14OllCXS6QRwqOHTj4g/n2aXZYc+npWFaUiGRrDY6iR005gLXtWuyrWmSyQfj4kxZbRZXzMKoeqvFSk+g8vOo75Y7u0H2c4WMVBLijzhfIN1Jbfl+XyBPUCPyz+GVFWWbwonUVXKPEKEDAu/4FW7kfvvhLbW95q4G3xPbyJN1wa2jIULjqtP3TuIWNvoQHAJYtxfvG3TYdbeGMYrvjSEdRT391cDQ/MRrj3Y4F5E3IrZovsN9QVCBqFL4MsQvxwBN/83mDGCgXzVl6FLobfx57e0hbb2Zd5M2hTh4JBJUUKYDtokFFEWlMMk8s3gm0u7yG2hMH2STz0pn/+6G8/9d6BO5g4E8+LP9uUch3PZ8Sm9vWzaw
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aa62fc-ef13-4f20-3d18-08d79c66f690
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 22:37:13.5378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxahtl1DI0g7RcPbW1vXPsdK+t5iNSMGLCSuOZRQpWFtZ6WoStPwwIddFsxjH3a7OgTsD0LKWIF/R++8GeIqqXJx+bcTiMMFJA+V5dgZ52g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3646
Subject: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Sat, 18 Jan 2020 22:37:17 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In order to have a quick way to see if optimizing some task function
actually has an effect, add a single line to the log file for each
function executed listing the wallclock, system and user time
spent. That can also help figure out which parts of a recipe is taking
the longest and hence find places that might be worth looking at.

bitbake already has the --profile/-P option, but that produces an
enourmous amount of output, and AFAICT only concerns python code, so
won't help finding suboptimal shell functions.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 lib/bb/build.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3d9cc10c..945efeae 100644
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
@@ -172,6 +173,14 @@ class StdoutNoopContextManager:
     def name(self):
         return sys.stdout.name
=20
+def _get_times():
+    wall =3D time.monotonic()
+    self =3D resource.getrusage(resource.RUSAGE_SELF)
+    children =3D resource.getrusage(resource.RUSAGE_CHILDREN)
+    user =3D self.ru_utime + children.ru_utime
+    sys =3D  self.ru_stime + children.ru_stime
+
+    return (wall, user, sys)
=20
 def exec_func(func, d, dirs =3D None):
     """Execute a BB 'function'"""
@@ -244,10 +253,21 @@ def exec_func(func, d, dirs =3D None):
                 pass
=20
     with bb.utils.fileslocked(lockfiles):
+        try:
+            t0 =3D _get_times()
+        except:
+            t0 =3D None
         if ispython:
             exec_func_python(func, d, runfile, cwd=3Dadir)
         else:
             exec_func_shell(func, d, runfile, cwd=3Dadir)
+        if t0:
+            t1 =3D _get_times()
+            wtime =3D t1[0] - t0[0]
+            utime =3D t1[1] - t0[1]
+            stime =3D t1[2] - t0[2]
+            bb.debug(2, "Time spent executing %s: wall %.3f; user %.3f; sy=
stem %.3f" %
+                     (func, wtime, utime, stime))
=20
     try:
         curcwd =3D os.getcwd()
--=20
2.23.0


