Received: from masterfoo.zenlinux.com ([207.192.74.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1QV52Q-0000Kq-2M
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jun 2011 18:58:26 +0200
Received: from localhost.localdomain (c-76-115-40-57.hsd1.or.comcast.net
	[76.115.40.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by masterfoo.zenlinux.com (Postfix) with ESMTP id CD5052FF37;
	Fri, 10 Jun 2011 12:54:55 -0400 (EDT)
From: Scott Garman <scott.a.garman@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2011 09:54:45 -0700
Message-Id: <1307724885-8950-1-git-send-email-scott.a.garman@intel.com>
X-Mailer: git-send-email 1.7.1
X-MasterFoo-MailScanner-Information: Please contact the ISP for more
	information
X-MailScanner-ID: CD5052FF37.A780C
X-MasterFoo-MailScanner: Found to be clean
X-MasterFoo-MailScanner-SpamCheck: not spam
X-MasterFoo-MailScanner-From: scott.a.garman@intel.com
X-Spam-Status: No
Cc: Scott Garman <scott.a.garman@intel.com>
Subject: [PATCH] cooker.py: fix bitbake -b
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 10 Jun 2011 16:58:26 -0000

This avoids a null reference when bitbake -b is invoked, fixing
the following error:

AttributeError: 'NoneType' object has no attribute 'bbfile_config_priorities'

Signed-off-by: Scott Garman <scott.a.garman@intel.com>
---
 lib/bb/cooker.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c23e3d4..cc5d939 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -990,8 +990,9 @@ class BBCooker:
         files = (data.getVar( "BBFILES", self.configuration.data, 1 ) or "").split()
         data.setVar("BBFILES", " ".join(files), self.configuration.data)
 
-        # Sort files by priority
-        files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem) )
+        if self.status:
+            # Sort files by priority
+            files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem) )
 
         if not len(files):
             files = self.get_bbfiles()
-- 
1.7.1



