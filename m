Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U06CX-0002zs-QB
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Jan 2013 09:05:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 87AD119DCC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id btZwjrzoSbRK for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:13 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 8614219DD6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 84A8E3414F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Tue, 29 Jan 2013
	08:50:12 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 5EE389C078; 
	Tue, 29 Jan 2013 08:50:11 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Jan 2013 08:50:09 +0100
Message-ID: <1359445811-6394-5-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH v2 4/6] fetch2: Adapt encode/decode url to use URI class
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
X-List-Received-Date: Tue, 29 Jan 2013 08:06:12 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |   66 ++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 49 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7f44976..b6fc8f8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -319,40 +319,9 @@ def decodeurl(url):
     user, password, parameters).
     """
 
-    m = re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
-    if not m:
-        raise MalformedUrl(url)
-
-    type = m.group('type')
-    location = m.group('location')
-    if not location:
-        raise MalformedUrl(url)
-    user = m.group('user')
-    parm = m.group('parm')
-
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
-
-    p = {}
-    if parm:
-        for s in parm.split(';'):
-            s1, s2 = s.split('=')
-            p[s1] = s2
-
-    return type, host, urllib.unquote(path), user, pswd, p
+    urlo = URI(url)
+    return (urlo.scheme, urlo.hostport, urlo.path,
+            urlo.username, urlo.password, urlo.params)
 
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
@@ -361,27 +330,26 @@ def encodeurl(decoded):
 
     type, host, path, user, pswd, p = decoded
 
+    urlo = URI()
+
     if not path:
         raise MissingParameterError('path', "encoded from the data %s" % str(decoded))
     if not type:
         raise MissingParameterError('type', "encoded from the data %s" % str(decoded))
-    url = '%s://' % type
-    if user and type != "file":
-        url += "%s" % user
-        if pswd:
-            url += ":%s" % pswd
-        url += "@"
-    if host and type != "file":
-        url += "%s" % host
-    # Standardise path to ensure comparisons work
-    while '//' in path:
-        path = path.replace("//", "/")
-    url += "%s" % urllib.quote(path)
+
+    urlo.scheme = type
+    urlo.path = path
+
+    if host:
+        urlo.hostname = host
+    if user:
+        urlo.username = user
+    if pswd:
+        urlo.password = pswd
     if p:
-        for parm in p:
-            url += ";%s=%s" % (parm, p[parm])
+        urlo.params = p
 
-    return url
+    return str(urlo)
 
 def uri_replace(ud, uri_find, uri_replace, replacements, d):
     if not ud.url or not uri_find or not uri_replace:
-- 
1.7.10.4



