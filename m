Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB11C021B7
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:26:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web11.29032.1740158767905191544
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:26:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=btTNGA0w;
 spf=pass (domain: siemens.com, ip: 40.107.20.78, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhUmOHOSIvMoUhjaGmmTKHSZzAIbR40+OQCDpoyhwiB3aTSq1bR3Q+9X1DdPcKwFiuRjNm3RNSO90sa5rbMixskD4djSmwMBN9Z0Jh7gUhBQk4OgHGxXddnktds8RFoZtafDf8tFA6/APjiHD6NERn2vD0lBQlVlj5rCevboqsWuMw+co5k816qIMeRnUAo4ig+9842nXXvKNT9sjksTZKlur0jmlD/DiqPN1DF8fPNhQavl/Do8YYK6RXoHZvIw0ZI5o3KVsSsLctRlHPRRyydTxTkwPpByPeA3X1DjV4ga9/9CiXllJiXp8+ajpqFOg/5jaFM/8ikWW0ud0XkySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoYpRWWxQtycvWwvMlOYLdgUTe46p0PunvlHEl+rttE=;
 b=rAijn5se+ttksDm11vLLEXWM6nyn7CXHL0fE50Yw9dIhgD8Jz2Z2uklsLuV+qOvLWXdQB5m259JohwL1uMfXtnjnm+6MQkrlxIe8nS74j/4DviGVv9XRq4sHf61Gdjo7QIshVvdk3iR22VyarZwaber9Tj/kEW725LpbYEOoib/LmTz4HSBkLRo7b7L+c18ArYs85EzucF81+hA4HwgrdMHaxzWMuOjVZZctn0IYRzVnpT1lUvcxniallHRWd4nAQh1i9JIj8RhpE5cedDq+CwOanRtVAjymIn9vv0xKjJjOItzojxhJlXvqsuVcRXtaYUuG13tH+xDw3cfyDHEcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoYpRWWxQtycvWwvMlOYLdgUTe46p0PunvlHEl+rttE=;
 b=btTNGA0w+vj4iW3niCTkkynE2cA+rfz1DOSVJxyi9qYU1B3LD2rYczD5byQa1FPNMRa6TLDy/KPoB6/lHolk/hygMO4CTMmPkIJ4+itLGMLvmQnE0sCXNitaPFYeoBaRUJW5/nwnfIyKuWdANKafafHA6toC+QtHDCaLPzljG1bXE4PBEKGbxen/71DxAj8GDwMw84NhHTInPomfWg3Avt3wByeHHX+NYipBRTHxw5skNE7NKHKnC1wTbCpuOEcGHHh29o/kZCkKTlgABGro9iI6K8CtnC6e99cnJrFWlzX99BxvDbAjeEWYWw4xG0qiTWZvb/HP8TeuksPbEFl/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU4PR10MB8514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:26:05 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:26:05 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de
Subject: [PATCH v4 1/4] fetch2/git: Add support for fast initial shallow fetch
Date: Fri, 21 Feb 2025 18:25:59 +0100
Message-ID: <20250221172602.527924-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DU4PR10MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a6032d-626d-46ea-025c-08dd529cd202
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FHSu6As1mqR7EpzknTtjm7ntGOimDXmGgtK9+IgsLm2APfttUwDwBbxVg+SD?=
 =?us-ascii?Q?6a+8EEyOQHvaLdJQJS26HOAR8HR1Ut3ZwjF7KHTFLi6lDPPg2u621zz86HYk?=
 =?us-ascii?Q?HfdCLAz42xFHKsfi6zmFBGWA3dCuX0ViEitEfvMDf6sshBkRiU33aQ458JMZ?=
 =?us-ascii?Q?joGhWPH/PtXkF7jYCAO5X39POUyiRlXh3jbBUlDCAxR/15w5VyauQGd8HbJL?=
 =?us-ascii?Q?kQLSBOPCaTFl2prQYCuMbEDRRTYngeeFe4leo/mhqqH0oHQGO7H6geT/0jeC?=
 =?us-ascii?Q?NzUkS17JyvYrtXoVYOcRSykuZnY02XftTIT7piWrv6FJeZrQNt8ZAKQx1cP9?=
 =?us-ascii?Q?pVSwXOCCWYEQ2U5GgzwgsniZv6uALzUkrfE7ob2NSsMn6yjtucgxndCI2Hwy?=
 =?us-ascii?Q?tz/g/XPY2kXFdaw7OhOqoN8Q5m1dWWA1QH8ReXvAp+qm5NBU3dcL/6O3fSIv?=
 =?us-ascii?Q?NBlFFInBezDwa7ZYBd9qyoDDSEpLuzm22Jit13mtHkPdmo0sTvFSy7p7u9Jn?=
 =?us-ascii?Q?w8ZUuxr1t93Ci3eiFoaAU7vnv6hX7mR/aW0RqwBK1cT+VC3AoLMxYKGuvXbn?=
 =?us-ascii?Q?Tr8tASeevleLimsn+pNSsjJVdwdcNtdYfVOr/Vwy/65vUEFjuq9mjCQDLGJA?=
 =?us-ascii?Q?KVAFPXumYEK5LSv4g51Ixj5CVH7M/DQQAFdBK8R4oB/gPDlHHILgnCOh00of?=
 =?us-ascii?Q?s5N8LqEaqYoQ7ppLebjGXUzypJNTJi00m+V8rze67eBvFEFYMbtbRbJ64dtb?=
 =?us-ascii?Q?nafN+Ll+P66XBFwGDH6EZ+RUliAVvqMpg8OIHUokjEdrpQEDVxBs34e1Olbt?=
 =?us-ascii?Q?1dt9tc5/1WXajCZbmG60Tf/0u96eonjlYsxOSgbCB8STCIfDlIuJHg7x0Z5Z?=
 =?us-ascii?Q?HosdHFPsq/Mb8PVZ/5KSxl+EAX8D2s5dTGVxEp/r6yvvBgxUW/QydQL50O08?=
 =?us-ascii?Q?l8qA338r/Zi587ucvLK9aZNRctESB+/myDkmJj7515U8xjV+nNR6WvKf/Msh?=
 =?us-ascii?Q?qbkBBsHTazgFecJvWS7ljiYGa37ITPNYAaOeGkTu7Q2xtG9PCTMIQ95mPVSY?=
 =?us-ascii?Q?Wc3oknFfMmqJvrUP+TyTRExN3TY0HRf0d/Cf9WUvXAMQb2fgNrz/HXh1yEi/?=
 =?us-ascii?Q?HjHjup6zZTFuEkteFlc7Y31S/baFD99gx86DtFfGoGa05GgAfzsCzIl7UCV+?=
 =?us-ascii?Q?BlDUMK7mjdyJ4nSaPPFT5pjb7BBqT8Yh6HDUzQH2a02/KLN3J7IV1Pu9aTne?=
 =?us-ascii?Q?/+DzVPcztaLUJ3NP630jGEI79uwjDXe0kbUMImFMFU+EOhPKQ4lfq8gz8SBp?=
 =?us-ascii?Q?FIXfAgAFt6TShlRD8mXy1+ye0CUPzef3VzGanQswwnxQ27xyB4OYuRpDnWaV?=
 =?us-ascii?Q?m4A4oxdxhrFbe2yKT7XaypbmWEGJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2SG2kq8iQZP6lEetRmO1ePjarC5juu0IqWXJNy1yXZ8eOYQq9YpldX2Zg2cm?=
 =?us-ascii?Q?BrIr6k1sEOWIudPiGzMzjczzituBKWoMP6C7/p64DEQo8ap1o0nyMfIJwHsl?=
 =?us-ascii?Q?XMJumCBK9zcBtMgwzIVHeooFITNh2VbZdCQVR9SsSpT++GHr//qKS3XDzpOQ?=
 =?us-ascii?Q?LQhtC89Isb4ErflPMkDGvY/3pqZ4giO01AZNdn6p7PXrHyuG9eO2ZnpNGfeL?=
 =?us-ascii?Q?/m5/mbRp20PUG5x2eSpPiqAvcdehO4+F4F/Sw57EwDuTGpkE9V430PbQzmjH?=
 =?us-ascii?Q?2P+aETtJZZ58SxMWgiSACnDIZa5JbAdmlW/tLvzXg3i5WQGJQtnErxSJFr9g?=
 =?us-ascii?Q?jBBTE8HGqBG9FfBlaOWr5h4bVpodLZKSXRLVDECfRXWChKqUybqA81X7CWfK?=
 =?us-ascii?Q?qQ8Tild33Me73iTDDdKn57ynZbFDcID7uFgl+YZnm4yiCzr4Y8twaM3HX6AF?=
 =?us-ascii?Q?jJAR/Z04UgJUUY6Wj2kQYLjzRa29mi+N0PJYUj3xSY3rp6yMs6iuYC2RCsNZ?=
 =?us-ascii?Q?jxSMom3jz0od1IpSczaACcexERyUulxt8aezY8x1mxWcMJo9eXd/k2VBDKUA?=
 =?us-ascii?Q?xNktOgoH469XKEhXnvDvZ7w7cWu6P5KjvOztB9W9O4T1ahvN0YZkQTw+qWqb?=
 =?us-ascii?Q?TvNvwi0/F1bPD0MgLqWRVia9GZhpRLRNNPx60eg8epYvWTV6uUp7CXnUJ088?=
 =?us-ascii?Q?5obwJ+V+qNEwl75OQiG+1iwjr0p0NjGZqNO3aSXZCHF+VVqZrQqN1rvFp8EB?=
 =?us-ascii?Q?gZIM1KMUU0YrLysiFe4SOrAYc8cziirP6GHCUaTHkBlo1J+9ZvC3aoDUcEW1?=
 =?us-ascii?Q?YjFNJiPRUi6TlfqIC6GU/DT45NJIoxRHl6GBbQASY0ZLiEiajr+sEY7K+05J?=
 =?us-ascii?Q?HBevp9m+0FU5NhSRFjYxqx3CMFgb1QZYl63JJ4ddRGsCooUysNnRZpjhUG4Q?=
 =?us-ascii?Q?a6GeF+XlM4XJSILwc7ylwpeiGjyKaMRpl2yIu8fJEH70gahi7X5jqbKb64RN?=
 =?us-ascii?Q?+7OrXvWDbBJbVVddEDcsR0ZCoznaC4fG++75EEtPP+MsuBa3OzvunHfhP0uB?=
 =?us-ascii?Q?pR+JKfr6DYlyrzaw8h1oPruzEe7aDrlsowaTW5qEK7ugVPzgbbJrtT+WFmvR?=
 =?us-ascii?Q?2R2zF4YOYSkRdzkPpDsZoBl6Enhc9g79r6nj9F4ziXOTxNwebK4fmxSRoE5s?=
 =?us-ascii?Q?ilrneuDHTmE/TK24re/UoFjU06sx5/LwYRF+wClivXr0XwG+dQx7LXHR1iRf?=
 =?us-ascii?Q?G3kgO0UMSVFMGoJCaWKaNMID+a1GjCJD+4WfNFPRDwWCiqTUfwBidrJX32F1?=
 =?us-ascii?Q?11VHBBTDA/uHxeg104hkSSIlD75k21dMoU5DCvySsjDvRjqFl3Wlne+8n3G3?=
 =?us-ascii?Q?pB0RFn4HK54zZeBG1xnvOtnmIXDNIEmDSANMSpT2qYldK/DEMeyIwSm7/epm?=
 =?us-ascii?Q?duqjNUFa6UH5MAsXdNQwyIkPRsvhihEeN5/oQtaQh3ZrTM80JHyV4qIzJwgr?=
 =?us-ascii?Q?TYlEyzmtnup6hS/CpmIQSPvIcbhKe65+wxvHvQ6c24gKoIvrtXRdRE1mFyI5?=
 =?us-ascii?Q?cJYwm40E2Wj6YSMAt2hvzZ4VkzD4sm/zSxzAsbVjR89HhXUTVXGqLxXCmbsD?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a6032d-626d-46ea-025c-08dd529cd202
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:26:04.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACHIi4MhSWqHA2WsRKwB7H96FlT86siEZYQbLfQc0bPbj2iFTvGCRDuwnx9rOZatDReMtdDOUSPSwYRrURxEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:26:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17286

When `ud.shallow =3D=3D 1`:
- Prefer an initial shallow clone over an initial full bare clone,
  while still utilizing any already existing full bare clones.
- This will be skipped when `ud.shallow_skip_fast =3D=3D 1`

This improves:
- Resolve timeout issues during initial clones on slow internet connections
  by reducing the amount of data transferred.
- Eliminate the need to use an HTTPS tarball `SRC_URI`
  to reduce data transfer.
- Allow SSH-based authentication (e.g. cert and agent-based) when
  using non-public repos, so additional HTTPS tokens may not be required.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 100 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6badda597..5ef2c2147 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -207,6 +207,7 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags +=3D " --mirror"
=20
+        ud.shallow_skip_fast =3D d.getVar("BB_GIT_SHALLOW_SKIP_FAST") =3D=
=3D "1"
         ud.shallow =3D d.getVar("BB_GIT_SHALLOW") =3D=3D "1"
         ud.shallow_extra_refs =3D (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") o=
r "").split()
=20
@@ -253,6 +254,7 @@ class Git(FetchMethod):
                 all(ud.shallow_depths[n] =3D=3D 0 for n in ud.names)):
             # Shallow disabled for this URL
             ud.shallow =3D False
+            ud.shallow_skip_fast =3D False
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
@@ -446,7 +475,41 @@ class Git(FetchMethod):
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
-            runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
+
+            # Try creating a fast initial shallow clone
+            # Enabling ud.shallow_skip_fast will skip this
+            shallow_fast_state =3D False
+            if ud.shallow and not ud.shallow_skip_fast:
+                tempdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
+                shallowclone =3D os.path.join(tempdir, 'git')
+                try:
+                    self.clone_shallow_local(ud, shallowclone, d)
+                    shallow_fast_state =3D True
+                except:
+                    logger.warning("Creating fast initial shallow clone fa=
iled, try initial regular clone now.")
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
+            # When skipping fast initial shallow or the fast inital shallo=
w clone failed:
+            # Try again with an initial regular clone
+            if not shallow_fast_state:
+                ud.shallow_skip_fast =3D True
+                runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
@@ -509,20 +572,6 @@ class Git(FetchMethod):
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
@@ -533,7 +582,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
=20
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow) as tfile:
+                    with self.create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=3D=
shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -543,7 +592,7 @@ class Git(FetchMethod):
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
@@ -557,12 +606,20 @@ class Git(FetchMethod):
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
+        if not ud.shallow_skip_fast and not os.path.exists(ud.clonedir):
+            remote =3D shlex.quote(repourl)
+        else:
+            remote =3D ud.clonedir
+        runfetchcmd("%s remote add origin %s" % (ud.basecmd, remote), d, w=
orkdir=3Ddest)
=20
         # Check the histories which should be excluded
         shallow_exclude =3D ''
@@ -600,10 +657,14 @@ class Git(FetchMethod):
             # The ud.clonedir is a local temporary dir, will be removed wh=
en
             # fetch is done, so we can do anything on it.
             adv_cmd =3D 'git branch -f advertise-%s %s' % (revision, revis=
ion)
-            runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
+            if ud.shallow_skip_fast:
+                runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)
=20
             runfetchcmd(fetch_cmd, d, workdir=3Ddest)
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
+            # Fetch Git LFS data for fast shallow clones
+            if not ud.shallow_skip_fast:
+                self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]])
=20
         # Apply extra ref wildcards
         all_refs_remote =3D runfetchcmd("%s ls-remote origin 'refs/*'" % u=
d.basecmd, \
@@ -629,7 +690,6 @@ class Git(FetchMethod):
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


