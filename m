Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1DA0770057
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 20:54:19 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u8FKsKxU014564
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 13:54:20 -0700 (PDT)
Received: from msp-dhcp15.wrs.com (172.25.34.15) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 15 Sep 2016 13:54:19 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Sep 2016 15:54:18 -0500
Message-ID: <1473972859-217662-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.5.5
MIME-Version: 1.0
Subject: [PATCH 1/2] fetch2/git.py: Sanitize the url to remove trailing '/' from the path [WIP]
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
X-List-Received-Date: Thu, 15 Sep 2016 20:54:20 -0000
Content-Type: text/plain

A git url should not end with a trailing slash ('/').  Inside of the git tool
itself there are numerous commits that strip any trailing slashes from the
URI.  This patch ensures that behavior is matched inside of the fetcher.

This is important because of the mirroring code, '/' is replace with '.'.  So
two equivalent mirrors: example.org/git/example and example.org/git/example/
will show up as different MIRRORNAMEs.  In addition, the path the files are
cloned into is also affected.  Stripping the trailing slash ensures both
equivalent (to git) URIs are treated the same.

In addition, some filesystems, such as Windows, do not permit a directory
name to end with a '.' character.  Typically this is not an issue, but we
have users that want to transfer or share mirrored downloads via windows
platforms and shares.

(based on initial work from Jason Wessel and Robert Yang.)

Note: this current fails to pass the selftest due to the URI changing
in the fetch.py's 'test_uri' test case.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/git.py  |  8 ++++++++
 lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 1bec60a..c9d07fa 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -77,6 +77,7 @@ import bb
 import errno
 import bb.progress
 from   bb    import data
+from   bb.fetch2 import encodeurl
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -141,6 +142,13 @@ class Git(FetchMethod):
         init git specific variable within url data
         so that the git method like latest_revision() can work
         """
+        # Sanitize the path, to ensure it does not end in a '/'.
+        # Git does this internally, so really all this does is affect any
+        # bitbake mirror paths, as '/' is translated to a '.'.
+        if ud.path.endswith('/'):
+            ud.path = ud.path[:-1]
+            ud.url = encodeurl((ud.type, ud.host, ud.path, ud.user, ud.pswd, ud.parm))
+
         if 'protocol' in ud.parm:
             ud.proto = ud.parm['protocol']
         elif not ud.host:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d7c73dd..ef39d31 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -230,6 +230,36 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': False
         },
+        "git://example.net/path/example": {
+            'uri': 'git://example.net/path/example',
+            'scheme': 'git',
+            'hostname': 'example.net',
+            'port': None,
+            'hostport': 'example.net',
+            'path': '/path/example',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {},
+            'relative': False
+        },
+        "git://example.net/path/example/": {
+            'uri': 'git://example.net/path/example',
+            'scheme': 'git',
+            'hostname': 'example.net',
+            'port': None,
+            'hostport': 'example.net',
+            'path': '/path/example',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {},
+            'relative': False
+        },
         "http://somesite.net;someparam=1": {
             'uri': 'http://somesite.net;someparam=1',
             'scheme': 'http',
@@ -396,6 +426,10 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http") 
             : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://example.net/path/example;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://path/MIRRORNAME")
+            : "git://path/example.net.path.example;tag=1234567890123456789012345678901234567890",
+        ("git://example.net/path/example/;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://path/MIRRORNAME")
+            : "git://path/example.net.path.example;tag=1234567890123456789012345678901234567890",
 
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-- 
2.5.5


