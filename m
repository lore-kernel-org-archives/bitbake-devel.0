Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
	[209.85.167.49])
	by mail.openembedded.org (Postfix) with ESMTP id 4970979D54
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Apr 2019 21:37:42 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id h5so3539182lfm.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Apr 2019 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ibeH8t2MTL2he447vk6izPGtLuQqNEiv8u7TN3phPec=;
	b=pT8wfEBDwxjgydJOaM1vjnjfe0L8ilMPM+sxXCJ1rPlk87PdaQW9POUrR8J5d7NZXU
	W4bALA4w8CKiaTb2W3UMsADZ5bJXJCOMIMWG34BWBcM0wmkXwrN3k5jZHJ7KbV4Q7I1E
	jV6LkHl/5IiZRCYh6/06Cq39D4BYYHIOvD6s/eO7jr7kS+ZqPrJ16G05WRL/WU8GLOEE
	qVTkPW+cyY8d+ncdZX1Jkn28Dvv/IZaaEUiacEpSFzLJ/T1E7SeTPTm8luL0DWR+ovDy
	nT/Osb4bSRT1D0MSRe85hHVsXl4NwHOsMHACEB+0VpR2N7cMc3VKRaRBO3ej84aqrQV0
	iJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ibeH8t2MTL2he447vk6izPGtLuQqNEiv8u7TN3phPec=;
	b=LDWnT0jT87RyE7tod/W4jx528k9PxtwUP3adaCaXs61MGqMJlIn7koJA0CqaePQZBY
	+s/YyS+xuj4a4nU4p2kAS5wAR1FqzH3oSs8R4JSw2oy+nO/REWssN/BdWe08UjubxgL1
	Q8GHIjQ8mO5f4gIVu6Z7swny5ZkcwYKkgQwaG/5mGSJChvtzAHsPGSBxY2xK/i+Cbv7I
	79GDJm6z79SgfchY78FvSXq8jBPK3r3o0L2Uj+C3L7hy6B0mWN38JuFqxrfbPegUvpSG
	AhwntHv5iE4H+oKV2mEaojDocDZCEGWoNsI4PUlW1bybE93TFXFInhyC9Z1+bfC3tAxl
	OQKA==
X-Gm-Message-State: APjAAAVgqWLx5FxF9jpyGG4uNqmKHm147qT/8IkNEg7LYiVbsCoPo8MO
	VvqT8GSXioKfUcdYCwVc/K/vlmt1
X-Google-Smtp-Source: APXvYqxLzaT1zwctGRmD6he8bnz4GSfXGKoNKKGPU6K6GDm0WCOmt1/BpZGPhAIwSaEx81gmcWw92w==
X-Received: by 2002:ac2:545c:: with SMTP id d28mr25236737lfn.144.1556314662182;
	Fri, 26 Apr 2019 14:37:42 -0700 (PDT)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
	[37.247.29.68])
	by smtp.gmail.com with ESMTPSA id h2sm5809375lfc.77.2019.04.26.14.37.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 26 Apr 2019 14:37:41 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Apr 2019 23:37:27 +0200
Message-Id: <20190426213727.23627-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] knotty: Pretty print task elapsed time
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
X-List-Received-Date: Fri, 26 Apr 2019 21:37:42 -0000
Content-Transfer-Encoding: 8bit

A task's runtime is currently printed in seconds. Change it to
include minutes and hours for easier reading.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/ui/knotty.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index fa88e6cc..f362c23a 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -222,6 +222,18 @@ class TerminalFilter(object):
             sys.stdout.flush()
         self.footer_present = False
 
+    def elapsed(self, sec):
+        hrs = int(sec / 3600.0)
+        sec -= hrs * 3600
+        min = int(sec / 60.0)
+        sec -= min * 60
+        if hrs > 0:
+            return "%dh%dm%ds" % (hrs, min, sec)
+        elif min > 0:
+            return "%dm%ds" % (min, sec)
+        else:
+            return "%ds" % (sec)
+
     def updateFooter(self):
         if not self.cuu:
             return
@@ -258,7 +270,7 @@ class TerminalFilter(object):
             else:
                 start_time = activetasks[t].get("starttime", None)
                 if start_time:
-                    tasks.append("%s - %ds (pid %s)" % (activetasks[t]["title"], currenttime - start_time, t))
+                    tasks.append("%s - %s (pid %s)" % (activetasks[t]["title"], self.elapsed(currenttime - start_time), t))
                 else:
                     tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
-- 
2.20.1


