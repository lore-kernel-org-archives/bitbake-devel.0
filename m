Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id B54C779FD0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 14:40:07 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id p4so12522602wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=If3iSQfwcWlNP88hXdN0v4OIv4AaFmHghUw1LjbIgkE=;
	b=OKcMpbasL/oBNNZu9TuD9IFnUFv/6qdSOW5QHWaC502O2wA4uiD7mbVhWOh0w8oLTN
	zWh3KUIhjohCkvap5/WBHMj8DL/uv4yKDcSPFAQshSZtl9D7gSlcAFEcPDybPkP3wV0H
	Ylc+y7n8LhLl+GrDiuiSQ9+Jx5VNMB9/PpF5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=If3iSQfwcWlNP88hXdN0v4OIv4AaFmHghUw1LjbIgkE=;
	b=NeXYZI1ekDXqLkrl9Cmmu2YcMI+6modv+Uqo0/AWd5NYPzlw2q7DmLOFkp/T0b6pRM
	DHuELn2bcEYPt4G6k4HzqxsDhrMZDIUcR5AIYFyG0HY+rqByIjfJAwDvnB7jwVQathaL
	NjcRDI//gW8zmwl3k49n82IjUIIbCE0BtsQbPQrdeQfjpPBsMsiIeV+PiyHoYVDzZRT3
	lQv+8z1K/AKlBPT2OskDuWapW1X3VzEsR4gkPGqAOxXVAaeyKgY9J9mKhhiFS9mJHCts
	GQIfuMsLKrZGhOJAmAlhFhynJM7rGiz6N3dAMSkdMqB9b1c+yNJl60qbFnvnaTpEl3bM
	1inA==
X-Gm-Message-State: AA+aEWZdAM7xqFFEFw02v3HxQzqEYCYENBSWrPnZ5od/FQ9yBUzwXLS4
	RvYhCa4Ct9oN/DZyJcDo8FwrsRq1cMhSqg==
X-Google-Smtp-Source: AFSGD/VJX80LiLcNFQ1K8h8Q5R453J3Gjva/Ue4dnfWbqYdjO8mBULyoHYwidfP+sQurPIOXbUQO6w==
X-Received: by 2002:adf:d146:: with SMTP id b6mr11007470wri.156.1545057608082; 
	Mon, 17 Dec 2018 06:40:08 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a12sm331314wrm.45.2018.12.17.06.40.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 17 Dec 2018 06:40:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Dec 2018 14:40:06 +0000
Message-Id: <20181217144006.32015-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] codeparser: Switch to sha256 from md5
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
X-List-Received-Date: Mon, 17 Dec 2018 14:40:08 -0000
Content-Transfer-Encoding: 8bit

We've reports of hash collision with codeparser. Looking at the way collision
problems occur with md5 and the way our function templating works, I can believe
we may run into issues.

This patch therefore switches to sha256.

Performance wise, parse time could appear to rise by 4s in 374s

Before:

384329 in 2.966s (md5)

After:

349743 in 2.340s (sha256)
34723 in 1.245s (md5)

since we still have md5 used elsewhere in the code, something we should look at
next (using sha256 everywhere is around 5.3s in total)

Unfortunately this does nearly double the size of the codeparser cache file
due to the hash size change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 3f8ac1d5f6..ac995a6a1d 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -33,7 +33,7 @@ from bb.cache import MultiProcessCache
 logger = logging.getLogger('BitBake.CodeParser')
 
 def bbhash(s):
-    return hashlib.md5(s.encode("utf-8")).hexdigest()
+    return hashlib.sha256(s.encode("utf-8")).hexdigest()
 
 def check_indent(codestr):
     """If the code is indented, add a top level piece of code to 'remove' the indentation"""
@@ -140,7 +140,7 @@ class CodeParserCache(MultiProcessCache):
     # so that an existing cache gets invalidated. Additionally you'll need
     # to increment __cache_version__ in cache.py in order to ensure that old
     # recipe caches don't trigger "Taskhash mismatch" errors.
-    CACHE_VERSION = 10
+    CACHE_VERSION = 11
 
     def __init__(self):
         MultiProcessCache.__init__(self)
-- 
2.19.1


