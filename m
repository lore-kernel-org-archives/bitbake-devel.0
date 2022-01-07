Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC3C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 23:15:31 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.977.1641597330384007669
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jan 2022 15:15:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KjsIdZ3r;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id
 o7-20020a05600c510700b00347e10f66d1so209074wms.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jan 2022 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rmRGr1GfDihraMWK3JFW7z8A7hZcjRypOBZr4UErL1s=;
        b=KjsIdZ3r8VJ0dzn9syJo2bQeGCtbyv2tKvm12zw4oVQlaCbttqp2Pv6J8BeEM603zU
         7EGHXDMLdsd+fCZEKggpI1bXo3J7Y+XxXDa+9+zXEoayyeOWCrPKfPbr0XF4owjZ6IEl
         BewV44ija+mpL7bBRDbtdhx7GxjRxcv0DMXQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmRGr1GfDihraMWK3JFW7z8A7hZcjRypOBZr4UErL1s=;
        b=uGxAfvXO9pxUlksRHsOA3e+BOf2H9HEJD7AHlUHjb1jyvCIGma22o/tItg40QrRWAD
         4b26AFRAxRrj/Yv0gv2cRSpqW6FFgoWAeNpIUthd8stx998jBR2yueLmp+9CeD89FC5Z
         6vmb+iin23VIlPyS79ESdwvKhSlUKwUVX28nU16RG8T3054S44cuMcpn9Mm+14hjN+E4
         gTenrccfcK1OaYzogbId9mEebv58QYj6WJXbItrlVCtoJmoDLvIUqnJEs+hBhtF0qpqW
         hXWfendKvLc+vzFc8kIEV1/DNlAV5X8iHF02JwGswD/kJbY2YHY+6adf3hbYX0jHaIcG
         djJw==
X-Gm-Message-State: AOAM531cXEmCNfy6QLs+us2rJ66A6GeIyr2ijH7sBzC5Rpr2Lu0f8rxt
	0bxc0fLeWIKzzPCDIjdIRxPDwuDDPNUsdA==
X-Google-Smtp-Source: 
 ABdhPJweXXcCgf+apPUmm/MKKO7cn4CqDOZNoUETIVIpgi91Xc/HGMShFc+wWkfbdsciqorjkqx0Mw==
X-Received: by 2002:a05:600c:4f0d:: with SMTP id
 l13mr13063743wmq.122.1641597328928;
        Fri, 07 Jan 2022 15:15:28 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9055:f73b:1aa9:bf82])
        by smtp.gmail.com with ESMTPSA id t6sm45147wry.84.2022.01.07.15.15.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:15:28 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-worker: Add/support network task flag
Date: Fri,  7 Jan 2022 23:15:26 +0000
Message-Id: <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Jan 2022 23:15:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13225

This patch changes behaviour. After this change any task which does not
have the network flag set will have networking disabled on systems that
support that (kernel version dependent).

Add a "network" task specific flag which then triggers networking to
be enabled for this task, it is otherwise disabled.

This needs to happen before we enter the fakeroot environment of the task
due to the need for the real uid/gid which we save in the parent process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index bf96207edc..3aaf3c2444 100755
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
 
+                if not the_data.getVarFlag(taskname, 'network', False):
+                    logger.debug("Attempting to disable network")
+                    bb.utils.disable_network(uid, gid)
+
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
                 exports = bb.data.exported_vars(the_data)
-- 
2.32.0


