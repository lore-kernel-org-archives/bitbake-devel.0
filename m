Return-Path: <johan.anderholm@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56DEFF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 14:03:54 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13857.1777385030668202942
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 07:03:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=YzU73awh;
 spf=pass (domain: axis.com, ip: 52.101.83.35, mailfrom: johan.anderholm@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHGPMQ3srUn3ZCqtbNx2ni4S1Y4X2/hz0YCW9/EibkniZFfuwjCf98ZoHID1AogN6KIRDpA2Lf3iZzCbSMdyjaGoS8ROYAiisj+Vhpcv0RJmo5BllP5wHKeiIdmp/2WugNd6iNCpOPlrQw5sm0kfz06yLBbx6AJUtKQ1UshKFvdsNheUjggjpCInJ+SISTz+Qd/aI5kxRuVC08Zbs+I09Q/pbLDQahpPYnD8BnDSGWe9iOJU7wokLc8fYZKMYrFzIkNrvoEH/3v0m5QV6amgzSw4q6HtpN9q/CrA2WjRGT9BqOLeCKivApY7DAoPnoyCk8t+X+oUkY+2oq4iECWGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aug2gN+ziVkgaYSL+PzSmI8HIOCJQS7PbGsCfNXfjv0=;
 b=a6IMo8krHXmLo4xO/S0lMg4dIaP1KnxJtAiR2W+I87+w4U+3TgFBJROhfVJH4lCKeY9BljjqTBt9+CSGrbZaBuLXY20YvfF3bvP0iUIz+8SifBuTXgDg4cPU2/jmFnItuD6ZNFaXk6CUVk3WlOF8c2Zug/cGqU6BunPnyt2H8ZimhAjrD0iva+5oAuYrAaWlWx51s2UHFLTxl/7GgSqMZS2RIgrep3elXzW8Um7JTgk80YH3oWZ7dTjyNrxggGjHUmsa1vJZU1ByT0gUYJpvYPG8i0sFYJbFtC1fDZvzIYvqFlNR/4qA4oGhhIGdjjN4TT8/bBbqZTObRoujUAFang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aug2gN+ziVkgaYSL+PzSmI8HIOCJQS7PbGsCfNXfjv0=;
 b=YzU73awhfsJWVGJ4rALENRhDAtYJLhVQLL4Png+GNpnhSwaNW30aWOkDgSyf0lOhVcL0FObqG+52WGNAbv75R3kV2cAv+Siv6lWTZgoYmvTzmvKkwqES0j6UJKsb7mSFF6RVcH+eKc/NLVEk0JBTtK20I2dWqho9//lvQQ7YhH4=
Received: from DU2PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:10:234::11)
 by AM7PR02MB5782.eurprd02.prod.outlook.com (2603:10a6:20b:104::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:03:43 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::d3) by DU2PR04CA0036.outlook.office365.com
 (2603:10a6:10:234::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 14:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:03:42 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 28 Apr
 2026 16:03:42 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 28 Apr
 2026 16:03:42 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 28 Apr 2026 16:03:42 +0200
Received: from bldod238s600920-7.se.axis.com (bldod238s600920-7.se.axis.com [10.64.16.16])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4CCAE768
	for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 16:03:42 +0200 (CEST)
Received: by bldod238s600920-7.se.axis.com (Postfix, from userid 20481)
	id 48A54609E493; Tue, 28 Apr 2026 16:03:42 +0200 (CEST)
From: Johan Anderholm <johanam@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] fetch2/wget: allow identifying with a bitbake user agent
Date: Tue, 28 Apr 2026 16:03:25 +0200
Message-ID: <20260428140325.3948844-2-johanam@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428140325.3948844-1-johanam@axis.com>
References: <20260428140325.3948844-1-johanam@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B99:EE_|AM7PR02MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 60549a38-2455-4849-1c98-08dea52ef4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hJrs6ofaq5WF9oe+Ur1IRT6jyvZZDpcCH/t72WzbfyvnJSrOG/qdi+UFcYxlgmTzfIbYF4uria/6TnjV4ttnCpX2dke7jpXMzU7/4Hl2YeQKZtQdDAUrE/f4qEITtVsoliDdd9PK08UJ8GcabYHmvNzu0JqmFTjaTpvK1vQAHYxHxqezqsQjx5YjTvYh55RnKp7Wf6fsdk7Xuz3EuWsOmRJbQBt7bqJDESK732bJPfeFf2qzw2HoqkmgUUJLgLK2yTOo9b7t5EasNAu5+mk0Ogc4UOeGZtOAeuUlaIxrYVla3/m0ovQa5+zbUOY6PRW+ZKwGmtoNnYfQEzoumrxgBamI5qlRzm5ZSijJ988XA34c2CCIaDzh+AHYa07baeIf/n4vB+bOt0S8eASzm41xbWEXKg3HrhguALPUoF49SCzVYN95nds5PAvTrzAPioB7hKp00zZdODvgaITEPjLTaKw1hjWAb0JGvLmg1lwarz+0D/5vIxPQWevCtNY1TYOl82vbUsIFzuWwiKvoSX5VzuWwVdJCMKok1eeGnuvc1qGddaJPD7ojjq/z5oX1GuiFkvlDQ37XF+3lpcuPICFfMK4eG9BUDo9LBc/eaUtOLfruiaLJiBq+67gSU9Ce56rWkhDH/0pLMB3HHs0/atK6VFeq5qM4GiVB7xb/Vr12rxjyAnlv8x9wk5XEplv1V12xmr9wqnOZLMxH2lr907/XQW/nod6Z32uHaCJGlXC/YEc=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FVrBRYFQf7ySf9z2RIEGNeKFm2HsaPhYjgAOVA4tZBoaSMU8Q9h9Wa1tpBrwz9CLJ0IDux1ggK4tS72WsUpIIsSGIAS1KWcDaGCgEQg5bGgFe8gnLZ7pZ+Ik4ZVad47mju7pMj84X26MdWFBTFyyIocwUm7w6NCGknVVHDKHNe5GK6BGUmikO+VNz8/36ZEdAr37Oza5q7Ri/RXxqg0CmzAwOQQsc+kIFjZIa9Z4wqovGPX7QnmqmLYFYi7TLMImnbUZqXeQaNnAsQooWNnD9I9vLQOm+fpqTQUs6WYlW2kxGC4NvOPCJnDH84Q7L3e2Pcou0fedQIZzbMYuCT/FUzgwSB1bjMYi4z9mg/dtpVIfvu+x/RmK5vPeB+wcVPxbQ+55Y/XSjkRflTIF6eAOcLs3W9FpuTMZGIt4uJ8fO2Dop0bbQ0Xj+c4Ek/hEvnPj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:03:42.8970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60549a38-2455-4849-1c98-08dea52ef4ed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5782
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 14:03:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19400

Certain hosts do not allow identifying as wget, but want an application
specific user agent.

This change causes a slight change in how checkstatus will identify.
Instead of simply using bitbake/<version>, it will now also include
project contact information:

bitbake/<version> (https://lists.openembedded.org/g/bitbake-devel; bitbake-=
devel@lists.openembedded.org)

This change was made to comply with the data access policy of crates.io,
while not introducing too many user agent variants.

Some more information on user agents can be found in 234f9e810494

Signed-off-by: Johan Anderholm <johanam@axis.com>
---
 lib/bb/fetch2/wget.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..93c8b73f4 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -60,6 +60,19 @@ class Wget(FetchMethod):
         """
         return (d.getVar("BB_CHECK_SSL_CERTS") or "1") !=3D "0"
=20
+    def identify_as_bitbake(self):
+        """
+        Should wget identify as bitbake?
+        """
+        return False
+
+    def bitbake_user_agent(self):
+        """
+        Certain hosts require users to identify with an application specif=
ic user-agent.
+        E.g. crates.io according to https://crates.io/data-access
+        """
+        return "bitbake/{} (https://lists.openembedded.org/g/bitbake-devel=
; bitbake-devel@lists.openembedded.org)".format(bb.__version__)
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with wget.
@@ -122,6 +135,10 @@ class Wget(FetchMethod):
                 # Authorization header.
                 fetchcmd +=3D " --user=3D%s --password=3D%s" % (ud.user, u=
d.pswd)
=20
+        # Some hosts, e.g. crates.io, may require using a special user-age=
nt.
+        if self.identify_as_bitbake():
+            fetchcmd +=3D " --user-agent=3D'%s'" % self.bitbake_user_agent=
()
+
         uri =3D ud.url.split(";")[0]
         fetchcmd +=3D " --continue --directory-prefix=3D%s '%s'" % (dldir,=
 uri)
         self._runwget(ud, d, fetchcmd, False)
@@ -371,7 +388,7 @@ class Wget(FetchMethod):
                 # Some servers (FusionForge, as used on Alioth) require th=
at the
                 # optional Accept header is set.
                 r.add_header("Accept", "*/*")
-                r.add_header("User-Agent", "bitbake/{}".format(bb.__versio=
n__))
+                r.add_header("User-Agent", self.bitbake_user_agent())
                 def add_basic_auth(login_str, request):
                     '''Adds Basic auth to http request, pass in login:pass=
word as string'''
                     import base64
--=20
2.34.1


