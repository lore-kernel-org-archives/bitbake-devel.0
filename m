Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E0C4332F
	for <webhook@archiver.kernel.org>; Fri, 29 Apr 2022 11:19:47 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by mx.groups.io with SMTP id smtpd.web08.8712.1651231178288500123
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Apr 2022 04:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=XPlmk+ik;
 spf=pass (domain: intel.com, ip: 134.134.136.65,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231178; x=1682767178;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Dqo2b21HoMifzyzXmAk/LE233KT5u5tEIQez5nTWhm8=;
  b=XPlmk+ik+BnBmkv2BkLwDObpkZOkvdHNX4++KKFXsM9X9p1BNc9yT2FZ
   A/l6XlLtCH0kkmhPLt/t+GIHJDl6GuEpmwMSaPGPFhH/RoU0aovRglw+f
   KN7rLyCIlOocYfOKKydvUeGHcwnbt/OAqrruGFdHrZXcuW0J6mgV4ufmJ
   j496rMmVXGCalzfLoN9qtth5gLm0D+8RcGlKn9gHdlvMS4gpK6ysR0T4Z
   7debDX+690ep+6fGDTQ5Jh8nO6u98/aN7EI2oh5fUz8BgZq0QjroOXikI
   QRNmJvw73IGZRrcMmXmW3tlalhzOm22uYNJMhTNaPG7ZdXp8rgtdCZcj6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266430840"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="266430840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="597282374"
Received: from fsuhimi-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.146.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:46 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/2] bitbake: knotty: reduce keep-alive timeout from
 5000s (83 minutes) to 10 minutes
Date: Fri, 29 Apr 2022 19:15:38 +0800
Message-Id: 
 <16299b0a3aa9fa67e8feb18e339cb07f8c398dfc.1651230735.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651230735.git.anuj.mittal@intel.com>
References: <cover.1651230735.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Apr 2022 11:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13667

From: Ross Burton <ross@burtonini.com>

The keep alive timeout is excessively long at 83 minutes (5000 seconds),
reduce this to 10 minutes: this should be long enough that it rarely
triggers in normal builds, but when it does it has useful information.

(Bitbake rev: 2e47346b95b09d7ab8f0603e2d62cfb549dc1f5c)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit dcf52157d3635925491783be656c6b76d1efe1a4)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/ui/knotty.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 64e33d81..3ba5579c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -607,7 +607,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
-    printinterval = 5000
+    printintervaldelta = 10 * 60 # 10 minutes
+    printinterval = printintervaldelta
     lastprint = time.time()
 
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
@@ -617,7 +618,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
-                printinterval += 5000
+                printinterval += printintervaldelta
             event = eventHandler.waitEvent(0)
             if event is None:
                 if main.shutdown > 1:
@@ -648,7 +649,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             if isinstance(event, logging.LogRecord):
                 lastprint = time.time()
-                printinterval = 5000
+                printinterval = printintervaldelta
                 if event.levelno >= bb.msg.BBLogFormatter.ERROR:
                     errors = errors + 1
                     return_value = 1
-- 
2.35.1


