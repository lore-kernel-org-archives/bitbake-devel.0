Return-Path: <tomasz.meresinski@comarch.pl>
Received: from odzwierny1.comarch.com (odzwierny1.comarch.com [217.74.69.9])
	by mail.openembedded.org (Postfix) with ESMTP id 3999C796A6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 17:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as tomasz.meresinski@comarch.com
	by odzwierny1.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1gHAZy-000BL7-NT; Mon, 29 Oct 2018 17:39:50 +0100
From: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Oct 2018 17:39:31 +0100
Message-Id: <20181029163933.26646-2-tomasz.meresinski@comarch.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
References: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny1.comarch.com
X-CA-Is-Spam: No
Cc: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.com>,
	=?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
Subject: [PATCH 1/3] build: Create package property for TaskBase
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
X-List-Received-Date: Mon, 29 Oct 2018 17:15:29 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before this commit we had private _package member in TaskBase.
Create public property exposing it.

Signed-off-by: Tomasz Meresiński <tomasz.meresinski@comarch.com>
---
 lib/bb/build.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3e2a94ed..d1eaf4da 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -104,10 +104,17 @@ class TaskBase(event.Event):
     def setTask(self, task):
         self._task = task
 
+    def getPackage(self):
+        return self._package
+
+    def setPackage(self, package):
+        self._package = package
+
     def getDisplayName(self):
         return bb.event.getName(self)[4:]
 
     task = property(getTask, setTask, None, "task property")
+    package = property(getPackage, setPackage, doc="package name of this task")
 
 class TaskStarted(TaskBase):
     """Task execution started"""
@@ -181,7 +188,7 @@ class LogTee(object):
 
 #
 # pythonexception allows the python exceptions generated to be raised
-# as the real exceptions (not FuncFailed) and without a backtrace at the 
+# as the real exceptions (not FuncFailed) and without a backtrace at the
 # origin of the failure.
 #
 def exec_func(func, d, dirs = None, pythonexception=False):
-- 
2.17.1


