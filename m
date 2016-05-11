Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 343B0700EB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM6tU3000453 for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rk2Csg6sKv3s for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BLuTdu032725
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:56:30 +0100
Message-ID: <1463003789.21831.295.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 May 2016 22:56:29 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] contrib/dump_cache.py, cache: Fix to use python 3 syntax
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
X-List-Received-Date: Wed, 11 May 2016 22:06:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Some tweaks to use python 3 syntax in a python 2 compatible way.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/contrib/dump_cache.py b/bitbake/contrib/dump_cache.py
index e1f2309..97c5463 100755
--- a/bitbake/contrib/dump_cache.py
+++ b/bitbake/contrib/dump_cache.py
@@ -36,7 +36,7 @@ def main(argv=None):
     Get the mapping for the target recipe.
     """
     if len(argv) != 1:
-        print >>sys.stderr, "Error, need one argument!"
+        print("Error, need one argument!", file=sys.stderr)
         return 2
 
     cachefile = argv[0]
@@ -56,7 +56,7 @@ def main(argv=None):
                     continue
 
                 # 1.0 is the default version for a no PV recipe.
-                if val.__dict__.has_key("pv"):
+                if "pv" in val.__dict__:
                     pv = val.pv
                 else:
                     pv = "1.0"
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index af5b9fb..742fe55 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -339,7 +339,7 @@ class Cache(object):
                             value = pickled.load()
                         except Exception:
                             break
-                        if self.depends_cache.has_key(key):
+                        if key in self.depends_cache:
                             self.depends_cache[key].append(value)
                         else:
                             self.depends_cache[key] = [value]



