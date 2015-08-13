Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 8277D765A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:44 +0000 (UTC)
Received: by pabyb7 with SMTP id yb7so46980896pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=aTI2zeum0VUVuFGE00d7dUVeaWCima6+rAZXnurB3AM=;
	b=XPkyzrQ0ANv2EQKbpvTTrowwrYw7Ch20HWjlizcT1Rvh3PRSFdHtBdo9Ujte868x/o
	l86tY5TDPNT1txDAHSBBUBMrXUhOv/+R3Y0FYfpFR0hXFfEOKNMjvLUd4BeKkl14BeHo
	uNHM1wZnYByB13Wdi8zBVHQtmKEvZXiaKX17adKKw0QR3ainnOPtb0N+9yjIjXhTnc8C
	sNlKMCgTM397bgUYnBOn6u3znhs+c2ltefENzzK+ntmqccELkYXu0RhW6SewT1IXc+oc
	6OfqjfxoqC3LFGKZIMsUsZXXMvcLYFXHVD7p8BrysfQTwVviwyb/kniUODIr1/k2sMoq
	wxYA==
X-Received: by 10.66.122.207 with SMTP id lu15mr82130736pab.146.1439509605309; 
	Thu, 13 Aug 2015 16:46:45 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.44
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:44 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:37 -0700
Message-Id: <62c33b7fadf2822c87656fd620d34cfab3bba08d.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
Subject: [RFC PATCH 3/5] bb.fetch: simplify mirror tarball handling in try_mirror_url
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:45 -0000

From: Christopher Larson <chris_larson@mentor.com>

Rather than checking mirrortarball explicitly, simply check and see if the
fetch method used for the mirror differs from the fetch method used for the
original url. If so, and the localpaths differ, we can trust that further
processing by the original fetcher is necessary.

This will make it easier to add the ability to support multiple mirror
tarballs, to implement shallow git mirror tarball support.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7b4d130..c5e1758 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -933,8 +933,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         # We may be obtaining a mirror tarball which needs further processing by the real fetcher
         # If that tarball is a local file:// we need to provide a symlink to it
         dldir = ld.getVar("DL_DIR", True)
-        if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
-                and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+        if origud.method != ud.method:
             # Create donestamp in old format to avoid triggering a re-download
             bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
             open(ud.donestamp, 'w').close()
@@ -943,7 +942,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 os.symlink(ud.localpath, dest)
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
-                if hasattr(origud.method,"build_mirror_data"):
+                if hasattr(origud.method, "build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
             return ud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-- 
2.2.1


