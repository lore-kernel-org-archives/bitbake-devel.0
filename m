Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13531C55172
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 09:08:48 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12392.1785834523730864514
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 02:08:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=TxwLAPvy;
 spf=pass (domain: est.tech, ip: 52.101.83.22, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExjS3ygtOXsIQI4geLownXVXAFHuF1nwl5SaxfcXkb2HL2ajIAdU8BaG1RtNYCPtSrTIkW/HIvZ0/xbiu8e9d6xQU93nASgD7l4i8KRHScsJ90dtSPuMMFGGQbONNjOC2I6JTNSA32GK1Ig4eaKAUh/m5cojl9XWly0IJ3UXscuy3H8JymjYG7TN/Md/+6xVzvIkjDPhAPHTA/ckFcuoOWKPGqvSDokhArKb0cDkMVcUvkrCv12LgMcv+Ab3awLCk5x37OZHJo+eYcl0a5uGqCubWP2zb0mkhPrxP8kYJnXPGySijqvPjvUXYtNQkixUBZJYNTv8nCUfEJ3ZiYRo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cps+J2Mhsxo6c1JBHAxCyfHG+ahKbbDceUrM3iqyUYo=;
 b=vtpLIM0abO6hUXUJhSEF+HmMwaMJXEThQdmgnH3jtgaAuA61cgyil/KFRTQEqYMOC8oChRhwvJNiSdf1xWXkNyTrdvgoUd77xEU72B431yyaOuKC9rbhH+MzALqYZ4exSx2YHgPnrdWNPLjdZh+pDnJr9JqNuWmufDhFqSUmtFDKMX8Dc1kYIl+zXw+Kkh+0JBetAWagwvtIMw+OZrkyS1CBhyR2voRmWhJhFh6Z7/jmwmeCjE7WHpRry91yflqy1KVQimgbS5z1uPQKWUs04NdpNMy8FrlfTM9AI72AHJdOokGUuAij73kd/8XRQMDAL13y1I6MkTceTLZvoAW+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cps+J2Mhsxo6c1JBHAxCyfHG+ahKbbDceUrM3iqyUYo=;
 b=TxwLAPvyp3KOlLISIyYr/2QgsYrinqPdEyrCNQXtgROMKfmfo7pKBHFHWBn6mzrzKRC01DP7L/3v+StWjVcPuwEjWIM0zOhvaSA7C41cWaxnml7m2Vy78YI8yctDSfyd+N2aNmYPotKYvN4q7EQE5cLZtFj/8Vp6V34tCOfCOHWBO19jw2zPrqxE+z9w7QS+3vgKtust7q4dDQtaOmQ5UsTMRC9rGADtoaiOiNB6wfpaICiFQUz0M/fWKaMnk9cMBGCS0PIP+XnHOd6DgLu8lpnFh8S9CfTk0SSOjscOzKBTvQtYUw3qd0zZVf8vj0DZdGNLSMyHZGAgDQwEsvCT3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by AM7P189MB0598.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:08:37 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 09:08:37 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH] parse: warn on trailing whitespace after line continuation backslash
Date: Tue,  4 Aug 2026 11:08:34 +0200
Message-ID: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|AM7P189MB0598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f71e7cf-0906-454a-1cac-08def207f830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	AYuLevF/eY/3GsZExxzx+4b4FaLqag3D4xXEPj7gYUY5Kyomx4c2AptT5zstL/e1nBkoq2axRgoNfXuZME/+shNQvWDyzeR1j/2yrA3xT157qnQ4dY024cVAp5wzy/HXUVO/+6S5aRUxhls+0CO213qwXN8Bj9xfw5otdGCCOVMFYlVNOJu9MOHl/vfvgB6DpbTVOceO5GG6OeUMeRbPKs7R1nuxEe6N6/yGSf3pjJ8aHzThke1u/sctRLul9REnQfTiaV8GhEmX3hEsCKlLb2Yt15INi6x4obVK+B2W1uxLVc/WBj30R+4DQPJKfcTG5HcC5q/d6o9tKZKZNmJoVu51Bm/ReNi1xShI9dCnv3k0/J/ng5rJjmywkG2aBhzIOsVQjRG+DMPS2OISmF0c15JV1xGNGeEVcBYX+1ZLZKQOACyZV6ejdEEPdVYkEgIpCFYDovRsEZ/XtLq2/bA4DmCFvZEu/yaspzqvnKMiVoxmiA60ZbAFghRj84PoiV9FxSt0jCLVB2kOg4lWs0FDWmTBVqI5zfT987Q8LncckPze5c/lDALlv1Aza/QJh/FKXtpB2NMrmWFmhdoJuX5p9klKz6B7J4Mi4akeGZB4LESWR1Fq/Hfbef1fJVuKlIbDQ6ShRnsMlun+p0FpdUXPK/wXsfi9dusd3BF73Rvc0a4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i5qs1JczD0mXQf500vCwrgPjgwzSuFvY1C8nFOZjAJKjWSAdiX5alUrJHYzK?=
 =?us-ascii?Q?M9TYMufWI11mq2Ob++BNKbT3usGEdq4Ch2UX2nqcLghD2XDjREfIVjRdjIwk?=
 =?us-ascii?Q?RgZL+ttByr4WeedYQEmyLhN4pi7YpygB2KzRVL5Pt4piGIv13iVxJDaXy70r?=
 =?us-ascii?Q?lGbzJPm65bIl+BdwDJNzDfeHBQr6Gf8I4pDXEMwEw8l7uY3kIRj9vrgtxK4Q?=
 =?us-ascii?Q?Y19miQDj5ueOgCiwIRt3aVSOINsL0bbDs/eEeNnlGYsbaQAhJIfcu5RFw5MO?=
 =?us-ascii?Q?1MYTSFfYw9nYeFB+HhU8Iksr3zjNligz2zj5ZLAVuLFPEaYGhzz4VRINVzPI?=
 =?us-ascii?Q?Q/wP0WXncDFYy48NURbA84cSmhD1969nIccTTpfWlsZoWQJn6g0nuBvq5M6p?=
 =?us-ascii?Q?6ZDIkAAazE40DfBgTJ1zaGm1vuiTTbgu2ZEdQ1OWYapz8WMivsGyLyryP7I4?=
 =?us-ascii?Q?kooCuO7Zg5MTJnyRJOZX3hm4o6Ab3iTjGczuYczngCYfJ791i/1qw89SYfk+?=
 =?us-ascii?Q?2CYu9CLmqE+VyubksvDfWIOpoGVTiDfnXuQUYh8xEyaZleyMugFCsTTQ0iAG?=
 =?us-ascii?Q?snKv7BcSnYS7z1NlX7mjF0Dh/HPzHBVZw9qEYEYg4qOpJGOUpHLC90QvG7f8?=
 =?us-ascii?Q?qe2dvjGg+jp9+0QPVRIFkfdDcJAy2upxy0m4/CY+Oz+8gjRkf1WSOo+y2gTz?=
 =?us-ascii?Q?m6dOr8Gn42blhftdfxEQjgqe4eCG1HQUpXWhzhWUKG7JxMJDFHO5xcWyGPIR?=
 =?us-ascii?Q?bM50PZsmWhM9P1O0QFnr+tD+ybtQAMnLoU4A9If1ZZG1tERYizgFrv3eXl43?=
 =?us-ascii?Q?jB1frSuf0CjBc8cuJ5nb8bjSoLp2I0e5bKH7m2q4KCo1smkqlpl3l8h1WikL?=
 =?us-ascii?Q?e6LG0oTEP8HaVV4F34yg+OvPcvcCbcVQ6dP/CzBdW4tKHT7IurhiK+i5Jb0w?=
 =?us-ascii?Q?GdiXJpf+n1CApNbkT8YFFQC+lURx+4Hx/FACLanOYVkI0PWBbaoZ/AJl4pul?=
 =?us-ascii?Q?qHvIvzZy6lTqNBBuGwHhA6q715iy3a8OTCEk0X1EeINhnFq9wx1eDDZIcNgT?=
 =?us-ascii?Q?rZUtcNEzPidGeasa2Ke04dyKWI3bItVvBC9Sqz2OPv5SMjb3lLBxEDEaF+iR?=
 =?us-ascii?Q?uGNMX0+PJy4kIY456gjyrpGqy0J8ClcPg1+s8bqq6B36SnbaP6xYD3NXA9LJ?=
 =?us-ascii?Q?wCOW9oF3MHljB3K0wcPMQ3QZVFSF8w7asApWiBo1AkYKK4G+gyEzrpyPscGC?=
 =?us-ascii?Q?3GkqDt21AaWmWcUuIBLaGsq9KRwm0ae5A2KsR5tr8dBfoxFeFSmcqPIK5+E8?=
 =?us-ascii?Q?QvZvygyhsvNjQNejl5npWxQCvSMGAIdVL6Gpwy845D2MgC4ydWKGgwY6DxRa?=
 =?us-ascii?Q?8IlvsVdgwgBZBTeEBH0fpBrZDaSd5+pKOpwTdEQ1zY3TlVkjQjjH+aV48HWf?=
 =?us-ascii?Q?8Pe/kz2dafMNEdq6d/POa0KMVa74K3DKSOllTCsl4IZtgvHAX/M7bPjDhz/l?=
 =?us-ascii?Q?8O8A8PHKlULsE3VZ04zc7BYDbCdF5LPq+w292FVBtxTcTm2sZW7+8L/uzh8Z?=
 =?us-ascii?Q?su7F99H+YvpXFU3iizRDxqO4+84jOjFzsERoF/nXfXRohDmsbo6IILKMm87y?=
 =?us-ascii?Q?ZzVQKDywQkjAqFnBidXWfu7l9tRtIL5R01z3zt7SKAIUVWug3b0K0v4vWqrO?=
 =?us-ascii?Q?674f4z0piefA9nN9qzTZaB9szSc1LeQKQTqwKGXglkrFOGD6e3NiUtTMz8Cg?=
 =?us-ascii?Q?P/xotvYzhhTSkM95MiMARQHdZsM3b5w=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f71e7cf-0906-454a-1cac-08def207f830
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:08:37.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVeHBRaTjknHejtt4KVk8ucNeqo/NLIKpDS+sLYD3WCYiq2UfXnpG5MtuTNEh2CL9sjyEmWAmVR2HxuKWy/c4eVf6F0g4S+mfLtcfsNpSlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0598
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 09:08:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19897

rstrip() is called before checking for backslash, so trailing spaces or
tabs after "\" go unnoticed. For example:

    file://foo.patch \<TAB>
    file://bar.patch \

The first line has a trailing tab after the backslash that is invisible
but ends up in patch context, causing patches to fail to apply on trees
where it was cleaned up.

Emit a warning when this is detected so developers can fix it early.

Tested with bitbake-selftest:
  $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_trailing_wh=
itespace_continuation -v
  $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_clean_conti=
nuation_no_warning -v

  2 tests OK

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---
Problem:
Ran into this while submitting libssh2 CVE patches to both master and
wrynose. The libssh2_1.11.1.bb on master has a stray tab after the
backslash on the CVE-2025-15661-3.patch line. Patches adding new file://
lines below it applied fine on master but git-am refused them on wrynose
because that branch doesn't have the trailing tab =E2=80=94 context mismatc=
h.

Other recipes in oe-core with the same issue:
  autoconf_2.73.bb:2
  perl_5.44.0.bb:313,314
  mc_4.8.33.bb:50,51
  libxml-sax-perl_1.02.bb:4

A separate series will follow to fix the trailing whitespace in the
affected recipes.

 lib/bb/parse/parse_py/BBHandler.py   |  6 +++++-
 lib/bb/parse/parse_py/ConfHandler.py | 10 ++++++++--
 lib/bb/tests/parse.py                | 19 +++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBH=
andler.py
index 008fec230..710ea04d4 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -104,7 +104,11 @@ def get_statements(filename, absolute_filename, base_n=
ame):
                 lineno =3D lineno + 1
                 s =3D f.readline()
                 if not s: break
-                s =3D s.rstrip()
+                # Warn if trailing whitespace exists after a continuation =
backslash
+                raw =3D s.rstrip('\n').rstrip('\r')
+                s =3D raw.rstrip()
+                if s and s[-1] =3D=3D '\\' and raw !=3D s:
+                    bb.warn("Trailing whitespace after line continuation b=
ackslash in %s, line %s" % (filename, lineno))
                 feeder(lineno, s, filename, base_name, statements)
=20
         if __inpython__:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/C=
onfHandler.py
index 9ddbae123..07b0c371f 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -134,12 +134,18 @@ def handle(fn, data, include, baseconfig=3DFalse):
             # skip empty lines
             if not w:
                 continue
-            s =3D s.rstrip()
+            raw =3D s.rstrip('\n').rstrip('\r')
+            s =3D raw.rstrip()
+            if s and s[-1] =3D=3D '\\' and raw !=3D s:
+                bb.warn("Trailing whitespace after line continuation backs=
lash in %s, line %s" % (fn, lineno))
             while s[-1] =3D=3D '\\':
                 line =3D f.readline()
                 origline +=3D line
-                s2 =3D line.rstrip()
+                raw2 =3D line.rstrip('\n').rstrip('\r')
+                s2 =3D raw2.rstrip()
                 lineno =3D lineno + 1
+                if s2 and s2[-1] =3D=3D '\\' and raw2 !=3D s2:
+                    bb.warn("Trailing whitespace after line continuation b=
ackslash in %s, line %s" % (fn, lineno))
                 if (not s2 or s2 and s2[0] !=3D "#") and s[0] =3D=3D "#" :
                     bb.fatal("There is a confusing multiline, partially co=
mmented expression starting on line %s of file %s:\n%s\nPlease clarify whet=
her this is all a comment or should be parsed." % (origlineno, fn, origline=
))
=20
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 6ac2137e0..b01932350 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -638,3 +638,22 @@ EXTRA_OECONF:append =3D " foobar"
             output =3D run_bitbake(["bitbake", "-e", "recipe-file1"], buil=
ddir, extraenv).splitlines()
             self.assertIn('BBCLASS_FILE=3D"recipe-file.inc"', output)
             self.assertIn(f'BBCLASS_RECIPE_FILE=3D"recipe-file1.bb"', outp=
ut)
+
+    trailing_whitespace_continuation =3D "A =3D \"1 \\\t  \n2\"\n"
+
+    def test_parse_trailing_whitespace_continuation(self):
+        """Test that trailing whitespace after backslash continuation emit=
s a warning"""
+        with self.parsehelper(self.trailing_whitespace_continuation) as f:
+            with self.assertLogs('BitBake', level=3D'WARNING') as cm:
+                d =3D bb.parse.handle(f.name, self.d)['']
+        self.assertTrue(any("Trailing whitespace after line continuation b=
ackslash" in msg for msg in cm.output))
+        # Verify it still parses correctly despite the warning
+        self.assertEqual(d.getVar("A"), "1 2")
+
+    clean_continuation =3D "A =3D \"1 \\\n2\"\n"
+
+    def test_parse_clean_continuation_no_warning(self):
+        """Test that clean backslash continuation does not warn"""
+        with self.parsehelper(self.clean_continuation) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), "1 2")

