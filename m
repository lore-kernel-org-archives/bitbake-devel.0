Return-Path: <armccurdy@gmail.com>
Received: from mail-ob0-f193.google.com (mail-ob0-f193.google.com
	[209.85.214.193])
	by mail.openembedded.org (Postfix) with ESMTP id 698A57706E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 00:43:43 +0000 (UTC)
Received: by mail-ob0-f193.google.com with SMTP id x5so1450381obg.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hwl7K7WgCVUdAPhdlxpSz9v6Hk+upfubqO7G9jPtSKk=;
	b=X0e0p7U0Z9BsvcZ9ETylhBoLVwQdAKowYoTChr6fOsjVzOemFLApLB1sN6wi5Kbeyu
	Btwa75sevenEA097BnnGIHVBePdJYCFF45O4FS1Yp4PLFBpsCTLsZv4dcFwWdwGr81pT
	r/R9XkD9ZOkQ7Slzbrx0UVI0vMKFEpfuXCTtDN7HQQ1NOIq0+ZJYPYxgVpKk9C1yPdfG
	DB1GXcgr9tfBIfsL7PEUqMVJgyYueH7vleuTiUGO/I8kJYAbglzSxAUylo2B9gbMkCfd
	PZCdvyQP+oJKmCOf2+ZedVL0LYCGBZ097r99raI1qdisjVX/9oyFQndGvKjiG5wVSnQt
	1zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hwl7K7WgCVUdAPhdlxpSz9v6Hk+upfubqO7G9jPtSKk=;
	b=NV6pgmoTDmhHLFMIut2/c/UMXRh7/hh6ODTGJ9vkzaqRFIcdz30SvxeLp825RbKdIV
	d6B4TueCQUCxPsgEibiGGvRDAWIOvTGSzVgsn1I7T0KEkEcjJhIeqiSjyzT6F/S+XkRM
	hEM5VljlXXYx1SPxlyO5jcKlFsZct85hDD1z/l1TspF9AdZjxoXQS1/zWw6raJQ3RGFl
	W1IrC98FcAEE3n/bFV6CSuZgZugD+aCowqmUsYsVw1dKlEN0RxmH2cx7fXcpmBnjoV/Z
	zF8fjSpyel1RK4rvoF6DuTj9JiBPS9yFXq8VQRzD6C7SJY/qy7MMnSFJ7qrQmo0NOcIg
	2ofg==
X-Gm-Message-State: AG10YOQfXgPvB95FAFufxIy29wF7w8OxjkAfUtioLpzKWVHR1R8WnKKiMbagx3Rwx452/w==
X-Received: by 10.182.28.7 with SMTP id x7mr118057obg.13.1453941823957;
	Wed, 27 Jan 2016 16:43:43 -0800 (PST)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id h1sm4274956oek.11.2016.01.27.16.43.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 27 Jan 2016 16:43:42 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Jan 2016 16:43:18 -0800
Message-Id: <1453941798-11670-4-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
References: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
Subject: [PATCH 3/3] data.py: sort variables being output by emit_func()
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
X-List-Received-Date: Thu, 28 Jan 2016 00:43:45 -0000

Sorting variables and separating those being exported from those being
unset greatly improves the readability of OE run.do_configure, etc,
shell scripts.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/data.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 70ba56b..07f4bba 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -270,7 +270,13 @@ def exported_vars(d):
 def emit_func(func, o=sys.__stdout__, d = init()):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
 
-    keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func"))
+    o.write('\n')
+    keys = sorted(key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func") and not d.getVarFlag(key, 'unexport'))
+    for key in keys:
+        emit_var(key, o, d, False)
+
+    o.write('\n')
+    keys = sorted(key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func") and d.getVarFlag(key, 'unexport'))
     for key in keys:
         emit_var(key, o, d, False)
 
-- 
1.9.1


