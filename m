Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369BC5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 17:36:35 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14431.1787074587353912887
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 10:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=zV+dvux+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.15, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5iwEZkSs2mjqf97/YFQo2XBxlZc6gAiGhltx8bU5nCcXf4laX3EPR454jzw9zhmR9wBjKQCs001Goi4U9i+XuGA+itwPTbai1eAPLK41Z5BQHRaPG4taseU8HnYfoGkCyDF37udUcbADJcSunSGoAIcUPaAJPfg9H0SbiFfckUAXySouB4qW957Mo4McVlUivDM9c8HseoNF5Nz+xN+ZIsUpNA9qSnJ48pgtvWcYZoXESBUiKAzyts6dLSnLqKWdjmUOKnKxQN3IIejFx+LYcSH6BZH3rk0VkDXAAo1wI/7BLxfrg605//9ot3CeekdtAwaIJBFUYetIHDshV8Nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAauqCGPpg58vEBIWuyjPP2Jy/Yv1YoX4uMG1S5uK6s=;
 b=ZTcZ0+aukBnrFYNrJ7TFXDATnQEpWUPx17MMHg1LpAoaAWgDbN80tL6tQ9SiCtV2/ngyTzBhoPX6wjK3b12jaYBkqbyEQmeRVqi1RP16gkLu+IwKWsRDhKQg13sIPgHvoLTmHpaSdJ2ekc+P8fFtqNUHDoDflIs6tmA6QfMZJcAcPJU/P8QInJ5KT5Dm064eiqg29isSrqcEAWFMlfNfSO7H0eDARrm0+Ta9W9jzi4wKlJsf+P3+qS1mKgh/RbIP22/1sOXrsLaoPAVWeZUuNRSk4oRBhcWPNDAsnlvJ3mZlbmrNtpFX0LwD96c5r1D6OtqVHRbBIESOg1Fvc+4xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAauqCGPpg58vEBIWuyjPP2Jy/Yv1YoX4uMG1S5uK6s=;
 b=zV+dvux+mrdkMHYJHyYVKkrzM1gJ1AjBeMLqhdy1mTpPXi8OxOl0PPcZ2DJD2dArDHQUZAj+1ME4WmVkWuVkhgRau9+584o/H/1pWrYrcdvhUEyuq+ZNTDuOHsyU93bgEExbJW/H38/MSzgyXVwPoqT1Gn3VfOBvfeZWECdhVOP3TBL58RAB2q2LUEq0pFpG/xwne7dt/Meic1wB+ChT1cyjsn+7doAwGW7HkM267gePcIq6cVz9+FmM7izlTcPyd1ExRaLkHmRJ3A/nvySFXh+vvHpRCAbsw3o3jppBYFSOXNi9TWoYVV/XnhB+ryYHKBM3BHHPcATgIU6A4xhanw==
Received: from BN9PR03CA0235.namprd03.prod.outlook.com (2603:10b6:408:f8::30)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 17:36:23 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::15) by BN9PR03CA0235.outlook.office365.com
 (2603:10b6:408:f8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 17:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 17:36:20 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 18 Aug 2026 11:36:13 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <rob.woolleywr@gmail.com>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] pyproject.toml: specify min Python version for project
Date: Tue, 18 Aug 2026 13:34:07 -0400
Message-ID: <20260818173407.2657441-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818173407.2657441-1-chris.laplante@agilent.com>
References: <20260818173407.2657441-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6e185a-f769-4808-3037-08defd4f3776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	a0Tvang6hm0vB3d2GO99Dsj4CffQGdY0mhegsWI43dUw/KK2RzAeZDxayTxKnUQWAEz3YhOhB60VE0OhnrAFt5KBbrFJ7qYQgt9SePUtvRHERPn6KA54Up9QPJ2TMtzwIwXdsxcJyTNZNkQ9mGLoddhYnwMGE5h5pnTu3rNzDx3BAKxdb2pvJx1kz3jZKAFm9xmpFznhPCPyG1t5S+4dRVGcl9YTDVLYm+VrI0XdDAxn+TctVOfuDCmcbgojyfx8mgjsDFi1fy9MSLzz3wPQf7mCuKkViWYRS62ol5OYq/QO73brDM8/i3UoJQeXyF3hyc4FWqr7it47e5/Ee7PKfm7t8u4kdkKxCuEh4/qXbsRbg43ldEqdQu8ttbGjoyoJ9av437F08Sd/EwnqaCMSPNMN4PnHm1Gjm6KBugwGVBFlYHXmTNGi4btQOdy/fDWSH58STn7AD8xdLxrsr57tgoPTi5SmOtSDKV1egPmmqoTnMaPqHyt9+PvIMLLYZAlA34B6fbgP3Kyki30O9aJSygwEqjP1yVP6AM8yi2oxcX0bxFN8ToU1DeUM3V2ZjfcEpcZuNprY5uDk+Ol5xzr89L3S0kNooYTE4DZgnV5LyGca95MxEbPsV30c5Cs58K1KikNHgaYTFkImxeUUU4YX5f2Cfw6Za6pvZDSv2k4Hzz1qWLkILw+dnChGGCwR47HcxY/MvdLSeWB8n3QDICkfAA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CNtsHP2rYo3EYvI1koXXfKoDqmfXfLiiSEHTbGRK8SDuUvjBF9EJg6yOK5oliM5J8LFqSfIMvtssQbjmqlJmb+OkLlOZYL7JhtZ89WhKeaqZsfx/d2bPmtZ1XeiWyMfLCjIYHvq5ChPNhhEGFFW1PY9vtuQEsDsm+kbVCPu8ZyB8li3T2Usy3PchmK0f4FEH1WLYZEZ26Y91L6R0P2H+8GzLbXK2pSTgB43UhzSdu1Aey3VvQ+eW4jVbhxJwLHZa1RrvwhdQtyHn5EAWPpO84aAFESBL+pppmsWmp/3xnwwcQdFTxWeQ1aOkTzKeFnMjC6CcK6V9Zb1vfVvt981zLbKYlo88AbrT+8aivsKUm9hKy9tTCd5HUvp+pgsxnwvj0OrwYKHfOfkK/HgvtYm1+saq1XZ+IDPo2p8GWivez/09PBQwnP8AOaY7Zt/wnmvy
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:36:20.5610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6e185a-f769-4808-3037-08defd4f3776
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 17:36:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19981

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 pyproject.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pyproject.toml b/pyproject.toml
index 4725e860b..c14a547a8 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -1,6 +1,7 @@
 [project]
 name =3D "bitbake"
 version =3D "2.19.0"
+requires-python =3D ">=3D3.9"
=20
 [tool.vendoring]
 destination =3D "lib/bb/_vendor"
--=20
2.43.0


