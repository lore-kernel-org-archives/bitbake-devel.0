Return-Path: <nick83ola@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id A1D737F9A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2020 10:31:10 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z7so48949754wrl.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2020 02:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=dHMjMxrsKFdADEV+OC8XpGxYgI68Xl0VV/mc2CDJFcI=;
	b=O531d6BkrVxaArtgkKIwoUUM9fFGxFyALn1EnQewkzNy/w3GfAujAc6ukdAljhym3d
	VI+FTa3pBFrXw+xM4yTSOpfZm/XJA/1QFwCjDUb09uwK9kb+pWUfse/Ochw2H1XCRypz
	zmStzmdK1bq8uLA2L3kQ0bL7yTR2CALsJoKuv1H8RRr22S/3h+O6XoLu0DAEaNETRBXG
	KlY7/y/rqeMyCDc9jWtnSHfCxxS+ELjSi+Tg9SykCypXTpmK1SQ/RYLkLCkKuYjOB89K
	iNWrYW0QFESuxKdtbl9sp8Sgy800x/cur7Ik2UhLfoITywXQI8cft42Z7X/3WiUtqUJn
	YHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dHMjMxrsKFdADEV+OC8XpGxYgI68Xl0VV/mc2CDJFcI=;
	b=iQ+pcDS23MOUFMRiQeGnPmPO6SRHcpzeOs+3VjOF4Uy05GAz7UXhyKqqHO6keLkNkt
	Hecs+q/bEGJ1hBtb6dS4DAey10SxY/rte4Sgwi807jZfD09OmHfXII1pjn7BOUBY8v2p
	F9zjChzoOyudP6kYHHe3OQzn7udZPkAoxP8hsBu1vBOoNhV2oTsRXPyXSmuB+dMPm1/l
	rtHaGLMnwfmeIAkkJvVt3Quion3rUgyPIHDNpRraYSdVOOQ+2+nPdcskN86VAqRAB7zH
	596GiOweoe3iprec4WLcZXP0lywHa8CzryWeDi7IMsKrK9toG7XkKuRAnD0C6HhSzBGq
	SdWQ==
X-Gm-Message-State: APjAAAVLZWE4JnkYv0yW7+x6ui4ddYMtXEw99CUiMthB6injjv9tSrfT
	MsnQzbPOpYOYUjR7qZ/J1gD5lHxGAYw=
X-Google-Smtp-Source: APXvYqwRG6eXxl6Qo9dmCEPMSdFJYme+mc7/QC72Ne3ZRljV83cVq0fDF8bNulmsvOHZTTFIed6xJA==
X-Received: by 2002:adf:8150:: with SMTP id 74mr106387718wrm.114.1578306671121;
	Mon, 06 Jan 2020 02:31:11 -0800 (PST)
Received: from nick-bbestie.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	g25sm23670600wmh.3.2020.01.06.02.31.10
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 02:31:10 -0800 (PST)
From: Nicola Lunghi <nick83ola@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Jan 2020 10:30:41 +0000
Message-Id: <20200106103039.34321-2-nick83ola@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106103039.34321-1-nick83ola@gmail.com>
References: <20200106103039.34321-1-nick83ola@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v2 REPOST 2/2] bitbake: fetch2/wget: checkstatus: use the same arguments as parent
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
X-List-Received-Date: Mon, 06 Jan 2020 10:31:10 -0000
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
index 5aef55a9c6..67b4d58924 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -121,7 +121,7 @@ class Wget(FetchMethod):
 
         return True
 
-    def checkstatus(self, fetch, ud, d, try_again=True):
+    def checkstatus(self, fetch, ud, d):
         class HTTPConnectionCache(http.client.HTTPConnection):
             if fetch.connection_cache:
                 def connect(self):
@@ -324,10 +324,21 @@ class Wget(FetchMethod):
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


