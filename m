Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A216C60746
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 10:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MASQSZ031606 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:28:26 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id djvv-OkpXEpn for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:28:26 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MASNqf031603
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:28:24 +0100
Message-ID: <1469183303.23580.49.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jul 2016 11:28:23 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Add better cache loading sanity checks
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
X-List-Received-Date: Fri, 22 Jul 2016 10:28:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We've seen cache corruption where the pairs come out in a different
order to the way we saved them for unknown reasons. Add better sanity
checking to give a more user friendly error rather than a crash/traceback.

Also allows the system to reparse and recover.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index cce12d1..439565f 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -328,6 +328,13 @@ class Cache(object):
                         value = pickled.load()
                     except Exception:
                         break
+                    if not isinstance(key, str):
+                        bb.warn("%s from extras cache is not a string?" % key)
+                        break
+                    if not isinstance(value, RecipeInfoCommon):
+                        bb.warn("%s from extras cache is not a RecipeInfoCommon class?" % value)
+                        break
+
                     if key in self.depends_cache:
                         self.depends_cache[key].append(value)
                     else:



