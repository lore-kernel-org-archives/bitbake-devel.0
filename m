Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6k1j-0008Dr-Gc for bitbake-devel@lists.openembedded.org;
	Sun, 11 Mar 2012 15:45:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEawqG003395
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:36:58 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03246-02 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:36:50 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEaiSL003371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:36:45 GMT
Message-ID: <1331476604.15192.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Mar 2012 14:36:44 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] codeparser: Call intern over the set contents for better cache performance
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
X-List-Received-Date: Sun, 11 Mar 2012 14:45:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

See the comment in the code in the commit for more information.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 04a34f9..af2e194 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -98,6 +98,12 @@ def parser_cache_save(d):
     bb.utils.unlockfile(lf)
     bb.utils.unlockfile(glf)
 
+def internSet(items):
+    new = set()
+    for i in items:
+        new.add(intern(i))
+    return new
+
 def parser_cache_savemerge(d):
     cachefile = parser_cachefile(d)
     if not cachefile:
@@ -133,6 +139,21 @@ def parser_cache_savemerge(d):
                 data[1][h] = extradata[1][h]
         os.unlink(f)
 
+    # When the dicts are originally created, python calls intern() on the set keys
+    # which significantly improves memory usage. Sadly the pickle/unpickle process 
+    # doesn't call intern() on the keys and results in the same strings being duplicated
+    # in memory. This also means pickle will save the same string multiple times in 
+    # the cache file. By interning the data here, the cache file shrinks dramatically
+    # meaning faster load times and the reloaded cache files also consume much less 
+    # memory. This is worth any performance hit from this loops and the use of the 
+    # intern() data storage.
+    # Python 3.x may behave better in this area
+    for h in data[0]:
+        data[0][h]["refs"] = internSet(data[0][h]["refs"])
+        data[0][h]["execs"] = internSet(data[0][h]["execs"])
+    for h in data[1]:
+        data[1][h]["execs"] = internSet(data[1][h]["execs"])
+
     p = pickle.Pickler(file(cachefile, "wb"), -1)
     p.dump([data, PARSERCACHE_VERSION])
 




