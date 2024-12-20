Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3416DE7718A
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=HX4gYcZq;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZq9YMdg3uzRbEE/+J8TX9dmYP6fcViP3eaowbYndjlMW6g2Kvyf1z5oGWE+FaLzT1iiCOmFLzD4Zp8LNROzweb/Z+BdWeOVbf7MRVl5O1dl7ZqFlBPByzYQ+/I+kB1b0HZIxoVxGbw8/OAv7PL8QZt3ZDWicpuVchuyt+o4h84HXdMdL5DPeONv1JuDwZhXxXx5dm0jEEyl666cZmypAu+3YK/W+T/EhkVDb0x09HAFpeAqY9DwCzcahXwbc8bELaurFqtCGxQ27lA/neQ2NBV/fFHGssXIO6R7OZ6LuywB+HHnjndChg2CIC9QjWue5IomSytCDlYzxt6YkqdlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTPZuyQ3aOrnIzP3GZtpG3WFcmfRMw3Q23kRVyZCQTM=;
 b=eYE2rRb1QbKcUKo4umiK/RLCcwn1QUXIi1Vq3DwXJjgeZctaFG297Mv+rDjJIGywX3U7IBauTaJlzEsE9cPM5nr+uRs3yPMSkh5d63q5K/o9cq4ukX7GhXh8yLKxb7YG/h4gCA3YoTjMSuhU/qwcmSqpBm0m3WpUgIoRrqFIRdUkaZ8wkZnNff5n7/6ML33n9SEM1jkL8LJ1xOPeBDx/q/hIDL5W22/ccSQU9FuaX/RRg6b2vVnnGS+jf9gHpMij7uf+G/MqqgSVq859wtoPzt9c9k8u6lUqn1JrbRVa2HzC8PcFerkEa2zOptCAltBJi0F4LfMTqy6VhApomKQ6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTPZuyQ3aOrnIzP3GZtpG3WFcmfRMw3Q23kRVyZCQTM=;
 b=HX4gYcZqGP28y95EoYe4Gzov4Me9ASNxlBTFtTGH1ts94lJWPNL11kapuamkHOAvcVtDnz7lVuz/SXYDZJe9J1R9BdeMKP2Dbn+DVw3+DZn02ce/scUTZiuMGSLRzWKyKSL7bcABHm93C+rgRCLr9cPg6wEPiTuAjtbn80zfhgGhq3n8NNR0+S8cRXjAS2KWhXzM7vDMBGIdta9BmzRJTsT9mNJQMiQ2DdIxj2Hm7C8v+iyZQuZR4UkQN/BGmvvNOkvPFPoDYVXajN2YgJAkR9n0pTBUkjXK/3mmSHbBszB7vDRLctPrf2ybCGW/mWO39R+ZWPxPzf8RyVo3ZJ0Ucw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:25 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:25 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 02/21] fetch2: npmsw: remove old lockfile format support
Date: Fri, 20 Dec 2024 12:25:53 +0100
Message-ID: <20241220112613.22647-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d552c8-9f2a-4138-42e0-08dd20e92345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EKsS0jh0Xn0RTsP2UfeLHfD+mU42TZPRhoyD4hjAWpK+DIP0eR/A/9+M8C0W?=
 =?us-ascii?Q?dtm3c7TfFeZHH4cWW93krFwFEMqXTzT8zem6WEpbpykfRC+4HBhpgbvMm4Gl?=
 =?us-ascii?Q?KOoU03oMKU8s2Nb7r6UK42/f2I/w6lOYTixgsdFUTbOweUyhOzBh8Vq0EKRY?=
 =?us-ascii?Q?9BrNEuSA35zw3qE+4StN5UVTvrfC5dnHXEAD0DuvzajzEnUhg01075pIhrr5?=
 =?us-ascii?Q?WGiQmrfES5fznVRTL0ITsQw1a/760zcZ7yXAnIMusKY/ws50veNTv4auiYgy?=
 =?us-ascii?Q?cSUFM5AxMrhVpnKcghNXiaFRNFQW2MMrHkzaOcv3LrnyN4onoMTuAYHZP2De?=
 =?us-ascii?Q?wlTJSH5dq4brwUGfeplnuSpbDiNfRW2gBeWjTYpL5sDvf/Yb0C21aH4JC16W?=
 =?us-ascii?Q?qNFeziwYQU1C0NNp/JtoRpslgBIAiKB3v7JWNIFhNTP38q2ZkWyIvDJz4WVD?=
 =?us-ascii?Q?OkDuKEUUnUskUGIabt6j50SKOa557fldwrIfM0Jp55kiLSmAi/h1dHnszLXX?=
 =?us-ascii?Q?v9OAdBh7j+asX/OyknUSZjWap42wNIQYPIIv1GfNpMzZt8O8qKbje45NzHnA?=
 =?us-ascii?Q?e2DIzJkrgNQQsP6lj25xDtIDjDno8HTXDYnTzuv9wJ7L8qtqN6Kv9luM3EKZ?=
 =?us-ascii?Q?a/PfIIVkKte5O+sdw4+rSLzhWhtgoKU7Ke4E77o18fDyRDw33PT5KbhNQ6Vd?=
 =?us-ascii?Q?PI++oM2+T0CsTi//MCtCSPG4KKmO2DuHmZ3RY2sibyzatPTnPOSQgte1XtwZ?=
 =?us-ascii?Q?LpNZCdlE4TrThrelQAaSm/zoGimPnMD8NbUfM0DGqihb0UV6nmOviVIEn0/g?=
 =?us-ascii?Q?FBNJGuSTxEfxo2CVmAxrHfLs+XGDsTl7V/VLdIQVSim1J+FYdkTeqojJ33Hd?=
 =?us-ascii?Q?MLG8/VrYf+wUG1NAZgIT6Ru7e88QiKX2rdysF+gFsyWQvpEqtoSd5FY81gfW?=
 =?us-ascii?Q?Jf3P9H1vaSWegwPdKQqqEemJEo6Chsx9K5EcEVsH1/3Tnamy2BoKAH+if0dl?=
 =?us-ascii?Q?ypS3mOos51vZLm+uA7fD969srG9ybzISHIPv6SApOdh8Yey7nqOTrb+B/VvY?=
 =?us-ascii?Q?dndDy9IeZ651ZIHP3fN+GghTz63oAYK1n4M2WfilSC125H8Z1cq433TAJQDN?=
 =?us-ascii?Q?WIXYtsaHmB4CfhjFs2Fo4UPlGKPyTOL0oJSy7uqhhQehngGjxJXa4AvaFCpQ?=
 =?us-ascii?Q?TkIjxas+OCJPnZsKwdPrwCRgDbyFubbnEnQF5dUP92bV7PSCSak7OZghRoUC?=
 =?us-ascii?Q?EBc9wYkRltSb+kafusbzANdbSMTVowHE2F5anDNZIl1lJgYeGm7vQG8zUdPO?=
 =?us-ascii?Q?3xH4alV1rxpJzbYqgwTzUhR4Y+FwT59lT2ZTZ197VEuSb42KEQyxw8oCJoYs?=
 =?us-ascii?Q?XA54IHeHybe7F4fQMyCcNhnCEOEC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SmxsuJ63qlx6dX6qCb6myMeI7n+hf9tmd+aZ/ds5paawAetDR2S0AWUkJm5D?=
 =?us-ascii?Q?Lm4stHk0AKfAj701+O+lQbZF/gknLKylxYNF+rJHF9Je7LssZxXZhhPFneO4?=
 =?us-ascii?Q?eQDXX9UdLSpTfmIaTsKISNkamXTVq47AC5sPAP7ICl5LZ4JvfcjsC++94d86?=
 =?us-ascii?Q?kwbLMDZwWdH5lRaYgf4poMGXxp9e+WeIt2ovQIkiprF3m+SJ+GTJr6Ydqnvw?=
 =?us-ascii?Q?9MMgUiYrYapyFq5YduUpUIiqyfc+cWLtTwy93ZFweLhwXWR4mqIrlxwH/1Ui?=
 =?us-ascii?Q?Pbj1f7G47GXb24XT0wfDWrPz9eM9rk6tYGndiz+rM0LmOFmbJJ4uhGIJ9Pb6?=
 =?us-ascii?Q?kOp2Af5UR/eCYdlaEv06YnEfQ2FLxyQ5Bz+1/p+S++WRbAxs803b1yEzG59U?=
 =?us-ascii?Q?39jYwMlWP/wLOAgQLJDXbATus1Nkw3BBgSfNAdt9OcS2jurEoJ3WlSLbN6xS?=
 =?us-ascii?Q?Kb1Swc9RW1ZwhoC9loZ0BHp8wR5Eni5PBNMPcuLqAxOyzm2aHJ76W8ipuEqH?=
 =?us-ascii?Q?AUeAWGHnbQHe2Tc/tY2F4/lhIwx4oipiKAPyEn2B3TzRitoM8YQXgRHnhl4p?=
 =?us-ascii?Q?CBKqbCuiauHWTGTaxYgl2MRSX3xlaW0k+pw5j7JBm+TDbp7R2JuHJ8hvYAfs?=
 =?us-ascii?Q?3LK29xKeUkI0K8hm4MIvOzIQF+liJrL+rciA1v0AhRC3M/WpacRt87piajz3?=
 =?us-ascii?Q?v+MJMuGPn5M3s9f0eMQ3Gwggk1jYihYC+0vbJEuFDkV9Dlrd6Q79Zdpbm0Nu?=
 =?us-ascii?Q?J94v1dwFsxS4jUeNLoOBa3J7BtV0tEMH0vUnBHWKkx7aT/fdaFyDwqnPKBAE?=
 =?us-ascii?Q?5lZ6043sT1jRtwPkqhLQtP+/mtcCfogRWwqc4d75neN+b6v+S+K+48mMA0Pa?=
 =?us-ascii?Q?JTHtS5sScPXbZC9iRlGyUGd4NMI2GF9hynJB6dDDdXw8/OVRsM6zMnikMAIs?=
 =?us-ascii?Q?hbltOH3penn/VdtU4N0sGUB6fiomBZL/ijk8Tgr1cBWpdw990SokrgxHOFrY?=
 =?us-ascii?Q?jdP5xuvBXaREv+tfAA6AYSONCHfO5g2HrcsqDYIjPFinoyhCCeXVBsY0NJQw?=
 =?us-ascii?Q?KXh/QD+Rwoig5fi8s8l6tXrXxW6SW8nlNb1u6H0H8jcSL6A+uiff8iYh1IkH?=
 =?us-ascii?Q?GXkHzv9jz8/s6bZL8pkFZrO9w2FOHMNp1tBssMs2ZlKYVVFU7ZIwa7bQhBCj?=
 =?us-ascii?Q?kDM3znZivL+bFsiDrjzeMEC/RFmzPAfARiXPu9tMVuW6om5fvQLk6jxMNj55?=
 =?us-ascii?Q?mDpJZCCWPZVj+3KCaU112T35NanwYxnOlC7wLg24YWUaHVALHbDqUEXCu9/n?=
 =?us-ascii?Q?7hUnDyzoSgp4iaeVnMCqzswgBUpIyOERaox2ScutMJd/Do8AsAh8yEvbosKE?=
 =?us-ascii?Q?PnXAqAeHTvi1B6tQ4v3pfUXxIKhMYiAcoGOhj/TUGpikUPlBP08gLv8hGQcJ?=
 =?us-ascii?Q?TFCPkFtgJVZ6Tw3AAwgmoVaN0kaixqyzgRL/O0CLntCBmTepY5FLcTfWjFKh?=
 =?us-ascii?Q?dGGWuUTn3PxBNuhIUcwvCmnIT91Fm+8d6hevz3L7QAYOypi8+MUU87RGhK+T?=
 =?us-ascii?Q?VCtjMbZboELsJ8yjZRWmLTKrIJ9HXkRMs7LojWeTdlcRfgzBD8GHNQm2YR+r?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d552c8-9f2a-4138-42e0-08dd20e92345
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:24.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OusTP67ncE99U3Wr6Gvbwhp0TfBcQHlViR2eaUVr8GImHEGm7kMpHCUQFVI1P0yv52QuPcUfeQ2YB4f3vuTc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16921

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


