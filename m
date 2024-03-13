Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CAC54E58
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 10:07:11 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.12852.1710324429092879717
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Mar 2024 03:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=ID4nD1P+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-202403131007050014218de7cf955018-r56_ze@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202403131007050014218de7cf955018
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 13 Mar 2024 11:07:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nkde5krkFRN6eivutSdJSVqFVGftrBpqUxCrsQGgvqQ=;
 b=ID4nD1P+Bes7PuhA2DK2aaBD1C5uKAJ6/RkxNMkNJaocKSFrNbhxgHVSMaAtZwwKoAutH1
 oi77xUt5ZihRPs88mh4W5HRlLzu8mCUAKq/7b9W+JDKo8fQKgvTm66Kniw8p3rL2ecgbeNmR
 C7rfjm/HBo2j6rjSzTbueIkYge4rw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: quirin.gylstorff@siemens.com,
	adriaan.schmidt@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 1/1] utils: better estimate number of available cpus
Date: Wed, 13 Mar 2024 11:06:45 +0100
Message-Id: <20240313100645.588421-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Mar 2024 10:07:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15998

When running in a cgroup which is limited to a subset of cpus (via
cpuset.cpus), cpu_count() should return the number of cpus that can be
used instead of the number of cpus the system has.

This also aligns the semantics with nproc.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
For a more detailed explanation about the difference, please also see
https://github.com/python/cpython/issues/77167

Best regards,
Felix Moessbauer
Siemens AG

 lib/bb/utils.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ad13d043..ebee65d3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1142,7 +1142,10 @@ def get_referenced_vars(start_expr, d):
 
 
 def cpu_count():
-    return multiprocessing.cpu_count()
+    try:
+        return len(os.sched_getaffinity(0))
+    except OSError:
+        return multiprocessing.cpu_count()
 
 def nonblockingfd(fd):
     fcntl.fcntl(fd, fcntl.F_SETFL, fcntl.fcntl(fd, fcntl.F_GETFL) | os.O_NONBLOCK)
-- 
2.39.2


