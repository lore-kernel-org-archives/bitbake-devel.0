Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
	[209.85.214.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1291A71D7F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 19:35:31 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id c7so4330823itd.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=1QNULyWZs1QuQINYGhmIw3AVoX2/yj1jkUdYa23j2VQ=;
	b=a461ST40LP+pa1yV27S2cMKlYCgIRhuU6smid4kPJWHHpAlpXHuRvulEwso9He4B8L
	yUiCsOSInnSV1BUloRW8+VJZfq3safGJWDcLkTqYfwIO/YOKs0Bb1XSHpSb+1mBbLNOn
	MwTfS7e7ZGPnUGrxMDE2ASKU228nEGVS9XQzlBQE9DkmSfSHsx6D7zGviHj5gVjPFsDT
	LP7wDsQcIOzcaqA+Z+rlWOi3swmj8k6xezAxbHePM6uboHm09pXp5Jl4/EBarSPg8/cG
	7qMSk7qwrC8RAhAHbxpm9C1sPxpZHCO5IyWK6zc90ibQ+7WnXnYOBJ4JlZwvU07EOR85
	BvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1QNULyWZs1QuQINYGhmIw3AVoX2/yj1jkUdYa23j2VQ=;
	b=E2NXl6Z71kEZb1/rnNE/gG6+M0Wgs1CWiHmZa8yxqVYRbgksAyDqJ3TgSPQ/0Lqz4z
	dc5gyM8eYDx4RVyPp//Dw0LWnOyveV+2Rd97QrRZrwCT4bZ9JWjbYCFJ+ph3kxZTs+JU
	n15GSotUGL/46R4nnNGAoFqLLkgvq/lJMIG2l/DUqGwxcV0HYdY+jjxN2ht1q+zgMJw1
	R8hbrm+y2fE4AsQcMCNK2DJW8bAo7OWV0Cx9t25QZYTDQ/2q2auwLgpAGpntYTwvTVK2
	CRb6m9pAHXVEeOiRXwWkeykXgW2zcJrXCweKlc65Bg+F+L9mFSybGH3h9AMzN59yAdhi
	C00A==
X-Gm-Message-State: AIkVDXLj1CWjv2UsUzfs1/0DP9Tl9uSCjJljh97soBYjiKiOhaTmtVuFZsEE6LEKB0Nzk5Wx
X-Received: by 10.36.217.150 with SMTP id p144mr279888itg.90.1484854532145;
	Thu, 19 Jan 2017 11:35:32 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A5686E.dip0.t-ipconnect.de.
	[87.165.104.110])
	by smtp.gmail.com with ESMTPSA id x128sm84150ite.11.2017.01.19.11.35.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 19 Jan 2017 11:35:30 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 20:35:15 +0100
Message-Id: <9139a7fdc76f7ec79020374294fcdd3c7f644952.1484854453.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.71d0a8886d0d5ad010cacb3c2ae130efc35fc5f5.1484854453.git-series.patrick.ohly@intel.com>
References: <cover.71d0a8886d0d5ad010cacb3c2ae130efc35fc5f5.1484854453.git-series.patrick.ohly@intel.com>
In-Reply-To: <cover.71d0a8886d0d5ad010cacb3c2ae130efc35fc5f5.1484854453.git-series.patrick.ohly@intel.com>
References: <cover.71d0a8886d0d5ad010cacb3c2ae130efc35fc5f5.1484854453.git-series.patrick.ohly@intel.com>
Subject: [PATCH v3 1/2] build.py: add preceedtask() API
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
X-List-Received-Date: Thu, 19 Jan 2017 19:35:32 -0000

The API is required by the revised rm_work.bbclass implementation,
which needs to know all tasks that do_build depends so that it
can properly inject itself between do_build and those tasks.

The new API primarily hides the internal implementation of the "after"
and "before" dependency tracking. Because tasks defined as
precondition via "recrdeptask" may or may not be relevant (they are for
rm_work.bclass), the API also includes support for that.

There's no default value for including recrdeptasks, so developers
have to think about what they need.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/build.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 271cda6..c6104a4 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -862,3 +862,19 @@ def deltask(task, d):
         if task in deps:
             deps.remove(task)
             d.setVarFlag(bbtask, 'deps', deps)
+
+def preceedtask(task, with_recrdeptasks, d):
+    """
+    Returns a set of tasks in the current recipe which were specified as
+    precondition by the task itself ("after") or which listed themselves
+    as precondition ("before"). Preceeding tasks specified via the
+    "recrdeptask" are included in the result only if requested. Beware
+    that this may lead to the task itself being listed.
+    """
+    preceed = set()
+    preceed.update(d.getVarFlag(task, 'deps') or [])
+    if with_recrdeptasks:
+        recrdeptask = d.getVarFlag(task, 'recrdeptask')
+        if recrdeptask:
+            preceed.update(recrdeptask.split())
+    return preceed
-- 
git-series 0.9.1

