Return-Path: <gmstima@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id 87B2260234
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 10:22:59 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id s29so1553770lfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Vevi3YzeEk9OQbKMF6dymUk/4HJVDQavlfPyzJkRqXo=;
	b=kTzaFMIP/4ZnyD285VToxUFLfWq4xIjOhTBCy2sjvqjhmdskBegdf6ZSpPg4HIJAyW
	LQ1UEP7WELoCT+bxHC7OaGrDjdO8f6LZXOiAdvwiKgGDHiOD0D5qN52kefnLKhXIkgIS
	85WFNvngOEWQZ3kDPjsZkdutWP+Csno8cPBlzRBqej+uB7ZQIoQf5mnwWQCw8PjjB+ub
	XldtvLiZf+8Flqn27zxo00Q/soewdAccbFDAN1AaXVU3zGdgriR+jD+aiP8FBnmK61zR
	8uP37En8T2xBVxjXMTfT9iqvuPw6fiAHPatTXfOIMY8n6Jf7IecsJNcssdfUgdECX2q8
	e/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Vevi3YzeEk9OQbKMF6dymUk/4HJVDQavlfPyzJkRqXo=;
	b=PSPC8g+s127gHnBjE1XEgbttL4o58d8R+8c2/fNh6Yo9dyptL1o/D2DVcl89TwDslo
	VFWSs6aSffFWKIjAc4rTWHCb36syb/BOjPo8DDmMflE9ePtFIloM1VXksvwzgdWYyWTi
	NOqv8BYuoe7smmitoWrzG9Z7jyCxTvhtdcujWdqTXPvBSqYKfeLjhSAdkug4u8B93Vwr
	P605hqFQMv3YKZ8Sa4l03V1p6mfFV2K3dRLifzrdAhuPWQJ1P1nh55fAGSlz+3zr52zJ
	NeOYHjrvGQkFqYqFperfcNmtknPHjeksYGzT4ZdMMQzJDEeCG4u/zE//0Ezo7OTqnkn0
	HgiA==
X-Gm-Message-State: AE9vXwM+dvM6y+6yghMSqwUKGTsue8I5ChizJILUPDBWI2E3f5QIz1PC41LHdjl56It9lA==
X-Received: by 10.25.212.5 with SMTP id l5mr10276325lfg.73.1474971780512;
	Tue, 27 Sep 2016 03:23:00 -0700 (PDT)
Received: from work.int.attocapital.com ([77.91.146.126])
	by smtp.googlemail.com with ESMTPSA id
	j196sm302031lfg.9.2016.09.27.03.22.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 03:23:00 -0700 (PDT)
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 13:22:47 +0300
Message-Id: <1474971767-30806-1-git-send-email-gmstima@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
Subject: [PATCH] bitbake: Correct broken symlink behaviour
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
X-List-Received-Date: Tue, 27 Sep 2016 10:23:00 -0000

From: Roman Savchenko <roman.savchenko@attocapital.com>

When making new symlink in case when link name does not exist
possible broken symlink behaviour should be taken into account.

Signed-off-by: Roman Savchenko <gmstima@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6ef0c6f..6638b34 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
     bb.utils.movefile(ud.localpath, new_localpath)
 
 
+def create_symlink_if_not_exist(source, link_name):
+    """
+    Tries to make link to passed source if link name does not
+    exist or it is the invalid symlink.
+    """
+    if not os.path.exists(link_name):
+        if os.path.islink(link_name):
+            os.unlink(link_name)
+
+        os.symlink(source, link_name)
+
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -962,20 +973,14 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
                 open(ud.donestamp, 'w').close()
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
-            if not os.path.exists(dest):
-                os.symlink(ud.localpath, dest)
+            create_symlink_if_not_exist(ud.localpath, dest)
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
                 if hasattr(origud.method,"build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-        if not os.path.exists(origud.localpath):
-            if os.path.islink(origud.localpath):
-                # Broken symbolic link
-                os.unlink(origud.localpath)
-
-            os.symlink(ud.localpath, origud.localpath)
+        create_symlink_if_not_exist(ud.localpath, origud.localpath)
         update_stamp(origud, ld)
         return ud.localpath
 
-- 
2.7.4


