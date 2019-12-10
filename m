Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
	by mail.openembedded.org (Postfix) with ESMTP id B30817FC59
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2019 19:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=PV1etK7Y7vZnfHIux69YIpmLsJfmaZYsh5fdUF4ZzIcEnhRkwl9HAbFgexQZ1T7/wRFPnId6z+Vr1rcOLeae7nd0mr8Xez+mck2DbZcjb9Zjj4lQh7BwvtyEqtY4+Zu/EMSfohKTNWVY0lMvPxpBxR+1jSbCtpj9EZpYg8531vvoUQFX2F1zaiQhACk+292WMxK6ssiaWgdmFwjlBsb95SWkh+SjGyJ9fQtAJ6fuGgI7RymOYuv93dRGOTZdHv+npJAUf4bzWdP7M8YIgeaHfdoqQyK3ImP11Fg/HzSW4pA2CiYOTVuGF+ftlmslgBh47F4ZVZcPv3nJy8KBPEElXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hM5n5wqfFqixQ/lM/M6zEM7u5GaaDR4tnoHyYElA1XI=;
	b=SQy4uhX36IGFRdzg9Xm1SWIiQ2lSJUN+DwsVpuY978IjbmPnnJrphBpkTLbn2jBv4j9O7rSlDjzrEuxOO/O2s5fRPU061q7Ru4dUlua2LEmCKRLm4kx1YdxJGImbS3nerpjyTCtKSEGCP3fqP0FPr04lAduNXdQBRY83NE9e/Oy8MiHWi+FVH9DvrP/HovtvLEfJMvE5azae1Snq7nsMMDtSBE16Ws9f0zCVp6bvMP+mqW/Cyiwu+lEaVoKQCP+XIJRtbd0YenGYGoqET64AS6WQ8Y2zguLaSmkZhsPdHuHQJl3eSInx5wMQ15mdqLxvvOIgbtdWTmjDuDsI/tZcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hM5n5wqfFqixQ/lM/M6zEM7u5GaaDR4tnoHyYElA1XI=;
	b=nZxotspT6F/vsM5zJDkz2fCEKldVeU+3S62+2N0CjPXt92qqivuRqztAFJejbDg+sriN1cNseSh3vyXtlucMX8d3TDDJ7SJwZZ6lTK7sKWCNM4Hj6WZRO0BCCDEcMuH0mbdL1eDZU8HJk5O1gJHwhmiHKj0rrp3K50Ykom5D9K0=
Received: from CY4PR1201CA0004.namprd12.prod.outlook.com
	(2603:10b6:910:16::14) by DM6PR12MB2876.namprd12.prod.outlook.com
	(2603:10b6:5:15d::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12;
	Tue, 10 Dec 2019 19:10:32 +0000
Received: from MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5a::204) by CY4PR1201CA0004.outlook.office365.com
	(2603:10b6:910:16::14) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via
	Frontend Transport; Tue, 10 Dec 2019 19:10:32 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	MW2NAM12FT013.mail.protection.outlook.com (10.13.180.80) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 19:10:32 +0000
Received: from localhost.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Tue, 10 Dec 2019 12:10:24 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2019 14:10:20 -0500
Message-ID: <1576005020-49841-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(29502001)(199004)(189003)(44832011)(8676002)(4326008)(246002)(2616005)(336012)(956004)(426003)(186003)(26005)(6916009)(356004)(8936002)(70206006)(6666004)(2906002)(7636002)(478600001)(316002)(4744005)(36906005)(107886003)(86362001)(5660300002)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2876;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b423106-1713-488e-9d65-08d77da4a0fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2876C19D192AA468AF2EAD7D8B5B0@DM6PR12MB2876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 02475B2A01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9fQrB9GNij2yUrkMOyoOMmZEdlHju3oiZD7vUHxXzoPbq1+r1clBtYD1w1j9ChFLy4dn3vvFGPAR42TxLU1eS35B/Z7dpbX+ew4iiNqLwQyT/XrY+CN80T2hpWD4bWfTYPZtovakd+/BxvDZ/uRQURM8Z2RBU2Sh9TdJvNSOGLd8o3ULhT1vIlVpP2hBzmGSkPijP1f8ll+ee6jfgZ1Kg6TSZ8mSTmiU5bwyk9l+ewuiOv2Ve1pF5sWnLrLvgS+gHwqOKWRYgV+oRVjYNnpf6cHdLfCK19SHagMqRvaZWxrGFwUUNmOdMLav296OOKj4oVn5WUQ29/rNtAew+YIoHPnnBf+ICGMc6UbL5q0QlBvCmg3Af+9Z+x2ggD5poNL5JmzyAyrWFcBjnfI6S3K7vYxusSYr+/S30Ed654/crChtj3DKESD3RoD/5VE9ZUwo+40GbdoCaxgGw8jgorNp3UsCt21HOWWHHHPt+qzQKfueKBze1Ue+lAurF37a62m
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 19:10:32.4173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b423106-1713-488e-9d65-08d77da4a0fe
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
Subject: [PATCH v2] bb.utils.fileslocked: don't leak files if yield throws
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Dec 2019 19:10:33 -0000
Content-Type: text/plain

Discovered with a recipe under devtool. The ${S}/singletask.lock file (added by
externalsrc.bbclass) was leaked, giving a warning like:

  WARNING: <PN>+git999-r0 do_populate_lic: /home/laplante/yocto/sources/poky/bitbake/lib/bb/build.py:582: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/laplante/yocto/build/workspace/sources/<PN>/singletask.lock' mode='a+' encoding='UTF-8'>
    exec_func(task, localdata)

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
v2: added missing sign-off

 lib/bb/utils.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 8d40bcd..d65265c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -428,10 +428,11 @@ def fileslocked(files):
         for lockfile in files:
             locks.append(bb.utils.lockfile(lockfile))

-    yield
-
-    for lock in locks:
-        bb.utils.unlockfile(lock)
+    try:
+        yield
+    finally:
+        for lock in locks:
+            bb.utils.unlockfile(lock)

 @contextmanager
 def timeout(seconds):
--
2.7.4


