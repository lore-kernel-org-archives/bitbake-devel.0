Return-Path: <iuliuv@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D9CFB424
	for <webhook@archiver.kernel.org>; Sun,  6 Oct 2024 14:55:36 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.32405.1728226533577514974
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Oct 2024 07:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LOqAdNpt;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: iuliuv@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9950d27234so46201066b.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 06 Oct 2024 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728226532; x=1728831332; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlRHxgFMCpsXJMyur/HABNSToSjDAl9feSi52AvV6+4=;
        b=LOqAdNptxDrPXpt3ASbcnA28kVEH9k8StzIg+FQTceDFxpS9GuH4mleAOnO9L6PSXi
         D+Ou/meggEhmK/TLY8ZCQan/Wts3haNzDPv6BDJZtRJ3wAdhZwNSsTmYZaX/IPOBXEAN
         /uvNvoX2Oma36d90DeYxxwWtqSJ+3eiAlqdYlNymhYwPg+T9tbUMxFtAYY33YY8yBYNh
         yKRgVmkY4sI4xAKrudLH7kfZhRdjNlHhN6SDyi++5k2Wad2FsF2eDnjaH3jTSuUrh2hG
         R9ks4uJp8ncJDOftCz2e4eJKwiIQhQI4+25HfhY+Re6TFQheNcE9th+pmqkGw42Imiyu
         unAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226532; x=1728831332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlRHxgFMCpsXJMyur/HABNSToSjDAl9feSi52AvV6+4=;
        b=djZgCjcyf7mFQWLoFd6Vz55fjjPK6C/LM9y9EC8HcvllVsWmveLIcgLI2aMvBnGhtw
         GEuLMtZiH7oPaahKapGSyWpr+zf2BbTjBgkLW8j6hJpmz4dpIA4bvBxM8eQKpk1zIYPG
         OoBCkY7tNjCfbUaUPG5KeaSbxaJGYFXHHPSoZYizY/4KGzIzGsrEQteh6C70CH/Uze5B
         3dp+TSgx5xTWk+YrCsdObdqRM2boIQfwkWXZezSmC/pb1OUygzjkXLn9oSBE0T4GY/h8
         z1Zu4/cu9FE/7L07Z9jl2o2x0ECvLxXHwX8a48lIMEMAm/x2rHz51OJyUFzUS1oQ0XaU
         IsDg==
X-Gm-Message-State: AOJu0Yy+d36coEcUJ/XeXhy+ubh6yY79kvmaGyAlYFp4G2AB80QQ7yM2
	QbS7LhrZNnuYPTy8Bk9NzHQhxcTQxtlqnYWS4jO6Z4X+WyjCclOBN0vWFg==
X-Google-Smtp-Source: AGHT+IHDIbJ+z4koSKyp++GovkjDPH8fuZATXtAPE5M2qM/tFDgo6aaH6bZsqErFNmrRT3GOuEH/lg==
X-Received: by 2002:a17:907:9802:b0:a99:4e07:e6c3 with SMTP id a640c23a62f3a-a994e07e991mr193488666b.8.1728226531545;
        Sun, 06 Oct 2024 07:55:31 -0700 (PDT)
Received: from localhost.localdomain ([95.76.139.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a7cfcfcsm212753166b.143.2024.10.06.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:55:30 -0700 (PDT)
From: Iuliu Vasilescu <iuliuv@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: iuliuv@gmail.com
Subject: [RFC PATCH] bitbake: allow -C to accept recipe1:task1,recipe2:task2
Date: Sun,  6 Oct 2024 17:55:26 +0300
Message-ID: <20241006145526.64190-1-iuliuv@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Oct 2024 14:55:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16645

Previously a command such as:
bitbake -C fetch recipe1 recipe2
would invalidate fetch in both recipe1 and recipe2 before executing
the default task in both recipes. Finer control may be desired in
some situations.

With this change, a new format is accepted:
bitbake -C recipe1:fetch recipe1 recipe2

which invalidates fetch only in recipe1 than executes default task
in both recipe1 and recipe2. Only tasks in recipes presented in the
list are invalidated.

bitbake -C recipe3:fetch recipe1 recipe2

would not invalidate anything before executing recipe1 and recipe2.
This behavior is up for debate.
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 9 ++++++---
 lib/bb/runqueue.py                                    | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 35ffb88b0..cce6097ea 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -373,9 +373,12 @@ Following is the usage and syntax for BitBake::
                            be 'compile' or 'populate_sysroot' or 'listtasks' may
                            give a list of the tasks available.
      -C INVALIDATE_STAMP, --clear-stamp=INVALIDATE_STAMP
-                           Invalidate the stamp for the specified task such as
-                           'compile' and then run the default task for the
-                           specified target(s).
+                           Invalidate the stamp for the specified taski(s) such
+                           as 'compile' and then run the default task for the
+                           specified target(s). A comma-separated task list is
+                           accepted. The tasks will be invalidated on all the
+                           targets, unless the tasks are specified as
+                           target:task.
      -r PREFILE, --read=PREFILE
                            Read the specified file before bitbake.conf.
      -R POSTFILE, --postread=POSTFILE
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3462ed445..a9ead0d10 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1251,6 +1251,11 @@ class RunQueueData:
             for tid in self.target_tids:
                 fn = fn_from_tid(tid)
                 for st in self.cooker.configuration.invalidate_stamp.split(','):
+                    if st.find(":") > 0:
+                        st_split = st.split(":");
+                        st = st_split[1]
+                        if fn.find(st_split[0]) < 0:
+                            continue
                     if not st.startswith("do_"):
                         st = "do_%s" % st
                     invalidate_task(fn + ":" + st, True)
-- 
2.46.0


