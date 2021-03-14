Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web12.8250.1615739431773177432
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Mar 2021 09:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sed0VDpH;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id r3so44984081lfc.13
        for <bitbake-devel@lists.openembedded.org>; Sun, 14 Mar 2021 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lECFJUOYSgTuf8FtixVaTESMz77rTgShN3tI1+eK1TI=;
        b=Sed0VDpHSUdp+9Bd43rIzMLBP9WBiH0sAO1hgKObE4KdUwl3pVoS99RyH7aWBB3bN2
         PS1HjRaXZGJsxG2PC4A5vqBLfwRT8/oNJDp25XjxgcNlChJOcOdWYfW2fKzjl1G20g6Y
         9QWE2BPmmyVRs2hgv3xh3jIVwWJL7JcDGFROJ2zo59ewdl6ggJMOZWf3KIzSEDt0hjjG
         fgl6Q0bciem3Bngw6gM+y6dhllkHRWEJVPuHSZy5ap8S4O0kuWBpwOWWjdL24WIuueHb
         uO+76O2dHN+6IXRgSNVIYXojpQN3c/o753TQcJpRFGumolzp0ZIb+1B5S84RILLMUf3u
         Z9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lECFJUOYSgTuf8FtixVaTESMz77rTgShN3tI1+eK1TI=;
        b=AjLuV4JxAwcM6dP15Oi32K8+h48ciwgm/fpWUH+nzsHxu1xrk8odL6eIV3/TEfU71k
         /jOWXnJQKJilrA1HliVAzdt9mRwUNVqMFMcHbqpYJr6T0oWBrXJ0n09xnBJufV2MyVQm
         4LMl7SiGnPZRquhVvVR1ZPitYdO1znMCVBpybp63pXh0YJNNo4leejByKJ9ln2kJ35tn
         OzfWdsPapKrHBOTk3OFBYIQCW2DFGZgBiCTJ8NMbvFdiGdeUoOqUy1sBbT8TbVgZdIhh
         LbnGY86RY1tlwEHO/LohVI9mzX2CoTn9cwbJepbn4MdvGmdmmNXpl5dkuz08jsWMNzkU
         efZQ==
X-Gm-Message-State: AOAM5323qvUpKWw2Vs1N8E8JlPV0nmhbHjZM+WFPcyKUFEyxu50guzwS
	UgeMNkPnjq+5JAohv6iMuGdUbDMFFtGlSA==
X-Google-Smtp-Source: ABdhPJytWLExQ2tG8sv5h1CHmGH/fxQZd7Dpkf1422CcbvitnJ5gYyLmtbP4fsDC1wYCpjEqU3jXaw==
X-Received: by 2002:ac2:5973:: with SMTP id h19mr5386636lfp.120.1615739429503;
        Sun, 14 Mar 2021 09:30:29 -0700 (PDT)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id d8sm2406459lfm.160.2021.03.14.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:30:29 -0700 (PDT)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: JPEWhacker@gmail.com,
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] codeparser: Fix TypeError in bitbake debug mode
Date: Sun, 14 Mar 2021 17:33:13 +0100
Message-Id: <20210314163313.9983-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 75f87db413 fixed the confusion between bitbake and python logger
but in codeparser still old method of setting debug level was used
causing TypeError, because debug level value was incorrectly returned
and assigned to event.msg.
| File "./bitbake/lib/bb/ui/knotty.py", line 660, in main
|   event.msg = event.fn + ': ' + event.msg
| TypeError: can only concatenate str (not "int") to str

[YOCTO #14298]

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
---
 lib/bb/codeparser.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 25a7ac69..0cec452c 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -212,9 +212,9 @@ class PythonParser():
             funcstr = codegen.to_source(func)
             argstr = codegen.to_source(arg)
         except TypeError:
-            self.log.debug(2, 'Failed to convert function and argument to source form')
+            self.log.debug2('Failed to convert function and argument to source form')
         else:
-            self.log.debug(1, self.unhandled_message % (funcstr, argstr))
+            self.log.debug(self.unhandled_message % (funcstr, argstr))
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
@@ -450,7 +450,7 @@ class ShellParser():
 
                 cmd = word[1]
                 if cmd.startswith("$"):
-                    self.log.debug(1, self.unhandled_template % cmd)
+                    self.log.debug(self.unhandled_template % cmd)
                 elif cmd == "eval":
                     command = " ".join(word for _, word in words[1:])
                     self._parse_shell(command)
-- 
2.30.2

