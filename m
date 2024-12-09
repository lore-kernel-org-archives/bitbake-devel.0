Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F3E7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 10:32:31 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.108])
 by mx.groups.io with SMTP id smtpd.web11.98025.1733740340477353303
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 02:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=zyxLdFPQ;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.108, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNnjXmryGkZIIswG5b0mOz+Qee+kpzNrktjSwfBXd2aFJcg0hymxUt/B5b+GwvOKbWPK/WVOKu1yA1HJsLQLfRGCl1K4zrqu/6IYMNBYvKAsCkUOsiaVZy88dcFhGywpMRAPrRO2lWGyHVbG6h/8DXjRtehDaaIVcXWnCMFHMjHU8SwaFL704RGfisrrydhaKZST7hmLeGEcptBOTScfPewS5vVEHeOwxUH/cbkFq38w3tvF4PmqpQfLy1f0EtVaebKe4pOg0MgJu030iKX7beeZ3yFR0obNoY3IVCAnyTCmzuOQOCERfn9zXYpDHHB64YtwGNGYNh/Dei7jm34TOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGYJ4xX0vQj8s4C3rYIzt9Xs2saHy0Sv3j9Hl/J8s/Q=;
 b=B0wybbfR2EW6jwKT/WMOrMUXfvu5HXT2simcr7FDw4qXHy98dpqPdS8XnmNp45ALIIZ6T3K2mhUEBFj+YufJ+aSTGaLCovjbR1J5XpdRETWfztUo5RPIyabsQ8gnjEFNjWO9ZGpkWgrWkBGOeK53tz5x3BOqFtkRm5ObBdzC2GCMJNJbcwlgSJ3Z72hCobsJ07N1Jnt1Dc8jabO540Cq5gPOqh4TTesm7GyJH+JpUq6UI0e0MNrYYuAQoE99rNf/91ES3MKhAG6oJvpxFnnrKi0HHuMYRfayKRXw7VfCq1vwmLefqYMf7BB6PrPUkgdK31zToqBOlSeGQiLNSy9nBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGYJ4xX0vQj8s4C3rYIzt9Xs2saHy0Sv3j9Hl/J8s/Q=;
 b=zyxLdFPQajH7uCCryUeTI+rIR5s3lvlPN5Qb/i4qxeJt+uu7H3jKpsrK4uku+0bJPxYTUEm7jj1/UdcklUaLI4mcg4bfJUqb6z8uvtcOZROhwjFD4m/3n5dQ8f4RN/6g6EC1F5aieTqfxPzsUmc1Fw6vZvMDNNIergKHaXVZHKkHBlwf7kEbQrx40hqX7P2okRCUpppRFeup+/cOn9q3m398W2XsLI79uyT0xtfWM942YCozoiBxuDjI0oi+u7o3JUub+shWBp/AsU01Hsd6Cs+zBxRpc3iAYoNvv9UDlEENZ51ZrCQ06LlF+fWRmdT3HAA1nzhFfgH5/QxApB56XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB8384.eurprd08.prod.outlook.com (2603:10a6:20b:55b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 10:32:17 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:32:17 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 3/4] fetch2: npmsw: ignore bundled dependencies in packages
Date: Mon,  9 Dec 2024 11:31:57 +0100
Message-ID: <20241209103158.20833-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 280fc157-606e-455b-1afa-08dd183cc107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X7UPp9ZA3UeVzHeDmZcZa1J3xzcQ0Rbs5p53A2eJKolt4zZ8W2D+MbpGOvJD?=
 =?us-ascii?Q?O7W0XJzBSsAkrDYdkN39UAu0Iw6+M5YaTvV93yOF9gsSJ889r5MUq/1vxgK4?=
 =?us-ascii?Q?k/iBMpqcsK5Au8NwoA9XK42ggViHqBZ9r+Lm1tp/P81/BM1FdOiDU9qZ6q1Q?=
 =?us-ascii?Q?ap7NdbWrFYQm/NK0ma82mhUCNJvFYoD2oKkWaDZuycy42616gCHN1R/1LmLf?=
 =?us-ascii?Q?hVAokeXO12gyucJXYFEw+bwU9F9gLqCuyq6gRltUan50B2kTs5W3zfO6nCb/?=
 =?us-ascii?Q?vy09Nsk+cBoeEIYYov4yRVnI3XSgqJdkgVmtfs/GbbncJBthu9AkB3knnQ0D?=
 =?us-ascii?Q?LwqAjvBCaP+pVOBwZh/5TbjAKJd9cJ64rlShJqaM4nJLsTrK88jYnO8SCxeq?=
 =?us-ascii?Q?boJ69E22wiq4p2BWrB4XMSo6H2Moyyy5kM/IpVzgoctSmWCkd/J9+G1hir5j?=
 =?us-ascii?Q?NSVtdzzHKKArcfNG4o/vw0c9OqsB4mI1OJBVdzZgPzLeTtNbstn9sb+BoZIu?=
 =?us-ascii?Q?Kn/jMBnpv4E3n0ZueVAY1P5lEp+UghdQAbDApP8HjQv1C2YTYPBGfp0VUZi+?=
 =?us-ascii?Q?YYPCv8NM42x7rVPdR/MFokKf69R4U1UNess6p0mrzIbviG9nqQnkPsLbIM9+?=
 =?us-ascii?Q?Pl6NicqtLYmhnIe+58JXjDBFmTCqnOHSnjHWE8Y4c1dy9v4AF119HD3p65U2?=
 =?us-ascii?Q?w8+IU3Abn5PmoAYR/NFl0tl3YmaDPkhv9QVLScbXCVtY+UVef3CcqrQDzo50?=
 =?us-ascii?Q?JpwZcW6caCTi4fVihUn2+i2if5in0WQv2m1HzLWDABhxKH/gWpIpPdJ2OhON?=
 =?us-ascii?Q?Nlke+kmmvwRyBJrdzTEC5pN5Qsy+A0Jv45VP9t6IadomRw2mKWxPJCOjCtxS?=
 =?us-ascii?Q?zvoS+R3XdmqmMJj7Pui/YttV7eexvZZUaTRyn6qn1U+c9c9/W5JGgeVl9vNm?=
 =?us-ascii?Q?H2TJEp+G5lJ2T9Wr044O3ukAetZ6miEySIgWGE1EOYoU+6fv/dJLyVBzS0n8?=
 =?us-ascii?Q?JOuKce/HVzaO8PrqtVX8oraAakEL64R5Xe6WXjlRZcPyOjEGhN1lNLs2RIAg?=
 =?us-ascii?Q?Pga6Phs8+pSMXJFzUFV6EUVhJ4Fs1hGMxpcj3Ah431ahpZ6rSxybb+OR2Kcr?=
 =?us-ascii?Q?D4BRCRLsodGRmLIMW06/tyIuw6Mz+Qj3MHgTkrYxQAt5aev5pGuXeQpIZ7V5?=
 =?us-ascii?Q?rrjBQa2yyO8kXfOeLdxVCkFRBLbPpARt/SruWdVGMRwlYkk2+SOCjIB1h9El?=
 =?us-ascii?Q?/i8D7hddwqAhtH+bxflXLCFSFZmeN3UUoLyLLPdclgjjLTv0VQZJHq6e+6Iv?=
 =?us-ascii?Q?3qy2Z7Am6JrnJcHhfQdeteU3vboGbcMRVHUcVXK88GDmIH4LRfYmGgHCtd+R?=
 =?us-ascii?Q?UuE5JOu+QBmZyhIsZDAE6LKxe11LwpLQz8416b31amEQajoD3g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8w7oS+zRomFCiJOq+eCnVmwfn/ri2ko4ZLZGpBEXmzWiwnipyKDkGInJabcn?=
 =?us-ascii?Q?2NP5ftn+ZwnKndLxLJddDE8W0N25qvg8qCG5m8EgnvOXO4PW04B1DcaYZ2A+?=
 =?us-ascii?Q?HZIaTGpr1NVEU45kVkW9a1Lx+eFs3Uzsqq/wrxDvL4CmXqEullysd+bkxoL5?=
 =?us-ascii?Q?GfMcb9BPoGSDgVWqkNE34iQlXZu/M78Vb4m8y/eHAso/w/YYDoR31l5gEFHi?=
 =?us-ascii?Q?Kr2D1ZRIp0rewPn7QKEZmkzh0KdO1fSAapENeFrZnoKxLtc9sNlYM3XQlPPX?=
 =?us-ascii?Q?mwvu9RrTiEWkTOaJ1ASjpOhvpvcHtDDBLPjhq1mj2GkJEHUjuIiN/oGjOeQ8?=
 =?us-ascii?Q?j9mxhM6N+zN2Rxnz+baVQe4J+Vwt7QGiggItXaBHPilYVww9ghFFI2GYHKgS?=
 =?us-ascii?Q?Fe/zBIxxxLRlXEk+pVJz5uq/ZiHoK/BuAC23NG1TJZ1+JknyuCk8mu+OYSYm?=
 =?us-ascii?Q?yAZBCzWMSpSQU5SacEW7jgDhcDZDVAHcn4h1D2D7R03TaPGRDiTExX9iFkld?=
 =?us-ascii?Q?0W4dyPul6jvvb4yUI59kNPKOR8izbTYFP5NnqKuI0Xu+KywQgBtmJvmfU8um?=
 =?us-ascii?Q?l3997ZaHM9DsI/DKuuFvjKdSxNO1UetimqkczHtT1jeUD/RAVgHkCBaNqUB0?=
 =?us-ascii?Q?9esQ+2sS/bMTIgoX4KnTnQR+xxci/Ga/A1ECPC8A16nWrK2FZ5s2dHhGthWq?=
 =?us-ascii?Q?iGe0e9Voe553N1xzJjCvGuCzXj68GYKj35G+y4U+Wy/cfdVOk/TBhO13qCdd?=
 =?us-ascii?Q?HZVzZbLSPzwlW/9Cw/L/T8tzPlKAu20JCICYOFTko/R7G4nzAvJSDUUhnrT0?=
 =?us-ascii?Q?QFVZQk9lHXC9tc6R3IrBPLZAAU9PlM9NXaOAazHug2PmwcfVCCoJ3GUfq4ze?=
 =?us-ascii?Q?LTnHSqBXj1DB0Tuyp+iHV4uthgJHgMaEv67Cv0SqtxXrm6tIoG4sBCCZ7u1s?=
 =?us-ascii?Q?9Gm6fR88r0ynKepMMxmFbZuM1HwYRxS9RZnCip/ErmH5yS7xJos+I6bhMptv?=
 =?us-ascii?Q?skKd6U3qniVowauFh5DpBYbhAlQ/Ji0K8YO6ECXmEx6m8dmHBQun9uxjcV+V?=
 =?us-ascii?Q?+O3hC7IgsCeeFz8FcrLcP9LX0sm1i0aNXyJi6dF+91u2HqOTnf8fXWIhdjNF?=
 =?us-ascii?Q?WmeGIIeo4d5+7JslG3ZVYE5agtLHLZE9+TFtVtcZacCbG1VygrP6Q5xvpX0J?=
 =?us-ascii?Q?Mi3loiTQA78wedJ4mV61gwCxVNdLF73+7e50xekILGZvLarZpdvAyMSQwHUP?=
 =?us-ascii?Q?Yxx0LMJ8xdVDVp4s2DDm6/1ok2vCLFS+42pzp18hCOJT4D+GQ/GA1u+NSkP9?=
 =?us-ascii?Q?w8W78KOK93y2hAqL5KkjsFqcgAPwwZxprP6/rJlYBsZRhjhvAZUx/E5/0Okr?=
 =?us-ascii?Q?UFGzBrx1COIpCvvBwECEsGkmMH2CzJYberK0DoGZyIa8SiMWR/0EQtFBabUH?=
 =?us-ascii?Q?oLiF7/gIYhlUfFQOL/NgdRv31c6WXeJHsRT59wq3NPJZh4Ne1TnRfa64F5pb?=
 =?us-ascii?Q?4QdnOekrd6iWjtQ1V9/PIwhvGwlvY789aeFxiR0h94XBXZsEfooDIvi/izZ5?=
 =?us-ascii?Q?OKbliSKC8YGK8ysa3dIfwACTp5zv4mkZ1QEwUhcakN1/t6rsHxgBkGFKoP6c?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280fc157-606e-455b-1afa-08dd183cc107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:32:17.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVx3LEThVw5AvIl7kApO76qQmtRzXxxdSit4lEGfB9OrO8D/vnW8eMCsYgmYU4lWd6UjSzcj0vODllRITKbLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8384
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 10:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16895

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The npm package lock and shrinkwrap file list bundled dependencies which
are supplied together with the parent dependency. The flag depends on
the lock file version. Add the missing `inBundle` flag to packages list
processing.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npmsw.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index a5fa598de..558c9a2b0 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -66,6 +66,8 @@ def foreach_dependencies(shrinkwrap, callback=3DNone, dev=
=3DFalse):
                 package_infos =3D packages.get(package, {})
                 if dev =3D=3D False and package_infos.get("dev", False):
                     continue
+                elif package_infos.get("inBundle", False):
+                    continue
                 callback(name, package_infos, package)
     else:
         _walk_deps(shrinkwrap.get("dependencies", {}), [])
--=20
2.39.5


