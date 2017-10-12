Return-Path: <sutar.mounesh@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 712D46059F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 10:58:11 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id t69so12076015wmt.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=4JuJsCGuSRVeMMuEEf28lBJStsLknac9NCqfbzwqAk8=;
	b=DXaiZvMdSxum2pZVIF03ml/jzNI1kv3HvS43hQfTj/7JHR0ESTRcEqVyA8LnGgaVwy
	CQTJR3spTsitXCsN+/8TdbrNaWryEdiKkoAFhWJuoLOgSNKtu/dxzywXgoEPmlawNVjx
	rTP9gIY934501V/J9QjW9veqQESFU30LNijsw5K71rwiRKtOxQDj6hHc7HF+9srKtiHt
	74/TCOF8UXq1Ip61SneXEwnUe3Nu84moC01wWop/uvVPOheayJ8J8AM+tsYRm1msXzLP
	M6kmzk7cab5u6hD2tqea8/4OvALscmwU2Zzsb+KPIWdawBdkT86/lzf4bNR+6St4rnfw
	xc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=4JuJsCGuSRVeMMuEEf28lBJStsLknac9NCqfbzwqAk8=;
	b=POr4Ui9/TfJ+A6e26qo4n4g5WQVBM1h6O4F+yQQbn/vdt/3wNsWPVuyY+oPAnH9G7W
	P5ZiDM1RN6Km4UoYxVNQANncDdkP2O5yIkOXJQJpoH2wTM+bE9svEm91zUfIjWRnJrZq
	11AqgbvQIyw7+vSxrvJSz86fhlNZzEa4ry3C3rCjfP9sRFeiISqGFeRww4XQA5WFccPW
	3vDbhOrCVqVIyVwSzSFdxTwRdMfiul9Z86szwzI9CETFuwt7qlXbca7ZUXymzMceJdrA
	S+HEQaBHFhUOZWiuoGheEX50whmrVlNtrfFrW+5qTE9FqPaaF5w7L1CVQprhfsSIxRQk
	LMsg==
X-Gm-Message-State: AMCzsaWnA6YPNsJmpR9YBQY4xzGT1tuzDyAFGQxxy7ixtsYr7vkz5lIx
	ctYPWbc7/LQBic6EXHp02bPrzA==
X-Google-Smtp-Source: AOwi7QC/WAJ0RrHYYQH6qY8qB03n7+Y9Lpf0ajjvsYre9zzGnhTTqR17x7U4+5ULOTzgBPHqUDMfCg==
X-Received: by 10.80.222.130 with SMTP id c2mr2481507edl.218.1507805891984;
	Thu, 12 Oct 2017 03:58:11 -0700 (PDT)
Received: from msutar-VirtualBox.world.mentorg.com (nat-sch.mentorg.com.
	[139.181.36.34]) by smtp.gmail.com with ESMTPSA id
	q16sm7869311eda.87.2017.10.12.03.58.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 Oct 2017 03:58:11 -0700 (PDT)
From: Mounesh Sutar <sutar.mounesh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Oct 2017 16:27:53 +0530
Message-Id: <1507805873-31091-1-git-send-email-sutar.mounesh@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Mon, 16 Oct 2017 13:29:38 +0000
Cc: Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Thu, 12 Oct 2017 10:58:11 -0000

From: Mounesh Sutar <mounesh_sutar@mentor.com>

bitbake is parsing all recipe files, against layers BBFILE_PATTERN for warning message display.
In case of sublayer with lower/equal priority, then all sublayer's patterns are not being
considered for pattern match. While checking recipe file against matching pattern,
the first matching pattern is accepted and added to matched list, while remaning PATTERNs are
not being considered. With this, the recipes are being neglected from PATTERN match.
This fix let's parser run through all the layers PATTERNs and on matching added to match list.

Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
---
 bitbake/lib/bb/cooker.py | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

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


