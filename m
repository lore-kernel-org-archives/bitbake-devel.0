Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1BC021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:27:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web11.2757.1740072443352419987
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 09:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XA6w0pVI;
 spf=pass (domain: siemens.com, ip: 40.107.104.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4V1w7nXZn3ivrktoowhwis+Hhpg2E0DHa7xB3krfzVj2Ey1WPxDjQlMJsAWx1y0o/+9awwXwfHATMMbposZQ8rSkA5aJMQB5wg+oe0OWGeQtlDeFwwdI9iuQNgzVDoKGwNC7LCtRQhVUdHUqPfdkBoDg5/Gyik9diSHzoS9S1FEYlUaWFWrfZQ+ZO0YD3xq1+ZEVVD+Mp04zkkn9eSUf21nVVwP7M0KUSFtYl0nQ4i3Se1WQDowroOf/6YuIwNeaRP3qDH1kDIRNbU12Qos8ltTWszmEcU/yUwhlJTbBfdNq49RKTKiUSMJLmlLSCz4PxL2VYvLwZfEqVN0D5yw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHmX0A1A2JmdJp+WPKA5qQK1V39QZvrldLsfRc7xdBM=;
 b=A+EE2VN6pICeW9Semk79RW4perhgCukVLBSeIynrsp6TxAP0zm2YnvyAXW2JI3Pu+5/UgAJTJWx1HLFytF02ixhCd0MAMYu4I5fiGD6TtDMfdY9pQPaXRdklCE5GbBt0Pfki7bvTHkD5ZLtRhphVVygmnklr7KPtdWHtU8E42eGeWoa+92Os+T2XDimNWQZn1aSxajw4fl+zYfC56mfqS6ZBbXmvERqSJDGCfmSb2FXcYQu5p6agXZnHFU7iVFuH2Bws6c4IQUT2H+r9qfJ2XBD+ZD/2rl8Obc0c4KBFcWGdhMmUrP0Dl+HvaP4bU344/fp2IguvubrItDrPw6d42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHmX0A1A2JmdJp+WPKA5qQK1V39QZvrldLsfRc7xdBM=;
 b=XA6w0pVI+56dBgcOpaFemXrXs4PpF7xZBmKmZ2ippXdv3/OqFzk+xd8zCU03KRH/F4HLBIUzIfAL32azrv0stlHgr8JIxRNjBW8aEZqfGbSHApsKG6052ln2Y8lrNhhWgsvtxn6u7qoihHxxzZNrQ2sIUSM+nP8OOivWo34xvz7b2+pYWNFqXeiF7CvjUIgai2Q9q/AxWojEWx0LBBX5dgG76ACmpg0NzsLMSV53DROwd4XjBpDCLO1dHrnzUeeKjvDsmkP1ftPDzxqFlVvidVyiyzy4ZJwHjHgnpaBSmt5ZYNS3MLaR8hECevskBRFNs6F1tUoWfbgvoVm/Gw7H4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB5551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:27:20 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:27:19 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org
Subject: [PATCH v3 2/4] bitbake-user-manual: Update documentation for fast `BB_GIT_SHALLOW`
Date: Thu, 20 Feb 2025 18:27:04 +0100
Message-ID: <20250220172706.3850722-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220172706.3850722-1-stefan-koch@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eea9a2-299e-4f0c-8463-08dd51d3d32f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Sb2etOhjOPvoZJWIIiHf13sOcP9N8riAxO6orAs6JtJso5qXAXET5avCynHV?=
 =?us-ascii?Q?VOzzRBJKZGghZNK7gNqT1RsMg0cxjYMpFiPbhYb3ywbuOPFSBZFHUSH3uR+S?=
 =?us-ascii?Q?c+tqTrYU1WJpwnymxDINpc3GCBYo6XLq4C7sfKuvu6h4RRcEAb7ikSENWKy0?=
 =?us-ascii?Q?FPnygPUE+9tIabDjFlYqgCi4BuhiDFm3dsaEuyzLZZlHQ6Qf3WQXfBH85drl?=
 =?us-ascii?Q?r9uv83xK3Ju/Hv493KmpbkX9/Kx/+Uil9rjEXcjsTZb9zLR7qOuH7KUM4KMc?=
 =?us-ascii?Q?AujYy159YI6oPsepv+zuBhBLiO5w7kIV7CuEDm2lBLup6nHlvHVIfI9hW/XZ?=
 =?us-ascii?Q?w5BnOFkQ1D3u+S77pMZlT/ItU3uJFgo4CmflAwFaGzqEiD0dqr8o6M+esGPa?=
 =?us-ascii?Q?IjbxSL6nYxcYT4dAf2Li6x/55+U4EWMAir/dalqKMf+q0XHodhY+57qvMM0T?=
 =?us-ascii?Q?iG4TF2GE1JNDkcQPojrhI4GSKOUzYXw9mktjRz690qtqS7Ffo/Yd3+MTJrzF?=
 =?us-ascii?Q?PYXodH7ltDV3feFaktGmBBnb3+wsLl+FDEW+0Dk1EGWlsvs7vBwBi+xvQzib?=
 =?us-ascii?Q?u0m5C0tCMHx6QgCBvkBkeirmb6L9dF4hKhShfpSWZQuLuB2Aeh3WMUOlFvBW?=
 =?us-ascii?Q?HXoBsyb3eBXayavmavL3i7bn7c9p/P263vAMaFowR9N2hG/NopQANqn30N5Z?=
 =?us-ascii?Q?S1gj27YbovEhCCdEH11ARVqQqyiR95St6MFDdB3vssk4bTbXBihrxQEKdRhA?=
 =?us-ascii?Q?MfSzFeTS+xhC2OHzB3KsSNrMyspTxuE9HyNkH2s1f1RrSPrzUQ44n4VmOQQM?=
 =?us-ascii?Q?oVzogT3SxYMBiwl2iC/8VMQ8EJHeTHzWeF7C8sLoEco15sa++UWB44gu8EGJ?=
 =?us-ascii?Q?h+exOQeI+YJzbPLZu63r23Jutk4qIoFyVSwX0/90KNZi9Wrs6fDC7pVeEiWT?=
 =?us-ascii?Q?Mh5OiFEg0/O9eNzseNBmAKNMCFdF37giSsL9ZUGpgKn1nvK60bzMdQgC2dIJ?=
 =?us-ascii?Q?xxcbEhT052V82u2qRTmUvx/KlZuzRCrqiDyDXnZhT51Zz7GU6mdl8JTVdVMi?=
 =?us-ascii?Q?prUdM5yduW4NTeCs5bKVRtMIzslrYCsIN7RUJuNIcZS5Vrs0nEEtioiZ0Dqp?=
 =?us-ascii?Q?8c2n3ViEN3cLWsaB6Lf6vyNUkO2Jm4nJLRaRTJxGuN9JzdI62/EzUqylCX93?=
 =?us-ascii?Q?UZFvlMX4CyTLk8clSAkXhCUEoDdMLt1dVA84rSvDrap/76AGBQcm26q9f7ez?=
 =?us-ascii?Q?GpbIKY1Iuwc6on8+FlEVnLHvjs0O+O6jlTSkVbhJzS1FVoXyIH5jGKsj35vZ?=
 =?us-ascii?Q?u/3fNr3aEO3jrvNzGvtyCmOaBhrI+HHHaqpEiREUR8jGPnDEVXvnJXVMtesZ?=
 =?us-ascii?Q?H+1WwQbp4zrLAREj8/h9ds8mZlbs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HB6Ro6WihXiQQau2e9FgS4+Is5CGxbolzg2UKObL0hiot9+qH/C3JK/+lZZV?=
 =?us-ascii?Q?4E8P/WPQQgHU/EgDOpqpYkWNLe959B25SrszXfeGpd7m0CDosdxi0aleMHr6?=
 =?us-ascii?Q?2dNSiXbXhdtwDB6GpVLuL8eMIcpidtmPg5ZVMMpM6X/nEWQR0uLv2XPs4hG9?=
 =?us-ascii?Q?Zsh0UJJy6eDO8SOShyOtndqBh6AOqgkzwGFGs3/P3HN7/sp8M9guprJwT7Xy?=
 =?us-ascii?Q?YdhNJt/Q4Kh37eONA9c3D0+XAXzTRS/MwtU2Eovci+sEFcjydC/HkIZokb5Y?=
 =?us-ascii?Q?kKki5BZ9vi99AJKUWc9LnY/XNg5e4xTWXnoSvKUKDgTnyO2veRzqR598bD1A?=
 =?us-ascii?Q?ws1oij590FH0jUGJFA82iAUAbsEAkGVyuLqK74pcB3QuIi3GhCUAqcPwoDRo?=
 =?us-ascii?Q?yFMtWKqKdk3tQt5VPf33M9mhQY7M98KUzKJ1wwTmp5v+wHKQvlp+7NJZWlNi?=
 =?us-ascii?Q?aimbB1nDOCK1HT2cVDz+DUylgMf6U2bsFH63Ffn42Z2ulK7rlZIEVynophxz?=
 =?us-ascii?Q?q35jZFabMO4xjb1GBUoMCgu/2e0LvAafLFYFUq/xRHry6ekdppOnDQ2jJ1Cu?=
 =?us-ascii?Q?pFXgnHo1GCSgk6Dw6wFZ5GWILJmOhM9AmmSBnWs8yUdheEcdxTdt1Q8vycvh?=
 =?us-ascii?Q?V5QI1DSnYlZ8jIajx3upjnmcls7QJms5/WFkh0+TIn8+wK/203C/UHMHw1LL?=
 =?us-ascii?Q?MvnnHGt/09o+c99edW69/UOzyQA2n2mKPV2lz0F61PU34hR54TqXP2sIKZw9?=
 =?us-ascii?Q?FJYis7XQMSjxkPCSSMr6DZHlnTZwgwEtHHa8ei4qNVIEMX4YA43U6poqzCUI?=
 =?us-ascii?Q?jjqRZEP14ikcjr39plrTNp1gmr1pGf9KDL3uhL6pWFkLmYjrnpLrNHSxgO3I?=
 =?us-ascii?Q?dmU61/2PgSMH/km6hej3dUZ83mjN37EwBChWIXXwRWEZxDnU4wCs8dRjQ2B4?=
 =?us-ascii?Q?9wtFSeihjsl0U8C6ZMZYki21apJ/Ky3BrTkLJekYFMGIDnNfisQc4HeTcNRz?=
 =?us-ascii?Q?lWqkCpFRaOB7aaAYjPa/RTAPS9Bn9UP83RT+hc+0c7LKZNzu/cfu0pjXjicO?=
 =?us-ascii?Q?JtEUeRUc/3Owvl7NycAS1rIfQpGKTGf9QgxnqX6hPDl0RGgkaJDX+nDrHeZ3?=
 =?us-ascii?Q?/mp9tZ4WlSfQaggHZeA/0acBAzRkhq33RTdxfByFqmt2jBLJo8oSfwSmftVP?=
 =?us-ascii?Q?iqad0l6qMeOUAB+20WYBlrvTxVXCYmv1+abj8BQ3X7NWPUv4dc0loDfIZUOF?=
 =?us-ascii?Q?TEEWLWpgmmQuY4SJ/WPLoQUHpmGu6ltqgJz2rIslM9yWxbOyNczfkW5uLaXd?=
 =?us-ascii?Q?bwYlxZ3TpcH2uj9cm7SrMsAqOIW7vO7Zmln0rKJ3r+cxaCMziV4nP07yFy50?=
 =?us-ascii?Q?E5f3IStS00UFkklYXdZXR1MLQ5c4fv6i+hsVkYtJK4i5KptdE6mgzCENmsRh?=
 =?us-ascii?Q?k8e3awn/zBl/btEUqwSGT1+CwdlHbVWo14eGTD7L0bdVEREzC1OdgyePJBX5?=
 =?us-ascii?Q?IKaQAYjGrLr3xOssoGTkOstPYTgskIBd9O1MD5H7GkAnF+O+caWqkeLAlsEK?=
 =?us-ascii?Q?IEdS1X9L2+mPH9qODUJBMD+CW2E3YFwar/hA/w/3ccQ0/9XZDLxn+ih+SMTv?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eea9a2-299e-4f0c-8463-08dd51d3d32f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:27:18.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azCGDitC3j4je55Z3akKrxuKtWUxANTDy0oV/3TlwDGgAyBOx/ttVhqDRGxn0ytIdM9p+mvUMoaWjaym2GpWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5551
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 17:27:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17263

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../bitbake-user-manual-ref-variables.rst        | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index ad219b531..f781c004e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -315,11 +315,17 @@ overview of their function and contents.
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
+      For updates, when keeping the cache within the download directory,
+      the data transfer may be significantly higher because entirely new s=
hallow clones are required.
+      Over time, numerous shallow clones may cumulatively
+      transfer the same amount of data as an initial full bare clone.
+      This is especially the case with very large repositories.
+
+      Existing initial full bare clones, created without this setting,
+      will still be utilized.
=20
       See also :term:`BB_GIT_SHALLOW_DEPTH` and
       :term:`BB_GENERATE_SHALLOW_TARBALLS`.
--=20
2.39.5


