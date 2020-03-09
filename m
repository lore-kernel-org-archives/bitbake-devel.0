Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail.openembedded.org (Postfix) with ESMTP id DCE73616A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:02 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id r15so9797174iog.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zyRSHe4y/VopjXO1OfQSM/EnEPqPaxS9urKIOQA4i84=;
	b=CVpVvskafDBlytSi1Iq9m1TKh/VShl6gRCwtVtH0UrJ7YSULEINWrIcD3RgyqCSMLD
	1YPae/d3ie35feH3/Ufxf2o2AYQBJQObcB6C90L9RqGrFtTmKInQ/wVhSOJnkxFgpbIx
	bHoB+cXbvPaRBr/4DcTvs8qyHhH//X63/U5jrZ742EAISwaDR2SvG8FEwC7tzt1BO4ib
	XP650yG6NNN5PH+RLR1bj2O75DFCZIooWRi5cIlfHr+cE2Q2dcka85OOmVBDmkNZG7ZR
	23ViTk6RLqWBfdzg+wqmD6DCSSvuanUtQMkb3zRoi32NEoob1SY9qQXy8wgnCwxymu7q
	TYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zyRSHe4y/VopjXO1OfQSM/EnEPqPaxS9urKIOQA4i84=;
	b=kxExGc5ulqLclR9OqbP7MQd5TiezODAphOi8QudpeUCvolEICFNDxUc2gm0h5XQcz2
	xP2+3dc00qXarsgQNzRZfs1Bwx4IGtAHkpe92SvHtAMHZu7wcvi2DN13fbRHCfhrooUn
	ReThPOXVEzfjMVmO/W7ha08KkqRXA8d14I0uX6rSK2LY2VGvubyeolYWDnlyvu2bVdIW
	Opjvp6+uWGpmDrcLiUyF7kLW9hJrKiT5hodXztJ0Sa7XTNeCu9v+T7s2Fi7wqhqMbZFg
	vxyUAqFCw2GFYJ+nruLh1zyJVMqwchsyBdx9wKaTuPJB2HRIOjDADleoXxYtrS2NIJiG
	/7og==
X-Gm-Message-State: ANhLgQ1n7qMFj/uIoicDJUIesLmZOZ+T+zxZ/6u6cpK/3UmM5cLDAo//
	bBSgGRT0q+2Y6Oi+WdczwKoSCd491Ko=
X-Google-Smtp-Source: ADFU+vvJYRp360LfZ0sGp6K914KIUrcdCjJYmuameXZEnDpZ784VYbDfKnhEB+WIZyUd/G/tvyFBDA==
X-Received: by 2002:a02:5ec2:: with SMTP id h185mr5806438jab.2.1583771642858; 
	Mon, 09 Mar 2020 09:34:02 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.01
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:44 -0500
Message-Id: <20200309163353.15362-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 06/15] bitbake: lib/bb/msg.py: Add filter utilities
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:03 -0000

Adds generic filter utilities that can be used to filter when the log
level is greater than or equal to a defined value, or below a defined
value, as well as a generic function to translate a string to a logging
level (or bitbake logging level)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index c70fd80806..8561826a6e 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -135,6 +135,28 @@ class BBLogFilterStdOut(BBLogFilter):
             return True
         return False
 
+class LogFilterGEQLevel(logging.Filter):
+    def __init__(self, level):
+        self.strlevel = str(level)
+        self.level = stringToLevel(level)
+
+    def __repr__(self):
+        return "%s level >= %s (%d)" % (self.__class__.__name__, self.strlevel, self.level)
+
+    def filter(self, record):
+        return (record.levelno >= self.level)
+
+class LogFilterLTLevel(logging.Filter):
+    def __init__(self, level):
+        self.strlevel = str(level)
+        self.level = stringToLevel(level)
+
+    def __repr__(self):
+        return "%s level < %s (%d)" % (self.__class__.__name__, self.strlevel, self.level)
+
+    def filter(self, record):
+        return (record.levelno < self.level)
+
 # Message control functions
 #
 
@@ -175,6 +197,19 @@ def addDefaultlogFilter(handler, cls = BBLogFilter, forcelevel=None):
 
     cls(handler, level, debug_domains)
 
+def stringToLevel(level):
+    try:
+        return int(level)
+    except ValueError:
+        pass
+
+    try:
+        return getattr(logging, level)
+    except AttributeError:
+        pass
+
+    return getattr(BBLogFormatter, level)
+
 #
 # Message handling functions
 #
-- 
2.17.1


