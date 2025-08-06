Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE9CA0EC0
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 14:53:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.47])
 by mx.groups.io with SMTP id smtpd.web10.27195.1754492013034209775
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Aug 2025 07:53:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=Fttrpscx;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSlpYS7oJ09Dc1mMsFjxfgwQLWl0MfYk24nbCKggI4SIHbtHcElV0TO9ugpvge6sj2mrjDZH5eeelPeYiKdp2v0GVHjq3mzUayc7mkS8njokiXamB3MxlJxHtq9hAPEyygypvi4r7bMRXLDtfa2YLJP6WN/QqMYZRwNO5ODFrDi5wG5qoOeTFz9j3FdRTKyz3756VcAKPJqCgOjZ+MxLcWhh1kIrydUY+PWWQFFhlQkSiq5PRjMHr9QFw8d9cQL4tNWPX4qg8efY2JHDjunYRnps5pktCaGviGRwvNHTaT0NAwOqhqFu6rtJE8ti3l9GtYf+3TAWACciSEsJS7CyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiNEU5RdvTkVmn8uczgxYo4zenIhb0A8A+l3XJQr4tQ=;
 b=mAu5nnw1M025U0Ln3l8uEM84I2EGgwDKQWyr6G4k5kAzzctSE7310Z0nOln9vwQNrc16ZIcfUYZafwSYYyt07FTQyLmGlxVF0MufF3bJu4AG46hktzPbK5mm1eys1bRr1bLdia/Ts42gRTaIPlxqaUFkejhOiubKKSuVJPtOT/yxv7/Bt+I0VovPE7a6Ll3Igi/1U0ppaYeRgHO5l1rmL9jis8KCEdcUN8UMEgGu4pZ9w0ezDi/4nrsPCTm7i/qaTN8qhh9vwkkpr07bayf7JDn69DjUo8IKHu+tboEAg8tNLZnTey+1XTky0SWE6BlfzhhC+wWX4WcmTu3gZabBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiNEU5RdvTkVmn8uczgxYo4zenIhb0A8A+l3XJQr4tQ=;
 b=FttrpscxP8pfOweR70BbP4+sxXqezRlBOvCLZ1NI05d8apsbMIven7pdzZsWmym3BvGDoZxpIoSJS3T3UPTMyDr6d0MafcbzpNGP8rBlaqAgqVpIaZ+QPy86zco4tuM9Y0dIyFgXcRnd9WBPRsNRoRVLiUxysWBx7DBLAU1biwsGaPAC0/rpPuvoK6lFuVnlqfj4iOw1Zt0o8pClPDLAw4BckwKMPrk4NPJz2cUTTCFKB97Ys1nPqxoEPD9zDTh3YYAOQ5k/5TQM3tJcEhizCLhlAzgfnpgVxvjqfE/BRPbDAoK6eNptoefohEsCGr46KeI7Siuu9HLcjpErfmkl3g==
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.35; Wed, 6 Aug
 2025 14:53:28 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::17) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.6 via Frontend Transport; Wed, 6
 Aug 2025 14:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:53:27 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Wed, 6 Aug 2025 08:53:17 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/3] cooker: remove some redundant control flow
Date: Wed, 6 Aug 2025 10:53:06 -0400
Message-ID: <20250806145308.2052128-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca9307d-9254-4854-eb53-08ddd4f90060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k2qz9+mEB1MN6+2XbEoj37n4dhuzC1Dm+9QyecWef9YN/0sZ4BgGFw3scAPe?=
 =?us-ascii?Q?z+AsZBq5a3xAk6sDorU3LNsKC7PVAnxcOonrazLYV/9DV8Gp86ofIYU4r4gG?=
 =?us-ascii?Q?L0/yA21ioiAnM4IdnxQGng6ZnZXuTm3js6n0jwCOV53Q86brJvYJG4SYEoZ3?=
 =?us-ascii?Q?cf5Zhz8Wh1OWhWYhF7E8Okwi+g4nr6aoEicD/UngbWeQ91Latf8+uaO4/oDT?=
 =?us-ascii?Q?cn+j5UE8ObPgX2cQpKdGlcB8t7/wfZ83LMJ+eLps0qg8fSbVY052qOsM9qZg?=
 =?us-ascii?Q?EcIpPbjTgzFdG4sACApQ2KrDyF+zRUyO7sWrqt2CPvX+d9xtLycLtyMuoecq?=
 =?us-ascii?Q?BnGpHvOlO4AM1IM/BZNZF2GBJUyyvgcsmJ3VoXkB9AM9JWKXj/HoJfXcj7w+?=
 =?us-ascii?Q?yXVTYlMwJiBXf6bTIYCRIRg3eD/3oenCab+lAF5CyFQ1T0QYv8FILpdwNVUe?=
 =?us-ascii?Q?rKABzibXD7Amw6j9+Cu0IAQBLM+xZ2BX9T2YziemPwq3GBfxjo0p74gdsfLj?=
 =?us-ascii?Q?prWaAbpdQbz5GEzCyXUXL/Gt5BJ19LzgPdDTZHl+umgcUq7R6+jKyWPdnjEN?=
 =?us-ascii?Q?3jGpaZ4LboxbcNgT/wgDCh0gwK/fTXPDt8K0e6JXB0SRr3yv3rJ85U/nEqPO?=
 =?us-ascii?Q?ERH+Gn8Ub5Q9dSmpgLCUD6iWo9SjtmSQWGordRfTojzcCY5Pv4wbdl2Wyn5L?=
 =?us-ascii?Q?Tbacyh9m8zjpaJDi1VSHg8V+JDPDNemxDZF84nfQPoiZlLXqPf5Xbo3dU8aD?=
 =?us-ascii?Q?vEtUezIi+1FaghFJnX8PocA/LA0cfquPAQFodX/2EQAbEWDJ+sNVlW025oTu?=
 =?us-ascii?Q?5Yn2bFybgnoRmFFfHD2x6sqwP1+lhZQS1AGXVCHGaAiin9uKbPaGMEPz2H7W?=
 =?us-ascii?Q?iHoax2iD+yYCLJL8Nf1tsmUl7uSkGMuWf7G3taiw2s4nx/I6o9N/Vhzb3pwE?=
 =?us-ascii?Q?9F0yDzaL4Mrk5u8NZrPo1z84RN3eShw8g3P9WG9UIU+3qwv4wa9Ykj/Lws2J?=
 =?us-ascii?Q?0AMyfHGNCQ3Pn+oMN7AaG93eDAPJGE927YU28hnuHVq2t3e29VPfPS0YFPym?=
 =?us-ascii?Q?JkwRMsduTh0JC/ilq4GFpOiEScmQcODbAxIy+S5P9fm/3d5iAVFgGz7ZwZ95?=
 =?us-ascii?Q?2mrKeoLQp+rUBJgqqPk4w9isT3OZrcW4FIMqqCFj6b7XH8xG4XwhKZvkJkMO?=
 =?us-ascii?Q?JBL3Z3ZbSYa2UjjKbzcYWbnv5zTgaSE+mMGtkTIgHpYmGsD+3aE/JFBZvau5?=
 =?us-ascii?Q?s19jnWSnyuPA+QUfsf/1ACWEnoCj+hq2dlskEuiXB/uR5JJkbgKzWTiMMK9V?=
 =?us-ascii?Q?LzFumXzKUvmH5/JdmcxE8mgDj7vW7npUUYqh89kRTRo3DcrJo7T5xBfht0Ug?=
 =?us-ascii?Q?ILi5wSWHSEcD+N5oitL8G2qSbHySGdxpWamBbRz29u7FTrRJO8oWaCCZYTEZ?=
 =?us-ascii?Q?76Utusj+lVgp26Z6ZST2oaMCvipIRwrSRKluBMYFr8CvBaLRv7rlabkKhpJt?=
 =?us-ascii?Q?Zcvn3+GcrPcVbjDJC9pRdcc41ykYklX52heW?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:53:27.3922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca9307d-9254-4854-eb53-08ddd4f90060
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Aug 2025 14:53:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17840

From: Chris Laplante <chris.laplante@agilent.com>

Prior to commit aa84a900e ("cooker: Ensure delays are accurately transfered=
 to
the idle loops from runqueue"), this was necessary. But now retval is retur=
ned
directly.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/cooker.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9e4000b63..fb87368f1 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1434,8 +1434,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
                 if quietlog:
                     bb.runqueue.logger.setLevel(rqloglevel)
                 return bb.server.process.idleFinish(msg)
-            if retval is True:
-                return True
+
             return retval
=20
         self.idleCallBackRegister(buildFileIdle, rq)
@@ -1504,8 +1503,6 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
                     bb.event.disable_heartbeat()
                 return bb.server.process.idleFinish(msg)
=20
-            if retval is True:
-                return True
             return retval
=20
         self.reset_mtime_caches()
--=20
2.43.0


