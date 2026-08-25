Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6241C61DCA
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:46 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30470.1787687202800229769
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=Gqbreq3f;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.8, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlC05DhS654SzM4oUuN3j920/Xm5qM9w8muVbg5+j5Sxw+SN7IdsipnuXFw2B4aLKhp2xpEHLJA7PR99k0ZOzmTfdqJfrT6q68/ZUHQv+3+dnSGEQhFQtAkUK0A1nvHUf4VMF17L3BXBQlTvtTvbTm4Wl2qCkP2iLRUMaoqbc42vfTELOEcKxhkn/ZmvS3wScq3vG0Cju00+9bFHvc8kg7WddLoNpPfQRk+6+HRwEeQiqgqjG3XhZYDW529oYJBMCJWoqQ46h1nH6h90IMDag4TI+6bmcStFSOvf52na1LKoX2L5V6T9YUNhmZH9RvVqjWcrAHMq3ilpDu3r/X0mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dekyU+sZFDlO44HxK4xlTLdyZR/RYfIGv8YSWzFa0XI=;
 b=v1aabnaOpiScBRCnzwArLRTJnMOSeY1h9jrzWF1XL41ka9uxJKeIc+I9UNE8izOpdf8dQeRPHuPGSFeZUES3b+bXdoZYA0mJvzNRiQLHZeVxL5lQWB4M2HCTDjY4ftvHwsJbA7kAwEChssf6vzvNUm2mkb1S8d/hApBOqwG9eAj5TsSoPCsG8C2FXr2qm8KgxeuGWOswXHPVzMERKP83tCU/yfpCDS+jTYvw0l0kG9uVDFnbYmrQAKbunk9x89PhoyJjZj3vSLUo6DneEKGNNlVfk/l636auhuTP8qi6KCzoIfB80wzDXnjJDw1Q48ildsrU2yj4QR5NiXveDO0t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dekyU+sZFDlO44HxK4xlTLdyZR/RYfIGv8YSWzFa0XI=;
 b=Gqbreq3f/4w9YN6eG4nMNFVMHP16lzF00JSKH/aZFahcTd8xLshiKnaZ9YCW+AnqPSAXXPbDmGnYYpCK9kgup6+/WFFfOMT2dIBISqGNTYMLdk0K4APeskW1OrumjD8WuPuMb071FPgHfePTm5KCewoVGKziuiFYyWr+kK0rhmmAlWkgY5BpOkg3Xa41b9g2XIBEyUkHN4ZpnUx/F38ikISRshv20DJ8nV/Z9eFZkizoMIb9GDLB2Zp5c3TYxjRdgXejJu8wd5XJ0m2Qx4zXTXwY9v0pgmkcSmGal7Ts7sOtZEp6f819qcKpEkEjTurhKdlik9OKmAfrljxh05m6Hw==
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 19:46:35 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7e) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 19:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:34 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:59 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 6/6] cookerdata: cleanup imports
Date: Tue, 25 Aug 2026 15:45:49 -0400
Message-ID: <20260825194549.152553-6-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825194549.152553-1-chris.laplante@agilent.com>
References: <20260825194549.152553-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bb4369-d701-4ced-2641-08df02e191df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	mH86CkIvryC7QInOojQ+4BTgnJogfy4fEaKZ+s23KOi9N8tpKGB6BOdqeQPYNJ3q96XaGrHQ9hT5jij3XW0V1WdyVh1oPfXkFOkaIUlKvgqcoQaJwpuatRCSLgSiAnpi3xPzo6SrHoJTVOTL77ur+amsZY4Hoz2VuCV7pacI0vuLVTxwHyhl8SFmcNvvsXlkxhhK/VxvsbBRC6E8ldLYroanw3yeqfahfx1PGbzrnwNPWgKkjEP8F1GPeOo+qSNKWfOOiq+Bmh5teQUU2NY8wLXJs0CCbLfdrS4QUqFbheCgbO29kXDJX+oYPdO95XlSBTEqpFEru8AhoiANd7OW8JT87STOyz+Llg8dqwOExfkg9y9k0gYtSHVlUWTTjGTN8Wc9RJ5XS9mBqs5MKfH3UCqwFTmxiQVwXHDn92XGkJJoID+9O+tzgX10Ocp3KhFUL5O1ZwJslFNSzwH6RN5b+bCqtauwzLXnJQQDTTsQDVYClE/pDFIjpIEkjRD5Uz8VXyhigLzrCo1/wQNs3zQH4Vy3kNvFL9twi1URyCFsZ5fFqnhm+pNg17WfZpGQi8pBykroaA+F+cNheEjx9/zdYeTWpUKrnwrCivIOGFDyyJyuOsxyigHYSEwIRqWu01L7IdABaoAKwg0VhTiwYaPjjLgEdwx7k5N3ff1qOFzNH0hCQQJz0+2DmKjRgschc67YBLI/Dl5+H7JWZbRzLDbHXQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	L9JagoSk8z7dQQ72EHQP2VH7Hkv2fDh+Qnvte98uIpT1NGx+bcNfIh9dYhOTN2FQ9yuAJnd8RTfdAGxo5HWKy6sMl3TvXo6QKWu24rF50uH0QrN4q8wXmugtFDdfKdxDdKRaRWYTiquzIej7uUbj2/lQCidTh873AaC807wtSKY2rALDKeQdxZgmPmzwmN52fyEHCbolpz9nftY90ZpAh1sFIl5cQzNSk2NsgDjKUFX6cTjZlEGCrpPeZmt7d1/oTi3XX9X4tfuPKHZopn+PiISLoXdhIRaY2mycSZOLU/4iYVpAsBjLDdF/gPZITdtpl4b3V6070pQh2iSPGVD7VcXUk+moQ0hLeETE3Maefh27348hBrX61S/48Ai/SlWCDQ22vr6qqJzbfUyVBvz6elVEbSM4R3yPNetvIrPkSujDFqVI4Sx4HTB2Eo3hijHU
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:34.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bb4369-d701-4ced-2641-08df02e191df
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20047

From: Chris Laplante <chris.laplante@agilent.com>

Get rid of non-Pythonic 'from bb import data' in favor of 'import
bb.data'. Also add all the missing imports.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/cookerdata.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 59f808c96..d307bff0a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -16,9 +16,15 @@ import re
 import sys
 import hashlib
 from functools import wraps
-import bb
-from bb import data
+
+import bb.cache
+import bb.codeparser
+import bb.data
+import bb.data_smart
+import bb.event
+import bb.fetch2
 import bb.parse
+import bb.utils
=20
 logger      =3D logging.getLogger("BitBake")
 parselog    =3D logging.getLogger("BitBake.Parsing")
--=20
2.43.0


