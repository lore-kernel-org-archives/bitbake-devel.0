Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 7EB9B6BBC4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 23:27:51 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id fa1so5424330pad.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Zzoqy+jvJFiO2ECzyCtGoTC2gNNdEzHl9QF7W8UdUec=;
	b=Skhk/By8AJxW3dcjJ27DcOovE3iRoZEnhU5fA+2MWKUdy7uJrJg+6ntyGR+uoUv8Y4
	qF7biEeMlToCsxtAk+arhBZ7ay+figgO2rtxAV4Yj+0hHrAT9jlQMibfNkCFiCh0EKI/
	3FmKsr/4akXkQ8/MYEWTt+yGVwfh0qP4M8qT1jiJ5qxpYGPwm8FAZEl6nzwdKPjpK59Y
	iC56fcZEP9qsvv6MCR+BGJ0D6DRSs7Jf+eXaqadXQQRoko9TrgwLI/VeTSTwFfPfmWGe
	qRmaC8j3V/WybdhPKRGxIveQgNVe4ybkwoRfhKs/y45+bQP8i0PfsJJV3jbW/wCUo6YJ
	omqQ==
X-Received: by 10.66.193.98 with SMTP id hn2mr11461053pac.173.1377646072540;
	Tue, 27 Aug 2013 16:27:52 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id
	mz5sm27126503pbc.18.1969.12.31.16.00.00
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 27 Aug 2013 16:27:51 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Aug 2013 16:27:41 -0700
Message-Id: <1377646061-24208-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1377646061-24208-1-git-send-email-kergoth@gmail.com>
References: <1377646061-24208-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] data_smart: allow removal of multiple words at once with _remove
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
X-List-Received-Date: Tue, 27 Aug 2013 23:27:52 -0000

From: Christopher Larson <chris_larson@mentor.com>

    FOO = "foo bar baz"
    FOO_remove = "foo baz"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 6229fbf..d325018 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -418,7 +418,7 @@ class DataSmart(MutableMapping):
                             self.setVar(append, sval)
                         elif op == "_remove":
                             removes = self.getVarFlag(append, "_removeactive", False) or []
-                            removes.append(a)
+                            removes.extend(a.split())
                             self.setVarFlag(append, "_removeactive", removes, ignore=True)
 
                     # We save overrides that may be applied at some later stage
-- 
1.8.3.4


