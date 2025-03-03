Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75120C282CD
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.53205.1741009758511073424
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:49:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FKWvl4qC;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhPfPy4MyyMi+T+YoXj//CMvZBzGfXFJ2QkzNtYNvecCPYvTRGRzcnQRv+y+2WLZntYdl2VviJyOkX4qRlmkR/AYRSU5WqOVd8WJOaJIKUQ2YtyHl+mt89o6argZMV305PjOoUqmrLYtzh17Zokm/XkRIa2jiASwso931Zp5C2BAKs/FZIeHV7cy1uU7hSXYl8gjwrzM4U6mY7TaWli6v/QC/T9/pB8ndOHIN5IG6OvgefOswMQJ8xAgEPOt7wneUzuxOrtLVLG8mH3MnLSgUnRhLxNKJqNgcrT/hyAbx+lMliqwA9xjom2YaXS9oX0vVuF7V70/5VQfW2HmoBlaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI82u8jkX7pTDB+xqh/wuiDeKiqh2em8AouR4ZZOgDA=;
 b=BmROOSXXJouBhPiVpYLF00ut8Pg3SHQjUC5gH1oledOwrg/UMvIgXfCU7sTgW3FvDm6TDfGb6vphsIOXbf1/nfurMSAwoDqXewamnEPNZDUX5HEAUYRx8ciAobC7ARk5MSzoJ5IalU/4zB2gMWBSmAijA9ko3+uQrCvd2PhVV0uO/AjsClt3MokiX196QinD7/tmpOgIFQJbOQY2K1+/3BVyjyAfsieE+qdBswe/h7Qg8ImBgNGQ4GI9SERqbrgUID0fyfjRFUbW98jAXCjyJbmdoZMD51LyXHJlgxpUH4SrjywdC4BPjQcRTH4i72CE83bnMK+2tibOpOtJbCHpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI82u8jkX7pTDB+xqh/wuiDeKiqh2em8AouR4ZZOgDA=;
 b=FKWvl4qCuIxCXt4VdAbjd2CkyXxjJ7PqJzAWyqnts1f43vzFeaJZwxkD35kjIDPBcwW1Lq2Lc6zboL3NKF/juNqoInE7XLxKnceQMequil5vLsfWd33ymyI5XHOG79lA+CM0ZSbFkF1b4Vin2s0+muYIhzx7JnBZe1i/Yul0MTBQsBIMGXxMadNT7df44Ijkl+/PIknEMXg/PrzFzJWyPGhtUSQPwu5UvpgPl9ieAa/zXVnVUOUmaPs1Vp8D2gj2rXatdQYdamPjiGhLhKf3SQmSsME/oKEMuAXGkbn3ZGN5nhcabVywwzlmF+8u7TabkqLLR10UVpFYBXiN4EyYFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:49:15 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:49:15 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de,
	mathieu.dubois-briand@bootlin.com,
	Ross.Burton@arm.com
Subject: [PATCH v5 1/5] fetch2/git: Add support for fast initial shallow fetch
Date: Mon,  3 Mar 2025 14:49:09 +0100
Message-ID: <20250303134913.356778-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a86ffe1-8885-4780-885c-08dd5a5a2fde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x1OfpewKTUiSNYFH8aHPU17jZfr5Rk5LnmwOV3iX9znEaUCK7DtDdzfax4rY?=
 =?us-ascii?Q?uOXk/TcAUgyI8ukxmbQg0OtOO8zC4+NWFwSsV/flr35ZrJVO/t350sD7calJ?=
 =?us-ascii?Q?clFAcSsM3MGA4b8BLzvtCvh0r8OYYc7+BY1+hPrfd59jb9c7yhFsBqAb0oWv?=
 =?us-ascii?Q?VSSBQ0RR8EHUK/yb3JiSqNFTm7mBb5MFW5FsP3B0AORS5cT7lsY4znOCox/C?=
 =?us-ascii?Q?/JWAnSkyXf08C7EA1BGR+IUHEdWahHovvVC75VLkV+TLCqJM0F9/K4s3TA1h?=
 =?us-ascii?Q?Yh2JOxanOMvEWoNU/9NO8bqpwbaqWeiK2uhE1bCwfDujmDKbS6IyBocttssQ?=
 =?us-ascii?Q?a2OnbhhTWkIUR/1HewZ5dac6zsi3IGUALy1rpo8e2R9Okut8OCz1dELre7iH?=
 =?us-ascii?Q?9gIHDn+8xVWuJ48v/rpnyZ+XD6fj433VFQsngqeaOIWzT8Zehb36DhBZCF4r?=
 =?us-ascii?Q?DprdAWG0eTZEuhFSnj7r3Hx5LcQJw/ME1qT67CaQ/JmVKvn5izux+M6m2rmt?=
 =?us-ascii?Q?imeBBJunflGo7tAD+UqgDJnrqYv/trBwxDn5Ss09ibL4P6fRy39Fg5G+TwzY?=
 =?us-ascii?Q?FGmdK9h703LOCeC2ZxpSkpSxXA62H9/2V3alnbLqAaZ4pljYU9b9E4R22HJ4?=
 =?us-ascii?Q?PhsGHBRHtQy2XAxZGfiVdMIa1v/s7O6mt8mVjyQhSN3g8RMFtdU+Nm64FJvj?=
 =?us-ascii?Q?TOPUy16E1we23ARRKqgpVQH8Mwr5U5cSmrqoX0tebOHbft+aWjCtZvI+tVSA?=
 =?us-ascii?Q?XMOcENjjpogRfWY835xjAYs7WcJEM5qaGkGaeNzWXrYoTNDYj8k+SCNKWeRT?=
 =?us-ascii?Q?DYnAT2YfMX5MOxmVXG+yxzv2/PppXG1VVfRFY4SdbF8h4aOtrSvL8H+1Z6dD?=
 =?us-ascii?Q?be8sg58/lHiimnDmsB+T+2s5bZZWKfAkbW4hDcLmpcBeZ+VN/UPRwobcMBK0?=
 =?us-ascii?Q?AKeLu67649MCRM4FilsOmdMRwrufoD9i5ktknI6N2BDSoS5b3rRu/O7z1Jo+?=
 =?us-ascii?Q?wsuwSBHDrufITZNyMVNRe6ovmtvGY3oZU/ZT9WJ07iz/DI6brJhDSHtkKeC0?=
 =?us-ascii?Q?iP90RWSraZjPSct53c7ZEFQAViZreb8VX5bFijgr0er5+Ou736lXGSZPIrMj?=
 =?us-ascii?Q?9YxGZoi902TUrj1ertuTpDEHzg1ow39PWujw2w0bbMrqqRCa4TFF/qcKe+Cy?=
 =?us-ascii?Q?M4dMZgFvTT01ZWWqv/RAiHv4TNt5EQRG84Oa8Mkp7tUeL7wkP+EJLJwZ3LFd?=
 =?us-ascii?Q?gj/bJH9mCirpUO1nNXPEh3Mf13PxxZWJl4dGrN5lFOacf76rzDjz/9yeNtpO?=
 =?us-ascii?Q?ez1k9UtLy/14GvK2W793abFds8i3Nh/41rfdlRUctmQg6NkJLPmnrZ/BvINM?=
 =?us-ascii?Q?0V+lGvDW42PSCkbu/riejXd/U0K4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qD5QWtGYb8TnAs8Zcio9KfKz+u3EU6bE8ekNoNWVT7CGKfw3pvg8jXdOnCBS?=
 =?us-ascii?Q?eBHkHhGlKK5j9LJ1h95sD37f868KATlTTlUQuTfCy/qMA/o9ZpXg8jjI2n7A?=
 =?us-ascii?Q?xLiFiRTqVg3aqmNbb/79o7diGIkyjIFCtHZt/PURAISGRKxa0H0MwGW8w0x7?=
 =?us-ascii?Q?ZD+9/cCPuiyceUq+kXyLAqroDicZsCfXyHr6/VJa4728G6Mrl+b6mzzpKcGS?=
 =?us-ascii?Q?I1jyaEJSui0w1R5e51fk7wUQFEIwfXcz09llqSpgQ2bm8XwWfdym74VrSj1+?=
 =?us-ascii?Q?2dS0xuQUtrldKg+o9bLUrqHL7vkhmjbOidcIM7oCJ1kWBBJD/om8Mt4Yp+0Y?=
 =?us-ascii?Q?OCAKa6c062OVp2MF0cWtbZpcFUaB/iWD/vwsMwM8cGE5imKyrUVxRZ7SpHe7?=
 =?us-ascii?Q?pYv05Hu1dzdXgEG1r+aPgr1WoyI8k5y6O8TJBpuSA6h3uOZYilqXcBzsvgAp?=
 =?us-ascii?Q?IVC7GSs/mxsLhTye8FWSAy+ehWwCuUK5N/Yd+/DFjhpbmbmnf85H4W1O72sr?=
 =?us-ascii?Q?esFwDHRlJD6rQwETQ2170A/BPhnZoDF9vsQdrrhBMHZeFbLXQsR98tMNIAyd?=
 =?us-ascii?Q?EsED8ZW1ITmOAUcWLtZvyArbHNbdBslqPGqtLG1nT6oELvb1DoVCaJYKNVRH?=
 =?us-ascii?Q?F8dtGNTGNBKOvv7qHABpCWHJY7sF8owNwMx5tqGX4iy3tgTOTA2FsYPZGKTN?=
 =?us-ascii?Q?dzuvUlO58xb8Mcj0WvgJtQW8xAW8oTVaeRCuE+4AccFD+jZQ0YXJesIaUEcU?=
 =?us-ascii?Q?2kHVQ85rwDWn+IKlWLo/bsWXa+o5N7Wni4mntlimL0zJ+P3dnUcZgAiWjK6+?=
 =?us-ascii?Q?xjayjsE8GKnMtGxKYUkPfS9lSnXWr7jhltl3CGWfeFg+s0iejlB+mcO4m3T9?=
 =?us-ascii?Q?oKQozWdWhc78OjhrBX6Zbf5akNxhL0xlvWh0q+vDfhqN+i4nl7dzR06SoeuL?=
 =?us-ascii?Q?+QOX5GwmxvkptJjbqn3VvjIyq36putCJ0irs7q24rHjbYhqo6ro7YbKY2nWx?=
 =?us-ascii?Q?cyTXGdqgrbLMI//PoWyrByMq4tOwFxLC+noLXj1lmEMyIpVYf9euaD0jRfil?=
 =?us-ascii?Q?OCCaRcPSnGemwWfuhOM3iVIrKKj3zZn44kup3oQyqhl/DCrzfKTanZqRzH+6?=
 =?us-ascii?Q?7jr5Kz3DwLlP2Z/d7zoywLyYNXkhKQKLDyJdIbcD3RMAFwNi3U6QFyjYM2s5?=
 =?us-ascii?Q?lYYZTXfGW7gyWdN5tbQVr+hQiR5aBunhJRK/AoO7R1Vgu7nlez78i2XS6Ugz?=
 =?us-ascii?Q?HpLqoJoM4BHd6qM6gRSFOAGWt5ZxgtPiBA92STNIdBhA2ywylvwogbUH8SIc?=
 =?us-ascii?Q?JlvixNKxxCOIvAf5cSfcdDB+aujYHEgrHE+RNVx4WFwKh3/3umFSa/AfCvKD?=
 =?us-ascii?Q?Eis4gTZ2109r5pBlRa5COpMm4LQ+nn8DTKUAvdjZ7NtTmK7IBMgdDoIfGzHt?=
 =?us-ascii?Q?eQJhENehDGmeXm0rgW+6mkYVpRcOQNzpv2bmYhn1u3dx1vUICDOgfAkQVj8H?=
 =?us-ascii?Q?TljBiZyHd8GWDLyd77H3V1NwjAEzgxno3G1brNh4OOyPCuKL+noX1x82LHNC?=
 =?us-ascii?Q?6QLoRZcgsUJKv20DpzNWS7DEbPO0g7O5ZAPjlMLR2XdI5mIFPgVFze8WhgQf?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a86ffe1-8885-4780-885c-08dd5a5a2fde
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:15.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKk/wHAjajGqC941HX7qDla0Im40h7P9FdV8KtVlWOithGzXddnVLhnbmznwh8D5VrCFtG3iL/chDOnNbdgsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17375

When `ud.shallow =3D=3D 1`:
- Prefer an initial shallow clone over an initial full bare clone,
  while still utilizing any already existing full bare clones.
- If the Git error "Server does not allow request for unadvertised object"
  occurs, the initial full bare clone is fetched automatically.
  This may happen if the Git server does not allow the request
  or if the Git client has issues with this functionality,
  especially with the Git client from Ubuntu 20.04.

This improves:
- Resolve timeout issues during initial clones on slow internet connections
  by reducing the amount of data transferred.
- Eliminate the need to use an HTTPS tarball `SRC_URI`
  to reduce data transfer.
- Allow SSH-based authentication (e.g. cert and agent-based) when
  using non-public repos, so additional HTTPS tokens may not be required.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 114 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 29 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 168f14d0c..9a15abaa7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -207,6 +207,7 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags +=3D " --mirror"
=20
+        ud.shallow_skip_fast =3D False
         ud.shallow =3D d.getVar("BB_GIT_SHALLOW") =3D=3D "1"
         ud.shallow_extra_refs =3D (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") o=
r "").split()
=20
@@ -446,6 +447,24 @@ class Git(FetchMethod):
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
+
+            # Try creating a fast initial shallow clone
+            # Enabling ud.shallow_skip_fast will skip this
+            # If the Git error "Server does not allow request for unadvert=
ised object"
+            # occurs, shallow_skip_fast is enabled automatically.
+            # This may happen if the Git server does not allow the request
+            # or if the Git client has issues with this functionality.
+            if ud.shallow and not ud.shallow_skip_fast:
+                try:
+                    self.clone_shallow_with_tarball(ud, d)
+                    # When the shallow clone has succeeded, use the shallo=
w tarball
+                    ud.localpath =3D ud.fullshallow
+                    return
+                except:
+                    logger.warning("Creating fast initial shallow clone fa=
iled, try initial regular clone now.")
+
+            # When skipping fast initial shallow or the fast inital shallo=
w clone failed:
+            # Try again with an initial regular clone
             runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
         # Update the checkout if needed
@@ -508,48 +527,74 @@ class Git(FetchMethod):
                 if os.path.exists(os.path.join(ud.destdir, ".git", "lfs"))=
:
                     runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clo=
nedir, d, workdir=3D"%s/.git" % ud.destdir)
=20
-    def build_mirror_data(self, ud, d):
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
=20
+    def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
                 if os.path.islink(ud.fullshallow):
                     os.unlink(ud.fullshallow)
-                tempdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
-                shallowclone =3D os.path.join(tempdir, 'git')
-                try:
-                    self.clone_shallow_local(ud, shallowclone, d)
-
-                    logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow) as tfile:
-                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=3D=
shallowclone)
-                    runfetchcmd("touch %s.done" % ud.fullshallow, d)
-                finally:
-                    bb.utils.remove(tempdir, recurse=3DTrue)
+                self.clone_shallow_with_tarball(ud, d)
         elif ud.write_tarballs and not os.path.exists(ud.fullmirror):
             if os.path.islink(ud.fullmirror):
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
                         % (tfile, mtime), d, workdir=3Dud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
=20
+    def clone_shallow_with_tarball(self, ud, d):
+        ret =3D False
+        tempdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
+        shallowclone =3D os.path.join(tempdir, 'git')
+        try:
+            try:
+                self.clone_shallow_local(ud, shallowclone, d)
+            except:
+                logger.warning("Fash shallow clone failed, try to skip fas=
t mode now.")
+                bb.utils.remove(tempdir, recurse=3DTrue)
+                os.mkdir(tempdir)
+                ud.shallow_skip_fast =3D True
+                self.clone_shallow_local(ud, shallowclone, d)
+            logger.info("Creating tarball of git repository")
+            with self.create_atomic(ud.fullshallow) as tfile:
+                runfetchcmd("tar -czf %s ." % tfile, d, workdir=3Dshallowc=
lone)
+            runfetchcmd("touch %s.done" % ud.fullshallow, d)
+            ret =3D True
+        finally:
+            bb.utils.remove(tempdir, recurse=3DTrue)
+
+        return ret
+
     def clone_shallow_local(self, ud, dest, d):
         """
         Shallow fetch from ud.clonedir (${DL_DIR}/git2/<gitrepo> by defaul=
t):
@@ -557,12 +602,20 @@ class Git(FetchMethod):
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
@@ -600,10 +653,14 @@ class Git(FetchMethod):
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
@@ -629,7 +686,6 @@ class Git(FetchMethod):
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


