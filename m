Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A6BC0219E
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.129])
 by mx.groups.io with SMTP id smtpd.web11.68552.1738932444338795086
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=0L7lKpE2;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br4I4Rg6LiVuLGmq4hlqdGf1RIg+2B4zg4+Br21bC8vY47y+Psj1AMjNBwoyUfCyrPh85K2jvZWAt9rsXJXnyVHFKGewNFTATpxo6QUUkuYi3xYkbSy48DiM9UvndNDLBaNueu92hV9YSki49nWvW52jy+z8ltkSB1eqduz1k8kiH86jQ7Q3ZF3kMOC2kjH2Cg04tYa2tjL8NXAkoECk+gdLcK+LtO2WVnEPq6E4HeWrwQtmyxhfTUEdtYElSKkJNvzrJM3h3XPAHK+9Wnl3ZiQxoidOLiGwc70N9fvl5zeNbAfCjUHCvoIiXSu2vnlrTN3dbtgel393q4C/c8Fohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6ZgOrag8iJXjdOgI/9BpkRMyn+KH3zr8RLFBmeM6L0=;
 b=WptDtE0flq94QpVLPDI/ewLrV1L0Yf4NSwYo5j+wJel4gnzjh79DABv/xQeVYmm7AGPizX7qYIecfvgcomqla0fNdioEy46fmOXMuSrr8jPd3048l/R5BAhb0LbxnPLgBZpXwPrjwJBQeMEmc8xyUuX2IZfyF0LraOP8VdcNF3wCtgHVwJOhScIEBfBmh0pS9qks2yaRqOgKprlGtyhfkYxS2OrNQifNE5o6o1yrrhSlMK8FWzeOnGppf1JfjU0CT3TgVelk3fncGWfJyGnHmz/u4ezn5ArZ5WyhrDGCttByo6pMkYTMRdE9g+/CAfvpwrCPgdQWbfHiKKQJI8u0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6ZgOrag8iJXjdOgI/9BpkRMyn+KH3zr8RLFBmeM6L0=;
 b=0L7lKpE2sp6NKZvaGXrs4EpD0JlhlxEwPkzdBwxa3H1zYgLHCCr/HyNssWVmHmEwxtz18Uq03j97ITW5cAJUHNbE1nhaIHb0yUEDBXuSvhcyJgRi6gCOtn0+GccB3qWNV9Dn+eadfjJZlJsj9VJVxYDOdFsj9STDMO6xXUrlM1sv01AO+TTiV6OKbfqmtf47KSE7k0vI6HhWPalEGh2Jp68fKt6pPzUp3gnL4w55CP9SRcWdtyvsEYBNjgRphQBuDcreD0M/sqYHbxzt7sc+13XFGBeXI1AStBSKRUQvrtAP9EXbtljtadZUTZsM8Xh5efijEJKz9GI2VH4h/RcixA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:19 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:19 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 11/13] fetch2: remove basepath from FetchData
Date: Fri,  7 Feb 2025 13:46:59 +0100
Message-ID: <20250207124701.14787-11-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 329150e7-a4d8-4b28-a5e3-08dd47758e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9gqSRmZkJurabMVlYnNjytnHLdP78PcBQs/o3XymBOLjC/N9mjQYahOG+tbE?=
 =?us-ascii?Q?BZB+qFlbmSoAeyCoYGEk9nb3rc9jYf+rilVqnVhV78JZSAf2DLjJwJp789E3?=
 =?us-ascii?Q?ZpMINkR6LlXI9MXw6p+Jq3ElnmdBZAjnZ+KCHXUlpFxLjdTYH+P98jU3mXaR?=
 =?us-ascii?Q?VbMr9+KUwfVmykxnf+dCied3JXzlNrP/M7CytB48dFl3L/wPQsYMQTigcrbd?=
 =?us-ascii?Q?Ln2tM93686JbL5LMyoyYBeGXCEXe88JUZRz1Gdyb7+Jglgvgqwvcpp13bah9?=
 =?us-ascii?Q?oxKKxPJr782ucImg88jgppPFkYNErQhW+W8NRPLldiu2Q5BbfsGmO9UeO9pD?=
 =?us-ascii?Q?k2jf3RyLEAZVFAv5F2bbfaF5qGrQ/Cw+jJ0qxW0vIL6AIpYUS/nU/01F8v/h?=
 =?us-ascii?Q?kG7PHYN1emu+awaXWUVQIdoJom81TJCvra6wlc/+x4qa6chwCEJXEzI5DHiI?=
 =?us-ascii?Q?NA+ofO7lhC+Pk/7HHlPbaphaKfdDir0b4ZIyqFddBquo0Exl3GJGKC0gLxM9?=
 =?us-ascii?Q?Eh766eiFCw1Vb9WAZd+/LXjZH2MDsMcO+UfyrBRlGNdyTuX6wu9TX3vDw4BW?=
 =?us-ascii?Q?UNMhjva1lmJ1r+dRfO6Iz6o3yqbu+886U/e6vSu+MQwOasc3fUe0MxVl85JF?=
 =?us-ascii?Q?kUTRlX92kKr3yDn5vupZJqdA3JxIhpVQnfBTABLzRfCU9pPZCp8aQPlvwU7R?=
 =?us-ascii?Q?qexpDT6sEu8nptSXSpPqwv321/T8He0WizlPAgnx47y2nZKRKYGb6Js9Irbq?=
 =?us-ascii?Q?2y4MDYBDKg3VR7kvjx6k4JxG77Z0LZM0su1pDZ0JApZttwqF/Vs0MBLh4xLF?=
 =?us-ascii?Q?6zBScTkRO+jAcdyYEaydl5xuvyAedNMGoatIsziO24pLKa2XapIJ+vJ0ZKsf?=
 =?us-ascii?Q?V3HRtGr3XcJbnKUP1r1Pu+4e/sBFLzK4QuEHgZkZYtEZ7SNnjq7szWbVWn9C?=
 =?us-ascii?Q?aZXNOgv23HLLvkqzF4w3NOVRXolQx8l9xvuf1tjLtMZmIh+7KqGzr2Ov95dA?=
 =?us-ascii?Q?BS7Of8uwSXxXeoK7Z+R2MN7ca5bdESIGF1UIyj4xUn+6dW0MMxPJ+f3RHFh1?=
 =?us-ascii?Q?0juszuF4Tye344OK3vcygsJkqJrYv2PeMrmMzc4xJgF/8+xy2XoP+6jTU/RT?=
 =?us-ascii?Q?LHG77xHlaMkbj7mgzi7b65GryeXcslWZg693mcaRAlZN5K4Mjy/9PZJNkgfs?=
 =?us-ascii?Q?F7cpaMaFFQ7P7H23TZx/XKoy4Hu3S6i7cX/FGqPr2wIIF+TeqIWSTx3oQwd6?=
 =?us-ascii?Q?gurOIgh5cEYx4ihodL6+qgNMCiGT6EZ58REd3LoeUlHVGb8vSb/rMzt2puOp?=
 =?us-ascii?Q?CqgMUQyZjIHeCdcSnUc5pbOW7KNYYZ1A4NytyH+Ewy8VzXSPn5xuX3v4ye4d?=
 =?us-ascii?Q?iMdqE1EuXmsCnE+tNUiq4pR8ljPBXgBKYaBzD3wsqR6bfb9SbXoNNyT9vx0i?=
 =?us-ascii?Q?LqngT8bM+eFYXW4M+DoxDLiNhT97+Qcc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aIu/n2hPub4okL1g0/L0eSLhxWsRoJjhham1JYwh0crNRBIE2gGJFuigoVbr?=
 =?us-ascii?Q?bvE3zoD3xuo7dm/sCtIDNSfiy14jqC1sIe5uQW9Cv2JTFE63IiUv5SoF7wH1?=
 =?us-ascii?Q?iPr9/70/cHsLX4YpNWwzVOQK/pqpIHC5zP2O/oLlM1eM8ySn17BtVbIgq1Z6?=
 =?us-ascii?Q?UBg5zf1hL2Cri40ewHGaDoh17kotqVHoQgzmi3CT2NR4yS+gq+/w+OJYaHH+?=
 =?us-ascii?Q?gMaewebooyb3EtNGANA6k25/AWu/q1IeHtxEexx6UVXxgtfxj884t3O5DBJC?=
 =?us-ascii?Q?HPNFBdC4a9Dw3CGoAivsENl9U3LjX8YhMyLhySj2/psQGrgHuSFNmxjQe1Mt?=
 =?us-ascii?Q?E7/C+NyilXntVLzbKFe872SdH42eoPnot6X+yQ5KNfp34bEVojzIwcvO/940?=
 =?us-ascii?Q?3/MQ3Dr8VDRFkvAqQ6lF7jikKjdGAp+eArPX+qkC72oPlTTlfZNJLlF8AwW4?=
 =?us-ascii?Q?+Sa3bNOLKChn7lNmHL821nx5pujufuS3/iabE/0mVQ7TrLSJWO7wB4G+R081?=
 =?us-ascii?Q?L3ZJFESrJo8ExpmphLEg+r0iJmxH+LAiGe73j4Ox0WeRwsDj3n8D9lLc8QVf?=
 =?us-ascii?Q?FaNzSr+flhcQSjsND7rDDFvt6gDPWnt4oVJsmYtTk4fUnYQg2+fppxfK2fLj?=
 =?us-ascii?Q?a2tW5KLMy5FKqmRyW3DSX/M+jWnlSnV4YIvSFcC15+S8miqznT3wG4PJMeP4?=
 =?us-ascii?Q?+5kjbb1KXq0mn1hXQHceAFbGRfBbkuKDL3fAQeuKft69QResuLKbJ08uYOcR?=
 =?us-ascii?Q?NKBuLJTToov80qOyH3lJvUKPD8uaQdXoBAVEhBFNaHn84IW4JY76BrXnaYCG?=
 =?us-ascii?Q?OwoETOMDlB2JKRlkjPwXhIAbk2MajiZAm8d3aarVQ55rUgDXSipJEB4irxbK?=
 =?us-ascii?Q?WO0et5ZadI1Vhs47OgneobKZWUoCsGFMFk2gf+/vrN3Sc7FuSZy3zU5pMQFb?=
 =?us-ascii?Q?9uBahaIEcKWSCtXtCNNexIei6ioN/LZev5nyM9RIHulJpo8W7p40om1SN0Xc?=
 =?us-ascii?Q?OFLvrQ0rcpt8FyQ/dt2XEgLQPjcinNmjJjh10dEbFcCGDRVilJpYMDwkRGP5?=
 =?us-ascii?Q?yuW/LwS4MYCgnpPp0zStBgycB/DlWtDlRrcQUGVX2rTc44UVUNhG4pCzo8i+?=
 =?us-ascii?Q?o8VaLY1uPxSJbxZFjszYB0eQ8f0ZDckWJybWZ+nHzM2cZ0sYj4lRUMoP3UVu?=
 =?us-ascii?Q?1w7tZUhdbSU1ZpV0AqvD2CNc71bfQ19AlSO8Ko8T34EUuSiWRC1czO51lIVl?=
 =?us-ascii?Q?UsvExjb9yweQ1eEpdHiArmq/fBdZRoMZVAeGtXaQlx/AMzDBpKx+5L0K85R2?=
 =?us-ascii?Q?BgI+nsbisqBnYAxJhoagtVnf11V4Wf4n6NggsJqPISrNcT455apoO6STBD/8?=
 =?us-ascii?Q?2SdepBRUkiW9zJ6/Q6+YGtHhfTrVkW0r8Fv8h/4iRn1ajNBGynQWnPzAZLsH?=
 =?us-ascii?Q?DMbY6cKZlrHhoahWseAEEgeHWjMtB+iHweilhOFIoofH2/IkUGuL3xHYsIi9?=
 =?us-ascii?Q?Z1X2jHuwIqALOJXSE0q37UetIP9i+7h3lKi6KjU39t7c5gyOTYcCFvZkyjCF?=
 =?us-ascii?Q?qx3efbTsneeRzcD0dKXKOTvrQZRbBehd+5Uk+2HS/yuwmUbhGijv5u8bKhKa?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329150e7-a4d8-4b28-a5e3-08dd47758e0e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:17.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGd87JvhmtTD0Ar1xHXsyXk0+GWvvW8xG5At1EnPCXajb3bRHiIIXQU4VYqxiE1IhWTQu16+JO5f0INmsRuMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17179

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the basepath variable from the FetchData class. The variable is
never used in the class because the only user of the variable also sets
the needdonestamp variable to false. The basepath variable is useless
because it contains the content of the path variable.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bd87f18be..a680783c4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1270,7 +1270,6 @@ class FetchData(object):
         self.lockfile =3D None
         self.mirrortarballs =3D []
         self.basename =3D None
-        self.basepath =3D None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm)=
 =3D decodeurl(d.expand(url))
         self.date =3D self.getSRCDate(d)
         self.url =3D url
@@ -1343,8 +1342,8 @@ class FetchData(object):
             basepath =3D self.localpath
         elif self.localpath:
             basepath =3D dldir + os.sep + os.path.basename(self.localpath)
-        elif self.basepath or self.basename:
-            basepath =3D dldir + os.sep + (self.basepath or self.basename)
+        elif self.basename:
+            basepath =3D dldir + os.sep + self.basename
         else:
             bb.fatal("Can't determine lock path for url %s" % url)
=20
--=20
2.39.5


