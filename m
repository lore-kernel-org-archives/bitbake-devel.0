Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.55.1616596422209368700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Mar 2021 07:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: vwXcX21wOMCl1K7WTaVodd6Z3xc+p69oGlwWaEJ1zidwBn6yKQNNvaQGOo12HGjgYFyyeEMQaN
 DGE4alCw14VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190132813"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190132813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:45 -0700
IronPort-SDR: aV+B96B0gr7YXqeSfqICojuwPWj0dusUSLhq62vZ1pDqiAYdiYfv3m7rdfS8PfCFkBRKAUXCTJ
 6IXpLp7t1q0g==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514213839"
Received: from alianabi-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.167.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:44 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 3/3] Force parser shutdown after catching an exception
Date: Wed, 24 Mar 2021 22:33:07 +0800
Message-Id: <767d5d6f92ef9a6939610087cf8064583870b7e1.1616596112.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616596112.git.anuj.mittal@intel.com>
References: <cover.1616596112.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Brzezanski <jan.brzezanski@gmail.com>

Commit bebef58b21bdff7a3ee1fa2449b7df19144f26fd introduced forcing
parser shutdown as default in case of build abort.

In this case bitbake sometimes hangs after facing error during parsing,
waiting for child processes to finish. Killing it then will spawn zombie
processes.

Thus we force the shutdown after catching an exception.

Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 915330e1dbae1ee8fd9a0358decf2c294f771961)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f4cc1e96..7ed0b802c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2207,18 +2207,18 @@ class CookerParser(object):
         except bb.BBHandledException as exc:
             self.error += 1
             logger.error('Failed to parse recipe: %s' % exc.recipe)
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except ParsingFailure as exc:
             self.error += 1
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
@@ -2227,7 +2227,7 @@ class CookerParser(object):
             tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
             logger.error('ExpansionError during parsing %s', value.recipe,
                          exc_info=(etype, value, tb))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except Exception as exc:
             self.error += 1
@@ -2239,7 +2239,7 @@ class CookerParser(object):
                 # Most likely, an exception occurred during raising an exception
                 import traceback
                 logger.error('Exception during parse: %s' % traceback.format_exc())
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
 
         self.current += 1
-- 
2.30.2

