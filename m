Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62385C0219F
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.73])
 by mx.groups.io with SMTP id smtpd.web10.68437.1738932437003972275
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=tvACbtqh;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.73, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQovdd1SFBTeP4VE31DzoTuzY70n3pqZrXc5JB28BobsjHn1VSZ/6HuN7HswmcUw3IiRMoYoQbL/BdjY1iDOyfuznW981GeqQ0IbTOXn7SPDTqvo5jdMfmsiJlPsxnvRrxemPNhe/OkynHoIUsJlf6muE/CRsytbw4eGvDUsyghgB0wiMClPLZ6khZRfHNjfxgCe6txr+R3AUt5EvOP4FMze6DMV0WIRmncp00bP9O7eMzvvi7vICKEBjkpnUAcvIA9yh7fSGwLvlqzqNIPurTcZ2cxMK7rPZzJLFR2J7NriBLkixilk90Wn6Xf7lHCRjLxJJvxbfaZYWZah2vBU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzFUgWiIfso/6mjgIoeqQVWKrpMELQyXfuLKK0wODaY=;
 b=gaYKrRRKEXQIDjYXsIsJEPI/bESAx8z3jJEsxAm1U1WVMDpb+Uxo26iMp/J27nV4mJABM60poqbaMcVvxdrDEJFqrMP4OvbQIGjDXr8s0nHv86P4bqOcXyhWFxHqF3FvbBrGZKBwN/+32RFDvckOEjgXy5owY2Tsuhvl3q7xxuB5h6WujSOKPmSLJ6np9PBEpxqihHrzTb7W42hFposBrU1NN66YXvIm8KsNMItSvh05h9zxfcK9gEYSwbPvtdGNLF62sOiFvMRPfPkxaU0+kCpK4xYychJjzHzb/EeqFioUcmN7rA0UJxfB1HsEkGOsQNfY5Hbo54VYXZV9Jj/yNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzFUgWiIfso/6mjgIoeqQVWKrpMELQyXfuLKK0wODaY=;
 b=tvACbtqh3+X2E70CshpyurVy1w5YIBAQvrWPyDO+lBTNag/rsM0ueFFBPYzB5jTzX2jxZP2cc7/6rHaPU1+yXjG0rMWvpc3OiLCIVW0hoFVfqbwEqsqZ7NrnyHfVFRa3YedxFxyfPnugVD7etJY84r0djm+exXXHMEpAFkVen/hmodMXr59QHWhVe2YPzznWSTjXA1x1tkCjzW5T91ZsBUlSacbhaWywFaSD4op1vl5lKnCIluSKI4rJ3VIXm+/rIsncV536785UPlNvS4Kegv/g0k1Z/F/tvjpqin4gv1YfOkeqUYzgp9jFkIZMWrklFKSmH0kEn2eJ4OWZFWN22g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:15 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:15 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 04/13] tests: fetch: quote URI password as per RFC3986
Date: Fri,  7 Feb 2025 13:46:52 +0100
Message-ID: <20250207124701.14787-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 44757d97-2beb-4982-9571-08dd47758bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TbJ6G4IXEnEOiaI8PJjWGTwk436cW2+c7wPoRLDtn6DJTYUPIiuLnEp/yIiY?=
 =?us-ascii?Q?HxJfXgVURt2iYIoYIu2NyTCxECiy0whEdQJpDybOrBLPMO/7o92v3heCCwBu?=
 =?us-ascii?Q?30ZcqaN425Seh558efHY1G/3lkQXuBEsDotJCk9OtszuH2HtgNQkPcyIx6Ep?=
 =?us-ascii?Q?BR3Cjjc1oDORSXCPsmXcW8sYrazUWcsEJJHs6aeOcR4GUUfYBJxjrpi2hVMR?=
 =?us-ascii?Q?hCuE4c3n9Uv5cNxXM9n861N+j9Ji+s+at2qECKN1YxR87o8cuuZ4pz1N84M8?=
 =?us-ascii?Q?6PqC5YZXEpKRFqtb4uEk9eJMg0Ywy6IdO0Tj1v2V4zgkHio73UoxXOGXf8VG?=
 =?us-ascii?Q?CpuxZU1ZbeduKcHDTArEvtouRJ8WMNdQK7c9MeLr3oDMtfnYbIlzSsFeTUIe?=
 =?us-ascii?Q?KQxeihVPN9+xlzy2EWgMHcUydRj/yp4pDVNbKgxok+x5D57fthtHHJJ5Tl6W?=
 =?us-ascii?Q?W3f9ESyCbpyrFEZiOGhc/9VnI18AzqRmosvP9WUqQlz5oyaK60+gHJsipMd8?=
 =?us-ascii?Q?NoqzC73K2/2AJOqdJ3to5RuYjS2nDDVjT2Ny1ZijVvi7cp1SX7qSLCsW18H0?=
 =?us-ascii?Q?6kFVoN/4QUlhdhQK9PEKskUyoCfWCU2Rpik6bMgUYOQdJH7bYDLqV7GlY2SN?=
 =?us-ascii?Q?t4iKYfwer/OiEza9Yn3qZFv6luHcGBLQ5eZ4K57KC2t/t0XJ3mXlaI/qnFzK?=
 =?us-ascii?Q?Jf8jVk7XrOvHBSrm/R1B+SaP7f0UcXLLaZ9X/gugQfvbJOgEBDRem56Wq0d0?=
 =?us-ascii?Q?bEVgl7IiG1dC8WMwNAeUceZr9xJJIohUU76K6cTuL3ajcWTjA8e4iVSZKUgs?=
 =?us-ascii?Q?KqjInCo9O9ORf7hJ+Cmw5N2snWzHMBE8VwzOpkaNK78t+xzWpHslQoaiMg6M?=
 =?us-ascii?Q?apuI6I8n8Tqs0+ABwPisNEiPlQoTiJbwiuYu1Sg2CsdfQUHmsJZRoAzN4IUR?=
 =?us-ascii?Q?HWnH759xLLm5FY5zgWHwAHMdHN+aPDzTFpYWprrbpAxXFsvbxajgsEXIYv1Q?=
 =?us-ascii?Q?2renr0lG6OeADip86Uo64z2QWBy9sidAibIgPjtnEjdfTAPD2lRVIsGVx8IE?=
 =?us-ascii?Q?pxhHXbkyrOMZ3BASDZAqfMOoX8nAzHRMms0eXnxIrb6CNTP1t8QjSKyYm4pR?=
 =?us-ascii?Q?BqGVHyYBt+cz2ZjBahZEuP4jpRjNPHB3oZCYxqxGN48FBjhEH7D0KGApkvFU?=
 =?us-ascii?Q?anrc5XLXd6X/VrV9uz5/Ps9yzb4uGgeK2uKzwVr6ZVg46g+6MANyPzZbdvRH?=
 =?us-ascii?Q?Hvdym0czzEvQ4+Nt7KlM76+YNm3xG+HKGyR3RcgbaeDox4AXUL1006ni0nDX?=
 =?us-ascii?Q?zCApIq84yRRarytknjKbcBLpO1m+fa/EVeUCbhHQ7xhtuicQV/BC16Cu/ag6?=
 =?us-ascii?Q?Je2vmttFin50rqkugDK5fYvFkPHK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AEICLa/B+lzhLCQUsL6LIzJGRpABeqKHh8WFl/vUF5EI127U1vWVsNJTrpTl?=
 =?us-ascii?Q?hi5S0f6JSA5gbT/o3qBiIz/hdlBfDvs0YeR5ZgTW9Mx8aiWBLeiL4t8Ab51K?=
 =?us-ascii?Q?BPbRXxIZLn5untvQomcgo6u6gS+/4cCiz9dxByldwLxNM9JLIvPHhsJyewU6?=
 =?us-ascii?Q?gT1DU9KoUDV1WYpTxYopw94hgs8eUwAFK0iTHbf0byyC42Se0pkXhGewGEbx?=
 =?us-ascii?Q?ZGsoxpE4W1mT6IN7vwLYOEEsAB6YmNZUFvWEKeu+0Fe4t1MUUY0YeAw+0Z6G?=
 =?us-ascii?Q?z4Z0LscfGyFeXNtrhuD8lzspPzZtynbyCuXrzTBZhOIddLkKtnMzXGWq9DDT?=
 =?us-ascii?Q?Xj8rlGvIT57ukDbzV2EYureb9IbLjfEKdzViX2FTwtpAsC0zAyUw473IRzpi?=
 =?us-ascii?Q?/bLPV0y+o1DTX+rvA75depCM4nEjeBOmb5FKSQ80veBv+gwQOEmlcpg/WucF?=
 =?us-ascii?Q?hVQvS2TIeM3Kw8pTdTPiqP5m/2GOwtO2/RvUU1NQ4Y7JXwwecSRr2zpophud?=
 =?us-ascii?Q?eHughA5uoYO/ATS5pj47JjdcU3UPVVx2n1z5m6z9LJ/XgXFwMzJIIYVUTQiv?=
 =?us-ascii?Q?2IWJJiENYdjM7g87MXCxEZQEDhfYd8zsqp8cry1YM4Wv94klTS9p1Hcr498c?=
 =?us-ascii?Q?KdFOVbXt6/wHgQEQNDX8MjRmDGjPHd+ULp00VqGdz2YKePhGanPDKjEfBhD7?=
 =?us-ascii?Q?sWDTRw+ohLWDxy9h/Q5mPiyihTvibS4WzGwChe0Oyoxig3Wj5Ukc8OEbPMA6?=
 =?us-ascii?Q?Pd9bId1DWLzckVLrJw989CX02EgwNKDJPkf77CIpbE7IQuUuQD03MCKgyHdD?=
 =?us-ascii?Q?j+SsLMLYssqmDLGCyMVxUuFBqNnNWffU/QXnkR4YrCHn5I6T87VQ1ubuZrMP?=
 =?us-ascii?Q?xJ1tsoky7HQZQVhtckE1DREytVjyAwgZgoLUdJ5gXKGF/ySO7nBgSSZLWKAd?=
 =?us-ascii?Q?xIn7tJOhNHTKlgJvHf06713IXwBzrpXrFEZP2WTLH0YurxudxkBEw/QW6rV7?=
 =?us-ascii?Q?rRFz8TiQzUdFoCxJWY6KmvPOxoNvvoDnCtgbrWRiJnH00gC8OHDVZ7R1z2qa?=
 =?us-ascii?Q?ZMSKtf8Vx632LpZ2dGmuZ07WSY0bsGGXGnuNDl7bkbbOTlMcumCiU80GcftG?=
 =?us-ascii?Q?WErbD5cg+9RE3ws7dipB6u7J7KYl7Lxp+mlU4Zd8d3K7CpJs0wFoj8IOOoNG?=
 =?us-ascii?Q?zUC4MvzlyLCIevUtUNeUc63ZCbNPcb3drU2QBh16CnrAEksWNmaB4VUOyBn7?=
 =?us-ascii?Q?LtamxoyYWLiTlaNrEjX/IdeTgCbhyQH1SVAD2seOtAe9/F0Dq1F4L7YjPWIE?=
 =?us-ascii?Q?nCZyrHcuVdSV5Zul1WFeG8VkV7nA1PaGl4lwbjzMa1QDqH+3ERTVVyJRBDaY?=
 =?us-ascii?Q?exOYS/aQ3nV2j5PLDyoElNBvUa9hfTcb/+BbsbO18Ec8ZuKGpmarPk9xREyw?=
 =?us-ascii?Q?R0lSbMvA7oHDemqO0xu+p1tbb8sbUcW82ccl6GkIrtkJFPG8U3HJKFuLy2D8?=
 =?us-ascii?Q?4129dR1GxvGgRC6jjC/NxMcHrnvsUZU+ZUl/PR9/wqsBuWInl/YjnYOQU07w?=
 =?us-ascii?Q?QDCnDaQZ9ect46E4/yXY3nVVPQ7aChQ57WZHit1KudjSuxtO1b5682TJkZpI?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44757d97-2beb-4982-9571-08dd47758bd5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:14.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y62GC1bsiHQZErbozJDrWvzYEDYk7tVqL1103xGaEfSuUSn7mPgrthvhVNzkAQXPl2bEH0RBXBB/qobu0NlLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17173

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The password must be quoted as per RFC3986 because it can contain
reserved characters.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0f1cb7670..48b9e4af1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1401,7 +1401,10 @@ class TrustedNetworksTest(FetcherTest):
         self.assertFalse(bb.fetch.trusted_network(self.d, url))
=20
 class URLHandle(unittest.TestCase):
+    import urllib.parse
=20
+    # Quote password as per RFC3986
+    password =3D urllib.parse.quote(r"!#$%^&*()-_=3D{}[]\|:?,.<>~`", r"!$&=
'/()*+,;=3D")
     datatable =3D {
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/i=
ndex.html', '', '', {}),
        "cvs://anoncvs@cvs.handhelds.org/cvs;module=3Dfamiliar/dist/ipkg" :=
 ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/d=
ist/ipkg'}),
@@ -1410,7 +1413,7 @@ class URLHandle(unittest.TestCase):
        "file://somelocation;someparam=3D1": ('file', '', 'somelocation', '=
', '', {'someparam': '1'}),
        "file://example@.service": ('file', '', 'example@.service', '', '',=
 {}),
        "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234" :=
 ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtok=
en=3D1234'}),
-       r'git://s.o-me_ONE:!#$%^&*()-_=3D{}[]\|:?,.<>~`@git.openembedded.or=
g/bitbake;branch=3Dmain;protocol=3Dhttps': ('git', 'git.openembedded.org', =
'/bitbake', 's.o-me_ONE', r'!#$%^&*()-_=3D{}[]\|:?,.<>~`', {'branch': 'main=
', 'protocol' : 'https'}),
+       'git://s.o-me_ONE:%s@git.openembedded.org/bitbake;branch=3Dmain;pro=
tocol=3Dhttps' % password: ('git', 'git.openembedded.org', '/bitbake', 's.o=
-me_ONE', password, {'branch': 'main', 'protocol' : 'https'}),
     }
     # we require a pathname to encodeurl but users can still pass such url=
s to=20
     # decodeurl and we need to handle them
--=20
2.39.5


