Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail.openembedded.org (Postfix) with ESMTP id 271EA7F02A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:36 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id v15so3917557wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/haZgOgcjeFQGYvM3PgwScxNLhId/CUxgmEhcnizl20=;
	b=KIdGtZt+2MSb5kuacVei/VC9yj8Js7PsrC0pwQjafn7o/bgkFgBbDYyNtM/GmOsWbk
	hg0f2I1iUXWl08q8KId5kH68h1judu0w63p9PJDrwcOWHzRpp856JqW5NpC+DbkVKxjI
	MYbfenvPaU/5hGwGmXEgr7PTz8QvuRhAE+E/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/haZgOgcjeFQGYvM3PgwScxNLhId/CUxgmEhcnizl20=;
	b=HVzl0YLw9qrHG99NsoBXsm23VgL/iY1uqRzMoh/RRqVc04Ak79mTpmZ9YtgkoyiUvK
	0IW4V1m2vsoA3FTgZikFtjqtFPs0R4BIg7rLXjJkB0CWlz4PtQQGFgyYC0NrIoyUX1xc
	bWgxu/XjNtF4bT/wipud4WiWDrL4cTnpSo5LbxJJulUyd5xVPJyNfp7Z9NcJnkux5Fed
	/Wox+6DGwA+M71m2N5yMaqTcVquQ6f/mt6aQ+NRMHSfNGbLJ87FD5IX5wyMxwI8zKZhL
	V++PXWnY1qbtPHBK7BKlAIJ1yEHXgfyoWSGIsbbXHtIOOqtsc1FmRLlxGiJu2Q3gmoK3
	wTGg==
X-Gm-Message-State: APjAAAXW0UfhXsNDaDCYDhxhqUFSieRkwrqu25nRf8hHMGyE9t5QdPCf
	SMC8Hs7bkCpUL1TMVT1tdGjNwKSSkco=
X-Google-Smtp-Source: APXvYqx/IIC9JuIxZsdpCm5lFb6UYCmFFb1xuEwsIo6KJZ8uBdvlkesqprERBPRsgksyTr/YoIrl6Q==
X-Received: by 2002:a1c:a686:: with SMTP id p128mr309552wme.130.1562802877610; 
	Wed, 10 Jul 2019 16:54:37 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:11 +0100
Message-Id: <20190710235420.23825-17-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 17/26] runqueue: Tweak comments and debug code
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:37 -0000
Content-Transfer-Encoding: 8bit

Add some extra comments to build_scenequeue_data() and fix the debug code
so it actually works.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1f41340170..05bc9f9488 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2360,6 +2360,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
 
+    # Sanity check all dependencies could be changed to setscene task references
     for taskcounter, tid in enumerate(rqdata.runtaskentries):
         if tid in rqdata.runq_setscene_tids:
             deps = set()
@@ -2409,15 +2410,17 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     rqdata.init_progress_reporter.next_stage()
 
     #for tid in sq_revdeps_squash:
+    #    data = ""
     #    for dep in sq_revdeps_squash[tid]:
     #        data = data + "\n   %s" % dep
-    #    bb.warn("Task %s_setscene: is %s " % (tid, data
+    #    bb.warn("Task %s_setscene: is %s " % (tid, data))
 
     sqdata.sq_deps = {}
     sqdata.sq_revdeps = sq_revdeps_squash
     sqdata.sq_revdeps2 = copy.deepcopy(sqdata.sq_revdeps)
     sqdata.sq_covered_tasks = sq_collated_deps
 
+    # Build reverse version of revdeps to populate deps structure
     for tid in sqdata.sq_revdeps:
         sqdata.sq_deps[tid] = set()
     for tid in sqdata.sq_revdeps:
-- 
2.20.1


