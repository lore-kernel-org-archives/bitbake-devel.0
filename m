Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4123C52D70
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 19:44:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.16415.1722973477549642857
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 12:44:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E+wrx2fB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so6927135e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722973475; x=1723578275; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rtu/5/T6GNJxhoa6mqI2q++kvDONJsD3jtVzudyV6go=;
        b=E+wrx2fB2rjMQISynEkgT9VDxOn1PTEx6qGtCfbnR17M59Abke799Y2Tv8s8RSvmVA
         GzBeKthQH6WR8MIal4IFn9sXlqCWOzEir0YJfF4ePgznEJMGCK1nm1XEn5qO03DDm+7A
         yGewEnbcc3lUrzqU39R04qfDS6Rd0P/XbdgWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973475; x=1723578275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtu/5/T6GNJxhoa6mqI2q++kvDONJsD3jtVzudyV6go=;
        b=NIxiKfNv7ip1FMsTcE+qzlqBPvzbwj5ZIh1R/ex204ZXE/D7Qn9ghOtvvHopYYjKP5
         b8UjnofbGBjqRabACLQOWYBVF6UNSOX7fnhw3OPvxlFBTpLG3Pgx00hxWdvAO98FMnt+
         31NtmOn61XJIdeWiGNOduaI4cn66wl2MAkbD+i1SerDmHwk0psKfNADYaX+PSui8Is/I
         MeENqkyDH/QTgT+hSEjATfrBr4fcNCM17Inrm5PeUqrYFjs8SiP9i2FAnIKUQsWZiyPC
         sCR9FQIc5yRGQmLpf/NiOPnQRJ3Jmi2ncaZIivTup7Bou4+A+HkoP1i1Oq2XVXt5WpGn
         vu8g==
X-Gm-Message-State: AOJu0YzL637E/eL6fZRl/Y5PJCtk1IdB9by3bHoZSj2QA9Pb37IFxEf+
	WIrtxqio6KV7r0PSIHj5KGIMXkeJSXUMnVixtf1fR1QnSm5zxuUYWQRCbQJLxVQieOmO5jMHFy5
	UNM4=
X-Google-Smtp-Source: AGHT+IFvXp1c6n1Htz6bXEFiQbAEnqvldVpp7sFqphHxW3RxGKE7aLrg6FQocIHRyzBAbpaCmgxPBg==
X-Received: by 2002:a05:600c:444e:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-428e6aeaf22mr112115825e9.4.1722973474921;
        Tue, 06 Aug 2024 12:44:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aeae:cd04:92c6:bd93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3ef10sm198317655e9.24.2024.08.06.12.44.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:44:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] BBHandler: Handle comments in addtask/deltask
Date: Tue,  6 Aug 2024 20:44:33 +0100
Message-ID: <20240806194433.107550-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 19:44:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16450

Technically our syntax would allow for comments after an addtask/deltask.
Currently these get silently processed in various ways by the code which
is bad.

Tweak the regex to drop any comments and add test cases to ensure this
continues to work in the future.

[YOCTO #15250]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py |  4 ++--
 lib/bb/tests/parse.py              | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index c13e4b9755..c1653faeee 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -23,8 +23,8 @@ __func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>faker
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __inherit_def_regexp__   = re.compile(r"inherit_defer\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
-__addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
-__deltask_regexp__       = re.compile(r"deltask\s+(.+)")
+__addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>(([^#\n]*(?=after))|([^#\n]*))))|(after\s*(?P<after>(([^#\n]*(?=before))|([^#\n]*)))))*(?P<comment>#.*|.*?)")
+__deltask_regexp__       = re.compile(r"deltask\s+([^#\n]+)(?P<comment>#.*|.*?)")
 __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 72d1962e7e..d076fcc208 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -179,6 +179,15 @@ python () {
 addtask do_patch after do_foo after do_unpack before do_configure before do_compile
 addtask do_fetch do_patch
 
+addtask do_myplaintask
+addtask do_myplaintask2
+deltask do_myplaintask2
+addtask do_mytask# comment
+addtask do_mytask2 # comment2
+addtask do_mytask3
+deltask do_mytask3# comment
+deltask do_mytask4 # comment2
+
 MYVAR = "do_patch"
 EMPTYVAR = ""
 deltask do_fetch ${MYVAR} ${EMPTYVAR}
@@ -195,6 +204,7 @@ deltask ${EMPTYVAR}
         self.assertTrue("addtask contained multiple 'before' keywords" in output)
         self.assertTrue("addtask contained multiple 'after' keywords" in output)
         self.assertTrue('addtask ignored: " do_patch"' in output)
+        self.assertEqual(['do_myplaintask', 'do_mytask', 'do_mytask2'], d.getVar("__BBTASKS"))
         #self.assertTrue('dependent task do_foo for do_patch does not exist' in output)
 
     broken_multiline_comment = """

