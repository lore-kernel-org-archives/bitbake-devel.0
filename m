Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id E38C27F331
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 14:16:02 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id q14so20596354wrm.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=zN7tvpAcSDOH0tIo6lc12oMwvzh9pAdTeHE1aact0YA=;
	b=CvBPbkJZJCFrxIcYSK5Oa+PqVcIV8JFP3pL2N8Yd1+VK9bZgPGXLF+WLiQI2Y7V54A
	qvn0pTR0j5Vov77ozsHW0kfRU5+M3cNJ2uZED2eknoRIJHcjxFFwfC0hhGq1RuOfihOo
	PAoBP98kn0+tkQDcxGvEKaeIF0ZdvOMkw59es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=zN7tvpAcSDOH0tIo6lc12oMwvzh9pAdTeHE1aact0YA=;
	b=AojeXyje8airf9ubZXORXHl+Tx01T5jVM7w3lfHtQW+8OEJzwzIakJUA+rkFUpebVe
	6L2XdPvs2YaGxJiLJYUh3ne1FySuwQocOhuONaD7LW6FuI0jnhFj0E2/zJNwtydEqHW/
	1woDlRzx1OZkyY41+I2mSiWY5Vp3ctMYh9Cdj1yvRLNXArVcViAJd+S8Px2MiHaeM4aM
	qAob6fvjS/yWO7CxFcdY2u6uLnhzH9ZnXbpsBvctvrbpBKIAgZ5mUCZp+aRsMxRpGyfk
	XWcEZLE6jNXJjuh2Tgw1oZiqF7p1EhorI6gQ9txyjp6G35t/JBnJsPnzK2KpeRC3f+2i
	tbvQ==
X-Gm-Message-State: APjAAAVf6Q9vi9PlZQUU+SRmtB8LhY+yykRLgkGzFeFBUN0Q0cG/jgdd
	LVcndiH0DeJmwfucahl2creijYPzQR125w==
X-Google-Smtp-Source: APXvYqwQjovRxJX/gLwB35OlymMppdm6TwsQJe/3/kK5JJglTZcP+gbjVppXhRV1IOjGRsI2lpA9cw==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr28298747wrr.334.1568124963329;
	Tue, 10 Sep 2019 07:16:03 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	f186sm4954353wmg.21.2019.09.10.07.16.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 10 Sep 2019 07:16:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2019 15:15:54 +0100
Message-Id: <20190910141555.6710-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] runqueue/siggen: Optimise hash equiv queries
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Sep 2019 14:16:03 -0000
Content-Transfer-Encoding: 8bit

We only have hash equivalence for setscene tasks so only query the server
for those, reducing the number of connections needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 lib/bb/siggen.py   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index addb2bb82f..45bfec8c37 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1173,6 +1173,7 @@ class RunQueueData:
                     self.prepare_task_hash(tid)
 
         bb.parse.siggen.writeout_file_checksum_cache()
+        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
 
         #self.dump_data()
         return len(self.runtaskentries)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index b503559305..8d3f2e8784 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -106,6 +106,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
+        self.setscenetasks = {}
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
@@ -151,6 +152,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         return taskdeps
 
+    def set_setscene_tasks(self, setscene_tasks):
+        self.setscenetasks = setscene_tasks
+
     def finalise(self, fn, d, variant):
 
         mc = d.getVar("__BBMULTICONFIG", False) or ""
@@ -394,6 +398,10 @@ class SignatureGeneratorUniHashMixIn(object):
 
         taskhash = self.taskhash[tid]
 
+        # If its not a setscene task we can return
+        if self.setscenetasks and tid not in self.setscenetasks:
+            return taskhash
+
         key = self.__get_task_unihash_key(tid)
 
         # TODO: This cache can grow unbounded. It probably only needs to keep
-- 
2.20.1


