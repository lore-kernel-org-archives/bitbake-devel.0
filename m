Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwAcx-0002Gf-6J for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:00:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBjUVQ008496;
	Fri, 18 Jan 2013 11:45:30 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05490-01; Fri, 18 Jan 2013 11:45:25 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBjMIi008489
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 11:45:24 GMT
Message-ID: <1358509522.27799.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Jan 2013 11:45:22 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: data_smart.py and friends: Track file inclusions for bitbake -e
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
X-List-Received-Date: Fri, 18 Jan 2013 12:02:02 -0000
X-List-Received-Date: Fri, 18 Jan 2013 12:02:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From: Peter Seebach <peter.seebach@windriver.com>

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

RP Modifications:

a) Split Include and Variable tracking
b) Replace deepcopy usage with dedicated copy function
c) Simplify some variable and usage

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1d38164..f06b71c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -338,6 +338,11 @@ class BBCooker:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
+        # Display history
+        with closing(StringIO()) as env:
+            self.configuration.data.inchistory.emit(env)
+            logger.plain(env.getvalue())
+
         # emit variables and shell functions
         data.update_data(envdata)
         with closing(StringIO()) as env:
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index d328400..5fdfeee 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -114,10 +114,55 @@ class ExpansionError(Exception):
     def __str__(self):
         return self.msg
 
+class IncludeHistory(object):
+    def __init__(self, parent = None, filename = '[TOP LEVEL]'):
+        self.parent = parent
+        self.filename = filename
+        self.children = []
+        self.current = self
+
+    def copy(self):
+        new = IncludeHistory(self.parent, self.filename)
+        for c in self.children:
+            new.children.append(c)
+        return new
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
+        if level:
+            spaces = "  " * (level - 1)
+            o.write("# %s%s" % (spaces, self.filename))
+            if len(self.children) > 0:
+                o.write(" includes:")
+        else:
+            o.write("#\n# INCLUDE HISTORY:\n#")
+        level = level + 1
+        for child in self.children:
+            o.write("\n")
+            child.emit(o, level)
+
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
 
+        self.inchistory = IncludeHistory()
+
         # cookie monster tribute
         self._special_values = special
         self._seen_overrides = seen
@@ -416,6 +461,7 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.inchistory = self.inchistory.copy()
 
         return data
 
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 4293d09c..3f93ad2 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -87,7 +87,8 @@ def handle(fn, data, include = 0):
     """Call the handler that is appropriate for this file"""
     for h in handlers:
         if h['supports'](fn, data):
-            return h['handle'](fn, data, include)
+            with data.inchistory.include(fn):
+                return h['handle'](fn, data, include)
     raise ParseError("not a BitBake file", fn)
 
 def init(fn, data):




