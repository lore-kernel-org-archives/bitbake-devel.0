Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.7729.1593486553749453318
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=HpXuwO2u;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id x11so7884883plo.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/EVH7edZx88Uj9wc0lkjkgwAc3UX8tdowJ/woHlwvIw=;
        b=HpXuwO2upj5ealmfTt93UTrb57RhM5BUVVUYvmtXPlScr0876KFKB86TWNKUk/W+dY
         pPB5xZyi4I5K30lWzf40FAV+ZomwBA7vQgnk+6+NpzPfA9Q8EJXuO+TYa8vN2px+xoou
         GBQYp983QwI2z247//V7opt3xaLKkVQxupxs8kCt0A3oMqWpeRQwMz7fV34jLMN8WnMo
         1ueGJQH3/EnDVohx1grzr2F4/+4X+uuKVnxIsrV9Edys8upiRcLqWGxgy0dUnFIxOmhv
         XnYV+WvSgJVXlpEkydSLLHHDqUc4XEnHRIq5tQP+OhZ8ES5iTjPoK1WXuuQ8l2AoJnh5
         RsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/EVH7edZx88Uj9wc0lkjkgwAc3UX8tdowJ/woHlwvIw=;
        b=T8quQS8CJ7F9dHMMbka4YK3KOgUEome7gwgCUQmkbsQvuMKdVBjPr8Av0211gKVZUT
         RkDMOHrAVjS6Gg8bVN1SXZqDL+lqMDfynb/Qw36oeMPuIwVtCyBhcdOxznHYNCFUHwjz
         9EQnNcimo/GecOK4uqujEa7fhu7R0mpvo0t5mojseeZ2CZg8+3c4HTY0KMhHRGw/5lbt
         YkoSq2LXVTfmtU0/LUr64kh47ILQMyldKXs3IS0kwqIhAXfY08t13EgpATfJ6qUjtu3/
         JT14ig+L/nNk2I+UzCueHbgZMSBc8cbU8v2QGXy3UkIUhk36TmxyUIKrvevAkwLx/Wr7
         iMdw==
X-Gm-Message-State: AOAM532StUQBBaVrlAE/ZMvBOpNrKeaghT7fVPGWloKa1ijB8Ha/NyyP
	yZDXZpF9aKHXr+26XcCXFL0ZkZZ75LOKqw==
X-Google-Smtp-Source: ABdhPJwGvhTMHnIqoG351UONOK2Kif+8LcmCHkRFbYF1rNzbVuGDg9YpFfWgQxL8AxQT/bS68Ut+9Q==
X-Received: by 2002:a17:90a:628b:: with SMTP id d11mr22160798pjj.67.1593486552739;
        Mon, 29 Jun 2020 20:09:12 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.09.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:09:12 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/6] runqueue: Avoid unpickle errors in rare cases
Date: Mon, 29 Jun 2020 17:08:25 -1000
Message-Id: <c3db9c186bbfeb1442f04b66af9e0c1bb662f83a.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In rare cases the pickled data from a task contains "</event>" which
causes backtrace. This can be reproduced with something like:

do_unpack_prepend () {
    bb.warn("</event>")
}

There are several solutions but the easiest is to catch this exception
and look for the next marker instead as this should be the only way such
an unpickle error could occur.

This fixes rare exceptions seen on the autobuilder.

Also add in other potential exceptions listed in the pickle manual
page so that better debug is obtained should there be an error in
this code path in future. exitcode doesn't need the same handling
since we control what is in that data field and it could never contain
</exitcode>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5ada512d6f9cbbdf1172ff7818117c38b12225ca)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 16f076f3..30cab537 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2958,7 +2958,12 @@ class runQueuePipe():
             while index != -1 and self.queue.startswith(b"<event>"):
                 try:
                     event = pickle.loads(self.queue[7:index])
-                except ValueError as e:
+                except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
+                    if isinstance(e, pickle.UnpicklingError) and "truncated" in str(e):
+                        # The pickled data could contain "</event>" so search for the next occurance
+                        # unpickling again, this should be the only way an unpickle error could occur
+                        index = self.queue.find(b"</event>", index + 1)
+                        continue
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[7:index]))
                 bb.event.fire_from_worker(event, self.d)
                 if isinstance(event, taskUniHashUpdate):
@@ -2970,7 +2975,7 @@ class runQueuePipe():
             while index != -1 and self.queue.startswith(b"<exitcode>"):
                 try:
                     task, status = pickle.loads(self.queue[10:index])
-                except ValueError as e:
+                except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
                 self.rqexec.runqueue_process_waitpid(task, status)
                 found = True
-- 
2.17.1

