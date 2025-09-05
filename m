Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787FCCAC580
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.84])
 by mx.groups.io with SMTP id smtpd.web10.14988.1757053280733913428
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=xcAfzWar;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emmmDCgNjck8R7s6lMPlHI9MzIzmJstSlxTP8q/oOtARiLKJx1dg6hNQ5LW+NYuJecbVzClZ29R4odQ/K9I00vae5+4V4yp8pfxU3/KWC6HQ7OifRUAl2Q3vdtrpvTN1xqLp1QNeTblp4zTIPwUe3QjnHk1Xd/dUcEIEk8H7ZS7Qc/xo89ujpRD2xtQl+0rK0bz3hhiKeenMGAFUiflgdoe2DLAxkDk/I2k2MSNVagM5FhLVi4KRkuBk6dkTSpB18tDN/4RWUWUqJgoog/TNy7dxoTF1HM5fiFjljLhYRe8YGR7xLYvAqjjrHWJz1bWsgum47G9EufawaGYBkzHeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOUfiewAD+pidFkGZUe+0SvI+qtL0cNBs6yfNrlcMgU=;
 b=Rruakwj6b90MqNGDUv7S0ihrIxEfm3/geD9kxcTgPJ80hWixttGC7NTG85YOMpbdBbsBSOYwKOca8YjqvscE/Rd8JVgIMYET/pe8kQoIcsTa4gboacSvSsCe88ZU25m3XaFoH0UUSfpHUdHIJgeVrY1+/K50ChL8wDhbQaXhnoL2ZmuzzzEDSAL1eNGcQ2onw5XSXdLmTfUzTyk3EgW+ODVWU2DqHg0xdNID75NIn3RYJIpIdbGLdrAofWFSBzOvClFqZScmB1n8PF6NqLE0CgkfGgbt/tMzBRyIBeMhLBYWzzFbQci5vis/PfBDx2XN3lVqB4PMv4WO8YFRIjX1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOUfiewAD+pidFkGZUe+0SvI+qtL0cNBs6yfNrlcMgU=;
 b=xcAfzWarh4ZK14/2Qa6ZJJbNmwu0p8BnJ3T9adSjh0njEYU7xfDaWDAZGyrwyuAhhFrsF2hCI8LeOoy7oY9bxl6Kg5NSmP8hGIDWVA6lCRIjZcVSEtR21EGCC7XE+UPDDfzU63DB/o+IJ37iTL5/CAljpBVJ7PobkqBDWld2GJcgs9ENxR4H0lNv6avjeOIEiI2q2x07zcM7A2sItbxGGe1dDId6eNFgKQBMd30OvmYyni5PEZLqc1HGllk6EuGEzR4v5jZ+ceH0MJ37viverodl7QyiU2TJQZ9B5XA1O0G4/6zU50Za6at/br8zmr126/n7E1rTtap5OREDDNC0AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:14 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 11/15] fetch2: gitsm: handle submodules inside submodule unpack
Date: Fri,  5 Sep 2025 08:20:54 +0200
Message-ID: <20250905062058.2563806-12-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: a307240b-72da-4c68-db6b-08ddec446a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+DJnU7S91g9yUI3yuY8UKCkCPx3UPypQ6n2Aq4Lj0ETQQo1FXlFz+vtcKjgv?=
 =?us-ascii?Q?x+o3Tc0qNAGNiE7HftXll3TatDp1yVKz3O8eaKdGe8ATJlw0mUL7H1ceV6SP?=
 =?us-ascii?Q?S5q+V4cyvSlXxY6I1IfSG/A8VTxuCeJZaUT95bLnJXZaXO61BYz7XT6iL7zP?=
 =?us-ascii?Q?gL9G6qS+VaQEU07n56y5N3nu8ah83i8flV9WSVm07Dtz8kBgn4oFNLw8MHOp?=
 =?us-ascii?Q?DU4StrUHQol8yqEOvmUA3guxkyGnDDwXk3NceOfPjJTATHC79pl3IZQc3bzi?=
 =?us-ascii?Q?LegZ0J/AZOCB3dWcN9EnFYMTbVPDQeC3wEnb/uL0JOmX+/yJmO5xwcVgMLw1?=
 =?us-ascii?Q?IKn68bVOiwuLXWz097MgofgiudB7a4K4osWUe1X+vB+H8NW8P4A4yIGn47kr?=
 =?us-ascii?Q?QtIlq/LJqzaXyF0VumR0F50rq7cReQ5awIJ5qkzZpsJk1mKtzlGt0gXWhSCm?=
 =?us-ascii?Q?fLIf9g+hjUioWoRNvA1jBakD+9FfLSNFKj4FvLDFQjlq4GtKI9EmkElaFbCr?=
 =?us-ascii?Q?f+GVK6FfyteMNH0N1QOFUF60K7h6NCeE0ykkiQm7VF7G2zgs/2xOjJ3q6WWD?=
 =?us-ascii?Q?L3x8sAAVB459v5/O+E4z7neDLTKnZgw+Z4fmrDy5VbZ+g6kChfBoiWVGOFVT?=
 =?us-ascii?Q?DjYzum4YpxAnbB7AUDys9a3tZkmnTXahbg2qQbsAMjYtLNn/H7XV47QoUmK6?=
 =?us-ascii?Q?Hu2MGpWzpUF95iO/jqmM/bMECpxO3r4Sy6IEYbKy1EsNtB5qgr/P0FszfgW0?=
 =?us-ascii?Q?/+osP3xN2nGLN9uORFPxscBMbDNztqU4vW9Px72G6v/LRBOdCvMJFf5YEctI?=
 =?us-ascii?Q?CsIvUoyLDcxavMYasjYRc4K9xrvApsT2ntJH9Xjvck4A0WN9bHUS/oJuGmap?=
 =?us-ascii?Q?scTAMR6TgM5WfMuJJSENHD4d9s8exOUP0DflKYwtcFp0W8lbKmnVKPquPNao?=
 =?us-ascii?Q?iYsDv4BbyeiPHT1J6LFtBf0rbeAklfOxz/YDZUlM7x7rBccHi122LgnVt7xA?=
 =?us-ascii?Q?oYDrDDX/ztJSJWhH/4uJ5w1OI0DjO+0aM6D9nE8SXv5GMGECGV+SjF7ySyBz?=
 =?us-ascii?Q?w/cAkkNfzbmjUPUphGL4cK70waSnXSvdb9HixbFmFGQeWFe7cX7y21+0Ng8Z?=
 =?us-ascii?Q?CHCxCi4vMrPmCw5v7AUTIyG5V0G6m0R5RCQW6MnyJbrWk3MEgkZbbZY8klJq?=
 =?us-ascii?Q?T7UoJUDe5HzUsQdu1Tc0EtJ4ZChYVONXYRDdXQGWBSlu+nBOL07Snof7xIEM?=
 =?us-ascii?Q?0a7lqysVtoJUqJvzMHSrje75jbyOZW3jAAfj5Dd23/TFTr3xPMs08xmGAdWh?=
 =?us-ascii?Q?sZm7k4+Dtq+1tb3/LMR/79kjsxK6ZtZgyS7qiO1/Ua4GsNXPlDqKsg8nYZqk?=
 =?us-ascii?Q?pvJ/qdB6fKCkrfSdledz9KPeEZWIk5Uutwcabr9txQa1WtxzV/qsKWa1+6xC?=
 =?us-ascii?Q?waB45NDh16amn7xZPiLaj479umahYndZveHii1CNUpAIjOFjBsMgsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ApC/l3FyhKAKSdgnE3ARZfnvL/YjbSQUo8bMYwx8mOuW3OmaR7NG7/hMYuzb?=
 =?us-ascii?Q?SAG9GHDlBCKk/7XKCNSzsC6UB+f/aq1JfbinwQoz42mIvWNY8+hMyy0FdlHZ?=
 =?us-ascii?Q?CyRoNrJTSx65CeaE1UJcksV15TZ0x0DirPn7DF4De1iRys83rUOaCZMBc+Rb?=
 =?us-ascii?Q?27em/YPQZe0Vcc1L19WSV5ZJE93krb3XTHBubxrfUvfzyG6henxXuaGca0hw?=
 =?us-ascii?Q?LES8dwMT1SCqqKgspHCQ+xUrmUS4XmUZhtLRIqrvdNM9FBMG4Sz0ATROg7Qx?=
 =?us-ascii?Q?zJ4upOQ6v3DqKVv3IT2s3hs76j9lsBphYF7buuJsxbsmOEvXHgs5F94pNgfh?=
 =?us-ascii?Q?VDyLDcIg9gs5OMPqCFzvZxlyqBRP30bGmnaMklzn5uefea1M2xbeSYcqgQ15?=
 =?us-ascii?Q?/GZtKxHduhRjc2oM+Hs2213ZPVChBVmlAgBxF2FaABmXm21VMYraYNQ+qYM9?=
 =?us-ascii?Q?Ezqe0j9FcUp7L3EFnlupMdOKmo3w5FhjdCtzXEd04HdLmxw02qb57Acz4GLy?=
 =?us-ascii?Q?QXkISzvAcNgwLao42Dm96eAcysRRonxdGPoyefpnpYB4AI6pVm+N6o1IRbpZ?=
 =?us-ascii?Q?NrsCwtvmVg6hD86VQcZimFtKMIEKWHduSSVGljW6UlQmidFlrOOtcwm88peA?=
 =?us-ascii?Q?ZBCQY6dhfWVRoQLTW71LwszywcMMOf9isU/vQNW89bPgBAKmQg596N2auN4U?=
 =?us-ascii?Q?ZUiCRjkPszpr/SuSHoq4yjBCedVNn+1chDjLJQu8omro4hzZ67slowFvKpiy?=
 =?us-ascii?Q?0ijyzcsksrlQ1n2PWAajYtIFOPYflWtgKiFzWq91RtRTLEzSLfeYetrXU1S2?=
 =?us-ascii?Q?sxP8JJnXSMRN4DphDitVii47+qwdQoXifPQrJoymsV1M+/8fh3Xs0CR4P6m5?=
 =?us-ascii?Q?If3Y1N6MMqO0zj7EHH2l0MkNyGTQbW5kYAd91+z12M4Iv3tUICod0+m+6pxx?=
 =?us-ascii?Q?SJ+bCzZKBcYgaUJ4twM9nBZRi6lWTCy3vLAqyRP3DtT2yklnGPmwjUj/ssw8?=
 =?us-ascii?Q?MCYI3joDKU2A1/c5fOeHjuGcFmgM4p0ous8cVMbQl4JrVwbQzEagkIb3BznS?=
 =?us-ascii?Q?BPxcXGPhi4ihBXD2LbA7DWAkgDQEsNy5T84AqWZmuJNgSY6zq52EfwGRNErQ?=
 =?us-ascii?Q?jUdkuZPVfIKdd8R15RLsjO4AfkRQ+35wMpn9/I/pNfXInNRtsa8I+zOqVmMY?=
 =?us-ascii?Q?unQGpQwOFgM7VkZqXnZKCKbxToylFKIoiJWYASee74EVqKJrwbL6x7RgYwnX?=
 =?us-ascii?Q?Yy9SERe2pnsEZRiA/VYo2DztPfLk9vIy4/fWb3ML9c0PNnKREFqUpIAGShcZ?=
 =?us-ascii?Q?eTyGDWYUgfpnsrVF+YxHdV8S2c6el6raAWZYLkVE60X2+xmX7LGPkCUY/WUL?=
 =?us-ascii?Q?LptDcMSVxeOga8wLyr1grsVec5n7MTsj5c+mTjkTO+56grZSMEOkEl8zukIR?=
 =?us-ascii?Q?v7dfrOJfCosbCL045+3Oknkulruavs8P1QsuznOv3TPmJnCkC4Yn3kD3OEMT?=
 =?us-ascii?Q?FAeTZRahA6qQf1xcsKUCE+h9E3Ao27X6aQev1VYCdI0ahNDFbElzPV5itcY8?=
 =?us-ascii?Q?Go/dTcmrIH4Qj9/oaDjfL3piOt2pq7p6Eh7eMsLjPU+XkY7dClcPB7/jql+k?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a307240b-72da-4c68-db6b-08ddec446a3d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:14.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25WlaKezwcVWqsZcP3dXOQ5VB/LhmD3/R20c6Efgv3sHkP+ZJYZwgb2oz6J6tDIeprkGG3Clb7kprs4hIssx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17968

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Handle the git submodule setup inside the unpack function of the
submodule to simplify the loop.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

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


