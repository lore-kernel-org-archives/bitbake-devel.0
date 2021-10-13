Return-Path: <cal@brightsign.biz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26997C433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 12:14:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.97])
 by mx.groups.io with SMTP id smtpd.web08.7311.1634127287984443778
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 05:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brightsign.biz header.s=selector2 header.b=PW7wvc1Q;
 spf=pass (domain: brightsign.biz, ip: 40.107.94.97,
 mailfrom: cal@brightsign.biz)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5FpVyP+8V40WOwMDnYfE+wEqjDaZaVbSgqh5QktfTlhEbfNlVU54+oSC8KItg1QJ/gDEEk4UBssmXEwu/htyCnGFnPzUnbZyrZ12V964dxQGi1ISnXuL3kxFg/IK+aka+9c5Qh5wcTpNDBIKDJXBqATO0bFC3h9Z6qsB7YHzpEp1m2k+5IWqQdmsoVpRC4d8U8WLPgX/7a1OV9SZgjmmomug/fOSK3zCnZSpChGNAPqBgpiTtqWBWcPRBx0VMa6vdNLXKazPRkjy37ShHdYDDZw3D6RQ7+b0GVhrmoOJmpVGq+RrI2Vtnv3O9/aHwYdXk0gUPHCDY167D6i92pAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEM7S0tt5g1bYRkOrJm2ZcraR5ZlVKPIn3KFU5/34fE=;
 b=fOtnCvdmTllKzKi1G8YQrgerTGfb7dELtAAntwsaGc/KznnnKZTDyaCnq7pdVJ0/2MvK9NYvmCFbTTBRlkhvuSpie2/a103hbmxLZ5Yu2ZqxmNKM3tkHzRI2SKjLvhAxG18of29T7BRlEvBZkBw9fjLXJUhCoUzSkV0CBm/+jTyQ8I2fMXwYRD4LrJL3sUn/HlJVbz7WAFiTaM3BOcfANZWnPck0fhPqV/OqyB8sHzANq1zhM9ngwwz4aerBF/QRqKs5s+lvpk1aU0e33gQxDF/oqOzZVbBNxNJOxmtgRtbHUAfIMT7SiAVJkoI8SVHj9HOq09H8PaS/NZeXYfXc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.138.180.132) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=brightsign.biz; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=brightsign.biz; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brightsign.biz;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEM7S0tt5g1bYRkOrJm2ZcraR5ZlVKPIn3KFU5/34fE=;
 b=PW7wvc1Qo4jjgErbwEbWdkEO4ZUduqzC/XE4aMGSRzZ09B7s3XtC/Q622FyR6W/OYYe0gdOINYjEnQbssm+khHxrYQb/e40X9ceaeyQVN1vv7oDdA7nM2BwbYh9P8f/ngxMz5zGy0LgCRWpB1a0T5EriMpInW/yHM2cR2kHMFtWRuLtmlFV/ialzsUuYhuw77CqsQt4XCxxFANG4IdXv1O7LVnesBrFubBBSeWkbXmNTmhrouy3Kwa35TgDFktsB5IB0HKev7zz2kg2P5JhmjjlIJ5zCP0ED7TUMU+EV1vRlq6gOYbxgssxgNTo+vwsN/6e1bD4wzn1CjlzGkvzZHw==
Received: from CO2PR04CA0150.namprd04.prod.outlook.com (2603:10b6:104::28) by
 DM5PR2201MB1499.namprd22.prod.outlook.com (2603:10b6:4:35::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Wed, 13 Oct 2021 12:14:46 +0000
Received: from MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::c) by CO2PR04CA0150.outlook.office365.com
 (2603:10b6:104::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 12:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.138.180.132)
 smtp.mailfrom=brightsign.biz; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=brightsign.biz;
Received-SPF: Pass (protection.outlook.com: domain of brightsign.biz
 designates 217.138.180.132 as permitted sender)
 receiver=protection.outlook.com; client-ip=217.138.180.132;
 helo=elite.brightsign;
Received: from elite.brightsign (217.138.180.132) by
 MW2NAM04FT048.mail.protection.outlook.com (10.13.30.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 13 Oct 2021 12:14:46 +0000
Received: from ukcam-caltinbasak01.brightsign ([fd44:d8b8:cab5:cb01::7b])
	by elite.brightsign with esmtp (Exim 4.92)
	(envelope-from <caltinbasak@brightsign.biz>)
	id 1mad9g-0003Pz-KN; Wed, 13 Oct 2021 13:14:44 +0100
Received: from cal by ukcam-caltinbasak01.brightsign with local (Exim 4.92)
	(envelope-from <cal@ukcam-caltinbasak01.brightsign>)
	id 1mad9g-0004cA-JY; Wed, 13 Oct 2021 13:14:44 +0100
From: Caner Altinbasak <cal@brightsign.biz>
To: bitbake-devel@lists.openembedded.org
Cc: Caner Altinbasak <cal@brightsign.biz>
Subject: [PATCH 1/2] npmsw: Avoid race condition with multiple npm fetchers
Date: Wed, 13 Oct 2021 13:14:41 +0100
Message-Id: <20211013121442.17696-1-cal@brightsign.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5886bb08-d3cb-4570-e300-08d98e430bb9
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR2201MB1499239A3C80248F271BD1E6DAB79@DM5PR2201MB1499.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AXhND6HkoemRgIupjtI5NtvXGPV4g28iC0FJh/zdDCSXUhJ+ClMkr1AiwViScSVF/LlPRGe+LHSIUj/voxrm8PgmPbnLoUmKi8ObwxBhbDjwCzmoKfJHR7eoN5/ltfIIdeSV8Kw0Ycu9cWrG4PH3oFtH2RdyoCZdcLLPyyyRzzCANV/3XC03c0NYePvtq80qwf8wc8+b7emTn1ooXu/reAVz/TDqWo1jHarUdAXucLd96DsAqWy/Gs3vci+Ic2BqOk2UUfbgelg7Rf1xBhevqH0wWu9t8STOMf7jPYSsNIfWmaLluTEytsfbDeIWdKshidTCd1nHFnllEcPXKA3ytyM8FgR9c4ebcxYJsRbZu7EOL3s5owfQIFw8ntKDI3sT9AmoNqnL/HnpV9biZGBws7m+U+9JdstdIsjg34cBXkHxZsM+hAG1mpXPDkGsDWOoWDqfLeaetwp0tFnCdlcbPdH1Sr+GzhVDyyHDfFiQkX8V2qXpKDhm47wjdWBi5BjPGxkZfelY49vKcVAbcO1DuIIl3NsEvwOZKWvfWMqICAPFbVxJooh2V4bWFqvsIWkIexeVXkzQGXBhWhTh66qaiiVy+kqDEdd4b5HLldzfv6heUiAtUFkvJJKyrnHmvk4grK5YE/c0tq/wdqslCsxuRtK7FHN3iffqF3Sv6lVxY7u/8XWn2b5qMQFiPQSDogTCGFIVjiOxPi+sGW0YW7mJmw==
X-Forefront-Antispam-Report: 
	CIP:217.138.180.132;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:elite.brightsign;PTR:elite.brightsigndigital.co.uk;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39830400003)(376002)(46966006)(36840700001)(6666004)(70206006)(70586007)(316002)(83380400001)(47076005)(508600001)(8676002)(70036008)(2616005)(36756003)(36906005)(186003)(356005)(86362001)(6916009)(82310400003)(26005)(107886003)(5660300002)(1076003)(9786002)(4326008)(2906002)(36860700001)(8936002)(336012)(9746002);DIR:OUT;SFP:1102;
X-OriginatorOrg: brightsign.biz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:14:46.0300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5886bb08-d3cb-4570-e300-08d98e430bb9
X-MS-Exchange-CrossTenant-Id: 8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c;Ip=[217.138.180.132];Helo=[elite.brightsign]
X-MS-Exchange-CrossTenant-AuthSource: 
 MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2201MB1499
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 12:14:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12764

If multiple npmsw fetchers are trying to download the same npm file, one of=
 them
can try to download the file while other is calling verify. npmsw methods g=
ets
called without holding the lock, which causes race conditions in fetching a=
nd
verification etc. Lock the lockfile before calling proxy fetcher methods.

Signed-off-by: Caner Altinbasak <cal@brightsign.biz>
---
 lib/bb/fetch2/npmsw.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 9523cece1..426a13965 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -30,6 +30,8 @@ from bb.fetch2.npm import npm_integrity
 from bb.fetch2.npm import npm_localfile
 from bb.fetch2.npm import npm_unpack
 from bb.utils import is_semver
+from bb.utils import lockfile
+from bb.utils import unlockfile

 def foreach_dependencies(shrinkwrap, callback=3DNone, dev=3DFalse):
     """
@@ -195,7 +197,9 @@ class NpmShrinkWrap(FetchMethod):
             proxy_ud =3D ud.proxy.ud[proxy_url]
             proxy_d =3D ud.proxy.d
             proxy_ud.setup_localpath(proxy_d)
+            lf =3D lockfile(proxy_ud.lockfile)
             returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+            unlockfile(lf)
         return returns

     def verify_donestamp(self, ud, d):
--
2.20.1

BrightSign considers your privacy to be very important. The emails you send=
 to us will be protected and secured. Furthermore, we will only use your em=
ail and contact information for the reasons you sent them to us and for tra=
cking how effectively we respond to your requests.

