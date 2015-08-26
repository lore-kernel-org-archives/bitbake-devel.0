Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6899276DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:21 +0000 (UTC)
Received: by pacdd16 with SMTP id dd16so165635398pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1XXu54bvoOrFH4TZfkrLsVWnM6In/9+ihA4g6Lshil8=;
	b=Gl5DHRbE/kXYwJhv3ZXFDzNsIjZK+smtFXM7z74R+A4m8uY+4RH8M0t57Cm9Xq/dhA
	/LLS+EJbR8g7HyfwUd7AUz2aka2JT/L5wNaukzB558r/lDtso6T4mgCNDuPJsuuO6szJ
	26DlinpRxfsx7jy+vJBK3N7arqqDyS0VJB4k1e/a+xM2gFbRrSIucSpHyGv955WNyTAy
	EF8fa6JGZvq78FyskvcUvqI0X6jdRk9oM6xjbThFOjwAzC8FwMr5wBD2UED757WOl6zm
	GhDDcmKPtxoAstoMyr1xjeGGijlsV/t0SpAoLAUYlJ7HsrcQV5oBXVlVqoNyRRP/g1P8
	YnCQ==
X-Received: by 10.68.196.99 with SMTP id il3mr70261564pbc.166.1440607042327;
	Wed, 26 Aug 2015 09:37:22 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	qe3sm25214673pbc.73.2015.08.26.09.37.20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:21 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:38:05 -0700
Message-Id: <1440607088-14563-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
References: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/4] bb.fetch: simplify mirror tarball handling in try_mirror_url
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:22 -0000

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
index 3d53b63..04d9679 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -937,8 +937,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         # We may be obtaining a mirror tarball which needs further processing by the real fetcher
         # If that tarball is a local file:// we need to provide a symlink to it
         dldir = ld.getVar("DL_DIR", True)
-        if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
-                and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+        if origud.method != ud.method:
             # Create donestamp in old format to avoid triggering a re-download
             bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
             open(ud.donestamp, 'w').close()
@@ -947,7 +946,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
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


