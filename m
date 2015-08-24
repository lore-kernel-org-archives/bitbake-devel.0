Return-Path: <kergoth@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id B694976C02
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 22:31:22 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so84811524wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XNZJTrTR7QNjz6azk3nJn2Y+28qPjQUqncg9XnwHTgw=;
	b=Yh7njVD3KZIK1a3NFoWaGp3d4jVMH4rhnRwqagDxK8cmFl35x5c5QqMtfgchF8vaVt
	AMU/acPPvw0tYW82iNUNomXbsws6PUyhhBDPuzVmurmtSuPPrBcOkllbq9zd4PpO70cr
	WcThvvgs2MArGJF77F1XwD8ErOJKLo8+/YSfN7Xh9vdBfDcOIuTgZ/cK/HJZEsAyEFND
	9jHB1lgaxzDta63f4WIf+JBx7+T1J5vEBynFlYwnuzVFYQWK9qIzOrYC7YLE0Gu8kcCb
	/BPRLGFMTwB4vTCUV5s0WxX37rkzq9CQskMVBkaILk6XhmGV9kRvQHH7D52B2cTHUcT7
	as0g==
X-Received: by 10.194.174.201 with SMTP id bu9mr10281916wjc.73.1440455482330; 
	Mon, 24 Aug 2015 15:31:22 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id p5sm7769494wiy.17.2015.08.24.15.31.20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 24 Aug 2015 15:31:21 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Aug 2015 15:32:00 -0700
Message-Id: <1440455520-29987-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440455520-29987-1-git-send-email-kergoth@gmail.com>
References: <1440455520-29987-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] bb.cookerdata: include useful traceback for ExpansionError/ParseError
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
X-List-Received-Date: Mon, 24 Aug 2015 22:31:23 -0000

From: Christopher Larson <chris_larson@mentor.com>

Show the user only the portion of the traceback which was from the metadata,
nothing from bitbake's internal calls.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cookerdata.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 57fc6bb..a033266 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -179,7 +179,16 @@ def catch_parse_error(func):
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
         except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
-            parselog.critical("Unable to parse %s: %s" % (fn, exc))
+            import traceback
+
+            bbdir = os.path.dirname(__file__) + os.sep
+            exc_class, exc, tb = sys.exc_info()
+            for tb in iter(lambda: tb.tb_next, None):
+                # Skip frames in bitbake itself, we only want the metadata
+                fn, _, _, _ = traceback.extract_tb(tb, 1)[0]
+                if not fn.startswith(bbdir):
+                    break
+            parselog.critical("Unable to parse %s", fn, exc_info=(exc_class, exc, tb))
             sys.exit(1)
     return wrapped
 
-- 
2.2.1


