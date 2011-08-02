Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoK81-0002Ie-To
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 20:55:46 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Aug 2011 11:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="37170044"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2011 11:51:22 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 11:51:15 -0700
Message-Id: <c0eae7f981350e4796ba22a04c6735bcd4c700ab.1312310554.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312310554.git.josh@linux.intel.com>
References: <cover.1312310554.git.josh@linux.intel.com>
In-Reply-To: <cover.1312310554.git.josh@linux.intel.com>
References: <cover.1312310554.git.josh@linux.intel.com>
Subject: [PATCH 1/2] bb/parse: track parsed configuration files in __BB_PARSED_CONF
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
X-List-Received-Date: Tue, 02 Aug 2011 18:55:46 -0000

Keep a list of each configuration (.conf) file which is handled by the
ConfHandler in the internal __BB_PARSED_CONF variable.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/parse/__init__.py             |   12 +++++++++++-
 lib/bb/parse/parse_py/ConfHandler.py |    2 ++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index eee8d9c..afe7681 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -59,13 +59,23 @@ def update_mtime(f):
     __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
     return __mtime_cache[f]
 
-def mark_dependency(d, f):
+def full_path(f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
+    return f
+
+def mark_dependency(d, f):
+    full_path(f)
     deps = bb.data.getVar('__depends', d) or set()
     deps.update([(f, cached_mtime(f))])
     bb.data.setVar('__depends', deps, d)
 
+def track_conf(d, f):
+    full_path(f)
+    conf = bb.data.getVar('__BB_PARSED_CONF', d) or []
+    conf.append(f)
+    bb.data.setVar('__BB_PARSED_CONF', conf, d)
+
 def supports(fn, data):
     """Returns true if we have a handler for this file, false otherwise"""
     for h in handlers:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 102c0e9..953ef87 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -85,6 +85,8 @@ def handle(fn, data, include):
     if include:
         bb.parse.mark_dependency(data, abs_fn)
 
+    bb.parse.track_conf(data, abs_fn)
+
     statements = ast.StatementGroup()
     lineno = 0
     while True:
-- 
1.7.6



