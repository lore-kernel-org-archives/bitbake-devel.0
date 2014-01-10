Return-Path: <pb@pbcl.net>
Received: from hetzner.pbcl.net (mail.pbcl.net [88.198.119.4])
	by mail.openembedded.org (Postfix) with ESMTP id 6DC2D6028A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jan 2014 16:28:47 +0000 (UTC)
Received: from cpc6-cmbg17-2-0-cust487.5-4.cable.virginm.net ([86.30.57.232]
	helo=[172.30.1.45])
	by hetzner.pbcl.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80) (envelope-from <pb@pbcl.net>) id 1W1ewu-00079u-C0
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jan 2014 17:28:47 +0100
Message-ID: <1389371323.9182.169.camel@phil-desktop.brightsign>
From: Phil Blundell <pb@pbcl.net>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jan 2014 16:28:43 +0000
X-Mailer: Evolution 3.8.5-2+b1 
Mime-Version: 1.0
X-Spam_score: -1.0
X-Spam_score_int: -9
X-Spam_bar: -
X-Spam_report: Spam detection software,
	running on the system "hetzner.pbcl.net", has
	identified this incoming email as possible spam. The original message
	has been attached to this so you can view it (if it isn't spam) or
	label similar future email.  If you have any questions, see
	@@CONTACT_ADDRESS@@ for details.
	Content preview: This means that it now understands "standard" URI
	syntax as
	well as the slightly odd legacy bitbake variant. There are other places
	in bitbake (e.g. Local.urldata_init) that also need fixing,
	but this is a start. [...] 
	Content analysis details:   (-1.0 points, 5.0 required)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	-1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
X-Mailman-Approved-At: Fri, 10 Jan 2014 17:09:25 +0000
Subject: [RFC PATCH] bitbake: Rewrite fetch2.decodeurl() to use urlparse.urlsplit()
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
X-List-Received-Date: Fri, 10 Jan 2014 16:28:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This means that it now understands "standard" URI syntax as well as
the slightly odd legacy bitbake variant.

There are other places in bitbake (e.g. Local.urldata_init) that also 
need fixing, but this is a start.

Signed-off-by: Phil Blundell <pb@pbcl.net>
---
 lib/bb/fetch2/__init__.py | 60 ++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 260fb37..4886dae 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -329,40 +329,46 @@ def decodeurl(url):
     user, password, parameters).
     """
 
-    m = re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
-    if not m:
+    if url.startswith("file://"):
+        # This is an old-style bitbake URL.  Fix it up.
+        url = "file:" + url[7:]
+
+    import urlparse
+    d = urlparse.urlsplit(url)
+    if not d.scheme:
         raise MalformedUrl(url)
 
-    type = m.group('type')
-    location = m.group('location')
-    if not location:
+    netloc = d.netloc
+    path = d.path
+
+    if not path:
         raise MalformedUrl(url)
-    user = m.group('user')
-    parm = m.group('parm')
 
-    locidx = location.find('/')
-    if locidx != -1 and type.lower() != 'file':
-        host = location[:locidx]
-        path = location[locidx:]
-    else:
-        host = ""
-        path = location
-    if user:
-        m = re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
-        if m:
-            user = m.group('user')
-            pswd = m.group('pswd')
-    else:
-        user = ''
-        pswd = ''
+    user = ''
+    pswd = ''
+    host = ''
+
+    if netloc:
+        m = re.compile('((?P<user>[^:@]+)(:(?P<pswd>[^@]+))?@)?(?P<host>.+)').match(netloc)
+        if not m:
+            raise MalformedUrl(url)
+
+        user = m.group('user')
+        pswd = m.group('pswd')
+        host = m.group('host')
 
     p = {}
-    if parm:
-        for s in parm.split(';'):
-            s1, s2 = s.split('=')
-            p[s1] = s2
+    sep = path.find(";")
+    if sep != -1:
+        for s in path[sep+1:].split(';'):
+            try:
+                s1, s2 = s.split('=')
+                p[s1] = s2
+            except ValueError:
+                raise MalformedUrl(url)
+        path = path[:sep]
 
-    return type, host, urllib.unquote(path), user, pswd, p
+    return d.scheme, host, urllib.unquote(path), user, pswd, p
 
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
-- 
1.8.5




