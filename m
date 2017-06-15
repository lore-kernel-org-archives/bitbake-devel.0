Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 62ECA783D5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 14:33:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Jun 2017 07:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,343,1493708400"; d="scan'208";a="99855406"
Received: from hadjizad-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.63.65])
	by orsmga002.jf.intel.com with ESMTP; 15 Jun 2017 07:33:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Jun 2017 16:33:28 +0200
Message-Id: <33da83a80a9196bc6a347745a237d5a82f436a22.1497537169.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497537169.git.paul.eggleton@linux.intel.com>
References: <cover.1497537169.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] event: drop some unused events
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
X-List-Received-Date: Thu, 15 Jun 2017 14:33:51 -0000

These were all used by support code for the Hob UI which has been
removed - nothing will currently fire or respond to these events.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/event.py | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 6d8493b..eb5cd04 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -616,14 +616,6 @@ class FilesMatchingFound(Event):
         self._pattern = pattern
         self._matches = matches
 
-class CoreBaseFilesFound(Event):
-    """
-    Event when a list of appropriate config files has been generated
-    """
-    def __init__(self, paths):
-        Event.__init__(self)
-        self._paths = paths
-
 class ConfigFilesFound(Event):
     """
     Event when a list of appropriate config files has been generated
@@ -694,19 +686,6 @@ class LogHandler(logging.Handler):
         record.taskpid = worker_pid
         return True
 
-class RequestPackageInfo(Event):
-    """
-    Event to request package information
-    """
-
-class PackageInfo(Event):
-    """
-    Package information for GUI
-    """
-    def __init__(self, pkginfolist):
-        Event.__init__(self)
-        self._pkginfolist = pkginfolist
-
 class MetadataEvent(Event):
     """
     Generic event that target for OE-Core classes
-- 
2.9.4


