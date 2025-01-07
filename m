Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A4E7719C
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.132])
 by mx.groups.io with SMTP id smtpd.web10.16695.1736241496534764322
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ncD7T5DF;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.132, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp7rIWXBnuPEj9uLQ3qaZquEPS3IJ5tJT8Fzzag8H4HbuKnYAKA8rpZezMIS39Xze4ScBN75WgTROUpm+SNKDZWEEbrAfUyyP6t6zbSxrPibpe8eNWhi9jiyWGWgEgweJRbc9GZfmJm5X6FMTubKYmRVDpiYmbJ1SpX8gd1Sekc7Gv5mpgqH7lIa4yWbmxA5IKD3XOQTnlsmeXzt5R8/3tIVb0FyPXtzrhcF4QR+TPMzeLq1Ky6MqcZBaWGemOJmnVeZ8C4EjYKS27e4/sPHBJgSFsd+XYPwXca6KPxJ5QcNmiaKLaBCcC49lsZmP9yRXRyVMD5YuUP/jc9mXodx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTPZuyQ3aOrnIzP3GZtpG3WFcmfRMw3Q23kRVyZCQTM=;
 b=pQOhC/emy1v5u2xx0vs+nGso1dQ9wQp1nxA/BVXoB7rOb9b8q9fOUE8zznZcalIq4QtDYyEb7HcLSkHEoq67FnN9BYJqcDuU6oQeKkuJfgTB/soc84IpmlQPheONo6rI7o4En6c36JhQuKsSQM+PXE4ZVgHQv1Kjt6j80jBf/et5HC1i7s8VpR4AvDzCFi9GlxN7BhMxj3mO1hDFUB0jICqgpSJ7ZHDMZ00vh7umIk/Fm/J328v7O1nKFtWeos4vpClwkX6yF+yZPUcKn0Tw60Y7q1P6092HZ/Vk9qiAdVCsYagck6f3zHsAIf6G/PZYkmo2p7Hl8ziQHFVKNMYmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTPZuyQ3aOrnIzP3GZtpG3WFcmfRMw3Q23kRVyZCQTM=;
 b=ncD7T5DF7bredU/tmm0FtNfkHlgJity5vgAs7zPR77wcHxLdcBl7HRIFDEkF2xOFAGFw6bA+YfYp2vGVxLPLC2w0jSIYXPgJCCJrbyAcCXezaLjIiXxYbCsjxqBsBbr9xuiKwGCE51wxWN0UgT0bfK8qekggREMd1NdQ70fl4g/6yLPXt04X+Tm8bZufEqLGCNNLixIlYLMGmRyNRupnY5X/MRFAyYdvj5y6aFDXlHVps4GvmluphKQenro/ygFOU3GEycfo4J7SrTDGpA7Nw4y2O7kdSvzky+448011e8iEma89XjxayYKLxCbnAm9uewEVbMWLhjKwzxkiUDl8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10607.eurprd08.prod.outlook.com (2603:10a6:150:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 09:18:13 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:18:13 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/5] fetch2: npmsw: remove old lockfile format support
Date: Tue,  7 Jan 2025 10:17:54 +0100
Message-ID: <20250107091757.886-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b0cd9d-d4ba-43d4-1b6a-08dd2efc35fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?odFTDUcbZPAtAvfjmS/I5wBNVEiY8/xwvjHSBh+OVSni+0G4ax31btJyPTYo?=
 =?us-ascii?Q?HH/v2W2CwKFodV+FbBxXLS9r8bIwi2sarHISHA/3qBvomjSoszjrn3OoHYFO?=
 =?us-ascii?Q?CuFRHhWf0L46IgiPM7dBoEzrc2u/Ku3Qg4SRMAHnqFt0KoZ7ilHZoId8Q+wk?=
 =?us-ascii?Q?cPUEDjGBfbEkEkz9URAZ9rwajKqo69dREnwqGsaTxIEnN1xN4ED+X7LkSDya?=
 =?us-ascii?Q?SaKOqXDukhZaiH4ezddc10jD0H8EQRNJp5tgYC789ohccZlaJq4zYwTER5wC?=
 =?us-ascii?Q?Xb9DEaL4k7VTv+TFMVCYmgdpt0hfjP2A72mzS1dgS3zGQv1MsIz52li2EaUk?=
 =?us-ascii?Q?lxvOoKPaHsfEI3CnDrMiB/m9+Mc1VnjNbgVfXW/TB9Gwkd9KAs+TCULWwIpw?=
 =?us-ascii?Q?arVcHHWr+g2fBkQRvvZfQC+30a5TiLkWFnGElWDRE+6l+0AL9uN6uIJa/Oio?=
 =?us-ascii?Q?+EcbFUP4FOgJ+7SARoLdP9oyd4pRMaKfngBz+2Qns69xNka75QxIyhXashMh?=
 =?us-ascii?Q?0oL13UkMucFmqWsjO0nYDJf1PNgL01K4NmL5pReci96toBOvHPDcfuhQvW1r?=
 =?us-ascii?Q?5Rl9PfKl6neADTVuJ9qwhT1sY0xIt7/YcMMrRe69t6GQGyPLNSak2KQy1mOh?=
 =?us-ascii?Q?n8mM5rzpeK55XEM+8VuMMRFUj5BgxuL3x0zTGIAXFE4+xPmaKFX1TSwPE8p2?=
 =?us-ascii?Q?icn/xw2DLBC0P80uEPc1sy3wVx95hH/CxG8wwRD10xsYENiHCcCjqdgQOw4j?=
 =?us-ascii?Q?2wNvPoyj+x0q1qP5+wyBLPqbUkWlS9HlleL9iOCeDWvAEfZEkkzUyHsJ5bpj?=
 =?us-ascii?Q?zm5Fl3G+kEB/KZeaNth3NqBQkb7M4p7NHzVLserGSaBzD3GGlsmFeC4E4EGu?=
 =?us-ascii?Q?qkpsN+4EEZp78Ini2LICpqcnmYmOICvyNxlarqNUwmXI7TPzg6t8lb+hKe53?=
 =?us-ascii?Q?k+HpfURmtmPR6qlN1WlXmOohxOvKNz+yQA5vSSzBxsaQGzosFcwPxIlHEquB?=
 =?us-ascii?Q?OGqlhDiw0bLgQ4to6RXggRiQbJNl9lNsyM8D6PASl062/3b/sLzRo/ZUkvAR?=
 =?us-ascii?Q?VV8EOhmiYtCywiPhdTTm+qAJeAKDSlwf8BK6fM8PWV7Bt6VY3yGzd75BQ+WM?=
 =?us-ascii?Q?0wuE1DoHCiKDUK4UsRG0b/OTP7CF/zjhVgzxgWSJyKjaJeJXegqHiXSEmZ7C?=
 =?us-ascii?Q?3mdFqJQM3pw7cJQYr5Zn4wz+EantBI3YAIdozZm4Iwi4uEhFADxK7sAHngHM?=
 =?us-ascii?Q?+qKLFaWqRyefF3x0fpV74PmGK+MfCasbVDu3m8AsbEj+dFINEfNx2PsV3lYq?=
 =?us-ascii?Q?k4lyYVHlf9bSrSvVYjTOZdsBdzCmom06DNnfMLTNUDHtYMCrhPNQalvOutnP?=
 =?us-ascii?Q?3Gb8BmZfWin7PIioH1grZxA4gg8W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dyLR+cr53RCmbd1CkrHzSW95EtnTxG+TD1H+2Dl0UrebZMtBxjz3BCvKctel?=
 =?us-ascii?Q?2BHA/D6e4cCcE0i5grdHQU8DzTbDd8D+xWmHgN63bqWKBNY05OQ56lIGncYT?=
 =?us-ascii?Q?/JdL3Zc7K9IJoRShYsRENWrB8qQyVHDYM8QYxR51NcDgFijhM0JBnxSj9ZOj?=
 =?us-ascii?Q?ArHgxWEzfzKVcMH0fsCRlW8GEy1ZydEUpQbvhYA9B6WVUbqvO2bz/n2rsRsd?=
 =?us-ascii?Q?jEE1iyuUp2mvMLNgt6zEG+BDoKdZiGVa1qyXHqy84IHm3dI4fzRCE6KLNCf/?=
 =?us-ascii?Q?Tx5mekwDxrqvk6OgyE2TVhH2m9Eh7Hd2W3BATWA0rAzhKWCDdkevKI+tGPg8?=
 =?us-ascii?Q?1Tgy9RIT12htGkm9Jbtv7tjxfD2ksRDL5shorazKb4/7gmfdhVjwpm6EuKsX?=
 =?us-ascii?Q?1eYPZDmOz8lVP8p2c61nLPtt4siNth8wiTP1MVfeXA3sYhgJ9ap8egwFy+1f?=
 =?us-ascii?Q?G1Egw8yER2OQ8HPkVb/PuaPKoaW+0/JePMRMkuVJFOeBKXtnW4BfoQvVorNK?=
 =?us-ascii?Q?uMTLs+fKhZ/gtx7qLhE3i0i15SsiqPSrvGRohQnvRIozxEKVsrKOGgRl+OuL?=
 =?us-ascii?Q?4gvWdbWx7If9YxtePStw6HckxZ8RROC2PYibGLy7tv2+iCFUnRgry5+hoCKT?=
 =?us-ascii?Q?v3fHPhteraUqtDiXrdFbxPpOftnYgN/NywOiMlsGQHaT4P9ckujyDYkWW9lx?=
 =?us-ascii?Q?vEIAE9dLMld2rJVse9Ixo3DuKer0q1vwpVZbY6100OlqUYJ1aXltpYHYiyO4?=
 =?us-ascii?Q?XKq1hWN4bNUcaGOc555/KzZijZvQVCj/e3b3afQkY8RlBifk67DMdClPGFdl?=
 =?us-ascii?Q?NobGqEdCZBEOiIgVNsoggNpMGs3BTudlpnem6bFFXJqznkU7tIMFyTdCtE+s?=
 =?us-ascii?Q?xWOUIpZJgwb1aREJghkNjyKUMnT8OuwrByLugtrX6lDbcGGUGCgDeajd4ttg?=
 =?us-ascii?Q?TvkrxBy27V4xCFKydj/YYq1O71HdozFM/4T7jkG+miZAbwHCELKbUgVIGoP5?=
 =?us-ascii?Q?Y1MAsvGP4pNoyJwVz6MxMqIZIhmIWTMbqQYxDQ08AV6Imrnw4y8VAtAs6Wsw?=
 =?us-ascii?Q?ea4LDryunGEZ6EFVHaaFEi4WhDMOzT0S2sx1YZX/UFUO73UTSM9HY3OhcjoF?=
 =?us-ascii?Q?EpS44iw+FXGi7rWmULN0VpljtboLhvV83A+NisqWQSek0GERG47PGCFSUlzZ?=
 =?us-ascii?Q?i5i4qKkv07BL2b/pMx4RrTZ8Bb7Jrx6Bx7Kauh9UIvvujKkg8fdz8gNK5/k2?=
 =?us-ascii?Q?ao3si/2yeMwJdoQL9WNZ4VgEHQfPWnLrPR/2L29vBjFpY1zvzxrsTVwikawY?=
 =?us-ascii?Q?9QjY0VdVm14rnwLduYCH/hhTZZsSMtS/+n2OBjFDvRkZnSf9kVj2Y3CzA3AA?=
 =?us-ascii?Q?rs/jBTelRypP56OncPkiLI3YVLInt3YFciKu/eg31MqJ0LYB9xvRv5GHVe4h?=
 =?us-ascii?Q?/dMLwZasNIWY7kuukfNySxM4k3iQvDGNQQIpKNF3XXzuvVqBJL+o1oVNaHZ8?=
 =?us-ascii?Q?pSxE3FM21LhoxGWApujx7vmQOC7SE9uLFiroFxUr0esEzNItNInIJ6uUDVyI?=
 =?us-ascii?Q?Ct20ab2AEadY8K3aL+5S0X7xXE59hJ1VddSF3sqYiyQetJlvtLh8Wou8ggQf?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b0cd9d-d4ba-43d4-1b6a-08dd2efc35fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:13.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFKjLIUNxXK44PZBZj7svIwFV9rzfzt6ykusaDGhawAluRf/bAKLYM+qwaLdK08CnzDr2Aw7AjD5bQ1fx7u9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16971

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove support for the old lockfile format. The old lockfile format is
required by npm 6 / Node.js 14 which is out of maintenance [2].

[1] https://docs.npmjs.com/cli/v6/configuring-npm/package-lock-json
[2] https://nodejs.org/en/about/previous-releases

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npmsw.py | 97 ++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 61 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 558c9a2b0..2f9599ee9 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -37,40 +37,26 @@ def foreach_dependencies(shrinkwrap, callback=3DNone, d=
ev=3DFalse):
     """
         Run a callback for each dependencies of a shrinkwrap file.
         The callback is using the format:
-            callback(name, params, deptree)
+            callback(name, data, location)
         with:
             name =3D the package name (string)
-            params =3D the package parameters (dictionary)
-            destdir =3D the destination of the package (string)
+            data =3D the package data (dictionary)
+            location =3D the location of the package (string)
     """
-    # For handling old style dependencies entries in shinkwrap files
-    def _walk_deps(deps, deptree):
-        for name in deps:
-            subtree =3D [*deptree, name]
-            _walk_deps(deps[name].get("dependencies", {}), subtree)
-            if callback is not None:
-                if deps[name].get("dev", False) and not dev:
-                    continue
-                elif deps[name].get("bundled", False):
-                    continue
-                destsubdirs =3D [os.path.join("node_modules", dep) for dep=
 in subtree]
-                destsuffix =3D os.path.join(*destsubdirs)
-                callback(name, deps[name], destsuffix)
-
-    # packages entry means new style shrinkwrap file, else use dependencie=
s
-    packages =3D shrinkwrap.get("packages", None)
-    if packages is not None:
-        for package in packages:
-            if package !=3D "":
-                name =3D package.split('node_modules/')[-1]
-                package_infos =3D packages.get(package, {})
-                if dev =3D=3D False and package_infos.get("dev", False):
-                    continue
-                elif package_infos.get("inBundle", False):
-                    continue
-                callback(name, package_infos, package)
-    else:
-        _walk_deps(shrinkwrap.get("dependencies", {}), [])
+    packages =3D shrinkwrap.get("packages")
+    if not packages:
+        raise FetchError("Invalid shrinkwrap file format")
+
+    for location, data in packages.items():
+        # Skip empty main and local link target packages
+        if not location.startswith('node_modules/'):
+            continue
+        elif not dev and data.get("dev", False):
+            continue
+        elif data.get("inBundle", False):
+            continue
+        name =3D location.split('node_modules/')[-1]
+        callback(name, data, location)
=20
 class NpmShrinkWrap(FetchMethod):
     """Class to fetch all package from a shrinkwrap file"""
@@ -97,12 +83,18 @@ class NpmShrinkWrap(FetchMethod):
             extrapaths =3D []
             unpack =3D True
=20
-            integrity =3D params.get("integrity", None)
-            resolved =3D params.get("resolved", None)
-            version =3D params.get("version", resolved)
+            integrity =3D params.get("integrity")
+            resolved =3D params.get("resolved")
+            version =3D params.get("version")
+            link =3D params.get("link", False)
+
+            # Handle link sources
+            if link:
+                localpath =3D resolved
+                unpack =3D False
=20
             # Handle registry sources
-            if is_semver(version) and integrity:
+            elif version and is_semver(version) and integrity:
                 # Handle duplicate dependencies without url
                 if not resolved:
                     return
@@ -130,10 +122,10 @@ class NpmShrinkWrap(FetchMethod):
                 extrapaths.append(resolvefile)
=20
             # Handle http tarball sources
-            elif version.startswith("http") and integrity:
-                localfile =3D npm_localfile(os.path.basename(version))
+            elif resolved.startswith("http") and integrity:
+                localfile =3D npm_localfile(os.path.basename(resolved))
=20
-                uri =3D URI(version)
+                uri =3D URI(resolved)
                 uri.params["downloadfilename"] =3D localfile
=20
                 checksum_name, checksum_expected =3D npm_integrity(integri=
ty)
@@ -143,28 +135,12 @@ class NpmShrinkWrap(FetchMethod):
=20
                 localpath =3D os.path.join(d.getVar("DL_DIR"), localfile)
=20
-            # Handle local tarball and link sources
-            elif version.startswith("file"):
-                localpath =3D version[5:]
-                if not version.endswith(".tgz"):
-                    unpack =3D False
+            # Handle local tarball sources
+            elif resolved.startswith("file"):
+                localpath =3D resolved[5:]
=20
             # Handle git sources
-            elif version.startswith(("git", "bitbucket","gist")) or (
-                not version.endswith((".tgz", ".tar", ".tar.gz"))
-                and not version.startswith((".", "@", "/"))
-                and "/" in version
-            ):
-                if version.startswith("github:"):
-                    version =3D "git+https://github.com/" + version[len("g=
ithub:"):]
-                elif version.startswith("gist:"):
-                    version =3D "git+https://gist.github.com/" + version[l=
en("gist:"):]
-                elif version.startswith("bitbucket:"):
-                    version =3D "git+https://bitbucket.org/" + version[len=
("bitbucket:"):]
-                elif version.startswith("gitlab:"):
-                    version =3D "git+https://gitlab.com/" + version[len("g=
itlab:"):]
-                elif not version.startswith(("git+","git:")):
-                    version =3D "git+https://github.com/" + version
+            elif resolved.startswith("git"):
                 regex =3D re.compile(r"""
                     ^
                     git\+
@@ -176,10 +152,9 @@ class NpmShrinkWrap(FetchMethod):
                     $
                     """, re.VERBOSE)
=20
-                match =3D regex.match(version)
-
+                match =3D regex.match(resolved)
                 if not match:
-                    raise ParameterError("Invalid git url: %s" % version, =
ud.url)
+                    raise ParameterError("Invalid git url: %s" % resolved,=
 ud.url)
=20
                 groups =3D match.groupdict()
=20
--=20
2.39.5


