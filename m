Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43010F92E5
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24321.1774973227594561804
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bFkAnjAg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8O2249206;
	Tue, 31 Mar 2026 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=EaoQbH8jwIIc8mFuxq6dKlxV0DBiM2EMZfO+VeWtnog=; b=
	bFkAnjAgKAFg91NUQp2wimlRBEhzDnofoTQPw/LU4sQgSqBkjl0S2bzWIoUU0FrN
	vtfcNRuUFdVxZcGPE+6cBQQfzKUBw7D9N5cMqSljOt13+BMuPQohAl4k32cxKzKx
	2wRT0wrc8qDkAB1xp/U8GfXFxF5OyQ0AFl+i/7yBO6VDwSrCjMieWEmgD0XfPXMq
	AFuCJ4VEWuHnu10NtP61ynZ6DadA+iCtuugZUwNSpG/OcBSxNMfRmFwzOppo/r17
	o8n7xHZvonUjKlsxjA7x32RkLTmKjynXiye2as5slEvq+JEnaY2TGKGbapn5EoF3
	L23Ujue/P6o1qEN6glmilQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:06 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:04 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:04 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 07/13] bitbake-setup: Add version check and catch exceptions
Date: Tue, 31 Mar 2026 09:06:57 -0700
Message-ID: <20260331160703.3137930-8-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf12a cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=JdKmuWCP-GRYc3YyTgcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Z6fub_4GSKFRz0XymUHajYlNk0jXXpJq
X-Proofpoint-GUID: Z6fub_4GSKFRz0XymUHajYlNk0jXXpJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX6RSCKtKZTiuM
 0bk15+ccUpuZ9K3lLkR+/+MwHLwROwoeMqemtwsLvJH/Xu5NlX2XWNU/oukvNbdscqFbKFdwgVD
 07+9XPRZ8+ioxxvJfZBCvpssQq6C0c9o/xjr4sh8ZaFfgl1C8DZouD03f2EJ2cirtvxN2Mh3vHF
 2pOc4WaKHsNOt/zoNdjpTesrQnFxg0mQd8Ay4Zpb0uEoyCb5LKS1Ja6ipk/DOg35pNXa/ODDRll
 R6YETY1scO+EG1k9RxRyefDtmUO0BJ7lOiqmB/3bS8ujR7fmxQ9uZ4Cl8a32U8MeBqtzZsR3n2m
 Cc/UB9bCqX3TPb+XsIsekKCdFpSxQifm+75IqklLpfeRMVclbBmCYXgmzYh0i/cju9FKUojOxhD
 43HNN5g45M924q59uj8WN+UODtugfdbjogp0bF5aUcAOPfnZsSX+PiiHKfKvMEuAwE75Nik1fNA
 ekT9uMLAMddcJaM7MaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19303

This modifies the conditional script stanza to match bitbake.

It adds a version check to ensure that the correct bb module
version has been found.  It also catches any exceptions thrown
during execution.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index be420adb6..939645121 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1404,4 +1404,11 @@ def main():
         parser.print_help()
 
 if __name__ == '__main__':
-    main()
+    if __version__ != bb.__version__:
+        sys.exit("Bitbake core version and program version mismatch!")
+    try:
+        sys.exit(main())
+    except Exception:
+        import traceback
+        traceback.print_exc()
+        sys.exit(1)
-- 
2.49.0


