Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF10C433F5
	for <webhook@archiver.kernel.org>; Mon, 23 May 2022 14:40:35 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.28421.1653316826454011794
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=gzt6tq6D;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id ev18so14258119pjb.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s8GBFl5L+MwDIirSZdicdf5LuYOTzU5QrXxXTpov5sk=;
        b=gzt6tq6DIKj9BHquJyvrsse9FkR1gJb9pdEO7P6waULxvOVKcnYv+j+Sem7MwUMdzp
         CPP+T4iCzUcudsPeOlz7zely8+UmjlBt4HMVznOkZKA35Er5gS9pVXU6ypflV73A299c
         WEeXuLG331IJkuga4Fj5frJ53XuxwvN12QUjAQU7TMEPog3shfZ5YjXYJ8j/AfUnXY2J
         +86nQCayknFYbR+xDDVAbm8lcaHuGC8Naw91R9qojw+CDxV+8v1Bmbg7EpTLzfhYW4m5
         SoYYfTf/6LEbwLFBJTFeLUBrbdIUDGJJRhjYpU3Oqyc3X0cpx0Yt56IC9webC9Fv20cM
         XR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8GBFl5L+MwDIirSZdicdf5LuYOTzU5QrXxXTpov5sk=;
        b=CEMOdvXCdfE1S8CiZA/5cCnrbroDsKhu43pHQH55XpFOiaX/bq+lQo4W7Qm9xBZ4jb
         +r58f2oDooutNT/gzelfpK9gMtSoNyaxmyIrZOf8VRKLyiiqjVAN0nLYK/VtNtD6jlYR
         HmA1ce2skUu6PBezgqrjvKxZpZtAwPXyFWu5WjXBgVRIpu6PYqOLq9BkfvkiQFPqLCL/
         8bXyo29CAJI5rUP63ag2+0iZxJPmSX4maxe0tZb9bdfV2hVLNCZYWqKQNuEIWqET5QVE
         7QUVSGajQAlz0ZulUFG7Hcc6NGsTDOMIZOUY+Q6MaOhDIj51hlj9kg93WEmeDFuEkboJ
         U1dQ==
X-Gm-Message-State: AOAM531m6VlUZJlrqTXNElsh5vvzugXVXHWnuT5+3B4biE/6OyhePLyF
	j68TiftAJXQtPO1X/lPZ5JcUAYR4J4ZnATI6
X-Google-Smtp-Source: 
 ABdhPJzqrCNaaVOce2JyLzk8eFtg0K4SeygEu17Koyr0Gq3JZMc1LLTL3Y2YI6QlYTo3HG5gIArXoA==
X-Received: by 2002:a17:90a:bb10:b0:1e0:383b:de80 with SMTP id
 u16-20020a17090abb1000b001e0383bde80mr9041796pjr.67.1653316825262;
        Mon, 23 May 2022 07:40:25 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 u4-20020a655c04000000b003c14af50623sm4865576pgr.59.2022.05.23.07.40.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:40:24 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/3] build: Add clean_stamp API
 function to allow removal of task stamps
Date: Mon, 23 May 2022 04:40:05 -1000
Message-Id: 
 <4a7e44faaf2c4060ea54491f4dd20c83c538648f.1653314792.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1653314792.git.steve@sakoman.com>
References: <cover.1653314792.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 May 2022 14:40:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13710

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We currently have no API to be able to remove all the potential stamps of a
task. It is unusual to need to do this, particularly as you could race against
other things happening in the system but we do have a use case for this in
cleaning up sysroots in OE-Core. The alternative is to mess with CLEANMASK in
OE-Core but that is just going to add potential for errors.

We need the first part of the make_stamp() function so separate that out so
it can be called seperately.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4d671504a25863018ac51c21c005cef0a4d8f05c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/build.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index af60c3d8..55f68b98 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -835,11 +835,7 @@ def stamp_cleanmask_internal(taskname, d, file_name):
 
     return [cleanmask, cleanmask.replace(taskflagname, taskflagname + "_setscene")]
 
-def make_stamp(task, d, file_name = None):
-    """
-    Creates/updates a stamp for a given task
-    (d can be a data dict or dataCache)
-    """
+def clean_stamp(task, d, file_name = None):
     cleanmask = stamp_cleanmask_internal(task, d, file_name)
     for mask in cleanmask:
         for name in glob.glob(mask):
@@ -850,6 +846,14 @@ def make_stamp(task, d, file_name = None):
             if name.endswith('.taint'):
                 continue
             os.unlink(name)
+    return
+
+def make_stamp(task, d, file_name = None):
+    """
+    Creates/updates a stamp for a given task
+    (d can be a data dict or dataCache)
+    """
+    clean_stamp(task, d, file_name)
 
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
-- 
2.25.1


