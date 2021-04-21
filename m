Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web09.13891.1619018457123844787
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Apr 2021 08:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=tBwlAX9p;
 spf=pass (domain: arm.com, ip: 40.107.21.73, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbyy5EeKuLYBjch47nkixerh4wfN6xaXUgzrKBSew7o=;
 b=tBwlAX9pyK9WVKzdHOokRduGx7vSEOIZrgBgViddoFyxe0Rbu5AlPnXUSvv2xSLwMsNSEZ2rmNmt3IBZk/X3b0UjGoQQ6ucbEMuYAxzirDhMqbaIfK1xpGSeYvcjQGIAG+MLOUbKxrM1LK5VX+YfqT87chZhR0h8h88vOObvn5g=
Received: from DB7PR05CA0065.eurprd05.prod.outlook.com (2603:10a6:10:2e::42)
 by DB7PR08MB3129.eurprd08.prod.outlook.com (2603:10a6:5:1d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 15:20:52 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::ec) by DB7PR05CA0065.outlook.office365.com
 (2603:10a6:10:2e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 15:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 15:20:51 +0000
Received: ("Tessian outbound 47ca92dabae7:v90"); Wed, 21 Apr 2021 15:20:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b528eb6abd6b0f55
X-CR-MTA-TID: 64aa7808
Received: from cb67e04f112d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1C670AE4-AE41-4702-9007-A0837CA38F47.1;
	Wed, 21 Apr 2021 15:20:44 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cb67e04f112d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Apr 2021 15:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8dBYvvjpHpe6CITsTBGAFQc4Ak0z2Ygjma15suPS+5W1OTSy51Az7WGteRzBRxUvZnSbLGeeRhhccWEb1fesf0zPcm/0JOxZdeF1OsWzjV968r/WhW04QR9RCKO4g3vSAzeidNSknttJOAIGvroECSvtOTXgl01JUCKWUJ+YGngJSn4YU9zC17aXkHgwsaEzUUIFaksljWsYk6tMmgbQvMI5j91pgD4hp1mhrS2ZjYbVjEt5h55oC69w7DgeQncVECKAe1bed+ywu3V1ZBMoxwgbZKpe2wyOJCsx53YyYcyyhpdeoE2z+Sy3HAEC7EBdX2iyw9q2NNCGPc5IvVqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbyy5EeKuLYBjch47nkixerh4wfN6xaXUgzrKBSew7o=;
 b=C36HT8VeHgc3Clo2Qx549isYBPW2uulIBn1GJUxRh2s+yIBNtvnxh5XcoxxsnfsZMyA0N5sDkJfBhsOLc/XWh/4n3BglFUHWXOzoclpz3mwTofcFgtFoOF/QSYKNeqr4/rz48+nJyFCynZNNjPzUEJRtXmA00CJ3bnorqjnpMJC23Ibpkmbv0LZPF6lZSWswX4tvZuvn7eIO9qja8s94kHFCMs42Z40sheMNMjgbJp7yA8BP+bmlvCdimf534XNMZjmeuYxQ54CbRI14umYfqugMCbn2Uj8sfhXnC39zyl1IRq9DT+BINCUYb7dJ6xUHsFItK5j0GirBA8icL7D6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbyy5EeKuLYBjch47nkixerh4wfN6xaXUgzrKBSew7o=;
 b=tBwlAX9pyK9WVKzdHOokRduGx7vSEOIZrgBgViddoFyxe0Rbu5AlPnXUSvv2xSLwMsNSEZ2rmNmt3IBZk/X3b0UjGoQQ6ucbEMuYAxzirDhMqbaIfK1xpGSeYvcjQGIAG+MLOUbKxrM1LK5VX+YfqT87chZhR0h8h88vOObvn5g=
Authentication-Results-Original: lists.openembedded.org; dkim=none (message
 not signed) header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM5PR0801MB2114.eurprd08.prod.outlook.com (2603:10a6:203:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 15:20:43 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 15:20:43 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com,
	Diego Sueiro <diego.sueiro@arm.com>
Subject: [PATCH v2 2/2] bitbake: layerindex: Add --fetchdir parameter to layerindex-fetch
Date: Wed, 21 Apr 2021 16:20:04 +0100
Message-Id: <361c2a75442559001b864ff0f525ae25c8bcf6cc.1619017963.git.diego.sueiro@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3b56d18433d4fb52fa08beb2d725999b296c73d2.1619017963.git.diego.sueiro@arm.com>
References: <3b56d18433d4fb52fa08beb2d725999b296c73d2.1619017963.git.diego.sueiro@arm.com>
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To AM6PR08MB3461.eurprd08.prod.outlook.com
 (2603:10a6:20b:47::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e120809.cambridge.arm.com (217.140.106.53) by LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 15:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f41f5bd0-e58b-4312-e91a-08d904d90cca
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2114:|DB7PR08MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DB7PR08MB312990C846CFDE011B61EE2192479@DB7PR08MB3129.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:597;OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 K3NeoKBN6GDVYkjtqS5Ea1t1Eg9Ueb+LGv/C6j2yNU05gmgk1+j4WIZS4JbCMfKygO7e4KiXmyeYPUkE4rDsniTh/sQnLo87s+yUVx06UtnLJ/qdwLFTkr3bbWRdEDC4dd7kauMN5BT1VmokZo3ukTAAHZltC6Sr0yraf/L0uWTYwNXNfN6LycGnkc2E0EVoGXJaRxaC8qb5fnNkEJccGNv049l9OmRai7ms9/vMvZQOqvT54F2J7X6nliUD/IvKJCADjsEgo80azvEC5A20T3UgNEB/ftgamnNknqcvZyFHMBTh29N/umX6oxkreky6z7lNGuKqs9NlvQXwlsKu5Xu7CsDyu+wYMNE0Kkg39V2hvkiV2fZP5C1FFlcFVozVEh+FbOI4iRh524Is+aGaZT+f77erwl+VV+SIX9QieG3SvQON9O63MWRZLErEjmb3kQy0Mog14vVay4R76KzV2tgf36T+OjFHfcBmFhV8N9Du1PNoB3Bma8G/PJPWh7xVOzXD+7mSlQMbGiVutaxySe6Z3mEUMAAetpIJZtBhBd1MiAwA1pBfH6yyQsv/OjPqIEdpYJuQ/+ysILes15LupWP9wvBhzt5G/c170R8u0Y3AIuPm9XeMzyCqpFM4X2hbWZ/E+sUN7umK8mMMkz4I7TwH01CEBOO8gvV3j8496AC++/qWsmy2vIMG2XlKtcxc
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39830400003)(376002)(44832011)(6486002)(508600001)(34490700003)(38350700002)(6666004)(5660300002)(186003)(83380400001)(52116002)(956004)(38100700002)(36756003)(66476007)(26005)(16526019)(6916009)(8676002)(66946007)(4326008)(2616005)(2906002)(86362001)(66556008)(8936002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
 =?us-ascii?Q?xfa5+vGIa2CNxdREoz/Kf1V15Z6WkvKMc1k2T6m4umJoLMiIL/8Bd3qRo6G2?=
 =?us-ascii?Q?/nYVSSEejVCQNIDdJt2YNKKoCpA1uZ/KYayD4m9DMi4YHHVnOwLvCJAZWroh?=
 =?us-ascii?Q?PHhQMZpmj6LrMR+sJ3uINgJfXpH4DyzDZ5aGnWtCrA3hUGaDXG3Dwqjz4dj2?=
 =?us-ascii?Q?PrIkp7216W7OHrwq9JasAjT7BER0vnMTHRk48v5w7r53JtHoj0AVoQmXMihx?=
 =?us-ascii?Q?2NTRMZctk4u0eu+jCESNt4XcahcnMmspC4bm3HncyfXdz4CcXd+pi0zRiMD/?=
 =?us-ascii?Q?ZXQEfA83BEo7rGmuyW5cCV6XmXSg1yovjLA1/q6f1k1HKbDXsO9favzZxkGz?=
 =?us-ascii?Q?8Gfj8VKtBblc8hJZEQeEMPGUpMFdxzAhW5djDknjoTunYnj61Z249kUq1Hkj?=
 =?us-ascii?Q?qvnCn/awv81U+E9iEdIIWPzTVMY5wfbl2YPxYUHuBKY2XihXsVYwXxID9Xzi?=
 =?us-ascii?Q?oE4W+xHQMLXqZYGF6SnQh48Ccy25r8SBXqUzINvNbL/XrhphcLmUf9rBpgOh?=
 =?us-ascii?Q?bXNv73AJiiQPtM0OAAf/wQgjz0NYnWW/DtJLM4cJLuxaPi8k6aArSYrENEiP?=
 =?us-ascii?Q?U8FziT5QHyqJq1kGIhkpA2mObkO7AHshur5MAMtLq5HHjD54Ar1UCUwWUv3M?=
 =?us-ascii?Q?eBoyKItoeK75l7xNaIi5FHvxehib6dMKoXBdq+1OT46Qu35rEE8obIsPbpWN?=
 =?us-ascii?Q?v8t2JRXjlNXsflkvoObKZG3brnFCm2Risrry+VA8w6HlvZOBtgJlZBfbOx8u?=
 =?us-ascii?Q?+vamEyMCNwpfrG18kkcS3UhiVwmsxgo0yHVd+Fo0XCNdCnOsRFQyKNMhwBvO?=
 =?us-ascii?Q?P2YIkR1Y/FSa+Um0fe0aK3SuczZ/l6JGxpNRgxLitxW0X2RhSrYuCJXdNJVr?=
 =?us-ascii?Q?rQTuq8qKxcuZm5Aa7wYD15wuAWC9SE42fYyaflfKNW8uTWpf7MWmNdeEAIfb?=
 =?us-ascii?Q?s5j/Jqzq4OdNszlUOXyuZpnO6+QEU4gIbgVonZnn428HlzQoHwflgltOHJL4?=
 =?us-ascii?Q?bUC7dfHjloWw5NGt6z2zDlwZ5P2QBdU8kzHZThdFsqSS6UWoovOFZONpNYCv?=
 =?us-ascii?Q?j7TmGMAVXKciynwnAqJyq3dMg3JuqORMYFmjzGdQuSsHn8XE168nki2VLFul?=
 =?us-ascii?Q?UvzSCBngtMlB4HQREyQ60OMb1wDQCDftckEMHpA9q3GrSeuft4gU72qtPg5a?=
 =?us-ascii?Q?vKYugivH7QzsQfXSb3mgYTLiUIF8/TtLLsMlReMm6xlMI2H3JOjW8R/4rPjL?=
 =?us-ascii?Q?4BL6NqmzZcO12EqiQuWwbaOIUbUWMuxlifY0tTPbGw2kcHLA/7i/SONL0vJz?=
 =?us-ascii?Q?c+rZb674YNHQrvKQNjCh9OcF?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2114
Original-Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	367d3374-ebe7-414a-1715-08d904d907db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0aBkmzq2+HbfbedxXabpTPXHlujC2f3vmAzp5mGCL2vi+5Exx/g7zFlH8l/IBk6Mo41Jga4xAQGx1X7QzUhMwm//QNTIOALUBDLmzNv+a3NIifD7c/BLRpO1tdPezTdOZ0qdpNaFZbI3On3bXUhe0r36n4mblu9kcX+h/PIZzq8PHZbPf/3xwew4fWd0Yk7k39CtKP1BzumyBSmXbu6sjtvUP6XQQzvF+SnmY2O9V24TuM0+Sy7tUA3gnsNgzer0Nkf3UyKE9rkf/t5POpPPnsPanlpuVC9GcrvwX6RaRynkU7wIx9zZH2EKE6kKsESciDsmjaKMxcThyhAfx91VMwTR3G6Vx/hnyRDj0xHSv46YHKzsJlYdrRgvK9D75jkrWzvfcJpYPlx15uoCvzDFpGQQL7JQDQJs+8aFAhOGuABFzutejjbLvNVkhfiEhfbbPa2ze4rsY7OQnPe7TEjqibrTVX4CLXOQDvzvPrRsSNR21Kk08foPwHE8Yy1NWN5Nt3ZBW/IdLE43DERlBf4H+3e+KH/T1OBIXhajtPy8KTpuVJntS6Pb2bsyDeGhcBHLsO0nx7qzmwa6FgqM9nFsqy6RE8JhayhWOa0uqBHuKYmLvtvtR78csKY82ZuavSH6O92UmfvAOoMcaym9AlIHcouekiYNfcJr0gEp000vjig=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39830400003)(346002)(46966006)(36840700001)(6916009)(86362001)(44832011)(70206006)(6486002)(82310400003)(83380400001)(356005)(36860700001)(47076005)(81166007)(4326008)(5660300002)(26005)(508600001)(336012)(6666004)(70586007)(7696005)(8676002)(16526019)(186003)(956004)(2906002)(8936002)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:20:51.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41f5bd0-e58b-4312-e91a-08d904d90cca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3129
Content-Type: text/plain

Introduce --fetchdir parameter to layerindex-fetch enabling users to choose
the directory to fetch the layers different from BBLAYERS_FETCH_DIR.

[YOCTO #14347]

Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
---
 bitbake/lib/bblayers/layerindex.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index 17dfc9874d..7936516209 100644
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
+        parser_layerindex_fetch.add_argument('-f', '--fetchdir', help='directory to fetch the layer(s) into (will be created if it does not exist)')
         parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
 
         parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends, parserecipes=False)
-- 
2.17.1

