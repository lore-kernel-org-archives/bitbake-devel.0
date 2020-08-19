Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.73])
 by mx.groups.io with SMTP id smtpd.web12.88435.1597846934272204788
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2020 07:22:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=vpYTTZ6b;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.73, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRF1iAn0Jcnl+FvI32XwnKDEarvTtE3RXzhwXzYPP2uq7plcuqIOECfvEQsFYXc7BLkIS7gB7QNpNYjO87iSWRKRpGHUzoNzj1aC2rIe69TiOSs7EOb2yYzNkQUAaGl3r+0Ii11WyrLX2O08OY0yKlm0EF6UqkyW5o5eujHqfjGHb55CdzvU6Ldt7pRyxxyE4reViZcfFOhIYygeGK50kjICGMNXNF9Hrkifw2tztdtreGa1ZBX1npVZESXSiKNbCvoayykeB1EYx56jxrXDedIr7t9TGLiAxNMPW5bRTRcNyKUVp9PO1+K9PU3kxaY6TqYFTOspa4jyQuR4IxJKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcUwg6kZb1TgCblsdCEuNnY57YgxKvfRDo99p1ITC68=;
 b=GGqFVG8NDh0ngc4FBPv9AcUwGdaE+LMzTdBq1rAvMZnLe7oGGRZ2DFuzozUTlBL863Rz4h4pCRAU78vCClYf8g7TltD+EC82cnB59SqTnC6L1kGlEDDKYJhNhNfW3ybpZV/WkP/jhMQ+D+p5zO6k6sDN9gAU77G9je/cdf4S9x+G0L6ezukRBljWyVxXdVJxP3dl/6hyxxDyeUnWZWVqns/vDQdsAl3SU/5awC5q81yrgtzjMi9pt0JIUUnGpylF4YMGct/mGe9ihbxuj8ueRy9QTR7pTilQEIfiAd7xqm4qSCzJ0dTy4Ksgbnvsoo/5T8MNtngBwifW6SkywRxuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcUwg6kZb1TgCblsdCEuNnY57YgxKvfRDo99p1ITC68=;
 b=vpYTTZ6bsgYHFLJegowt2Lwj82IqWaunGUzeK4TJerxp9v972PoxQvo917pxwTqSHApmvAzo76+Jcmmo8ovMWmPLkmRzKGCV5QaWscn3N0IR26S7O6v1pLRKDYHiNDJFPV1QEGEXJCnVHZHtHPcUFpSfSVmya7UlpeYkATJZMczbiVls6xyMTUKI43Mr0wrthcG+kBGAWD6gykYhAANZfhPVdiaw3iZ3p/sAof+QrExmOlRMRXKSTMb48nbWOM9sRtksHXL/r6pAvY0nojbIwinZQ/5RHgx/9KkDLkvSlv4r9+Rd46gq0RZbNxQB5r3uE802XMlXnygYzy2GAaaC4Q==
Received: from DM5PR19CA0048.namprd19.prod.outlook.com (2603:10b6:3:9a::34) by
 MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Wed, 19 Aug 2020 14:22:12 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::f7) by DM5PR19CA0048.outlook.office365.com
 (2603:10b6:3:9a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 14:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Wed, 19 Aug 2020 14:22:12 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Wed, 19 Aug 2020 08:22:01 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: make shell traps less chatty when 'bitbake -v' is used
Date: Wed, 19 Aug 2020 10:21:33 -0400
Message-ID: <20200819142133.60341-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e3fcbf6-fb21-4c53-7db9-08d8444b43e0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MW3PR12MB4506C3DC0ED29939135798A28B5D0@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pr/YEf5hp29nNVhQvd3LHqPQeWvIRVZ2b1dNsVSqolOys3DxH3ySvgJI4famaB24yuY3IxZk3/nwT84rE580CfMx/POGCGGXqy4AsQjev0DaXskfu3B22UU0lOXP/A9OzHKBJiAwyy1eztim9JkguvJmzh+Xg+NSSXNj+ZKP5L9AcqCk3LkuUYO9A7By1EOLaxSSvMTs3/6yfttQfUzbaaX3UpCD1AoTg3js7r/Bvu2oVgNj0Aikn2dova+i8QV1qY9GVaH7mb6KM1bggcCw7aLGpsdwAoCiCfgT5DNNgC7XQCHyUpjDQFgGnnpWj2zSMBOpy2SqGAxQrSB+F5p4JS4mxDH0gMJo7B+jxMmcZWpwBt2w3TwxmGpgsoGEge5I7OhX7OxS1zi/YiTOCUBzPOmYJ7dHg7X6znrSdpokfAI=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(29502001)(46966005)(426003)(107886003)(44832011)(478600001)(8936002)(6916009)(316002)(4326008)(2906002)(7636003)(5660300002)(356005)(82740400003)(2616005)(4744005)(956004)(47076004)(8676002)(1076003)(86362001)(186003)(83380400001)(36906005)(82310400002)(26005)(336012)(70206006)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:22:12.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3fcbf6-fb21-4c53-7db9-08d8444b43e0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
Content-Type: text/plain

This shuts up both the DEBUG and EXIT handlers.

Also, remove an unneeded "set -o errtrace" (i.e. set -E),
since we no longer use an ERR trap.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 5479a53d..94f9cb37 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -318,6 +318,7 @@ bb_sh_exit_handler() {
 
 bb_bash_exit_handler() {
     ret=$?
+    { set +x; } > /dev/null
     trap "" DEBUG
     if [ "$ret" != 0 ]; then
         echo "WARNING: ${BASH_SOURCE[0]}:${__BITBAKE_LAST_LINE} exit $ret from '$1'"
@@ -353,8 +354,8 @@ case $BASH_VERSION in
     set -e
     ;;
 *)  trap 'bb_bash_exit_handler "$BASH_COMMAND"' 0
-    trap 'bb_bash_debug_handler' DEBUG
-    set -eE
+    trap '{ bb_bash_debug_handler; } 2>/dev/null' DEBUG
+    set -e
     shopt -s extdebug
     ;;
 esac
-- 
2.17.1

