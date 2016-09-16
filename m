Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id CF4DF731D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:05:15 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id q2so1331481pfj.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=b6gZHvgvnaEqXbLRgRu2tTtKBR6pbpc07e2jyTm9yNs=;
	b=MPoh6jMgABuAFuIGXcBNXUDnjW4v6cl42BFXToetvckvGyYWP9QSFZysESrNmutRfl
	GsDSCPr6q6NLFfKEABeAcbUdHs2UgpUateDf6WpsIlK0pngQ9Szh/oNTF0yaDgTNI2QS
	DxTpTY4KokdnBsq3e419oyfEvtVf5kcqs8BlKXag24QFJzJY8GwaZPNijOBgW/ltgaRT
	l+tuY1cu8swjzHvw6trcB5pnYpaN6u8liyLgPnsIbmZ8JWqjXLYDO9IfnsGDe41Z9Oic
	3YTxLOeBHM1xrDkY42xkaFBgiBRRfVajWMASvRzUtAgDMEGJwCD6mB7LCiLRIPR7wibV
	sj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=b6gZHvgvnaEqXbLRgRu2tTtKBR6pbpc07e2jyTm9yNs=;
	b=Rt0RRvZfbt8QcgNgmcHRN5ZaMCBn7JgdTSRUnWtG/+onRt17pO5n1jrsZ6TFfPzHYX
	7Woa1WmlphOmxtmWxW/NvAH46SK22G04nyzqnor81pIKg6OoH6zUkUlg2Af91pYKTXlB
	S4hnwk+1ij3sA6UL6FSmhSuTTHa9g0wrrSLmDCCgJsXGaOmDnxL4P2IOLEOZbmdOccSy
	x3IxdaWA9rKK+9w/5xb0C9PQZou7NOWzE9rZ1rAHWBI6p9XT1YzAV6K8NlfWy/7G05WA
	Kx8ZnR/Ln83BZKWx/J1ot5EnLUCGkP5bwXAmnQv56N9NKmrS/1kwNIDUouWbFndhASQq
	7qOQ==
X-Gm-Message-State: AE9vXwPLBt1QmkI4ayn684BuId6L3gMNYdF/AW7TkRiWNhlZv3RadrS58x1oi0kIUjMTMg==
X-Received: by 10.98.113.135 with SMTP id m129mr25553036pfc.41.1474056316253; 
	Fri, 16 Sep 2016 13:05:16 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	h123sm54113642pfe.69.2016.09.16.13.05.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 13:05:14 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 13:05:11 -0700
Message-Id: <1474056312-13817-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCHv2 1/2] bb.build: in _exec_task, catch BBHandledException
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
X-List-Received-Date: Fri, 16 Sep 2016 20:05:16 -0000

From: Christopher Larson <chris_larson@mentor.com>

We don't want a traceback for this exception, we need to catch it, fire
TaskFailed, and return failure.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index fcf0149..2ed0441 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):
             logger.error(str(exc))
             event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
         return 1
+    except bb.BBHandledException:
+        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
+        return 1
     finally:
         sys.stdout.flush()
         sys.stderr.flush()
-- 
2.8.0


