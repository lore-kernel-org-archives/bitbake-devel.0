Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id AB8EC78E9B;
	Thu,  9 Aug 2018 22:10:50 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id y10-v6so6069444ioa.10;
	Thu, 09 Aug 2018 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8uLk+2Uk/u9RF7aiqEAmtS5J6YQ2/mtdbMmTZR9lzlo=;
	b=jpDrtC7yxKKB51PIFMkejlmlrflo+B5h7EHlIwWi/03wTdhVsTQn4UblfKCOVjiH+Z
	weEpZBhkPGMPBWg9NpSu1FIhRwB0SEqTr3yfRB8Mv4mWOm9JNS8ijySYnvxZMqhiqMZ8
	rP7IYYB596Sqq2UhshPZdzPLPtkJgK0n9HM2+M6/vwOl0DvTT3AbUrDbaMhSK4YuAdJJ
	3xHNZVm8HHlyPMzKTpyQMLMYwqUp/T00zarpcOwrgDQUd2S9YQ2kb9zbZ+ivFxmEdrr4
	wz8p5bk0K5Niau+So6xT+3hrFEaU3vvDgNqJ4g8LqZka/2kk4H7Bik59RpgkHQGaIChN
	CkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8uLk+2Uk/u9RF7aiqEAmtS5J6YQ2/mtdbMmTZR9lzlo=;
	b=lfan0exZi9tGfG7mHP1GAmIoxOUvNfIJeZVmBH8f7uXaXtblKF7aRY9N0F3m3nnGt8
	xoV3fwf2yGhrObottobutKSOnBYx9oNZS4z66dRyWlZwoTAOjDSZNMBUNaIDy++fDAX3
	qu+z3ImaeHrrT4nHgFg/fWzerhUGj0Moj9IQ/wQiqHpFbYxlaj4VDlgHEXAT9m18UFFB
	djtUBLE85bk4EySYcycB3zgkfPwd8rAWd8XyAouwqXoKXwNVvm3opIHdNZ1NekMtS0ua
	Om6CZLeAK/G4qzsMtObCGfolQvcDvXr1ATqO/E68RseokMA655lJJA80n1Z8EbNId6vM
	qVPg==
X-Gm-Message-State: AOUpUlG2SlioeQPMq9xSSYD6MICE0YDQBXja3BXj8yKwNid9uYXPwnGj
	uAP5kubLqzwbDwBEoWkk+Mm59a3y
X-Google-Smtp-Source: AA+uWPxG4pat1ftGzNI78qBGP6iku8HBg3Y3zTSlMcCEak/CwZVXBRqknlrQtNhhIRAVd4Mk2Xbnrg==
X-Received: by 2002:a6b:3809:: with SMTP id
	f9-v6mr3425112ioa.105.1533852651624; 
	Thu, 09 Aug 2018 15:10:51 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:33 -0500
Message-Id: <20180809220840.26697-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 09/16] bitbake: siggen: Split out stampfile hash fetch
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:51 -0000

The mechanism used to get the hash for a stamp file is split out so that
it can be overridden by derived classes

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index e9bb51d736f..7fa5b35337d 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -340,6 +340,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
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
@@ -347,11 +354,9 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
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


