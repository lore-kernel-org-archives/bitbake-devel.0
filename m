Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.15770.1599301770295315700
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Sep 2020 03:29:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HiZzAVeS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id c18so9830163wrm.9
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Sep 2020 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1EWb/NNIf3SAEBtPx9B8faqU1fRD2ozWvc6lN6NHc80=;
        b=HiZzAVeSLJZ27dSBGumL87zw61yQBoea265dTIONmhmDGvM7YVR0NjBMumuQhMBNq1
         rBqCCoMTbNn3hH6XzvxJwNZDWBzrorCuCLRx/yGhvAXiQDdelx6ewU73VBrEARh7fUiJ
         e76/stZA0lyM9p2w9+Ah+iYJIJAElbg5wjHoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EWb/NNIf3SAEBtPx9B8faqU1fRD2ozWvc6lN6NHc80=;
        b=QY7HGbr++ZMOCZkGYRQyXqV4f+1PcJM1iryZR6ljfeo7Tt9ERZRpARMNLsaFHozego
         93gIHyEBsVAhYNZD1yRP/4h+Ypx9/y86wMLEm6MRpS5eh0vARpzylGDkvc/g9To0tI9k
         n7MHnWikA2l5FgoK7ii7j9UqAExfWvZt/p8kyEBBfJEESZr7nGFSK4XIyuL+07ATH3bb
         raU/MU7MpAFgGt3vRWgFs/P1c+Y+V7zSIMMe4fQQVp34YmoKCujqvNKBnaK6RIBhRW74
         sw3OqCu8f2BLvLf0OwIOyoB2ggqOiARfvn6FU1cS9VCd/YSu/P0OhPXqaKuVHq7S18mG
         v98g==
X-Gm-Message-State: AOAM532J0Asf5bqTcMwYwqZPx6DwyNrA5x3xIxRAxw+bxAK5D03hwbJ+
	ZCzTN+tnc+Bg0sJhz0t7ZEaSJ+Wx5rpQiw==
X-Google-Smtp-Source: ABdhPJwJ8F8EtT7/0yKG2cL/e8dYeu+3DXHKAB/Ys72J3VdUZ+Njx+qPFYy7UI9cEdaMhLzSWtsMSg==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr12518487wrx.182.1599301768282;
        Sat, 05 Sep 2020 03:29:28 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id o2sm17079713wmo.37.2020.09.05.03.29.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 03:29:27 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] server/process: Prefix the log data with pid/time information
Date: Sat,  5 Sep 2020 11:29:22 +0100
Message-Id: <20200905102922.1847453-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200905102922.1847453-1-richard.purdie@linuxfoundation.org>
References: <20200905102922.1847453-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing which process printed which messages and the timestamp of the
message is useful for debugging, so add this. Ensure the log parsing
isn't affected by using search() instead of match().

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 83c3e6b444..21f95cb61e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -36,7 +36,7 @@ class ProcessTimeout(SystemExit):
     pass
 
 def serverlog(msg):
-    print(msg)
+    print(str(os.getpid()) + " " +  datetime.datetime.now().strftime('%H:%M:%S.%f') + " " + msg)
     sys.stdout.flush()
 
 class ProcessServer():
@@ -480,7 +480,7 @@ class BitBakeServer(object):
                             lines.append(line)
                         else:
                             lastlines.append(line)
-                            res = logstart_re.match(line.rstrip())
+                            res = logstart_re.search(line.rstrip())
                             if res:
                                 ldatetime = datetime.datetime.strptime(res.group(2), start_log_datetime_format)
                                 if ldatetime >= startdatetime:
-- 
2.25.1

