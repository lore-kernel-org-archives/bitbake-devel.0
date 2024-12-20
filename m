Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD8E7719C
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=AKxmv8dc;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpbo+9OdTFYOeScZidyeKRQYOwcCfcK2ausTRgvJ7wBA0t5cOgactJaewfy1nDMuVfdrL9vW0aHhphYnGE3Rx557ova6DEEZmMuUf2M22vowRfTtMxDTEnUZeeUVka57mhxTkWkMwRdjxaRLNPoZUHXadXM1qZtsrRyb+MGMAqRSiXYy9t0RXiqh40+pvxDKEhhe15rDdZQI9nCGffNSiOQeSuR0afR2/zN8rkfT0hQOo4DbRcbF/l2uwiSAeQ/OduM6Vb+7NByfwc3lvilx01qbkJ8NYHAKMUKbf1z1sEawk4WsexL8v5XoqUyDfueQdaAny8b81e30Ubf8G+jXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjSgsCSlyuNISja8yjNqfAPuN8YK7Pt60PQplva+QQo=;
 b=qyXHLQ9haR/fziAH/YFSKgsSije6Xrs2zgDpOdVi9tnt5+rDJEdR6OLUr1pud7PopWDeW2rpDvJAGcITd9h2fH7YQKfjq33jyJ9J9MG26dowjBmXIB+mIZ970hGgT80EV0cDLOsZr/4U+HEz24rcmrhdmz5cXDKyKXjb5ywD06d5AwX8JPZfpzUDPZTTzkpXm9788Odw1hncrgkEm6zPpqqsq+OpRRo6gjB2Qb8msSuAGJrYKqO5U91TtTKoUiquKvJRX9gM6u6IanZz0XDiZEHOIaSZPggDtVdyLZHnfJP1QFV1sPto7dzaP5IIO2MwdPsvIQiGc3Nd5WQv9XslSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjSgsCSlyuNISja8yjNqfAPuN8YK7Pt60PQplva+QQo=;
 b=AKxmv8dcu9kK1gf19ivna63jBxg4vDRiUul5lrF+9fo8/762evRIeSWLEiN2roTART18t9OpnlgmgdQ+PWeR1Ww2EJy+totYrDU0zK9k8V3C5kdzyENjPVxhO7YeSu0sfZpf6KlmlDR32Iz7F898+Vf/yMSmiyKILNVshWcIA7kFPyQtyI23zgaO+EFAoIbsPwmmyEO5YO9nRkszbBzd8hHWwgi6jVn/CcSrnMRb4BKL3PlY/3kM478Ll44VCUNHQ3z1pnyWlnzFc2w+5E+9tbUPcyGudTB9pBEzSLPJDzrYE52mOOMoVzd73dKob+MvGqupQT67apkKsXSw7Psvwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:32 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:32 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 20/21] fetch: add cargolock fetcher
Date: Fri, 20 Dec 2024 12:26:11 +0100
Message-ID: <20241220112613.22647-21-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ab7e62b-08dd-43d7-91a2-08dd20e926b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tooRTjcqnbPpKhG7Kdt7LS0BVAS41kC+mFIs2SZxLwsN6EbhA2bh9msfF78y?=
 =?us-ascii?Q?iF2PjjmEL56y/aCsjlfdHtdzAjSTGdDoFWE/W+G0N3SfFGCeAuC+wGXKuD1Z?=
 =?us-ascii?Q?f2674/1CiZTAVrJuKjCn22KuPspoP03nKZ+XQiKGks6up7rDdQDVlYmDWPlk?=
 =?us-ascii?Q?xnJkwJk/y97TYsg6V9Xl5Vq6EhthaGQ1sRsNHA+Cl/oRViwzoLWKwEEGCBZg?=
 =?us-ascii?Q?ZWbAjnjpSYrYY5opTlZN+p1JBMv+Fy5EzRGYHMrR2/fLXH8LNfm4JcMNpwgO?=
 =?us-ascii?Q?rj6vPG0SWBEl6LgHkJOYu6taKxNUc3x5ldCAt26Mc0wWHsWqPcUaJAb7NpTA?=
 =?us-ascii?Q?l2wcXrILvGnIktvVpbUDclfoa2jNh7OGXj7nLOS6d+RJMV3P+mRvl3E2I/8W?=
 =?us-ascii?Q?JKbhEJyeOz9xSuKzrxrHWy65ePiik89sT2+Ks+4/+Qhw+PyEg0HtutPMgLCc?=
 =?us-ascii?Q?HKsS2rUc22oimoRSV4pAHfVdlCxeoVYxGb43FQSRt2p5QyzwgTnNBzyrtGkk?=
 =?us-ascii?Q?MOb5uD1xX9hF31TbGkraRSD+8QjSLXd2IAlGeZrtBKAhDW/XP8FlwgStftsV?=
 =?us-ascii?Q?Xh7uP71TU5gy8ochtwSmspdZu9f6rm64C406cEeR+xZKRoU5o9N8E/ThrC/r?=
 =?us-ascii?Q?3397WXmgL6KvDwVGMhe8OFT50YrYpN2SaxHoH1sFQVvoKExwmgr3oxDWM+C3?=
 =?us-ascii?Q?g/0Jb5/5vlMvycz3OO20wrJr4MtAkw/VrQnVeez6SHCa6/Jxv+Z12OYGPA/t?=
 =?us-ascii?Q?1yhSxM69WHuUatyw+S2fJPcmlx3ZfvAHbnqVoGXelQU+dMW1WknSYoy2JQ1h?=
 =?us-ascii?Q?N34DinLdMLHi36e3NnDIEQ7k84O+e+RSZZoUg2IABy14sScdgk25PNZK5/Rg?=
 =?us-ascii?Q?YYZRVIe4TjWPFAs95Mc81TD0W8XOWye1+WNwBEhh7p1qNFLNXKCMvztS3ksR?=
 =?us-ascii?Q?/qt8X1HN5uTnI3Sq7IOkGL2lFGDW1HpEo5ETFntWrYMBVDkQRdh8uWepHHsH?=
 =?us-ascii?Q?dEcPcQtuF8wTx43awE6/Ducxn1w29PztbNCv3DPFdirAKPeFyO5Zf9Yxrvw+?=
 =?us-ascii?Q?Eimrad4TLbiGZuKBRaBydy6zmTef8cM3/XDNxz1SCOe89giGCVPwqPrMipWU?=
 =?us-ascii?Q?ht6WkTjQOGRWfeYqi9okGS71NGRphHz8F48TTbZ2dz+ri34X+ft102h1vcK6?=
 =?us-ascii?Q?DL1bjb90W1R7qU9mNhZ4cXXdPe3yRRCabTJ+094R/gXT8wdziW4eN7zmoGKz?=
 =?us-ascii?Q?JI1IttuyH8bVFLrg6m19gXsV/Gcoh8pUbzMnNfvC4M9j37N5JCcdnvD7K2VU?=
 =?us-ascii?Q?McN/eeaitIKyWIIePbKwPGlxofDlZRB0EF62HqvILoS2KD35Q4EVBw36948N?=
 =?us-ascii?Q?tg0klHeACirolTfoC6r6fVc1X6Js?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pBbFdU1KMnAY3A3rYZYG5NhGXhS5R5zOOi6nDN5baNGJ57/h8C1yF94kHWLs?=
 =?us-ascii?Q?z/DRuVtaw4eAZdf59R5RNyXxsLNV/EOP0xs9UCss4RHYSYmM7waqoauUuRYR?=
 =?us-ascii?Q?fbeb7jBKuqUv1AeJ/YkSQdM5I6XzktO7Sux7HM85wLXV+2xdpd8WtVjsdNIT?=
 =?us-ascii?Q?U3h/HJRHdTvmSkmdiAJjoSWtJU14rYvJe5fRK1mZK8KvI2MkWmJUwNoelyjN?=
 =?us-ascii?Q?AgNbunShrPWFUdd5IOlH4QztgbDNmQfaXOB2M8VJ76FsJlNHS5rOLMYPu2fh?=
 =?us-ascii?Q?6ahcD+EdFrvQFrSTU/Gbj2mPaY7i0i+pwHJ9xHACnWGmn3rorSOuCZwP0HTL?=
 =?us-ascii?Q?YFpSSyo9X0r1A2cteKvPA8hsBQfOWx1ZwnV9re8AlG17oc+6SB98zwIjfnpk?=
 =?us-ascii?Q?GRbULjgB1OO3fDDV+hftEG7W5pt3yJb1rMwYeYsLoYhGWoAmYReZSeUKqjBU?=
 =?us-ascii?Q?2PhX9pWHAvNtAmDHmlavf3kHGX7O0RoxD5WHi7Fhc/s5+ssRnag4ttMVnefZ?=
 =?us-ascii?Q?Uph6HBgronU1Pa2cl6RTkeZZuUT5jqAQ+ufyknae7T89SK+UebLNYECFLFlw?=
 =?us-ascii?Q?zMXrtbI1AFFJtluj70oAqq4kFmOqUTL8rs8bvaE4aKzIbklh1CUFy2InhZIt?=
 =?us-ascii?Q?jG2miavAxu+0fARHMfQDVVIJTJsWkfoDFdhR1087aELRc8CZA1jZR8aUXuZF?=
 =?us-ascii?Q?tU4A/XFMqopUivDIY0Wn2ev4ouzAoeNJEUTsyxVLsjh8dlt4/Gq6H9lla4dF?=
 =?us-ascii?Q?zVJRjM9lCUpaucQz33PTnNIG1uxpuTZ23tLkP800Echd3kGMiJD1d7AbqP3X?=
 =?us-ascii?Q?PwxQPr4G0p3125LEZhbgW+v2MkInBwKUnqEqtwudMUp7+FKv3PvAkOHOYCAr?=
 =?us-ascii?Q?mJRpaWQHLtD/r+1KK9QnoU+kp7J9vFFnjeDqrYkafSZfF1FptDiU82Ow+i6X?=
 =?us-ascii?Q?uiSVy0X+jJ8e1TIS0kqaHo+poTbfDFANV136396/LSxKJ1e9eAZitn7XUKDN?=
 =?us-ascii?Q?Sd4Z4R43HQx+ZiFI0zv0iSzdgJ0AoRas3GkgpJtkXiZX2+6jC0/rr0kEGPMz?=
 =?us-ascii?Q?S5pAiKsgmrKiT8mmnrveokQBhsZMWp1qx2KCPrlgI1fVVYJmDP6P1dftsjMG?=
 =?us-ascii?Q?WTOrHHNegGVOImJ9TkgrHVQQgCWK9KX7oW+bQeR2bgA1k9W5PxfuDXrz+XCh?=
 =?us-ascii?Q?KlgabsjYXVrYMir/pjNuqhTvOdr52YPGLlUQ1awgI92UhA9+TN4XP3Z7Z4gx?=
 =?us-ascii?Q?aQQP23ns0mxeSdPofGK3F/QNkZHwk6va3SXZKWADhegUQVALFDOg0VHa3r2H?=
 =?us-ascii?Q?mUyHK4x4ENYKbwL39UK+TiZUuL0CKHlHfyMHkQBjgaOyE6m1Y0SmKOt8OPWi?=
 =?us-ascii?Q?DU+kfF2aVd+pVeRr0J+5c+NAVBlEaV/i0kbTesQxG0qeaAcVXx6603p3qUpc?=
 =?us-ascii?Q?HM8hiyEpjx16Kw2ZYqAmkeXcLwzb/R4AKTMhJHpuzVl5JK0pN+IIBSP0yQom?=
 =?us-ascii?Q?8toN5Ff/UqcRtDCyPMc+R3dEAjokvpunMgjICrr9jPvZDWFrFaK4s2e4AHFy?=
 =?us-ascii?Q?D7xfdeHrm5qRl5ilTyyWP7kTSLZAKFcsrkNM6jwukzIXxJkFTFa7W863W3hw?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab7e62b-08dd-43d7-91a2-08dd20e926b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:30.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijLJ4AZ7EfxWW3iz4wqjo+/hltuP4XC2aLKlF1s1j23jx+ZEkO4LLwRJA6bp8e1K+ZRG9ebOqfH0wZMxilqrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16940

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add cargolock fetcher to fetch dependencies via a cargo.lock file. The
fetcher uses the dependency mixin and supports different types:

cargolock
    The fetcher uses a local cargo.lock file to fetch dependencies.

    SRC_URI =3D "cargolock://cargo.lock"

cargolock+https
    The fetcher downloads a cargo.lock file or archive with a cargo.lock
    file in the root folder and uses the cargo.lock file to fetch
    dependencies.

    SRC_URI =3D "cargolock+http://example.com/cargo.lock"
    SRC_URI =3D "cargolock+http://example.com/${BP}.tar.gz;striplevel=3D1;s=
ubdir=3D${BP}"

cargolock+git
    The fetcher checkouts a git repository with a cargo.lock file to
    fetch dependencies.

    SRC_URI =3D "cargolock+git://example.com/${BPN}.git;protocol=3Dhttps"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py  |  2 ++
 lib/bb/fetch2/cargolock.py | 73 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 lib/bb/fetch2/cargolock.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 10b4cf24b..012130ac6 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2117,6 +2117,7 @@ from . import crate
 from . import gcp
 from . import gomod
 from . import gosum
+from . import cargolock
=20
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -2142,3 +2143,4 @@ methods.append(gomod.GoMod())
 methods.append(gomod.GoModGit())
 methods.extend(npmsw.methods)
 methods.extend(gosum.methods)
+methods.extend(cargolock.methods)
diff --git a/lib/bb/fetch2/cargolock.py b/lib/bb/fetch2/cargolock.py
new file mode 100644
index 000000000..18df160ed
--- /dev/null
+++ b/lib/bb/fetch2/cargolock.py
@@ -0,0 +1,73 @@
+# Copyright (C) 2024-2025 Weidmueller Interface GmbH & Co. KG
+# Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
+#
+# SPDX-License-Identifier: MIT
+#
+"""
+BitBake 'Fetch' implementation for cargo.lock
+
+The cargolock, cargolock+https and cargolock+git fetchers are used to down=
load
+Cargo dependencies via a cargo.lock file.
+"""
+
+import os
+import tomllib
+import bb
+from bb.fetch2 import ParameterError
+from bb.fetch2 import URI
+from bb.fetch2.dependency import create_methods
+
+class CargoLockMixin:
+    def resolve_dependencies(self, ud, localpath, d):
+        if os.path.isdir(localpath):
+            localpath =3D os.path.join(localpath, "Cargo.lock")
+        try:
+            with open(localpath, "rb") as f:
+                crates =3D tomllib.load(f)
+        except Exception as e:
+            raise ParameterError("Invalid Cargo lock file: %s" % str(e), u=
d.url)
+
+        urls =3D []
+        for crate in crates.get("package", []):
+            name =3D  crate.get('name')
+            version =3D crate.get('version')
+            source =3D crate.get("source")
+           =20
+            if not source:
+                continue
+
+            if source.startswith("registry"):
+                uri =3D URI(source[9:])
+                if (uri.scheme =3D=3D "https" and uri.hostname =3D=3D "git=
hub.com"
+                        and uri.path =3D=3D "/rust-lang/crates.io-index"):
+                    uri.scheme =3D "crate"
+                    uri.hostname =3D "crates.io"
+                    uri.path =3D f"/{name}/{version}"
+                    uri.params["dn"] =3D name
+                    uri.params["dv"] =3D version
+                else:
+                    bb.warn(f"Please add support for the url to crate fetc=
her: {source}")
+                    uri.params["subdir"] =3D os.path.join("cargo_home", "b=
itbake")
+                uri.params["sha256sum"] =3D crate.get('checksum')
+                url =3D str(uri)
+
+            elif source.startswith("git"):
+                url, _, rev =3D source.partition("#")
+                uri =3D URI(url)
+                scheme, _, protocol =3D uri.scheme.partition("+")
+                if protocol:
+                    uri.params["protocol"] =3D protocol
+                    uri.scheme =3D scheme
+                uri.params["rev"] =3D rev
+                uri.params["nobranch"] =3D "1"
+                uri.params["destsuffix"] =3D f"{name}-{version}"
+                uri.params["subdir"] =3D os.path.join("cargo_home", "bitba=
ke")
+                url =3D str(uri)
+            else:
+                raise ParameterError(f"Unsupported dependency: {name}", ud=
.url)
+
+            urls.append(url)
+
+        return urls
+
+methods =3D create_methods("cargolock", CargoLockMixin)
--=20
2.39.5


