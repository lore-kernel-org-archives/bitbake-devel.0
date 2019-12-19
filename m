Return-Path: <nick83ola@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id DEF5A7FD7F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 15:07:08 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id q6so6299193wro.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6GE95Nowgv2j0PnQ//R4G6yRfb7bBKg6V0cy5Fqg6KE=;
	b=Iyzg1J/rNMZ4DRSJzzQPJ30YvUdo9gwEL9tvCtEx/6ean/j47RSgM9Viw7eaKztA0y
	4x7Iipue43r8ik23kOAqQFLeeoVUhGpALH/8zln+unTEZsSvWrC/ihtFV3BeeUrH1LTk
	BVxvC6j8hM1Y6V1BQlhfe1xg5/vcSRy2iYWavOOSijQB6AJjoBuBHNncGWQlmNDXDoFA
	pXNMuR0EomIUKUKpa+RbCQ9gfs795j0jJDcf8T9VAbqLCiOb7Gl0cymysUBDqr57IHXP
	SmiFL8NIPgBpYFsoqJ9GW4NyoWw/Fyx3LuP2huHudDIIXA7vPvPN7lpnR2zl06K/Hw/U
	znXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6GE95Nowgv2j0PnQ//R4G6yRfb7bBKg6V0cy5Fqg6KE=;
	b=YC4P4TG6SjqTC8zeaLCuwxq1akuO8Wf1U03zAf2u82PHR7/9a6ZzV3ojuVJtzeuykv
	PjfcYNbfNjwYRWPaR5Wj9+LC5GMjtE3npEUbfXMxi7GkYP9vnnTHYG1Hfn9uJp9xUb5u
	yL7eNlJGLEc32cxcoFeo0drdpIC6n+5z3lfXgd4eH6Fq1tpHx3ya2lrwKQB9bwy4+v0W
	saKX/CHFwEQfT+F1uGy/AOpfe2Abvkt4xxWgpIeDnxJzXoDfbN8CWqB5L97y1oe1kPw3
	eOjNV8dYAEqRyVPg9jRjopMtrAKtzAriftBLThgpeVo7M6/3YoMhU4wGK4RfxEJF5ZsL
	WDOg==
X-Gm-Message-State: APjAAAUGbz8kRiknRRPM1NUDC2+ZyswVS8Ifg0XL2Aw4a9NbCaaycSWu
	SPAwFLfXO6SxUCs+S/i+T7Bm7WruPzs=
X-Google-Smtp-Source: APXvYqxuFp4TWnIjH33yxIb+BCToVhb++7W+ttO1Tc/3T4CaZPKARFwVNLygU6T9cuvsmryNhouNwQ==
X-Received: by 2002:adf:8041:: with SMTP id 59mr9573149wrk.257.1576768029217; 
	Thu, 19 Dec 2019 07:07:09 -0800 (PST)
Received: from nick-bbestie.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	s128sm6542189wme.39.2019.12.19.07.07.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Dec 2019 07:07:08 -0800 (PST)
From: Nicola Lunghi <nick83ola@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Dec 2019 15:06:40 +0000
Message-Id: <20191219150638.31858-2-nick83ola@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219150638.31858-1-nick83ola@gmail.com>
References: <20191219150638.31858-1-nick83ola@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: fetch2/wget: checkstatus: use the same arguments as parent
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
X-List-Received-Date: Thu, 19 Dec 2019 15:07:09 -0000
Content-Transfer-Encoding: 8bit

the commit:
  312f1a5e741: bitbake: fetchption: attempt checkstatus again if it fails

was introducing an extra parameter to the checkstatus function, overriding
the parent.

Avoid that and remove recursion as is not needed.
Also introduce a small delay between the two requests.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 bitbake/lib/bb/fetch2/wget.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 180fe9aacd..9c0defb6d2 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -201,7 +201,7 @@ class Wget(FetchMethod):
 
         return True
 
-    def checkstatus(self, fetch, ud, d, try_again=True):
+    def checkstatus(self, fetch, ud, d):
         class HTTPConnectionCache(http.client.HTTPConnection):
             if fetch.connection_cache:
                 def connect(self):
@@ -404,10 +404,21 @@ class Wget(FetchMethod):
                 pass
             return True
         except urllib.error.URLError as e:
-            logger.debug(2, "checkstatus() urlopen failed: %s" % e)
-        if try_again:
-            logger.debug(2, "checkstatus: trying again")
-            return self.checkstatus(fetch, ud, d, False)
+            logger.debug(2, "checkstatus() urlopen failed: %s", e)
+
+        # Some services such as SourceForge seem to struggle to keep up under
+        # load, with the result that over half of the autobuilder checkuri
+        # runs fail with sourceforge.net "connection timed out". Attempt to
+        # mitigate this by re-attempting once the network operation on failure.
+        import time
+        time.sleep(0.2)
+        logger.debug(2, "checkstatus: trying again")
+        try:
+            with opener.open(r) as response:
+                pass
+            return True
+        except urllib.error.URLError as e:
+            logger.debug(2, "checkstatus() urlopen failed for the second time: %s", e)
         return False
 
     def _parse_path(self, regex, s):
-- 
2.20.1


