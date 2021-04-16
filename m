Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web11.11264.1618589279155956836
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Apr 2021 09:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=lcY1X82r;
 spf=pass (domain: arm.com, ip: 40.107.20.50, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKhC0fFWDEk9btWeM8YZ9QNXfi7nN7l1c7aPm+unB4I=;
 b=lcY1X82rHres63Wr3+hVV24vPHDyy8bH+8xYzFuY6frbMcbrDAMxtCK4MJfZ1El2C6mJ2tGNv1xjKFl6JttQPULlG8F+POorXc13MrzuFf8g7Jd6Vle3+XWAIFQDP7a5j0U3CGfneasm3B4EJEnHWoH4FZsCmPeE2hAxlmz4Fos=
Received: from AM5PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:206:14::28) by DB7PR08MB3418.eurprd08.prod.outlook.com
 (2603:10a6:10:27::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 16:07:56 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::bc) by AM5PR0301CA0015.outlook.office365.com
 (2603:10a6:206:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 16:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 16:07:55 +0000
Received: ("Tessian outbound 47ca92dabae7:v90"); Fri, 16 Apr 2021 16:07:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc9a65eaa4707b67
X-CR-MTA-TID: 64aa7808
Received: from 028ac88de512.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CF5A40D4-842C-4312-B644-0227F6928CAA.1;
	Fri, 16 Apr 2021 16:07:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 028ac88de512.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 16 Apr 2021 16:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd18mfgRbi01YrlsMRhiNIXFxpdBbx//5CKzDcn+T91VAmUoQpgmIzjxAvvLgG0I948pQ0fAZ0pKQQ/9mPdX2TvUUCRyF3gnNesE8VEjPUMBBfACFwXg8JJlndi6NuBklWCaU4ar2CiTRuGLfOgmyAfGuVsU7bAizRsd2wCxdP6aaBRHoUD6sX9SWz1RPrUBFYfZE5x2STPa/LbRPplD/29/a7BrKnTFIbSAnxrtd2HW/STgDXT8t/bRwTABTLZlfti47X7MrVbWjH9bevgtQ9HjYgz4s5o8sMTnnBB0jAn+BW0Xa0mNmKB9ubTXHlGCGRD92HynTC0lOT7cU1YUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKhC0fFWDEk9btWeM8YZ9QNXfi7nN7l1c7aPm+unB4I=;
 b=JEs8EjtkLvEcOJMwc2oKyI88POXZNWjEinzVU9ueE9Dtr06ENdzrKY2xzDZzAn66sd/lFdNvCLjz+tzCd/mSV0jRjPE9quloRuaNt4xUj/mrUobzuMzd2AsWRYxk3OtmaGdrE7hzia/9iK+8RKd6hb49wunMfCK5bO7SSVcQe3loYEMHi6FI5QaHg11wYPNnOKXlKyOyIxnQunkS1NOnw31plOoOhUTYScjkqbe2zVIBO/UHd/ZIrjfyDwBlavjaXbfk8z1cycXfqqxC/B8VfBFluA5ooGqForJwefR/qRgfpLiMAefoUVao4XUarSVV95nZsRXBFJj9kkeQ2+4wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKhC0fFWDEk9btWeM8YZ9QNXfi7nN7l1c7aPm+unB4I=;
 b=lcY1X82rHres63Wr3+hVV24vPHDyy8bH+8xYzFuY6frbMcbrDAMxtCK4MJfZ1El2C6mJ2tGNv1xjKFl6JttQPULlG8F+POorXc13MrzuFf8g7Jd6Vle3+XWAIFQDP7a5j0U3CGfneasm3B4EJEnHWoH4FZsCmPeE2hAxlmz4Fos=
Authentication-Results-Original: lists.openembedded.org; dkim=none (message
 not signed) header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM5PR0801MB1747.eurprd08.prod.outlook.com (2603:10a6:203:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 16:07:48 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 16:07:48 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com,
	Diego Sueiro <diego.sueiro@arm.com>
Subject: [PATCH 2/2] bitbake: layerindex: Add --fetchdir parameter to layerindex-fetch
Date: Fri, 16 Apr 2021 17:07:11 +0100
Message-Id: <6b47f8915980672ba16ca0a7b40b46084457df56.1618588951.git.diego.sueiro@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
References: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::14) To AM6PR08MB3461.eurprd08.prod.outlook.com
 (2603:10a6:20b:47::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e120809.cambridge.arm.com (217.140.106.53) by LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Fri, 16 Apr 2021 16:07:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac3abcd-7384-47c7-8556-08d900f1cc0d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1747:|DB7PR08MB3418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DB7PR08MB341803CB6D849CB99DB0C613924C9@DB7PR08MB3418.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:595;OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 vAfatWQK/TWusj7Y1P16uPR4zHdw+Duz1H/Gsvg2uBETdi3f44Qrhf9g7ubo9TAZO0lGmhxWf28NrE1SlWIXpgYS7M1vFI6LIo3A9DkpL5pVQhykSxgsQ9CqwwYfWKHoq8LkJzm6o0IdwSclNsOFZBmVcvEaWzWf5VY+smRHCcOUFM53KQsnnHvoUWpz0qh1/G5zb8frT4/iJCslCBEIM5SLSYvIaYfI7mtu37IkyQ8TcQ+KBD5skp0FFTSAW3zQKPbKbR1pBEoXBgW7tdXZCR/dqRLfhO6i0c5eQLn1UBZYQbqLI8B+DEgJvQywmtLDCqK6a1JGkXMtW89yaDTldZOx8AqTJIrrgQaYQWZtaWAD86YxFZJs/QJNMN8h4cdz4+aWbWqkafCKp5Oq2Ek7B3B7ogaah7ozJ4njXJV7OQ8hyFlBDnpHzOCQvUj4dqXxQVaxGNUySsp7Z9aSdXJ2pVrMCl2m7HJlXo/WIq3RhyF4Q+8Lt7UdA7RKWHEWzDk9Ov05p/yZrt+JuelGSwKYt1xdnjiExGK+nhLEBbGgf7/58nJMzFCwTRgp1q2f9dnHVp/TVC8SLqx2p2ZAb/qd3Mtsdj36rr8pXNP0ncGLcKW6orpsGcLErDybAqJbswp88ywCqq3D8lbX9MFqScV9bbW3Ymxh4mMRiLUZkN8FAjo=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(7696005)(2906002)(316002)(8936002)(52116002)(26005)(5660300002)(86362001)(36756003)(2616005)(956004)(4326008)(6486002)(83380400001)(8676002)(478600001)(38350700002)(16526019)(186003)(38100700002)(66556008)(66946007)(6916009)(66476007)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
 =?us-ascii?Q?Gwl1HxAXBmNBemlX7WuGpvyezLwUSiZ4odFScVOpciwMwr2DVs0wb1GL4gc/?=
 =?us-ascii?Q?ErUXQ++YEn/VMBCV7Ix98HRbi2vtmHxTE/QtsjcH0NUU7KQWMGqo0iKa9eGK?=
 =?us-ascii?Q?tZ9iJXZ9eiOxLaHy/KVjG9CD4IA+81oFInxdmjC1yNWuujJtixuWGbRUPlJl?=
 =?us-ascii?Q?sc6EgrgK6OMB2FePy/c4km0y6nSiyKiGhS4g7oTAOo1I68kJ5No07wOVgPsH?=
 =?us-ascii?Q?4hTY05un8ivf3cA3zLKQL3iAj0J9CfNQ3g25zFA9ne+1pXgie1DvnbJ7G3kT?=
 =?us-ascii?Q?kJaZokuB8t8q4ylXbBPyHg1PXcxLazlSLWUqTQeg8skXky3JmsMSVGfU4xGQ?=
 =?us-ascii?Q?c6ni1GqIsHfNgegaI8mx4KqFHD9sL7+MnhQWh1PcveNL+yUlpLkBmfdS5I/1?=
 =?us-ascii?Q?1jr3zY/cCjPH+dseoj1wKPgM0fhd3GhYp53T3vqR512mWoe+iEywMKoS3WQi?=
 =?us-ascii?Q?izbgtk5ajR5kox8dqr4romflVb0ICSV6sFipP836lOGZeTv39YzxVAz36MQF?=
 =?us-ascii?Q?qyvUQ3esRYHWgtH4/AKlQZITaOOu9P+7eOlUliHPRVnZz85sAYf+lQGcdbOC?=
 =?us-ascii?Q?tXw215wGlpatXMkvfSbPROnnFcTNt+Krh2OAaqAAwTbmMfMX2q+A3xJ0cDYP?=
 =?us-ascii?Q?GHzYwkk544xzWN68TVGoWOz/Rg4rfhJMtkPVWDotJx1AWIF0CfOfg/tsHime?=
 =?us-ascii?Q?nKnr224cFPbcVtQ/sQxOc9YrhcgpPZXVPo5H3wMdbY++BKQIZocyUNclqy0v?=
 =?us-ascii?Q?vSaUPG2VREoI+9g0MubA2DSkX7pvO45NM3zladqxyfQRC064Faw43d/DBave?=
 =?us-ascii?Q?0moTcjE1aJNGU43Rw8qdjvsp/Va/ppZ6z7zLGaKYpKGxV+fJPSmfyBuNbro3?=
 =?us-ascii?Q?BmEuo66UewPV4ETaJhwrpj4yfkCEBMJZNIl3QUpxF0elCX91k3KQ0b24RZ9o?=
 =?us-ascii?Q?TFzhAKGTLfXYuZLiTJmZgi+gS19a6hj4vUbNhr9mJnsf39F1LcfjnL1niddb?=
 =?us-ascii?Q?uqkwUGQBdEIQjNgLlkteO8LsJ2e3paG4eGZmFXQKJbcCFy/CaqcaZTrVAPQ5?=
 =?us-ascii?Q?Ojp4zRHAJFN1lx4S9PLQLpuRmLEi9vynMgVItIDb4c0Vixs918bBTPL+wItj?=
 =?us-ascii?Q?ngrPomVlWaAj4FBp48rcOm0CniyurD72K8mXff34aTgL71oeVMZoJiDJBYhh?=
 =?us-ascii?Q?c2MeKzR0AB04u7MbGF4fyCAxtkF0O/RN2udBK1fssf+fbCzgMxEt7/RlhXM1?=
 =?us-ascii?Q?3zJTCwUQ7npweYyh9k3bByVh7jTBJ07iIvD8w1K8q/YnfO8EC9qWa1u2d1Yk?=
 =?us-ascii?Q?ovATRuh+0vyw+x5VJcqxscD8?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1747
Original-Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	729bc76a-49e9-422c-e474-08d900f1c739
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S+iKVSFrHnL/QieClgv+NdJsu9Z6m3PbIeBHrcF6dDEsy2Iv9fodNYkuBB5MFfybd6ZI7py0XWERzha1q8n+19vHZWZeZaiKV9hCPJEeXen7sdYrCa3XkW2mhN2E0L8A/qHbtsBkbansGjc7GdjbqpPLICrF8Z0CO7IzLgtKzoksTMG5Ut0Hqtg/odvgl482mXPq+ME6C48pX+1+0zTk+q4HbhnG6xCo8TPa9ZP54DrwzOKlEBCdPhCgp6nb1SvqBDRFPYbwSj6HuDJYh5nX5oTAiyYzbxPE8ksjSMIEWZ/WmdRep+PNE3BSakNXisx/svstEX6GN6OsfeMOTYR26uaaZ/oJ/S/wJusemxrDxU2Fdpa9mVPMEelKHK/9vgTP3RbMNzNYy7sMJviy+vaKclDds44B4LV6f/TXWa6pmmdCNvB4rXAqDGhaGKxJ/5MXIPzWPyZ357xDk3TvJa7eyLyQvog/gaNfL6vfXtqOd1P53N83usR78LleKExxEevqu40lc2c3Ku/ECaw1d2OCSCGOLPE3OhbRmE6YSBGaX58n2yIQCX4el1oOkxlCempvC6gE7mdP6UIsuZYkqPufLwrvS/EcKNsd3zep07Mn5c6HWWh6urTXIHcZZwGz/9xCTGxSgvtQdXL09omkqqwivL2hVadYWFohGrrLkXxi1DM=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(956004)(478600001)(2906002)(2616005)(83380400001)(70206006)(8936002)(81166007)(70586007)(336012)(316002)(47076005)(44832011)(6486002)(16526019)(186003)(82740400003)(6916009)(36756003)(7696005)(4326008)(356005)(6666004)(36860700001)(82310400003)(8676002)(26005)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:07:55.8463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac3abcd-7384-47c7-8556-08d900f1cc0d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3418
Content-Type: text/plain

Introduce --fetchdir parameter to layerindex-fetch enabling users to choose
the directory to fetch the layers different from BBLAYERS_FETCH_DIR.

Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
---
 bitbake/lib/bblayers/layerindex.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index 17dfc9874d..5816d70bfa 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -159,12 +159,17 @@ class LayerIndexPlugin(ActionPlugin):
                 logger.plain('  recommended by: %s' % ' '.join(recommendedby))
 
         if dependencies:
-            fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR')
-            if not fetchdir:
-                logger.error("Cannot get BBLAYERS_FETCH_DIR")
-                return 1
+            if args.fetchdir:
+                fetchdir = args.fetchdir
+            else:
+                fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR')
+                if not fetchdir:
+                    logger.error("Cannot get BBLAYERS_FETCH_DIR")
+                    return 1
+
             if not os.path.exists(fetchdir):
                 os.makedirs(fetchdir)
+
             addlayers = []
 
             for deplayerbranch in dependencies:
@@ -206,6 +211,7 @@ class LayerIndexPlugin(ActionPlugin):
 """
         args.show_only = True
         args.ignore = []
+        args.fetchdir = ""
         args.shallow = True
         self.do_layerindex_fetch(args)
 
@@ -215,6 +221,7 @@ class LayerIndexPlugin(ActionPlugin):
         parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch')
         parser_layerindex_fetch.add_argument('-s', '--shallow', help='do only shallow clones (--depth=1)', action='store_true')
         parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
+        parser_layerindex_fetch.add_argument('-f', '--fetchdir', help='directory to fetch the layers')
         parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
 
         parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends, parserecipes=False)
-- 
2.17.1

