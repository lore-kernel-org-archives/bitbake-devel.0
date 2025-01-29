Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C3C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:24:35 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.35])
 by mx.groups.io with SMTP id smtpd.web10.10469.1738149871051466691
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:24:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ksH/+KIh;
 spf=pass (domain: siemens.com, ip: 52.101.66.35, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL5AlX55eHDLr64VC4JmLfI3TB2AZkOWFtkCgxvX0kbGkKIGOuif2y7NKev9xCAUX+o1pp99A76QOkZe9sY+3tEo/GjUCoBcP+RLKLqizJsiSOThXO4h5w0+jBUz7DMxuQqHyIwlEDNdpOFIl0oC/SgzKrDCIddWT8GgGwGUsyxFL+kZhB8I2MUYxeaHXw33aBduZ27g3DnlQI9ULQ/FcpG3pzOVgZWD2aeowt4+kGZiX1k2LNQMW1wdEdgq/XuElP2lLr5ATYttRahIJyf96c6+KoVXp8ux66h+l7ZS1Zeo/8lHb0aHQlGnK31R/NEV7UdWrEj+yu/qzEaTI4zmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kGhT4BSXuTPcAZUwNVEXPa0SNfWiTmgihk9nD7aDuE=;
 b=joZFZ5RMTeBO+0ocKWoF4kKt1r/D+z2Ulk0F9V4AO73irO/MXOIl6NEupdP1SaAP4rXs9HfQhPoVJZ4Fpdm+54z2X3LEf33h5+5NZ2KQRb/k+1lV07t/unuCVXf73jaOKIZMW26UApMCyj6751lVr2Pqh6oqPWd/09szB9wBn1KFjzlYB1G9nOFBLiPwWLADk5EVL7kHizOWs7MQyU0qCYIHito747A1ASRyvlbCV8u9CMRVibOY9PgsvmlpHt8oZyrvggtny1stBEKrMOebWA/EDzGVj1W8dq0vgJkU9ZhuDwnqErqhXPT6CgjEctZPkDGiDzZM3uK188fPSBAyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kGhT4BSXuTPcAZUwNVEXPa0SNfWiTmgihk9nD7aDuE=;
 b=ksH/+KIh0kgawjo7Jc4rYnXIwuGi4cnt9Y+qETeGuDSZHMDPkP5l/zXBj6aDAgbOAL4gjqP3/zVUNSDe/WWb6e2s9WhoMhbe+NKiymYkcrJTbdiVNp0EitI/JZNGeceuggsfU13rm3ep69Bw0TVaJx6AK8/VkezeaZI9+Bd10jxNMY9Y4+pvM14Uk/qIXEw8OUOCfScE8WCsNGxXKhjKkaJeuv8Ob2CuxmY79/lifNZ+veiA2n4hGiRCvMCkXDV8lGXw+PFfu8b1NHgQCHMq0VePBCKlSKEXu+ZIF/JBPhaRc37x/RKGwcsWv52jZv59jmEPRzraJy2WEIMBDDhxbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB6421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Wed, 29 Jan
 2025 11:24:28 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:24:28 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 1/3] fetch2/git: Add support for fast initial shallow fetch
Date: Wed, 29 Jan 2025 12:24:04 +0100
Message-ID: <20250129112406.1660522-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129112406.1660522-1-stefan-koch@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f95fc0-83c1-4f87-e1a7-08dd40577e3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h5fj9KbyApz+ZG9SUuQz6BRQBip9YaWe7zAZNrs4IO/Rog8vhTmofdUhrHZ6?=
 =?us-ascii?Q?jBLMQxk0YDEQOQXlyzr1squwER2DR/WPa9QyEfY3R9pjKrofaXNYXYWm4W7T?=
 =?us-ascii?Q?nmBNaQ6HOOxDn2z8PbTi/W98e1+E/joyR0JTVihu1feMcSEazRPgn+wgMoBK?=
 =?us-ascii?Q?RRo7SSALZRtX3LwtARLhTu1gjvYQBk05PZ7/YFgaDyWRM9ihMa3cbAQw0znw?=
 =?us-ascii?Q?kSdo1GqaggzEozC8hgf1+DeH3ysg4INx66f3oCFJjqiDZ32NorFMHxFJ7UTs?=
 =?us-ascii?Q?Ic30xhHU3L3cOzUDZNW+nxIvW603NshiHD136bm3WyyglYk4yX1Hc/cTrS7u?=
 =?us-ascii?Q?qVHFesF2pshWPOjcAG/Sgtuu0Yd9b0FMoSgZ5ZQSjWfS6agetBGhWwJMMYx5?=
 =?us-ascii?Q?BHdFpuZXHg8pzEfohvlnUlhBV1OYJuxfxztjzGUveQ0t8H8sXuGBehk2s30i?=
 =?us-ascii?Q?gFih3HBoWdILLxeEwdfVwALuXN5bi89chikaY5plFHNAiLYMlfu5saWAF9ER?=
 =?us-ascii?Q?l1JWebOXNuTUBzylSPfhoO+dHGkyl9QD8VfYDDFtvz20Cv5uKhcakrGkBVPs?=
 =?us-ascii?Q?RE/ZgA+iLllaQmVPqSe1ah4g8BfSY4t+y+seZGgm9qr1W8HsblY6YOQ+b7qH?=
 =?us-ascii?Q?71oNJKPYy8W8sBhVJetw89vb/b0NCHXxTegrQvh12G/mOTEF1rmvDD+VFUZM?=
 =?us-ascii?Q?ctpKLnrgUVG4PEWtFGT4VgSzu9b6xGy70bia/2Bh4fL8NntyK/9nmQ12BwGA?=
 =?us-ascii?Q?7ID7wkH2qx59LwdgterLilsl+KbSv8+dEmX1AJhZiN20W393w1Du8pcAlQAk?=
 =?us-ascii?Q?9lwMvk3SRTrNTbwVDL68zRWjTC0Q0gVUi5W7S+hqRn1YL1pya+BlcXFNmyce?=
 =?us-ascii?Q?n45pdAsNTBuWSktzS01vQuCRAXwgpYxQwT6lGfUYf+48Ol/eFQeNdMx4PMIb?=
 =?us-ascii?Q?uK45d8JWdeKkrxhyFgGxsQOVbLnxFXH3sPXBVQZliNUfs3yfAVZL9PxwDKsb?=
 =?us-ascii?Q?yXjUqxjbCxPNZjlnY0VqwJjSdhenmk+KlfGyOlS9NjHg3J1xBK0IaggKQEJh?=
 =?us-ascii?Q?5OVCmHBZjp9P1cxw2xKqZw0neZcItB1AgDDEf3MDpblh60oDXX2XyaOQzGE7?=
 =?us-ascii?Q?iPCneHDK7x68GUfrZhTZZLFhri6XoH7xUooj+SZddvp8ZUrhAySX4UeaanQH?=
 =?us-ascii?Q?2z6lt6YaO4Ap8Y/r7Qn6EJgKo5n59DPBICMX+LtWNowNpK317K+YsYNREzo+?=
 =?us-ascii?Q?GFzWE+2Veqy/3MN3ZUI0EQXBGRmxrjD26Gbw1OdVNrq+WDtQujBQgJi4yx5U?=
 =?us-ascii?Q?99DRc/XACcPiIRk/5MYDAacJYs6UQwVn5h+jfKznMuAnwrjWWJt+aehx6B9U?=
 =?us-ascii?Q?0Xswjsz5BJJMowhH5SlY5KNmxGBK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ktqZZI3hdfv7KwEUThLQcl2r0whYVbIRscBb4/qxdSSXet+DhYqkeD8z30PM?=
 =?us-ascii?Q?PSqoP2Z4MlWI+d/2bZ1vXE9QvG4558fRqtF3t3eBLlfcEdf4+dTVBqcJaF01?=
 =?us-ascii?Q?SDG5kUiyIGlWm0j4vk6m/bkvHo+FtjD9CSvP0s56xnq7au2dVgPIbuJ2Sr5E?=
 =?us-ascii?Q?feCB2ecUX7FS8Z6mmKORRwCUHsmt68CTEEjAL1a3XEzFF1vPGWO9tXE8eMiN?=
 =?us-ascii?Q?h8b6Hf8j56JfGvps44dKMkmLLvAbCkCdk3+qvSCGXtM0wiMsgYLcrdsBSqh2?=
 =?us-ascii?Q?rGuqYpsgUpiOxP4NlvejgykdQCtNsNRIsjcjdJ5Ms77JrZ4FeBvoAZ8G3eKP?=
 =?us-ascii?Q?m/ixlakHseyRAiBfcAnaAbU+LPoAOLXlQYniOMl6qBsFSM1cUJUIFjpFNBXI?=
 =?us-ascii?Q?OQQv0+bu3jgrhWR4mtpoPst73dSMM+Q1VBacqwcd/dY5sce1bqiqXXyoC9nN?=
 =?us-ascii?Q?zIVbkJsJcy5Cn1G7GA+mqMFuwEQZfBb8SBKauQ4ISBLQ7hqUG+SouOh7M8ks?=
 =?us-ascii?Q?Pms1LXHGR3Ofc+xVqKZARvYv6PtLcC4nlY1DLM0LuUMPC2VPlFN4j4JkxctU?=
 =?us-ascii?Q?gdmyYLK6XqjoALQwgQI0aQFVv4woXbxGWBZu8sUCoWqPi/wQi7f5ZmhLBph4?=
 =?us-ascii?Q?5WoH8NmKSn+Q611DCFr9le2fL7rlfDLrkbe49LoQPXLUVveM3QbNsvbtDcub?=
 =?us-ascii?Q?qdBGmHQxOBvqLh7BM22diEs3z34cnrorqeHyEQquPcCwtbfjoK0WozoW55yo?=
 =?us-ascii?Q?BriMmmv3NjBWWaCDxSzHg+qKdd6wGB61wwUArakKT2to/n5WoPXpvDIauqJA?=
 =?us-ascii?Q?5bgEDl72pN54U5ThLO4Jf8au9F9A+yoxuodjCpB4JQ54x5IBFOeoFnkM8ZuC?=
 =?us-ascii?Q?CT5OR/gyPRADX2qUcNcMNw09Lue7Bodfy7lVvjmkkDucyFxEdKPoBdMPhj07?=
 =?us-ascii?Q?8omYp3+tNKO8v9AspSsJ4f5LD6n7oCX6IJmxo4ANvwB+r/Ix8+1rYnxdx0cD?=
 =?us-ascii?Q?WueYHorkn0jYlsTglbl1fcEJA1JwPFDm468hs00nN77dtLw9IkMK3csMbZZb?=
 =?us-ascii?Q?Ci3V1ujLKZrPZu5t+PPCQJeDZwhZPw0civp5gbG7mDfot7YLtRo+AB4CB76V?=
 =?us-ascii?Q?hhqDMilzTuv5YrhW02kFqbFRMO9XwmIWohRnP0/twFKK8gYD9QJDovjdrOGA?=
 =?us-ascii?Q?/H1IAIJHEpNDgwXt9V62ZhroOU9v7oATuxx/IXDIiSdYM40ErO6ncBV+2v6S?=
 =?us-ascii?Q?Eq8Cn8GBE4DA9R93+9LKEd2IMqkkdu6J7LCQrvj9yI90irZQKGzMjviHDZny?=
 =?us-ascii?Q?/O1P5BYhHpkCpk8ZfU56zEkHtKhpL8sgOM48dAEU+hKMsoCWOcliNBAf4dzK?=
 =?us-ascii?Q?pOO9MzwhneADC45QDF2z4HAi/yI5nfy1bbH7jXQ+3vJvXeTllqjm2248LNwA?=
 =?us-ascii?Q?F1a4Y2zo3VmpOEY1XbB2KQ3jf2nvZMsms2/fPKdL/KYSDwIuQH9Fi7436vRS?=
 =?us-ascii?Q?Di8CO6EmXXfl9Rh3NsYUuMOhOLTI5dru8B4SaYkbpPbLzfjwVXOySa0A9qKn?=
 =?us-ascii?Q?t1SK5WG4zj1hlorS6DRSW9yWtT0AcHsoIEVsjF9hlROgBbFzNPhKaU4f4rAm?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f95fc0-83c1-4f87-e1a7-08dd40577e3c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:24:28.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e9mwUqyXr9F/0QJ1sLR5bZbavl2pVlEP+iQ/rvgX410YrfF3NFsa9xkbWNTmpcxcHbIRWMr0yhyrEpVqYtIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6421
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:24:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17109

When `ud.shallow =3D=3D 1`:
- Prefer an initial shallow clone over an initial bare clone,
  while still utilizing any already existing bare clones.

This improves:
- Solves timeout issues during initial clones on slow internet connections
  by reducing the amount of data transferred.
- Eliminates the need to use a HTTPS tarball SRC_URI
  to reduce data transfer.
- Allows SSH-based authentication (e.g. cert and agent-based) when
  using non-public repos, so additional HTTPS tokens may not be required.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 92 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6badda597..6d87c2f18 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -366,6 +366,33 @@ class Git(FetchMethod):
     def tarball_need_update(self, ud):
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)
=20
+    # Helper method for fetching Git LFS data
+    def lfs_fetch(self, ud, d, clonedir, revision, progresshandler, fetcha=
ll=3DFalse):
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
+    # Create as a temp file and move atomically into position to avoid rac=
es
+    @contextmanager
+    def create_atomic(self, filename):
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
+            shallowstate =3D False
+            if ud.shallow:
+                tempdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
+                shallowclone =3D os.path.join(tempdir, 'git')
+                try:
+                    self.clone_shallow_local(ud, shallowclone, d)
+                    shallowstate =3D True
+                except:
+                    logger.warning("Creating initial shallow clone failed,=
 try regular clone now.")
+
+                # When the shallow clone has succeeded:
+                # Create shallow tarball
+                if shallowstate:
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
+                if shallowstate:
+                    ud.localpath =3D ud.fullshallow
+                    return
+
+            # When ud.shallow is disabled or the shallow clone failed:
+            # Create an initial regular clone
+            if not shallowstate:
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
@@ -557,12 +603,15 @@ class Git(FetchMethod):
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
+        # Use repourl when creating the initial shallow clone
+        runfetchcmd("%s remote add origin %s" % (ud.basecmd, shlex.quote(r=
epourl) if ud.shallow and not os.path.exists(ud.clonedir) else ud.clonedir)=
, d, workdir=3Ddest)
=20
         # Check the histories which should be excluded
         shallow_exclude =3D ''
@@ -600,10 +649,12 @@ class Git(FetchMethod):
             # The ud.clonedir is a local temporary dir, will be removed wh=
en
             # fetch is done, so we can do anything on it.
             adv_cmd =3D 'git branch -f advertise-%s %s' % (revision, revis=
ion)
-            runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
+            if not ud.shallow:
+                runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
=20
-            runfetchcmd(fetch_cmd, d, workdir=3Ddest)
+            runfetchcmd(fetch_cmd, d, log=3Dprogresshandler, workdir=3Ddes=
t)
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
+            self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]], progres=
shandler)
=20
         # Apply extra ref wildcards
         all_refs_remote =3D runfetchcmd("%s ls-remote origin 'refs/*'" % u=
d.basecmd, \
@@ -629,7 +680,6 @@ class Git(FetchMethod):
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


