Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id E54B56B8D1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2014 10:01:43 +0000 (UTC)
Received: by mail-ea0-f179.google.com with SMTP id q10so2472725ead.24
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2014 02:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=RDU/AI18FvMPOFQHpj0goxwjayJ6H0E4Bp2PfZlGrGk=;
	b=R4p5CNEMAq2uiaksm/OBt8hc+jXUjm5ZuSZkX1BhbX8wuqKd7SfuMU6aWtjsrUhyVW
	aPh6cICOwQ4ZOWGj3DXz2c03ypkp84NW4FS/tlLTqwXSWm1pi8HM52mKeNNBU3C16rFP
	y4vQ9e+q8g/uZXw5JKcmw8eJDw4ErjQL9fokJ5GSJAjU/fn0TDLSyn+FCy6cvhlwwIdg
	oXYHZ/iZl7wqIe3NQOb+lpHTo51593mQ7XehNekY13m0/a4Rt+Wk/3iSEmu7SxmA04WY
	uDk7+LgCR0TO09YPqF/mifckHSHJo1iu6Pil+LrEM36WyKIzKUgloDew7ojN1jykPDFf
	KHkg==
X-Received: by 10.15.44.202 with SMTP id z50mr18583566eev.81.1393149703868;
	Sun, 23 Feb 2014 02:01:43 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	n41sm49251094eeg.16.2014.02.23.02.01.42 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 23 Feb 2014 02:01:42 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 23 Feb 2014 11:02:18 +0100
Message-Id: <1393149738-20871-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH] runqueue: Catch ValueError from pickle.loads
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
X-List-Received-Date: Sun, 23 Feb 2014 10:01:47 -0000

* exception like this keeps spinning quite quickly generating GBs of logs
  better to kill it asap and show invalid pickle

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/runqueue.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 413d59f..bc48684 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2092,14 +2092,20 @@ class runQueuePipe():
             found = False
             index = self.queue.find("</event>")
             while index != -1 and self.queue.startswith("<event>"):
-                event = pickle.loads(self.queue[7:index])
+                try:
+                    event = pickle.loads(self.queue[7:index])
+                except ValueError as e:
+                    bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[7:index]))
                 bb.event.fire_from_worker(event, self.d)
                 found = True
                 self.queue = self.queue[index+8:]
                 index = self.queue.find("</event>")
             index = self.queue.find("</exitcode>")
             while index != -1 and self.queue.startswith("<exitcode>"):
-                task, status = pickle.loads(self.queue[10:index])
+                try:
+                    task, status = pickle.loads(self.queue[10:index])
+                except ValueError as e:
+                    bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
                 self.rq.runqueue_process_waitpid(task, status)
                 found = True
                 self.queue = self.queue[index+11:]
-- 
1.9.0


