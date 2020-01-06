Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id 1EEF27FDD0
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:04 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id n9so19308691pff.13
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=paei4CsarOQgVjzqiWvlqV27K2XKAO4q3wav2K/ryz8=;
	b=bZXYhjruqhxTrx+DB+X34ULyj79sDFCfRam1Fg6CMa46SY8vRPdJuCPdzz6wprDujM
	X8OZPXPRb9NcgTmSuilysdUeAmjxMLVl3YcVnm4jHK0/4VF6xDn6l/D3tuW5kpUwDI73
	a68sBqn1T5yeL3JHF0wKPotLxbw+ySW7DdCn+schz8VjmeZTb3rE2DN6DQpXhYp21JOo
	M5XqnSvfMxa8Rkk9ZsM5ZbrcSqLkjfI3B6AYdCb8teVYub7K+DBRNzIuyZHRkA2chJzF
	gwMxaIaX9cYgfZt0xC1TIHjkX6yJLtGyhg/lGxFMNvjOmv2/yzkMenJ9tGXa2d/MNCSN
	d6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=paei4CsarOQgVjzqiWvlqV27K2XKAO4q3wav2K/ryz8=;
	b=tONNr1CFswWVtMFQCnw72qNyzKMnUWkfeLAOBJtVIXe9A0yuniZAotbblKzUTYG4G3
	G5AVYulE4f7Fvx73c/fTXYnQ1pc/CTc7OmuT/hCEsE76KlrYEMgmqykAa3hMXh/rnWuE
	zbC7IGCXFcL5zaYrUavdhS3kSsLvjEO0JGmyc8VSIB3DHyYJ0wS/eOloGU87Y1uxVKSO
	+vEGw/O7mNIBZqDvpxISiVnfIbkSLInUBW3KdpJ+H2n9BrVdv8bfe49aKZ1ZPI0I8d9T
	0OwcUE4Nany4Tlx0NS50KXCU073d+29UNopn8k/9UMi7wBtIdlvt0Rx17LSsXzxHVexI
	uw9g==
X-Gm-Message-State: APjAAAWqS4/gLe/kNw4vvOAY3oVZRr44UiZH9fUSjT418fFeezI1wH/B
	EM7lKuQynuwfr1xgXdMJnJV93e5F
X-Google-Smtp-Source: APXvYqyQSCV1nub47pFrsyCdt2kPKwfTpUYJVvO+B5NUtqGVScd16HWYWWA6+/OX29aH8EtyqZhIjQ==
X-Received: by 2002:a63:215f:: with SMTP id s31mr108423159pgm.27.1578328025107;
	Mon, 06 Jan 2020 08:27:05 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.04
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:04 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:36 -0800
Message-Id: <14babbf0a32637db640e0494b0331397dcb0f715.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 15/25] runqueue: Optimise out pointless loop iteration
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:04 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 105d1f0748edde7753a4063e6fdc758ffc8a8a9e)
---
 lib/bb/runqueue.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6da612b7..73775d97 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1182,11 +1182,8 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        procdep = []
-        for dep in self.runtaskentries[tid].depends:
-            procdep.append(dep)
-        bb.parse.siggen.prep_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
+        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
@@ -2294,11 +2291,8 @@ class RunQueueExecute:
             for tid in current:
                 if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
-                procdep = []
-                for dep in self.rqdata.runtaskentries[tid].depends:
-                    procdep.append(dep)
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
+                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches[mc_from_tid(tid)])
                 origuni = self.rqdata.runtaskentries[tid].unihash
                 newuni = bb.parse.siggen.get_unihash(tid)
                 # FIXME, need to check it can come from sstate at all for determinism?
-- 
2.17.1


