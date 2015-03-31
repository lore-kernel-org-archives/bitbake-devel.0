Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4036973CC2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 18:39:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t2VIdpAZ015516
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 11:39:51 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Tue, 31 Mar 2015 11:39:51 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 31 Mar 2015 14:39:50 -0400
Message-ID: <1427827190-10442-2-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
MIME-Version: 1.0
Subject: [PATCH] fetch2: Add BB_TRUSTED_NETWORK support
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
X-List-Received-Date: Tue, 31 Mar 2015 18:39:53 -0000
Content-Type: text/plain

BB_TRUSTED_NETWORK is a list of hosts that the fetcher will be allowed
to use when BB_NO_NETWORK is not set.

If BB_NO_NETWORK is set, then networking is still disabled.

If BB_TRUSTED_NETWORK is not set, the behaviour remains the same as
today.

If BB_NO_NETWORK is NOT set, and BB_TRUSTED_NETWORK is configured, then
only the hosts in the list are usable by the fetcher.

eg:
BB_TRUSTED_NETWORK="yoctoproject.org git.gnu.org"
The fetcher will be able to download from yoctoproject.org, git.gnu.org,
but not ftp.gnu.org or any other hostname that is not in the list.

There is also limited support for wildcards on the beginning of the
hosts, so BB_TRUSTED_NETWORK="*.gnu.org" with match git.gnu.org and
ftp.gnu.org as well as foo.git.gnu.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
---
 lib/bb/fetch2/__init__.py | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     | 33 +++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b004dae..09e13e0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -61,6 +61,17 @@ class BBFetchException(Exception):
     def __str__(self):
          return self.msg
 
+class UntrustedUrl(BBFetchException):
+    """Exception raised when encountering a host not listed in BB_TRUSTED_NETWORK"""
+    def __init__(self, url, message=''):
+        if message:
+            msg = message
+        else:
+            msg = "The URL: '%s' is not trusted and cannot be used" % url
+        self.url = url
+        BBFetchException.__init__(self, msg)
+        self.args = (url,)
+
 class MalformedUrl(BBFetchException):
     """Exception raised when encountering an invalid url"""
     def __init__(self, url, message=''):
@@ -851,6 +862,11 @@ def build_mirroruris(origud, mirrors, ld):
             newuri = uri_replace(ud, find, replace, replacements, ld)
             if not newuri or newuri in uris or newuri == origud.url:
                 continue
+
+            if not trusted_network(ld, newuri):
+                logger.warn("Mirror %s not in list of trusted networks, skipping" %  (newuri))
+                continue
+
             try:
                 newud = FetchData(newuri, ld)
                 newud.setup_localpath(ld)
@@ -971,6 +987,44 @@ def try_mirrors(d, origud, mirrors, check = False):
             return ret
     return None
 
+def trusted_network(d, url):
+    """
+    Use a trusted url during download if networking is enabled and
+    BB_TRUSTED_NETWORK is set globally or for a specific recipe.
+    Note: modifies SRC_URI & mirrors.
+    """
+    if d.getVar('BB_NO_NETWORK', True) == "1":
+        return True
+
+    pkgname = d.expand(d.getVar('PN'))
+    trusted_hosts = d.getVarFlag('BB_TRUSTED_NETWORK', pkgname)
+
+    if not trusted_hosts:
+        trusted_hosts = d.getVar('BB_TRUSTED_NETWORK', True)
+
+    # Not enabled.
+    if not trusted_hosts:
+        return True
+
+    scheme, network, path, user, passwd, param = decodeurl(url)
+
+    if not network:
+        return True
+
+    network = network.lower()
+
+    for host in trusted_hosts.split(" "):
+        host = host.lower()
+        if (re.match('^\*?\.', host)):
+            host = host[2:]
+            m = network.split('.')
+            network = "%s.%s" % (m[-2], m[-1])
+        if (host == network):
+            return True
+
+
+    return False
+
 def srcrev_internal_helper(ud, d, name):
     """
     Return:
@@ -1511,6 +1565,9 @@ class Fetch(object):
 
             lf = bb.utils.lockfile(ud.lockfile)
 
+            if not trusted_network(self.d, ud.url):
+                raise UntrustedUrl(ud.url)
+
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
  
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d56ef49..69e689d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -547,6 +547,39 @@ class FetcherNetworkTest(FetcherTest):
             os.chdir(os.path.dirname(self.unpackdir))
             fetcher.unpack(self.unpackdir)
 
+        def test_trusted_network(self):
+            # Ensure trusted_network returns False when the host IS in the list.
+            url = "git://Someserver.org/foo;rev=1"
+            self.d.setVar("BB_TRUSTED_NETWORK", "server1.org someserver.org server2.org server3.org")
+            self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+        def test_wild_trusted_network(self):
+            # Ensure trusted_network returns true when the *.host IS in the list.
+            url = "git://Someserver.org/foo;rev=1"
+            self.d.setVar("BB_TRUSTED_NETWORK", "server1.org *.someserver.org server2.org server3.org")
+            self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+        def test_prefix_wild_trusted_network(self):
+            # Ensure trusted_network returns true when the prefix matches *.host.
+            url = "git://git.Someserver.org/foo;rev=1"
+            self.d.setVar("BB_TRUSTED_NETWORK", "server1.org *.someserver.org server2.org server3.org")
+            name = bb.fetch.trusted_network(self.d, url)
+            self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        def test_two_prefix_wild_trusted_network(self):
+            # Ensure trusted_network returns true when the prefix matches *.host.
+            url = "git://something.git.Someserver.org/foo;rev=1"
+            self.d.setVar("BB_TRUSTED_NETWORK", "server1.org *.someserver.org server2.org server3.org")
+            name = bb.fetch.trusted_network(self.d, url)
+            self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+        def test_untrusted_network(self):
+            # Ensure trusted_network returns False when the host is NOT in the list.
+            self.d.delVar("BB_TRUSTED_NETWORK")
+            url = "git://someserver.org/foo;rev=1"
+            self.d.setVar("BB_TRUSTED_NETWORK", "server1.org server2.org server3.org")
+            self.assertFalse(bb.fetch.trusted_network(self.d, url))
+
+
 class URLHandle(unittest.TestCase):
 
     datatable = {
-- 
2.1.0


