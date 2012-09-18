Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TDnTs-0007Ul-JM
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 04:24:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8I2BS79029469
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 19:11:28 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 19:11:27 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 21:11:24 -0500
Message-ID: <2b14209d1f740515c69d2534e3f7bf70950592ad.1347933709.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1347933709.git.peter.seebach@windriver.com>
References: <cover.1347933709.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] data_smart.py and friends: Track file inclusions for bitbake -e
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
X-List-Received-Date: Tue, 18 Sep 2012 02:24:09 -0000
Content-Type: text/plain

This code adds inclusion history to bitbake -e output, showing
which files were included, in what order. This doesn't completely
resolve timing questions, because it doesn't show you which lines
of a file were processed before or after a given include, but it
does let you figure out what the path was by which a particular
file ended up in your build at all.

How it works: data_smart acquires a .history member, which is an
IncludeHistory; this represents the inclusion of a file and all its
inclusions, recursively. It provides methods for including files,
for finishing inclusion (done as an __exit__), and for
dumping the whole tree.

The parser is modified to run includes inside a with() to push
and pop the include filename.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/cooker.py         |    5 +++++
 lib/bb/data_smart.py     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/parse/__init__.py |    3 ++-
 3 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 237019c..4642753 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -332,6 +332,11 @@ class BBCooker:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
+        # Display history
+        with closing(StringIO()) as env:
+            self.configuration.data.history.emit(env)
+            logger.plain(env.getvalue())
+
         # emit variables and shell functions
         data.update_data(envdata)
         with closing(StringIO()) as env:
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index f5f3b13..7cb53d8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -111,6 +111,48 @@ class ExpansionError(Exception):
     def __str__(self):
         return self.msg
 
+class IncludeHistory(object):
+    def __init__(self, parent = None, filename = None):
+        self.parent = parent
+        if parent:
+            self.top = parent.top
+        else:
+            self.top = self
+        self.filename = filename or '[TOP LEVEL]'
+        self.children = []
+        self.current = self
+
+    def include(self, filename):
+        newfile = IncludeHistory(self.current, filename)
+        self.current.children.append(newfile)
+        self.current = newfile
+        return self
+
+    def __enter__(self):
+        pass
+
+    def __exit__(self, a, b, c):
+        if self.current.parent:
+            self.current = self.current.parent
+        else:
+            bb.warn("Include log: Tried to finish '%s' at top level." % filename)
+        return False
+
+    def emit(self, o, level = 0):
+        """Emit an include history file, and its children."""
+        if self != self.top:
+            spaces = "  " * level
+            o.write("# %s%s" % (spaces, self.filename))
+            if len(self.children) > 0:
+                o.write(" includes:")
+            o.write("\n")
+            level = level + 1
+        else:
+            o.write("#\n# INCLUDE HISTORY:\n#\n")
+        for child in self.children:
+            child.emit(o, level)
+
+
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
@@ -118,6 +160,7 @@ class DataSmart(MutableMapping):
         # cookie monster tribute
         self._special_values = special
         self._seen_overrides = seen
+        self.history = IncludeHistory()
 
         self.expand_cache = {}
 
@@ -411,6 +454,7 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.history = copy.deepcopy(self.history)
 
         return data
 
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 7b9c47e..b24673b 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -88,7 +88,8 @@ def handle(fn, data, include = 0):
     """Call the handler that is appropriate for this file"""
     for h in handlers:
         if h['supports'](fn, data):
-            return h['handle'](fn, data, include)
+            with data.history.include(fn):
+                return h['handle'](fn, data, include)
     raise ParseError("not a BitBake file", fn)
 
 def init(fn, data):
-- 
1.7.0.4



