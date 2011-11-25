Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTu0I-0002yR-OT
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Nov 2011 12:31:39 +0100
Received: by opal (Postfix, from userid 111)
	id 0C52910330; Fri, 25 Nov 2011 11:27:37 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111125112737.0C52910330@opal>
Date: Fri, 25 Nov 2011 11:27:37 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/siggen.py: Don' t backtrace if the taskhash data isn't present
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
X-List-Received-Date: Fri, 25 Nov 2011 11:31:39 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 5ace320ccc01f4e326f90b7ba060dcbff3380dca
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=5ace320ccc01f4e326f90b7ba060dcbff3380dca

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Nov 25 11:20:33 2011 +0000

bitbake/siggen.py: Don't backtrace if the taskhash data isn't present

This allows the code to safely fall back to dumping the basehash data
if the taskhash data isn't present for some reason. We could effecitvely
obsolete the runtime option and use this approach instead exclusively.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 7580742..91b4160 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -159,7 +159,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         k = fn + "." + task
         if runtime == "customfile":
             sigfile = stampbase
-        elif runtime:
+        elif runtime and k in self.taskhash:
             sigfile = stampbase + "." + task + ".sigdata" + "." + self.taskhash[k]
         else:
             sigfile = stampbase + "." + task + ".sigbasedata" + "." + self.basehash[k]
@@ -180,7 +180,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['gendeps'][dep] = self.gendeps[fn][dep]
             data['varvals'][dep] = self.lookupcache[fn][dep]
 
-        if runtime:
+        if runtime and k in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[k]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:



