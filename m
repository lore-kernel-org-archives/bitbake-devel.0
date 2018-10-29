Return-Path: <tomasz.meresinski@comarch.pl>
Received: from odzwierny1.comarch.com (odzwierny1.comarch.com [217.74.69.9])
	by mail.openembedded.org (Postfix) with ESMTP id 2422679A16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 17:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as tomasz.meresinski@comarch.com
	by odzwierny1.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1gHAZz-000BL7-Bc; Mon, 29 Oct 2018 17:39:51 +0100
From: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Oct 2018 17:39:32 +0100
Message-Id: <20181029163933.26646-3-tomasz.meresinski@comarch.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
References: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny1.comarch.com
X-CA-Is-Spam: No
Cc: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.com>,
	=?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
Subject: [PATCH 2/3] runqueue: Fix base class for sceneQueueComplete
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
X-List-Received-Date: Mon, 29 Oct 2018 17:22:36 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__init__ method initialized bb.event.Event not sceneQueueEvent.
Change base class to bb.event.Event.

Signed-off-by: Tomasz Meresiński <tomasz.meresinski@comarch.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9ce06c40..e138a5c2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2615,7 +2615,7 @@ class sceneQueueTaskFailed(sceneQueueEvent):
     def __str__(self):
         return "Setscene task (%s) failed with exit code '%s' - real task will be run instead" % (self.taskstring, self.exitcode)
 
-class sceneQueueComplete(sceneQueueEvent):
+class sceneQueueComplete(bb.event.Event):
     """
     Event when all the sceneQueue tasks are complete
     """
-- 
2.17.1


