Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6D4C25B7C
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 20:44:34 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.1867.1716929066027175602
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 13:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eqvtFnj1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421124a04d6so11354045e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716929064; x=1717533864; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFoLgyCqdBtE7WpK0nWArbjkeHZtb0yq21OOFSKvciQ=;
        b=eqvtFnj104aVSG9JkT0awaBKXUXlm4cJpHW+k8BEDebwZdVCF2vVZWGehm1IBcqyjI
         Ylei73G94tSGB8xjPAGI9TUFi10vnP1XIFoH3bXgdVHyXQ62DbNI9bDPDk6GJqwTTBoT
         61TG2mJAH2DLE/YHAZ2iFDPjUTFat2SaxHcus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929064; x=1717533864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFoLgyCqdBtE7WpK0nWArbjkeHZtb0yq21OOFSKvciQ=;
        b=GYhhtfXrrjh5CSD8d9PkZFPjpCbQiZhoql26S/YxQDRVfr/2WpoJ5rMmqD5vMG0/f+
         oOOH7kkvi3ZzwNqK2vWvMSkB8YFKzufL/f6u1AapxDHfcF1WRolwCbz3B6yh7gi3JhW3
         CA/k1DrRmmG9BuUA6Qcz2cGKlydEawia8Tx+pWB7IC477Zm5YLfwEwWoKGP9/Z4BYMc6
         MCWEyHQXC1QVae+GpgwPeH2OT4fyOeIU96MbKXJJlpm8+RrY/jFsXyLnZqqRy6nPP6eN
         WQ4GkJUGpplwbZMX7TizVAvB170d+tDBVi2HElWa4eiOagfYl9jyDeDfiRGNySafDxvn
         qYAQ==
X-Gm-Message-State: AOJu0YwFQJsXckcWwthgfSGdIz67iGcGUNsx1/Rw/4AM3a9mkzXf67Ww
	3b9ctRHhsmGHpjK0ZxBzl+b7wXbj27AQYo0xHKrJIWpuMbuKeYkxx1mWqFFcBDor86TetactB0x
	y
X-Google-Smtp-Source: AGHT+IGSUwCnk32rPoUtJP0F00QUJW4vmM6uv3VsjgE/9+FGLS2byUfsj+2SwvNPbycP0HTGwkx5Iw==
X-Received: by 2002:a5d:6a8f:0:b0:354:f2b8:c75e with SMTP id ffacd0b85a97d-3552219d4demr8175540f8f.33.1716929064082;
        Tue, 28 May 2024 13:44:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b316:c62f:d434:bcd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm12635228f8f.29.2024.05.28.13.44.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:44:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] runqueue: Process unihashes in parallel at init
Date: Tue, 28 May 2024 21:44:19 +0100
Message-Id: <20240528204420.2845521-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
References: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 20:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16274

Improve the runqueue init code to call unihash queries in parallel since
this is faster and more efficient, particularly on slower links with longer
round trip times.

The call to the function from cooker is unneeded since that function calls
prepare() and hence this functionality will already have run, so drop
that obsolete call.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py   |  1 -
 lib/bb/runqueue.py | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 076ddaa58d..255b9f199a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1459,7 +1459,6 @@ class BBCooker:
 
                     if t in task or getAllTaskSignatures:
                         try:
-                            rq.rqdata.prepare_task_hash(tid)
                             sig.append([pn, t, rq.rqdata.get_task_unihash(tid)])
                         except KeyError:
                             sig.append(self.getTaskSignatures(target, [t])[0])
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 84a6f4172c..999868dd72 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1280,11 +1280,18 @@ class RunQueueData:
         dealtwith = set()
         todeal = set(self.runtaskentries)
         while todeal:
+            ready = set()
             for tid in todeal.copy():
                 if not (self.runtaskentries[tid].depends - dealtwith):
-                    dealtwith.add(tid)
-                    todeal.remove(tid)
-                    self.prepare_task_hash(tid)
+                    self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+                    # get_taskhash for a given tid *must* be called before get_unihash* below
+                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+                    ready.add(tid)
+            unihashes = bb.parse.siggen.get_unihashes(ready)
+            for tid in ready:
+                dealtwith.add(tid)
+                todeal.remove(tid)
+                self.runtaskentries[tid].unihash = unihashes[tid]
 
             bb.event.check_for_interrupts(self.cooker.data)
 
@@ -1301,11 +1308,6 @@ class RunQueueData:
         #self.dump_data()
         return len(self.runtaskentries)
 
-    def prepare_task_hash(self, tid):
-        self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
-        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
-
     def dump_data(self):
         """
         Dump some debug information on the internal data structures

