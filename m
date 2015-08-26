Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 61D4F76DE4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:09 +0000 (UTC)
Received: by pacgr6 with SMTP id gr6so13813486pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KZ3z4qVAafW+7CiUR+n3qcJOhceIHnRye7DyDvTUBB0=;
	b=O196bDaSJ5yBDqXVW9hWmwqbhYrPSM0635IhjIuzNnxeddsb+Ho0myR2MUC/qBgLm6
	rCoDnq5g74fg92EyjQKbFkCD/vVx83bPYszrUECYKDwRMFTKNcIGJPTDJw7vf1EgbUyZ
	Z+DNDhX79RUXv4PGE9WnDGv08kFmoi0m4IEtR8/8c+aleGPvoi0MEI8bTwUashqilsqC
	kxzpwdKmv8xIkKSa/8sMudGDF+trPL/bHCg9AGJB2hwonc0ax+QNBkfnMqqcnwTHQV9W
	vKWCRDAWTXpiOBKpfdA7XcKiR1gYCXajpRiXinXCQlf678YVjZ2At4evd1zwBBkjNTXZ
	I3pg==
X-Received: by 10.68.112.227 with SMTP id it3mr71772986pbb.132.1440607030502; 
	Wed, 26 Aug 2015 09:37:10 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	vw6sm23226840pab.14.2015.08.26.09.37.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:09 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:37:46 -0700
Message-Id: <1440607067-14461-3-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
References: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/3] bb.fetch: handle checksums consistently for mirrors
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:10 -0000

From: Christopher Larson <chris_larson@mentor.com>

If the main fetch method doesn't support checksums, the user will not be
defining them in the recipe, so we don't want to check them for
premirrors/mirrors either. This ensures that we never error due to missing
checksums on a git mirror tarball.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ec0c31a..e229c30 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -628,7 +628,7 @@ def verify_checksum(ud, d, precomputed={}):
     }
 
 
-def verify_donestamp(ud, d):
+def verify_donestamp(ud, d, origud=None):
     """
     Check whether the done stamp file has the right checksums (if the fetch
     method supports them). If it doesn't, delete the done stamp and force
@@ -640,7 +640,8 @@ def verify_donestamp(ud, d):
     if not os.path.exists(ud.donestamp):
         return False
 
-    if not ud.method.supports_checksum(ud):
+    if (not ud.method.supports_checksum(ud) or
+        (origud and not origud.method.supports_checksum(origud))):
         # done stamp exists, checksums not supported; assume the local file is
         # current
         return True
@@ -922,7 +923,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
         os.chdir(ld.getVar("DL_DIR", True))
 
-        if not verify_donestamp(ud, ld) or ud.method.need_update(ud, ld):
+        if not verify_donestamp(ud, ld, origud) or ud.method.need_update(ud, ld):
             ud.method.download(ud, ld)
             if hasattr(ud.method,"build_mirror_data"):
                 ud.method.build_mirror_data(ud, ld)
-- 
2.2.1


