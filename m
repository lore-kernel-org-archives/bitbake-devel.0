Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254CCC56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 11:24:55 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17550.1786015485828209025
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 04:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=yjJUg10D;
 spf=pass (domain: est.tech, ip: 40.107.130.68, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEF9EuRnkVf3lRiMTK54FODt+SH9rDC0xMh8drCpU8Q/enM6cmeAdwrxEDkJ307JcYPOj2WLMsxI6Q5fiQyiKxgC+gCPtR2aT/vmNEPk/uUsQHk2+j7sMQPqtlsr64i61WCryGVpDEIusrcd7SqCTMhJaRzSOo0H+cwlmzqtA+SiqI0ldfINOtBpKIc6ki3HdJkIgDgeesmNETrWMkFGoDPYCfGhAx3/K5PXAAlPI0BEdOWW04J5atkjIgHrjsD/+LGMfft8NmMU/5cqRmplABX14cFs/586FFK5KVJCgloIplXwJgxRM9hlgpqRtUQXeSkvO4WUgcjkyAShavH+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG8LqoLh1vUhElV5bC0MOYUVSuhczJ2+qZmjRbBHkf4=;
 b=NyhOlItrr5iEgaO1v6ZmdOPCe9UbSeKgbCMCA+d92ZttzOEY9gq8wiM85Z3OElRw7zmZf02gu6O10a5aN9Rqw0Qg1W6wDmfFzqkvOa2whCuckZCS5V2q9xA/GSzhUPq1ebwM64xiCgwRWpNroCD8jcaTll47lSbXLwq+pE2ToO1IckujbB68uA85/NzoUtX/xgIYFImTnrt23MMr1fiHITOAGekAdcQkfQQVVYuGHrVccBeRVeSvYebLXxo9BcKO/kcBzs2kYxIVs2eg0SBkBbXHoKkwJlckxJCnWaTyY1zAKeGNUkELffelAhTRAPU/e+cwVbH+CgEsBT2PomDupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG8LqoLh1vUhElV5bC0MOYUVSuhczJ2+qZmjRbBHkf4=;
 b=yjJUg10D76nVkMm33S5VSRDaaiQyNtFA3+odkEpZzlC/cqe1kX28qFuRBu4zH6PgRT4Rfjdd/B55pXDCdf1XKoq/xYBECqPKzM/1zOqfG/6Ujtzp76Ge8IfisMkCYbmgZkLFVftq5a+/7DMGdOOL4oMWJniOe+YBEGk2rGMWvuHDYVMhdRmEMrr+tWGFAd0lphW+EAG1rNBMI3i34cE8Xf0ujoLXvh4v17SHj4mOPj37WoC+U+Y4cQfsvLTwNBMannOrYbZGRR+8UbAilRitmbsZfDuzMxnHNVa/k9jE9ekcCXtuqj7pUStelQkWBFdHBG/V06I6c9H4lmXUYI9D9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by GV1P189MB2292.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.8; Thu, 6 Aug 2026
 11:24:37 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 11:24:37 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v2] parse: warn on trailing whitespace in parsed lines
Date: Thu,  6 Aug 2026 13:24:35 +0200
Message-ID: <20260806112435.25128-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|GV1P189MB2292:EE_
X-MS-Office365-Filtering-Correlation-Id: a88e1ddb-6768-4796-eb30-08def3ad4cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	3RKajM8X+DMa0yNWx1tAPMo6p60MycfIkXTDU5wI3/talcKmZLxOve+C+jpMzogaIn3G0wdpEcgr3uZF3zwz96esjsIlFHenX27J7MYJp8XRK4iD83Bzk9AI+F7z0Y8Z1CZpZy1ROhjq6nYtvjDnfo9Yfjx1rnCesPUpRe/rX1hHXnTrIqwGsrgi7/EyJiZ040KSAkEqswg8Xy7nSBsG17/7pZvTYrUGd6RZKVi62H/3RU+tIkW4N2Dn1uoGK1FzYbLcwv0ktf33w3yMGNwSVURiAPJp+vUEHz3gVCGN/VkvtUHB4D8NBKoTdLCgGv6g8jTQuM7TcGpeOPa7d3EFzUx4q3icGO6UEP+KCp+c4jnepvc5r12enzgj3hHt0g0EoP22uU6t1EjEqHxQQNKZiGIIygmeZgYOCTDQpjl+E16YmcXPvLLKUVlOqTIuvdSgXJaa0Ej0llK0h8PMoWXiJQ7KxK142qxw1ntuthn3E+WckaA2rg7l2gkvZ6ExBT5UJ2enxKSM9zH/hdnLtWlTafObWkLjX+k/msW+7gP4zOEECGAXe9krD/xk0hz6LgBFXXUoiEPaAKQdUziaMLL5blq4cVjtSaRul6NZgieVCQF0JupkJRlsJQZANegqOx93mZIc9W3ZsWg2KR7xsomNeUWR307++x6KdX3F50UXy5c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lM5qhJLW1knTvWrelxf6dZcVW/5msI+sBWWPBo+tJlU9OKWkqGFcc8jP7WhC?=
 =?us-ascii?Q?DUfsuKYCkBYkd/7lrWrAkI6O/p28Z5tekC0frlOkiz+MUZKTikGl3dshF7xx?=
 =?us-ascii?Q?7zoETvvwkcpJaASpRPQ8iAs4ao2OvFBb1wGpNGzdosawAh98neS6ah4ixwK+?=
 =?us-ascii?Q?1bO80Yyb8sCpMhBLgbG7UjhwrXKyshSO2JsCeIJQlN/jL/ThjdrK6ErDKdOZ?=
 =?us-ascii?Q?Rvm16ux0LVlfRiKivpKGqSJDQQsuJd2HtQAWrxVLSgvOfuoXaYt8wRNX1QeM?=
 =?us-ascii?Q?jMwspCmh/n05/FZY8ck3k3695D3jmPdDgOS0DeohQcmojL8U9V0jarMz1JGE?=
 =?us-ascii?Q?XWL5nP63bnM0N47+y6mDt9cAvh/Jphtl9E7cjDpSdlAT0QKxEOJTtYj+s+jm?=
 =?us-ascii?Q?icpewY9mcqT/5dAeocdI7JBP5bsWvtMWUFG3PeAqjKUu+kTEaT6xTIKLyf/6?=
 =?us-ascii?Q?uLiaDV54q4ETz3O7s+6KXTxcnx2wuVJAks4MNlneYNpZnlIeiMyaySXK7P5W?=
 =?us-ascii?Q?4YEI2dDLlZ8fRQLB2eKIiF30EyZX+3aPbU0m8q3K43AjKgg+r5MO6o6z+0Jt?=
 =?us-ascii?Q?KmcllvRajDaPyNn75rZ55sq/H+dRZ55sfd8yXXTDpzs907I5CdJFV5jgw22t?=
 =?us-ascii?Q?t48olv5sGXG/qNuObein48kzPeUXzW7pc5U1jQRdoCCOZyEgaUfuMbHj8UPW?=
 =?us-ascii?Q?dYHUo7pyg84BApI58LZgwxL3YDLcho4csFPGVaisEveW7c9tdfjEZm9nop4z?=
 =?us-ascii?Q?u3xxut23eZbAuSz3purZ0c86AenmJR72/ISRR/4QNC1WK2fX83LDUCYvJOb+?=
 =?us-ascii?Q?zcEtddMvqBatfmsrlUUb368Rdjqdmo6cNEC8Fw7icFtDfxWzjB6XAE5c+5DD?=
 =?us-ascii?Q?pg8TgT8BGrGPteSe34oGdhY5zzw/PTDi04uZE26lhH7W4UKTxhx8r+fIXp8H?=
 =?us-ascii?Q?0FVcTqf7NBan0eYiE41azIQzCDAm8fOZeWIi7DKyCH7sWUGp3jZQ7IKsrej9?=
 =?us-ascii?Q?kajx4X2Y872dy8KiOmY4+sego0jx0hY9vGPGftulnnz0E0fMvhSL7E5fbiEL?=
 =?us-ascii?Q?PwY2MHK49sZhA/aCQgoceWOzyeQ2apJqD5z+pjBdMK7Gt7Pqt2LdSvVwqtUG?=
 =?us-ascii?Q?e48gORWIkLHNSAIjds9QcKXb6WzIP34tsy0wdNJ38rSqAhL5Oc3jb/f3FgZC?=
 =?us-ascii?Q?dj7lzePAM+yyZ0M4O7WRBr0NshlOghU3+/wY64j1/I+1nH+3k/SY8iGY67IC?=
 =?us-ascii?Q?srO3iDMr+uG64w+d2dbazw/hacMPkfTUbCCwmPZ5rOBKHW+BGaj6Gufw/K8p?=
 =?us-ascii?Q?x7ngLYAnh/RO4pLgtB5N+GQdfBz6He5NvTKIWu0KxL0HS2HQs/jINTTTrmhe?=
 =?us-ascii?Q?SL7pgEjeQ/zDy3SKJ4RO3ouBs3edZPGvybJGRdV0vnaNu5wTl30egW1aRJuM?=
 =?us-ascii?Q?pGalzXGjSvIDVL6nLQ5bPsa+1TvwDBy+PbbM8RbC0IhOkdmTPUBBrGQMGxnK?=
 =?us-ascii?Q?0nxIq84XkWi9TW+/ORr8ZKzAq36qpEHSmE6qTW0bwvmOg7u2hEgvvAAZnfSv?=
 =?us-ascii?Q?RbzQdM/xwsQC012gVJCHvjKTxLXgv6osEeF8KmkXS738WFiDPlAbHaPLmIDT?=
 =?us-ascii?Q?Je/RGY9JyHArpMPaMPE6/qpIacVJPpFDmYinK+zLyiDyBq1QKRa8C+Vfy7Tl?=
 =?us-ascii?Q?r1EEZDIOu2XcT8XnxOxm7OqydJGDC5BFIXdKh5mNAYWTb0tQ3jWtix35JFVP?=
 =?us-ascii?Q?59VT/7IyqQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e1ddb-6768-4796-eb30-08def3ad4cb3
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:24:37.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z3aYBercaJN0Qk49QLb/OsfcnLKHBsXhsRk4bBYxJcAOCbmzY5d6g2oAdB7Xn0Ym8TGJNdMCSF29G5tlz8RTiiF7LcSSpn/YqMXFu7ij00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2292
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 11:24:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19903

rstrip() silently strips trailing whitespace before processing. This
hides invisible spaces or tabs that end up in patch context and cause
patches to fail to apply across branches.

Warn on any line with trailing whitespace so developers can fix it early.

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---
Changes since v1:
- Broadened from just backslash continuation to any trailing whitespace,
  as suggested by Richard.

Real example from oe-core master (libssh2_1.11.1.bb, line 18):
    file://CVE-2025-15661-3.patch \<TAB>  =20
This caused CVE patches to fail to apply on wrynose where the trailing
tab was absent =E2=80=94 invisible context mismatch.

Full parse (bitbake -p) across oe-core + meta-openembedded (2970 recipes):
- 228 unique trailing whitespace instances (verified, 0 false positives)
- 82 files affected (53 .bb, 19 .bbclass, 8 .inc, 2 .conf)
- 92 in oe-core, 136 in meta-openembedded

bbclass files like useradd.bbclass, sanity.bbclass, buildstats.bbclass
account for most of the warning noise since they are re-parsed for every
recipe that inherits them.

Tested with bitbake-selftest:
  $ PYTHONPATH=3Dlib python3 -m unittest lib.bb.tests.parse.ParseTest -v
  3 new tests pass, no regressions.

A separate cleanup series will follow to fix the affected files.

 lib/bb/parse/parse_py/BBHandler.py   |  5 ++++-
 lib/bb/parse/parse_py/ConfHandler.py | 10 ++++++++--
 lib/bb/tests/parse.py                | 28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBH=
andler.py
index 008fec230..3ac694e20 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -104,7 +104,10 @@ def get_statements(filename, absolute_filename, base_n=
ame):
                 lineno =3D lineno + 1
                 s =3D f.readline()
                 if not s: break
-                s =3D s.rstrip()
+                raw =3D s.rstrip('\n').rstrip('\r')
+                s =3D raw.rstrip()
+                if s and raw !=3D s:
+                    bb.warn("Trailing whitespace in %s, line %s" % (filena=
me, lineno))
                 feeder(lineno, s, filename, base_name, statements)
=20
         if __inpython__:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/C=
onfHandler.py
index 9ddbae123..e4306d035 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -134,12 +134,18 @@ def handle(fn, data, include, baseconfig=3DFalse):
             # skip empty lines
             if not w:
                 continue
-            s =3D s.rstrip()
+            raw =3D s.rstrip('\n').rstrip('\r')
+            s =3D raw.rstrip()
+            if s and raw !=3D s:
+                bb.warn("Trailing whitespace in %s, line %s" % (fn, lineno=
))
             while s[-1] =3D=3D '\\':
                 line =3D f.readline()
                 origline +=3D line
-                s2 =3D line.rstrip()
+                raw2 =3D line.rstrip('\n').rstrip('\r')
+                s2 =3D raw2.rstrip()
                 lineno =3D lineno + 1
+                if s2 and raw2 !=3D s2:
+                    bb.warn("Trailing whitespace in %s, line %s" % (fn, li=
neno))
                 if (not s2 or s2 and s2[0] !=3D "#") and s[0] =3D=3D "#" :
                     bb.fatal("There is a confusing multiline, partially co=
mmented expression starting on line %s of file %s:\n%s\nPlease clarify whet=
her this is all a comment or should be parsed." % (origlineno, fn, origline=
))
=20
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 6ac2137e0..5ccc6e93a 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -638,3 +638,31 @@ EXTRA_OECONF:append =3D " foobar"
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
+        self.assertTrue(any("Trailing whitespace" in msg for msg in cm.out=
put))
+        self.assertEqual(d.getVar("A"), "1 2")
+
+    trailing_whitespace_after_value =3D 'A =3D "1"  \n'
+
+    def test_parse_trailing_whitespace_after_value(self):
+        """Test that trailing whitespace after a normal value emits a warn=
ing"""
+        with self.parsehelper(self.trailing_whitespace_after_value) as f:
+            with self.assertLogs('BitBake', level=3D'WARNING') as cm:
+                d =3D bb.parse.handle(f.name, self.d)['']
+        self.assertTrue(any("Trailing whitespace" in msg for msg in cm.out=
put))
+        self.assertEqual(d.getVar("A"), "1")
+
+    clean_continuation =3D "A =3D \"1 \\\n2\"\n"
+
+    def test_parse_clean_continuation_no_warning(self):
+        """Test that clean backslash continuation does not warn"""
+        with self.parsehelper(self.clean_continuation) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), "1 2")

