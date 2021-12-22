Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9CC43219
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 23:19:12 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.26491.1640215150873732758
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Dec 2021 15:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FmvEJ0dM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id s1so7921061wrg.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Dec 2021 15:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RaQOt+Ve6miinDxe9J9zw5NZ6eAeI36wNd/OD1302GQ=;
        b=FmvEJ0dMhnH5jR9wacmv/KrJB1CEVyuijaN1Ah/VRnkVQ1bFXKwDOWSJk533C/3Dym
         07W20HqWKeWgW4LOq6rCnwM6py8kXmKdE6+hKiCYg7v2CkQxXApmw63PCsk1caLuqQ/G
         wYRirmvqI85gTv6Gth4LBq2vjJfMwWuIS//2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaQOt+Ve6miinDxe9J9zw5NZ6eAeI36wNd/OD1302GQ=;
        b=HwqlnPgIQoNXxAvjYxmgn69zJAJg/tW340FEXh96H7lvSm7Q5ilWQ+lV/NsWsrQo8u
         NvEQ1eeXPxmC5I6Hwm6mTr9cH4oRP520rTSpnG6tLlUuYe4UQojoxxUfsy+szzzZmlSD
         h9F4HeQP5bkbPolgMpVP/1S9XZcJ7SDzXGTYC4QwUwUkGrJ9xRKT91Eef5gbkGbn/Lcy
         qnrytSO7N2uIQMQjkV/Glb5G0a8WQJhAagaruS2NU0q9nZylilD3TYNB8UotvMFiF9IF
         x5PE73B42c5WjRFJOoA/sP9eBo0iBzKAw/0qM3IUWm1XQGYaNuzrneS2F2B92SBUyZ55
         kCMg==
X-Gm-Message-State: AOAM5320C+SWtoFzM5foFrfAKlnT+yMo9QD+PVhQfBl0MCaQNSc3lg1f
	Qdm6Yrw/osDXo48J6TvIWXcN+gy+19teUQ==
X-Google-Smtp-Source: 
 ABdhPJxKv6FbKvAFuzVYzbhA3avzh6RLurIvjQT4Oyk8eZcv6313X+OKD2DZ2ZKywydeX1TsRZ5rPw==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr3427938wrf.436.1640215148454;
        Wed, 22 Dec 2021 15:19:08 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:1853:9343:6af4:2b3f])
        by smtp.gmail.com with ESMTPSA id
 n1sm3504768wrc.54.2021.12.22.15.19.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:19:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-worker: Respect nonetwork task flag
Date: Wed, 22 Dec 2021 23:19:07 +0000
Message-Id: <20211222231907.1036709-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Dec 2021 23:19:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13200

Add a "nonetwork" task specific flag which then triggers networking to
be disabled for this task.

This needs to happen before we enter the fakeroot environment of the task
due to the need for the real uid/gid which we save in the parent process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index bf96207edc..32d4f58655 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -152,6 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
     fakeenv = {}
     umask = None
 
+    uid = os.getuid()
+    gid = os.getgid()
+
+
     taskdep = workerdata["taskdeps"][fn]
     if 'umask' in taskdep and taskname in taskdep['umask']:
         umask = taskdep['umask'][taskname]
@@ -257,6 +261,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
+                if the_data.getVarFlag(taskname, 'nonetwork', False):
+                    logger.debug("Attempting to disable network")
+                    bb.utils.disable_network(uid, gid)
+
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
                 exports = bb.data.exported_vars(the_data)
-- 
2.32.0


