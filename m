Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E5E7718E
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=dsXLOfrK;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0kRTJ/j41cNul61tpu5kZGHPFZvQdabCvQSMRsJgCmvSlRSDJQzQrb/ojydk45mMcg4E3AeLoIeE7VvVKS2quz+LcsW+qKLBgQOBgaGJkmcspAtkDabSmdRGActhMW+4bn0+2rQ8lyS0f21fLnZsdafzXm4xBG4Vvb2rjZZnqdcFclkfZSGq8f89YhHQZZ1mq52FEYMVKOOMe5Xc6RIo1cpjRMJS5pxlfH+4GQNQU+sZTkE65kDh24O+x2N5Y8UaprxfZY1x6WN7ffwleKlFUSMlH8Z3WUxmPNo+cXzotX917lEEw4L/0HgOu07LrcVgC8PGTltS3OaZA0l49QyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcdW8MubFG0xs5axX8roi4aUXLdBiwpdbBx3JxYKD4s=;
 b=QCKeGta0MeWM31D63MHKeW9ukxbmOaqDjIuFlO3QePntYMRXcJjh5X3gcyTPKgrW6fcGx6kx/bIlwlAUffEjdx/YZiKVoVZVx1W2taO4bSKwEw+tafIfDng0bs0XRCwawcSA13VhX/RYhvoBEU4P5il/fr69szlXBpgc1HowmnyeOC197BEPeAZumErega97aMH6iD3u5W9kMeiyzjOxXFpv78s+ufB9TQBsQN/G1C8+QdYZrFbdAf1SJEQwbkxvsYM0FP3My/jgQ9Ap318kTA0PofOwXRaz0r8WemTgz6GB/tFsEvmqSw7QzBl9aYlu1nWXfHbdw9MEhvgl+GDXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcdW8MubFG0xs5axX8roi4aUXLdBiwpdbBx3JxYKD4s=;
 b=dsXLOfrKR+iS4mw09DyAYXLJcGlVGGvpII5haYzhSHyks85d7P94u/fADm5eYvU9ILKVkU+1gEsIy5MsYQLay4ClOnzrs7JoFJGn7aK5fTiXVgIkXh58jhBN7qGSLaYMP0aaeHM1us1lBoo1J/cll3R91ixr9OaV4HGdHhUNTv6B3YWaEHRvkJdrpeFKrYYhFmSi+9XNvRPACDfZAS7wK22cIpjayaPSUU18pznaBQcxeTtIk0ArSMUatT/mwiK7hUiOJ9aLOYXM9+fWSo+M/+caY9Ciziui7898bBi83+p+0F/vg8NRWtNmPHhyfc1P2/DPPIJplUDKBUTxw39gVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 18/21] fetch: add gosum fetcher
Date: Fri, 20 Dec 2024 12:26:09 +0100
Message-ID: <20241220112613.22647-19-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d79d5fa-8ca3-4889-5b9e-08dd20e92657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Fmq+GJumgtdsxwnyvqff6zt20c5JoZEi8W2/H/KNFvYnPiQj9eElKXmiFCJa?=
 =?us-ascii?Q?GVSBwkwfK9jqSgG3/GbvxV7f7gefOpYNyEXXiXqRl2aRUMU8c7xp6YM0Eqbc?=
 =?us-ascii?Q?waJyYKdXko2Tpar0ITbCI1DqKaZzYvaZnj3ciYfWrDThgl7zYoNHrSebZllD?=
 =?us-ascii?Q?FLcRuUsoP4xRiLCiQL2IIo9TYpjOE/EdUiFTKwCsZKhhkHfzkAsqLhe1xXYD?=
 =?us-ascii?Q?4zkwWK2APqztfrzeaZeZHgaaWeR9AjSqPXz2H2Wsfy58SWQx2pozjDBaRM2w?=
 =?us-ascii?Q?xjfp8qjVL3kpKJfOV2VOwAF8aQse8LDWqf2CALofNWOcnwH4sIC8DAxppvTZ?=
 =?us-ascii?Q?d8yzKW8TNCZeZkFm5TGWoR60Rie7XpQMU3lT/6UM3x8huxAkWWMgDslAu1eR?=
 =?us-ascii?Q?GDIEkeb1x0XknxYusJ96aL3yAkMGZaLvY3A/dH3v3Z6mC6bKPYaXXNkdCrnE?=
 =?us-ascii?Q?6inGYVX8A8yX0D3gMoZPWeX7E5YhjgAPd8q4+W0fVsx07e+pDdvhEaPMltlF?=
 =?us-ascii?Q?Jo/x8syFcCiiKoxJNTT3crBjMBfFRgBIUc4AJ/A6OBMGNkGVgn5T9maoSrHS?=
 =?us-ascii?Q?RNw1hxVcQ2kICxsSou6/p6oUA+hSzS9tmw2bRqQEZJoJ/SS9t4N/cW2a/4d5?=
 =?us-ascii?Q?vZcseC8G6FGfQph2BtPVtsE4ZYsvbVuvVeP0vdCz0jHT4MHSWvpbqZ2sSeYt?=
 =?us-ascii?Q?9XTGFtvohs0wiIlhhuESLpw478upGKidgcaFoNiw3Zmu0AFiYSCEdbz4Sasu?=
 =?us-ascii?Q?3fUKXpf0xRR09W1+XHo/T6OAkIndrkIj+egJdTGKqJ83VrP2z3IqcRrY1Jpc?=
 =?us-ascii?Q?dlazW/TK2D6viZDwdt1V6yPeuyQQKNF0W677bjpUpmq+0PpGqQaBLoKmX97N?=
 =?us-ascii?Q?xHt8B6XRqRZqP8NDKwX8zTsA82E68OS+mtrzDJvXD0FLuzutkGNiK8kl6mCI?=
 =?us-ascii?Q?/SVGLZJMaUuErI3zWMEOJyRzrbYz0WX2ylkImsDS+WJ6NVNY8JMscGlf9FQK?=
 =?us-ascii?Q?+tTWiIgzCtwFOKIIIVJZLEVJvVfcu0agR1O9s4X24Jq6xQCFBSvH1kDgjCl3?=
 =?us-ascii?Q?8r6IXQSu2itp1QHFYvfRJ4/pVTsnrOt9xNsK6z1+14O25p56xztntotvhC8p?=
 =?us-ascii?Q?5OSvAI7p6ZBMSlLaM3ys5ZczpBahedtv5413U3jZmUmOm4A2wcEC2PCloDTp?=
 =?us-ascii?Q?HAgAFY8tGHGruwx7KrluP+QYA5ex/3dWYSYctS6Sk20ZfRMzqS/IDJiasHlv?=
 =?us-ascii?Q?B2D3hh/dZke/0yUQff55m2D6XcgrVkTEGtEqfsw9/oqtVhLq0KzWb91Qa3+z?=
 =?us-ascii?Q?utxhi8e1LPcbvKGFi0aB7Mhwmokm4Dr7cJcZYr0vsNVl9CmHjSs6hFTOCS0x?=
 =?us-ascii?Q?kZ9izSaedSYVbX20TBFKViqnqM7j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fWx/u5appbVk27m4Nz5afaXNR2W/2frsCs2RZH5w/vJ+SQIVYKipP5vSldJc?=
 =?us-ascii?Q?gL81X9Ws0fuZ8O3h57yiQO/AzbHf4LkWfeCYnNf2AKt8Ga1WQ6O4vHmNppsv?=
 =?us-ascii?Q?RaOEq1NRm0bAMwyXowUBfEiYEAAkWm7ZRLpUEXemv22D9u0CE9A0uXD2QFCr?=
 =?us-ascii?Q?IfE3sIyVbxN48o/+rbxd/XU7jISEe4GedCFG+qsmvGf7n+M88Hlts50oRc5y?=
 =?us-ascii?Q?KqPVKDBpgRFtNCJ5eMBUgOr9rkJkQ55FWYDyeAaEHkVpBYfYT3OHeBaF3doa?=
 =?us-ascii?Q?7gG11hojSg3mwtJjzt/H+blz50Dyjs7nTXujwEtY7W4tl0vLhAs7XC1gYhdN?=
 =?us-ascii?Q?WZtCgvyQ08gHd9sVEM+bLqO6m/7Qypi0KXBuLCeNhWguPRaUEfNP8VxbTZm+?=
 =?us-ascii?Q?qxOW2oP3zP4ex4uYsaPwTQzu2j8fC82Q68zNwZSkdPEer7AuexLKHAlY3wu+?=
 =?us-ascii?Q?4evksVl88LWvBOZJllY8zAufU6ysYK9AHJlCiYsvjyJvLfRKjjoUrPTjyi4p?=
 =?us-ascii?Q?JrF8msytjVGRIxn2A4xmfawjf4llSk1ZrELyEVZTyXPdHipTd4gXtEfgiJGz?=
 =?us-ascii?Q?r5ARpquyJEY10ITu8/K7MnYHfthRIFbh+Ahfc2s4Un8s2gZiC+u0tv8aF1pu?=
 =?us-ascii?Q?OymMy1h9xX79bqJ4+Rx8Nt/O/Y9VHcZrqw06obKMK5cnQ/iFDfA1ptFMyZmH?=
 =?us-ascii?Q?8g9qUWXGB0rmy7/YbamP5nc3lGv7jAiNgtO8lFJ55BGfvobel4NGCdWO+jJO?=
 =?us-ascii?Q?z+IIm92pVgWmUEr09WV2NOwtxiJ/SQw9ZW2nl1ycntQYIDxUs9uBj42g5ac+?=
 =?us-ascii?Q?vhTAc45Ij7mw7GuxRgq+zwTcp9XvcAaQ1aV/EQAlFC/d/0dKjd33aYULC7qP?=
 =?us-ascii?Q?Fh6IsEvUSlE0/38WpdnF+nI0yD8lUdzM/N5KQ1sXGc29oxGJ7x5LGlWAPzYk?=
 =?us-ascii?Q?J64Mv5meRd3WfROHf3zb9JsAtL/dhB+kWVdWJ+WqjfY+LuKqGQ5ozSynrD8M?=
 =?us-ascii?Q?F7Z6j46C2Z++m8e6Tw+OYui5REHRrl57jCXBC+FwvAa/RDoVn+5UH2c5Hj2H?=
 =?us-ascii?Q?T8npH4u/GtA+xOXSFO/qPFY3afeD1E/az1NAlKVoxjRBh14UrPhgAgY+0mHM?=
 =?us-ascii?Q?xiIfonzddklE/NNcrxBJnjyj55jGnP0BmHzt5IB7r1GST2R/XWkKO095eHQT?=
 =?us-ascii?Q?tqP1ZRI4Slv2BvYiKPplp56Rpbd8aJKdK97CLvqnlucf0EDR64ivVbJqHmAt?=
 =?us-ascii?Q?SfCHUBlk1U/0N3emvgjKUf4gSPCAamTR2vhJ0XKsbL+0DQdQ4DOYWSYBeVvi?=
 =?us-ascii?Q?Eg59XR1DtrL+IPqzS7trec6pVDFt5MY/gbHN0hw4g73ElsaC7H8Ele+WhhSJ?=
 =?us-ascii?Q?AeYze80XyB1H+e9Hv6NA+4lDx8eDkfMve/H0JbaZL9aiuDENNNz8aMT27cSe?=
 =?us-ascii?Q?UcFg5/PRk+dxXDqaUxHf7q1g+v49OK5pL3m0hNA8ffbwe8ExEGUXDscTJ3M/?=
 =?us-ascii?Q?weMKOf8fNaYCoFQX50Avhax3jVkwGuYO40ZWNLzwsKHYHaenMRKsF+8D4Nfg?=
 =?us-ascii?Q?Vco3Nzg6+qqR5rbq018na4JloL92F29EmGRjMO1E0SRXl0Dcu8pHqSWPobTy?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79d5fa-8ca3-4889-5b9e-08dd20e92657
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:30.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cn2bOJ1dp5nb1CYb49cBWLGJpfcrB1XXdpBr4MSBV9vdo5riKMD9esHXrn70BCZ+3tarVBlVhutrmtSAakkD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16936

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add gosum fetcher to fetch dependencies via a go.sum file. The fetcher
uses the dependency mixin and supports different types:

gosum
    The fetcher uses a local go.sum file to fetch dependencies.

    SRC_URI =3D "gosum://go.sum"

gosum+https
    The fetcher downloads a go.sum file or archive with a go.sum file in
    the root folder and uses the go.sum  to fetch dependencies.

    SRC_URI =3D "gosum+http://example.com/go.sum"
    SRC_URI =3D "gosum+http://example.com/${BP}.tar.gz;striplevel=3D1;subdi=
r=3D${BP}"

gosum+git
    The fetcher checkouts a git repository with a go.sum file to fetch
    dependencies.

    SRC_URI =3D "gosum+git://example.com/${BPN}.git;protocol=3Dhttps"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py |  2 ++
 lib/bb/fetch2/gosum.py    | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 lib/bb/fetch2/gosum.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5dbc0598d..10b4cf24b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2116,6 +2116,7 @@ from . import az
 from . import crate
 from . import gcp
 from . import gomod
+from . import gosum
=20
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -2140,3 +2141,4 @@ methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
 methods.append(gomod.GoModGit())
 methods.extend(npmsw.methods)
+methods.extend(gosum.methods)
diff --git a/lib/bb/fetch2/gosum.py b/lib/bb/fetch2/gosum.py
new file mode 100644
index 000000000..001ef3304
--- /dev/null
+++ b/lib/bb/fetch2/gosum.py
@@ -0,0 +1,51 @@
+# Copyright (C) 2024-2025 Weidmueller Interface GmbH & Co. KG
+# Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
+#
+# SPDX-License-Identifier: MIT
+#
+"""
+BitBake 'Fetch' implementation for go.sum
+
+The gosum, gosum+https and gosum+git fetchers are used to download
+Go mod dependencies via a go.sum file.
+"""
+
+import os
+import bb
+import base64
+from bb.fetch2 import ParameterError
+from bb.fetch2 import URI
+from bb.fetch2.dependency import create_methods
+
+class GoSumMixin:
+    def resolve_dependencies(self, ud, localpath, d):
+        urls =3D []
+
+        def resolve_dependency(module_path, version, hash):
+            uri =3D URI(f"gomod://{module_path}")
+            if version.endswith("/go.mod"):
+                uri.params["version"] =3D version[:-7]
+                uri.params["mod"] =3D "1"
+            else:
+                uri.params["version"] =3D version
+            if hash.startswith("h1:"):
+                uri.params["h1sum"] =3D base64.b64decode(hash[3:]).hex()
+            else:
+                raise ParameterError(f"Invalid hash: {hash}", ud.url)
+            urls.append(str(uri))
+
+        if os.path.isdir(localpath):
+            localpath =3D os.path.join(localpath, "go.sum")
+        try:
+            with open(localpath, "r") as f:
+                for line in f:
+                    fields =3D line.strip().split()
+                    if len(fields) !=3D 3:
+                        raise ParameterError(f"Invalid go.sum line: {line}=
", ud.url)
+                    resolve_dependency(*fields)
+        except Exception as e:
+            raise ParameterError(f"Invalid go.sum file: {str(e)}", ud.url)
+
+        return urls
+
+methods =3D create_methods("gosum", GoSumMixin)
--=20
2.39.5


