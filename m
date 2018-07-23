Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 2065 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 23 Jul 2018 16:18:10 UTC
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
	(mail-he1eur01on0049.outbound.protection.outlook.com [104.47.0.49])
	by mail.openembedded.org (Postfix) with ESMTP id 951126FF78
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=b6UwrTdVkW8Sc/8kI9IpzvIuTacei8ik40pHb9TEEU8=;
	b=iDGIixugLv56T0dyHZ8KCtaQ4+ekSaoP5CfFv9q6gt5JcygfUBssb0Myf/jUqLIS1rHJ8FGwY/Yc+ST7khFWTfDN7zvjhd3iUO1WJ2QrHsNlFIyPixFV5Q686+8oDgv7OnuytJA61NrLbJfhY0Z4DQv84Z33MiBPXovtaZpzEn0=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:42 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:54 +0200
Message-Id: <20180723154259.9076-5-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d17392ec-c472-443d-827d-08d5f0b3116b
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:+zhQtK0VdWiDn8EfPZ1JZq1FZkzZTKf0NusGA+knRuD0RJpGU5QMsmCN4POsJpyXJCFM2gFLNQB1p9ddCIHTkyxijBOSTmWztWRnvu6nEpRfeTdCey5TXZJr1bmDhhx/IIkBrmt5jWrwXhx/1HCOgq1jUVm84mJmyCI8+lRABJVNBFwU/+xJ4hdTH9wk/8/vwBQJBxV8jXZkKNnlNmk+bELlR0IzFbhoLyUuLWP8NdKwqZJ0wf0NV+hZ2u2O5RJW;
	25:CATBm8rb7tDOsEgCEsiFOE2OB91YRZ3I5ZsAaIYhtMnIRdMOdUNH5q5FdVjxVV574fxXt4eOXKl6oMWiBCqlHBwvIkXUgJE0jkKct1hkLzaLbbtVS/8PA0MMg++xQ76XpCb642fbtyRs2HOtNE3dCOPLYjmGBNCVV3f7qjF5ar45Kog+f5Cm8YI4ghoSMNcGmmLtcfEq0HBTAEGoe5CFQmZBN/H6nmMnxQZCD770lcjF+L8jw6FXpVwOYsl3ZO38yEhBZCkxGkphjnmGa+h8vX9uOZbmBZ/hdg7SIpxLkOzAvhWYZa7YN9TeMBgYPYyPGzCfrvWAtk/9qg8xhOBbzg==;
	31:4Q9W0yE7lzxly7p7rtqbveqp/WVdNDj/xRDj3cqjWd3Ug3aPe0H1+rdCbDxirxlNbdtG28WKh+ecROmVKmDM+AB12kYiUhmY6UZYjYtj59VEi7+InzM9v0ApIM9ChZFCbOSXGC5ZM6AjFibifYfzsAnTqEedlVZoDDHlopJuoLoJ/Vj63r7qxYvWCnyMBLpUn/WpA4K/PcAceiXkNchz9cnOqVFtNfEG0W54FRCbDRY=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827BAE71B710FC6210EE8CC8F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:YOiMbdUkwVepcvFfotQLexaM6KRSurpYS8Ilr4sPtmN60v3WKI1uizqRWCYZr+MYC4TDbOO+xrgMinVPhSpy5gRFsZGkUVEGisqRCRpNVgxpP3UQpTp/GbuTuHWSspCUVMsmY/itlxZsrU13dcPf6AGcjpj8JXYEjPQihq6H8svnJvzLp40DBI9BN6PiR/dwspKsx4H+oA75SgjJraxSZ4NAxWyFpheRISK37iSVFiOVwxqriaUJE4oCgiUb3yYp8BW1Z5bAOIQbClm2zGb+UNqjEf/Xdc7b7LNBBXi1ia4rPyVE78bEdvYs8aqfulAlySZrFYBRpj6hbpFUzzZGabXXZWPyMeS/LWQbT1mzAWwbIZ+NzS5nX487v6AaDl0S
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(81166006)(16526019)(186003)(11346002)(446003)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001)(2004002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOjg1UDBxMlBlNzFBZUR1K0RobXBlS0RDYU9Z?=
	=?utf-8?B?R3VRdDhTeUdiTTMyNFJqa2pJQ1kzSmNFY0FMYU5rOEpFMENXWXRvT2srbWJt?=
	=?utf-8?B?RGoweDZJMVJuR2NwQkZHSVdVUmVBTDhaeHVVa1VoemxpOFRIYzZXY1NVSGxC?=
	=?utf-8?B?ZngxaCtFQ0NieVhxZ3ZrR28rSUFiMElEVllZbGhYTVFmUFkvSU4yZDBlNTZk?=
	=?utf-8?B?dnF4L2Q0djVHekxnZ3oybUV2Ri9PNlFvWkRONVVlR0xRQzFqM1Y3aVR3QWYz?=
	=?utf-8?B?MU9ZOVhvYjFybUtSQjRocFJIZnVwaEhQSEo3WmFvY09lU21Ick8rTFlvS1VE?=
	=?utf-8?B?bzBCSDViZk9aVld5VitFSHg5b0dVVFdETTJvQTUzTThqV2EzV3MzZk1VSmpF?=
	=?utf-8?B?a09qeWp2cStReGFkcFkxVmpoUGh0bThCeGRvdXdkWXNVV3FkZ1l4a2wxMEty?=
	=?utf-8?B?em5hN1RtNUdQMXdnNHNLaDRzYmxzWkxrZ01pU0tqTWdvc0RkQ3pNUnVTdFFk?=
	=?utf-8?B?dVdQanBPYnhGUkQwZWFNcWZnVElEOVFBWnNJWUFSU2NwWSthL3ZjdGtGQnlj?=
	=?utf-8?B?MW1obnhERFVlRUlhc2hENDN5YW5CaXNUT2I1RFdwZ1ZNa1hlSDByaXZYTDhm?=
	=?utf-8?B?Q2MvS1hQOWdwSTI5U1hDUHdySnJ2ZkdLMVFwcllpckplbFVDb2NLYm5WNlMv?=
	=?utf-8?B?Y2hYS3pvTkpuOHF1Z1NtSGRucTc2SkZkUVJaRGV3YWo4UnMrVGFzMmNQS1Jn?=
	=?utf-8?B?dlJBSFdMMU1PaGJxRXg0SnNUQmFQN3JpSjVhWUhpWDFKZWJVODhhRmV0QVBO?=
	=?utf-8?B?bzNxL3RvTnY1WE1BTWlEbUhvemdLMkR4R2p0WDd1dVh6WHg5SzZUVGxNd2Rh?=
	=?utf-8?B?blVFSGNkazQ4L2xzRnh2L1JvY1FWM2tPN3FGaVJCcFAxVDhBTGNtT2hjSStl?=
	=?utf-8?B?M0tZT1VSZlVUYXhqUmJIS0NXSUkrY3BNakQzU3RLdmU1eklYeWo1K09hRlNT?=
	=?utf-8?B?RU9BUXR2dnRqTlpURjZrMU91Y3FUOUdxOXpSZGZZMkduZDN6d1pMTGQvT3FB?=
	=?utf-8?B?MjJrUHRnNUZsYWxHSUZvRVhvQTdkUHJuQnFrcUQxTWU1R2tmaTB3M3RyN0Jz?=
	=?utf-8?B?eXhrbFZ1WDFpQ0J3aXNBWGl6TEMwLzZkTkREQ0JqOVdYN0diVGdPNEdhQUJU?=
	=?utf-8?B?KysvVFZjZDdsSWxyNTJiYTExT2pxS25BVXNYTnFWRlRXbmt3NzVFTEtDd1pJ?=
	=?utf-8?B?djZOSHRoS3EwQUVJYjgxUWxzQndTNGpzUGF5N29nQzVLOGRDMENPaEg0QlRh?=
	=?utf-8?B?UEhlNWZXMGdhaDAzejA5VFNIQzdzdUpKL1VHYXZvdUdEdTA1eTA0ZGgyZW5O?=
	=?utf-8?B?c2M2cXQ1dkdRVmFiK2l3SW9lMUUyU0dOUXVSQVlCZ3VIM0M2TnN4Skg5ZWlW?=
	=?utf-8?B?UktvWkpIdG5VM2hjWldQQTJJckdURTJ4RkorV1NDOEhTWGd6QUxmSlhOQTJ1?=
	=?utf-8?B?Y1B6ajNxZmlCOXFUV05iTkxoUTNrL0QxTkxQMGtYeWh6V3JreENXWFZ3bU9K?=
	=?utf-8?B?WUFFT3JBejdHSVh6VXFYL2pza2FPL1ozclRLWGlhQnZsUUFzNjQ5R1FhOGJt?=
	=?utf-8?B?MHF1VGEzNGJoTDJkU1hrTlc3RndML2JRcjRyWnJkVTB1TE5RTmIvajArTGVa?=
	=?utf-8?B?enY1ZWRpRkFrREdxRHJUWEgyRU1SU0k1WlkzakVrcWQvQjlubFVwMUgyV3lh?=
	=?utf-8?B?aW1Pc3AvL295OTMvMVFHUT09?=
X-Microsoft-Antispam-Message-Info: KOeYo998PobwLiEZpYVk6P/gvQY1j4atJ+ZVoDx1mnmItXjQoH8Zku4OLGmhOT6HmVWtbIhYJtORZX34+i+UMkwvgJ/NW+DpD9vap2t+Tl1t+mNF6yUaAk7mKOtvHtdLaEE3rKFbUhXkjymb+jGxMHR1Zz0PxrvEDg9EcQ/ew8jbo7R7BllIKmnHPkJVJWNg+8Dp3p1f4uJQiZ+8YFj+tR8L+tJLjkNhryOKWp8gwFs9ZEqV4VFLVI07IaZou4fyqCIRSLHE02L6JNVpFk4c60GuDmxQTqVgxhNFNHulR+4g16uuuGliOMKXn1YQ+BniXWhuL7cWep1SNb4GXkD9WmuJ+mdtYaQgvSIPUgvPEXc=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:iiwMtH/6mghrSX1fF8Z7BD/oR8IIG/lhWjXDHYsQkQrYsTwdCNpHy5G+nkDxv3xdfiDVGJAP04WgwGrWKfNGKvozKRJBvODgBFiGhkwWgo7z5EQ9LwNCYDCzhvoHMlRVd6Q8jeO+Pp12BFUFKXFu1/JNiG72D3GM7OeW2OR6acewVQoAYyTL5yQ+rZeNernHd6sOQbFZhBm478TK5q/RbXt42gQmzSMQ5GaIcvcxN4A1Mlwpbm6+lKgUuvIUQkFcYUyslsH0Lm2MlpJFW1plWQrk+lzBUBL6AFlKX4bk2PkrM24+yXGmMLpudShrp7OTHoI0oQ2Ls5+J6sLpxj0jg/L943qN8RVqpukTlIV/8/VrhaxUohvUO4lqYNnYQSweazXMkxh1j9ZRaGL1cx0R6uJuwjadBgi22iCpJsAvgMOZ2aG0OXRgq1ktkUWjHMEFe6AOAr1OJZuy570tuzMQEg==;
	5:JcUJRLP6BYFvYGjWuLy4raoS0i+ko0CvZo2N25WY9oit1JqfXmtgyXEDFaI4P0kILUlgF9CHBFEBfbJI4dP7br0xro76/24ltjTUxyeMuXIuKG7sI48WVBP/IOKAIT2JlzZ1cMwc2EweWiJRHIbnbJe1JednT68ovx6cb0LrxYE=;
	7:PQmYJTv7lNgf8sOOBTYsY1tFUW/KhX0NP+DD+tWQhruvfTqL5ih7Ls7idLYTwktEz514PFKKdnd2g7+SpOlu0msGXwWlvtVixE3k5ldPcor5FncPe9KO/HSeNr3yIKlT5g6KnZOdCDf2rKCcJwBiF1O8+d1y2aVVCekd4UBLU5++X1d5TGnD+EULKg0RjT922qFB7hZ1/zHNEchGp0mGOaexjwHKGIrLwOHzBYLJGq9M8r2iMaVp/WzK8xhuF1/G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:42.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17392ec-c472-443d-827d-08d5f0b3116b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 4/9] tests/data: extract LogRecord into own file
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
X-List-Received-Date: Mon, 23 Jul 2018 16:18:11 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LogRecord is a mechanism to capture the log output. It is used in the
data tests. It is moved into its own file to be used by other tests.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/tests/data.py      | 25 +------------------
 lib/bb/tests/logrecord.py | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 24 deletions(-)
 create mode 100644 lib/bb/tests/logrecord.py

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a4a9dd30..e8121a21 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -24,30 +24,7 @@ import unittest
 import bb
 import bb.data
 import bb.parse
-import logging
-
-class LogRecord():
-    def __enter__(self):
-        logs = []
-        class LogHandler(logging.Handler):
-            def emit(self, record):
-                logs.append(record)
-        logger = logging.getLogger("BitBake")
-        handler = LogHandler()
-        self.handler = handler
-        logger.addHandler(handler)
-        return logs
-    def __exit__(self, type, value, traceback):
-        logger = logging.getLogger("BitBake")
-        logger.removeHandler(self.handler)
-        return
-
-def logContains(item, logs):
-    for l in logs:
-        m = l.getMessage()
-        if item in m:
-            return True
-    return False
+from bb.tests.logrecord import LogRecord, logContains
 
 class DataExpansions(unittest.TestCase):
     def setUp(self):
diff --git a/lib/bb/tests/logrecord.py b/lib/bb/tests/logrecord.py
new file mode 100644
index 00000000..2693e4ff
--- /dev/null
+++ b/lib/bb/tests/logrecord.py
@@ -0,0 +1,51 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Tests for the Data Store (data.py/data_smart.py)
+#
+# Copyright (C) 2010 Chris Larson
+# Copyright (C) 2012 Richard Purdie
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import logging
+
+
+class LogRecord():
+    def __enter__(self):
+        logs = []
+
+        class LogHandler(logging.Handler):
+            def emit(self, record):
+                logs.append(record)
+
+        logger = logging.getLogger("BitBake")
+        handler = LogHandler()
+        self.handler = handler
+        logger.addHandler(handler)
+        return logs
+
+    def __exit__(self, type, value, traceback):
+        logger = logging.getLogger("BitBake")
+        logger.removeHandler(self.handler)
+        return
+
+
+def logContains(item, logs):
+    for l in logs:
+        m = l.getMessage()
+        if item in m:
+            return True
+    return False
-- 
2.18.0


