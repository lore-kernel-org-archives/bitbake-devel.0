Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.333.1616175015382368427
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 10:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d2abjMt0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id g20so5880421wmk.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Mar 2021 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ7M1RNk13tqhVGXnyBhiOG1SZRmLUo4jYBuKCMVrs4=;
        b=d2abjMt0mY7B1Dx7fQepZiYHqUkWdYC3ejxhrknwkUouxGO/7WYlUEZLdByHE+5qPf
         qf8RDH5n+u7XQUapiuQrlGEvQD4Zp19aRJJAaxZP4oMBI7X4RXXrHGOcnwcOTBt1zdln
         coT4xry9LOzp+uPo6QP/qXCwMOG5wixlZwock=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ7M1RNk13tqhVGXnyBhiOG1SZRmLUo4jYBuKCMVrs4=;
        b=hGpKOWATjawIneQwZSlqPZKsn3cGQxM7D8oGhgcRuNFYEoe2YLJP9KJU0dSNhcpPMi
         x/kPZlfnruJHrXYrc+ud9LepezIAlgAH4yxAvhE+ipdZZT9o+urHJFtywLgmVqjUnqAk
         XCLDcVLfOFPYEk85aKyWvagG3cCc1GR+7AbfP7zqQj0GWuAiJeIhxEXnyb94Rea2NQXs
         D8eWjokspENjBwDnyzLmyENJVNq2J3bnE9rsGwr7qdj47DwLENrB+aKGwbFoYrARmBPZ
         mADVBp+H2o6Iu5BnPX9JQspgPqNGifiDS6ckjFn5P3Sulgds/IAlePLKZ5mRzO9zfslO
         Qudg==
X-Gm-Message-State: AOAM531E3SMGifO98iK7waU+g7o6Sv5zZHoDJoXNUB5v6cutW5IXgJVx
	4BjXzJ6tgsrOTk9T80rW6UOPB/W3+E3UYQ==
X-Google-Smtp-Source: ABdhPJwWXqh4+7/zxXh7lw+XreFWCeVn1Qop0NhAozjdmMLR/WiwqNTPS+SwFhT3myYQKRvNmOiETA==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr4763244wml.7.1616175013792;
        Fri, 19 Mar 2021 10:30:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5808:8e52:d330:3893])
        by smtp.gmail.com with ESMTPSA id x25sm8537852wmj.14.2021.03.19.10.30.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:30:13 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] build: Add file_stale_stamps function
Date: Fri, 19 Mar 2021 17:30:11 +0000
Message-Id: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function which compares the stamp filename we want (including
taskhash) with what is in the stamp directory (using the clean mask).
This tells us which stamp files are stale and are due to be rerun.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index f4f897e41a..b2715fc530 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -854,6 +854,23 @@ def make_stamp(task, d, file_name = None):
         file_name = d.getVar('BB_FILENAME')
         bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
 
+def find_stale_stamps(task, d, file_name=None):
+    current = stamp_internal(task, d, file_name)
+    current2 = stamp_internal(task + "_setscene", d, file_name)
+    cleanmask = stamp_cleanmask_internal(task, d, file_name)
+    found = []
+    for mask in cleanmask:
+        for name in glob.glob(mask):
+            if "sigdata" in name or "sigbasedata" in name:
+                continue
+            if name.endswith('.taint'):
+                continue
+            if name == current or name == current2:
+                continue
+            logger.debug2("Stampfile %s does not match %s or %s" % (name, current, current2))
+            found.append(name)
+    return found
+
 def del_stamp(task, d, file_name = None):
     """
     Removes a stamp for a given task
-- 
2.30.2

