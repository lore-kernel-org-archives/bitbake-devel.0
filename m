Return-Path: <kergoth@gmail.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 0592676BA5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 22:31:20 +0000 (UTC)
Received: by widdq5 with SMTP id dq5so84527194wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=8VOj3MrU/zm4n7bZWDXIMlc1WKAXZSMTx0hfB9Svw8A=;
	b=tPgy6om0u8DNnJdtEHuquBU9p2KU9WUuGxMx+34lLBDNcVkFtaQWBo0tOBBrDzRTjX
	uw9c5Pu+WWpen/AGO9SIV8rPJUhs22486dyUKxzvwIZXmQopGpoctMTrxpTDVEF3aDHi
	8YX4rSKPtU1A9VY8PctvHLIoHtLk8XtkwPhgGVPDPbWOv+7JvUzCxU+LtkKNmE+LT02e
	EPFxJbzhQu9WQFElYPQPCFkNaFyFHvS2MLNt+EZJQkiFWolrYuM+mHco6MHaVZ5bRH/v
	09OUN1dGBCU8ou0p5SXmS31w+lz2ayx+nFSWyhgGapbTJUigHmhSmcgi6g8UhFIrigNS
	74qg==
X-Received: by 10.180.99.5 with SMTP id em5mr26167281wib.43.1440455480262;
	Mon, 24 Aug 2015 15:31:20 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id p5sm7769494wiy.17.2015.08.24.15.31.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 24 Aug 2015 15:31:19 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Aug 2015 15:31:59 -0700
Message-Id: <1440455520-29987-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] bb.data_smart: retain traceback from ExpansionError
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
X-List-Received-Date: Mon, 24 Aug 2015 22:31:21 -0000

From: Christopher Larson <chris_larson@mentor.com>

This gives us the needed context of the original ExpansionError, which is
invaluable when we have a chain of function calls in the expansion.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/data_smart.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 26f69d1..6fac82e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -367,7 +367,8 @@ class DataSmart(MutableMapping):
             except bb.parse.SkipRecipe:
                 raise
             except Exception as exc:
-                raise ExpansionError(varname, s, exc)
+                exc_class, exc, tb = sys.exc_info()
+                raise ExpansionError, ExpansionError(varname, s, exc), tb
 
         varparse.value = s
 
-- 
2.2.1


