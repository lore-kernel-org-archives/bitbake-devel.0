Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D7C021A6
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 15:51:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.50])
 by mx.groups.io with SMTP id smtpd.web10.24130.1739548265353865883
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 07:51:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VwcECcvV;
 spf=pass (domain: siemens.com, ip: 52.101.70.50, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZDcJu4XrkZJkuFiJzv7o2hvnfY6Amqm7l2DrO4UjWp1s1maoP+V1hgSbAr17CjKnIPwyO66VNJpPJJ4rerM5qvkB2YXFdlzojvFze3VsYij1E3RG5QX9S/ycc0X0+ySZQvZHdaVvgrkDdDmRWxw/moEBseNBmqgXfRB0IbvUUllfW2Aapn17S4Mitu26maxcTaXX38/i74l4sNz72ky5m8YljdoWLnEBlmWf3zikmnebwipREx8dZsiww1HSHB+RM76WdPM2Pz/lgDjOTaJADZTZ6Si0pU2thbmoBha1uULJbFs+H8+g/q2p64MHmWtGCJAJGD2NGiwaAv7KSdHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPPuFC3C4li9vlkLtECDcFuz5JBQzy/XjbHqPv+rJOc=;
 b=NhEY0pUePWhimdulnnMLLABcSqyrsImpP8a/V1kTiDpvHylw2DvENfwkTEfzPdy5EPL1rCCCDupxPc/UFPSfUuLMmOdMab4e4FdscvTsp1++J75KrXCj2SC+DhJTIloYrsoJ/hyZFNNwiuSNOgi0WwPvS8I3HVsmTgGufrkAAELtyHZBqp714SMEEQFWz+g7bXnPzZFqmVboah6Le9j7gbkIFeyGA3tlmNC80dnZcknnKhdddZiKP7hMx4icIPq1FIzslQKn6DC6gskbQApNTPAcyv/TXBMTE2/0kaRYP0rumi65Ntw8xZkCXvhvSg6D4Izab06VElI2WOEW4NRGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPPuFC3C4li9vlkLtECDcFuz5JBQzy/XjbHqPv+rJOc=;
 b=VwcECcvVN+SMX3YBOrKX9D8KixTixWI9VF9s/1iqgr4LzRXwKaFApOLuqpGxpDelaSa3N1E1e0PjtB/4fvD7i/UvQatwFeW8Bd1vtw/NFdtYqu59vobklDMLYz36hCrzAFaLtjj71K+1QixX16JpMGsAXOg9+bjLBkTZxuxOlL2+cf3qauJdrDI4mdMHVDtgNQQ1OuUvid2LnIEFi3/K4EfzLGCVm5LOSIr/L3kAEQuf0dFs6NbdDPKiRMadlVZHwouKxDxtbXCIOymwVWkQOy0DWoUlYIivLgmeah/hYZZbVo5XsghAR3SBSY2dTE2aPwizysGjzl7r70q8g9KBfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM8PR10MB4081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 15:51:01 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.009; Fri, 14 Feb 2025
 15:51:01 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com
Subject: [PATCH v2 1/4] fetch2/git: Add support for fast initial shallow fetch
Date: Fri, 14 Feb 2025 16:50:54 +0100
Message-ID: <20250214155057.1748020-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AM8PR10MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 845f7e4b-86a3-456a-8bbd-08dd4d0f6160
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?06eiNIFeYmgoXN/eh/FezMoW0wFjUTOMgAkBwC4cmtA46MqZqJFnYokPFpzm?=
 =?us-ascii?Q?OaboM2PrCvZu8HlWdyMrMXfh6YlFX38BLMHFnFYs4gc+VRJOSHJX//AEJEsM?=
 =?us-ascii?Q?PWklTSRfwbwegohKVX5OvoeXKiwWYJOoWidxT+6AXs7rfdBkNSRaEp3o1jVd?=
 =?us-ascii?Q?D7B1lkQyVYQstRU3L58FTUCOtqzYi5iFviVCX4Q76nf7CRwW8pbXsm5oaUyF?=
 =?us-ascii?Q?0kzdKjuJ2+yxI09/e0Pf/qVFXkq3SjtgwxQFfgP6zeRGWJg12ZGCuvSQJSnP?=
 =?us-ascii?Q?DEnVfEm+QbD3KXW4C5zVc63LVc8H9NYQ4YcPFhKTuMb/WgwNz3fMPBLHG9l2?=
 =?us-ascii?Q?eR4Z9+lA4dGUdzBmxnmsL6YCIFm5sE4WIP/D+Z09Qbn7/YXjKqhFxXF8T6Nf?=
 =?us-ascii?Q?vjCQtgEsyTqysw/w96eXXMWOB9Vlhj2ZUJL2SGqTTdpSlXeVu1yzOcmW2ZH7?=
 =?us-ascii?Q?Lb60ipvlvska8QyoPCEXQHQn2pPcvqM/hWF28rBwKvLtXHWxpeIKWJwAcgEm?=
 =?us-ascii?Q?Mvel/o3JPCqiWIgkyCVeFCdgewRc8/l1aDPW6q6iS2EyaoIAXyY7TmdVX48r?=
 =?us-ascii?Q?hLLuzfiKI4QB0zmc+Ot2gEYM5gvIm1nYqjO5XpvGENjobW7LLGUsVInSVIzh?=
 =?us-ascii?Q?KZeZ7o99mGwsyZIQAGgibdI8uH1KlxMQ9aUrMR9HSGS+LSmWP7LchLIvpd3f?=
 =?us-ascii?Q?nHZjN5m/2jLh3bbAqOuxoZd/cA3EX+oolz9jvLqzFem79QL7sTk9oRS0fXGU?=
 =?us-ascii?Q?6lhOVkoSxh/XF+6wO1+oyld+TfEQje1DhFyH96LIthQCX1AK/qskbgJ0eW56?=
 =?us-ascii?Q?5eMDQD2s23wO6RmYn0D0EQRh+f9Zf6Ob9IxZHzD0MbAsAbkhMMJO/YjiJxgb?=
 =?us-ascii?Q?Fubegyedn46Rplysi3R3ojEoALd+yRs9pNzTYBY0GhDR0/hwEeYL/04RkFAv?=
 =?us-ascii?Q?EPXvv5IFkpcv9eLfnaePbg2KgeZRDrTwcBbi+/EaJNDWzcJw1c0DjT0SPues?=
 =?us-ascii?Q?/PwEJmC5tYUXeIw3hM4x3On48y0fZF705Jc8xFSNteuoh0oaDpszbYYHl/Wo?=
 =?us-ascii?Q?A8WS7HSg1hCqcLsjVXWAqonEDW/cDhs+YibYOpJuMQSr1RTIeC8o+0jrPRfZ?=
 =?us-ascii?Q?/bpX6GBT2QUEzJEaXjAa9AG4Iv98INF0X1VP0oyUuOb1mbjMYXB5qwnwDhki?=
 =?us-ascii?Q?CWLnlEW7E6KIg6safhoyARVQRpMRWAgV0lCHTFUyF69Eb6PvQ/F5wLXZnsi+?=
 =?us-ascii?Q?RioOuzCmjmBBE0saLJWV7NOQMHviia8iSmNIiL4TE1AFbDa+xlfHQWcNaLZc?=
 =?us-ascii?Q?X6H4dMcfYzaKh93/7QBDS3r4G6YdFblrIjlMhi5kkmoLZxSj+uFsAJ5NsGG8?=
 =?us-ascii?Q?QeFLO7D4vrAqHp7UNISMCH7TCwB7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w0Qi/K7NRnmMxnZKhKIeCltXHkxvknhjHHR608UCxDl+cBpKlNodNlBIXHQy?=
 =?us-ascii?Q?piMu4708t0hRJ4qscDmQJSexc+ish8TT+dlm+MShi1wxKSsh0xIxjbOhYmkI?=
 =?us-ascii?Q?7tOOuc/soRd0UFCm5xaw29OV0MQCbG356U7LV3YwlhPujhPrj9YEjplbFBxP?=
 =?us-ascii?Q?OT9wxFD/5YJb5icV+aY1kc4gyV6Q8e866BNI3+8Dj3gdh33n16HdhgEvJUxN?=
 =?us-ascii?Q?SUbL+iw/mXWsbtISu85msXbq8xivTeDEWn02z5kx05H7bcUrZdyHzq4AtiWF?=
 =?us-ascii?Q?2rmoMmztrvWq8J0yt5EyF09P44nJNCrm2YwAAwlqlBMSWs7lMJVtO2zgppsT?=
 =?us-ascii?Q?ffS6/F7SmOPj2qP3yudQS+SBvoHvnd5xROdYgyQtSJz86gwWVuWJfJOUvC3D?=
 =?us-ascii?Q?LvejTwvrZ8NwEdvp3LEIPBd7J3s7hu9hZ8BhvaIZzL8wKqSPmxc5v0uMtJoz?=
 =?us-ascii?Q?yJdwurzPtKXUQMUy0UV7KMuU3G9n0FQ09TdUbedkykvNC6weKYLBXdzPCJyV?=
 =?us-ascii?Q?kUTVIQ6xK6DIU0Mzwc5f3d0lD3HQyYDVTuY7eyjqofiV9Wv9zR0jrl/e1mV4?=
 =?us-ascii?Q?poaJQpU422dHQT5Ki4R822+WIeYrcBpExLOyMxx/bL2LBBmZadSUDmc9uQo1?=
 =?us-ascii?Q?9ZhPQ5OWKlB3owSXIe0yju8e1VqokXs88O8QE5HhR+98MlEAs5UKkxoHcZS4?=
 =?us-ascii?Q?fiF5CcT1Jb7KxbAiojMCg3V8TmcCHS562zQG04rc5sNPJcVWQH+SBgOn4Jde?=
 =?us-ascii?Q?v10xxvccEpaC9evYtuZwAr0bO8yJkrddNhjhBY11liUMnRXFD4FANo8pCrt1?=
 =?us-ascii?Q?bDFz1TSaPbFKLmrHWQXGOCmBMB7ie2x2u3skpanIeM+JmBHUJxSRaiGZ5xHt?=
 =?us-ascii?Q?LjkRWjlzvnV7kfFXdt8fQoM1wYsFlCv7x9QAEJHxgGodFVbtx6YP9ph2gzmZ?=
 =?us-ascii?Q?BE3qfQE6hOyHSqpWCZBV5IGPxsq+JLwOX8i0GdtY2lTDjac0lb0Wq6kuktIB?=
 =?us-ascii?Q?bdBk64nAWVPWcftTMhxr9v1m/4WpTMGhOl+/jgUunJOqWU2s75kQsO9PA8jX?=
 =?us-ascii?Q?o5FIaG7W51hI1xSDcLcwgQtJsBtx6+hIoDFXvjHWLtcjkC2MO5ZSlb1yL7k7?=
 =?us-ascii?Q?r8F1IQVxQnQipm9njeq3ox/ixXQ8cDmhAZ9QAn06GbIJ3b2ieWyqyEl8yTFM?=
 =?us-ascii?Q?aP1Obo5P04wrfy11HqALNBGOGD8QVtY35ULUpbXJAwjH2djaosShyVlu+JrN?=
 =?us-ascii?Q?KrIn0IaBAzsKoMLe6TmAY4flNbp0rd9CAwtGu5tAP6S/2VKzgEuuyx9YFdCz?=
 =?us-ascii?Q?siubG4ZCeYBsYqGORwMGY8eyBTgDEy5OHmBxoUaX4O9C4YE4DOquDqm229zU?=
 =?us-ascii?Q?US/0knJCMu6eyde6nsoj50aQuc834ovGbXUG/ktb4JZDNDIIoPBtCqCvWuYS?=
 =?us-ascii?Q?zUF+cp5YuvyO0fLy/dnuRkMjmsKCjfoR+akkHvpNIcoTdb9zP+F8YxprqXeL?=
 =?us-ascii?Q?1Hez8l98617HwfzLR22E1EKfebrrRHnsIC1xd4JNwG6QuxgBJAM0D+NB9uLQ?=
 =?us-ascii?Q?1BZxd3WBxfAxqVQ0tNbjK0qisPV+ePwLf4f5bBstbkQFopykvNiyobVIf+fv?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845f7e4b-86a3-456a-8bbd-08dd4d0f6160
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:51:01.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0wOq4oFsT/psb6KaJi//794Y7HaM5RSMEL4t+QF5yJcod68HrvLYsbhfqsXaAKx9vxfRkeen7WDQnad3pLatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 15:51:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17223

When `ud.shallow_fast =3D=3D 1`:
- Prefer an initial shallow clone over an initial full bare clone,
  while still utilizing any already existing full bare clones.
- `ud.shallow` will be automatically set to "1".

This improves:
- Resolves timeout issues during initial clones on slow internet connection=
s
  by reducing the amount of data transferred.
- Eliminates the need to use an HTTPS tarball `SRC_URI`
  to reduce data transfer.
- Allows SSH-based authentication (e.g. cert and agent-based) when
  using non-public repos, so additional HTTPS tokens may not be required.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 96 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6badda597..a38f6bf0b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -207,7 +207,8 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags +=3D " --mirror"
=20
-        ud.shallow =3D d.getVar("BB_GIT_SHALLOW") =3D=3D "1"
+        ud.shallow_fast =3D d.getVar("BB_GIT_SHALLOW_FAST") =3D=3D "1"
+        ud.shallow =3D d.getVar("BB_GIT_SHALLOW") =3D=3D "1" or ud.shallow=
_fast
         ud.shallow_extra_refs =3D (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") o=
r "").split()
=20
         depth_default =3D d.getVar("BB_GIT_SHALLOW_DEPTH")
@@ -253,6 +254,7 @@ class Git(FetchMethod):
                 all(ud.shallow_depths[n] =3D=3D 0 for n in ud.names)):
             # Shallow disabled for this URL
             ud.shallow =3D False
+            ud.shallow_fast =3D False
=20
         if ud.usehead:
             # When usehead is set let's associate 'HEAD' with the unresolv=
ed
@@ -366,6 +368,33 @@ class Git(FetchMethod):
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
@@ -446,7 +475,40 @@ class Git(FetchMethod):
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
-            runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
+
+            # When ud.shallow_fast is enabled:
+            # Try creating an initial shallow clone
+            shallow_fast_state =3D False
+            if ud.shallow_fast:
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
+            # When ud.shallow_fast is disabled or the shallow clone failed=
:
+            # Create an initial regular clone
+            if not shallow_fast_state:
+                runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
@@ -509,20 +571,6 @@ class Git(FetchMethod):
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
@@ -533,7 +581,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
=20
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow) as tfile:
+                    with self.create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=3D=
shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -543,7 +591,7 @@ class Git(FetchMethod):
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
@@ -557,12 +605,15 @@ class Git(FetchMethod):
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
+        runfetchcmd("%s remote add origin %s" % (ud.basecmd, shlex.quote(r=
epourl) if ud.shallow_fast and not os.path.exists(ud.clonedir) else ud.clon=
edir), d, workdir=3Ddest)
=20
         # Check the histories which should be excluded
         shallow_exclude =3D ''
@@ -600,10 +651,14 @@ class Git(FetchMethod):
             # The ud.clonedir is a local temporary dir, will be removed wh=
en
             # fetch is done, so we can do anything on it.
             adv_cmd =3D 'git branch -f advertise-%s %s' % (revision, revis=
ion)
-            runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
+            if not ud.shallow_fast:
+                runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
=20
             runfetchcmd(fetch_cmd, d, workdir=3Ddest)
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
+            # Fetch Git LFS data for fast shallow clones
+            if ud.shallow_fast:
+                self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]])
=20
         # Apply extra ref wildcards
         all_refs_remote =3D runfetchcmd("%s ls-remote origin 'refs/*'" % u=
d.basecmd, \
@@ -629,7 +684,6 @@ class Git(FetchMethod):
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


