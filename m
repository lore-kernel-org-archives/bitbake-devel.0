Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C4E77194
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=e4ZAy5mD;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfzrwhVg3kPznq0QHVe40PF35dUPLpTWtTqvM2QUat51zX5qsJ7531AqK4j1TxsqonwSmAJPPLy+bhaf7zfkkgLNjxdFzchPqWGfPubJUo6mc1puwwnpmMyEF7+bckmP6YNqvMJZc2ERZoB9XMDvoxXdQliKKGMzYvj87d9kMfY1EmX/hL3/AkIdkHihOmbpDHwM9eAUgQ3zNCO96Qjrje0ljnyEIxAG1OR77h3fAcbgs4a9I7bMvxtIuXHBAByphXYQroG7jkAZmNZ1quURgae7NXYX67nHhqC6NgcKAMX6mo2eIGj4u0W8E/2hro8lGv19LIkRSoMCCtX854pHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh/WNWuuyisgUp+5E56nzUtPFSpNFcDOw4PpKhURkpY=;
 b=Wwe35Y2OaxIBOLjkYbJ2AB+V7feXEYIZXyOa1eYrYM7PGZe3KTV6Z9zw1RQbZlnM3Rd59GGzU2av5FovwJM6CJ3mGR4lDPFErilts/nCn/jL80ajqoP3q7eMujyCBvrFqJLCmeKL4DLSs67z4/dWgpEnF+qrm+w9qYqDffpyjCA1XJl/ZkZhvzu1rbQ0Azd5UXWJkAG/jMrzqtXOx1hGY7drG58bl/UT/18/1dnCbPUUtH+BaaZGDULM4um8LLoQTVcO0YxR6wcAPDGBUqBktt8U6NivHpMI+kgt6QZ46+NVWXCu0jtm5+Ldh8yjA8Lr2i/zSlFcX55uzcLzenzJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh/WNWuuyisgUp+5E56nzUtPFSpNFcDOw4PpKhURkpY=;
 b=e4ZAy5mDyrqa0GzLtp+Eq12tgS8B9e3MCQLOLQxz7fjIaS8JqZ51JSz7NV7bMpoQXPybptSu3CI28jRKy8ooRutNthY5d3n1/iMAXrFuT9Aow9tYXpbKLQIAY8jfFn1i43kvl6mUbOFH6uD99VWeVRqtxeo6/k6nrAFpOAQVJhAOVUtE3yuEdi992d+sg84Sg+Ikl93gGL/lxyvSPxM5ZlGmBWJFpFlJmBwrGHtzCtoU+vY6p3qwNSHDty9eP6oyiFESCAhp6LNvQsFtwZK1oKZclaQM5mFyBJPgDsH3ffxe9aboRpdpiyLXLspguYV07fUL2pgh2aFQRtDIYS282Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:26 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:26 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 06/21] fetch2: introduce common package manager metadata
Date: Fri, 20 Dec 2024 12:25:57 +0100
Message-ID: <20241220112613.22647-7-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd213d8c-1309-482a-0af5-08dd20e92403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LUNC65/KAWfYZhDMuBlokxxGgjvh3N2lFnc+6WTBTIf5N941PtqaOAxJHSFh?=
 =?us-ascii?Q?yKYE6RcilMyg5UHt0XsqttxWnhy6OiCyK1D3TiRF+kXS5KGERnmD9nOwy/JN?=
 =?us-ascii?Q?wNFV/dn9vFlzYGSzkVAIA6tnssjFrmRgBHMSXHIxkCKYTkitdQG+1I8lKBqN?=
 =?us-ascii?Q?Kf1MLEPRTkF7agwniBNCQ8HxFBEr9RhxZr+rNVUAVJpQKdWUGivIXyB5eUnm?=
 =?us-ascii?Q?KIE5Em++tQsY1U5I5UPF37tT792XeaXfj8+m6iO5a8GDdmdlzSc23f5wZU8t?=
 =?us-ascii?Q?5W2AQ8Ioj+BeN6oywNynoeQBdj/adE+YLSxUvE1OK/el7bPJlaztVfAI0B7k?=
 =?us-ascii?Q?KN+C/bG79kuit8wgIN23E9rcMBFegqZzBVa/h8Wd+cpx45FDCoSzNflir6WA?=
 =?us-ascii?Q?lKsJ20B0ifMpIL/7Awi0kL30NRdxrzbIQ1XiUhupeMObDuRp+EfjkBrxPwWx?=
 =?us-ascii?Q?oWN4u8SXjvtcINwqLxur5cXI/Cql8MWV2vdymvWGs2LgGG6zZap1og3/wpcG?=
 =?us-ascii?Q?QxX3pyCGGdvteBADgQj83/r1189pS5RL+eufUt35C+5r001FDMdMVJBktZQz?=
 =?us-ascii?Q?gF/bw3ydjJlSppqjtq1co/kfIkYlP5oZxukyUZLKNR2RgHrRDdH2VxwlWAiG?=
 =?us-ascii?Q?0urmJZe3pUb/9fhSclT5uUZCLxLyjbTO676H0lw30O9tYBu3P7rA3s+AWqXT?=
 =?us-ascii?Q?lh3AVBJjPWX7BFLDCzUq3dAKtKQbuL5yXBBE59zXiRnIM1ejZ87I1VK2D3jP?=
 =?us-ascii?Q?igScOvXvEoeLXi7nRB0N/9O/6iFApfs/FShPVQx59VPs5yI3QZ6dtvmXppTW?=
 =?us-ascii?Q?Na/lorqQDrXqxKzPJ5626YcxgwtgFUAbIpL0muf6/QPIJETOyXElnKfYWv52?=
 =?us-ascii?Q?HvzwtON9/DSIijqSj8XECtV7b/mNxJ/wutPVRVm3zTNBF0jIpGJHGR65Glop?=
 =?us-ascii?Q?WEzn7lWpVgMDAd/4J2k9lb2WXuH+tmjj8190Sw25ibZYMAHA0bAPghUcVoia?=
 =?us-ascii?Q?w8rSXLyxIdjQf3OJ6cfeiXct6HZnErOpbfN+OkJx93+H8rEQv6Xd2zj9X7wI?=
 =?us-ascii?Q?st1ubwtukxBjapgSkF01QgtPTLJaAMISsw1eR7Sg+fW8l3XfkUA+Vy/onm2F?=
 =?us-ascii?Q?C+R95ff68iYiVCFFAVA4yBeVhPnoIds6RXOySjKp0FoGfMPibeUKqMCZKqER?=
 =?us-ascii?Q?pX4IZH54Xocd/mLo3j0iXaOiLzBiipJylywWMNJ0o1DTdjyCy6InaxJ+npNP?=
 =?us-ascii?Q?mbDPr38C8SAaaZDBIRobXgDwQu5r2z1cHFe8yY6dIqajr8LwleFY2szZ0K3e?=
 =?us-ascii?Q?/Ru73k5EQYtiwoQZ9CLk3SgG9gD9XLSEqbCVDcQA339jsk+XKTzGA15PvvtA?=
 =?us-ascii?Q?DPJ8ze36ShT7k7E39kh1OAsIhXKmYW7mdXanml30Q29eUoMvoujOFjlMaNxH?=
 =?us-ascii?Q?k9ueebHTExau9UHVqMRRb9zOjYuDhBym?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rj3OcZS8vE4ntN9fk7srU8c6YXIZzVMM6VvYl5J2LcF/LBr3tLmdbJzh/+lD?=
 =?us-ascii?Q?opqR3P5QMy2FohwCrdbw78wZLtWKN1RUmGnkAXOeyi5hm4SLv3OiY6tvoK5L?=
 =?us-ascii?Q?9f/MFED92Hy2z7vko4FZv1L66iPDaab+wt3O89VmQJehsUP+AqWZgsp/2XK9?=
 =?us-ascii?Q?5hGIDklCNtUmGzkMP3quiauCSKrovuP94soIEEqHGOygm3hNs7s/WtI0FQ09?=
 =?us-ascii?Q?juPGj9zLuUc8+SjeFxT8u5iINBpKHOIQwo30DRWf8m1X3uVgzUbJbSR/5s91?=
 =?us-ascii?Q?ThcKthbkH+tJhbZEf/wkZE2gVeRUcl9ovVpF6A7lkYs4Mudyqnrr0ve+yzOa?=
 =?us-ascii?Q?52Ur/Xe8gCdugdM7eAYguSMKYKWyBi69yT6NzbHDHM9xvXCSBCurYggSjeZb?=
 =?us-ascii?Q?Y4H9FMsdzhuqq2DuOXpxPVphxU+H3pDMez9aqXi27GEi7iCZfM4DI25SeCLr?=
 =?us-ascii?Q?M+VfSO7hSCL8ju62IB64KIYSJCOCeQ3RJNYzd6wgdd6kMJcUBZ/mYlmXq2/U?=
 =?us-ascii?Q?u6UkX8qsr5Lci2eRRrsIVdukDVEaZ23RevQ6eFmnr7wVK3RWt8Gf5d+RcHon?=
 =?us-ascii?Q?cdVJpdTta/jYmH8SUA6Nc11i5+zYdd1ajW0ee/XDrVuuR3k3c/qGa0LYYYjs?=
 =?us-ascii?Q?1aJhka+FxbfirPB04dArma/JkIRvn6E52w7RXPUNdl9QyKPsYZ5uW50nAUfZ?=
 =?us-ascii?Q?uU23XjjfYA/L2WHg+fMRVHIQ0O+D5rcmy+H3zWS5JLOueGqfvq03NJ8Ny/cy?=
 =?us-ascii?Q?MShWbM1btE0F1gT6fnrNzeAKotTPp/nhSQ8m5FR+pPhZVmpcDvElVaEbshMg?=
 =?us-ascii?Q?o454fqxQxAiDCJ3CyA6C+6CeJLu+sOBpTuLHVpHgxsdnmd2VEzOm+Uu84kaK?=
 =?us-ascii?Q?rP5PDfzt4NSFYQfVI63R8gSTblCHfj1oeiTVG6CrxGdTIuWrA2Vu/jXSOXOq?=
 =?us-ascii?Q?mbcCb3JobczVBXCnXY4gdxAFGM4l3fsBINJU/PNAcncUTvJvB6Oa9vhl9jhu?=
 =?us-ascii?Q?jwhpywtQf4X5BcvraUQJrVFM5bAv7q57gJmrqrb8BDR0Vl5SyBCCzGWG8VEg?=
 =?us-ascii?Q?pM0ip689Qh2mPkKnACsJchPNqJTn1hxCnWzthYAGN/Cl33Due3PFCOAPOy55?=
 =?us-ascii?Q?W/N8Jt6dEwtHbWYi0s8trXAbzBTdaTxT1XeJOhMQz9CVLyfiUvsf0IAGLpMa?=
 =?us-ascii?Q?67EwHJ4ib/V67+7t3GeIHtPez/U9Bep2aGin4xWzWIyLjEgwRoean2D+t9I9?=
 =?us-ascii?Q?IClASh9eLOOmQ/toALsNjRQGilSMeUAR7RXFt7tMZoWqbK5mAcT9IbHgpd+0?=
 =?us-ascii?Q?1kUgypzWCE7/RvE9b1csPHzuSVslekvX2eIPKxX1e3PZKnADi1KRCcrZ+QyN?=
 =?us-ascii?Q?ND3Ngys5j8pROdkdPSnEAgjuV4+oWEFdzmo2aKiZwUTDadgzcSI+eKYpLB2j?=
 =?us-ascii?Q?4a0LKU1am3o19fFkLIQ6ARkCdLkP8ZvxQ9IdrC7hnvZ1kgRhSQJS/ZGlU6fh?=
 =?us-ascii?Q?mFput1GFn/B3w/lk6bKH9G+h3ILJAKgeDfsL+kcJPZV5Po75MU/gSjR5fJTe?=
 =?us-ascii?Q?hPYt7x7UjbHRqxKwVNGW7xTeFyiekXCMnookIvVS6hyx1xsY/fOAW4tco6u8?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd213d8c-1309-482a-0af5-08dd20e92403
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:26.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5HoyF+y396nHoWh8bZv6kfJdraYR2yZ+Ci7pM6qry1+u4nPkH59yhur6Mlp6ueLHiLSEpam5UFTPRPwdvLlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16925

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Downloads from package manager repositories are identified via registry,
name, and version. The fetchers use individual styles to define the
download metadata:

npm://<REGISTRY>;package=3D<NAME>;version=3D<VERSION>

crate://<REGISTRY>/<NAME>/<VERSION>

GO_MOD_PROXY =3D =E2=80=9C<REGISTRY>=E2=80=9D
gomod://<NAME>;version=3D<VERSION>
gomodgit://<NAME>;version=3D<VERSION>;repo=3D <REPOSITORY>

The name and version are important for the SBOM to add usable name,
version, and CPE to the SBOM entries for the downloaded dependencies.
Introduce a common style and check the existence of the parameters:

<TYPE>://<REGISTRY | REPOSITORY>;dn=3D<NAME>;dv=3D<VERSION>

The style clearly separates the metadata and supports slashes and @
in the name.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d2a30c18f..4b7c01d6a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1356,6 +1356,12 @@ class FetchData(object):
         if hasattr(self.method, "urldata_init"):
             self.method.urldata_init(self, d)
=20
+        if self.method.require_download_metadata():
+            if "dn" not in self.parm:
+                raise MissingParameterError("dn", self.url)
+            if "dv" not in self.parm:
+                raise MissingParameterError("dv", self.url)
+
         for checksum_id in CHECKSUM_LIST:
             configure_checksum(checksum_id)
=20
@@ -1711,6 +1717,12 @@ class FetchMethod(object):
         """
         return []
=20
+    def require_download_metadata(self):
+        """
+        The fetcher requires download name (dn) und version (dv) parameter=
.
+        """
+        return False
+
=20
 class DummyUnpackTracer(object):
     """
--=20
2.39.5


