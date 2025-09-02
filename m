Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A976CA100B
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=PG5sr3Je;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TysAzBB8dVt67yhAGAb++nriicHzwUf0I/bb6u39k4BKEaJfceag8MD4bdgd8aTIoPoK7LPrq5smcqYpN1rWAkB5ED3EHKBvzA/r163cRGMBO8RqyzhbqTfkSR2CuD21q7+oLDpgHQ2pgbv7Djz24PfLt4dsx4TMxBeWQkp6Nn/oVk1JsLrotL2mSpeEW1IiuCytdfyvhgtNvDFwrBnuFO4g10yLDEMuVvPNKpPPNHTumQRfok8tXA/tQ7zCEg4QLqBXL/sGU+Q6eG3Q2+gDb70ZDXsA4MtqKzZxj2+Y4HQ6gCG8GoWx0Zvk1nLcuo617UWcgbjD5QkZIZRx1ixwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IQFXh4tEGCzBV++ML3ZkOXmpjlHV6Uq0ac3+85o518=;
 b=q3kf2fEC++I/p1dJWYwxMeNkNL7gMPOKpmvpWyi//0xE+sketagr/lMuw6DxDvamQ/r4teCFfNAUXJmtrOW2mZandLfO6kZxB6FMbNB/lSHT0huATxIjSb7wFAFpZt3Jq01Pl86y+yRm6w5o4CrApSYiUSP+fa4ypHfgNjoxUrRuRIvwRjRr9Gt4Y9KlRM/Gj3Bn7RTzndUX+yUytApum0ENBWVAaaQlzMUaedT9A4r9KelibIB9NzbTLmVRnN0EgqN8/kigtzQCKQZbgGvDZkPagpXKoUpYtMjKCS0Q3O1cbtYO+DMj4HLGz0sB0FqbSsoIlnPV/6jODyFwktzKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IQFXh4tEGCzBV++ML3ZkOXmpjlHV6Uq0ac3+85o518=;
 b=PG5sr3JetaDRLvqtY9FESjIjRK/ewVdmIUHY2k3+kQxQQTvo3R40QkinYgtx8QY32YPUPBSpVP8X9mOJudCrmSZ5brVjnblToI7rcNWtqtdm5BIJZv1gOG79lwkHD8jniFukJos+maKtfmRXYHRrOTwYSEKHLv/PXmmNWwBet0tU/9jxLWOBPAQOG5DZhKIYbYPYwc3RvF4FaUcMD1NigWgPsO2xw9MSn5cZ0wb4HfU3Y3PDnKGog6K9cxqfB1ZBqc8tsUUEFlRSH0GXSl0ySy1cdUlRpG5rU/mXwbU93LYqHMwx7OfXKic7UQByye/cGKK2lJjng0XjVWnqCfeJRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:45 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:45 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 11/15] fetch2: gitsm: handle submodules inside submodule unpack
Date: Tue,  2 Sep 2025 08:45:10 +0200
Message-ID: <20250902064515.30879-12-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: b145e9a6-5d5e-4a5a-b399-08dde9ec5553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JEmQTBoKO7faTV96qTPlmZXXuRRBUrZkPTuIGYJk6dNYz0gZsiwb3ODsQmHk?=
 =?us-ascii?Q?Bejo6IYMntCHOy47yb1SrODKMbxQr+6kn36+WXruuos0bh9mKnn+W+mI47Gz?=
 =?us-ascii?Q?Yw7ckB0EI1gfJ8jfUZ0tB/eXxexDCWS34148GTczv+rELIXuJ1eZgJG3JTcF?=
 =?us-ascii?Q?1eZ2gdDD1EWPHDm3CNAbzVQyuBLTHfIVCvYyahOxdN7APCL049aoH8Ymxu0n?=
 =?us-ascii?Q?fCJP1nWV2cEZGzwKnX3fQCcYEo5cDowvhT4QOmIh9nDGMonh5yUeqvPQC9bJ?=
 =?us-ascii?Q?OCUT4uCduNiiMh9INj6OB79cxwwRQUo8BAPsLWEQ8kHM/j7PTzNAF832FNhk?=
 =?us-ascii?Q?m8pP+r4gsoBSHSB4+uCThZPWKXHV4IE3bWqufROy5Y+zqxDWfWLsTw1kjqUU?=
 =?us-ascii?Q?tCgn1T3D7wLQnW/T3did6QGXcQqQg4wA0NhKFsC7a/dgb+iYZwmUo/3GxvHT?=
 =?us-ascii?Q?FbtlENHwJurjIwXoznbynTa5EDpA0RnABTa0k6BMfY81tSEK/1kcVn7csZ5J?=
 =?us-ascii?Q?ZxF07K+9NtDhGNLcZY+lsa+GM1V5zFCLaeYI32iwzwHD7JCKkjSOKtH9BeWQ?=
 =?us-ascii?Q?AQHPbzPSBo+b7l5/l0xZ2bRsnQzvilq5U3CsoukjHaIvANr1Eb4lIyVVhHD0?=
 =?us-ascii?Q?jmydwGuf1zGwnndA6ne5iNeQ8nxZk8cUN+28aU8hdUyjrjSKhTfVicOiznit?=
 =?us-ascii?Q?5UXLkopXZBkYJT1BHsbvBolMHaIgIYx9dGsRNzt+uQGnWfGaXKUs6Av5CpSA?=
 =?us-ascii?Q?kGu5Ef2gG9PWGI1soGdV+csgjw5hw1y5M2LGt0XmAJepgVWPusxkM82A6i3I?=
 =?us-ascii?Q?PcAJFhRDWHL94NmrpLw145DIuEXqCwphtSlw0GjOjUB+gqgLDkRJOowtsUg9?=
 =?us-ascii?Q?7sMhPZLrdRuqPmxzWMazkWLUesGbYo6hMKZHlWVvPKd8DZumGebTgrQJEpqz?=
 =?us-ascii?Q?52hwuQ6CguyVHmOhY4T5LzYm8P/2saIe+jg3TOkZBx6cEU2wbPNDeGQY0UHI?=
 =?us-ascii?Q?gh/HBKRzdLntRDIubDeUTojaDYKUPyuIpv8xM87Si+nbgzXpDAlApllLWH6x?=
 =?us-ascii?Q?DaXXv/aQlOoes2HhDoxzxaJb+xdIWol1F19AHqiRyNgOUpW5+lJTQueXNFp7?=
 =?us-ascii?Q?HRl2XNrYGzvyAQAD1Xbr3W8bVjW2o76kQcVZXUfE8569fIchEsnIP/IMKxLF?=
 =?us-ascii?Q?WVFD10bpQLXCzWoQZNUVKQFCVWMZwnfBfz1OWtE4mKiWO64Mj0cjclsDI88H?=
 =?us-ascii?Q?vebAMKL7rYGGEHwm0qc4PvPpEw8IZh2wsvTr5ve0GWRbGV5mMvjM2CeT0bVC?=
 =?us-ascii?Q?IvrGVd3oj6P0qnXPeeh/on+RNDPP0EcvNPRROvKDiTJUZPgEOvW79T+9uczc?=
 =?us-ascii?Q?VG191hTTR2Rvu25lkJ5KbTvzbiR+4j2xLHlasg4BdScCgriWvIOnOjEoUEY2?=
 =?us-ascii?Q?ObwkC0JSDfMSIAbYPZIYTU2vWWzhCHk79oYSSfoJ0CAderkHgjRfJw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l6Aw1GJD/MAoNBJbvPm/mCqIhckErQ4HFeiH+Xnn72CvDA7bSVzyzkfOx00y?=
 =?us-ascii?Q?umzXduqyKxJI5pV7+PN3Pt9nnNIxIjkeWxBWftyvdzgakjlf4071UDsjSzOK?=
 =?us-ascii?Q?2AnHytiZiOqePPNMpGUO3vJ5b6GVyqzGZ+JV/FJLkw62hbpqXxP8ioJ8aXTq?=
 =?us-ascii?Q?OqHOJ9D1rxGUfgPKL55VVKFgtZE7gpCxWrQNJ/0PpLDE/0BYMXhVCWRuNM35?=
 =?us-ascii?Q?tjFYEhj7HMgWfMqyvSsdiSd0OxmAy8IJP3QZOd2tSsVcxzjneWogWZgLLUaO?=
 =?us-ascii?Q?zChh+ovg8yQj05aB5g1pKRy5UmXnJoo/OougSJZMxSkKSFYi4cN3UECwWn30?=
 =?us-ascii?Q?F78xSnQhheaWNeS0b0sRkuG7hw7GsXahvb36GcY0ziO/5kAtEk0N21KXSFnP?=
 =?us-ascii?Q?/HqkyeP+5RywEziN9tYw3X/Xp72oMFekIaA8dMexofzIpC6vKaz8cY84crYz?=
 =?us-ascii?Q?rOJxEGar50FnmmxJap/DOjYcTQZTI5ApMp1JPqwTWyEDL8cjTWcGUckpUOmk?=
 =?us-ascii?Q?ZZ34aQmpxoHz2pUfgH0TZET5hamDbB4RTudYIdV6uwT0s/zV+aViGxqqxaIM?=
 =?us-ascii?Q?sKZ6D757q9Fl2103tnqRl0A1pQQzX4VBfN4C/FGK5kHbLLWH20K4OYl7Ztcs?=
 =?us-ascii?Q?9WqF3/++soQ4Jx07GtMj1ofxnlQparZIlueutbdkLlFJ45T7goVsshL2aTSX?=
 =?us-ascii?Q?9fkcK3wtzXv/WHJs98QGudfYaYZfH85pD4tSw4BxFel5y+zIbkJnhwvDYgRP?=
 =?us-ascii?Q?Uw/LHa2N9gPZ8mv10lnEQobgdFfBL9YgfUksV09uStEmPOoyQ9ZNQhF40fqP?=
 =?us-ascii?Q?bnSwo9TyoXDgB9LoHIoVAG9L8PDhI1NylO8EEHqtZDmFa0L1B9cyPy5fjNXP?=
 =?us-ascii?Q?cIifT6K9MF2X2ji0OvU/M5hI3oYHXcAs/xEa9JwNCWeUXhI9s163fikU1XE2?=
 =?us-ascii?Q?TZ/hZi3NKF8xzvj7Rc4v/5yIYb5JJYbe0kAn7a0HrTsLcP8FKGX1BbBael82?=
 =?us-ascii?Q?pk7vAuOxqnvezIY3vlp1eFcOO/1Umtu6ENP9nd9/noXeg6Cso+27xmLJebt9?=
 =?us-ascii?Q?xYS5fJiIkdXrxg9pRm0CfOPPznHWqz94leyH+SlbomiGdTlB0yLeZdbMDYTH?=
 =?us-ascii?Q?5BZ7b6Lk+7CBzhSKSo5V1u3jFIrmQXdfzOjym/8QFfR/Ss1g9CxVyl8GXBD0?=
 =?us-ascii?Q?ZRvEgt2lzRtgkZPnuXYtKb0As0+07v3nP6TUe85gGVV0Mxy5yYyLDZwmepWg?=
 =?us-ascii?Q?obMB3qzVpWc7UtAGWTa56m7t7CPepawwOScBqjBuc8HL2kQtm/O+L99GMMoP?=
 =?us-ascii?Q?Bg0XKfLKzgWvRdFFrxnQI5BItAwicOme6sImYd/WbPMlgLFaQkvl61E9JJPJ?=
 =?us-ascii?Q?mTlASg93jGW3FhNxuCxanHZ6fjYassxz9tkCSiVH33Bx61p+e+KUX2DM9fb6?=
 =?us-ascii?Q?PVqXwisZe4RP12/mcTSnyrPg9XKSkhrIisBocNhMmnQIJU26VrIRSC1wZb4r?=
 =?us-ascii?Q?/OG3C6EoMs8nDWrl7FprmZ8/Qt0sBfSS8o4YKrQos3p3rSMFVm8nY+QHmPXf?=
 =?us-ascii?Q?+Bj1jLIt2e+BFukNgz0c9729qzKssjlEuebTthpuCsyCsK2IiXRHyBGCzK16?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b145e9a6-5d5e-4a5a-b399-08dde9ec5553
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:41.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4cXOhAkGaNZkt5Jnwr1mpqVw/dhnw9CWYJtoWVnsyq8dbpZJj1rDfVcUWzVfSBAy0LjNlqWrPnltRWP5I4YJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17930

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Handle the git submodule setup inside the unpack function of the
submodule to simplify the loop.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c3e7189a0..37f82cd37 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -198,25 +198,28 @@ class GitSM(Git):
         self.call_process_submodules(ud, d, self.need_update(ud, d), downl=
oad_submodule)
=20
     def unpack(self, ud, destdir, d):
-        subdestdir =3D self.destdir(ud, destdir, d)
+        fulldestdir =3D self.destdir(ud, destdir, d)
=20
         def unpack_submodules(ud, url, module, modpath, workdir, d):
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                new_ud =3D newfetch.ud[url]
-                parentdir =3D new_ud.parm['parentdir']
-                if not os.path.isabs(parentdir):
-                    parentdir =3D os.path.join(destdir, parentdir)
-                fulldestdir =3D self.destdir(new_ud, destdir, d)
                 newfetch.unpack(root=3Ddestdir)
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
                 raise
=20
-            local_path =3D newfetch.localpath(url)
+        Git.unpack(self, ud, destdir, d)
+
+        parentdir =3D ud.parm.get('parentdir')
+        if parentdir:
+            module =3D ud.parm['subpath']
+            if not os.path.isabs(parentdir):
+                parentdir =3D os.path.join(destdir, parentdir)
+
+            ud.setup_localpath(d)
=20
             # Correct the submodule references to the local download versi=
on...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dparentdir)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : ud.localpath}, d, w=
orkdir=3Dparentdir)
=20
             if ud.shallow:
                 runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dparentdi=
r)
@@ -228,16 +231,14 @@ class GitSM(Git):
                 logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
-        Git.unpack(self, ud, destdir, d)
-
-        ret =3D self.process_submodules(ud, subdestdir, unpack_submodules,=
 d)
+        ret =3D self.process_submodules(ud, fulldestdir, unpack_submodules=
, d)
=20
         if not ud.bareclone and ret:
             cmdprefix =3D ""
             # Avoid LFS smudging (replacing the LFS pointers with the actu=
al content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
                 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
-            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dsubdestdir)
+            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dfulldestdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             try:
--=20
2.39.5


