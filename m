Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web12.48797.1591048199966671816
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:50:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=LHj/1Lxy;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id bh7so458898plb.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFWLywHUm0HXSp6XmwReaLd6W54PUwvEWB9wsisPuqk=;
        b=LHj/1Lxy4T+CogMv+eqxsmLTw80QS9dK9NmdARQuhfs3FgMuKXCR0pYw+X7aarvup1
         QwfZechxxKjSNCLJprjdkns14xw7LVEiWT+UrMcAgVpE28AEB+fai8sYwbySGCyfIcxJ
         8c/PP6CYazwaNnml0jjcxfTxBH9mvIRJwYebvgkT7dKGrqpQTWksDJcBEBJGBiPkNEvI
         0AX62qi0t2VmHdsk3KxXgQ403u5E9J03Shp7eCloGQvqtvEfOBgBz0sFC626s0Ukw0tf
         ZAFefFGfKQvdmlZCwzLuq5NHOCjemGwFatrlT6ULJd+B0qim3EDGteS9zjnvn7V2taSz
         vNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFWLywHUm0HXSp6XmwReaLd6W54PUwvEWB9wsisPuqk=;
        b=nXmz3KJ2rZA+G9t1RsTIVoJDeJb+1s1TYiDjnxQBp9COBNeMD7zAN+rTZozOpXf3on
         IZjmaHk3Vx6VmJSX0N76X1B9eP7oxDwwVIjpdmJ2mYQWAwgiPL7/lCSTa2wc+Nsnv2oD
         wmfDApspSJiyAwT4PZzNEM3UaSjyDXvGhmNsYE8IUh+BnytokTA4n5PzJqB+k/rgc17A
         ybVVAEs8+Mtt8VCWdb4IgezH5NfF9uASir/G59qdJIOVKcbdE01T0qDuJGH0UbMWPJya
         y24KZtWJF0bGU2awZKW3kBqXOgBcjEltUMmCHX7O4FnM0XmcFR1Ap25MN/xIIoJJMazc
         8Xgw==
X-Gm-Message-State: AOAM531HhoaSaRa/EF+qCXyB5Aw3e85q2nZN05bphefLIKlTn+UNkrmj
	IDGPP8Nji2rBLgW2yAU3nrbyYoKcDhU=
X-Google-Smtp-Source: ABdhPJx8uJ4qQiWelzJ+A5eNHVqg2TlNhFc7CD1pZ8ja76i3urt7QODMfSTKGocpmQAjlLZyRSYiaQ==
X-Received: by 2002:a17:90a:8c8e:: with SMTP id b14mr1480220pjo.222.1591048199254;
        Mon, 01 Jun 2020 14:49:59 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:58 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 8/8] bitbake: command: Move split_mc_pn to runqueue
Date: Mon,  1 Jun 2020 16:49:45 -0500
Message-Id: <20200601214945.32481-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of the other multiconfig splitting functions are located in runqueue
so move the function to split a pn/fn there also so that its easier to
see them all together. Fixes a case where the findBestProvider() command
wasn't working for multiconfig because it was looking for a prefix of
"multiconfig:" instead of the newer "mc:"

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/command.py  | 8 +-------
 bitbake/lib/bb/runqueue.py | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f45b6e5320..8ed3d8f679 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -138,12 +138,6 @@ class Command:
     def reset(self):
         self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
 
-def split_mc_pn(pn):
-    if pn.startswith("multiconfig:"):
-        _, mc, pn = pn.split(":", 2)
-        return (mc, pn)
-    return ('', pn)
-
 class CommandsSync:
     """
     A class of synchronous commands
@@ -438,7 +432,7 @@ class CommandsSync:
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-        (mc, pn) = split_mc_pn(params[0])
+        (mc, pn) = bb.runqueue.split_pn(params[0])
         return command.cooker.findBestProvider(pn, mc)
     findBestProvider.readonly = True
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3d54c2b88a..cb5aa80f2f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -46,6 +46,12 @@ def split_tid(tid):
     (mc, fn, taskname, _) = split_tid_mcfn(tid)
     return (mc, fn, taskname)
 
+def split_pn(pn):
+    if pn.startswith("mc:"):
+        _, mc, pn = pn.split(":", 2)
+        return (mc, pn)
+    return ('', pn)
+
 def split_tid_mcfn(tid):
     if tid.startswith('mc:'):
         elems = tid.split(':')
-- 
2.26.2

