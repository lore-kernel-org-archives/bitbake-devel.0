Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.40])
 by mx.groups.io with SMTP id smtpd.web12.7120.1596810253181863004
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 07:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ZsqJaoAe;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifNmDip6jBQy4YX4wbzhkDFqtllwDywhrQuO7FAb+sBEi8NAwLHHdUQtejjP+zBJeuFWvsxLbor9aEN5TjO6N6dt45/V5FovYy7TCifEkI4j4BbqQKDtownmHLeSbk4+0mkgyg29uAwkBPH4g7OU0T5sMYnhMXAxKN1PgcDGvUEaE6SlwU9swkMpU9nmoQtpnwEZ5cwe1ZZONcCB6rCbiKOwAt4t+/LWKZKt7P/BCCeG0CfYxFWlyzf/UwGKB1lg0ZyowCTXveLDZ0DGCZ1NWejAO5twLWtmSYq1wokJ5mPkMMrGMgPUAO9o0Unj45QynzpUl/sVYlLugmxXDrEcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0msclTf/Z18vYk5vmxMZ0hxpHGWIWQZOrg+vJEa0dk=;
 b=mrXTQ9KQDHl07CYClZO5tvkP210dRG0sh/ol9aCyDr0iQytuEIiUErqu6czNRoSY12ypaCzl4jrZ/H9Ve50VM468+OYG/3ps3SC0Mj+9sQ52TxH7KHSy+1zvafqNB7BSN8D4nyxNREpv4/k/gHb037iT1MKLnHvPxGIZ6CXtKEyaMHHmG6Mqw+C4Hr7sXRNXI3cSVNbDF+Y8D+TQKpQDPKmgDFUgcVLxVFfgWjLM2EZX5z8msDqGbHy6ujK08vfxZkfs4opeCt3jCX6sylsaY/Pzib7vbY+ezCahBT/kn66ar2ijip27UqNJYljjNWJopqmoyxNfDEQSzmurFoU+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0msclTf/Z18vYk5vmxMZ0hxpHGWIWQZOrg+vJEa0dk=;
 b=ZsqJaoAeZdPds4m68KexkeN/iumHuIPXKQNHCpRiDex8e6aEUXs038fsLsgQFdBWk42Vwv2WKsA9WJ4rsQoa4g5SFEcANFpKXumRGhDlfnLwDA+RDCbMu7ZFvrEX1dH71nRqZu4Jt/efPw52X+9cMDDxim8KBAlAibU1WR/kogwgN8NLoc9iIiEQi8WEPUCqH8XgEW6o1AcaKUmEbxFYqE3cyARlYE/1rSRHLsWIlV1Dp255YDNpcmvY7RPaovB9C4m/73tdgrZjL/NYRYdE/Ue2IP8dkejmh6g8uDZ/5Al1Xn0tPGOUh3ciij0j1oUVO/BYAqI3GujH+fnJs4J6zg==
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by DM5PR12MB1563.namprd12.prod.outlook.com (2603:10b6:4:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 14:24:11 +0000
Received: from DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::cd) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 14:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT022.mail.protection.outlook.com (10.13.179.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 14:24:11 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 7 Aug 2020 08:23:58 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH 1/3] data: emit filename/lineno information for shell functions
Date: Fri, 7 Aug 2020 10:23:41 -0400
Message-ID: <20200807142343.8648-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807142343.8648-1-chris.laplante@agilent.com>
References: <20200807142343.8648-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba30484-3135-4f8d-367f-08d83add8dd5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR12MB15635726A7BDC999508F166F8B490@DM5PR12MB1563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4DM+QAkiT3hk4dMIt9NfZZo5E/VVe28NBRdtrdSB2EGr0GEtr2EpHntJaocwGAKoqbg8EQoAcdznFoKpitXJnWSEOpaj+M8gXPUfpcRqL+k296bvH9dg8/1F3E/3cQGg327vgdlXOKEVc6AOCAWKLPG6Zb2DSS3T1bm+OWTcPu9X7vIbCUWAxG+qLa40snvg32S9lFQM8sTgDqKL+/TFGzm70K+ewpHWKZ/lL8avwoLqblVP+Y2vhKnaOmGdm2WNRdOq21nXzESTVr1Jjdy7gdXHwIFGZgSbpqSEHirMmixBSQD3H3KdbN8uxncU9+jG5T4j91qY8vdG1ZZ3KACjdry5ZqVd/K4nWtd/V9H50zYANpOky/B1Ew5Rbv9fSXDCLPPdCNq3GATVO+tWC2wq23jCqXW/t1qNIJNKO49A24Q=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(376002)(346002)(29502001)(46966005)(336012)(5660300002)(107886003)(356005)(1076003)(8676002)(426003)(82740400003)(316002)(6666004)(70206006)(54906003)(82310400002)(47076004)(2906002)(186003)(36756003)(2616005)(956004)(83380400001)(44832011)(8936002)(26005)(4326008)(86362001)(478600001)(36906005)(6916009)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:24:11.3459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba30484-3135-4f8d-367f-08d83add8dd5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1563
Content-Type: text/plain

Make it easier for users to debug shell task failure by including
some breadcrumbs in the emitted .run file that (hopefully) points
to the .bb/.bbclass file where the shell function was defined.

Unfortunately this won't work with functions with _append
or _prepends, since BitBake wipes the filename/lineno information.
This shouldn't be too hard to fix; for now, you'll just see
comments like this for such functions:

[YOCTO #7877]

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/data.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index b0683c51..d71e2fb4 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -161,6 +161,12 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return True
 
     if func:
+        # Write a comment indicating where the shell function came from (line number and filename) to make it easier
+        # for the user to diagnose task failures. This comment is also used by the shell trap that build.py generates
+        # so that shell tasks can report better line numbers in case of errors.
+        o.write("# line: {0}, file: {1}\n".format(
+            d.getVarFlag(var, "lineno", False),
+            d.getVarFlag(var, "filename", False)))
         # NOTE: should probably check for unbalanced {} within the var
         val = val.rstrip('\n')
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
-- 
2.17.1

