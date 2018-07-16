Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id 89B427545B;
	Mon, 16 Jul 2018 20:38:05 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id y10-v6so24291580ioa.10;
	Mon, 16 Jul 2018 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=r5tzJR3AdMNs1Fk8Hi0XLPArEyCuDD8JhFBuAuh0c6A=;
	b=DNL+TCneU9r61xfJju4iMhP1bUdmdIxiBspcj9bAhaYfEanwkmKaQUw3z2CqRaBVZ4
	pWNAAOBKmMEjq5rrs8GkIXLnvgEtAxRUOTbEoOWPA/6+acyzogXZdgV7nVB8luF/hDxq
	DomnF0lrWFprwGmmCtjHyfXG15RbLXocNnJeqZT2wMh6O9+BFduXTLBcgC11qyL/7pFm
	QrARofXj/HaFnSC6ITNhvozPBPQoKdydQr1UAezM7SdDuD0UMQ2rHTJx3RS92lyNehXB
	0fN90HQ92IqRQM0jrwnTJCaQ7YqhQEwFxPMyFbRoUiyqAC6x4xyJ+mC3siUydgyD/CUn
	VlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=r5tzJR3AdMNs1Fk8Hi0XLPArEyCuDD8JhFBuAuh0c6A=;
	b=Wu84tDlFYR/pyYXCsfrHf5AjpeKFX2l04iW3dxFoLsi5mhmqSCfAyzl0RdGJ16hMWy
	yqFjtWGXqhzLMQzziV7O1wIkXAZqcU+SgpVGXN/UW8+L8lVJ13bXANmpDXPuRKfh6WIc
	UOtsBMFC14VEldMyqbUPvbqXRCjvBgz+eKFUUPISo3l0xna/xV4dxGNGrSPwPAVd2fk8
	FbAGtbD6OO3DghJtq2i9wGN4W7a7U6x1COqKHc18KD/7ISo+lBqUQL0cGUESu+9vdBfl
	2EyHN5MHMGILgP9pXVriEoRIyhgAV4J2hOz+gl5V94jH3nbgLgCQWfOYMNtE2nPTcEoI
	R8fw==
X-Gm-Message-State: AOUpUlEG1y+eBZ2EaqhRXX4dJ8w9v3R2ptp1FzEEX9z3JUZj+9zXmFTZ
	+AXR8MDjSXgKW1wRf/QrEjIpJOTr
X-Google-Smtp-Source: AAOMgpdNq2GjpM1zMIgFuI+96fAHjk90PXzwCBAX5J9bC2zRpLd2hEu9ug8PmOojaRVE2wjRVI5Yrg==
X-Received: by 2002:a6b:870e:: with SMTP id
	j14-v6mr16187978iod.208.1531773486383; 
	Mon, 16 Jul 2018 13:38:06 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:21 -0500
Message-Id: <20180716203728.23078-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 2/9] siggen: Split out stampfile hash fetch
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:05 -0000

The mechanism used to get the hash for a stamp file is split out so that
it can be overridden by derived classes

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index ab228e4148e..d2dfcbc3fdb 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -331,6 +331,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
 class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     name = "basichash"
 
+    def get_stampfile_hash(self, task):
+        if task in self.taskhash:
+            return self.taskhash[task]
+
+        # If task is not in basehash, then error
+        return self.basehash[task]
+
     def stampfile(self, stampbase, fn, taskname, extrainfo, clean=False):
         if taskname != "do_setscene" and taskname.endswith("_setscene"):
             k = fn + "." + taskname[:-9]
@@ -338,11 +345,9 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
             k = fn + "." + taskname
         if clean:
             h = "*"
-        elif k in self.taskhash:
-            h = self.taskhash[k]
         else:
-            # If k is not in basehash, then error
-            h = self.basehash[k]
+            h = self.get_stampfile_hash(k)
+
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
     def stampcleanmask(self, stampbase, fn, taskname, extrainfo):
-- 
2.17.1


