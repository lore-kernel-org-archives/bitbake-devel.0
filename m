Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SwKyw-0004PA-D4
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Aug 2012 00:32:02 +0200
Received: by ggnp4 with SMTP id p4so5996358ggn.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jul 2012 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=UT6JLA3MuJu+WvWjI+wTMn0f8i+42BVKkfUE0BnrKCw=;
	b=kd1cBLCyrDpAvu8KO5Ggyq+d4Jg9eoo+qvQ1Vwi0NJ1vnOxRMMsBSE6JnfaJJfgoOV
	M8LAz8qlL+bDJHzV97p8xkX74VQIxPx3/QWBpN9fKdoT0r1cb5psFXUmwpPfUl3JSiiE
	Q01Mv1jbjl/wkLceoJsjDdHN5cjVto9Ypbz2fcNkCwpARMzUYVbclXLvAzmwjMqhaJK/
	wD+DQPMjwaVrijx3lT2O+RbJWMA1iZYlNuFcd1W1KuTG1YmgL3p02Ey+ZGKDtfY/vf6Z
	BTynw4uw/GG33bli8sGJ8IQAnVG0pHXPAkUctBJytmj5VbqgDwlr3I76z4gmi6j5mW5X
	aIQw==
Received: by 10.66.78.42 with SMTP id y10mr35442925paw.31.1343773224261;
	Tue, 31 Jul 2012 15:20:24 -0700 (PDT)
Received: from precise64.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id ov6sm1136612pbb.41.2012.07.31.15.20.21
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 31 Jul 2012 15:20:23 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jul 2012 15:20:14 -0700
Message-Id: <1343773214-29621-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] fetch2: handle broken symlinks in local mirror handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 31 Jul 2012 22:32:02 -0000

From: Christopher Larson <chris_larson@mentor.com>

If a file:// mirror is being used, the fetcher will create a symlink to the
local file. However, if the local file gets removed, that link will be dead,
and os.path.exists() returns False in that case, so it tries and fails to
recreate the link. Now we unlink such a dead link if it exists.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fa963be..8f5b097 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -557,7 +557,11 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
             return None
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):
-             os.symlink(ud.localpath, origud.localpath)
+            if os.path.islink(origud.localpath):
+                # Broken symbolic link
+                os.unlink(origud.localpath)
+
+            os.symlink(ud.localpath, origud.localpath)
         update_stamp(newuri, origud, ld)
         return ud.localpath
 
-- 
1.7.9.5



