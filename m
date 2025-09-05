Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B523CAC587
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=GgMm42Ki;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2GQ3aJMQrzjGboQ8lD3Nc9AvfM7Xj2Tdf6Lskq878iAG3FgDiny3B8rtGEGahEfg6PepNcfINN0v4gA40IMjug3V5N7SLjxR0X0HJbrlx0X0QQBn9yOeWeJuFPcs8TFaIFyOEXMZxLUxaAKB5BLl7oXZzWncSt9HN40i9ZqHdteJTNpmp0Zolxh2C7dzKv8Iflt7Q3A8ckvWqydfvLQp5orfkYyVFeoZIY2a5eLk1vLbNcy47DZCBgxK2YilDnIArczo+5XhBzl1rWQRSzFIXV9OHEH7Z58utiNmoz5idCnq8q1admLNqK2Kw1gtfcz2tAcX8xcMDqpvZKqlgzUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo4XWvgrRzCpPyAwi4GEy65BB2pw+iqgs3MqOME6kuQ=;
 b=CCwPlhhIaSo/qw5nG0Xl9JB96PUvjDCZfWWvk01RmVI3VppBED7IOuM6dvM6mlRTY/5P2NHKp392ApJtk3mmwGtBO5zduHFPK1Y5ehPWZzMO3Mzh+ue/IJWqbm3BR682KrBOizaUEcXzW4jlcFzPaTWztxGIAU0MgNy8dx0qCO7SPnh7q2ONfRWQBQUmiiSzcWeZeMCbVXTjU13V8gGN6TA50QyeDy8BTew61OHW8rld6ZWj5IQN9F11GggV22UOCndz4YClXIG9bPqoa/kQh1qn7QDYiiZnCfQGJo/tuCTsIFvoVdeKQoIVUMSJ3UEZwMws/k+gi6gqjevTcMV0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo4XWvgrRzCpPyAwi4GEy65BB2pw+iqgs3MqOME6kuQ=;
 b=GgMm42Kif59zMATKPIIqECVYql3oahNaGezow6CcZM7jVZdQj+jVhf/qKPlFmb5Fp/qBIDRNGzoE/4PknB66YzSLdcxgVlMkzvVAmmbvnMGDylJgSHp+kBymkMe+fmZEHbunkU4OKaxrsTAwnc7uIpQQ7+9UskG7at4btYL3PppZ5+0YJM/CDT+c32mHRuDw6/Z8fV/xXLe/9DWOioU2ZowdU4wBjGYKGSv4IHUTqWogYDLmbXf4NEDB4gz5XdOgiBWWxioyiw7zrsu4qhmM7FXeqjcB6lzcoqMcNSxjyz1Wimoe+MeHJWiIEUdhSACyZmXAJBkw53cQ7sKvYViV4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:11 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:11 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 04/15] fetch2: gitsm: remove dead code
Date: Fri,  5 Sep 2025 08:20:47 +0200
Message-ID: <20250905062058.2563806-5-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: f50c6d8d-9c66-4475-e177-08ddec446870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AInOEYeEqZWCY/otI8CdjcAjBlmT4NkYOgJmC4MaZrt2MZ4uQ2EAE8BTlyBW?=
 =?us-ascii?Q?p4RAGlvmb1MfRRAxGOkzsh2PaN9wYcDRdmr/hKFp8bPZrEdu6kVgQhTjISPq?=
 =?us-ascii?Q?DiH6AHvHCJdVvaP8KwiSihYIy5EUQ+FsEQ8zCSNuPTIUoXUgQ1vMgJxeRwe2?=
 =?us-ascii?Q?r5e36by08hQvM/uK5YFYFcyNOPabuUKmDnj5YOtrdDkZxcKj3wrroNR43wy9?=
 =?us-ascii?Q?aoJBVcoGYV6DmUNTLJ3c+/vPUFVFaKkWTGcVMqYUqHcWv0pkXkcWcGIFZNuX?=
 =?us-ascii?Q?03uvVBtDr926qn1UafyDnhxw7S2z43HB3HBSSkHUg0xiwCbL9/RpvA7k3DTL?=
 =?us-ascii?Q?gGCZA5WKyzoFPo7QjB/0kDSUUbpmWZkFykN51CzAhaOg0ft60gXkW5Fw0Lwj?=
 =?us-ascii?Q?iCqvdbhF+1V8bqaamwAeOBBwT5d/xx+thMtgYg6hQTTGHK+9iZXxzMh/bwUk?=
 =?us-ascii?Q?Og+/6JHXVW8bY9Soudq815bl6O3c+zGLIWNV90jLqFV5AuLunMuPkKkX/RcX?=
 =?us-ascii?Q?TVOCxBBA3pvoyoctZSs2OVhHAjY00TvyXF7M9ALAm+7+Abhkz0hmxzGB3dgl?=
 =?us-ascii?Q?WKE6PV2vG9CRqtwrT7UacoT7w+e1rZRgdh+7HwxQbFpd935o7ERj2E6rEmt+?=
 =?us-ascii?Q?T7WyVZGLLQ7ZWYyBndLsgu0d/By+kbx9FZHIGpWwJ4RyWxj4M44u6xQR28VD?=
 =?us-ascii?Q?j0nei6uS/zN/BzZcBr+0ES2yuU2ggKE8TDRYNeOR/+TASP3k9i5nV7ssDv+s?=
 =?us-ascii?Q?yiSd3VNE2IOaQw97s7S/tpd+I/EUzs1Hnh/AiFzW/gQRfZXbA0RNZe3pOwWZ?=
 =?us-ascii?Q?PYkn//O8utZWcuULITE7eI8h5cr/TthMtJOO65ss+ZBOi2nyScEKGnQ3O++E?=
 =?us-ascii?Q?yk5UfTTP0wRYRY31QLbHtVstuBBFTsaTcW7ACwApr22yuNblbU0B8lnuAthP?=
 =?us-ascii?Q?7E59CXtA+Vdv5v7g4hc3ye3z5tUb58mRCF+RVVhRENOum1wI7CjSh6I0CxOM?=
 =?us-ascii?Q?25qri2kmaLB2d0nmXoIi+SgY/rRMdzPukq2BQ5IPKdsix6bd38pEO5wfDscO?=
 =?us-ascii?Q?fyxez2mcWMxBZGewggZB3URkBrd94OUhcmvpSln/0dx/KCXkOiiXUO/YLfrs?=
 =?us-ascii?Q?02RKyPSQtna4KwWoKwj+O0qAUItDDnvrTdYzdehJWok1/un5LzMvafn8SEgl?=
 =?us-ascii?Q?eH9QOvvKpgbSLk13IuKeNBSSm4SlMsQ/uKnFOMzAE3vuIUT/m+9ht7zQ4oeW?=
 =?us-ascii?Q?He3cpu+R8HxzQWMyxWJdYZZg23K9YYYFK/OC4xCpeor17j0xxGHyP75jm3QJ?=
 =?us-ascii?Q?cthY2WcdBv/hxSLrBmppzC3+phi7gQpApFrT5qL5e3uNPqru5q8ffL56XFcq?=
 =?us-ascii?Q?PJ1OWXLULt5SktGWjvJiKunwlgESQWEVYFN4oE1r+esCOmLNfdLPMjCvZhca?=
 =?us-ascii?Q?RX6IQmfrMmXVWFL+TkttU5jVvr3dyOvavavnbprpDYRfHAakBJnydg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oG59CUWIBc7MgX5A0MnHFQ1UmWQE9jWljEzgeVSefJVJiPzjsG3IBNVKtkOP?=
 =?us-ascii?Q?n43X5l6aHNR9z7BoQb9ulXFziZnf9/YZaNIu+L5KINHWAkEydxW0Gl23Du7Q?=
 =?us-ascii?Q?/KL/82OF20qVh8a32EdibTrwnWSK6GL3MDjsZ8lvIwVJZKym9eC96mzPv/oL?=
 =?us-ascii?Q?BH7TRwPEwwttapMAJKEG0R5caO5+fnbXeNISDRCANcqG/nPkrWIixiV+5xV8?=
 =?us-ascii?Q?LQb4CcX3MpRinWV9lwhsDPa6dyeZL9lZJ0TFnbdXIcAgE5LTmobYtC7+HF/O?=
 =?us-ascii?Q?GQY8mPT02EEu34wci/cJR8qes0pWPhjBB27a+AfmEuLzCgcpELRzX7DZ73ve?=
 =?us-ascii?Q?ySmcJWafQHbQcWa3RKyVpB8MRSa5jOxZO9xblxcuI1Uz77BqDla+tMAcczmO?=
 =?us-ascii?Q?N0UrRhmYY5PsL/FYIsZaTxBbq2noSmAFsAYnK115UGMBhZoHCuXqgy2O3eo4?=
 =?us-ascii?Q?pqNNae2ngz+/eDTgtZz1POmbx4Vx1i9v9JcH5tM0jVU5ofPqr7/NAb6g/8Rh?=
 =?us-ascii?Q?qpmwg+x+5X8Wcrrdp2xzQOdlVKbYm+md8Okl9GAPEIwDXcxg5jIXW/gkko3H?=
 =?us-ascii?Q?rJpFb/rKlueypJV98aGacUkg3n9fw7QixcbAgMVSwDE26AbJy3ImBdEhYoOA?=
 =?us-ascii?Q?jAKAchmi9yXZR52QkNon14zM6EpkjBx6DXChff7b2JKrfKyCJy09f/rkOS26?=
 =?us-ascii?Q?3A5Wln61xrcy0ZGWjNEMjpdZ9PQZLeFhlB5k078jACqAsc4FbucLP1T26Q2b?=
 =?us-ascii?Q?Q7kySzeuc252uBKjjmgjumcI2vMqJTclRFPACc0vmVTHG6jtI84sh3jpJlrg?=
 =?us-ascii?Q?P1k55mAhjbDV7ygFgY9Dxy/jjQzRNPjNFsy7C74kL51c68VcJ2MtPktkhXqn?=
 =?us-ascii?Q?n2Nk3wBPn2n6k0i5xDHalFmhD0I3KiMGgj7VUoCgo+YKuvuOAAGky1x7DmCW?=
 =?us-ascii?Q?SVtV/IMrlVkNswpNmK82sQkkHdo3/h0v2pae64b+IdJzl4i0nxQCbfL0SVn5?=
 =?us-ascii?Q?qZCZOfpDchKdT/tukYqyb7ki484PadxyQvF+SarrySI8dLsem2Vcojfg52nW?=
 =?us-ascii?Q?iAiN30nk/YR5SpTRBY+eZZkFvjmq0mNitlCEAOMT7AzfS0XFlgMB2Bi08koq?=
 =?us-ascii?Q?gvlc2mld/pXeHXy/xAfpO8NBajWnDqRTLgBwu70O5fG30HinC7u4drfqkSrh?=
 =?us-ascii?Q?pUjuCt/knLkivYYQgz2p45wQECD5WyIqrDOwp9gHUzEmp7gB3v1xAlrGs6y7?=
 =?us-ascii?Q?C9Q5PK1D5r2HznybG4nUiW645ZHU+VBNxxPA8uMv9blRCsKyeviBcWWTciBl?=
 =?us-ascii?Q?wIDHgwFew4NQuQnaVutKtIxSyeruKOaEYUg150bLiCayjBzhUV3isgMnjsxJ?=
 =?us-ascii?Q?tQJqZ1PlPzr4/1JyMJhmp5RgVrW2Zf9MGJfVWztA/etr5KggS2ARHZST3suE?=
 =?us-ascii?Q?LBdH1cGdeVRD9dM2DDClzrsJ8pUtpzhfcREfiPHnpEFHh3XBav6DpdF+Zeph?=
 =?us-ascii?Q?93yF2cSPYlbbkiPedEkw/hpndEE30R5S1svneuRRe39RUudK9im5VrJxBT3s?=
 =?us-ascii?Q?8GLXOyz7QUaxJ2L8gS/s1ZULwDl31QincSR9NJ6th0r51W0MTmCZx4S/ubkE?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50c6d8d-9c66-4475-e177-08ddec446870
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:11.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8dFFuzzP3kEt1nBCOiUeU66H2ePxBKRWrcrOpu+RmtHRz2W0NPObWlETP+oQ0pSTpRO4VE733y2eU1+UG7UvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17961

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove code which isn=E2=80=99t used inside the project or the tests.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index d9ebe8d18..9baefb3e6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -218,10 +218,6 @@ class GitSM(Git):
=20
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                # modpath is needed by unpack tracer to calculate submodul=
e
-                # checkout dir
-                new_ud =3D newfetch.ud[url]
-                new_ud.modpath =3D modpath
                 newfetch.unpack(root=3Dos.path.dirname(os.path.join(subdes=
tdir, repo_conf, 'modules', module)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
--=20
2.39.5


