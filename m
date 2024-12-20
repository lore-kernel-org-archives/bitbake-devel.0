Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516AEE7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=VO5ow6Ql;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOc4Uii8RJ7gwMAeVZU0jcdv83q2Pa3Ba9imBH75HKpk7zr2uSy/F9xyupEVMoih8uCSdy+9in+Q4k5HrWISsstSUBYgXuGd/3gW1XFX7IXS7wZKC9rXJDw2gG/rtgPVrMSL7hZ3PeFFjXWxx8/bhEElL9LgJR2u/auqrD0SVPZzms1ULBetyNNTLcolgb2ru8GDgru1MJlPCbMyGrVDn0aw+kmWUudO/6dHc+BFn/xFHZZoDSWKOEAP0AfAedJuZEVAUT2tnfPNmuJcKRiFyYBjWtNpyeQlf3YBcMCGcAD1p+bk2IH4s70Qn8avMXQpz/GYjrAT/dfulZASLHMzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUnEYLBpnFS6KFFX+hiKjOr98Rh4ZfH9Nvm05jFPbj4=;
 b=V/Fq/Nv77HZgipuacnOJIeF9yCE40J7khw8XzjacL0z565rGR+FvIQ24//Ev5dH4JhgU1x0pwNGccmbZpuimW4Jx3Zmelp1Y8iaDfLWUH/owkuI50kP1AKFa3ZY/WriWdg/Ru9EqfZjRhCTLzpDjcXZScDMT/uvZQrQx/IPzqdtx03yFsmEClJFh2CWuooUHQLBW0qU8ydPNCnsYj7xSpNuFAEUFqBM6TvWDqEtWX1P9hxkY+Qw5KGZ/B2ldHDf/TcogXKHzVadEHzcbSHg8oxG0B8aHJdG2Shrprhi4Xcq5XJIyZDyjDpR1Ayxv0GbSyVuxhjkUqhscGrLrozkrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUnEYLBpnFS6KFFX+hiKjOr98Rh4ZfH9Nvm05jFPbj4=;
 b=VO5ow6QlI8FcMDXD3ZFfPSRBWr3Q8MtR0JNCUYdo2iEHRO39hnd3gTOzfWUJkO2P9zexswyivWwgV+urzqLNVJwhMhgGD5K4+X7xfCFB/pLK8zxdx2QHF+UCXVvXxEFt+Xtl/NeztV5kMsoq1R/NczEqUvwCUSHOkFioJmnpIE/mSMAE4OfVEyVZwhF3duZOKiJ39omXbyCpCxGmW6iiv6SL8rKjwmfHPKTFVp8vBw+OKlm5EhF48xiMkWCFojaFzX5q5KVji0+KSi3Cmg5T5FGfPyEAOLsU6d/by1SOtg7aMqSJ9Rj1Ujfh0AXdhjllKLoMSQSu/SMKnMjAnLp8Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:27 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:27 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 10/21] fetch: npm: rework
Date: Fri, 20 Dec 2024 12:26:01 +0100
Message-ID: <20241220112613.22647-11-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c27570-ec4a-4cfc-6699-08dd20e924c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tsm+zvu1Wrq9wXmFWkb+2zmr8EqMIfc8j6Gdni6GLExrJl+Bi15BqL4eVCKR?=
 =?us-ascii?Q?j9rHsMFQ7nfwFMviHq+yXd6fn044Ga8Sxz+d0fhmFRQengkqZrWaEVGUC1lc?=
 =?us-ascii?Q?hzRWIafSqDqEEZFFu6yQC+NCMLtmKww/Xl5Dj8J+TSN0Y5x2kE40niSIxvOu?=
 =?us-ascii?Q?Vu9XvLNzVRWS6QIZvwQrqtYN3grBEOocFKTQH3WlwkEhb2f8OrMV7y7J3peT?=
 =?us-ascii?Q?KyE+zXZsTVTLb2TZcMj+nez3hO40CLxLWFQzBeqI/UrPjzD3bI6gmRpsDcPa?=
 =?us-ascii?Q?p3jCQpMdauGzwKWUkXyh8BuTBmVERn6d6/8oASGEfB1cm2gx+b2yN0fhQb/9?=
 =?us-ascii?Q?Mq/6umpkfZbY6ohwPrfw1RcUFn/p8FCQonK8oronNQysMVyF7p3xb4tkeKMr?=
 =?us-ascii?Q?L6A9CQchOdKBFb6ad8c4ehOv7bcCOj8WSoPmENf2T54BTNc4ArE8S7AwBCl7?=
 =?us-ascii?Q?5s9M+rLrjAOlW3ewEAwpJif/osYG1ZI88zI7DnStKJR6ni/FEPAkRSvIW2uz?=
 =?us-ascii?Q?XvPwMI421F9syzTJy1LWii/yl1DlMWAb+H4RHt33d0AxIGRtTLT+l0G1bQea?=
 =?us-ascii?Q?F/kqYz/pwEfTq2sYkJ6fbKJv8TNUv4lTchWtWjHNkAHcaCSNw4xXWqtco5xv?=
 =?us-ascii?Q?1xOvzXKGLA5LPofiVee+wxAsH9oa3a4MRmJOQMSeWWWN6xnXwC3QtAYBRAs1?=
 =?us-ascii?Q?Ws/QxWLPNgCM7LD3sEiCK9wdpGs3ZWsxCeYHkWtXpK6Ywk6i5C/vDDg6uST5?=
 =?us-ascii?Q?ffWsXIQni3QcbvmFmrHtvlmMmaPWv0tAK2uQ2vRb6VOLwWI8qpvHkJ/uoRDw?=
 =?us-ascii?Q?nYO5t/rGjENX2flrZ8OiNttsl7mvxMx8wwzl8QumtUDz73OvtyUbgNeCjfWB?=
 =?us-ascii?Q?VHLLSRbpMYSUNpTcpj46sf9xx1LH/jfHFA/+7izbgQdTfmkT4jgBWcln4D+J?=
 =?us-ascii?Q?LeeVps0Coi1EBz8DeJPt+6IdPxpjelIaTdKe2UFdAjz3JwpoN7qf8bnWgsck?=
 =?us-ascii?Q?RAn7/9rnQ+318QT3TcAlUNQqR0fLIlB2hfUv2hZAxshkhGgQdCOC5WBLqsw6?=
 =?us-ascii?Q?+adm3qzE/JaPMbhnt2ChdBehugLhlBUqhs4/WJH4XlMJrF6vZYDEhaJk73Wr?=
 =?us-ascii?Q?GdkcrETfIRroOD4+MozCRRJ8kwCj8aePH9FQa7m28p4k8aBXdb91qptQ5NWz?=
 =?us-ascii?Q?4tX4nu8lSB03WCLtZAaWlUjbZ2HRzZomH9gwGJV9hhGJNfbHJPd6o/nIFW8R?=
 =?us-ascii?Q?ojxA2HA/B0xfFMWtyr0HIgAxxEIPeWFQFdKZl2XpaYj/zaxmqGOWKSaIkEfD?=
 =?us-ascii?Q?G9RkNm0pBelrSiZQ487V+7b/B0iCuaoly6RtZMGN1nnb8jI+fPOERicowX3C?=
 =?us-ascii?Q?hqePDmRRN7FglHlRmhuBLeZuxJUpMhZ6Pi0ZLcg4P6UXR6JrZw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I7GVUc5oZEAYKcbvAUPhpb+ipCwUiD+rxjxHjEuIo1YYPyJH/4QP/qDtv0EL?=
 =?us-ascii?Q?/LGpSD11nH1gxZSZyj4HBYo6HC8na8rrcCW6b6citvaV9+SCF0igCl+24IQb?=
 =?us-ascii?Q?7lpXqATry2DIBgoPOSXOGncJhKqCsET40Es53qVeQedLTOVeiFb40w6ov53A?=
 =?us-ascii?Q?9IjHDildOs06Dq8X/DkL9tqYntglYMWIXval9lqwd21ccrFog0Nixn6kbcr7?=
 =?us-ascii?Q?hSTvMU7L9IuoVX7Vl9me2vuyv//R0LnO6EHTGhecjfydSnxHTqbPp2hq48Rr?=
 =?us-ascii?Q?jCnqcvtBXFvBDY/sp46vubClJrMpXwpmaTT5/gTgeRslXDkNn3jnlIcDMVh8?=
 =?us-ascii?Q?ZbdbXoCBvLD9Kf5zXZXpuSmDU4bqWdahtZ9hDwuJ3Ge7AOKI+DCY2PE+QSbR?=
 =?us-ascii?Q?FG3qKocDR5sGmmWiIFZvydNBdFm7gejUy3qJvVdrhumoaqDefOlWlVDX0Pdc?=
 =?us-ascii?Q?hioDX0vaHL1rFVqh0xoaV5sJiPM8j3cMeuIE6hrZtVH+wWo8uGGIHX2ofvqf?=
 =?us-ascii?Q?LH73+smmsThzY3m5nBHvamYA/L7Na3oKknordrZ5RpjfggmMejwfz7ucRRKa?=
 =?us-ascii?Q?iP4SrvtD/aVZQm4uihRbrKQSWsWacuIDvyFQSdcxkD8uVH6cAFO5e6HFZoBk?=
 =?us-ascii?Q?uFICItVqe/GM50UVT9tOYlFQTEMwaxqHBrtRHj3PNI1FAqqfE59iiNcpsa3V?=
 =?us-ascii?Q?KprWjabo8ctMWzy0b234nASvTD64piDdV3P0z/FEe3tKdFp8Fj+8bLis5Qmg?=
 =?us-ascii?Q?+07Vu1Bz6btUlxyEf02abNWC1BSNxxlhmCSjXWdpQB9bNdaGZs1qAAq+svwN?=
 =?us-ascii?Q?UQYqsc7g4/8779Lat8xSDnpsqhGBJSA/jtEOjz3b98Dae/eqNYDzu6BsnGQs?=
 =?us-ascii?Q?wo25Earf79EjWpNuhAocoE5ID3hc2ELk5ECpxpk8+bLARl9xAYzqr3PInoFI?=
 =?us-ascii?Q?fClh3n1KNF6xuE0TgRK+98bOwpREte+QKu0SZ1MYet9bEU84EfpH/DA7Z5Wo?=
 =?us-ascii?Q?vBl4h62BRKpWEyrLgpd7YZRX9pAJLwRoLE1Xjr+xqKzJPQt5GadW9GcBhDim?=
 =?us-ascii?Q?5UcY84VyvfKGElDSz2qRZvZPHDYJNP8s5xP2nIwU3WSK2RmYjdo8e+i9hgcJ?=
 =?us-ascii?Q?LYQb36D6I/96nmxs9g3N83FKyWsFrmNXRQS0gaGeoUlPJkxgYOM7/IkymB+q?=
 =?us-ascii?Q?0wgA8esgYUeMaQ+jcdwNNG7+Mot9RMDAE7VROGJubupaQDZIW7v89Llbquw3?=
 =?us-ascii?Q?U9fvP3KtEFhz02P5xpH0GWyScqodJw09UDDqig2+BMiWIhNolO+Hny6VCffa?=
 =?us-ascii?Q?16cPbDU9CFw6qLJP3cEz+rv9TDovix0DmMEEepkgx+kmNOOvOo8Pv9q8nb8h?=
 =?us-ascii?Q?qlJ9e9NLiQd5FOZTn6yCT439fppU3bQX3SQe9oo5rwKXt3Lv02Hn6VZgQg7P?=
 =?us-ascii?Q?lsLzBqD1RJK9EGVik/y9FkxqLVvB8jByQVOKEUGMmzSvzvhIwuDGPo2HoZGu?=
 =?us-ascii?Q?2iHevzPE4sSc60lzXE4eF52ZvPJjOXncNuUGrNwExwh3NhfDdZtq/xzJwKIj?=
 =?us-ascii?Q?5isaInpxo0u6zqxZiMnZHzw1wWQiaTFXP7FKkhNxkLqCWlAWRJU0PO4he8Dx?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c27570-ec4a-4cfc-6699-08dd20e924c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:27.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W69tXbIjo2br34uvBslC5qI/yn48+WzEaUXidBjvbH07vNdq3Qd0NnQoiAGuIheursbaU4iKyozO0KjjZ51OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16932

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Rework the npm class regarding testability and integrity:
* Remove dependency to npm binary.
* Construct URL via a fix style and don=E2=80=99t resolve the URL via packa=
ge
  registry.
* Use the checksum from the recipe or URI and don=E2=80=99t depend on the
  checksum from the package registry.
* Add common name and version schema.
* Mark unused NpmEnvironment and npm_unpack function as deprecated.
* Use Wget class as base and remove foreign done stamp handling.
* Add support to compute the latest release version.
* Remove support for latest version because it requires a package
  registry and should be rarely used.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npm.py | 244 +++++++++++--------------------------------
 1 file changed, 63 insertions(+), 181 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ac76d64cd..120dddbfd 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -10,20 +10,19 @@ SRC_URI =3D "npm://some.registry.url;OptionA=3Dxxx;Opti=
onB=3Dxxx;..."
=20
 Supported SRC_URI options are:
=20
-- package
+- dn
    The npm package name. This is a mandatory parameter.
=20
-- version
+- dv
     The npm package version. This is a mandatory parameter.
=20
 - downloadfilename
     Specifies the filename used when storing the downloaded file.
=20
 - destsuffix
-    Specifies the directory to use to unpack the package (default: npm).
+    The name of the path in which to place the package (default: npm).
 """
=20
-import base64
 import json
 import os
 import re
@@ -40,6 +39,8 @@ from bb.fetch2 import check_network_access
 from bb.fetch2 import runfetchcmd
 from bb.utils import is_semver
=20
+from bb.fetch2.wget import Wget
+
 def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
     # For scoped package names ('@user/package') the '/' is replaced by a =
'-'.
@@ -64,14 +65,7 @@ def npm_localfile(package, version=3DNone):
         filename =3D package
     return os.path.join("npm2", filename)
=20
-def npm_integrity(integrity):
-    """
-    Get the checksum name and expected value from the subresource integrit=
y
-        https://www.w3.org/TR/SRI/
-    """
-    algo, value =3D integrity.split("-", maxsplit=3D1)
-    return "%ssum" % algo, base64.b64decode(value).hex()
-
+# Deprecated
 def npm_unpack(tarball, destdir, d):
     """Unpack a npm tarball"""
     bb.utils.mkdirhier(destdir)
@@ -80,8 +74,8 @@ def npm_unpack(tarball, destdir, d):
     cmd +=3D " --delay-directory-restore"
     cmd +=3D " --strip-components=3D1"
     runfetchcmd(cmd, d, workdir=3Ddestdir)
-    runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=3DTrue, workdir=
=3Ddestdir)
=20
+# Deprecated
 class NpmEnvironment(object):
     """
     Using a npm config file seems more reliable than using cli arguments.
@@ -130,7 +124,15 @@ class NpmEnvironment(object):
=20
             return _run(cmd)
=20
-class Npm(FetchMethod):
+
+def construct_url_path(name, version):
+    return f"/{name}/-/{name.split('/')[-1]}-{version}.tgz"
+
+def construct_url(registry, name, version):
+    path =3D construct_url_path(name, version)
+    return f"https://{registry}{path}"
+
+class Npm(Wget):
     """Class to fetch a package from a npm registry"""
=20
     def supports(self, ud, d):
@@ -139,178 +141,58 @@ class Npm(FetchMethod):
=20
     def urldata_init(self, ud, d):
         """Init npm specific variables within url data"""
-        ud.package =3D None
-        ud.version =3D None
-        ud.registry =3D None
=20
-        # Get the 'package' parameter
         if "package" in ud.parm:
-            ud.package =3D ud.parm.get("package")
+            bb.warn(f"Parameter 'package' in '{ud.url}' is deprecated."
+                    "Please use 'dn' parameter instead.")
+            ud.parm["dn"] =3D ud.parm["package"]
+            del ud.parm["package"]
+        if "version" in ud.parm:
+            bb.warn(f"Parameter 'version' in '{ud.url}' is deprecated."
+                    "Please use 'dv' parameter instead.")
+            ud.parm["dv"] =3D ud.parm["version"]
+            del ud.parm["version"]
+
+        if any(x not in ud.parm for x in ["dn", "dv"]):
+            return
+
+        registry =3D ud.host
+        if ud.path !=3D '/':
+            registry +=3D ud.path
+        name =3D ud.parm["dn"]
+        version =3D ud.parm["dv"]
+
+        if not is_semver(version):
+            if version =3D=3D "latest":
+                raise ParameterError("Value 'latest' for parameter 'versio=
n' is no longer supported", ud.url)
+            else:
+                raise ParameterError("Invalid 'version' parameter", ud.url=
)
=20
-        if not ud.package:
-            raise MissingParameterError("Parameter 'package' required", ud=
.url)
+        ud.url =3D construct_url(registry, name, version)
+        ud.info_url =3D f"https://{registry}/{name}"
=20
-        # Get the 'version' parameter
-        if "version" in ud.parm:
-            ud.version =3D ud.parm.get("version")
+        if not "downloadfilename" in ud.parm:
+            ud.parm['downloadfilename'] =3D npm_localfile(name, version)
=20
-        if not ud.version:
-            raise MissingParameterError("Parameter 'version' required", ud=
.url)
+        destsuffix =3D ud.parm.get("destsuffix", "npm")
+        subdir =3D ud.parm.get("subdir", "")
+        ud.parm["destsuffix"] =3D destsuffix
+        ud.parm["subdir"] =3D os.path.join(subdir, destsuffix)
=20
-        if not is_semver(ud.version) and not ud.version =3D=3D "latest":
-            raise ParameterError("Invalid 'version' parameter", ud.url)
+        if 'name' not in ud.parm:
+            ud.parm["name"] =3D f"{npm_package(name)}-{version}"
=20
-        # Extract the 'registry' part of the url
-        ud.registry =3D re.sub(r"^npm://", "https://", ud.url.split(";")[0=
])
+        ud.parm["striplevel"] =3D 1
=20
-        # Using the 'downloadfilename' parameter as local filename
-        # or the npm package name.
-        if "downloadfilename" in ud.parm:
-            ud.localfile =3D npm_localfile(d.expand(ud.parm["downloadfilen=
ame"]))
-        else:
-            ud.localfile =3D npm_localfile(ud.package, ud.version)
-
-        # Get the base 'npm' command
-        ud.basecmd =3D d.getVar("FETCHCMD_npm") or "npm"
-
-        # This fetcher resolves a URI from a npm package name and version =
and
-        # then forwards it to a proxy fetcher. A resolve file containing t=
he
-        # resolved URI is created to avoid unwanted network access (if the=
 file
-        # already exists). The management of the donestamp file, the lockf=
ile
-        # and the checksums are forwarded to the proxy fetcher.
-        ud.proxy =3D None
-        ud.needdonestamp =3D False
-        ud.resolvefile =3D self.localpath(ud, d) + ".resolved"
-
-    def _resolve_proxy_url(self, ud, d):
-        def _npm_view():
-            args =3D []
-            args.append(("json", "true"))
-            args.append(("registry", ud.registry))
-            pkgver =3D shlex.quote(ud.package + "@" + ud.version)
-            cmd =3D ud.basecmd + " view %s" % pkgver
-            env =3D NpmEnvironment(d)
-            check_network_access(d, cmd, ud.registry)
-            view_string =3D env.run(cmd, args=3Dargs)
-
-            if not view_string:
-                raise FetchError("Unavailable package %s" % pkgver, ud.url=
)
-
-            try:
-                view =3D json.loads(view_string)
-
-                error =3D view.get("error")
-                if error is not None:
-                    raise FetchError(error.get("summary"), ud.url)
-
-                if ud.version =3D=3D "latest":
-                    bb.warn("The npm package %s is using the latest " \
-                            "version available. This could lead to " \
-                            "non-reproducible builds." % pkgver)
-                elif ud.version !=3D view.get("version"):
-                    raise ParameterError("Invalid 'version' parameter", ud=
.url)
-
-                return view
-
-            except Exception as e:
-                raise FetchError("Invalid view from npm: %s" % str(e), ud.=
url)
-
-        def _get_url(view):
-            tarball_url =3D view.get("dist", {}).get("tarball")
-
-            if tarball_url is None:
-                raise FetchError("Invalid 'dist.tarball' in view", ud.url)
-
-            uri =3D URI(tarball_url)
-            uri.params["downloadfilename"] =3D ud.localfile
-
-            integrity =3D view.get("dist", {}).get("integrity")
-            shasum =3D view.get("dist", {}).get("shasum")
-
-            if integrity is not None:
-                checksum_name, checksum_expected =3D npm_integrity(integri=
ty)
-                uri.params[checksum_name] =3D checksum_expected
-            elif shasum is not None:
-                uri.params["sha1sum"] =3D shasum
-            else:
-                raise FetchError("Invalid 'dist.integrity' in view", ud.ur=
l)
-
-            return str(uri)
-
-        url =3D _get_url(_npm_view())
-
-        bb.utils.mkdirhier(os.path.dirname(ud.resolvefile))
-        with open(ud.resolvefile, "w") as f:
-            f.write(url)
-
-    def _setup_proxy(self, ud, d):
-        if ud.proxy is None:
-            if not os.path.exists(ud.resolvefile):
-                self._resolve_proxy_url(ud, d)
-
-            with open(ud.resolvefile, "r") as f:
-                url =3D f.read()
-
-            # Avoid conflicts between the environment data and:
-            # - the proxy url checksum
-            data =3D bb.data.createCopy(d)
-            data.delVarFlags("SRC_URI")
-            ud.proxy =3D Fetch([url], data)
-
-    def _get_proxy_method(self, ud, d):
-        self._setup_proxy(ud, d)
-        proxy_url =3D ud.proxy.urls[0]
-        proxy_ud =3D ud.proxy.ud[proxy_url]
-        proxy_d =3D ud.proxy.d
-        proxy_ud.setup_localpath(proxy_d)
-        return proxy_ud.method, proxy_ud, proxy_d
-
-    def verify_donestamp(self, ud, d):
-        """Verify the donestamp file"""
-        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
-        return proxy_m.verify_donestamp(proxy_ud, proxy_d)
-
-    def update_donestamp(self, ud, d):
-        """Update the donestamp file"""
-        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
-        proxy_m.update_donestamp(proxy_ud, proxy_d)
-
-    def need_update(self, ud, d):
-        """Force a fetch, even if localpath exists ?"""
-        if not os.path.exists(ud.resolvefile):
-            return True
-        if ud.version =3D=3D "latest":
-            return True
-        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
-        return proxy_m.need_update(proxy_ud, proxy_d)
-
-    def try_mirrors(self, fetch, ud, d, mirrors):
-        """Try to use a mirror"""
-        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
-        return proxy_m.try_mirrors(fetch, proxy_ud, proxy_d, mirrors)
-
-    def download(self, ud, d):
-        """Fetch url"""
-        self._setup_proxy(ud, d)
-        ud.proxy.download()
-
-    def unpack(self, ud, rootdir, d):
-        """Unpack the downloaded archive"""
-        destsuffix =3D ud.parm.get("destsuffix", "npm")
-        destdir =3D os.path.join(rootdir, destsuffix)
-        npm_unpack(ud.localpath, destdir, d)
-        ud.unpack_tracer.unpack("npm", destdir)
-
-    def clean(self, ud, d):
-        """Clean any existing full or partial download"""
-        if os.path.exists(ud.resolvefile):
-            self._setup_proxy(ud, d)
-            ud.proxy.clean()
-            bb.utils.remove(ud.resolvefile)
-
-    def done(self, ud, d):
-        """Is the download done ?"""
-        if not os.path.exists(ud.resolvefile):
-            return False
-        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
-        return proxy_m.done(proxy_ud, proxy_d)
+        super().urldata_init(ud, d)
+
+    def latest_versionstring(self, ud, d):
+        from functools import cmp_to_key
+        info =3D json.loads(self._fetch_index(ud.info_url, ud, d))
+        versions =3D [(0, v, "") for v in info["versions"]]
+        versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
+
+        return (versions[-1][1], "")
+
+    def require_download_metadata(self):
+        return True
--=20
2.39.5


