Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C207CDB47F
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=V9wHs6Z6;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H25j4nY4/pBfQykCMF0pGcGNl83UIdLMDpSVhYlOH+ksUy4lkSnY+MvcDpE6t731DqpIgHc5Tqdvj2W33adk0tMXB6w3EmNcSyY3paZEzOLwJ6dsuCif0llXEy9nLSne9YjNWOHnzz0fmwWF412NnKsfQaH5rIWOw5/TMB/W21XC5z+f1xMqxfnJoLJs39ncxOLKUTBZPbooenHIMCcF94Km7KX8lolhvrMXhmk+BTyYqA+XMwLnKYVq6yatK+l5wMZk0vojh60y9rKjaChjzN31m5d1ZyCVr5RbWP+ZC+M3/T7yCyvlyP7Zhbo+WY+Mv9z51P68eYdhjzfuWvUplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/hkcyK+GAQ33Bt9+Ejr3/Fo071hq4V6qV0QeHiKoFY=;
 b=TkEi6hqrCoXGKE6BBaeFnLfBfzuCV1dvEbi5Xg02LqQUfO0cwnfkhjxBJeYDV2aom92mIS9O2gpmPzmDh4PIWvrNf3ocTRT5wff+wX8NesbI3dgPtqzLZqQ0sAMs/8H0znY8Z8v4PfWURsf+l32ELZ/n9D/TTuQKGw8tmn0ciTxaa0W4UlIJbemX5qk+WtpjBGT2qBzib3KYwTWLnhZsB1jc7nkFzQ/jaWqRpOHuqHjvr3Nzmh1fWCI/i4+eOgM3c4wLPkrlnOCsW8YsiOJqFIlbZl8xe4Mdru6/mrKzAQ9IWCHjqayxFq5xuDqi9+qJwRimcbs1SoeBOtUdTQAkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/hkcyK+GAQ33Bt9+Ejr3/Fo071hq4V6qV0QeHiKoFY=;
 b=V9wHs6Z6oT4SvUinr6BwC3fYmCMFaN8Fn0N0cfMc4zuL8OqZtJdSUshRcKnvzZ38KtJe33WNiGFAz84TPjAU2JxVZauds6MDuP8XBW3zqUgUlV/hadXstFEq75vOyQ0NLao+mHsqJaoGqZUDqN+sPg33tEBqJO6LdOKC65lzXn59Ac8maBzPpt2UekHzCgCNdjxhNbU8cM4K+cuxXk1sx5zTuX5lgiImHmX3MUZczH1I+lJcFU8r/zJT54nxJ6ZMjuZn3dwsvaPmpuNgjBkMVQyMUDkwOw5jYfg0ZlfDZQ5guoMl3SxDdDMg9fzvU+Cb4guVfES4sa1KrT777X/qGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:02 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:02 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 4/9] fetch2/git: keep the gitpkgv commit count numeric
Date: Thu, 25 Jun 2026 09:07:45 +0200
Message-ID: <20260625070750.2757558-5-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::8) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d1d251-a230-425b-b035-08ded2887f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	WZ2XeYzagZJED6Kh5ct6lZT8vOUd3hjtIH/YKHHoSD2WwWFdJukhYRV7JQ/JmDYwlRi1rcsBXaWOkMJI/AzcYFJVC/fEgViPRMt6qEStGNOMyuxG9WSpynPCu19mRDpzChiJdmAO1RFkkeQDoyKwOSaTWrwZbr6enfSEP0JLc5/2cl/puLDWHX3fFde9Ot54X0OX3ZwlDEsIa+r062SlqmR0Mkvm7TQP8cxejccl85JIPYa/wW7u14UOcUx9H6KGMlzfz7F5N6WbFy1MYVMwJue76+oYgnwnsoqa4zFrmtynS62vDLVfJhn9spC+MfndBfHuul53fXxqpWfc5d2oHKyK2FY53hNl4IOPfYuep4/4OuJzYVovzJpTE36gwO55uCkrjksvP7fY/IQd2U68iSxjlxYLUlbYDzf8SB6nDPzYFPv6z6f1JRsYWDuJ+JX7wYZiodrGkKWSgSDfs35aRGE+dzdwMyJhu3XnVMh5q040OEwepM/O6k42zGLcyqJsPykR0WabDkdLVCQQ8dOnRNfpShbrAS05BlFizeldEn9NfSJhJit4aEYmYP/mZOn+SLUZrkaZEoEDZHLsboOr4s9PxDPhVr0s7iFANsvabipYZKKfMQa8g8NQ8Er0obEtTIXp881sI3XprUdfwmYH7tnqKYN++mcdxPNtXsHoNYo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NwV78YQtxmsUaBjXEYdPTHVoV2CmxE2G/hqRVrg5KmeRyN7fe4o6ybRxcqdK?=
 =?us-ascii?Q?COYuJOr+0S0BbH37juZfDKpNpBBi5iZ0fgWcEt2FBydfWQImkrml561ueZ8f?=
 =?us-ascii?Q?tVQvJyPnJL2ZlQkkyNWCkqbSlpPWtuKM+ephXb+keQbxNQm7tQfgOcYnGTCx?=
 =?us-ascii?Q?8tgBwkMBUCAGEoPQIQ0p0HOyHH01aPauOfAW2PVf5SeKRTGecOhGWWY9AzXw?=
 =?us-ascii?Q?4CzgqbZdZldlvgRFDpzCW2YEeIIxDKrcdgzIaTaphtWu6Adg9qUiZFk4+cSB?=
 =?us-ascii?Q?PU46rEuJfwXkotZbWjkVv6ML+AU/KG+OOai17BLqDs0qyCN6pNkCSE0XZWVL?=
 =?us-ascii?Q?F58+CeVkBXKFrPNESa7vT+J0z0i68a726rWd9k1TD3AXC2qcA/srwLBBrtf6?=
 =?us-ascii?Q?Mpl8/jnXEhlgUrIzNBQKGSfcwf3IIr97pEHtF2K26JEWLsHjzRffaR5zKL9K?=
 =?us-ascii?Q?OJbKI49yTe00sDqJSjlLEN9BwYb8QFyzbLTMkNxInMuyxAxXnnkTNhvsYD2d?=
 =?us-ascii?Q?yoICRXt5xkKkQgRHoLLOaCRluIdBikDeUeY6jqs0MK26BiR51j/GtRjh/fEK?=
 =?us-ascii?Q?Mb/li2EjdKv5DP57GZAnu8Ig3O5RFGqozL1leKZnzhKWSym8/FuH6irNhfTf?=
 =?us-ascii?Q?zYO8TudUql/r/xZS/4azujhsJdBLaTH217T4pGacYFGMugTEQRMFYIm3tt+x?=
 =?us-ascii?Q?pQY5yCjYjBBS6ao9f8apH/K6QruBG9lCO8Ih24WY6TIb/BRYmJFO/9hiQON+?=
 =?us-ascii?Q?CqPQl4XhbSisD0/mVry6gWv6zLbhN11ViFHh5mOcZ8JA2IYBinc3g8PBNjxL?=
 =?us-ascii?Q?inx1I6gkoANXCsKfki9wOz+U3aVBCL1N1NTIyOphnsElb7wCBKmdZihwXlYP?=
 =?us-ascii?Q?NzDSi7x7ZWwg/ycdTS+9MMH3JwKJkiPapixEcOkfurvYnqJM9NvuXeujqBSs?=
 =?us-ascii?Q?Dxx/0iSYeE3BOK/YNiiJ7ErB6t3/qPIYRRbcH6Qp+l1RrcO0aP4TLdIB7/4/?=
 =?us-ascii?Q?8XCZj/p2NV0TF0EDG8z6LBq/DKIb6FOvXKp93d5MuSFdW8e3vc3moxop/U8h?=
 =?us-ascii?Q?zM7kjay3rqmDHVhJmv8/v4bHVIFvLQC02K9uvukS65o6lypNWcHRdVeqe8PO?=
 =?us-ascii?Q?xJacQRUGWmObFD6RRbSXeXZiQbeeUf+BfMqXRt5tJA1qm1VOk1OsVe0lGx4z?=
 =?us-ascii?Q?nYWe692QfT+36nf08rTOcT+l6Y6WB9AXrw+nns7aG1U69PqF15vnyT6L8WDS?=
 =?us-ascii?Q?Z5aAODafimdlLOMBG/5DS4O8E8t/C9eGSs2BVz7LUGYJZ6eoZWitXjOerEYR?=
 =?us-ascii?Q?FMnWHqTaD1kLdTb4KeR0+c7FFQ1EvQWybXXRVVeOYIyKAJwazXkxqMtTCgFk?=
 =?us-ascii?Q?V004EW5dK0BCaSyEdMnIU0Zz8AcYFEInXtIJTd/jTnyWQZ+UBrcZb8XTmaEA?=
 =?us-ascii?Q?rNS0av/YbSMb+nPRZcQ9WBegGGdKfWqyPW7WTdeIW6xVfFbPce7WqYrvS6uR?=
 =?us-ascii?Q?Qyb+gI7QxL/J1cSyXbhQk12QWQCBcpFYAv7MArs8+6OI93arrKtaEHDLjmrT?=
 =?us-ascii?Q?mpvJn1LH1vN5EFe17FlG6nGD+dZabBTB57FscV6MhqnA02ujIrvnIonQn80y?=
 =?us-ascii?Q?s71ADwLjvt/UPGoxi2RwB80yMJdDI5UzkkQ0fH6gVXQYCNgZg3djBKl2Ji6w?=
 =?us-ascii?Q?ihzdYVI8ORAcpTycaGPhiV1u3jpB8GZto9lhSpLS2dfy2kAav+3k+YX70s5R?=
 =?us-ascii?Q?d5cQOTYRMw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d1d251-a230-425b-b035-08ded2887f42
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:02.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqT55x3BvLVIBW0kWS0NNKGO4mUiuRIneucJlHndOOUOOf/zRSs1BsNvL0o0poPic70Xz8uuM41g4iSaagkTqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19783

The cold-cache path used to keep the raw splitlines() list in
commits while only using len(commits) when writing the cache file.

That same commits value is formatted into the returned version string
below, so cold cache could return a Python list representation while
warm cache returned the numeric count. Store the numeric count in
commits before both writing the cache and building the return value.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 00983b744..0bb2ea39a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -1031,9 +1031,9 @@ class Git(FetchMethod):
             commits =3D None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_fil=
e):
-                commits =3D bb.fetch2.runfetchcmd(['git', 'rev-list', rev,=
 '--'], d).splitlines()
+                commits =3D len(bb.fetch2.runfetchcmd(['git', 'rev-list', =
rev, '--'], d).splitlines())
                 if commits:
-                    open(rev_file, "w").write("%d\n" % len(commits))
+                    open(rev_file, "w").write("%d\n" % commits)
             else:
                 commits =3D open(rev_file, "r").readline(128).strip()
         if commits:

