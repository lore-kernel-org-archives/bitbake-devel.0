Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CBC433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 14:11:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.8781.1634134299118887803
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=icusDCs6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id r7so8877631wrc.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zmxyOhlOWYJSb5nqYRbmOPzxawid1e4NDjhsfZFaF4=;
        b=icusDCs6130KaSSE45DALf0EOrmmgsIX0tnZl6oripgXsKNYK+PxBD7AJfnIvUF1/U
         /MiPYWUd3WXJ3VUl2O0HL1YG5cETwIczWIcNlvy5H+5iSqo9Q/eg09XFqDdqZtuskeli
         VQGIzts4JaZeFNlwYtuSqd6WgX09DdXsh1Soo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zmxyOhlOWYJSb5nqYRbmOPzxawid1e4NDjhsfZFaF4=;
        b=TX/4Q4bSCk6E8QeY5QxI4fnsRbK6u+B1iiHK2Jmjvlbg0L3fh2pk4HAGYtElKJf89i
         l1oMddsMznpWQpGdKRTXBqQVVzKQtz8HJLI30ktcscJWGkR0fBxJ0fOz0eXUCdV9L+sE
         Ow5ySJzz+VQkaATZ6YkGQkVa3fiZPCEZhyVen9cEf3jMYCWRWdoM46MrnR5P/hAlfy56
         NOs3wy6sVPSPYYhZQUwxpBdeqGDgjiq3/oXY/r32PDLDYxvh08ngPmvh6sDKJ++TTMmZ
         ZBjao+5PSFA+DvBFxJ8/CqxEG9i/W1SAOYgMd8pxGJsHWbV2npxnFZE0fZhcr+DZCNW2
         jOJQ==
X-Gm-Message-State: AOAM531CJQ4lp7gFNwbS3lFWmgmVNijiMX81KdRw+4rFm4P0TKx7nmY/
	DdWhpd4r4ALrRcDUxMsMhTwOl/0QYV7HiA==
X-Google-Smtp-Source: 
 ABdhPJzm8D4/BZdC3HIrdO+8DfL2v1nkit0OX1j0pCtNdvE9yiBLxlVM8QgY3AoFagp/pKYY3RcUvA==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr3835901wru.14.1634134297272;
        Wed, 13 Oct 2021 07:11:37 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:65b2:89df:e6ae:44c4])
        by smtp.gmail.com with ESMTPSA id
 p11sm6152429wmi.0.2021.10.13.07.11.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:11:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker: Set BB_CURRENTTASK earlier
Date: Wed, 13 Oct 2021 15:11:36 +0100
Message-Id: <20211013141136.2870128-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 14:11:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12766

For some debugging, BB_CURRENTTASK is set too late to be useful as
it isn't present in some event handlers for example. There is no
other way to know which task is actually running so set the value
earlier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 1 +
 lib/bb/build.py    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 6a12e1fed2..c8eb65567f 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -237,6 +237,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
                 the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
+                the_data.setVar('BB_CURRENTTASK', taskname.replace("do_", ""))
                 if cfg.limited_deps:
                     the_data.setVar("BB_LIMITEDDEPS", "1")
                 the_data.setVar("BUILDNAME", workerdata["buildname"])
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 7e4ab9f64c..d6418e40b3 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -569,7 +569,6 @@ exit $ret
 def _task_data(fn, task, d):
     localdata = bb.data.createCopy(d)
     localdata.setVar('BB_FILENAME', fn)
-    localdata.setVar('BB_CURRENTTASK', task[3:])
     localdata.setVar('OVERRIDES', 'task-%s:%s' %
                      (task[3:].replace('_', '-'), d.getVar('OVERRIDES', False)))
     localdata.finalize()
-- 
2.32.0


