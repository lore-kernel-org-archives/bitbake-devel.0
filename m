Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 703396FFA1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 04:22:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 20:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,559,1455004800"; d="scan'208";a="905624170"
Received: from mlim-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.143.14])
	by orsmga001.jf.intel.com with ESMTP; 08 Mar 2016 20:22:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 17:22:14 +1300
Message-Id: <86e520994b017a2e8e77184fddd10d7c58071c86.1457497288.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] fetch2/npm: add missing URL argument to ParameterError
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
X-List-Received-Date: Wed, 09 Mar 2016 04:22:58 -0000

Without this you get a rather odd traceback instead of the proper
exception message.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 3ff11e9..d44454c 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -75,10 +75,10 @@ class Npm(FetchMethod):
         # TODO: find a way to get an sha1/sha256 manifest of pkg & all deps
         ud.pkgname = ud.parm.get("name", None)
         if not ud.pkgname:
-            raise ParameterError("NPM fetcher requires a name parameter")
+            raise ParameterError("NPM fetcher requires a name parameter", ud.url)
         ud.version = ud.parm.get("version", None)
         if not ud.version:
-            raise ParameterError("NPM fetcher requires a version parameter")
+            raise ParameterError("NPM fetcher requires a version parameter", ud.url)
         ud.bbnpmmanifest = "%s-%s.deps.json" % (ud.pkgname, ud.version)
         ud.registry = "http://%s" % ud.basename
         prefixdir = "npm/%s" % ud.pkgname
-- 
2.5.0


