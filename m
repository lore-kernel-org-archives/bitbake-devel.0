Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 3F403719B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 03:42:35 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 08 Feb 2017 19:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,349,1484035200"; d="scan'208";a="223091769"
Received: from ystew-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.191.171])
	by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2017 19:42:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Feb 2017 16:42:29 +1300
Message-Id: <9f8cd57cf888ec1c29a07a25517af38ae88e5fc6.1486611730.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486611730.git.paul.eggleton@linux.intel.com>
References: <cover.1486611730.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] tinfoil: ensure PATH includes bitbake's bin directory
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
X-List-Received-Date: Thu, 09 Feb 2017 03:42:35 -0000

The runqueue expects to be able to run 'bitbake-worker' from PATH, but
for example in the OE extensible SDK, tinfoil is used within devtool
where this isn't the case (we're not exposing bitbake to the user, thus
bitbake's bin directory isn't in PATH).

This fixes devtool modify usage within the extensible SDK which has
apparently been broken since the tinfoil2 changes went in.

Fixes [YOCTO #11034].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 96275fd..940f9ab 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -211,6 +211,19 @@ class Tinfoil:
 
         self.ui_module = ui_module
 
+        # Ensure the path to bitbake's bin directory is in PATH so that things like
+        # bitbake-worker can be run (usually this is the case, but it doesn't have to be)
+        path = os.getenv('PATH').split(':')
+        bitbakebinpath = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'bin'))
+        for entry in path:
+            if entry.endswith(os.sep):
+                entry = entry[:-1]
+            if os.path.abspath(entry) == bitbakebinpath:
+                break
+        else:
+            path.insert(0, bitbakebinpath)
+            os.environ['PATH'] = ':'.join(path)
+
         if self.server_connection:
             _server_connections.append(self.server_connection)
             if config_only:
-- 
2.9.3


