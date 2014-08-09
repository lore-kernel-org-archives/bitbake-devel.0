Return-Path: <tylerwhall@gmail.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 6D08270A72
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Aug 2014 22:46:30 +0000 (UTC)
Received: by mail-ig0-f180.google.com with SMTP id l13so2628289iga.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Aug 2014 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=J1Ca4+o4lhKVyJjv67PAc9rVcEIiTfoa7SkqeTUpj70=;
	b=idW7zktjK2gD1AR7hNEd72iDmd8M94GX6tgJox/PwWU6cxPIshgotqe2ouwSCM1NMc
	Hicf152LUT1L1S1SOCNEpQJGVBCCKP4PxmmnWh+xEgpgq0eqnxEe6vdssyz0f0n9M/tE
	XPkoOOlvdyC72Xzf92VCWj4aI13q3QERWrThn52Owwe72BLboGSblnbLs4LBvrEB49jI
	Uio6Q1UHqXJmMEkV+x370ZA13ivP+klTy+jUp5zVCgYo09KEZtv9uITYSGoYnoHCT8/f
	rO3j4AWTs9tiC4jE9BXepKVQdmvw43XkiOCzm0qjozIZJz47op1AyVd0rVidOdCnnw4L
	wy7Q==
X-Received: by 10.50.25.41 with SMTP id z9mr16872924igf.0.1407624392402;
	Sat, 09 Aug 2014 15:46:32 -0700 (PDT)
Received: from localhost.localdomain (CPE-76-177-97-210.natcky.res.rr.com.
	[76.177.97.210])
	by mx.google.com with ESMTPSA id i8sm27266024igt.17.2014.08.09.15.46.31
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 09 Aug 2014 15:46:31 -0700 (PDT)
From: Tyler Hall <tylerwhall@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  9 Aug 2014 18:46:20 -0400
Message-Id: <1407624380-21750-2-git-send-email-tylerwhall@gmail.com>
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407624380-21750-1-git-send-email-tylerwhall@gmail.com>
References: <1407624380-21750-1-git-send-email-tylerwhall@gmail.com>
Subject: [PATCH 1/1] fetch2: Downgrade the fetch failure log to a warning
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
X-List-Received-Date: Sat, 09 Aug 2014 22:46:31 -0000

do_fetch and setscene are the two clients of Fetch.download(). For
setscene, a fetcher failure is non-fatal since the real task will run
instead. However if we we emit an error log, bitbake will return with a
nonzero exit status even if the overall build succeeded. Leave it up to
the client to decide whether the failure should be considered fatal.

The do_fetch task in openembedded-core handles the fetch error by
emitting an error log message of its own, so fatal fetch failures still
have an associated ERROR: message in the log.

The new output in this case is
WARNING: Fetcher failure: Unable to find file file:///invalid anywhere. The
paths that were searched were:
...
ERROR: Function failed: Fetcher failure for URL: 'file:///invalid'. Unable to
fetch URL from any source.
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index df2f2b0..f3b9463 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1455,7 +1455,7 @@ class Fetch(object):
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        logger.warn(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(ud, self.d)
-- 
2.0.3


