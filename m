Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F6C282D4
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.53205.1741009758511073424
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:49:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=R0a+yRz/;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp823018D+0Ap7kh0BVfJCglQoWwD3zVK9QXSq0fPGH21FBRuty9WcNlrb442KLuG7YVWo0JSq0L57a9hG6B0RzVgWRmFXmMACzZVcaDqV3hsdWvjwookmiQleiTRA5tAqpfIjyV4Rk7riPOjf5NYhZFBNyapQCrVxuXRQ489NJmzZDNv9FJ9N7lWuqEErCZcAFYLwjF+0JLnKErR5KJwCPvAgnMJ0hen5FeYulKQBVkLSk9uTus1zv+e0AkW+ejRNy7XZhk1GKs9K/dIAWvSf/NEK6U26Ga8K//tr1o4uS/98looOQUybmoV8WnIdV4PZc/hROOuLco6Okp2po/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L1SrloaMuoXa8iLbuu7Qf3jo26EOmH8Q2bZIPiVjyw=;
 b=beNdGe3vnTjDlWhijvTabIlvsx4i/glUfTdfahOv87kusXPMgow0s7tsKIn85auHiCq6DFjdWNMIRgJIIwAp+dhIgc54e0Q0nSdkYXc0GYzykluqo6NLb/r98tzVAkgYLh4gx+KcW7Z3DSMWXRrXVgPbX8COw/aAkL45+EyG4bAOJx8emHoZHP7DKYAEIpmEGGDEXA/EwobCq72Ii8mzP/d/UWYBIHeL8Ss5zh47cpGOfbCNafTR/dubyTs1bERhgmvHPpI1maziRVpxAvCIHk+suXJloclaGbFBAOZa4T3WNkX+3DCFvLS7KQOa11HIOwbBfKak9zrdu8UIUQ1Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L1SrloaMuoXa8iLbuu7Qf3jo26EOmH8Q2bZIPiVjyw=;
 b=R0a+yRz/a1kJ64L/5K8M2sX7n8PWvXebEqOfHovx8xKX6lYwNsGELd8jOZgTqRLv2oKoNkkUzNTNjgtW8cnqFFfIDMERKhULzNpkVOyyhaPdOs4erF4HlBnT9x00zwKDBQu/Bj+1FvYglfIIrWZBcE82iOwBy1u5Jvb+NrBrPUpVW6SiBrEopLCXFuzi9IfF3K9hn5YcbU1Vi+00LSVexJ0ZL0jOczralSN8xrfuYfYi7BtaEU9Kcu28qVF4Zv+ib+5CQbQUhn9tZieD21Onq8zeejj4aAWWlZs+LfRVBNLmW+DYQJ51mP2OpwNkFlztBuawyeoTTNkq2qfisxc4xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:49:16 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:49:16 +0000
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
Subject: [PATCH v5 2/5] bitbake-user-manual: Update documentation for fast `BB_GIT_SHALLOW`
Date: Mon,  3 Mar 2025 14:49:10 +0100
Message-ID: <20250303134913.356778-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303134913.356778-1-stefan-koch@siemens.com>
References: <20250303134913.356778-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e513e88-2904-49ef-3a4d-08dd5a5a3072
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Yw+jsUjrMK+rOsTYfViaxeMaHDNaU+Ehx1BzH7ETSS4xkK8zCN+L8csYUByT?=
 =?us-ascii?Q?OnaJJkY/V6WyO180L2hAEnl+i317yMlpISMN3fGbQVdNdvqgjd+wg852DW6t?=
 =?us-ascii?Q?aVYShpJfNyLHgMHT0F+85HJS+/o3YIOJRFZTKBtSD+FfTZswCgIxPqYPVZ16?=
 =?us-ascii?Q?KnbXfeAL6EAOb5uzhggPTZUWvUhUBO4m4iybpFWtumVgkoDzHjPfeYqc6luG?=
 =?us-ascii?Q?LpE2KXSPrYbN6ZdLH9ur9eBEvL+06Bx+4r7uuBmjJ687GobQmcjf14byej73?=
 =?us-ascii?Q?PtKpVrk5xjgkZY5VQM5gIL+rE/tesKIyxZQ0+J1cV0lCjx7O0tFmQGGf4OE+?=
 =?us-ascii?Q?L/ObQ2kNUWvIuuoMac68qlWwkbQnSxK8Q8hckQMNmPdtIWNCX4kVb6v/6RKo?=
 =?us-ascii?Q?JFI/mmjfBRFYSIDc00Uy1TVH0vOUvc9YTuUr//kys4Xx3gwPRfMg4M4K9cYu?=
 =?us-ascii?Q?Cni5d7qjuxXF8EeUJMzzO64eLK5YkevKeEKNvyYnV0i6mYpm/WiQfxngmqJr?=
 =?us-ascii?Q?bvKzwFosjEJk8zgG8IxPjLGfeiims0Raf7UlkwzWp6Ww9k+5SHqTW42IwadC?=
 =?us-ascii?Q?4LVikAqxKvP0UZQvQH98R6nqAihiZcpOz4DasU1xKNZGPWDfrV7B2ix1/bqe?=
 =?us-ascii?Q?I1XF/CT6m/ydL7ac42Y2taDNQjPWAV8Sciw+U2ks6LP+/2pkiFBsFBTn5KJh?=
 =?us-ascii?Q?I9/GNFWibcKiglGYeBb6OohF3CMsGT0VWbmkzcjZQYTpDAmzeHI9oQkQkG50?=
 =?us-ascii?Q?8xiNfMMFCDGPQcIN1EKgzmz0EGX9l0wJnYrJRZMhwT5tVrrvAOw6OGmfuXCI?=
 =?us-ascii?Q?ysgr9apaLDctLjG2u/WkkcsdelBD5vyzM+Ain48Eg9dFX/9ZveOKA1S503rs?=
 =?us-ascii?Q?0pMi23AR9eUoV2S/TSpTV2wv5PTDz/w75CzRwuoXsvslLoJ7behkltXgiFXu?=
 =?us-ascii?Q?KorCNI7cTsziBAkNkDA48MlJVuMSxZwOysWiRack2Z8a1fs/qfonRTulZl25?=
 =?us-ascii?Q?M+IIuDgAbRwpQDD8ugNlSNdxigGse0mR0tDED8v+rpFUI518mwVMjfqizjRQ?=
 =?us-ascii?Q?GlTe9+KNqlwL2IYrzsCX+V6tUYmthd5FW3bYbANQXdHAqq75UBIvdFrfrzMi?=
 =?us-ascii?Q?euKpbyqc2i3ix3vzR8I+UfJYgBXWD1KlIxnkLwrGl+i8dho/GIEH54wucB7I?=
 =?us-ascii?Q?DGHnY9qYAkWwazIBsD/AfYkDXg9CZqyjIaBQaOouXeG36l8tiYEGtu70xNQF?=
 =?us-ascii?Q?r/fIKDUPrgLO/8TqEH7tCG14CFwtED46dAn0a72W/JJW3IvRhswmnX2JHwwW?=
 =?us-ascii?Q?Pf6icwtAsunJHFR3NCvmB83ps/bpZx+BoaeV0TNdNh/HV12AoDTIxJnm6atI?=
 =?us-ascii?Q?ybJy76mgqRejvjWjBUhrLfSL/7Wj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eD2/x1bfMTr2ouYtIKD//33vVT1NJAeQTavSwYrzeJ7qRPO7ONf9GmAyihwt?=
 =?us-ascii?Q?cJFgFqj93lLoc8DJ2WTUzyWGO0alh3e1azrqbez9DuT2Qg320fMCBNuhu6/I?=
 =?us-ascii?Q?2Z8ub1+YteVkTwGx24FUVfGHcNNLRk08AzfXzLJ3PtL/g9s2BOIR+NyPWrE3?=
 =?us-ascii?Q?SBP6xjpUVgBKPUSQaeoTYgbAJd8sNHAmLv0vi6Np2+aPk59wcQdQs9GmoFXl?=
 =?us-ascii?Q?co4dRNZmG22aKrqn8LKcarjUtI8pcPxtqoT6dkbFEqswDJ4RDUtGhIXPhyaS?=
 =?us-ascii?Q?jQAOsGCMibX0ampbe8+pYLd8GpSE3/t0WMqS2kajHWOD5qmSevl9OxKUTBIC?=
 =?us-ascii?Q?ZqTC+0QpZq3e9qJ8chwdkF2SDxUxG6o0CMwqITWd+sOkp/iPcLfDqhreJ/K+?=
 =?us-ascii?Q?/3Q58kijOc9oSsySLeRBSrlsAZ/FqSL7F81p/IxF7nfwhSQSMcooe+fwrbfi?=
 =?us-ascii?Q?ENbSjiZXDnyz/sxE9RA3Z+Q/nEaq6WOcIR9zuLL7wxdEONLMn8JpjBt7smDi?=
 =?us-ascii?Q?nAeyv1WDEXVg3W76jUI7O/GFFhgZL1xqmqc/5HT6KACHqPxZZKDhRHFl3hu7?=
 =?us-ascii?Q?aD5fmJGg9eCW8jE3kyEudzOThMpFONHGurvDNdN9QZgxBk0vecpmIHNu46DD?=
 =?us-ascii?Q?cW/zQdTqbgZwOqFjwqN9Y9P2LMNjpngyI4qJZK1OJgSjdvG1+C/0lkUXtDcA?=
 =?us-ascii?Q?VXZ3xRS6N85p/3gwlLTqBo0T9AQGPHk4llu8oJSGFqTZOhNLhL+61nW1k+wW?=
 =?us-ascii?Q?I2GkD66wC08LEOhonsk4QiGriNdKyayWdh0RF5rpUlESV6zBxCHSgJTfBG9C?=
 =?us-ascii?Q?rwZgYVgVrPgfn8Ed7Oc0DDXNsc79HBShfLrAW4C2A+wlZYi7qUVw5+v2N89l?=
 =?us-ascii?Q?eNmjwxhoBAJzuSFcRMs9mXTR/i+JiA+0AyBhQqs71zEqaw9Ul8V+qBWsQ1s1?=
 =?us-ascii?Q?tZ3nyQbb7YSFF11YY6LnRuTVx40k8q6znccYmz4OjtLTg3Z7bjE/WfcWJCw7?=
 =?us-ascii?Q?vDGfPV6E4n9hQ/W5i+L+Ye8gio2Oq8zlUi0C67DXOK6ozCpqNo/Zk8P5YqPv?=
 =?us-ascii?Q?sJnnBQiBQFf7CP16FI9KNurC68ZJH54Pq8W8vDwgC+iVTD4V7VhNvWxMcqhp?=
 =?us-ascii?Q?CEm3JlBOCHKJkwio6YT2rWzsuIQRsynZcueRG09388KXj5pmY4BRroSbFSdR?=
 =?us-ascii?Q?rF7M2o8slUHLKjCVxgj3AguHQrXf6kYck+rXGNat7/RyBvsYbooamyp77PVw?=
 =?us-ascii?Q?1tl7h2jVe0+IsJ0rb+5puK/51cwe5rckrEcm2P6dXrcMJFieDHmVdU9gV3UD?=
 =?us-ascii?Q?aMPMKh6EEZv5kYW60qRLBBGblcXFtDRRGJRDy1a36jCLrBKKq18nuUD85BZ9?=
 =?us-ascii?Q?TFyZSKZYLFKpX3n9ozVD3D5gqVyQY3NE4hJ2xHR6r07otvfahftGSb09k/sP?=
 =?us-ascii?Q?WKoRpnTo7GdGJz5gz18i0gOXALLwSrBt45PwIIlKpC4IbVszO0/J0sY9jYF5?=
 =?us-ascii?Q?J8F30wrPcKKQoN/YS9HXODbwQN323PwFRNE5jlxJbnEw4Tz9hN32WXhWdt/Q?=
 =?us-ascii?Q?dYocfo3eYEkuVG+orR58EhEj5w1/Sfo271PpxRV7qpKy3nTQLo6HMBPhDTyp?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e513e88-2904-49ef-3a4d-08dd5a5a3072
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:16.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8drx4IPsjeXTopPa+eloCzYF+ZKY9MqIsKVCDft5ER4jWbCaSu+syAProwzYwtNeQPhHsxJhRtu5SLCsj788+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17376

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 858de6347..dd8cf2409 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -320,11 +320,26 @@ overview of their function and contents.
       mirror tarball. If the shallow mirror tarball cannot be fetched, it =
will
       try to fetch the full mirror tarball and use that.
=20
-      When a mirror tarball is not available, a full git clone will be per=
formed
-      regardless of whether this variable is set or not. Support for shall=
ow
-      clones is not currently implemented as git does not directly support
-      shallow cloning a particular git commit hash (it only supports cloni=
ng
-      from a tag or branch reference).
+      This setting causes an initial shallow clone instead of an initial f=
ull bare clone.
+      The amount of data transferred during the initial clone will be sign=
ificantly reduced.
+
+      However, every time the source revision (referenced in :term:`SRCREV=
`)
+      changes, regardless of whether the cache within the download directo=
ry
+      (defined by :term:`DL_DIR`) has been cleaned up or not,
+      the data transfer may be significantly higher because entirely
+      new shallow clones are required for each source revision change.
+
+      Over time, numerous shallow clones may cumulatively transfer
+      the same amount of data as an initial full bare clone.
+      This is especially the case with very large repositories.
+
+      Existing initial full bare clones, created without this setting,
+      will still be utilized.
+
+      If the Git error "Server does not allow request for unadvertised obj=
ect"
+      occurs, an initial full bare clone is fetched automatically.
+      This may happen if the Git server does not allow the request
+      or if the Git client has issues with this functionality.
=20
       See also :term:`BB_GIT_SHALLOW_DEPTH` and
       :term:`BB_GENERATE_SHALLOW_TARBALLS`.
--=20
2.39.5


