Return-Path: <adriaan.schmidt@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643FC48BCB
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:41 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.49])
 by mx.groups.io with SMTP id smtpd.web11.8104.1649749403992291602
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 00:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=ICpP4y6D;
 spf=pass (domain: siemens.com, ip: 40.107.13.49,
 mailfrom: adriaan.schmidt@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0sppQJT/Nz2KXOfqpFOwZUXVXvKcp/gI+MD3jGsbq50qUt5t1DZyZOwQxBnAUu8JEPKmRnGVOKEZoWdFOaxYGD6Y7v4m2hbOsCpcvhGinNBf5eFTiUMIUdjIFtRXSMvscvXv/hdmOAhSNmi1Y3di8nI0HA0ZjyL72dzZwoIevmmQ06JZPvT69qz1AezJRH8UquZTqcTXgGoE52rMYNidCFyhsKWQ2tEC9odbYGOJQXUtncVxsQ0709s0LQ3eW0R6jxvNVzvR84W//Pb8F44wdDjYXumtI3jKpy113/s1WPwdkxBwWOYwUPk6UFln2hyVnzxA7KjCN4EpKMWcXH8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im+OaSskhSVI/rg5hiZSR2xuJIPC1b6I1TfCizU1LDM=;
 b=KIZ2tFwhCeQJYMjVuEWGtjw5uXDrLnaE2pPBr5cIw20FSIwnWSA0XKI9BSvxeXffB1z8yG4BVBRw2KYkdyfNhW/ojNNfQOtL4yy8yHL/YUVvGJq4bawcVXGEHnCqqfMr1NNDVF8CNUEOKqdX1N0yzUXUaX0AjQRJ/fe/XCYsHBw2+dCUOSv6e9U2+0RmAg8UAU1Z4Bbd/Y39DiMIMkKaV1IBY2ImzTl8YKGa/PFG6XtOPep1wGhSzJkDQmriTz6TIsC6i9loXaYbwdibF1t73JGsC8JzYlIVqmaw555uP7jJ4xN6SbCKjM4UhsuMdV95O6O7Yr/02oJcP8l09XEb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im+OaSskhSVI/rg5hiZSR2xuJIPC1b6I1TfCizU1LDM=;
 b=ICpP4y6DNzotlhEhGoCAKnNeGRnjJkSqgsa3OPJF7Zjm4SnuczvpByfBC1abXJ3lW6pVQBVKzlbqILHHHRHzBUyy8MPPqtJ8pNSpbRoNV/8ZMjkQl+SCLGA6H7jIxZ3YsYaBBztw1O0yMqSBEhnzPBDqXMSjGsIngROrXDIePJD3SnTjzCZH/9iuzD9xZBySt1mx049i0LBSXhHYjQKcCpj+xsP+NuJf5w+xNvYjP+RQonfPPQ5hIXaNbtRPTwE1A/cG/+BSScGe5v0Ihqyj2PX5Bu8m8kwRqotu8a8n1NAu2z+Sety9t8lCFdbpbr5y0XaXo/dAKy/vihpZRVl2cQ==
Received: from AM6P192CA0065.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::42)
 by AM9PR10MB4370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:43:19 +0000
Received: from VE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::ff) by AM6P192CA0065.outlook.office365.com
 (2603:10a6:209:82::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 07:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT062.mail.protection.outlook.com (10.152.3.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 07:43:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 09:43:18 +0200
Received: from random.ppmd.siemens.net (139.25.68.25) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 09:43:17 +0200
From: Adriaan Schmidt <adriaan.schmidt@siemens.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Adriaan Schmidt <adriaan.schmidt@siemens.com>
Subject: [PATCH] bitbake-diffsigs: make finding of changed signatures more
 robust
Date: Tue, 12 Apr 2022 09:42:57 +0200
Message-ID: <20220412074257.220214-1-adriaan.schmidt@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [139.25.68.25]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.217300-8.000000
X-TMASE-MatchedRID: B6KhYplEuGcOEiuv1tl5LlZKqhTmX+QSLPVNKiCZUVMSEYfcJF0pRf6l
	pfpte41h4PdcWsl+C/MjPvDq/GcpoDfQmMAtWgSaj0IvV7jlqDjM0QPdYuYm92WnA2xO92UpRHD
	XTtwRFPvk3+66bOOjdLqt48ksM9Q4tpptbjJu7gU9UhhE3qgjYaPFjJEFr+olwXCBO/GKkVr3FL
	eZXNZS4KBkcgGnJ4Wmfwe1UhoOXN2JWAcF4dHiOXZJnjGLXoWTyMurVeCewQR+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.217300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 FA9C98BB168EE3865296648981D1909389ADDB0A31143F8B419839D4274CA0A32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129cbef1-c9b3-403a-8476-08da1c581cb1
X-MS-TrafficTypeDiagnostic: AM9PR10MB4370:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB437049E8D2441978DEC618E8EDED9@AM9PR10MB4370.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4+QEtifS53Te5GBBiS/aaGB9x5v5R2nUTZWRq0+Gld25YsPrtaY0qmCq7NeNu48HqcbU1wAl+EfWaEwjYbzaNVhOsjpUizaPMLXgaq85K5C1uk8xyUR5mEFhy5yq4UGT4iE35pZvwr+dHYuKOdxHzd7F7bSqTMwKQqiCqUOsIqM+cEvdXO5dnRoMFXng1bLmprRPKND/AC1Rrvcetaqr5Pu2QtaKd3jTkBj0hBB0E6jVvJq0uL/yopQIOuysB4pAJOZVSmVH0tCMZxXFIhTippAMwys0uu6B2GH/ig1O3BQcwPJGEBs2rlvwkRJJinE+8pjh74qWw4ywfMbinOe989MB1VzjV7uewHTwJZcoolO+IhDaH3L1FS4XhHfk0qc1TbP4105IqkAulQtUDGDRkoSPB6NoMnAFG10Qw6JWNNGo8SWFMTycWkkl79PWFrqrt3hM+zmIcm1+O8HmwVJVSLydnlf4jW+w3ntzQv5TOQ5vH02UCpCGWzlxVl7d7Dx+63yXiQp5C+4aYAaSR0VMn6qH9QFFd1mmBWO4z3n04AObp/p6kYFFRPC4ekJiN2Xp7hWzdZwyj30mZNgAWq2t7V57AlTcW6b3cVFligZb59rFUR3emB+wpy2qgfFY3s0rhPhg9TaPAoqa9l6E584EPGgTocB79N0XgPgOrw+DttuBMTHL57p7hHdpNLiqhy9gootyXtUP+VzAn5nu479q7g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(2616005)(40460700003)(6666004)(5660300002)(186003)(26005)(107886003)(36756003)(16526019)(81166007)(956004)(8676002)(70206006)(70586007)(82960400001)(356005)(1076003)(4326008)(498600001)(82310400005)(6916009)(8936002)(83380400001)(86362001)(36860700001)(2906002)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:43:18.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 129cbef1-c9b3-403a-8476-08da1c581cb1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4370
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Apr 2022 16:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13603

In `runtaskhashes`, the keys contain the absolute paths to the recipe. When
working with shared sstate caches (where these absolute paths can be differ=
ent)
we see that compare_sigfiles does not identifiy a changed hash of a depende=
nt
task as "changed", but instead as "removed"&"added", preventing the functio=
n
from recursing and continuing the comparison.

By calling `clean_basepaths` before comparing the `runtaskhashes` dicts, we
avoid this.

Signed-off-by: Adriaan Schmidt <adriaan.schmidt@siemens.com>
---
 lib/bb/siggen.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 1612b4ef..130b38d8 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -991,8 +991,8 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=3DFa=
lse, collapsed=3DFalse):
=20
=20
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a =3D a_data['runtaskhashes']
-        b =3D b_data['runtaskhashes']
+        a =3D clean_basepaths(a_data['runtaskhashes'])
+        b =3D clean_basepaths(b_data['runtaskhashes'])
         changed, added, removed =3D dict_diff(a, b)
         if added:
             for dep in sorted(added):
@@ -1003,7 +1003,7 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=3D=
False, collapsed=3DFalse):
                             #output.append("Dependency on task %s was repl=
aced by %s with same hash" % (dep, bdep))
                             bdep_found =3D True
                 if not bdep_found:
-                    output.append(color_format("{color_title}Dependency on=
 task %s was added{color_default} with hash %s") % (clean_basepath(dep), b[=
dep]))
+                    output.append(color_format("{color_title}Dependency on=
 task %s was added{color_default} with hash %s") % (dep, b[dep]))
         if removed:
             for dep in sorted(removed):
                 adep_found =3D False
@@ -1013,11 +1013,11 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=
=3DFalse, collapsed=3DFalse):
                             #output.append("Dependency on task %s was repl=
aced by %s with same hash" % (adep, dep))
                             adep_found =3D True
                 if not adep_found:
-                    output.append(color_format("{color_title}Dependency on=
 task %s was removed{color_default} with hash %s") % (clean_basepath(dep), =
a[dep]))
+                    output.append(color_format("{color_title}Dependency on=
 task %s was removed{color_default} with hash %s") % (dep, a[dep]))
         if changed:
             for dep in sorted(changed):
                 if not collapsed:
-                    output.append(color_format("{color_title}Hash for task=
 dependency %s changed{color_default} from %s to %s") % (clean_basepath(dep=
), a[dep], b[dep]))
+                    output.append(color_format("{color_title}Hash for task=
 dependency %s changed{color_default} from %s to %s") % (dep, a[dep], b[dep=
]))
                 if callable(recursecb):
                     recout =3D recursecb(dep, a[dep], b[dep])
                     if recout:
--=20
2.30.2


