Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfnv-0005Te-K7
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:48:12 +0100
Received: by opal (Postfix, from userid 111)
	id AB19510333; Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174903.AB19510333@opal>
Date: Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: close files in apply_append()
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
X-List-Received-Date: Tue, 10 Jan 2012 17:48:12 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 470a160813ce6cf04f83258d46ded5c2ab8bc520
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=470a160813ce6cf04f83258d46ded5c2ab8bc520

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Sun Jan  8 12:06:51 2012 +0000

bitbake-layers: close files in apply_append()

It's recommended practice to close files when finished with them and the
code in this function was not doing this.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index b4c4127..b4cfd55 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -307,6 +307,8 @@ build results (as the layer priority order has effectively changed).
         recipefile.write('\n')
         recipefile.write('##### bbappended from %s #####\n' % self.get_append_layer(appendname))
         recipefile.writelines(appendfile.readlines())
+        recipefile.close()
+        appendfile.close()
 
     def do_show_appends(self, args):
         """list bbappend files and recipe files they apply to



