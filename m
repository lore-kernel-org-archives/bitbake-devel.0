Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web09.32337.1620656212122152697
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 07:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=gMYYsB2u;
 spf=softfail (domain: sakoman.com, ip: 209.85.167.169, mailfrom: steve@sakoman.com)
Received: by mail-oi1-f169.google.com with SMTP id w16so7744012oiv.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iNOk6XF4utpm6fGbAyAeLnJFmasw8KfvK8Hlh+3KSyQ=;
        b=gMYYsB2u7HwX1AzheIt57NEjId4JD1KEndWzjA4BfqGWM1Gh0mvwGxQk8tXm30hJ1/
         d9EuUJurIBZJ0dI2rdxztDv0SGjvq/ewqzk5hQ13N2h2/JxrkyjswCeimavwtbgjNwpD
         DFRY3SROXrT3YdvOJAkDXVbDeHS2CGm5oYeXwY9ihjbow/jJvB9d2mQL8XSILEwLyVJJ
         RriVgvZiQe1nDt3MgWIzMC4JEXu5Vi0sLtfyQCSYCKcexpe7oiZm4lMMiKQAdEeIFqW7
         ZbqEjsx24mIYYIvnucx2sm1VStrfxvHHBEXXDSyN8W16V6Inq5IMgr6rwiXnRa5eBPAE
         i5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNOk6XF4utpm6fGbAyAeLnJFmasw8KfvK8Hlh+3KSyQ=;
        b=k1ISesYAv/sr14PJajxE5t6vpuM186AShk3cCIgUVFT2HZ8+3sIr5ucJsxDQ0cpAFT
         7Gq1C0k2Tu+/+h4orzejNpr71/J+YkD/JZTpCXgjJInIBLhdvH2HYZ+bHTGCvrSIsHSj
         J3+HFWinKGtgo+z87Waz/Cql4e+WHnpEF1mKinpcrbSlVzlxGgEJZLfFZ1Hbh3W1roo6
         4WxUTD+rOhtYrmtmkRrV3yRXeZSpcnRBCM9NJaOSthuYaeU1zyETt4Fr1aZaGBialFNz
         ufu3b/nHHhDeMbBEEnKa0c6ZbkjJlxNiI8a9BVYfaYkp7f8rICfDUbTBQVwpbM99Exoe
         D8yw==
X-Gm-Message-State: AOAM532ZJTmOmXcSkh/M2s9v4g3DAQSuJxeoiTdjJoIoS/Ug7P4hprOm
	NootrAE/TXk5ijEpAHX67xFSoCrmp+Yk2uaNMpg=
X-Google-Smtp-Source: ABdhPJwI5lg0wHHdORGOijF0SsUlUjWkaSeMh1Gj2Lh8DpP6B/F6yahHwEjpjoHBKCB/K6vYe5u+OA==
X-Received: by 2002:aca:ad48:: with SMTP id w69mr17741793oie.21.1620656211048;
        Mon, 10 May 2021 07:16:51 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id g106sm2401303otg.77.2021.05.10.07.16.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:16:50 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/4] runqueue: Fix deferred task issues
Date: Mon, 10 May 2021 04:15:18 -1000
Message-Id: <99fa63415cabf3129f149c2cdb557ec18b06b98a.1620655927.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620655927.git.steve@sakoman.com>
References: <cover.1620655927.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In a multiconfig situation there are circumstances where firstly, tasks
are deferred when they shouldn't be, then later, tasks can end up as
both covered and not covered.

This patch fixes two related issues. Firstly, the stamp validity checking
is done up front in the build and not reevaulated. When rebuilding the
deferred task list after scenequeue hash change updates, we need therefore
need to check if a task was in notcovered *or* covered when deciding to
defer it. This avoids strange logs like:

NOTE: Running setscene task X of Y (mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch_setscene)
NOTE: Deferring mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch after mc:host:/A/alsa-state.bb:do_deploy_source_date_epoch

where tasks have run but are then deferred.

Since we're recalculating the whole list, we also need to clear it before
iterating to rebuild it. By ensuring covered tasks aren't added to the
deferred queue, the covered + notcovered issue should also be avoided.
in the task deadlock forcing code.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3c8717fb9ee1114dd80fc1ad22ee6c9e312bdac7)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2bb97b6e..2d35d478 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2789,6 +2789,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
     sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
 
     sqdata.hashes = {}
+    sqrq.sq_deferred = {}
     for mc in sorted(sqdata.multiconfigs):
         for tid in sorted(sqdata.sq_revdeps):
             if mc_from_tid(tid) != mc:
@@ -2801,6 +2802,9 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
                 continue
             if tid in sqrq.scenequeue_notcovered:
                 continue
+            if tid in sqrq.scenequeue_covered:
+                continue
+
             sqdata.outrightfail.add(tid)
 
             h = pending_hash_index(tid, rqdata)
-- 
2.25.1

