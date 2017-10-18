Return-Path: <andre.draszik@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id C4CCA719B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Oct 2017 06:51:36 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id l68so7991048wmd.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 23:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4JkP0jwhntE4sbMUoI2xneXm1QfioV0T/biSbHe+m6o=;
	b=RrJ+zIlay+QjvCENHRGfPq3432DL5YJeFp3rx/w0TGL0oxaaEU+BSH7FKQSAvyfxHk
	lw/55l4U7h+wI4+OJUDFobVu+qOsDmaekeOdVdXTh9GGzcF0KcczkfAqdqrdpAtKbU8L
	SQWXVN54SoNnBUx1VmjS8a8EgxgZ75dvI5ELR6r758kKsf65OiTS0Qcbw/nj/40Lwa+Z
	3IUvbRuxksTyRL7t31/lOyJoNNReQf8iZgi3sofu0/GuW0D5wxn2MqPCRRYOcrQjNVdf
	d1icAxkZSxB5H8/MQx5XrklftBsVxQBN9JGFz6+YJpVm2ZwxwnjC2koderqvxrKZhIaJ
	dBtQ==
X-Gm-Message-State: AMCzsaVNFG1a47XtnqGDvCjOp7bD57gz5VU9hs0jK/ixpOenuGVDqm7J
	4c2rANEQ8dI6e4m/W5rBhGZP5INi
X-Google-Smtp-Source: ABhQp+RGNGUiCAay9Won8M8MxFI8VdxwBdYBGyZoDqFNjrH1MTaLL/lI7KrDS7o+uuD4WCh/bXRCIA==
X-Received: by 10.80.189.205 with SMTP id z13mr16354835edh.184.1508309496843; 
	Tue, 17 Oct 2017 23:51:36 -0700 (PDT)
Received: from tfsielt31850.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	j39sm8744994ede.10.2017.10.17.23.51.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 23:51:36 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Oct 2017 07:51:35 +0100
Message-Id: <20171018065135.22771-1-git@andred.net>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20171017133121.19524-1-git@andred.net>
References: <20171017133121.19524-1-git@andred.net>
MIME-Version: 1.0
Subject: [1.34][PATCH] Replace deprecated git branch parameter "--set-upstream"
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
X-List-Received-Date: Wed, 18 Oct 2017 06:51:37 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andre Rosa <andre.rosa@lge.com>

Since 2017-08-17 (git version 2.14.1.473.g3ec7d702a) using deprecated
git branch parameter "--set-upstream" causes a fetcher error. Replace
it by "--set-upstream-to".

https://git.kernel.org/pub/scm/git/git.git/commit/?id=52668846ea2d41ffbd87cda7cb8e492dea9f2c4d
says, it's deprecated since 2012-08-30 so hopefully all still supported
host distributions have new enough git to support "--set-upstream-to".

ERROR: PACKAGE do_unpack: Fetcher failure: ...;
git -c core.fsyncobjectfiles=0 branch --set-upstream master origin/master failed with exit code 128, output:
fatal: the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead.

ERROR: PACKAGE do_unpack: Function failed: base_do_unpack

Signed-off-by: Andre Rosa <andre.rosa@lge.com>
Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

(cherry picked from commit 2ab50074c1a6c56a8a178755de108447d7b7acaf)
Signed-off-by: André Draszik <adraszik@tycoint.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2550bde8..7442f844 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -326,7 +326,7 @@ class Git(FetchMethod):
                 branchname =  ud.branches[ud.names[0]]
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
                             ud.revisions[ud.names[0]]), d, workdir=destdir)
-                runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
+                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
                             branchname), d, workdir=destdir)
             else:
                 runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
-- 
2.15.0.rc1


