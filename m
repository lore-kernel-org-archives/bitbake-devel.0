Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RRM2W-00044o-8V
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Nov 2011 11:51:24 +0100
Received: by opal (Postfix, from userid 111)
	id EE45610331; Fri, 18 Nov 2011 10:46:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111118104638.EE45610331@opal>
Date: Fri, 18 Nov 2011 10:46:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : siggen.py: Include list of variables in hashes
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
X-List-Received-Date: Fri, 18 Nov 2011 10:51:24 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 727ca945177ce9bd44515cf611e3e95a09466d98
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=727ca945177ce9bd44515cf611e3e95a09466d98

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 17 14:01:06 2011 +0000

siggen.py: Include list of variables in hashes

Ensure that the list of dependencies is included in the hash
as well as their contents

Prior to this, adding or removing dependencies with values
of "None" would not change the hash, despite diffsigs reporting
this difference.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 611772a..217f29b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -101,6 +101,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             alldeps = seen - self.basewhitelist
 
             for dep in sorted(alldeps):
+                data = data + dep
                 if dep in lookupcache:
                     var = lookupcache[dep]
                 else:



