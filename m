Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422DC46CD3
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 21:01:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.131932.1703797282149803395
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 13:01:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=X07mZxIH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1726e0f95c=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BSL12pq014294;
	Thu, 28 Dec 2023 21:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=6euSS
	4X+gsB0wbYjbYedHYEOTbDPSPsfYOy2/HgrYUE=; b=X07mZxIH3F30x0/ZJU8wx
	u0VrdScjD0pysyvsl13ymn2wI/IzkhLz85i4/EHN1Ft+bznNJVC/B9bTkm/ySIKZ
	ac80JogbQjrvCYLzO/F8HnZMOaAPEWf+wEGA8B5xMKz6tUJJdzI9bF5lLDS1p+L/
	ZUox7jygQ6yDflNLxAG4FL6nLSp3zLRKcGOzrWBczWSudBI/Ms0d9XVlOMtD5T67
	+gliFDtKXex0mVz+FFi+Gg6BWdNicbmDnuwb/O5QwIc14guUjyE9R5aPqSAQrYfN
	qMAottJpkO7sj8b+pIhxD10jrvXkD+A3+1/VCAKb1nGQVTacRZHBg2dQdnI5+zYp
	w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxvpan-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 Dec 2023 21:01:20 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:01:23 -0800
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 13:01:23 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <mark.asselstine@windriver.com>, <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>
Subject: [PATCH 1/2] server/process: catch and expand multiprocessing connection exceptions
Date: Thu, 28 Dec 2023 16:01:17 -0500
Message-ID: <20231228210118.9273-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _hKLaHdIImFUumLNakT98Y1q-ipKKzfd
X-Proofpoint-GUID: _hKLaHdIImFUumLNakT98Y1q-ipKKzfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=915
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280167
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 21:01:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15713

Doing builds on systems with limited resources, or with high demand
package builds such as chromium it isn't uncommon for the OOM Killer
to be triggered and for bitbake-server to be selected as the process
to be killed. When the bitbake-server does terminate unexpectedly due
to the OOM Killer or otherwise, this currently results in a generic
python traceback with little indication as to what has failed.

Here we trap and raise the exceptions while extending the exception
text in runCommand() to make it clear that this is most likely caused
by the bitbake-server unexpectedly terminating.

Callers of runCommand() should be updated to properly handle the
BrokenPipeError and EOFError exceptions to avoid printing a python
traceback, but even if they don't, the added text in the exceptions
should provide some hints as to what might have caused the failure.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/server/process.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index d495ac62..6d77ce47 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -500,12 +500,18 @@ class ServerCommunicator():
         self.recv = recv
 
     def runCommand(self, command):
-        self.connection.send(command)
+        try:
+            self.connection.send(command)
+        except BrokenPipeError as e:
+            raise BrokenPipeError("bitbake-server might have died or been forcibly stopped, ie. OOM killed") from e
         if not self.recv.poll(30):
             logger.info("No reply from server in 30s (for command %s at %s)" % (command[0], currenttime()))
             if not self.recv.poll(30):
                 raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s at %s)" % currenttime())
-        ret, exc = self.recv.get()
+        try:
+            ret, exc = self.recv.get()
+        except EOFError as e:
+            raise EOFError("bitbake-server might have died or been forcibly stopped, ie. OOM killed") from e
         # Should probably turn all exceptions in exc back into exceptions?
         # For now, at least handle BBHandledException
         if exc and ("BBHandledException" in exc or "SystemExit" in exc):
-- 
2.30.2


