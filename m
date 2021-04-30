Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.11226.1619788130658871419
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Apr 2021 06:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=agJcVXkh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id x7so70476841wrw.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Apr 2021 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1y6F/I+AZ/0LHk9nTTAJgv2jP6UzWkpVUhwZJmXquqQ=;
        b=agJcVXkhZvvhTq0CTCq6Rdp5iu900RLTiyhMGVHSO08cQgws1npcKCaN4L5r7SpDuL
         lO77ix7vNSePz4wqt+j6wtw3Z257I1JcanW9cAjknfhmjUr9nDNfMUYgJmhhk04H2laC
         npYwe72YKTKpmESKvyt8/ukejKOZP2ZqmXVSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1y6F/I+AZ/0LHk9nTTAJgv2jP6UzWkpVUhwZJmXquqQ=;
        b=XygizS+q/vEtTZPZ4nHN7thyCsExs4rnIDbo84mFc7FPySJldZKH156+ilBxyEm2yL
         bzbe9bTe6fxnCggDVa3Fph3Dr1tIIAB2ZrKAHyQYicbRs3S8CzgjCIv6/bY564A5YvJM
         yFv9DFJaDPnNZ+ib2bed1OMNUXJuhWVLkzxHqPA7+f4SCPFtNxnl4UsLT1eVBx8H4UYF
         k/rFZzBtHo5RsABryhhoRSAFTTtG+zC0AfsXUmmMuJh1mUiIT3m2aYqXvqe3xxQ8a54+
         ESyyxGE1aNcEYhtMX5QCmNTGxt+WnbdwegF8OJzxhfCi3+H2+gyYzvmRXSto/5hjk7gG
         IhgA==
X-Gm-Message-State: AOAM533rWfpWvghW/vrSFTT/CKaHqgFGIlvQa73qj6/bj00OMVUEBbGH
	p6gBr6HYp07dimlqa2ZmXyi8G6Yz7SIrDA==
X-Google-Smtp-Source: ABdhPJyUFyfvqdRzs2MuCJBai3KyOv6aAonRYQzOh2rK5sTS32n5x+vS3K35ow63sPCzaK2Xb+vRxw==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr6729800wrp.341.1619788129251;
        Fri, 30 Apr 2021 06:08:49 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:38ed:4baa:ed1c:e489])
        by smtp.gmail.com with ESMTPSA id r13sm2418740wrn.2.2021.04.30.06.08.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:08:49 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Handle deferred task rehashing in multiconfig builds
Date: Fri, 30 Apr 2021 14:08:48 +0100
Message-Id: <20210430130848.1801762-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430130848.1801762-1-richard.purdie@linuxfoundation.org>
References: <20210430130848.1801762-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the hash of a task changes and that hash is a deferred task (e.g. a multiconfig
build), we need to ensure that the hash change propagates through to all the tasks
else the build will run multiple copies of the task, sometimes with oddly differing
results as the outhashes of native tasks built in differing locations can confuse
things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 78e576eb2c..6c41fe6d43 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2294,10 +2294,16 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
 
             if unihash != self.rqdata.runtaskentries[tid].unihash:
-                hashequiv_logger.verbose("Task %s unihash changed to %s" % (tid, unihash))
-                self.rqdata.runtaskentries[tid].unihash = unihash
-                bb.parse.siggen.set_unihash(tid, unihash)
-                toprocess.add(tid)
+                # Make sure we rehash any other tasks with the same task hash that we're deferred against.
+                torehash = [tid]
+                for deftid in self.sq_deferred:
+                    if self.sq_deferred[deftid] == tid:
+                        torehash.append(deftid)
+                for hashtid in torehash:
+                    hashequiv_logger.verbose("Task %s unihash changed to %s" % (hashtid, unihash))
+                    self.rqdata.runtaskentries[hashtid].unihash = unihash
+                    bb.parse.siggen.set_unihash(hashtid, unihash)
+                    toprocess.add(hashtid)
 
         # Work out all tasks which depend upon these
         total = set()
-- 
2.30.2

