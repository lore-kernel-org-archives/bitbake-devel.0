Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4FE9A77E
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 23:06:25 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10475.1774393575250537832
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 16:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=HqxZC0kA;
 spf=pass (domain: axis.com, ip: 52.101.72.28, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLKcqdJzlTTXwlU+TRqcCza7gBe/PKo06z3SUGYUF7zzfiVH9mgV383jsZw2fwyVjgYOBdX9Y1g0f/FBmmANRNZ2NlswwsafLEc1RdkCKhwBh45d9PH+RNApJ0WcWBL6m05rpV2zJtOHvn9OUYNObhlh7pFES5jwfN/cBLuebV1izzB6uR0mNHydrYTQ44+2hz8G/aYfrIlVzgUI4rHRG/uQvWuPotZv/4yGMdElj9/A9Q0mFgsyEft2siXvi+pfWqbQObZRG1sSWNb3Djr3yEiVK/0k+MeUZ+l7KF28OiJXwQ+JTzCaNSBljlKRpYs0l5zX1ghTGKLAUrW35LI+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsx7TE6iN0fQMMBmyqaMIADKzioYdSMIdoAqnpVDtTc=;
 b=OcstYcdHkp0K9DydFPYFc8l0bWlUczRLe8FGOr9LGUDc2X3MI+wTfRWK8VLxv+gv3o4clC44NXQwxTmM2Vy9JoVQ2u+hjU1Dzjo7o9yAaESSUd8M9fwP3ltzL4ZNEAD4uWc1fOnwut5d/JzIHfR9kyrMnucQ6L4UCoEXpRgh6qcTFaHtrOeshBBs3i0bkN5pOvchXM5CgAoRVEAYQnRQmWgqbIlP2lCtN80XNASgb7RJMDOo2w9jXvAMgZG2yuNYzcwX6mQ/vJgMAqDCGsWPyQckhfnlQ2GsgiT27qMb0wEo/fbO6kvC2OVDvcgp4Br7hC6nCWxRlBjIPI0Piv7TPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsx7TE6iN0fQMMBmyqaMIADKzioYdSMIdoAqnpVDtTc=;
 b=HqxZC0kAYfkqPQIQN04eb+20kUIeHNqg/hsZQhOook7X/K2jVtMACNb3CeUUk5WTwcpZ0bQfMfviiyyJLnUxZRVUuQbooTfGJOCHvwCsuaIFksIIdpccByS140hoShOnFkyRFuVNM3TB/uwSK36jXZZwJZ50ZOe1J/ZG/JY4vhM=
Received: from AS4P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::11)
 by AS4PR02MB8084.eurprd02.prod.outlook.com (2603:10a6:20b:4fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 23:06:11 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::26) by AS4P189CA0031.outlook.office365.com
 (2603:10a6:20b:5dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 23:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Tue, 24 Mar 2026 23:06:10 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 25 Mar
 2026 00:06:10 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 25 Mar 2026 00:06:10 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9C9C22A73
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 00:06:10 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 93D04122223; Wed, 25 Mar 2026 00:06:10 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] tinfoil: Only allow one process progress bar at once (continued)
Date: Wed, 25 Mar 2026 00:06:08 +0100
Message-ID: <20260324230608.3291465-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|AS4PR02MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: baf413b1-6222-433a-3bca-08de89f9f0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xRgV+u9o4bIkSxgd6qcQlWk7bG3T5hO17geMVYg6+sLK6zpiNzRkBGgoRMclF3vhczkP8Pw/Mvap1kF/01Z8eXSDuMOkbzDTsb74hH3Um4WbDdPhdgG2YhXXIrao0+jDUHhySFpItTgnbQVpJkm10rg21Sn2/RRraLskDRY65F39Hc+cVJ9sAchYxXwWFxhaDDnVaeAyilj6+QS29DtBEdv8wS2CQ4k3dnGGyP/srJ2Kvjp51XGL0dSewYcaEk7R04d+TlV2SWq/YLiJnkXdvVNKd6err44441pvIqyGMlBtOm5FlXv2+U1jsTHlJCa8y3rszY/RgdPp1UeN4bGAg4z6xEcHMqrvQlXISEC1RB30QCDK9/i/iMjdgFuc3Pw1BBetIPl/WinwuEHn70HdTNPl0N2Hu7OOpG9/GSQh8hVuiv/0JjbVd1MPrctOAuy2YExNnDGV75bqU4XaA0w1Q1xNWgyvPNEu+Nfi5WtZ1UY+F4KqkdP6W1r19owvwOXOz3NVpWqKcfgv90YvF3Foehtf6jEouXNe/RrTeD1s74WWseDJRj0XQoidxB47V3PebHSQFpyQjOsqphef2hrrbQ2c/gYU8deATWA/mYwAra9lKuHK2TCPLg4x2qshle8HGXdhq2UyygO3y4gAt6Hz7b4V/BfM0FuibS31RL7Ac3Qo3ps4jJvDi8xsU5YjTvw2ke/nbqAgoe0CLtvbopFJRawDsrvwmJKmHM8qCZIw69mF/LqUYN7an2bYe27IYGYfHytdyjn2DXUM3+t7iP72ww==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	vCq4gdaYbGnHmTB85Xz1f+xLQuKPgOes+cqx+PEbxFVlTyuDQlyrWIEQFXDWS85jYbs+RywZdgd/l3AkOkbdMijGUM7NHUGYMLA93UA76gqZTrCRpGzLzlL34SW2flh4zE/dMShRyiIfW0o1+186vWE/BATA/rLYSj/NiA1VRN0H7mpUaY1Mxp5ybWDmyiDtsat21eHKBbdG3i+SDPPjLdVo8mdwsTD+D8UgElthe1O1vlEIUPG2+7Dq0RX2uGPJ3WGk9OiGfD5lp7KFGCFLua5R+5mZ12aSM+S0wWVGdtRug3wvqal/9ILk9v1tDvKzy0/OR2TydmjV3Nw+LKkpPbpBYjkVfl2xox2RBdPuHiH7pLYmHSZ0fhQG3TjkWb7gcjyc9Aw8H0GxBQbFX1PALdnNWv/zFx2LaG0tlydtKcRfUIbCodytj8T1w5Ta81Ap
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 23:06:10.9699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf413b1-6222-433a-3bca-08de89f9f0a0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8084
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 23:06:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19217

In commit fcf6effe8c6de015e0ec65f908b606af6d096c23, the handling of
process progress bars was changed so that only one can be active at
once. However, for tinfoil it was only half done as apparently virtually
the same code exists in two places and only the first was updated. This
corrects the second occurence.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/tinfoil.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 9c1768942..634d7796f 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -927,23 +927,23 @@ class Tinfoil:
                             if isinstance(event, bb.event.ProcessStarted):
                                 if self.quiet > 1:
                                     continue
+                                if parseprogress:
+                                    parseprogress.finish()
                                 parseprogress =3D bb.ui.knotty.new_progres=
s(event.processname, event.total)
                                 parseprogress.start(False)
                                 continue
                             if isinstance(event, bb.event.ProcessProgress)=
:
                                 if self.quiet > 1:
                                     continue
-                                if parseprogress:
+                                if parseprogress and parseprogress.id =3D=
=3D event.processname:
                                     parseprogress.update(event.progress)
-                                else:
-                                    bb.warn("Got ProcessProgress event for=
 something that never started?")
                                 continue
                             if isinstance(event, bb.event.ProcessFinished)=
:
                                 if self.quiet > 1:
                                     continue
-                                if parseprogress:
+                                if parseprogress and parseprogress.id =3D=
=3D event.processname:
                                     parseprogress.finish()
-                                parseprogress =3D None
+                                    parseprogress =3D None
                                 continue
                             if isinstance(event, bb.command.CommandComplet=
ed):
                                 result =3D True

