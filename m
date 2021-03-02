Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.156.75])
 by mx.groups.io with SMTP id smtpd.web11.1357.1614721933374029203
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Mar 2021 13:52:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ni.com header.s=pps11062020 header.b=ovBQsUp0;
 spf=pass (domain: ni.com, ip: 148.163.156.75, mailfrom: prvs=869528ad88=chaitanya.vadrevu@ni.com)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
	by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122LnKq3024715
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Mar 2021 15:52:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=PPS11062020;
 bh=s2b8netGoY2t6uuy5YcbwblhxQDaXc/s+z6GqYee/GU=;
 b=ovBQsUp0yjGgWFD7aG+/vR32XQUryNmWBq3Yh+aOuiOXsYaD7oyF5T+DnSR4MZUgIaCV
 yLm0nC7hGvumtvmTc64cyaEmlqjQCCJydxJCd+aJhFj92sIVT7RltCu4cptkXVdx28d8
 IoZFdR1RkbtJeh3+hC+qZuhIoRrr7M0gjCKYcuH/9eM4PkdFjo5ict4FdlCJ/Cf8GZa+
 kTHYVQxacDfrBgHy20oJe6m9VgQoVPVlEAkgcGTH7tycwgsm/fvA5z+GYaQEoDkygV1U
 s8oQpaSHLZ3lHtpJKTHP9mH2On2TlkiLJX+OmfJprxbWDDWf3JrEbuweYTDn8H/uCB4M TA== 
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mx0a-00010702.pphosted.com with ESMTP id 36ymfx6671-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 02 Mar 2021 15:52:12 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
	by us-aus-skprod3.natinst.com (8.16.0.43/8.16.0.43) with ESMTPS id 122LqBEl018445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Mar 2021 15:52:11 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 2 Mar 2021 15:52:11 -0600
Received: from cvadrevu-linux.natinst.com (172.18.68.32) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Tue, 2 Mar 2021 15:52:11 -0600
From: "Chaitanya Vadrevu" <chaitanya.vadrevu@ni.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>
Subject: [PATCH] process.py: Increase bitbake timeout and add logs
Date: Tue, 2 Mar 2021 15:51:34 -0600
Message-ID: <20210302215134.11881-1-chaitanya.vadrevu@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Content-Type: text/plain

We have started seeing "Unable to connect to bitbake server ..." errors on
our build farm consistently with 60s timeout. Increasing the timeout to
300s and logging every 10s.

Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>
---
 lib/bb/server/process.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b27b4aef..d5571c36 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -390,12 +390,19 @@ class ServerCommunicator():
         self.connection = connection
         self.recv = recv
 
+        self.reply_wait = 10
+        self.max_reply_wait = 300
+
     def runCommand(self, command):
         self.connection.send(command)
-        if not self.recv.poll(30):
-            logger.info("No reply from server in 30s")
-            if not self.recv.poll(30):
-                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
+        total_reply_wait = self.reply_wait
+
+        while not self.recv.poll(self.reply_wait):
+            logger.info("No reply from server in %ds" % total_reply_wait)
+            total_reply_wait += self.reply_wait
+            if total_reply_wait > self.max_reply_wait:
+                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (%ds)" % (total_reply_wait - self.reply_wait))
+
         ret, exc = self.recv.get()
         # Should probably turn all exceptions in exc back into exceptions?
         # For now, at least handle BBHandledException
-- 
2.17.1

