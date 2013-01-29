Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U06Cr-00030o-I0
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Jan 2013 09:06:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 416C111FAA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KfWps3CwQslK for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:32 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by ra.se.axis.com (Postfix) with ESMTP id C52B611FAE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 862F63416B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Tue, 29 Jan 2013
	08:50:12 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id E6AB09C077; 
	Tue, 29 Jan 2013 08:50:11 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Jan 2013 08:50:07 +0100
Message-ID: <1359445811-6394-3-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH v2 2/6] fetch2: Add a class representing a generic URI
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
X-List-Received-Date: Tue, 29 Jan 2013 08:06:26 -0000
Content-Type: text/plain

A class representing a generic URI, with methods for accessing the URI
components, and stringifies to the URI. This class should be a bit more
flexible than the existing {encode,decode}_url functions in that it
supports more components (e.g. port) and that it does not rely on a
specific order on the return values. This makes it easy to add new
properties without affecting the API.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |  194 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4746356..7f44976 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -30,6 +30,7 @@ from __future__ import print_function
 import os, re
 import logging
 import urllib
+from urlparse import urlparse
 import operator
 import bb.persist_data, bb.utils
 import bb.checksum
@@ -120,6 +121,199 @@ class NonLocalMethod(Exception):
     def __init__(self):
         Exception.__init__(self)
 
+
+class URI(object):
+    """
+    A class representing a generic URI, with methods for
+    accessing the URI components, and stringifies to the
+    URI.
+
+    It is constructed by calling it with a URI, or setting
+    the attributes manually:
+
+     uri = URI("http://example.com/")
+
+     uri = URI()
+     uri.scheme = 'http'
+     uri.hostname = 'example.com'
+     uri.path = '/'
+
+    It has the following attributes:
+
+      * scheme (read/write)
+      * userinfo (authentication information) (read/write)
+        * username (read/write)
+        * password (read/write)
+
+        Note, password is deprecated as of RFC 3986.
+
+      * hostname (read/write)
+      * port (read/write)
+      * hostport (read only)
+        "hostname:port", if both are set, otherwise just "hostname"
+      * path (read/write)
+      * path_quoted (read/write)
+        A URI quoted version of path
+      * params (dict) (read/write)
+      * relative (bool) (read only)
+        True if this is a "relative URI", (e.g. file:foo.diff)
+
+    It stringifies to the URI itself.
+
+    Some notes about relative URIs: while it's specified that
+    a URI beginning with <scheme>:// should either be directly
+    followed by a hostname or a /, the old URI handling of the
+    fetch2 library did not comform to this. Therefore, this URI
+    class has some kludges to make sure that URIs are parsed in
+    a way comforming to bitbake's current usage. This URI class
+    supports the following:
+
+     file:relative/path.diff (IETF compliant)
+     git:relative/path.git (IETF compliant)
+     git:///absolute/path.git (IETF compliant)
+     file:///absolute/path.diff (IETF compliant)
+
+     file://relative/path.diff (not IETF compliant)
+
+    But it does not support the following:
+
+     file://hostname/absolute/path.diff (would be IETF compliant)
+
+    Note that the last case only applies to a list of
+    "whitelisted" schemes (currently only file://), that requires
+    its URIs to not have a network location.
+    """
+
+    _relative_schemes = ['file', 'git']
+    _netloc_forbidden = ['file']
+
+    def __init__(self, uri=None):
+        self.scheme = ''
+        self.userinfo = ''
+        self.hostname = ''
+        self.port = None
+        self._path = ''
+        self.params = {}
+        self.relative = False
+
+        if not uri:
+            return
+
+        urlp = urlparse(uri)
+        self.scheme = urlp.scheme
+
+        # Convert URI to be relative
+        if urlp.scheme in self._netloc_forbidden:
+            uri = re.sub("(?<=:)//(?!/)", "", uri, 1)
+            urlp = urlparse(uri)
+
+        # Identify if the URI is relative or not
+        if urlp.scheme in self._relative_schemes and \
+           re.compile("^\w+:(?!//)").match(uri):
+            self.relative = True
+
+        if not self.relative:
+            self.hostname = urlp.hostname or ''
+            self.port = urlp.port
+
+            self.userinfo += urlp.username or ''
+
+            if urlp.password:
+                self.userinfo += ':%s' % urlp.password
+
+        # Do support params even for URI schemes that Python's
+        # urlparse doesn't support params for.
+        path = ''
+        param_str = ''
+        if not urlp.params:
+            path, param_str = (list(urlp.path.split(";", 1)) + [None])[:2]
+        else:
+            path = urlp.path
+            param_str = urlp.params
+
+        self.path = urllib.unquote(path)
+
+        if param_str:
+            self.params = self._param_dict(param_str)
+
+    def __str__(self):
+        userinfo = self.userinfo
+        if userinfo:
+            userinfo += '@'
+
+        return "%s:%s%s%s%s%s" % (
+            self.scheme,
+            '' if self.relative else '//',
+            userinfo,
+            self.hostport,
+            self.path_quoted,
+            self._param_str)
+
+    @property
+    def _param_str(self):
+        ret = ''
+        for key, val in self.params.items():
+            ret += ";%s=%s" % (key, val)
+        return ret
+
+    def _param_dict(self, param_str):
+        parm = {}
+
+        for keyval in param_str.split(";"):
+            key, val = keyval.split("=", 1)
+            parm[key] = val
+
+        return parm
+
+    @property
+    def hostport(self):
+        if not self.port:
+            return self.hostname
+        return "%s:%d" % (self.hostname, self.port)
+
+    @property
+    def path_quoted(self):
+        return urllib.quote(self.path)
+
+    @path_quoted.setter
+    def path_quoted(self, path):
+        self.path = urllib.unquote(path)
+
+    @property
+    def path(self):
+        return self._path
+
+    @path.setter
+    def path(self, path):
+        self._path = path
+
+        if re.compile("^/").match(path):
+            self.relative = False
+        else:
+            self.relative = True
+
+    @property
+    def username(self):
+        if self.userinfo:
+            return (self.userinfo.split(":", 1))[0]
+        return ''
+
+    @username.setter
+    def username(self, username):
+        self.userinfo = username
+        if self.password:
+            self.userinfo += ":%s" % self.password
+
+    @property
+    def password(self):
+        if self.userinfo and ":" in self.userinfo:
+            return (self.userinfo.split(":", 1))[1]
+        return ''
+
+    @password.setter
+    def password(self, password):
+        self.userinfo = "%s:%s" % (self.username, password)
+
 def decodeurl(url):
     """Decodes an URL into the tokens (scheme, network location, path,
     user, password, parameters).
-- 
1.7.10.4



