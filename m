Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD53C83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 13:54:43 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.21424.1752846881704540197
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 06:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hciDbPTv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4555f89b236so19333655e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752846879; x=1753451679; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ud1ef023jbW/+1Rc9R2SqT4B2JjCC4eEWvU6drYbRE=;
        b=hciDbPTvGVep0gAA4b1NYRlPYMG/wh8lDe4ynIcvQYTbMEvEyWLCUrrs7cODZGXjZX
         wgrYRzd5J/h1AzC+LB+erBgkBbI94lJWtqiHU3MPUR2YNF/q30dNHVrcIYimMs3hSEvN
         o0kLczzd7NmDMODlvszDMuTkH7jSs5coMIvdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752846879; x=1753451679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ud1ef023jbW/+1Rc9R2SqT4B2JjCC4eEWvU6drYbRE=;
        b=NXpjXnxW3yQNdDTxTvPPT0YKdAQjad7SsK3kw5rt2wQ1x1EdfiwGXUqfUpyMfi+/wR
         R+Nf1E+8SGLnMtCQl9cFkcVkmsX7VcptkRgrVif0IEzi28XbP7+cCT5KtXlLEZhekQTW
         +xO/NmX08n+Zzq4/lZFaE3WgQphbQ/8LOLU5oJDoLJbhU7mXrv7DmblAxcYYrwBwwIN7
         dPqCNEyFVyr+La6MOJ4PAJtYTW5Re2jrBx9nkMxYmjbXePcAIt6qCnqEo/6pbpnWdVIj
         M2i5E+c7M7Wa1HnJi2IF5cd5dh+TTyXSFY8xB54S3Qrs0cxsDFjAUmHBSU/C4fJF2dul
         h3SQ==
X-Gm-Message-State: AOJu0YyGNnxMBRrr3rGcPDAinFDGluFa6z7wG/8djr+UdE/aNYTw4kTO
	Tgf/kBofNYas5fLPeoxl+0MhwVzOBIiZpanBYUpf5bMijEjrIGqPSVI6iBN/YJxtyR0WhPDJKX8
	RH0Qu
X-Gm-Gg: ASbGnctNWH1qaykNZDhoI/OHYEOJubvtGGpA4U+cQqa48qkr6jYteXIRGAE+MeGksYx
	XqD1gVUme8ze52Zjk2aMAAJjYmi4PHUFRUv/mW465lE0Zv/gQG2PZLy2vHf3KKRgVmuxxyb3Krn
	mZ2RyDajkC+Tq3v5RsiO6oPP0BdgVNMeg7RkeVg2FcFFWto5kGXLdsvBLnLvDQPYUIsss1q+zcQ
	Qa85Pjn3dugT8Sc4x9FjSxY7KLXndi6wVK9BNJCV2AlOo/KtNDJQP0D6LjuksHusGDeTQQDLJIJ
	Sjad+/Z7vFVRy3I/tOjmIOiK36NHvW7WPg3HBUrscgK9EqoumS3wEn1YoARl2zZjLjFvpk3ibtL
	XI4EX0R3yc/M39OYWTbpw4HKyosVzvtI/9RzA+Qo5mW9+clc7
X-Google-Smtp-Source: AGHT+IFS5kTXw33K8zt224+Zl6+CWF1F3/1n3mJ/2AVL/+G3tUOkca1iMFdRbDGIvZMDgZQunQMoew==
X-Received: by 2002:a05:6000:1a85:b0:3a5:2ec5:35a9 with SMTP id ffacd0b85a97d-3b60e4be76amr9758566f8f.3.1752846879341;
        Fri, 18 Jul 2025 06:54:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b19:5c6:27ed:a530])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45635fe6a9dsm31275825e9.2.2025.07.18.06.54.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:54:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] utils: Split profile reports into separate files
Date: Fri, 18 Jul 2025 14:54:37 +0100
Message-ID: <20250718135437.247096-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 13:54:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17795

Use a more logical name for the profile reports and put each report
into a separate file since people struggle to discover them currently.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 016036dbce4..c288c826c09 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1441,29 +1441,43 @@ def profile_function(profile, function, output_fn, process=True):
         prof.dump_stats(output_fn)
         if process:
             process_profilelog(output_fn)
-            serverlog("Raw profiling information saved to %s and processed statistics to %s.processed" % (output_fn, output_fn))
+            serverlog("Raw profiling information saved to %s and processed statistics to %s.report*" % (output_fn, output_fn))
         return ret
     else:
         return function()
 
-def process_profilelog(fn, pout = None):
+def process_profilelog(fn, fn_out = None):
     # Either call with a list of filenames and set pout or a filename and optionally pout.
-    if not pout:
-        pout = fn + '.processed'
+    import pstats
 
-    with open(pout, 'w') as pout:
-        import pstats
+    if not fn_out:
+        fn_out = fn + '.report'
+
+    def pstatopen():
         if isinstance(fn, list):
-            p = pstats.Stats(*fn, stream=pout)
-        else:
-            p = pstats.Stats(fn, stream=pout)
+            return pstats.Stats(*fn, stream=pout)
+        return pstats.Stats(fn, stream=pout)
+
+    with open(fn_out + '.time', 'w') as pout:
+        p = pstatopen()
         p.sort_stats('time')
         p.print_stats()
+
+    with open(fn_out + '.time-callers', 'w') as pout:
+        p = pstatopen()
+        p.sort_stats('time')
         p.print_callers()
+
+    with open(fn_out + '.cumulative', 'w') as pout:
+        p = pstatopen()
         p.sort_stats('cumulative')
         p.print_stats()
 
-        pout.flush()
+    with open(fn_out + '.cumulative-callers', 'w') as pout:
+        p = pstatopen()
+        p.sort_stats('cumulative')
+        p.print_callers()
+
 
 #
 # Was present to work around multiprocessing pool bugs in python < 2.7.3

