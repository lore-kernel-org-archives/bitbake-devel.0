Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.1735.1623794463903078540
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 15:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=CE+odM1i;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so2721719pjs.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Jun 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CRCmDr0fzGn6M62BfBmGv9O0ucDkCegHqmNdwP9u+X8=;
        b=CE+odM1ib/2EwKwAgYBXpmgbsJ0J/wXSAa0RsYAIBDjFhdS8m7vgJyeeMca+cNKZ6P
         D5hLf987HU0i5fkCjXRwBichC6CbJwwlDW8T00dWUT6JpK5N2unrg30O0eYi9n9udPhy
         +aQYcFdbAo9Dn1BrOjUREAMVZahwUoFEJDHgqRt45CkQzKTeEynXHoP33/8XQdhl+b2E
         4IfhllNxTv59ojvvkh6bw6n/vwhhXLHwQYaXQDz7JTqNsQJgB3H6jqwwqLJQ2FlqXBul
         Fn1fmj98nrtaQyyhxMv92oZMLIr3HaUeh+bZnKK9Wi7xRCbW7J4d2sOcgysxn1et/EXQ
         OiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRCmDr0fzGn6M62BfBmGv9O0ucDkCegHqmNdwP9u+X8=;
        b=riplwXlU3SHsguKZQ/8e34ZCQUjNMf1jPp5Oo/gtDgl84CctyMoBY86i+n2eAw2qwY
         kk4Knd8jXM+T304TclyiaaKEMDx0TKVN0SHMK6pEmP/NW8RqgXUEzCZ0L/LGFmcIZRMV
         Yy+ZdlCPr8kLUua2K9zg9fJvrIA7qiNHJe715a7TmEoccLif075lTLzzpTGXT7EnMPpY
         OA4lkrRgeTZLCxr9LS7+pVLh1DW2oDTyL2WF1eeltalSO+LBIoQCAsHQracqEJeYF56O
         5+9erhjNZQ+ZU0yzq7jVxA+WY43P/fF7GjwormFrCH8f+Y4oCVcQmvB9vjH5ohdEXf3C
         C/rg==
X-Gm-Message-State: AOAM531OiizhBe2AEc5yITQSyj8HgL04NjnMFr2doB4LP8BEfJIm8rT6
	Po0Syiuvoo1+OYIaHd46kBqbde6kqg4LEaYZK7Q=
X-Google-Smtp-Source: ABdhPJxhls7KU/a1IklT6pL0zidHSjGSif3gpiafWktZxe40xR68Vx7OOAij2zi/f/tmK5f2upaXAQ==
X-Received: by 2002:a17:90b:1810:: with SMTP id lw16mr1374503pjb.203.1623794463000;
        Tue, 15 Jun 2021 15:01:03 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id ls13sm115049pjb.23.2021.06.15.15.00.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:01:02 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/4] cooker: Ensure parse_quit thread is closed down
Date: Tue, 15 Jun 2021 12:00:30 -1000
Message-Id: <01806bb2b81947ae3aa9f7057b0d682161b2f8c1.1623793815.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623793815.git.steve@sakoman.com>
References: <cover.1623793815.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Each run through the parser would leak a thread from the queue created to
shut the parser down. Close this down correctly and clean up the code flow
slightly whilst in the area, making sure this thread does shut down correctly
(we don't care if it loses data).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 11cc2b95..4820d268 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2056,12 +2056,11 @@ class CookerParser(object):
                                             self.total)
 
             bb.event.fire(event, self.cfgdata)
-            for process in self.processes:
-                self.parser_quit.put(None)
-        else:
-            self.parser_quit.cancel_join_thread()
-            for process in self.processes:
-                self.parser_quit.put(None)
+
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
+        for process in self.processes:
+            self.parser_quit.put(None)
 
         # Cleanup the queue before call process.join(), otherwise there might be
         # deadlocks.
@@ -2078,6 +2077,9 @@ class CookerParser(object):
             else:
                 process.join()
 
+        self.parser_quit.close()
+        self.parser_quit.join_thread()
+
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
-- 
2.25.1

