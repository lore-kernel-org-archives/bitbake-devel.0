Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
	[209.85.215.176])
	by mail.openembedded.org (Postfix) with ESMTP id ECE8C7F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:27 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id k25so24174381pgt.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=0ViN4eew048vW/phfY2G2OZGq0yL+x9DncJgy3Y4PCk=;
	b=EBBzTmLW6wbSmkJX4hBP3z+nh8v4IIhoLrUo1oYgpvqOhOnv0v72GOF89j+4BBxH00
	EzhEqjFh84Dj1d+iA/E+wqoOCxUAigaxFKAEqwVhhHP6VSieuwnLc6FayZKsjSDjE/1A
	NcQTpHNWtKz/NNY04hZlXlOB/ogcLDJ7umPt4GizPc7Ibgn8XIgNJ0RiCDREnrWjvBEx
	kFHkMH3M3kRftTc6xM3JI/xyPtZQ/MNN97ivePGNuXhE8gYIVnwNRQFHIVxwq5k9xD96
	TDJf3plcD9YDXkp22gMMLceHEIlYe8dlg4oZULVIM3HtAiUT7fEZ0/1EzZSq/sB1WW8X
	nemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=0ViN4eew048vW/phfY2G2OZGq0yL+x9DncJgy3Y4PCk=;
	b=hcRSDcMAl5KSJHJvMrrbPybS3XPbewwO9AR7oQ0Tq20Kg7WXfkAyseQ90PSwZjrhpv
	6U+ztqy2GKz9t2pkbrkdH7FdpZ0IEEN16a4pTQhBw4zd0+T7QSraEbUChTX5TBgWJdzG
	soIs9gFTZlRhte0PL1m+MThoF3L8cd4fX4eUUf97twpKxlCdp+aahoHN1L9aKGKZgFge
	IzLFy/Gl1i1+ooWhxf+6gkliS6vHouas3vLwoXsMHM3GSPzdF51VTs6RHAmhUwIf4X7Y
	hlgbEv5IABBaL3plIBcK/Hq0bFch6ci1otLQr03rqpWeoh2y8FR33UJHPoxpnw/Bpwtu
	yZTg==
X-Gm-Message-State: APjAAAVqMZbRKzPGXWbjObGNWwaEO9xPclHa3xgZLY5zI5JFY/cyPOcl
	SNItCiJqPbnlXSR6jQwtUbWRvmpl8+g=
X-Google-Smtp-Source: APXvYqzefx99w3zXqvQu2T/g+yr67wPNZfK1FgDOr5/QH1Wh6OaZLtzySzZpCLZNlXdEsEnoM3+bNw==
X-Received: by 2002:a63:3245:: with SMTP id y66mr99144164pgy.234.1578104608898;
	Fri, 03 Jan 2020 18:23:28 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:28 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:01 -0800
Message-Id: <7fa3ede953971f761d8cafafa37d1bcb65ad6a77.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 16/25] runqueue: Optimise task filtering
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:28 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We were seeing this running thousands of times with hashequiv, do
the filtering where it makes more sense and make it persist.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2cfeb9998a8ad5b1dcda0bb4e192c5e4306dab17)
---
 lib/bb/runqueue.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 73775d97..b90ac875 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -148,8 +148,9 @@ class RunQueueScheduler(object):
         """
         Return the id of the first task we find that is buildable
         """
+        # Once tasks are running we don't need to worry about them again
+        self.buildable.difference_update(self.rq.runq_running)
         buildable = set(self.buildable)
-        buildable.difference_update(self.rq.runq_running)
         buildable.difference_update(self.rq.holdoff_tasks)
         buildable.intersection_update(self.rq.tasks_covered | self.rq.tasks_notcovered)
         if not buildable:
@@ -207,8 +208,6 @@ class RunQueueScheduler(object):
 
     def newbuildable(self, task):
         self.buildable.add(task)
-        # Once tasks are running we don't need to worry about them again
-        self.buildable.difference_update(self.rq.runq_running)
 
     def removebuildable(self, task):
         self.buildable.remove(task)
-- 
2.17.1


