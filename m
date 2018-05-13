Return-Path: <n.merinov@inango-systems.com>
Received: from main-1.inango.com (main-1.inango-systems.com [5.189.174.2])
	by mail.openembedded.org (Postfix) with ESMTP id BB1FF78A0C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 May 2018 14:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by main-1.inango.com (Postfix) with ESMTP id 89287443445
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 May 2018 17:49:04 +0300 (IDT)
X-Virus-Scanned: Debian amavisd-new at mail.inango-systems.com
Received: from main-1.inango.com ([127.0.0.1])
	by localhost (main-1.inango.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zWwqAYrXoz5; Sun, 13 May 2018 17:49:02 +0300 (IDT)
Received: from nmerinov.inango-sw (unknown [194.60.247.123])
	by main-1.inango.com (Postfix) with ESMTPSA id CE052442E47;
	Sun, 13 May 2018 17:49:01 +0300 (IDT)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 13 May 2018 19:48:49 +0500
Message-Id: <20180513144849.6526-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.14.1
Subject: [PATCH] fetch2: Use correct check in parameter handling in uri_replace()
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
X-List-Received-Date: Sun, 13 May 2018 14:49:05 -0000

If uri_find contain parameters then original URI parameters should
be checked against parameters from uri_find instead of parameters
from uri_replace.
---
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/tests/fetch.py     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 72d6092d..829f1903 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -452,8 +452,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
             # Handle URL parameters
             if i:
                 # Any specified URL parameters must match
-                for k in uri_replace_decoded[loc]:
-                    if uri_decoded[loc][k] != uri_replace_decoded[loc][k]:
+                for k in uri_find_decoded[loc]:
+                    if uri_decoded[loc][k] != uri_find_decoded[loc][k]:
                         return None
             # Overwrite any specified replacement parameters
             for k in uri_replace_decoded[loc]:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74859f9d..66a9ddb5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -402,6 +402,8 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http") 
             : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
+            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
 
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-- 
2.14.1


