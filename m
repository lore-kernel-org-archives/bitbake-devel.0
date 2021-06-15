Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web08.1737.1623794481125247726
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 15:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=UCyOb/rg;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id g4so526777pjk.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Jun 2021 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SLyAsDxrZb4ORwrxSnIbfR4V8aoQ9GrPP7/ldHEktL0=;
        b=UCyOb/rgo1WheoX3WjE8JLfV7eEVKsIKF1ALJ4YQeuYYget/edp9OQL1s8lMFfokHf
         /eX19C1frMtZg0amhDXVQcToQ/XTOIJw93aPUdJu+3O/sCbpjnOZRVbIaPKYJ11FBhUe
         cYCqCw4AcUqY4K3khGrMBPgFs0w3/i0CEEHrCZfQuIIZc7Ba9eqQKAyYxwK3DAbrIvhk
         g4rU39gXDB2x8RZK1lCntZ59PY+yhaDMrHYOBfuNr3W0dtZ9RVOzeKcy6aDtqQhNHqSX
         NtPyq8l/zLIr2Tuf0IQvCCXJpuxDXSUWotR/GQ0CT5Na3TGYnJwTXSEy4Ywf5OT2fTAN
         pKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLyAsDxrZb4ORwrxSnIbfR4V8aoQ9GrPP7/ldHEktL0=;
        b=gb0Pxbal0KOMf99g3hCm/JYYSXmvLPPAphsj92/Az0khusrKaJVHFtRTTY+dQsl0aX
         IS2jKgLiC88yIloQr6GFxF1HrQf3glu4lC581SGlB9XsR4WXmgZs8GrWvoyHpB6JxIro
         MIk5ak2swxoWOIGyxIkQqG10/76WyaCV6xtkwM8RqyTE3houat0KomvKpUDz/gTupu7A
         VGL0L8heuYlI+s6WdatUbG4EkfHnr3gcw4ES2AAxymCF69ji8QzcEIyZSMoFJLjJFdp+
         fyxZ8l4tnyqrA6hFxJG/v5fInbnKI1c6txCRNZfJgGBxjslFmLL/LnElloJEd6a5qVjY
         b95A==
X-Gm-Message-State: AOAM532LbmpU8Ub5C3GWrO57W/lctO+TIgUmUaEyK+4mZF7RGvkAQxB6
	Q2RlH/sSLFh8W9SzT0N5hzk/u19BjwycECx1Huo=
X-Google-Smtp-Source: ABdhPJxySFl/fOwqRga82WED7aSWO95jnxuPH5elzeRvCTVGUJFqhJPXFifCNX5yk7ifz3hprx3VHw==
X-Received: by 2002:a17:90a:c791:: with SMTP id gn17mr900823pjb.221.1623794480228;
        Tue, 15 Jun 2021 15:01:20 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id ls13sm115049pjb.23.2021.06.15.15.01.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:01:19 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/4] cooker: Avoid parser deadlocks
Date: Tue, 15 Jun 2021 12:00:33 -1000
Message-Id: <31d1079603b75b0784fe6e44d7c5b3cfc911673a.1623793815.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623793815.git.steve@sakoman.com>
References: <cover.1623793815.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If you make parsing fail (e.g. add something like:

X := "${@d.getVar('MCMACHINES').split()[1]}"

to meson.bbclass, then run "while true; do bitbake -g bash; done"
it will eventually hang. It appears the cancel_join_thread() call the
parsing failure triggers, breaks the results_queue badly enough that it
sits in read() indefintely (called from self.result_queue.get(timeout=0.25)).
The timeout only applies to lock aquisition, not the read call.

I've tried various other approaches such as using cancel_join_thread()
in other places but the only way things don't lock up is to avoid
cancel_join_thread() entirely for results_queue.

I do have a concern that this may adversely affect Ctrl+C handling
but equally, its broken now already and this appears to improve
things.

[YOCTO #14034]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4d2c62cd..730cdc56 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1933,7 +1933,8 @@ class Parser(multiprocessing.Process):
             except queue.Empty:
                 pass
             else:
-                self.results.cancel_join_thread()
+                self.results.close()
+                self.results.join_thread()
                 break
 
             if pending:
@@ -1942,6 +1943,8 @@ class Parser(multiprocessing.Process):
                 try:
                     job = self.jobs.pop()
                 except IndexError:
+                    self.results.close()
+                    self.results.join_thread()
                     break
                 result = self.parse(*job)
                 # Clear the siggen cache after parsing to control memory usage, its huge
@@ -2060,8 +2063,6 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
 
-        # Allow data left in the cancel queue to be discarded
-        self.parser_quit.cancel_join_thread()
         for process in self.processes:
             self.parser_quit.put(None)
 
@@ -2081,7 +2082,8 @@ class CookerParser(object):
                 process.join()
 
         self.parser_quit.close()
-        self.parser_quit.join_thread()
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
 
         sync = threading.Thread(target=self.bb_cache.sync)
         self.syncthread = sync
-- 
2.25.1

