Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 8EFB878332
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 10:10:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Jun 2017 03:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,340,1493708400"; d="scan'208";a="867840905"
Received: from petrova-mobl12.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.250])
	by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2017 03:10:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jun 2017 12:10:24 +0200
Message-Id: <a45168ca5a0c84830db548a8892d453f571962e2.1497434991.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497434991.git.paul.eggleton@linux.intel.com>
References: <cover.1497434991.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] cooker: fix always loading cache on every UI start with memres
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
X-List-Received-Date: Wed, 14 Jun 2017 10:10:51 -0000

The main point of memory resident bitbake is to avoid loading data
unnecessarily on every bitbake invocation. Unfortunately the code that
updated options from the UI was simply treating the fact that either
of the "prefile" or "postfile" options were in the list of options
passed in as an indication that the configuration was invalid, which was
bad because these are always passed in. We only need to mark the
configuration as invalid and thus reload it (and thus reload the cache)
if the option value has actually changed.

At the same time, the recently handled "tracking" option needs to be
treated in a similar manner since the configuration needs to be reparsed
if that has changed. Also, add a few extra debug messages to aid
debugging this code in future.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 661cd0e..6a1b649 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -415,17 +415,24 @@ class BBCooker:
         self.ui_cmdline = cmdline
         clean = True
         for o in options:
-            if o in ['prefile', 'postfile']:
-                clean = False
-                server_val = getattr(self.configuration, "%s_server" % o)
+            if o in ['prefile', 'postfile', 'tracking']:
+                server_val = getattr(self.configuration, "%s_server" % o, None)
                 if not options[o] and server_val:
                     # restore value provided on server start
+                    logger.debug(1, "Restoring server value for option '%s'" % o)
                     setattr(self.configuration, o, server_val)
+                    clean = False
+                    continue
+                if getattr(self.configuration, o) == options[o]:
+                    # Value is the same, no need to mark dirty
                     continue
+                else:
+                    logger.debug(1, "Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
+                    clean = False
             setattr(self.configuration, o, options[o])
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
-                logger.debug(1, "Updating environment variable %s to %s" % (k, environment[k]))
+                logger.debug(1, "Updating new environment variable %s to %s" % (k, environment[k]))
                 self.configuration.env[k] = environment[k]
                 clean = False
             if k in self.configuration.env and k not in environment:
@@ -435,7 +442,7 @@ class BBCooker:
             if k not in self.configuration.env and k not in environment:
                  continue
             if environment[k] != self.configuration.env[k]:
-                logger.debug(1, "Updating environment variable %s to %s" % (k, environment[k]))
+                logger.debug(1, "Updating environment variable %s from %s to %s" % (k, self.configuration.env[k], environment[k]))
                 self.configuration.env[k] = environment[k]
                 clean = False
         if not clean:
-- 
2.9.4


