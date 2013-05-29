Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C0D8662051
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:55:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3t637001317
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:55:06 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:55:05 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 23:01:18 -0500
Message-ID: <1369800078-1613-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] lib/bb/cache.py: Change debugging note to a debug message
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 03:55:04 -0000
Content-Type: text/plain

Some apparently debugging was left in in a previous commit.  This caused
bitbake to return a list of bbappends when things changed from the cache.

Make this a proper debug message.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index c92ba35..9e89742 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -526,7 +526,7 @@ class Cache(object):
 
         if appends != info_array[0].appends:
             logger.debug(2, "Cache: appends for %s changed", fn)
-            bb.note("%s to %s" % (str(appends), str(info_array[0].appends)))
+            logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
             self.remove(fn)
             return False
 
-- 
1.8.1.2.545.g2f19ada


