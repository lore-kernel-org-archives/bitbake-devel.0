Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
	[209.85.214.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5C7497F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:58 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id c23so6704452plz.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=rSTHOK7XIpdGSYz7Y/UA729Ez1sTcfhNRA3va657buU=;
	b=m0z3NL+PMxXXbJGq0YA1BHt9kZRNRQRR/O0qo3DK2L7g/Lm5St/Rga5jtiEuyB5oJ9
	HrjzhTL4wkOqPaBwCwPN+QGa+fXQbql1OZ4wUnz04IZi6Mw1DUuaagg7K5vaL0inJ8OH
	i7O9x8FEj7mOIdAiAcf1z4rG8BmNGUl7awGQ54oWkI5JoOUeQxX8WBhXPb/itLzaPOiK
	wNQ6cO+VnkpQ0z/AjTOnrVALZ2+7f0yGbUVL8v1LdUAcVdIwpgU62ReDbPejKa7CERRD
	8NISkyZOZ6A4afetwmC+MBXpTZDWOVa1Wkpy/g44Si0iheVSyGQF9pdUI1/waSLlqBgH
	QlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=rSTHOK7XIpdGSYz7Y/UA729Ez1sTcfhNRA3va657buU=;
	b=P3XZRywpOzczvxdEN5UwsrSAKRyZmie+nTqR6rpm61KEOwqKxCJHSJitcD9XoGh+d1
	XELksK6z8w8SAtFUJjXsVbXUT8NG7eEqZSoQnR/Mb/bqcCe8uozP3wm2Q2ry7cbwxQR4
	3WnlTaCaotGGyo+ztpa9K1YUu5GjWfdzHGmQSMHyUr4B8xOxgZkAV9ALWZVlSYL1Z5ka
	dbbCX/Ksw+heOXZWEzbPsQKpKi7WdiWjIqMU6lICBttjU9309rbJcYnQyYEVDkFWef7P
	+QGPjq02Z57YRJngtfr9TGObJwwarom8GvZcZmofzpA/NaNQ6gpyJ2W4bM//3kqJ/GhU
	YjkQ==
X-Gm-Message-State: APjAAAUmkt1y8k5St69ygWkAMBlb+lXKG456sfhBmhoLcCXxrpHl1Hdw
	Gty6hfQAd9FVV1T+vEYmcaYYHbj7zIw=
X-Google-Smtp-Source: APXvYqxWhIsDcdObw2Axa0DiZUI6CM7sU/Z68MwzlVrBCc9mZqZTCSEA+ZT9F45pd3MBfj9BCqs7TQ==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id
	b44mr32898790pjc.9.1577076659348; 
	Sun, 22 Dec 2019 20:50:59 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:59 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:40 -0800
Message-Id: <7fa3ede953971f761d8cafafa37d1bcb65ad6a77.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 16/18] runqueue: Optimise task filtering
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:58 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We were seeing this running thousands of times with hashequiv, do
the filtering where it makes more sense and make it persist.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2cfeb9998a8ad5b1dcda0bb4e192c5e4306dab17)
---
 lib/bb/runqueue.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 73775d9..b90ac87 100644
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
2.7.4


