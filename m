Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 64C297F316
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:52 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id r3so2545816wrj.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=iKMxK283GyI9nGVK35ifqdemcRouEJVZjTUhYY7agEc=;
	b=S4bPW+789UJZAnSCR0LPXQx0GS/Xo8GJI5DLBCAATfB0622q88Jm8A9G031fnybDEe
	TP/nMIszFz5LcZHZ3Tnj88e2JLWkRkKPXftmfiiq5hqTVgJ0RHgxoveqFyLHd1aH9BWT
	op28BLNTfkK78mDEpU3M6dbolKwMbjKb16Ruo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=iKMxK283GyI9nGVK35ifqdemcRouEJVZjTUhYY7agEc=;
	b=NksDP+8F8vsXhvkeuinxNBTbsg4SwETwX5bg0F44USUhUrpT1qrL/iGUedFHXOwWsq
	mr7Xpwjk3x5tqWUB9WSp0k1GeG53YzlV2ddNUxJs+HePCfKlFK/xqIeJIb+CkIMC885X
	F72Oh7TL47B/2GAze/61P5x0Kw9N5rKMXRf/9xxzM95jwJ1a0DcDhNmUbe9Q/HoN/MPJ
	se10GPDnfSVmtKCifE65ITL5Fx2etk6/TPzR0yzp3K66RZK2cu59jMd1/IBNyv9NKww1
	j+NvF0nSRVQ2dqd62UbsmP98Q1JGeRZNjWGpamluwHg5QE8ipL0fw3RaoVwkhYiRWaNB
	62Ew==
X-Gm-Message-State: APjAAAUQGGBo3WRcJX2z+VtP3YqmqEgpaYgPtOzdA+I5ZJTeBeBPIdXh
	ZzBakCYRi/EN8ptmH0VHkDqSMTYbNE8=
X-Google-Smtp-Source: APXvYqzQkrui6KTc3qNEpXc4dozpJLEu3iKutKTlumJTJX3KPvtbrXlbB3BHkUO88OCpF3kdFfCaJw==
X-Received: by 2002:adf:fe4a:: with SMTP id m10mr2690238wrs.209.1569587632867; 
	Fri, 27 Sep 2019 05:33:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:42 +0100
Message-Id: <20190927123347.19276-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/9] runqueue: Change task migration behaviour for rerunning setscene tasks
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:52 -0000
Content-Transfer-Encoding: 8bit

Currently runqueue will rerun setscene tasks multiple times as hashes
change. This has caused numerous problems since a setscene task may
become "unavailable" for some future signature combination and the code
then can't easily "unskip" tasks its already passed into the execution
queue.

At least for now, only run setscene once and assume they're equivalent
at that point. In practise that has been much more stable in testing.

Tweak the test to match the change in behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py       | 4 ++++
 lib/bb/tests/runqueue.py | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 02160ef4d7..65169931f1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2301,6 +2301,10 @@ class RunQueueExecute:
                 continue
             if tid in self.runq_running:
                 continue
+            if tid in self.scenequeue_covered:
+                # Potentially risky, should we report this hash as a match?
+                logger.info("Already covered setscene for %s so ignoring rehash" % (tid))
+                continue
             if tid not in self.pending_migrations:
                 self.pending_migrations.add(tid)
 
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 01b992c47c..50b3392bc1 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -307,8 +307,5 @@ class RunQueueTests(unittest.TestCase):
                         'e1:package_setscene']
             self.assertEqual(set(tasks), set(expected))
             for i in expected:
-                if i in ["e1:package_setscene"]:
-                    self.assertEqual(tasks.count(i), 4, "%s not in task list four times" % i)
-                else:
-                    self.assertEqual(tasks.count(i), 1, "%s not in task list once" % i)
+                self.assertEqual(tasks.count(i), 1, "%s not in task list once" % i)
 
-- 
2.20.1


