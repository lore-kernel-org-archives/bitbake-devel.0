Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B0C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:27:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web11.2757.1740072443352419987
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 09:27:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Dn/Yyqe6;
 spf=pass (domain: siemens.com, ip: 40.107.104.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvhgGPWNaCsQ/Bp7JKcFe/rtNyK8xUoQ5UblUEffAMv+Gu+XHFgngXMW4+BRsqcknS9XmoJPQLHsUfHerDBk2PbT4YwKfN/LGideHWwmEclQ2UQR1/A4EilrBYJCy+g2V8tW702wRh8qw6XOJvBaAQqIWt7A56bl48GVKDFw+tyVUrnEhkYKof0MxvgABd6pvULIEwMH/oR+n7aRiutB4VBbu1JJh2OewKvCxnmiFZqE5QU9Zz1UgrTwkUU2Yv4meW6Dh/oHNt3HwoTETbO1I3WFgnKOWY8BA1/B7uc4OtQzCUIteB0M++dXyDkovl2jQGLeBSRatndndGsswDgY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm0ObBeGDZ85BodGI91rkrc31PpouF69sKNu8AHmCrw=;
 b=jlL/Mpv14ZB/dR9VO8g6XShiXNTdeC1WgkTxRvHfEuAvNmox0wJ8Pa2xfr0xMpAT2w0E6oujdZgJG6OKbOCGztSZeRsUtrWqtyASpNTpQn71xOoXm5v3KnuHYdCco9pfsSn5dRcgWc+ScIO9Z5FLZ8GCohV2aEMfsZTetmK0ahSoLhRSIIA16v+OCW8Q1lQVLes+oYs2XtlrUNIC1EJWpomimPmaIVERDF6jYPbT/P1T+4+6QQSCyC9gzEJKcPHtvicnVgoU7Fs3CYMNob7mC9x9BDwS/ZgdO/GLZMecYFKzOvyq0P7yR4lWou2OYZ9WniZhGuzU8WPWqYIWSS8Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm0ObBeGDZ85BodGI91rkrc31PpouF69sKNu8AHmCrw=;
 b=Dn/Yyqe6761uTu0noqMQw+UEb/x1YAtPclLOwM8osCcp58eFvrAdtEAkL8TxIjG8F+PncCmCYKsMmd5ygJQ3xJgiggVCH6Q7sf+ZRj4QriQ9rbuJtMCCx6yqWumy7p3KRfVBW+Gn8pHXjyOc464i5gMyD00ylaGbqfFCPUDV+M+r0qTc7J7VO0QuLHMZsElaSRkTmHbzFZCW665vNmpLuHZq7Cehp2M6Gzz+H0zrzi8mHkehl56OAE6dvwus4lVoFlEe8t+fA8f8+sRtEyNX1KFpA5u77J8eLo/aw7vUZAPG2IqgA8kYJOEySqQM5ZHHJg4GPZvRT8BNpUOf2Za+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB5551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:27:19 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:27:17 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org
Subject: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow fetch
Date: Thu, 20 Feb 2025 18:27:03 +0100
Message-ID: <20250220172706.3850722-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9f878d-f46a-4770-0872-08dd51d3d281
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R+R0OE1fUMtoulDJYqScvK+a4yp5KqU+nwDyvm3emGF651jvyh/fRoy+VYWr?=
 =?us-ascii?Q?kbsY5+qPq5uK9VqW7NdErzHaV00C4iqnbMlBrtPEztcYCDsHyOnO3vGiTZSE?=
 =?us-ascii?Q?yQkbnmkv0KlozmfiqYrKbjExduuD+x1hkPCBOdwqTiCvs92U6R6fxpYnwKwz?=
 =?us-ascii?Q?PrkY2XJxJ5sV6YAIY5/B7i8iN4vb6/Erfj8wxIkuN8JqzhV3elU1+P6XRd/4?=
 =?us-ascii?Q?RPFG4yaeFuibRyEUaHRgnjRafGw2dQwR6Q/CMt+cZ3WmoJqCL47t6xlqnV1J?=
 =?us-ascii?Q?8c6qhDZvwxPixY9tWjTg5NkycG3snTThJCAQbL5nebMQZL6NlELG1YSs1qPy?=
 =?us-ascii?Q?EUfC6glUvC8EnfJNAyD8nS/3pCm7+skl+W3BvcR89t9+GLRt/u/64jb3dAYD?=
 =?us-ascii?Q?p4xQx0wWveZVUg2PRuvQTGs6ThkBOiChOV/y/Oj24L2WFx+PQ8dU2IOW9qDx?=
 =?us-ascii?Q?zE5g5qIYYzCzSFZIhMnw/HTs4+XMY6SKMoZuZo1o78IcNAv6N88Ft9hfvMHC?=
 =?us-ascii?Q?ho/7FoxdWbAMqxD3pB82yzIuk0bV3xqE0jsqCj7bqmHMn+uaffmwHH/PN0BU?=
 =?us-ascii?Q?SK/SXfQfI20RWY5ByBSAdhQsK4+4tqTYQMYwCIxsEFWcO0asQGFDevz82pAc?=
 =?us-ascii?Q?3JNk8wH1vRV7av6JHNmPwXZvmN9iJY4faoNaceaRz3NxtxDb5IP31tcV3zOk?=
 =?us-ascii?Q?B/YvInwqHp5c473Wbg+qAQncoO56tVPh1nyKZ6VetPd3W6gcx4EEq014PKzu?=
 =?us-ascii?Q?hAJM6EVBYrhjiyP3Dpy3NdudJ43P73tT5Sg1wow0QLbRMrZxVj01LXHOAVIj?=
 =?us-ascii?Q?3rHULt6jWAvzaakQbkNoAtaMXUUCPDHCXBTGrXvhRLbZ0iibQMF0f9F5z1LY?=
 =?us-ascii?Q?kPLIj55A7P9e30ri5FvFO+GjzZpdnYfYcFe1HZBhJN/WiGg2cJR7qTE+Fp6t?=
 =?us-ascii?Q?ihAzQ/OSif66etF7zcPZT/cPHeZPsr0m2Yn+/QbrSAcup7jdGBxhjTQcsnKY?=
 =?us-ascii?Q?haJyxe2zlkmsUjz3XRMppKdXP7bJgjOks797Pn1Ca4YoWdWgeEE4eZPzTo9M?=
 =?us-ascii?Q?/BalqXGUc2JCIhBdYF4zwMbrNFXXLZRVY3zu12ARCvU10wR2FW8DxnxtTgwT?=
 =?us-ascii?Q?7/yGgrSDVHNbzJMswHoKWBtjOYLOWGHPcQb2RyIeDjxESUto2dxFKLQpWmGm?=
 =?us-ascii?Q?XbBx1Jn+ZBkRnF7FUUk7RJqX4cMYv813punHK+9xAdbKHik4wJKMCYMW93ZP?=
 =?us-ascii?Q?/T+cnYNIxBERhlPR+hxOQEOKhWuRs0xXnK/+mwq6rzTeDbSZxIBmnokGqMmn?=
 =?us-ascii?Q?9jhmF2BzfqlEoymrn1McIPzZ0u6ruY2m+nOSWHe9gU7V/WtQPQJTN3XozTLb?=
 =?us-ascii?Q?gjfqGV3I/rVMV4hLac7E4aMurUC/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qGazxaACjwww1KhJsid4LQyyB+L+/koKnvxj32H7QCZ4Cdk0c0DFQ3H6Sv4T?=
 =?us-ascii?Q?i6/Br7wvci+wSJxtTfCE9GfW6fTlOmDVf83P/KY0vuCpECrBSTNVc3pIROWi?=
 =?us-ascii?Q?Z0ZG+F/FsAvU5fkDRTkg0S68HxuxZOpXkFeQvBHRzZgKASM6AsZeSbNFcPFs?=
 =?us-ascii?Q?OhY3VKsc9Nuf8v1ouWYDJRrLfAWLGO3wofbvotUAj0VNUlckUxpKABfN/U+e?=
 =?us-ascii?Q?RgIsNNA4Xf8Ijs5IfTVJWzomU5NyrQuxn8u6ZB5aUXkFc/TV1RC3zvPp2sY6?=
 =?us-ascii?Q?5Ud9+WZUfxQNONGSGEpqUPhz02NV8q3EIyGbrYbHMviHXCgAIl0lC1catkpO?=
 =?us-ascii?Q?s4yT2X7QbSHZAR83vN5va41g1eLCcoJOqN5i+eGRVEo8GvPPjtwzjTeHzBS3?=
 =?us-ascii?Q?j/+3xEy0dEjQnjm6w3/UV7C6KUGeJJfBz2iu1pB9bXqb0wGAw9mV1gvissHo?=
 =?us-ascii?Q?ss/OvFIhvQS+EXlCn5B0+HmpuWx6TXgMWI1Zk4n93zEvGssZD5khKByH9GHW?=
 =?us-ascii?Q?jngLePNffyt9Z/rnJoXo3zl+XkwIlCgJnFG1FqTDskVP4Qfxg0NncQRgP/an?=
 =?us-ascii?Q?yMiYoeuuv+sOMPXyKznp6Bv13MXSq0K7pCVB7oCa00WvFm77PwFRnA0zPYtR?=
 =?us-ascii?Q?faa0SQ9AgVW7iN/WeE/wuuTBrv2bL9j2GK7cfA15RymmNDoTlSiS1wfriiPj?=
 =?us-ascii?Q?32CPC3J72u1xCQQAFxKxtlIecRbVqfqM4NBY5sdLmO6wEcJHrDpWaSlfb03p?=
 =?us-ascii?Q?WgedoFsgqlbmArzM0CsxcSLZH0Llu3KpGcPDfjt/GjhAMCeSBAI1ak1FAvxd?=
 =?us-ascii?Q?VoaJlLOM640DSQgce1XxSyfBoLXpKjPsUgiL1goMni+AANh4PykjNu/eLYDn?=
 =?us-ascii?Q?gbvivkCYdFDlpP8C2+V95ebILYSMWJ7SH2/KCPKsIm65dBIWfNohTEOI3TQM?=
 =?us-ascii?Q?7ioNCyi0H8SZbBsV2OBFKkhvmJDLMmfBKFLjku9s/Yx01nuUJjHMADBgLSku?=
 =?us-ascii?Q?YTM1KdtP2hnHF2uMh7a9zLiQZfISaiDr/ECMpEAM9E+wx44FruAONN16y84l?=
 =?us-ascii?Q?5fCKZXDubdzlrXNtmxYtm3eDXQodWZVjfMXuu6Bc2jWZXspijt8oCxcOEivz?=
 =?us-ascii?Q?5+3Rkddn1UHa851iZ+dO0ClEddFgVoO5NDlC+6H0s34Fth6m0Sfr1mxhTB3/?=
 =?us-ascii?Q?2EIdwJFdtJjsvUJMQiX/YI/LDmFxlruWJQrlqbeb2qA96B9332NTKPOFSMey?=
 =?us-ascii?Q?ZSXpcQbpWVeT/GCW2xZqG/ySMoTl1EaRGbtzfCWImPocQP8qL73CSEL2XY3+?=
 =?us-ascii?Q?SznLMAG6fylAHIP4HEvhi1+IfR737i0uNeT/RHtF6+wBF4214eVT7Ke86zTd?=
 =?us-ascii?Q?gLG7HVcQ9lavY/jSniWyiPtSDflvnDGbg6zPe7PjB9VW4ul1RqxBF3HflFXk?=
 =?us-ascii?Q?BFBbbyIt3hZWeiN6ZdxQV5tAFCCQN6m2Wm46vH0ZZFbFnWUe8RDGlOI8XZN+?=
 =?us-ascii?Q?aPbe9FJf835awEmfJg0XO4l3ePuGIFwsat13CXCJRAIGkTfrt25DzZ7fQaLG?=
 =?us-ascii?Q?+ABC9pmpEO5tJRo+6/H29q9r6bsEvyi/wjVJ5nOvhl5RR42Nx9To1zsapXD0?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f878d-f46a-4770-0872-08dd51d3d281
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:27:17.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59Ke4WBSiZVF6QPa79eW6xfYN7XM5H94WwIAemySMqSIYCkPFGZ+fZc2iUZ/YPDggfjASBsEWKhuZ/S6NvwtTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5551
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 17:27:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17262

When `ud.shallow =3D=3D 1`:
- Prefer an initial shallow clone over an initial full bare clone,
  while still utilizing any already existing full bare clones.

This improves:
- Resolve timeout issues during initial clones on slow internet connections
  by reducing the amount of data transferred.
- Eliminate the need to use an HTTPS tarball `SRC_URI`
  to reduce data transfer.
- Allow SSH-based authentication (e.g. cert and agent-based) when
  using non-public repos, so additional HTTPS tokens may not be required.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 100 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 26 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6badda597..d5c7f4332 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -366,6 +366,33 @@ class Git(FetchMethod):
     def tarball_need_update(self, ud):
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)
=20
+    def lfs_fetch(self, ud, d, clonedir, revision, fetchall=3DFalse, progr=
esshandler=3DNone):
+        """Helper method for fetching Git LFS data"""
+        try:
+            if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) =
and self._find_git_lfs(d) and len(revision):
+                # Using worktree with the revision because .lfsconfig may =
exists
+                worktree_add_cmd =3D "%s worktree add wt %s" % (ud.basecmd=
, revision)
+                runfetchcmd(worktree_add_cmd, d, log=3Dprogresshandler, wo=
rkdir=3Dclonedir)
+                lfs_fetch_cmd =3D "%s lfs fetch %s" % (ud.basecmd, "--all"=
 if fetchall else "")
+                runfetchcmd(lfs_fetch_cmd, d, log=3Dprogresshandler, workd=
ir=3D(clonedir + "/wt"))
+                worktree_rem_cmd =3D "%s worktree remove -f wt" % ud.basec=
md
+                runfetchcmd(worktree_rem_cmd, d, log=3Dprogresshandler, wo=
rkdir=3Dclonedir)
+        except:
+            logger.warning("Fetching LFS did not succeed.")
+
+    @contextmanager
+    def create_atomic(self, filename):
+        """Create as a temp file and move atomically into position to avoi=
d races"""
+        fd, tfile =3D tempfile.mkstemp(dir=3Dos.path.dirname(filename))
+        try:
+            yield tfile
+            umask =3D os.umask(0o666)
+            os.umask(umask)
+            os.chmod(tfile, (0o666 & ~umask))
+            os.rename(tfile, filename)
+        finally:
+            os.close(fd)
+
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only pre=
mirrors
         # is not possible
@@ -446,7 +473,40 @@ class Git(FetchMethod):
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
-            runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
+
+            # When ud.shallow is enabled:
+            # Try creating an initial shallow clone
+            shallow_fast_state =3D False
+            if ud.shallow:
+                tempdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
+                shallowclone =3D os.path.join(tempdir, 'git')
+                try:
+                    self.clone_shallow_local(ud, shallowclone, d)
+                    shallow_fast_state =3D True
+                except:
+                    logger.warning("Creating initial shallow clone failed,=
 try regular clone now.")
+
+                # When the shallow clone has succeeded:
+                # Create shallow tarball
+                if shallow_fast_state:
+                    logger.info("Creating tarball of git repository")
+                    with self.create_atomic(ud.fullshallow) as tfile:
+                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=3D=
shallowclone)
+                    runfetchcmd("touch %s.done" % ud.fullshallow, d)
+
+                # Always cleanup tempdir
+                bb.utils.remove(tempdir, recurse=3DTrue)
+
+                # When the shallow clone has succeeded:
+                # Use shallow tarball
+                if shallow_fast_state:
+                    ud.localpath =3D ud.fullshallow
+                    return
+
+            # When ud.shallow is disabled or the shallow clone failed:
+            # Create an initial regular clone
+            if not shallow_fast_state:
+                runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
@@ -509,20 +569,6 @@ class Git(FetchMethod):
                     runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clo=
nedir, d, workdir=3D"%s/.git" % ud.destdir)
=20
     def build_mirror_data(self, ud, d):
-
-        # Create as a temp file and move atomically into position to avoid=
 races
-        @contextmanager
-        def create_atomic(filename):
-            fd, tfile =3D tempfile.mkstemp(dir=3Dos.path.dirname(filename)=
)
-            try:
-                yield tfile
-                umask =3D os.umask(0o666)
-                os.umask(umask)
-                os.chmod(tfile, (0o666 & ~umask))
-                os.rename(tfile, filename)
-            finally:
-                os.close(fd)
-
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
                 if os.path.islink(ud.fullshallow):
@@ -533,7 +579,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
=20
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow) as tfile:
+                    with self.create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=3D=
shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -543,7 +589,7 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
=20
             logger.info("Creating tarball of git repository")
-            with create_atomic(ud.fullmirror) as tfile:
+            with self.create_atomic(ud.fullmirror) as tfile:
                 mtime =3D runfetchcmd("{} log --all -1 --format=3D%cD".for=
mat(ud.basecmd), d,
                         quiet=3DTrue, workdir=3Dud.clonedir)
                 runfetchcmd("tar -czf %s --owner oe:0 --group oe:0 --mtime=
 \"%s\" ."
@@ -557,12 +603,20 @@ class Git(FetchMethod):
         - For BB_GIT_SHALLOW_REVS: git fetch --shallow-exclude=3D<revs> re=
v
         """
=20
+        progresshandler =3D GitProgressHandler(d)
+        repourl =3D self._get_repo_url(ud)
         bb.utils.mkdirhier(dest)
         init_cmd =3D "%s init -q" % ud.basecmd
         if ud.bareclone:
             init_cmd +=3D " --bare"
         runfetchcmd(init_cmd, d, workdir=3Ddest)
-        runfetchcmd("%s remote add origin %s" % (ud.basecmd, ud.clonedir),=
 d, workdir=3Ddest)
+        # Use repourl when creating a fast initial shallow clone
+        # Prefer already existing full bare clones if available
+        if ud.shallow and not os.path.exists(ud.clonedir):
+            remote =3D shlex.quote(repourl)
+        else:
+            remote =3D ud.clonedir
+        runfetchcmd("%s remote add origin %s" % (ud.basecmd, remote), d, w=
orkdir=3Ddest)
=20
         # Check the histories which should be excluded
         shallow_exclude =3D ''
@@ -595,15 +649,10 @@ class Git(FetchMethod):
             if shallow_exclude:
                 fetch_cmd +=3D shallow_exclude
=20
-            # Advertise the revision for lower version git such as 2.25.1:
-            # error: Server does not allow request for unadvertised object=
.
-            # The ud.clonedir is a local temporary dir, will be removed wh=
en
-            # fetch is done, so we can do anything on it.
-            adv_cmd =3D 'git branch -f advertise-%s %s' % (revision, revis=
ion)
-            runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
-
             runfetchcmd(fetch_cmd, d, workdir=3Ddest)
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
+            # Fetch Git LFS data
+            self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]])
=20
         # Apply extra ref wildcards
         all_refs_remote =3D runfetchcmd("%s ls-remote origin 'refs/*'" % u=
d.basecmd, \
@@ -629,7 +678,6 @@ class Git(FetchMethod):
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
=20
         # The url is local ud.clonedir, set it to upstream one
-        repourl =3D self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quo=
te(repourl)), d, workdir=3Ddest)
=20
     def unpack(self, ud, destdir, d):
--=20
2.39.5


