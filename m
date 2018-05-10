Return-Path: <matt.hoosier@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail.openembedded.org (Postfix) with ESMTP id 40D0C74DE8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 02:34:17 +0000 (UTC)
Received: by mail-io0-f193.google.com with SMTP id a10-v6so1313547ioc.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 May 2018 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=ByZqaZQyzFZFaKbcYf+UDCPEXb0Kh8AoVAqtYIDYbo0=;
	b=hOhKI6myDJKp0QDdUQzJlN6MgdXFKndYu2e2Q6He3TXH3ZEdbZ1GC8QK8f5GGmSMy1
	+XaLoZhxZmEz4uRTXxzDBuMzTxG8/IaWqkLXLkEfeG97/ppnfhlbbP46+ifFeksDuD7q
	U+tE9lw/XlHEegK9bcqvZgSyAlK+JaEqZ7eAniPYl6LJKxijsVQ9T3ugZsQXa+nnPnnp
	iGqsDd7Vc++YIcFSLBCt2PNHIhdsmpDrkyo8IUpfbBSNLSVxIwD4kvFWDSiHbi03G6T2
	dPKefdlPhRWEZVsl3kJQs+q/sYAkjrQKr4+5S5dwsNv9AEddo3X8lU1oqnzsm9W80u5l
	mOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ByZqaZQyzFZFaKbcYf+UDCPEXb0Kh8AoVAqtYIDYbo0=;
	b=VazYVIGF44xq9SveM8NgEvt4+/OvQQ/Fnbfy+kYeCogbxAhnBF+kah/ZnRu5g/vOI+
	TfxfzXxbKv3mXd9CsWuiqO840UGjH/+79nWHB1x6yYCBH64kF57WesmVtDfpLkgWCHQs
	bi+d6mvXenmN3X5lvESxvuZCvb4GrKlbY6lUOMEHsHf3TxbB2uYH5N/7AxrIIYxim61R
	n84rXsW8NCJc0Rk7v6GJU8ST8lYq3f9A+vvkapu9gTYCJ5kTJdAtRAuGRXJ7a14ghug6
	ghzU4NvR7Nh/bXLFN/MaBK9MpOvMx73Zq/l4jytBu7vRyOCRb3c3wnXQ9wagzoSwotYG
	xCXQ==
X-Gm-Message-State: ALQs6tCHPp8aik27ZCVGxes5XYI6+EOxaa1/fAUFhkXrBdEnT9GIo23H
	vlBdjlDVoaRPRkGox3VdA9uxLMnG
X-Google-Smtp-Source: AB8JxZpzzXFKo/dQ1zrw8ndsIr9xvFO9tpnsqRUgr/hYb0AFNv7hvG7cglkjVh7BNhRaSVAAZgVBsg==
X-Received: by 2002:a6b:1110:: with SMTP id
	z16-v6mr51191917ioi.248.1525919658559; 
	Wed, 09 May 2018 19:34:18 -0700 (PDT)
Received: from localhost.localdomain ([136.63.212.18])
	by smtp.gmail.com with ESMTPSA id
	d16-v6sm8865969iob.74.2018.05.09.19.34.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 09 May 2018 19:34:18 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 May 2018 21:33:57 -0500
Message-Id: <20180510023357.96409-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.13.6
Subject: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Thu, 10 May 2018 02:34:18 -0000

Although the submodules' histories have been fetched during the
do_fetch() phase, the mechanics used to clone the workdir copy
of the repo haven't been transferring the actual .git/modules
directory from the repo fetched into downloads/ during the
fetch task.

Fix that, and for good measure also explicitly tell Git to avoid
hitting the network during do_unpack() of the submodules.

[YOCTO #12739]

Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..1f3fc443 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -132,4 +132,14 @@ class GitSM(Git):
 
         if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+
+            # Copy over the submodules' fetched histories too.
+            if ud.bareclone:
+                repo_conf = ud.destdir
+            else:
+                repo_conf = os.path.join(ud.destdir, '.git')
+            runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
+
+            # Careful not to hit the network during unpacking; all history should already
+            # be fetched.
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive --no-fetch", d, workdir=ud.destdir)
-- 
2.13.6


