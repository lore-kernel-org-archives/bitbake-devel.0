Return-Path: <prvs=8806058be4=adrian.ratiu@ni.com>
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com
	[148.163.156.75])
	by mail.openembedded.org (Postfix) with ESMTP id 48DDF7307F;
	Tue, 25 Sep 2018 12:32:30 +0000 (UTC)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
	by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8PCVFWA008939; Tue, 25 Sep 2018 07:32:30 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mx0a-00010702.pphosted.com with ESMTP id 2mnmeggwqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 25 Sep 2018 07:32:30 -0500
Received: from us-aus-exch2.ni.corp.natinst.com
	(us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
	by us-aus-skprod3.natinst.com (8.16.0.22/8.16.0.22) with ESMTPS id
	w8PCWSne007659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 25 Sep 2018 07:32:28 -0500
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
	us-aus-exch2.ni.corp.natinst.com (130.164.68.12) with Microsoft SMTP
	Server (TLS) id 15.0.1395.4; Tue, 25 Sep 2018 07:32:28 -0500
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
	us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP
	Server (TLS) id 15.0.1395.4; Tue, 25 Sep 2018 07:32:28 -0500
Received: from ionel-work.natinst.com (130.164.49.7) by
	us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP
	Server
	id 15.0.1395.4 via Frontend Transport; Tue, 25 Sep 2018 07:32:27 -0500
From: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
To: <bitbake-devel@lists.openembedded.org>,
	<openembedded-core@lists.openembedded.org>
Date: Tue, 25 Sep 2018 15:34:19 +0300
Message-ID: <20180925123419.8176-1-adrian.ratiu@ni.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2018-09-25_07:, , signatures=0
X-Proofpoint-Spam-Reason: safe
Subject: [OE-core][PATCH] utils: lockfile: Fix infinite loop
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
X-List-Received-Date: Tue, 25 Sep 2018 12:32:30 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A nasty corner case leads to a hang when utils.lockfile is called from
oe-core's package-manager:deploy_dir_lock (in turn called from
rootfs:_create further up the call stack) with "name" owned by root
and the user running bitbake has no write access.

Because this code runs under pseudo, the UID and EUID of the bitbake
worker process are 0, so the os.access(dirname, os.W_OK) returns True
i.e. it thinks the path is writable when in fact it's not writable.

Only later when trying to open the file an Exception it thrown because
the OS prohibits writing, but the Exception is ignored and the open is
retried leading to an infinite loop.

So this fix is to not ignore the "Permission Denied" exception.

An alternative fix would be to replace the os.access() call with an
try: open() except() at the beginning of the function.

Signed-off-by: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
---
 lib/bb/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 56894f13..73b6cb42 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -497,7 +497,11 @@ def lockfile(name, shared=False, retry=True, block=False):
                 if statinfo.st_ino == statinfo2.st_ino:
                     return lf
             lf.close()
-        except Exception:
+        except OSError as e:
+            if e.errno == errno.EACCES:
+                logger.error("Unable to acquire lock '%s', %s",
+                             e.strerror, name)
+                sys.exit(1)
             try:
                 lf.close()
             except Exception:
-- 
2.19.0


