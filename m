Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id C37C76057A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 21:15:53 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id vz6so2582596pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=wA/Scl8e19Lc22W/ZehmJZsLpfHe4kLgB/c3K6zusGg=;
	b=wuUGzHvbCg4JBs/YtpGOr0tiIW1TPeENbIxqHn0Zeh4hdCOGZlELJcdzUsFioVyV8M
	QEQd1ZPcI8rT9Hpk1g09fhtyrgeemtQQYEYLiii4fPPtrb55YjcmeybA6wk/hYBXxBED
	SmdGNZl4qG841qtrhl023ldYQuJ/lvqmGJVSkvEX5DwDJg8DB7IHwKIKUu9j1TFyiLUy
	15M9AeDgrIReG5ZZTkA0uHOrnCUhEqpsOY+zZurf3m5wBfk53Sn3ZsQkwXFSOdKhTC5c
	eC0WOM+oM2p/9A8yO7y3v7Tf/2tSJbHbRsHDgSoO+kQNa5/Oug1JZdVvt6FXvFfeygSi
	LGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=wA/Scl8e19Lc22W/ZehmJZsLpfHe4kLgB/c3K6zusGg=;
	b=DnUI4P53+NtiKCw/gRY+lsMzcX4vrVrR2byvhKtQ+cHeWu/5Ib6sQvKBMiozUI6SH+
	/OQ4ZSGw0SmtD7/CsJ+sF1NlcHqZJPdhjn8cV0M1HKCogB0MYJeY7zj+atM5HUT3HsyI
	+OINw0Fct6kBtY3IbmuIdX+6HlJwPD5tuCzhTTzkdVz4z+Nv42o7ylhChPymw6vM8lU6
	/Ol4wzX4wA7xbZGyNBRFdwZyUjRmXU8fWKRPSmyTOrsc0cU4bkK+cNs4q5hLvT2JdDAk
	ZFP4oq8x5r3PxsxKGLFWreRyZ56/GRrThaY/CKprqNdgKCX00RDpR8QnRcbWQ94fBvF/
	gmbA==
X-Gm-Message-State: AE9vXwMgi5uKMAIaA6CpPQAKFOolWwqTULrczd63m8IHOhdLQP5Shz8h25t97+b5AscDmg==
X-Received: by 10.66.158.10 with SMTP id wq10mr17899986pab.2.1473974154138;
	Thu, 15 Sep 2016 14:15:54 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	ps2sm7115880pab.10.2016.09.15.14.15.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Sep 2016 14:15:51 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 14:15:46 -0700
Message-Id: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] bb.build: in _exec_task, move TaskStarted into try/except
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
X-List-Received-Date: Thu, 15 Sep 2016 21:15:53 -0000

From: Christopher Larson <chris_larson@mentor.com>

We want any exceptions raised by the TaskStarted event handlers to be caught
by the existing exception handling, rather than unconditionally hitting the
exception formatting + traceback in exec_task, otherwise we can't cleanly exit
the task with a nice message from such a handler.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index fcf0149..28401b3 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -560,8 +560,8 @@ def _exec_task(fn, task, d, quieterr):
 
     flags = localdata.getVarFlags(task)
 
-    event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
     try:
+        event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
         for func in (prefuncs or '').split():
             exec_func(func, localdata)
         exec_func(task, localdata)
-- 
2.8.0


