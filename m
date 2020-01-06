Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
	[209.85.214.178])
	by mail.openembedded.org (Postfix) with ESMTP id E108B7FD83
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:05 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id g6so19086757plp.6
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=0ViN4eew048vW/phfY2G2OZGq0yL+x9DncJgy3Y4PCk=;
	b=VYC6sme9SePNjleUAVPnWMVkUPTPHqISlRVJ2gGABvtkmWXcuNIE/6lhsZdcOAvkTg
	OsLTogOS4SRfBjrk+g7D7gkpkf3Xk7b9TedfYASf3l9nZAphqf0Fb5pFiM1I1fpSssfc
	gy6n8wDJYMWLZ9nm3vtGL9Ebg8S5YotIxGjvaib5bfSqWM8gZ+M46IObYjyJTWcUBpVA
	nUOvdcdSO+/ur1Jqn8fvXTnYJpW3h4jOPGTO3S/OW//gFlCx6fp+/Q7Ib/f29jiSFB5k
	DO+vcQJUvnwxSa6e1saUQAk/TIhgM0jGhhZ9/dlU1WzuYTpeH2IHo8qRuonTgba7Jz7y
	1RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=0ViN4eew048vW/phfY2G2OZGq0yL+x9DncJgy3Y4PCk=;
	b=Mg+vqdaiX8MvnZIDjpBNFu9ubi3qYzwlBdiiAPvd2tKpzMFbhnSg5N8VVCWp+EfsWw
	yGbsyXPW2IPlMFZP3yIvta+DMO9KByZoSBXXHjGYtyB+mRWEtVPMTBFjtKoPIag2mc7s
	ser63K8yyhccQ504pPui6r6RIkcL8CGUdLo2FbUzEdb/7TdnHoC+5roWPr08KsubDoG3
	KspLycLVKljO35t8QywLenjrRjRrdA2Q/PIw1qKQJUgKBQiD0IiaIvt2IRGf0R9sM+/8
	pRS5CEibpt/mpTBW9yu3KaB3rtGOyvWfwSBWLrlc9WwVARB+xiUlHR+C8hjKg0tw87Fh
	eXxw==
X-Gm-Message-State: APjAAAW/kiQaZVObNWLu2bDLekbZLkvc4gqjm4rRFT1FYPdPzwBMlgIz
	LaVL0RhCdnvvYJTopulOiiN12iCs
X-Google-Smtp-Source: APXvYqwx12nzsg7FscHEvI1q4vNYXCWPZkrv+w5F819jNAjBLNRu0ySkb7iQS2KCYINkeEZqGHpSFQ==
X-Received: by 2002:a17:90a:8545:: with SMTP id
	a5mr43898757pjw.43.1578328026203; 
	Mon, 06 Jan 2020 08:27:06 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.05
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:05 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:37 -0800
Message-Id: <7fa3ede953971f761d8cafafa37d1bcb65ad6a77.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 16/25] runqueue: Optimise task filtering
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:06 -0000

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


