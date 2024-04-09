Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B786C67861
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 17:59:03 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.143719.1712685539637147261
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Apr 2024 10:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jgQ5jaWL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4829237d63=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439Ahltr011451
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Apr 2024 10:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=3G1Ij
	q3GAvdFwKYnq+cgok/ofiwxxIJfyNpfU1EKLMw=; b=jgQ5jaWLg3mBN36sVEKg+
	stPNpJ4cmFc1rxltPmp+KZo5QAoM0q1DB5EXsyciziRgTZfC3iBKz4BGQUfXY+MK
	Ilh0YGs8yLR6rm4tLS1Rwy3j+tYTVxkIzv2XF1WrvcX26J6gEfocZoe2VSwWNthN
	l/WvsX5AjoTrqB6TVruGRCLMhZrj15QoHbMAZv8EYYEwdt4WEw7Xq+RNcUiGfwZw
	2vvUevEzOWvf1GS8Bj27fEhtIc3R0s2Bi2YLVKwR5Kdud7BIWt87KFxejWm/U9kQ
	KpSGh+zc8h/rahBLLDiITMO3AdRuzOu9zrQPb7VrrOpd4o7rY8IjBurF/C/A3E6Y
	Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xb1p0auqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Apr 2024 10:58:58 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 9 Apr 2024 10:58:58 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Tue, 9 Apr 2024 10:58:58 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] wget: Make wget --passive-ftp option conditional on ftp/ftps
Date: Tue, 9 Apr 2024 10:58:58 -0700
Message-ID: <20240409175858.877459-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1otHn4w8FOKr1nytV5SJMYcE5bukX4No
X-Proofpoint-GUID: 1otHn4w8FOKr1nytV5SJMYcE5bukX4No
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=942 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090118
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Apr 2024 17:59:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16065

Fedora 40 introduces wget2 as a drop-in replacement for wget.  This
rewrite does not currently have support for FTP.  This causes
the wget fetcher to fail complaining about an unrecognized option.

Making --passive-ftp conditional based on the protocol used in
the SRC_URI limits the scope of the problem.  It also gives us
an opportunity to build the older wget as a host tool.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/fetch2/wget.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index dc025800..fbfa6938 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -87,7 +87,10 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
-        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30"
+
+        if ud.type == 'ftp' or ud.type == 'ftps':
+            self.basecmd += " --passive-ftp"
 
         if not self.check_certs(d):
             self.basecmd += " --no-check-certificate"
-- 
2.43.0


