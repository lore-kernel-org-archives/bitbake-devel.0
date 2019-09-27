Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id 3B50F7F316
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:53 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id l3so2533550wru.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=mxvCPalvusCSpAop2lAn0aDrrp6ef1sNeZTqvYc5tI4=;
	b=b8cpC8BwQgFTYmHSu84fYB97q1mwUfGIjOb89L0QQdbnhVPZ5hUsmZKDO2KXN1VuBT
	QZlmTza5W8vRKJJOF3NF96yLPi2YJXxWBFAm6mrZhTGOrb2OlDsXpGK5bYpr7Il6rCyP
	F8l7yiQgKvFcd3w9hD/v+A32ODO3kgxA+RH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=mxvCPalvusCSpAop2lAn0aDrrp6ef1sNeZTqvYc5tI4=;
	b=ZRp13+7kM3MvgYTA6sMmk+fHkMhouuMf1lksto1FrTeuo+9jmxIgvTyYCZc0AC64SI
	eWvPIv3A0XQqaKbj6ylupRQZgZA/nnvRzB3isyvXV5EEd6Zamb+JS+mTPHhbwtqnJGfc
	qOnirzbHAR/TTYQ1wA33hOl7qwKkThunQk2tC3mndIBNvA05SiWcSAeH59UZK+zSoBNh
	dKMqrz22B56PEkpc4QMVdvGFYGbowhuwkfqLQ2EMrTUX9lfG3foU3qORspO/nBjKDVUq
	xnyIZc83TfrUjalIDwA3KAyhfVa2avsqBWA7KgrHYrerMnDotc8D7d1bhxFZIJ+hjJQr
	D90Q==
X-Gm-Message-State: APjAAAVYjhFf1e0G5vUX7byobIU5odrpPAevzmdnVkwaUYZ9ARQsGusO
	MfitkhUoZ3dPBAZ9pagHEl09uVVbECU=
X-Google-Smtp-Source: APXvYqxYBezm7AmmePo5hBq91VQgXJkFCYxwEYYq2PQe6kFNY8j8jHfbNC9LEVNtiYH7FkTJC594pA==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr2723688wrp.278.1569587633727; 
	Fri, 27 Sep 2019 05:33:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:43 +0100
Message-Id: <20190927123347.19276-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/9] siggen/runqueue: Fix signature mismatch issues
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:53 -0000
Content-Transfer-Encoding: 8bit

We need to set the setscene tasklist before we call into the
taskhash/unihash code else the behaviour is inconsistent.

Avoid reporting hashes for non setscene tasks since we'd never
query that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 ++-
 lib/bb/siggen.py   | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 65169931f1..29bfd65e0b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1162,6 +1162,8 @@ class RunQueueData:
 
         self.init_progress_reporter.next_stage()
 
+        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
+
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(self.runtaskentries)
@@ -1173,7 +1175,6 @@ class RunQueueData:
                     self.prepare_task_hash(tid)
 
         bb.parse.siggen.writeout_file_checksum_cache()
-        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
 
         #self.dump_data()
         return len(self.runtaskentries)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 71fa018227..6207cbca30 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -455,7 +455,11 @@ class SignatureGeneratorUniHashMixIn(object):
         report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
         tempdir = d.getVar('T')
         fn = d.getVar('BB_FILENAME')
-        key = fn + ':do_' + task + ':' + taskhash
+        tid = fn + ':do_' + task
+        key = tid + ':' + taskhash
+
+        if self.setscenetasks and tid not in self.setscenetasks:
+            return
 
         # Sanity checks
         cache_unihash = self.unitaskhashes.get(key, None)
-- 
2.20.1


