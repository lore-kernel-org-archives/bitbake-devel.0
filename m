Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id C4FED6C562;
	Tue,  4 Dec 2018 03:46:29 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id h193so12259831ita.5;
	Mon, 03 Dec 2018 19:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=d7GbVFUhhuHEou5pVIrgViTgpng+zN7NNZ7zVfBj8Pw=;
	b=q4bTNM8gdbHFZ1QfZ6Q1pz9af9tKJ5NjLW3pZIIzvq7SVWS+rqmvfe+0WdovBpzUwU
	fEFd8qQR8dh58AvxC291Q4shz9Sm8znRMbpLyopxkSsUqQday/7pu6nKq76xp2rsOy1J
	1AjU1yPubrPpw1HL4m8M4oTJVzwxTXXrh23IGfNy+lr6cKGNvoA3WXGh7wJMPu0W5rDH
	/PfigXN1YVsyFcCr0AJXQW9MgydBMr2rXqUp0GmSYZ9AS0j3YZekNm0F8Zk5BaGyKJUO
	QW51vV9GEFGGOTnDZUkABQfK2r2umXB7A2Csm/ZWfTKLg1MvBL5k5eXSr7VHR3H+5wAu
	gUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=d7GbVFUhhuHEou5pVIrgViTgpng+zN7NNZ7zVfBj8Pw=;
	b=bwtwp1swiKTgbuoXwbtuCsBPwuAu9HfcAwVCqndon5PCD7CJYQgbrIZ7QeC0LecQrq
	zo6RtnHY/B8R1In3ybeYQzlx7lsQKyZ0A/bwhoILpaHYJ+6KA0sxD1bifmJDRG+4x4oq
	0o7G3Ud09RB5cP/JnMOyirzI3I+ukph8l0vqRlpwkaIruMclMZcJsjLI3Bl99CyDd2q9
	op273PffZ9+LCYc0p5rIcf5lX/h8pK8XNB5Y5gHFOVlD03CbhpL6owTnthJ1qpCoCYe2
	9DQVfQybvrZauBsmvfSFKwQ0cw+LYWTBpr51iJngFI3hZWx9su9PIDKQEQ4g/wi1xa8s
	ZXKg==
X-Gm-Message-State: AA+aEWazWb4P6oks7oukhiOPTUqu646JxnNJCLuQDqDn4S0wdMU0HgsS
	Yam6Qx+oy7G54cDu6b2xnZLqxJSMTs0=
X-Google-Smtp-Source: AFSGD/WBeDpYuDm3BT3EnNkFJfTQbTd9VOA7vRVeFgXw1Fzy74CPtAOAGgKwZGO70p+cMg8y/4baXA==
X-Received: by 2002:a02:c943:: with SMTP id u3mr16985929jao.96.1543895189712; 
	Mon, 03 Dec 2018 19:46:29 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:29 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:37 -0600
Message-Id: <20181204034245.25461-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 09/17] bitbake: siggen: Split out stampfile hash fetch
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:30 -0000
Content-Transfer-Encoding: 8bit

The mechanism used to get the hash for a stamp file is split out so that
it can be overridden by derived classes

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index fdbb2a39988..ab6df7603c8 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -311,6 +311,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
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
@@ -318,11 +325,9 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
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
2.19.1


