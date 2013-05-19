Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ue0yf-00082B-UD for bitbake-devel@lists.openembedded.org;
	Sun, 19 May 2013 12:36:49 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4JALKmv032412; Sun, 19 May 2013 11:21:29 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eTPfM1POnMpD; Sun, 19 May 2013 11:21:29 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4JALQAQ032421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sun, 19 May 2013 11:21:28 +0100
Message-ID: <1368958678.32727.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 19 May 2013 13:17:58 +0300
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: "Hart, Darren" <darren.hart@intel.com>
Subject: [PATCH] fetch2/git: Clean up sortable_revision
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
X-List-Received-Date: Sun, 19 May 2013 10:36:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Now we no longer try and provide increasing values from the fetcher,
we can simplify the function structure for the sortable_revision
pieces and move the AUTOINC handling directly into the function
which needs it, simplifying the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index dd1cc93..f8f8244 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -616,7 +616,10 @@ def get_srcrev(d):
         raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
 
     if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
-        return urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
+        autoinc, rev = urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
+        if autoinc:
+            return "AUTOINC+" + rev
+        return rev
 
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
@@ -625,18 +628,14 @@ def get_srcrev(d):
     if not format:
         raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
 
-    autoinc = False
-    autoinc_templ = 'AUTOINC+'
+    seenautoinc = False
     for scm in scms:
         ud = urldata[scm]
         for name in ud.names:
-            rev = ud.method.sortable_revision(scm, ud, d, name)
-            if rev.startswith(autoinc_templ):
-                if not autoinc:
-                    autoinc = True
-                    format = "%s%s" % (autoinc_templ, format)
-                rev = rev[len(autoinc_templ):]
-
+            autoinc, rev = ud.method.sortable_revision(scm, ud, d, name)
+            if autoinc and not seenautoinc:
+                rev = "AUTOINC+" + rev
+                seenautoinc
             format = format.replace(name, rev)
 
     return format
@@ -1280,14 +1279,8 @@ class FetchMethod(object):
             return rev
 
     def sortable_revision(self, url, ud, d, name):
-        """
-
-        """
-        if hasattr(self, "_sortable_revision"):
-            return self._sortable_revision(url, ud, d)
-
         latest_rev = self._build_revision(url, ud, d, name)
-        return 'AUTOINC+%s' % str(latest_rev)
+        return True, str(latest_rev)
 
     def generate_revision_key(self, url, ud, d, name):
         key = self._revision_key(url, ud, d, name)
diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 58e80c8..5d9e5f9 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -132,12 +132,12 @@ class Bzr(FetchMethod):
 
         return output.strip()
 
-    def _sortable_revision(self, url, ud, d):
+    def sortable_revision(self, url, ud, d, name):
         """
         Return a sortable revision number which in our case is the revision number
         """
 
-        return self._build_revision(url, ud, d)
+        return False, self._build_revision(url, ud, d)
 
     def _build_revision(self, url, ud, d):
         return ud.revision
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index cbf929e..9a779d2 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -178,12 +178,12 @@ class Svn(FetchMethod):
 
         return revision
 
-    def _sortable_revision(self, url, ud, d):
+    def sortable_revision(self, url, ud, d, name):
         """
         Return a sortable revision number which in our case is the revision number
         """
 
-        return self._build_revision(url, ud, d)
+        return False, self._build_revision(url, ud, d)
 
     def _build_revision(self, url, ud, d):
         return ud.revision




