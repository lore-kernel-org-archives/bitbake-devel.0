Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id DBAA27FA0C
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:56 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id c23so22038827plz.4
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=S2V9pTvvMwwDjaApifsadvDyNlY9W74XCGwyO6ZgOjQ=;
	b=YGiDAMkz9Bwgy7PVI8IcjVUDklj9QZj3iz7h/Nn9azmD2qDKi99KagyIql8YJ0Hw3A
	mkyMMx9BBqmWADO+arinStxaeTczgqPplhAOAIfWUN/f3EGl8PoGlGdwL5CYrpFluIfm
	JgmIlMKJ6lBPRr6L8o0y0Ye1nbIduBmdrpjLwNyZ0vOZhGYIPbx3ErdBYMezS4y2ob8n
	Uitg4gDRAVinX1WUSiQ/Dmub8DYsprXBjSitwm4fkenZa+1ZMRAIlBwdniH/R+Sbowv9
	HzDDXS59WiyIOAm/FD27sW9y/zkrt4SyzvZtByrjPUtnzg9vctSM1iTguwfBSdqPuX/x
	Ictw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=S2V9pTvvMwwDjaApifsadvDyNlY9W74XCGwyO6ZgOjQ=;
	b=uQMPDR4nIm6b1uFN8Qth4cAb12lB1fQ9zDKW6K/A9VZ4GJ6g+BmZFc+SsnWa/t3ab4
	5najkxyRSl/ftripReA3yLlk57TqdPsq0gZOC/RnCk3yFD6W0UWr2r6HAGw+t+oKwoQQ
	MZJ5T+vddsa+tnKWeXYQgsnLMtFnLQ6T5tWAH0aRot+G2tPCBNTAeNP92525uv/bE3LK
	3tSoyMOK0SioH9VG0XwEYp9tTX8DZWBL5hkPUKtc834TpG5+vjFaiRSfN5A9R8fIu5hy
	7sbGUdSTk1wL5Wt88F62oWultx8ztYU0j2ecwJ1X3Yp//17755ndr9V+xh+j6RJnfjgI
	Q6cg==
X-Gm-Message-State: APjAAAW9Gv1Xo4256jc+RstPAo5odTfJfKizzdnDQ315PlYnBEDP7QbL
	bJZtYKfigzp3byqlv2ulsW9FIMcH
X-Google-Smtp-Source: APXvYqx7waoAP01Ao9Rg3N2Ixpa3BT4CoXuQDlaNnvV5TG0LeGOEdUe+Ap7vSl6pC2Ivrpbi6ryXlg==
X-Received: by 2002:a17:90a:98d:: with SMTP id
	13mr44114610pjo.102.1578328017799; 
	Mon, 06 Jan 2020 08:26:57 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.57
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:57 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:29 -0800
Message-Id: <5afad266f2ce55db2038c36f2e49a3c80be9bbfc.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 08/25] siggen: Fix performance issue in get_unihash
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:57 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There is a significant performance issue in get_unihash(). The issue turns out
to be the lookups of setscene tasks. We can fix this by using a set() instead of
the current list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1e561672d039ebfb8cd0e0654a44dcf48513317c)
---
 lib/bb/siggen.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index dbf51023..2fec8599 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,7 +44,7 @@ class SignatureGenerator(object):
         self.file_checksum_values = {}
         self.taints = {}
         self.unitaskhashes = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
 
     def finalise(self, fn, d, varient):
         return
@@ -110,7 +110,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
@@ -157,7 +157,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         return taskdeps
 
     def set_setscene_tasks(self, setscene_tasks):
-        self.setscenetasks = setscene_tasks
+        self.setscenetasks = set(setscene_tasks)
 
     def finalise(self, fn, d, variant):
 
-- 
2.17.1


