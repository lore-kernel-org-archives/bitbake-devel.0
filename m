Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8r-0003Tv-8p
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbXk7002020
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:33 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:33 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:48 -0500
Message-ID: <1347921831-60604-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
References: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/4] progress.py: Fix traceback when running goggle ui
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:13 -0000
Content-Type: text/plain

The following traceback appears when running the following command after the
devshell is exited.

bitbake -u goggle -c devshell busybox

-- traceback --
Traceback (most recent call last):
  File "/work/bitbake/lib/bb/ui/goggle.py", line 35, in event_handle_idle_func
    build.handle_event (event, pbar)
  File "/work/bitbake/lib/bb/ui/crumbs/runningbuild.py", line 299, in handle_event
    pbar.set_text(event.msg)
AttributeError: 'ProgressBar' object has no attribute 'set_text'

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/crumbs/progress.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/progress.py b/lib/bb/ui/crumbs/progress.py
index 0c7ad96..1d28a11 100644
--- a/lib/bb/ui/crumbs/progress.py
+++ b/lib/bb/ui/crumbs/progress.py
@@ -11,6 +11,9 @@ class ProgressBar(gtk.Dialog):
         self.vbox.pack_start(self.progress)
         self.show_all()
 
+    def set_text(self, msg):
+        self.progress.set_text(msg)
+
     def update(self, x, y):
         self.progress.set_fraction(float(x)/float(y))
         self.progress.set_text("%2d %%" % (x*100/y))
-- 
1.7.1



