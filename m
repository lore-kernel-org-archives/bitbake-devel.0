Return-Path: <mounesh.sutar@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 92B066B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 11:08:53 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id l10so3782994wmg.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=IEMjIuEqF+qckzS76nKRPRE3+urlKZCC6KqIo6VttF8=;
	b=dtV+g94T1ehSUpIfwSHpM/iBptBWEG0nlL+WvwH724XGQ7sGoGSGVoS843IlkbpHWA
	ffNWMiFClRNF8N9RDS/2CJEY2k23elP3y8XE8wR6gD5pzxfQStlpcn5wWTbFnKgmD6pO
	OWRqlwve3z+tGwgFUaKGwSranD7XdBDNgAv2JU9Ec0I49TSPhGc6qIlYiWycPo2ChO6u
	oVD6NTeYXrdadjRdlbov6gDt/sXdIBr7xsng5EwBWukQzBlDlr4qS56mmzHuShCHmUKD
	XqmvDBTwhI8yCqLwATOP6lIW6KyOSD8cPNhMyfaOtUNB3eXjqICFz6RGi0rPH0dYfrdP
	0uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=IEMjIuEqF+qckzS76nKRPRE3+urlKZCC6KqIo6VttF8=;
	b=YK+5ZqpcgATjqLxR49upAtP2kPMKeMHl4eJ6Ph7YTYQYXRjtjpN75DHRPVJNKDcuFu
	dtaq1iMMgCaW9BSdUxaa9FV8tQSKSQdSxOn07vNozQrrM1pqYHi/15eWRxh+PXngJFun
	Wm3UKF91gA5cYW7G6psJ+fBpXK+p0L+SR6T37O9w/JIMTeMY98wikTY3TpLae9VuKYBb
	9rKB6ZLKUEWZSUlGeStytRsAiUqmEKiV1sZOuntccnQuWAo4JN2RLPekvnaQK2YLwWam
	zcZqYvQAUzHNKpqaizE7pzhRFGXWRk/hYLQ4ClJEoVbZOUHD/mie961Y30z8PMMfw+0w
	7ZNg==
X-Gm-Message-State: AMCzsaVcVTeU1SsfpYL0moH6LQpSY0nhiRAE1tNtc1KYLNde3DjSTe16
	ugHRIUqswBImop3sbkM2/qSrtQ==
X-Google-Smtp-Source: AOwi7QCZXLznDr8cC8C3nU/G7l5haLJwDh79VET/22bPZE9r8WNLnzD5aaEoa0nTBnQHh0pt3dukwg==
X-Received: by 10.223.187.1 with SMTP id r1mr1689590wrg.253.1507806534219;
	Thu, 12 Oct 2017 04:08:54 -0700 (PDT)
Received: from msutar-VirtualBox.world.mentorg.com (nat-sch.mentorg.com.
	[139.181.36.34])
	by smtp.gmail.com with ESMTPSA id l7sm5890163wrg.69.2017.10.12.04.08.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 Oct 2017 04:08:53 -0700 (PDT)
From: mounesh.sutar@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Oct 2017 16:38:45 +0530
Message-Id: <1507806525-31342-1-git-send-email-mounesh.sutar@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: [PATCH v2 1/1] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Thu, 12 Oct 2017 11:08:53 -0000

From: Mounesh Sutar <mounesh_sutar@mentor.com>

bitbake is parsing all recipe files, against layers BBFILE_PATTERN for warning message display.
In case of sublayer with lower/equal priority, then all sublayer's patterns are not being
considered for pattern match. While checking recipe file against matching pattern,
the first matching pattern is accepted and added to matched list, while remaning PATTERNs are
not being considered. With this, the recipes are being neglected from PATTERN match.
This fix let's parser run through all the layers PATTERNs and on matching added to match list.

Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f44a088..4cf00ee 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1412,13 +1412,23 @@ class CookerCollectFiles(object):
         self.bbfile_config_priorities = priorities
 
     def calc_bbfile_priority( self, filename, matched = None ):
+        objectInitialised = False
+        tmppri = 0
+        tmpregex = {}
         for _, _, regex, pri in self.bbfile_config_priorities:
-            if regex.match(filename):
-                if matched != None:
-                    if not regex in matched:
-                        matched.add(regex)
-                return pri
-        return 0
+            if regex.match(filename) :
+                if objectInitialised == False:
+                   tmpregex = regex
+                   tmppri = pri
+                   objectInitialised = True
+                else:
+                    if len(regex.pattern) > len(tmpregex.pattern):
+                        tmpregex = regex
+                        tmppri = pri
+        if matched != None:
+            if not tmpregex in matched:
+                matched.add(tmpregex)
+        return tmppri
 
     def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
-- 
1.9.1


