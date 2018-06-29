Return-Path: <liu.ming50@gmail.com>
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
	[209.85.208.175])
	by mail.openembedded.org (Postfix) with ESMTP id C092F75441
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jun 2018 15:43:27 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id t21-v6so7674052lji.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jun 2018 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=LXRORVKtr+wLPyE0GG/sT+3hYaEbnNFp/v2reS938yw=;
	b=p52tDULhEaX5UDI2TL4NKCjd8D+iI8+gBz/Fudce6oXh2hQfWy/c4QVwX0199r9B4v
	6vythxn0n8EAMFdTQeX6aqFi97+05cosQxRnPzRlXy4oGr+vPysOJtDmHMZlY02hcpNQ
	mgIphrcCAnoKeSb4WZb9zgsrxoI1JxTtkjr0amOO02L30oiKHtJ4TaUwduYgXJ0iRN3L
	RCGLVetoCf/oT+tcpLG9PisPQQb2Y4MrbwkLAkzk6nys63+zdVg1tBAZAkhEINj4ibnk
	5nXYzQJyAua0k5EBkAbP5OSr+xp5pgy6kkRqH65kENIW8VvtC5Ix8GkJFLRMxJiPbFb+
	ZRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=LXRORVKtr+wLPyE0GG/sT+3hYaEbnNFp/v2reS938yw=;
	b=QQ5v4XnWcP/6/0aSNacEAB5qX5JguPo3inkrrnBjnnOjhFmW9TswNUVIPzcU/w3FDs
	wXqF5N9k+qe/ZD4H6mg9VuR9OEDNuLyFQgvz+K68ssJ3r4c4hDeLG/uhjwN+UHeY/d4X
	m8EaJPxb+Up51ZPFov5GoZJoU1bosB0seYtoM12RmY7/oBdFeQZfukboa9g5jkvmL/Co
	Yqp3nrISZjUXHhG0RkYXInu6beV7/E/SmqU7AzXWmogZ0yui2j04CN6XkU67vveQ5hIe
	Ggn5pJSkmZH1EwlGnQkEKEczyUMYRUKV8AYNuGl+4i4OG0zDwj96qYoOaWt5U8QH0vFp
	ZbUA==
X-Gm-Message-State: APt69E3H21njgrrDoH6n040kZmOCgTHirTOp4TwKNqmwod/LKWG+4QeN
	Qbss5Rya9K3O4VL/DZVO9FbA5FUI
X-Google-Smtp-Source: AAOMgpeaShTyuNEqj1fRorixk8qg34QueNbKsXfQZGs63lsZbjUj5A8cxHvr40DLdlfI1wAahau24Q==
X-Received: by 2002:a2e:99c7:: with SMTP id
	l7-v6mr11190832ljj.148.1530287008199; 
	Fri, 29 Jun 2018 08:43:28 -0700 (PDT)
Received: from peterliu-Precision-M4800.emea.group.atlascopco.com
	(m77-218-244-21.cust.tele2.se. [77.218.244.21])
	by smtp.gmail.com with ESMTPSA id
	f81-v6sm1781592lfe.6.2018.06.29.08.43.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 29 Jun 2018 08:43:27 -0700 (PDT)
From: liu.ming50@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jun 2018 17:43:23 +0200
Message-Id: <1530287003-28208-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Ming Liu <liu.ming50@gmail.com>
Subject: [PATCH] runqueue.py: fix a multiconfig issue
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
X-List-Received-Date: Fri, 29 Jun 2018 15:43:29 -0000

From: Ming Liu <liu.ming50@gmail.com>

The file_name parameter passed to bb.parse.siggen.invalidate_task
should be a virtual file name instead of a real file name, or else you
will encounter a following error, for instance, when you run:

$ bitbake nativesdk-lzip -c unpack -f

the error arise:
| ERROR: An uncaught exception occurred in runqueue
| if file_name:
|    > taintfn = d.stamp[file_name] + '.' + task + '.taint'
| else:
| KeyError: 'virtual:nativesdk:/opt/poky/meta/recipes-extended/lzip/lzip_1.19.bb'

Signed-off-by: Ming Liu <liu.ming50@gmail.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2d9e18d..0a4d155 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1093,7 +1093,7 @@ class RunQueueData:
                     bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
             else:
                 logger.verbose("Invalidate task %s, %s", taskname, fn)
-                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], fn)
+                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], taskfn)
 
         self.init_progress_reporter.next_stage()
 
-- 
2.7.4


