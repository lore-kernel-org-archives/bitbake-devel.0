Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 200FC76BEA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:11 +0000 (UTC)
Received: by pacgr6 with SMTP id gr6so13814164pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3a4Ejsg10qEWZT/aBl5mvpzscrCTgeXGk7WhCEprHlk=;
	b=LWnOms0GecpJeO9Llb54B6d8vmyjDnuEFvu3xKqkUWaNfAJhWdyYYc1kqftiusfu2m
	OwaeoIXZIb8Q8J1IilymOUJc3kVPrONWnxEVPmFuDak4Jna0t/AoUUJcLbqcTvDprt+B
	l5sXiMzfjbAg01RXei99b25E6jEsvXE/RcfRtxd6A3iuMbo6NCZaDSoXvCAuVSFSfyc5
	gyRbdJmEW6LUuBkRITcVGWDhpGpVtzEFuGjVCrHnDNbvuC1ooaMbYreJopiuVd2QDDxn
	cxXy/c+is/szZGFzleajdyOY6VHN+XQbMFWCBRsNnVQmvXSb8ABP3r9xILN/bOxbfLhH
	BJpg==
X-Received: by 10.68.254.69 with SMTP id ag5mr71768198pbd.130.1440607031918;
	Wed, 26 Aug 2015 09:37:11 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	vw6sm23226840pab.14.2015.08.26.09.37.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:11 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:37:47 -0700
Message-Id: <1440607067-14461-4-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
References: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 3/3] bb.fetch: don't remove the clone when an update fails
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:14 -0000

From: Christopher Larson <chris_larson@mentor.com>

When our clone exists, but is out of date, and the attempt to update it fails,
we don't necessarily want to remove the entire clone, particularly if it's
a large repository.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e229c30..3d53b63 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1590,7 +1590,8 @@ class Fetch(object):
                 os.chdir(self.d.getVar("DL_DIR", True))
 
                 firsterr = None
-                if not localpath and ((not verify_donestamp(ud, self.d)) or m.need_update(ud, self.d)):
+                verified_stamp = verify_donestamp(ud, self.d)
+                if not localpath and (not verified_stamp or m.need_update(ud, self.d)):
                     try:
                         if not trusted_network(self.d, ud.url):
                             raise UntrustedUrl(ud.url)
@@ -1618,7 +1619,8 @@ class Fetch(object):
                             logger.debug(1, str(e))
                         firsterr = e
                         # Remove any incomplete fetch
-                        m.clean(ud, self.d)
+                        if not verified_stamp:
+                            m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
                         localpath = try_mirrors(self, self.d, ud, mirrors)
-- 
2.2.1


