Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
	[209.85.167.67])
	by mail.openembedded.org (Postfix) with ESMTP id 999297ED62
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 17:22:00 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id r2so4680486lfn.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W4kx9TBX7e9Qst+X5K4aOq9+QdQmNue31AuOMZgTpPo=;
	b=fh8ttyaNmbTN2gNNv3bx1muWAexlP7emQ8udIt2Je+XvPfPPDpHB1WsUuDsG+2ZE6k
	7zDuu8mu8oHNJE1Bzi8/YFK1jglkM2ORMwdnAn+Qq8ipAfeFaiLe1UmWyJ4HVbN9CsZT
	s1MTfw6FwYmRmK0IzgC06FYGZiXujhTujx1XXCNIRzOx8XB+ezT6b+wpl5Fmfwa9wfqe
	zief4roR4sXP7Bs/NFwO00ldGr4vHRUAPMZSqi6FCm5aJylm4RDredgP+2zoQwZmOIi7
	TnpqcbgSv5d0I4F3VBEoBER+CUBm2zQAI0EjG3uIp7kxi3EAIAbGgwhh2a+kLQwX6nUf
	H7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W4kx9TBX7e9Qst+X5K4aOq9+QdQmNue31AuOMZgTpPo=;
	b=q7NmeZIrZvJ1kvGN6NxhaVkY8hh0UAqLT6CzXyh5ZyN3q34fZwH+IJE7fWvlTV6wUI
	C1Unw1uFefPggX5nlqljR2dqoxksIljOHoHTaaodXQGcVzA6gR+SixGiku6Cj+d/q4VZ
	jVoZhwQGO53PAAe5TlPHZ4Z9kJwGCCMNfZJl34Vcf3aFrQkdxFGE4CMjcwhqhkclnzPH
	Bk4hdORLOZT30WhAF+ABV0wmZOYUggolDRX59ckGgSNiX9bG1YsgLH0vH8j3751xLjw1
	QioPTSDnV4LsQgoU9D3SX2jf1TJtM2ZNs4x3FTFY+2fiIRFeIiFnjVE/asVR0meR5/3E
	F/hA==
X-Gm-Message-State: APjAAAV5tjsX2PA44yoxOLJG2+FfZOKQxnuwNCUVHVz9lkBf5VJiounG
	1lLGJ3zNY6GT7T79vkIw4AliUSRLbBY=
X-Google-Smtp-Source: APXvYqzGpOaArRBYOHvJCRgfQ2Qp0cgqad0QP0RrZJSeLwNz888fy13bq0swWKiZsHNopET+p4Z9tw==
X-Received: by 2002:a19:711e:: with SMTP id m30mr32460707lfc.63.1568395320480; 
	Fri, 13 Sep 2019 10:22:00 -0700 (PDT)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
	[37.247.29.68]) by smtp.gmail.com with ESMTPSA id
	u26sm7010233lfd.19.2019.09.13.10.21.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 13 Sep 2019 10:21:58 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Sep 2019 19:21:40 +0200
Message-Id: <20190913172140.3847-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [RFC PATCH] cooker: Support saving the base environment to file
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
X-List-Received-Date: Fri, 13 Sep 2019 17:22:00 -0000
Content-Transfer-Encoding: 8bit

Add support for saving the base environment to ${PERSISTENT_DIR}/bb_env when
BB_SAVE_ENV is set to 1.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/cooker.py | 4 ++++
 1 file changed, 4 insertions(+)

I have a usecase where I would like to extract a couple of variables like
BUILDHISTORY_DIR, DEPLOY_DIR_IMAGE and TMPDIR from Bitbake's environment,
and use them for further processing in Makefiles/shell scripts.

Running "bitbake -e | grep ..." works, but on my laptop that takes ~5 seconds
to finish. I'm perfectly fine with using values from the most recent parsing
done by Bitbake, so an up-2-date copy of the Bitbake environment on disk would
solve my problem.

I couldn't find a switch to turn on that would enable this, or a utility
script that would allow me to inspect existing cached data, but I did get
something working using a custom .bbclass in INHERIT and a custom
"write-bitbake-variables-to-file" recipe, but that seems like overkill after
realizing that patching cooker.py was not that intrusive, although the
patch is not perfect.

Does anyone know a better way to achieve this ?

Cheers,
Jacob

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5840aa75..7a37f808 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -385,6 +385,10 @@ class BBCooker:
         self.baseconfig_valid = True
         self.parsecache_valid = False
 
+        if self.data.getVar('BB_SAVE_ENV') == "1":
+            with closing(open(os.path.join(self.data.getVar('PERSISTENT_DIR'), 'bb_env'), 'w')) as out:
+                data.emit_env(out, self.data, True)
+
     def handlePRServ(self):
         # Setup a PR Server based on the new configuration
         try:

