Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 56B7E6BA7C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2013 02:21:08 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r7S2L8IW024163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 19:21:08 -0700 (PDT)
Received: from splat.wrs.com (128.224.60.28) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.342.3;
	Tue, 27 Aug 2013 19:21:08 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Aug 2013 21:20:55 -0500
Message-ID: <1377656455-5850-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH] serv.py: Fix regression from 972bc43e6d5b
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
X-List-Received-Date: Wed, 28 Aug 2013 02:21:09 -0000
Content-Type: text/plain

commit 972bc43e6d5b1207b944b3baa8f9805adb35dda7 (serv.py: Fix hang
when spawned dynamically with bitbake) introduced a regression,
because the wrong patch was submitted.  The syntax was incorrect in
the original patch.  The logger iterator must be used with a call to
getLogger().

[YOCTO #5059]

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/prserv/serv.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 781f054..6d0c718 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -146,7 +146,7 @@ class PRServer(SimpleXMLRPCServer):
         # Clear out all log handlers prior to the fork() to avoid calling
         # event handlers not part of the PRserver
         for logger_iter in logging.Logger.manager.loggerDict.keys():
-            logger_iter.handlers = []
+            logging.getLogger(logger_iter).handlers = []
 
         # Ensure logging makes it to the logfile
         streamhandler = logging.StreamHandler()
-- 
1.7.9.5


