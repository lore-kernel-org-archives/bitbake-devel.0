Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id D4654605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:43:57 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id yl2so15275587pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=efftuHnzHxd4ouh77n+h2gikTLnzoka7/iUULHeyP4w=;
	b=JqswAoU0989LNixHJnNT88Iu8b/uZu/0/mBkC22t+4RvNncpY6g58NFvcdyC7OJifr
	q+E4cdGI78Fbv6Ak23OY/SYuv09Ulf0dGM/4Blrm9Gd1FcZ9Tq/xF5/exDum/6ypZw81
	ExGDZCFBS9baJIR5zDBEfwWjiOM9FzftUzHEQqHSgd0s64b5Qtr0BJVcQZF7P69WbkOh
	Bl3IdW8yqy/SFcTxxK6ZzrjmjVcWdWGVeNm+tl6p7GmXXIFDeDUAjE0zN4wKLtez/jH9
	SiEZORlc++3SR3dPbE7y3duaTfmDck/fHibsrBUGJnPYaBh/2IWoNXko/43KU1U4Cyhq
	eeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=efftuHnzHxd4ouh77n+h2gikTLnzoka7/iUULHeyP4w=;
	b=UecRDj0HDMrMlNBYnCBRcQx9N5VFE2VLYuprA2CkQdq+9nGRlhTezM4Gq//XQiQ5Mm
	peMXGZecTCYyczYLndv53Y83nL7SHLvzvijNsYSu2BgIuTsxIKC5n9ef7jKSkWD9zn1l
	iRhlzl9PO3ttqDW8nIVTrJK9xQB+mXxTMfyeX7th2THrX49wq8U0v9H20IcvqQer/z55
	s3Jt8DiqlXeTGbTVBbraGPs62f0qpmh2ZJHvzmbOoKMTzFvUzd1J9GBuWANuoWHDHT9S
	3Rd0HAYtvKjD9m8UHRrO9mumAzqIYqymULuMZvMCrxP9+hOFxEn4TngGc7usdvuaYZ+E
	L+sw==
X-Gm-Message-State: AOPr4FULp4dTaKCGb5KHOof2PsPBho09yHrHuUai/JFTm7VHPlZoTW2lFK3Sdy7Te6K4NA==
X-Received: by 10.66.167.40 with SMTP id zl8mr39423414pab.8.1462045438904;
	Sat, 30 Apr 2016 12:43:58 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	fh14sm33540798pab.31.2016.04.30.12.43.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:43:57 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:43:52 -0700
Message-Id: <fec58af5443888769f2737837bb8b307d7a7c32f.1462040900.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1462040900.git.chris_larson@mentor.com>
References: <cover.1462040900.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 1/3] bb.build: handle __builtins__ as a module
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
X-List-Received-Date: Sat, 30 Apr 2016 19:43:58 -0000

From: Christopher Larson <chris_larson@mentor.com>

Fixes pypy support.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index db5072c..a5b99ed 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -61,8 +61,13 @@ def reset_cache():
 # in all namespaces, hence we add them to __builtins__.
 # If we do not do this and use the exec globals, they will
 # not be available to subfunctions.
-__builtins__['bb'] = bb
-__builtins__['os'] = os
+if hasattr(__builtins__, '__setitem__'):
+    builtins = __builtins__
+else:
+    builtins = __builtins__.__dict__
+
+builtins['bb'] = bb
+builtins['os'] = os
 
 class FuncFailed(Exception):
     def __init__(self, name = None, logfile = None):
-- 
2.8.0


