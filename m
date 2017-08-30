Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C2BDF78369
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:22 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995037"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:43 +1200
Message-Id: <c5de0f9cee5876e78c34057ad2376f049f53c621.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504135776.git.paul.eggleton@linux.intel.com>
References: <cover.1504135776.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/5] tinfoil: fix log message doubling when config_only=False
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:23 -0000

With config_only=False we launch the UI and it sets up a logger, whereas
when config_only=True we don't, with the result that with True we are
seeing log messages from both our logger and the one set up by the UI.
Suppress our loggers with config_only=True to avoid this.

Fixes [YOCTO #11275] (again).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index cd0587e..fd17edc 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -325,7 +325,12 @@ class Tinfoil:
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
+            oldhandlers = self.logger.handlers[:]
             bb.msg.logger_create('BitBake', output)
+            self.localhandlers = []
+            for handler in self.logger.handlers:
+                if handler not in oldhandlers:
+                    self.localhandlers.append(handler)
 
     def __enter__(self):
         return self
@@ -381,6 +386,12 @@ class Tinfoil:
         cookerconfig = CookerConfiguration()
         cookerconfig.setConfigParameters(config_params)
 
+        if not config_only:
+            # Disable local loggers because the UI module is going to set up its own
+            for handler in self.localhandlers:
+                self.logger.handlers.remove(handler)
+            self.localhandlers = []
+
         self.server_connection, ui_module = setup_bitbake(config_params,
                             cookerconfig,
                             extrafeatures)
-- 
2.9.5


