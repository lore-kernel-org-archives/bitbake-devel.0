Received: from smtpfb1-g21.free.fr ([212.27.42.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1SANrD-0002hw-48
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 16:53:51 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 378252D95E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Mar 2012 16:44:58 +0100 (CET)
Received: from localhost.localdomain (unknown [82.233.81.124])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D53D7A611A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Mar 2012 16:44:53 +0100 (CET)
From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 16:44:51 +0100
Message-Id: <1332344691-24973-1-git-send-email-eric@eukrea.com>
X-Mailer: git-send-email 1.7.7.6
MIME-Version: 1.0
Subject: [PATCH] runningbuild.py: fix goggle ui
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
X-List-Received-Date: Wed, 21 Mar 2012 15:53:51 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

without this fix I get the following error once the build is finished :
Traceback (most recent call last):
  File ".../bitbake/lib/bb/ui/goggle.py", line 35, in event_handle_idle_f=
unc
    build.handle_event (event, pbar)
  File ".../bitbake/lib/bb/ui/crumbs/runningbuild.py", line 287, in handl=
e_event
    pbar.set_text(event.msg)
AttributeError: 'ProgressBar' object has no attribute 'set_text'

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningb=
uild.py
index 4c3fe2c..343eac9 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -284,7 +284,7 @@ class RunningBuild (gobject.GObject):
             # handle when the build is finished
             self.emit("build-complete")
             if pbar:
-                pbar.set_text(event.msg)
+                pbar.set_title(event.msg)
=20
         elif isinstance(event, bb.command.CommandFailed):
             if event.error.startswith("Exited with"):
--=20
1.7.7.6



