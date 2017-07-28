Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
	[209.85.223.196])
	by mail.openembedded.org (Postfix) with ESMTP id 2358A71AE6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 19:47:56 +0000 (UTC)
Received: by mail-io0-f196.google.com with SMTP id m88so10852140iod.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=KiA1T+nIDowSiI3DVdt4YdkHxTnFjG4Loc1UXWpa7oQ=;
	b=oJTCphbsgzcaJej9Ar0CsUdDh8u8Qsc57jjFddFIifdMvLDcNUIqNUH/7+tbfoj2jN
	/Sw6LN1OSaxIAfeQra3wYmJ7gAvj+5X39uzfvJZGGEbEdrq56+XJ8K4i4JvLEFl5hpDH
	3J82yenLbUk17FjV+QJ+/6RietghIEEC7dX5jvILWo4wopERPY8es0deUaqrgW/n0tYc
	VcKv7laSL2+kGmYv5PoA/7BiJJgMFJpsy9u2Bpgs3dnoNl5klmA7iUKWMXBQlspYYlRg
	T1+myDy1PiZeR4xWsx+zSvUoxrkrHsPdttKcBQq57AJzhZhplB9/zmktquvZUpqhT5J+
	kO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=KiA1T+nIDowSiI3DVdt4YdkHxTnFjG4Loc1UXWpa7oQ=;
	b=kuPstobOaxVQm43hcxZtrIiqvvR0G4dUYrz1yyFX6k98XSptXt3Tjvg3Ah3M5HFIXB
	fMvrnolarsqqNnxEUTPM/RirFN7x/vka9Xqn4MGVblQDHeVzlQhOc4FtIbjGGOktvksr
	+fHNkhqEzJLUT5FxGHPJrNLlIOL2UzH/h442+3jXoPkbA/xHclTrTBGQbeIFSCiXxILq
	rBxWuADrjdEHFHhY0n/432tMY9YG6Ke+17VklqP476aQmnNidWkouwnHbJb5Nz4r7JrC
	uwC0azUwHXEPAvxu0WUm0f3kEkR0hj5pRwo/T3P/omdP7GS3BonSpb9g0CkYK7PotM8T
	DA1w==
X-Gm-Message-State: AIVw112E266yx8/x2OXEVe+qx+IhAvoBTweYyJhEPTapLVK5FRst6t9a
	YWLtEQAWvR46gC6R0uM=
X-Received: by 10.107.181.210 with SMTP id e201mr6082621iof.61.1501271277252; 
	Fri, 28 Jul 2017 12:47:57 -0700 (PDT)
Received: from onyx.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	q81sm2536109itb.28.2017.07.28.12.47.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 28 Jul 2017 12:47:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 13:47:53 -0600
Message-Id: <1501271273-20944-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] tests/fetch: fix GitShallowTest.test_bitbake
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
X-List-Received-Date: Fri, 28 Jul 2017 19:47:56 -0000

From: Christopher Larson <chris_larson@mentor.com>

`git fetch --tags` seems to interact badly with `mirror=fetch`, resulting in
the regular branches not being fetched, so drop the unnecessary `--tags`. This
fixes this unit test failure: `bb.fetch2.FetchError: Fetcher failure: Unable
to resolve 'master' in upstream git repository in git ls-remote output for
/tmp/tmp4ag_mgmn/gitsource`

[YOCTO #11698]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 343ae8f..faa5c74 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1440,7 +1440,7 @@ class GitShallowTest(FetcherTest):
         def test_bitbake(self):
             self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
             self.git('config core.bare true', cwd=self.srcdir)
-            self.git('fetch --tags', cwd=self.srcdir)
+            self.git('fetch', cwd=self.srcdir)
 
             self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
             # Note that the 1.10.0 tag is annotated, so this also tests
-- 
2.7.4


