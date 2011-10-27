Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RJK65-0007ku-B5
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Oct 2011 09:09:57 +0200
Received: by opal (Postfix, from userid 111)
	id D837710328; Thu, 27 Oct 2011 07:09:21 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111027070921.D837710328@opal>
Date: Thu, 27 Oct 2011 07:09:21 +0000 (UTC)
From: git@git.openembedded.org
X-Mailman-Approved-At: Tue, 01 Nov 2011 08:48:59 +0100
Subject: Joshua Lock : hob: fix backtrace when dismissing open dialog
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
X-List-Received-Date: Thu, 27 Oct 2011 07:09:58 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: db59297aa1861614ffaea4295b9b054baa8a12b9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=db59297aa1861614ffaea4295b9b054baa8a12b9

Author: Joshua Lock <josh@linux.intel.com>
Date:   Tue Oct 11 10:16:02 2011 -0700

hob: fix backtrace when dismissing open dialog

Clearly a logic/indentation error - we should only try and load the recipe
should the file-chooser return OK.

Fixes [YOCTO #1668]

Signed-off-by: Joshua Lock <josh@linux.intel.com>

---

 lib/bb/ui/hob.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 71ea88a..0fcaad5 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -400,9 +400,9 @@ class MainWindow (gtk.Window):
         if response == gtk.RESPONSE_OK:
             rep.loadRecipe(recipe)
             self.save_path = recipe
+            self.model.load_image_rep(rep)
+            self.dirty = False
         chooser.destroy()
-        self.model.load_image_rep(rep)
-        self.dirty = False
 
     def bake_clicked_cb(self, button):
         build_image = True



