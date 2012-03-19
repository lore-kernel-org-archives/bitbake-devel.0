Received: from smtpfb1-g21.free.fr ([212.27.42.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1S9bTd-0006dZ-81
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:14:17 +0100
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 84D6A2CBF0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Mar 2012 12:56:25 +0100 (CET)
Received: from localhost.localdomain (unknown [82.240.38.71])
	by smtp2-g21.free.fr (Postfix) with ESMTP id D2E9E4B0085
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Mar 2012 12:56:20 +0100 (CET)
From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 12:56:19 +0100
Message-Id: <1332158179-2776-1-git-send-email-eric@eukrea.com>
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
X-List-Received-Date: Mon, 19 Mar 2012 12:14:17 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

* goggle ui actually fails with :
Traceback (most recent call last):
  File ".../bitbake/lib/bb/ui/goggle.py", line 35, in event_handle_idle_f=
unc
    build.handle_event (event, pbar)
  File ".../bitbake/lib/bb/ui/crumbs/runningbuild.py", line 234, in handl=
e_event
    pbar.update(0, None, bb.event.getName(event))
TypeError: update() takes exactly 3 arguments (4 given)

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningb=
uild.py
index 718f692..10ca394 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -231,8 +231,8 @@ class RunningBuild (gobject.GObject):
                                       HobColors.OK,
                                       0))
             if pbar:
-                pbar.update(0, None, bb.event.getName(event))
-                pbar.set_title()
+                pbar.update(0, self.progress_total)
+                pbar.set_title(bb.event.getName(event))
=20
         elif isinstance(event, bb.event.BuildCompleted):
             failures =3D int (event._failures)
--=20
1.7.7.6



