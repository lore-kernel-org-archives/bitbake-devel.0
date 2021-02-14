Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.15864.1613302756140172965
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Feb 2021 03:39:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HnbnavzX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id j11so3715611wmi.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 14 Feb 2021 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRPL12nBq7xYaZjpRz0iPJpbvDKLUZMoe1gJC5/YkoE=;
        b=HnbnavzX5EQJAe5KUuHuXHCnltQVflPqSfInywKBVlbVP69JTLGSfUhjd2KKehCjtN
         3K9ra7xS6+sJdyNU9GTA+wbmoAETg8tJlykW6xBl/lX7cqaHlLYYIKTR9D+jf53E7R92
         Fg6mpTAM13k2GFB9YGkfFnp0Kv/OA0n9mq5TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRPL12nBq7xYaZjpRz0iPJpbvDKLUZMoe1gJC5/YkoE=;
        b=D23FK37uK4TX7NRvwvew/L2aEwXYsn8n1OdhSL0nXGH7odpNcP6Wh64H1TUP2FBPzY
         rVlqysrvXlXfX9i7x9Krx1zwb1TCiv506WySVCOh2QAsOhsV1HfwkLFn+edQPD9Be5Ax
         rCN0PmUvofmYRbjy0TbmMQeWXowpKzAZPO3IE95dXEi97eZ3EG11oEY1AEqXhgNolZJY
         aQ1GoIccwtJcA/89mbsxpjBTnti8XgBzfjJf/7kLb1wz9NLdLe8hbmOVaw9X/Pd8YB/O
         Wgkx+NcbKiDxkVSPW8jJIdKLdCGWkGvehgzAic0v0W1/3/YS94tGZOOOkyxkQFezVf/N
         TGhA==
X-Gm-Message-State: AOAM533UOtT39rDv/PiWdiILdYtbcd5G/vw0z4U9lLs5skdi837jWRwT
	tJiob6SJn2yFNiSCWB7YZILzkjY0Wg2lpA==
X-Google-Smtp-Source: ABdhPJzucynG/clz8gzz50surOkn4Kjj8ZqzW+NF7cJIUnSV34utf8QcvwGiL2J5OgY+mjjQGMb73g==
X-Received: by 2002:a1c:3cd6:: with SMTP id j205mr9966668wma.166.1613302754542;
        Sun, 14 Feb 2021 03:39:14 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6c46:cb67:3902:3f00])
        by smtp.gmail.com with ESMTPSA id a17sm23654683wrx.63.2021.02.14.03.39.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 03:39:14 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker/runqueue: Add support for BB_DEFAULT_UMASK
Date: Sun, 14 Feb 2021 11:39:13 +0000
Message-Id: <20210214113913.1960305-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently each task has to have a umask specified individually. This
is leading to determinism issues since it is easy to miss specifying
this for an extra task.

Add support for specifing the default task umask globally which
simplifies the problem.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker                                        | 8 ++++++--
 .../bitbake-user-manual-ref-variables.rst                 | 4 ++++
 lib/bb/runqueue.py                                        | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 6c37967513..7765b9368b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -150,11 +150,15 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
     taskdep = workerdata["taskdeps"][fn]
     if 'umask' in taskdep and taskname in taskdep['umask']:
+        umask = taskdep['umask'][taskname]
+    elif workerdata["umask"]:
+        umask = workerdata["umask"]
+    if umask:
         # umask might come in as a number or text string..
         try:
-             umask = int(taskdep['umask'][taskname],8)
+             umask = int(umask, 8)
         except TypeError:
-             umask = taskdep['umask'][taskname]
+             pass
 
     dry_run = cfg.dry_run or dry_run_exec
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 74a3eb8095..a0c56a4bc3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -108,6 +108,10 @@ overview of their function and contents.
       command line option). The task name specified should not include the
       ``do_`` prefix.
 
+   :term:`BB_DEFAULT_UMASK`
+      The default umask to apply to tasks if specified and no task specific
+      umask flasg is set.
+
    :term:`BB_DISKMON_DIRS`
       Monitors disk space and available inodes during the build and allows
       you to control the build based on these parameters.
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b8b217c64a..54ef245a63 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1271,6 +1271,7 @@ class RunQueue:
             "date" : self.cfgData.getVar("DATE"),
             "time" : self.cfgData.getVar("TIME"),
             "hashservaddr" : self.cooker.hashservaddr,
+            "umask" : self.cfgData.getVar("BB_DEFAULT_UMASK"),
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
-- 
2.27.0

