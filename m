Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.45])
 by mx.groups.io with SMTP id smtpd.web10.4701.1614048098832722299
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 18:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=eKEkA6tK;
 spf=pass (domain: windriver.com, ip: 40.107.244.45, mailfrom: qi.chen@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd4FuZtTE7VXf0XTikBsyS1Tgg8LhaD8EMOsPBe0trHaFPWczINL0/5z5RSlrJ0zhJyu3tuyQZ4b2nq4+nft8+6F34K2HqortJDmWNHlLAigufCNlpy0/2JkaDUdPOxFK93Y4zJaQeTZ1GnJ/mpMwHkRSX3VUfxU+GOV8PePjNf2YK1dG6O6zt0th7cCLkcZGxZ/tq0ZFvFyN85z95g2MIjgCN7lAznRWeJe+KZaRXQ+NzBIVqsHM/H8QCkPLwPJWIpoQZ4RfQlaf7gYldxmqOLHTXokBaFIRFgEzVJn8368hFN4G2BQnI0FuCgLXJE76+YNkm4E5Ycj5UIKlouOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP/dS0qR56YtPUh56XwpIBNX/iKmtArt3HR02dZORxg=;
 b=fypItw78wcCtCsaWC6gyrU29ViRK09TYqOhD7aRs6SsD0GqGZ9OHKGsznJ9HvFErR4tYJYEhD9dgWcv/gpMengUOo6qwRFBXL4r1mpxVfgNohNydDBHA2ysE1gg5nnYq4bTtgmojrJ1aUy7X5XOnQQcrhi/8uBBKex+jeRF3PJfX4tB3lO0WzNawfysKsEMSN0cJxokCYDFh4me0gtP4tkRpFPKBwRbim1qiTbK0A5MWNHgUQR7U5BNLlqspM8Ec7jKUG5RYNnYNwMyTjTHZkz84qKGUyf82DMD79A0EqcCRzrJn2UsVsp8t2tPvfahYy9EcBPqbOwDnj0dPtdnNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP/dS0qR56YtPUh56XwpIBNX/iKmtArt3HR02dZORxg=;
 b=eKEkA6tKC3cvqGAVxH7o9QSmDRWqmwmj9UNSlnp8Y/7aLpzPITAbbKcdee2tEWECEyJinTdRSAhbLZqk8JTKqEhqJvyYwr/YXZy6/7tgyWv5D7BP8LnkuhBhqSgwa5cSviL3PgyREqZNQYV604oPbVcduDW2+9tjYIF51J1T2Mg=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3480.namprd11.prod.outlook.com (2603:10b6:a03:79::27)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 02:41:36 +0000
Received: from BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60]) by BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 02:41:36 +0000
From: "Chen Qi" <Qi.Chen@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] event.py: fix regression about INVALIDCONF
Date: Tue, 23 Feb 2021 10:41:20 +0800
Message-Id: <20210223024120.10982-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To BYAPR11MB3480.namprd11.prod.outlook.com
 (2603:10b6:a03:79::27)
Return-Path: Qi.Chen@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core3.wrs.com (60.247.85.82) by HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend Transport; Tue, 23 Feb 2021 02:41:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442ee80b-d6de-4268-32b6-08d8d7a489fe
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5085:
X-Microsoft-Antispam-PRVS: 
	<SJ0PR11MB50858C088E9680BA9F6E9626ED809@SJ0PR11MB5085.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	luWA/XTjERbac4OXtxI5Vobpm2IZpkHqLuB+xgiMn+IhboxSN1tdbBsVvzc/Slc6p+OXUblu51a7PA/wN6Kx3/M2BoH/OslAHhVLp76CP9ARFI7I967zQBXnzzvdW/Rz7zvxVH0XDPs38C6YnbrBkdGgc/0YALcqXzbq7k3LE1mDjE2CoSRjs2PerkrdOBATfzYaYxpl1Ixq5IjXqmlTD/h4q+WVpmAtiRUtFXVFx1TontJOSWuuYqF7ZZpLr4uzKIorgKk/OOMCiw1I8HS1kcSIGEqdmd85TSsl6HOIGHZWbTB2xPw90R9ZkD5AhgTcevm6OsM14lwooRkBrh7QsKnWdSGqIeuSwPB3nW7D58fdt4mBMHR0kOL05GOt2JmCF+qK7htM7UUIkpNDVLlMFQPOV7oa6Wu836WCXBJ+pC2D1Pu6gCwo3z5GoKtA4CW+iKQ00/pZcnv40QvKwwKHly3AVPKWjSf8asBOUTXPetM/DLJiGsfkSWKLioU2Z6Mwqb/lPB5MzzVpIfPV1ynAWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3480.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39850400004)(36756003)(16526019)(66476007)(1076003)(316002)(52116002)(8936002)(6506007)(6486002)(86362001)(6916009)(66556008)(26005)(5660300002)(956004)(2616005)(6666004)(186003)(66946007)(8676002)(478600001)(6512007)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?+hh2bDSTFweCbdPBGdSvkYNGzz+iqD6+5bK1jUcgbdFEPLQTslc2JfVDmaKV?=
 =?us-ascii?Q?u/OpVAUkxg4qibDhBulf8emNMeY84d+pCn4AvgcXjnnBQpS6FiBYLQSAzhka?=
 =?us-ascii?Q?pPHK5aoq41eeS3g1jZ6P0HvC7WeeDqgOZZ5XcLeav5SCUbqJ5svCtdqTjdRR?=
 =?us-ascii?Q?STbSOLum+ML5CAMY/ncHxLgsQtPcOFY3pioKrXIwBaRT/xegKuFzxBNSdbPC?=
 =?us-ascii?Q?3grKLGf4n+L8SDwQm+GqSqsy+/rupat8nihkbL5dDdRSEtR4tIVV9irmhAeM?=
 =?us-ascii?Q?fAblKRJLZ3lUxbB6uOLOFHG5EcTKwbtVdqjrnJn1L8nZorKcw1+PRQ24Lroc?=
 =?us-ascii?Q?7gSiWPGZDfTyoeHiLHsA4G4DHeMvqke1MOxpRdVsJe4lzkHCKevLbwRPjRXc?=
 =?us-ascii?Q?JElzqOMQxz4XxJIGZjTWFU8XiyQFPxLGcd/Hvj8NAS47fDFrff2xEYnkA5EC?=
 =?us-ascii?Q?m3ALJyAb79obua1h9foqFnXyMRBxvfAtXGdWLM9E3c98roqt1MDehHr+oXfQ?=
 =?us-ascii?Q?QT6c7PUJc7hWnSgMKnNBcGLd2XV6hciNLALh7QWtFUT/NlSnBcYI0ARBsaOx?=
 =?us-ascii?Q?V108lsxqia55BkNR00jFceSXaNl2e0Zp3IhzBuu1QoMpmEZ1MykcdyvNXKJl?=
 =?us-ascii?Q?fOtmTjbUBXL9j4zLMEP+I07MTASUvwWgz2/EKs+X6Qeh8QybuylOFfyBjC3W?=
 =?us-ascii?Q?Cf/HlTBF8gyThePHukaR+U2Ty6FbmpBp4MkQrmJj0Ii4tZ2h8WKPTCIMtD4z?=
 =?us-ascii?Q?uriU4bYp9wbUF8Gs63A9xmjya5kLJTN0nrJ9Pxb3Cee+00m4QrNpwJL1TnPe?=
 =?us-ascii?Q?hxubQsucOVG6SzTVsSB/xI+VwSFOL4NNITAy9Ryz9ElHv1UgNLh7RYRfCvRu?=
 =?us-ascii?Q?exC/uu4kO14+BhC3tCCZJx2EB790lod8Jll9Qte3t1HjQ/34At/NbWE1Dqpq?=
 =?us-ascii?Q?H1WrDfNSq7D+LR1VV9/8Yq5GmxtQ6ooxpAgwNN7BGt2NYjx/wvDlGpqYKwL5?=
 =?us-ascii?Q?s55YRqpPUh+jAE+vkqF6MBrsCW6HnQAf4rfxllDPDOHMaX8FHwdNzV2KDNCM?=
 =?us-ascii?Q?OmiAWKQOuQVLC6New6W/fA2ZQdqCXoOzu77Q/RzCGwOq63kWrO4Nc43qTkTD?=
 =?us-ascii?Q?5YAfpPKTvlUpZpSZTRAtSRXvLRSHwTrv6R24j/momwxCFlZBik+gNbBeICGu?=
 =?us-ascii?Q?HZwyFTStrLDjZF+1O3svv/iSvBnTqk/ltA/5aWhzpE+o7eWpooollCD2HLdx?=
 =?us-ascii?Q?qQU6jty59auaQXTII0BIfO6MDOZxtGafV/CTmqJ3EGko1JodT5eJJKbSMK7F?=
 =?us-ascii?Q?PGHi7KrxwDU9s+zkKsg3d4E0?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442ee80b-d6de-4268-32b6-08d8d7a489fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3480.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 02:41:36.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVnFhfD2hkMUMA+pMjuVhK81T8bDnjKdv7dZzo11mRmZbNbU+fy5kWU3wxOvd9yZ1mMA/e01jMTYGQxHYRGPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
Content-Type: text/plain

A previous commit uses __BBHANDLERS_MC to record all handlers, but
it does not take into consideration of INVALIDCONF, thus causing regression.

We need to record the name before returned AlreadyRegistered, otherwise, when
reparsing due to INVALIDCONF, bascially all handlers are not called.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/event.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 23e1f3187b..3e5718395b 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -238,6 +238,10 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
 
     # already registered
     if name in _handlers:
+        if data:
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+            bbhands_mc.append(name)
+            data.setVar("__BBHANDLERS_MC", bbhands_mc)
         return AlreadyRegistered
 
     if handler is not None:
-- 
2.17.1

