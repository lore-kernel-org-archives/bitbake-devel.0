Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C02C61D85
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 02:10:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web11.25598.1700532599242924091
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 18:09:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=oDMt4SG2;
 spf=pass (domain: axis.com, ip: 40.107.20.44, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUJk1FBF+ULLa5FCCc3tnDB39KEwvesZFnyeTtoOTb20ioLTXr1cWCecfAqF8RtRW07c24xa6A1QJqmaH2YBJhRvnGWWDknS6SSwNhcyiL1p/IXcNfQwyn2r9CFM3meV19luFlNgX/Pa4lBfEV4ICPzBYQ2OpI8EJmXkj6iBEb97WQ4cLnwiH1Q9GV35LKQq161mXcAvmoT0ByV+hkdPsL9RZvAhp6/nkVexZfWYw3LmtpB7TSKA+ZcGaFAeFQkofXN8jKrnK4pXRrO1UB23+MbbiGf/VWWRguXtSaTvhACFe+dfUtyHvndCY5VtCSsYhqAfEkywXtb1GVkyi1NX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbphYS2SRbG5q6i5/GNPZ/AMnPoz/LSTVkD2Dm6z31Q=;
 b=mmLCvOx4Ak+kpCAz2ynMXkQ3rDR5e/snLfT6eB/xASK+TPpc9oqvs4lFhlV1THJCNh2tBqlaF1wkwLPOtZX6yhhGVtvLDJkimTsWdeNPTx5D9XpMSC1X4dNzeTjUK2Ra2QgcwKHANjU+d8pv9Jqg7nh9jVLBdAw3bJxDOEC39YqmNGwEmROAmdrKuR55LYYAfzZYPYtLUcnWkObW2hRT1AVnOOR+SkOgadL/jQySWoSWstphf4/UDj5nyhh/YIqwzaT6xZ2QXlw3jKf48w0orSd3b0WDn6mKqFGt64CdWIvNDwYZQUfRL7W+FLYzFH344erWEj1SgPlD7UVmu8mhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbphYS2SRbG5q6i5/GNPZ/AMnPoz/LSTVkD2Dm6z31Q=;
 b=oDMt4SG2rQTJFPn691YaeWJsitU6pUlGbqoxpa0S27+MHTFN/dwUZD3APJ9nStbeIgViXM7mkl58LRRNhsuUWW/4xMkGke15mSyiglzO7Rv2wIs/kTAydb1YRruuz/V+TD4ngBvHft7Ps3K0xa5NiDS+FT8agD5xO1pRBkfjWJk=
Received: from AS9PR06CA0612.eurprd06.prod.outlook.com (2603:10a6:20b:46e::19)
 by DB4PR02MB8728.eurprd02.prod.outlook.com (2603:10a6:10:380::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 02:09:56 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::3d) by AS9PR06CA0612.outlook.office365.com
 (2603:10a6:20b:46e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 21 Nov 2023 02:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 02:09:56 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 03:09:55 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 03:09:55 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 94052E43E
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 03:09:55 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 3AL29tYI1069263
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 03:09:55 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 3AL29tXA1069262
	for bitbake-devel@lists.openembedded.org; Tue, 21 Nov 2023 03:09:55 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] cache: Simplify virtualfn2realfn()
Date: Tue, 21 Nov 2023 03:09:51 +0100
Message-ID: <20231121020951.1069234-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121020951.1069234-1-pkj@axis.com>
References: <20231121020951.1069234-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DB4PR02MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f17ece-e7ac-437d-403b-08dbea36f4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jYVcIAY2TKUuRN/CvW02ZIz8PTBLA/Sy2jEbtZ1iYA9OOeOxhE/2zHC9G4Vp7r9E6PYwSDjkaVbYyi8/gt1qgB6i5fTDixUDXLxHVEuMcQFHFBIsGkCxxtGzO0BleVbColcj52yj1vTWi6mq8BwX0b+HMlstt0q3SiGPYOVCRg5sJG8V+YiRSxUerlOSV944JXuHhHhqRRWA1bNlXjw5E+at53BmdHJFjVB0bw7B3Qro354wjvKhYV6ya7SXB/PfzZePRLbAuXTPb6N8YRC2mApYwjN8FGi0KPCHOmvuRZArpV4QLTa6RJ+QL4YtMGj36SVyPAAhY1tqpFqpgLjsEbwSp8PWyBsCXc5cy72y4M9lIqJpI6qMEmqbR+XmqxSFSFj28RbTjR21c8/fKYEaRhjK6ZrbbjD7GNX4DENc5UeKoliqfMb45lEREaKyGR77SYIIlIotoXMJQetU/lDJJ1wHgbZZTIANwZa8+QTUMKElwBZE8N2VT1GvMv1AOvuRrBEh5j19swITlzePc44oqv8jGLqFx5aZjFUmy/CdSFRp2mTZAe46v/pQpBgOEAjwil9quhaDPflq2xrmScK8fA2IDGd2S4AxV21WqvDS0UfC/Jsl+VuNyg7MQg44Fy+xxMG9HUVvwfKE5XE+ANI73bYkrQMM/OCuLdJx0x+FvvHi0jf9JrVccf+zq6k4MJG+qX/mofTGuiaMAL/m5GMa/u+eJXzFpOA+ufCmWgfiKQVlc347MhUPOlPkhEZ1RJbjBr97G/C6s4dWiQkNB02Z4w==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39850400004)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(36840700001)(46966006)(40470700004)(6916009)(316002)(40480700001)(26005)(336012)(426003)(1076003)(2616005)(41300700001)(478600001)(70586007)(70206006)(81166007)(356005)(42186006)(83380400001)(47076005)(6666004)(8936002)(8676002)(36860700001)(4744005)(2906002)(5660300002)(36756003)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 02:09:56.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f17ece-e7ac-437d-403b-08dbea36f4ea
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8728
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 02:10:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15544

Also correct the description of variant2virtual().

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cache.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 5ea41c5de0..18d5574a31 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -344,9 +344,7 @@ def virtualfn2realfn(virtualfn):
     """
     mc =3D ""
     if virtualfn.startswith('mc:') and virtualfn.count(':') >=3D 2:
-        elems =3D virtualfn.split(':')
-        mc =3D elems[1]
-        virtualfn =3D ":".join(elems[2:])
+        (_, mc, virtualfn) =3D virtualfn.split(':', 2)
=20
     fn =3D virtualfn
     cls =3D ""
@@ -369,7 +367,7 @@ def realfn2virtual(realfn, cls, mc):
=20
 def variant2virtual(realfn, variant):
     """
-    Convert a real filename + the associated subclass keyword to a virtual=
 filename
+    Convert a real filename + a variant to a virtual filename
     """
     if variant =3D=3D "":
         return realfn

