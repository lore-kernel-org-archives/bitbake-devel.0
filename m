Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.119])
 by mx.groups.io with SMTP id smtpd.web09.9958.1613667267730274954
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 08:54:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-onmicrosoft-com header.b=zTj/Zly6;
 spf=pass (domain: nokia.com, ip: 40.107.21.119, mailfrom: jan.brzezanski@nokia.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlsWksB6D1f1SLnmeCA4hYZKOw7i/KdXNEhOi9HCuk4pGb1a/PdfZZKG5UFibif559a4BY2HppvoD3drT8M4em4RAHz20kICfbVqRTlCPgM3jqvi9FmKVFOgQ74pCuMpfte79yQMWtRYyJOpr1vq1CurrBpJ5MIYt1m2bK00WKyDvHleKvfnXaojBwlwCXegUmSXcu/xwrCWcSfzgDyoMTZ5+tcRLpffBzPMJmlduC4M3ai5B10Sx7Y7IZKsjcdJePNTfdVHqjpvEt6vLUWPDTDTlME7bM06Z64EYjnnf/x/8pajvagMeUb6sPAZe1KxB7CgiyqPaf2VGQ6xA3HZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wia8RnpxhAxuIcah6rFA6jKY1c/I4JuR0sSlKzgmBEU=;
 b=c+HZetvbrjPRmwxGqbLFyQtOD6rw5+O7ESUjVvHynA/5vUar+RhvfTmfFO8+eQP2gU18cI2/Z3fOpF8FIOQDdTH0HoZsdCEYruRJrQly518nPz/Px/nVHg5iV/iV/1mNMb82jZ/nXoU5368UMufBZgnApCYUB19OnSrWAkzqqytTYCd2gCxyEuuknE+3+2eKLeHKVeQetxitdu7h42qlyHKWKy3iEjAdtsiwOTDCfBWA8kRc6sluHq+rYWjy+hsSar/eDlHi2cPGE5+rwV/f4r3DWektQZm28Isdapz5VXnocIUd1P9drobbhkHFbku64jxuhqq/PJm+QOwDcmOAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=nokia.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wia8RnpxhAxuIcah6rFA6jKY1c/I4JuR0sSlKzgmBEU=;
 b=zTj/Zly6rBDttSgDMPy/zjBuTLl5/9zyFxCN+DP5++r/1qy876/xtGy9KJ36LxIbId48WIXo0VWuVYi+M5vUPd9zIbXtch3rupdbuW4+Wb2QH47y0Xzzgf9F1nbycKxlgy2H4R2KJEmAX7hrKFYEG0+mx0cdJm4ALgaTj68s93k=
Received: from DB6P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::16) by
 AM9PR07MB8002.eurprd07.prod.outlook.com (2603:10a6:20b:2fc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.22; Thu, 18 Feb 2021 16:54:25 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::e) by DB6P195CA0006.outlook.office365.com
 (2603:10a6:4:cb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 16:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=fail action=none
 header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.100; helo=fr711usmtp2.zeu.alcatel-lucent.com;
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 16:54:25 +0000
Received: from ulegcpding.emea.nsn-net.net (ulegcpding.emea.nsn-net.net [10.151.74.60])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 11IGsNEU016485;
	Thu, 18 Feb 2021 16:54:23 GMT
Received: by ulegcpding.emea.nsn-net.net (Postfix, from userid 62230471)
	id 639DB15FBA; Thu, 18 Feb 2021 17:54:23 +0100 (CET)
From: jan.brzezanski@gmail.com
To: bitbake-devel@lists.openembedded.org
CC: Jan Brzezanski <jan.brzezanski@gmail.com>
Subject: [PATCH] Force parser shutdown after catching an exception
Date: Thu, 18 Feb 2021 17:53:32 +0100
Message-ID: <20210218165332.13461-1-jan.brzezanski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Return-Path: jan.brzezanski@nokia.com
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf8d47e-405d-4e4c-55b7-08d8d42dd90f
X-MS-TrafficTypeDiagnostic: AM9PR07MB8002:
X-Microsoft-Antispam-PRVS: 
	<AM9PR07MB80020126B4CF42C9BD910C8A97859@AM9PR07MB8002.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jybnA5E2Kx9kLSclrQai8DmW2TaGQu3X4BwJYD2HVu/vrLrQ3u3eam+ATjJGSRLbWM+EiSeb+kU8V9XKabq+Ou47wk17ghJuKsrNbIyWy+V4dejlEdtCNvOQviDVcwWlavv2wX5dOLIVbxA7vQJZSWTzkzLIW9UPg+iDY2ev9BFiqKj1DyUtWOzaifJE9mzHZZCBHNV/uES2wtEUn3FlAqDSKu6yEQ2mIp01sQKqjTrxMmDnt3sZiruiKnIrbpglulfKm6Npi67UBgOIqXuxDn2QttNEx0rfz4dmzN3vYV/BBTGedOkqMWg9nft/0J6AlxGpPO55G20sQ6FVOl1nJuCdZR0K9WXdIs0DqoDEMXnpcK3LgEMZ99QdUTt0/VjdacOjUDqTDoAVZ/ffnp+ODndI/iiWtDGAWe/7gQs+t54AKRGTHtBJAWJtC+c+3whSqHjBF0ngIm3kmFvcw1rAM8apkTczBKCI6v1pgcUhPYSo1wGRSEcsUnnDZ/N5Suc3vyTdDRJR1Kh1cqfd1BFNIqOwac8F6xTBxoDN6dMPB92syTHVKO6v+xyWPsUBDbvMugCUDzwQlaUjhEbnJNid2JGhXj8XFgUQ1ARAANk//hPFJQxu7bHa8qEU37Eo3qbC5S76gzy9eDftNaylT1kBXTF7VH5PMaEMcj3R6ez/NdM5rLAQ6d+bsNfEIR+sjQRmS/3nRWmIm8HVXulImV4a+SOX4AU0lPVHgbrk9xLJRFiF7uQl4jvr9rmKxw3Q38/P
X-Forefront-Antispam-Report: 
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(84050400001)(36840700001)(46966006)(5660300002)(83380400001)(47076005)(6916009)(82202003)(8676002)(76482006)(186003)(83170400001)(8936002)(356005)(81166007)(44832011)(70586007)(70206006)(6266002)(2906002)(36860700001)(42882007)(478600001)(4326008)(2616005)(336012)(82310400003)(42186006)(26005)(6666004)(55446002)(316002)(73392003)(36756003)(1076003)(82740400003)(45356006)(36900700001)(35450700002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 16:54:25.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf8d47e-405d-4e4c-55b7-08d8d42dd90f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB8002
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Commit bebef58b21bdff7a3ee1fa2449b7df19144f26fd introduced forcing
parser shutdown as default in case of build abort.

In this case bitbake sometimes hangs after facing error during parsing,
waiting for child processes to finish. Killing it then will spawn zombie
processes.

Thus we force the shutdown after catching an exception.

Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
---
 lib/bb/cooker.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0e492b9b..f4ab797e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2211,18 +2211,18 @@ class CookerParser(object):
         except bb.BBHandledException as exc:
             self.error +=3D 1
             logger.error('Failed to parse recipe: %s' % exc.recipe)
-            self.shutdown(clean=3DFalse)
+            self.shutdown(clean=3DFalse, force=3DTrue)
             return False
         except ParsingFailure as exc:
             self.error +=3D 1
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexceptio=
n)))
-            self.shutdown(clean=3DFalse)
+            self.shutdown(clean=3DFalse, force=3DTrue)
             return False
         except bb.parse.ParseError as exc:
             self.error +=3D 1
             logger.error(str(exc))
-            self.shutdown(clean=3DFalse)
+            self.shutdown(clean=3DFalse, force=3DTrue)
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error +=3D 1
@@ -2231,7 +2231,7 @@ class CookerParser(object):
             tb =3D list(itertools.dropwhile(lambda e: e.filename.startswit=
h(bbdir), exc.traceback))
             logger.error('ExpansionError during parsing %s', value.recipe,
                          exc_info=3D(etype, value, tb))
-            self.shutdown(clean=3DFalse)
+            self.shutdown(clean=3DFalse, force=3DTrue)
             return False
         except Exception as exc:
             self.error +=3D 1
@@ -2243,7 +2243,7 @@ class CookerParser(object):
                 # Most likely, an exception occurred during raising an exc=
eption
                 import traceback
                 logger.error('Exception during parse: %s' % traceback.form=
at_exc())
-            self.shutdown(clean=3DFalse)
+            self.shutdown(clean=3DFalse, force=3DTrue)
             return False
=20
         self.current +=3D 1
--=20
2.30.0

