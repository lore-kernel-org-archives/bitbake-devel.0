Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.12553.1593276634524284954
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 27 Jun 2020 09:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GqJQKIFw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id t194so12165769wmt.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 27 Jun 2020 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKioL8M4Jgk/eoj6Lctx2DTMdriOxGjws9eEx1afLXQ=;
        b=GqJQKIFwIcdzC6JUrx715ynJkiBOuaTGy85WAQqrjICcJ0wWHhmCqIZE2ww8wSM3Ot
         dfZ3X2E+HeBPIl47Op/VNs/RaoNQP/E3ap8nY5b/f20vDW//lSGvWr8FJ8OSG+GxHalh
         Tx3na74ctuYqHsMk4eC+UfzjL7RHI9Y6/ue8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKioL8M4Jgk/eoj6Lctx2DTMdriOxGjws9eEx1afLXQ=;
        b=CYZm9C6cDTC/Frkf7frbUxidNfBThD3U8J/n8sGyU7B8fkcG+tDU8T6sQ+Ns40jGLe
         vD8nCiq8Oo1aNxuAGXtaNyehcM6PghWpvhzxEC9wviqahZBrAwW1CJMe/O0aUJ7ihhoG
         N7XCGUCbBlltjKQrHBLgjeKlP2/ttli1UskBizAzGGMqisRaCwEIq5TSWa4HFwJcWKEp
         AzJsEobzRAs/41J6men+/8QG9oVOtTBoK+DaYnAQ2YMGsKrQODQG4FEvQYqRvc0ecXy8
         K00KAonK6c8wSAglYeOBiAERS08ZZfkiPVRXNS2INsYePEErvf3wtrAdNSPJJ9yZP3s9
         0Zkw==
X-Gm-Message-State: AOAM531mbxe7E2ax9xESs5jnZHWMxCijt3blWdhBT/tjVwiXkIiDf2k8
	p3LS1reEw92eDGRizi6v4g/EkvZhdT+JnA==
X-Google-Smtp-Source: ABdhPJwu35pY18AVNdoe7vKotLnwW5AkdYLL5DdnP4Vf9IfBiygpdMyqbCQmd8D9wKUVRtrHyG+bEg==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr8974634wmi.49.1593276632757;
        Sat, 27 Jun 2020 09:50:32 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id f2sm20888619wmj.39.2020.06.27.09.50.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 09:50:32 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Avoid unpickle errors in rare cases
Date: Sat, 27 Jun 2020 17:50:30 +0100
Message-Id: <20200627165030.711190-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rare cases the pickled data from a task contains "</event>" which
causes backtrace. This can be reproduced with something like:

do_unpack_prepend () {
    bb.warn("</event>")
}

There are several solutions but the easiest is to catch this exception
and look for the next marker instead as this should be the only way such
an unpickle error could occur.

This fixes rare exceptions seen on the autobuilder.

Also add in other potential exceptions listed in the pickle manual
page so that better debug is obtained should there be an error in
this code path in future. exitcode doesn't need the same handling
since we control what is in that data field and it could never contain
</exitcode>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index adb34a8cf2..02a261e30c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2967,7 +2967,12 @@ class runQueuePipe():
             while index != -1 and self.queue.startswith(b"<event>"):
                 try:
                     event = pickle.loads(self.queue[7:index])
-                except ValueError as e:
+                except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
+                    if isinstance(e, pickle.UnpicklingError) and "truncated" in str(e):
+                        # The pickled data could contain "</event>" so search for the next occurance
+                        # unpickling again, this should be the only way an unpickle error could occur
+                        index = self.queue.find(b"</event>", index + 1)
+                        continue
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[7:index]))
                 bb.event.fire_from_worker(event, self.d)
                 if isinstance(event, taskUniHashUpdate):
@@ -2979,7 +2984,7 @@ class runQueuePipe():
             while index != -1 and self.queue.startswith(b"<exitcode>"):
                 try:
                     task, status = pickle.loads(self.queue[10:index])
-                except ValueError as e:
+                except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
                 self.rqexec.runqueue_process_waitpid(task, status)
                 found = True
-- 
2.25.1

