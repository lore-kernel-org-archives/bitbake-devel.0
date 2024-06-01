Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC17EC27C44
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:36 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.36211.1717244856482737449
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Hwbz4wxs;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-702342c60dfso1872576b3a.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244856; x=1717849656; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGHus0hctalZvqZUVmpgCRabsjS9XcjL4CPRIMjvmAk=;
        b=Hwbz4wxszc7TS1GjIvndoEJep/DY5tIJlAHS2FJRnD2uf0SZ4iwu/ZL4UbLw2R+geV
         ws6ZOIMZsuBzpEVKtYsKwM0RSMLAPW+Xl3PUZ5YZSsmc5ovo65lFGQGRsvARHDQeEFn7
         q21PIb/yN/8XWlG6Vgk7SfwtA1c+sNRS7pJWSUCqN8KOEplLbO21KhGjsPukGOjBviKF
         p4XM8rju4+Dk6WDBD6RSuc45tLTdM+4O95oYyZwTWUJ37cSmJVaJEB62Xs9ee4MNcICl
         PXO9uUIsXL/W6D+lVqs4+wFytKFMrPe5Ppjnmpclo5rp9VUFIrn7d5jNbKNTmYjzlVup
         1CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244856; x=1717849656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGHus0hctalZvqZUVmpgCRabsjS9XcjL4CPRIMjvmAk=;
        b=ehwM946/i1Eus81qAtY+gth7rmrQqzdQ9D2DIzIcyCfAVJUPXXKvOYrZFr700+HhW2
         Tdxcf1rnhSaL8jTB4KzRKJaQPuzNGk11CPPR5HUt5OOZC2yfrzUZXA1Vh5MVSXscy2YX
         8lxsAUU8xAZugwXdC9z2lzDN4zxZyJUDYlQXpH3kjW8p/Bon2B6i7m4GTkh6Hwu/EMgc
         R/nbfj7OfnlkTojYTRucOaQ7xxy73MBkeffwuiTaoLF5fwYpyAUHCG8gmIwP+JrUuHh6
         7Xjv0mL7HFs0rz3lK5VKbdx4ua9FsTN1NWwniUNINEmu0am7QUXQIpf30ZqREQ33VGTd
         y+uQ==
X-Gm-Message-State: AOJu0YweZ6IAHPRm+i3ihXhLBfMV5+1hS5httDvy5xI3tfpZYq1zc4au
	R9eiZS5tHLVwslabmP1pnl7N7/UGCKum0Ur5V3WtJfbZMkLB/sUu4AxeEs2mEHtMuVoaH29CAAY
	3
X-Google-Smtp-Source: AGHT+IERU7LkfTwnZjs7EjLAo9NhmG/Gh4IgDNz5nFGEaCCe9ioVNPFPT8Bmrr9NtbWgHzJdW2tvyQ==
X-Received: by 2002:a05:6a00:a94:b0:702:2675:fffd with SMTP id d2e1a72fcca58-702478c7436mr5227558b3a.34.1717244855738;
        Sat, 01 Jun 2024 05:27:35 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:35 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 4/8] runqueue: Process unihashes in parallel at init
Date: Sat,  1 Jun 2024 05:27:19 -0700
Message-Id: <33686c80347491a39cbbd7a926eed5452e9aa168.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16308

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
index 939a99997..6318ef4a8 100644
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
index 84a6f4172..999868dd7 100644
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
-- 
2.34.1


