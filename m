Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.85])
 by mx.groups.io with SMTP id smtpd.web12.9690.1603462693309362363
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Oct 2020 07:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=oDrH2g5l;
 spf=pass (domain: windriver.com, ip: 40.107.92.85, mailfrom: stacy.gaikovaia@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fao4DhnEd+C8rHwCqDxvR3NM6hbydE5/AES3L6hdIq9GUFJZAd1L8LWzBlelPZTBSGI5Rg4JEzOnlcA4Cm/uuq2w4ujNboXzY/y42gG1KZ0h2kJ9IAuMmEdC1BmI0PzUj5gb61OzeGYzxhjbwW+lNqcToLTdbBGIHnPnO65xjUnFfj2v970sGZAVRkAlT6JsXRgScADHo7rgqTnq0oj/bIgOgGEaRBw7mNXy00SFx11GBMyYj1MmnhQhynWJfO+wwsqsRvPhmOB2Q56GZ03TgKFnHun0Brg8bZNUfy7HiPkZoigHU/LSBeL0J0lf7TPBg99ZElapoAvE2AOsMcKqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnxJdm+ro3O8Zx1k3GndCf1K800FEo7zDHOhHJmnzkM=;
 b=IJEBTRCvRKb1/Vh47xpI2NloFFaSsz5osGzxuByJP1Cfnkvv7Vp6H3oQbq/+GRb6sHFiCqIjWBtthhszZqCvJ0mcqMgvEpYop2w5ca/oQMCmHnLqZaZ2bAeTcsQRnqWbTX5wKflh4O1vJ3F5Hj29eCoNq2rnScEcaxHVe3X3+uPgFrn7dXZw69XzA7bxNyOGgKpJFkdr1rc5bgZiuu271oQt/LQ2b1fnF2RKPHOGcTcoJ7bp4m7ZHNPp/kcEEFiGOdJPbBLiQEigMbQhBsqNqufK3yt+4aF7gcuZtfwKbCkh1jrIw8K/kjluk2Rin0rWRRaaB8oQGrBR28uQkZJRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnxJdm+ro3O8Zx1k3GndCf1K800FEo7zDHOhHJmnzkM=;
 b=oDrH2g5lmP94LkJy3HulzuDMtFzlHrWbJmR2GaMUKdgGhZvCM3YXWG8JaRKfFnKenokdqWfln6dx8Mqm+PDOztuxnsZcVMWPInxWBfEDegs/EOBxDfxCYs07BI1mq1CwNzPe5DXN+NiG8I8iy8QCOJnw47QXtiGo8C6mhse5ta4=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3127.namprd11.prod.outlook.com (2603:10b6:a03:91::32)
 by BYAPR11MB2664.namprd11.prod.outlook.com (2603:10b6:a02:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 14:18:11 +0000
Received: from BYAPR11MB3127.namprd11.prod.outlook.com
 ([fe80::b1c4:b8ce:3c62:2b94]) by BYAPR11MB3127.namprd11.prod.outlook.com
 ([fe80::b1c4:b8ce:3c62:2b94%4]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 14:18:10 +0000
From: "Stacy Gaikovaia" <Stacy.Gaikovaia@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: handle cooker daemon startup error
Date: Fri, 23 Oct 2020 10:17:56 -0400
Message-ID: <20201023141756.2370657-1-stacy.gaikovaia@windriver.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To BYAPR11MB3127.namprd11.prod.outlook.com
 (2603:10b6:a03:91::32)
Return-Path: stacy.gaikovaia@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-sgaikova-lx.wrs.com (128.224.252.2) by YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 14:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6366116e-43a2-494b-788d-08d8775e7874
X-MS-TrafficTypeDiagnostic: BYAPR11MB2664:
X-Microsoft-Antispam-PRVS: 
	<BYAPR11MB26647DDF76345090E8416842FD1A0@BYAPR11MB2664.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TaDbA3Kc/mNtarz8RlYQUQEQL3a8VratmfBj7KfW/YDznioyM8EI5ix4+XO5cFYnnDbuiisKRS0GW9XgIyFYaelnmXvqVac4fo3oZeG4c46WsC20XjD6Ncn2N4tXUH94GRkjF8m/1L8XwkIp6jgs3kb/D9bSpQV5dnoojLILXpSFf4GdR5wpR6tOHNYeEkJmEREbldvqs63V9hN63uEt7u9BljV9IiVlVMZM5VnknzMhKBoTwmznXKsMgfvy20SKJpEavH60GLQyzdLJhjmIawNS47ZGPG+CRiY7zmtztUvYXQjUdw1zNUtzvbhoKvOml6VWmbef31SsDmorZnPeRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(186003)(8936002)(6916009)(8676002)(16526019)(83380400001)(6486002)(52116002)(44832011)(66476007)(956004)(66946007)(26005)(66556008)(6506007)(6666004)(86362001)(2616005)(6512007)(316002)(2906002)(478600001)(1076003)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	nVkDxLQI2/VfMJ+kka8p9bD+429zYqa1N9f60mny0YNyvz0eb4UabK6pYxejkKQmfJe/4VCCH0lQPjgv6fWXihuofITzZcZ3muESABIuOhvrLQBgUAlmdkAvQTdWUeFcNkiXsfF+0E+NyggrXcTWrP49QbicAAwg+Ajch/SqW+88SkjKeQd5HiJLCTzRR55y/xW4dgbBXl9e/4vNexzqngeMFT4HvS0VdTqxgCsV23sFd+2r1e6oXFKCnJzIL9YKIh7e6Gu2CmGovekBRM07wq02SrdmUR0DRgEGWFe/v0hfvJY5y5Nbg/HsRCKz8i1Ees75LbsvTU8kBAox9w0tzbBEBAT5BAbdM2MeKBl97S3cqvHfCz4QPJC7qqhpm/sV5ZmgODATCECdOV5ra5k+LpPGOPruu/Ke7aCtYTErfTa98k6X+vUV+ePJWrTY/kNXsr+EN1ObJcDvayROitYlrUzZjMRsx+cO45Up9NqLbszQwPJLGwwvQWJ08F5tjXLoUk6GuWHMzXZX+6mHpkD/zMjH/tMX4JvKGQWeEXKiR+fcwmFXpRiDqV+GmMPPD3FiLloF7vLVPGHBShzclLEvU0YyHOfyiqNpC8ogp8P1+M2q2Dw9vEyIjpUraPXrMzFLk8OEPm9jnSucewaJJXQZlA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366116e-43a2-494b-788d-08d8775e7874
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:18:10.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOjREvMGBMueSYM6DfSO2a41ejfQct/ScAl/Ep2rTuLotTytk+VGd3tFcC34FUkTXsLu//oKRB9K/kq3cZ2K6QBRtiFoLmiKGkPu8Ru//lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2664
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

On startup, bitbake spawns a cooker daemon and waits for
it's acknowledgement signal.  If the acknowledgement
doesn't happen in time,the bitbake object will fail to
initialize and exit.

The error that occurs in this case isn't handled by
the existing try - catch block because SystemExit inherits
from a different base Exception class.

This commit adds SystemExit to the list of expected bitbake
server startup errors.

Bugzilla: Bug 13993

Signed-off-by: Stacy Gaikovaia <stacy.gaikovaia@windriver.com>
---
 bitbake/lib/bb/main.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 7990195eac..e92e409f07 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -456,15 +456,17 @@ def setup_bitbake(configParams, extrafeatures=3DNone)=
:
                     break
             except BBMainFatal:
                 raise
-            except (Exception, bb.server.process.ProcessTimeout) as e:
+            except (Exception, bb.server.process.ProcessTimeout, SystemExi=
t) as e:
+                # SystemExit does not inherit from the Exception class, ne=
eds to be included explicitly
                 if not retries:
                     raise
                 retries -=3D 1
                 tryno =3D 8 - retries
-                if isinstance(e, (bb.server.process.ProcessTimeout, Broken=
PipeError, EOFError)):
+                if isinstance(e, (bb.server.process.ProcessTimeout, Broken=
PipeError, EOFError, SystemExit)):
                     logger.info("Retrying server connection (#%d)..." % tr=
yno)
                 else:
                     logger.info("Retrying server connection (#%d)... (%s)"=
 % (tryno, traceback.format_exc()))
+               =20
             if not retries:
                 bb.fatal("Unable to connect to bitbake server, or start on=
e (server startup failures would be in bitbake-cookerdaemon.log).")
             bb.event.print_ui_queue()
--=20
2.25.1

