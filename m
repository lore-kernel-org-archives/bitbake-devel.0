Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.13506.1600943089501695042
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 03:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BRHWbDbZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id w5so3184762wrp.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2020 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxWpIBHJ5I+Vdytq/PJTaTtim0d3U91nw5xZuKw7Y8o=;
        b=BRHWbDbZ/O9t6SDzyz8iqYA7KK1iWnl8EoftxPcPHXp6JXeD9k/qt3WslR5lXM4a/s
         N/Q5Fzy6v/qD4OkvAtyE7gUWxFar1b375t8kaL6j2cHw9GSG9gIQvELZ3A0F/593wWmz
         UfBLS6mWyZuJdjxAjiOGQfG0Av7Gz929URI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxWpIBHJ5I+Vdytq/PJTaTtim0d3U91nw5xZuKw7Y8o=;
        b=aLTghRr/t89crvByUlqsbL5+7B8n1uCvL+p45FCirkDE+eBxF1XPnBIZkRUat4wsOI
         sTv+IqiP4CJCBpV5N/3W2Mcemfyd7thAsNfNNnLyB8xpkx+kIM2AAeqIKy6Ux58J7rJN
         SFjhTk7sBKaCFy8WBjv4BG1dG0sQBlu2xO9B8U7LAfK2lM123qgfIEykAehGQ/WHyvtF
         TiyRjDRBEiuIDj1L2XnKY0RgdljgEwJn9Nr6HVk7IVPqIIlNyH8DJ7VS/b3pb+mT2IQ7
         1FgWxAWYqntN7/qCLoqQ2TtlZ6od3fTtMya6QbxZUCZ5zk7A0iqgu9Nce4dOpd6lkB+n
         BYIw==
X-Gm-Message-State: AOAM533Uhdia88FZcbqTa0quYYw7mHKDjnHGirtyg7B7hQbR63PFydoY
	jhDJAp7MUdYSuC3juus1CUYpqBJDulZZKA==
X-Google-Smtp-Source: ABdhPJxElF262hFuVDW/WxOfrFqJ3hpvftPnZ5Ki45qrD8CuhRPkTuHx2CGps5CsAuddnmIKIWw4qA==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr4527740wrj.92.1600943087453;
        Thu, 24 Sep 2020 03:24:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (6.1.9.3.6.2.6.e.a.a.c.2.3.5.1.b.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:b153:2caa:e626:3916])
        by smtp.gmail.com with ESMTPSA id s11sm2968855wrt.43.2020.09.24.03.24.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:24:46 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Revert "bitbake-layers: add signal hander to avoid exception"
Date: Thu, 24 Sep 2020 11:24:46 +0100
Message-Id: <20200924102446.2584492-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4fca9a07f2d6b0544977112672b786982d7bb8f2.

The default python handler is to ignore SIGPIPE errors yet by adding
this line, we see:

2020-09-23 22:10:20,325 - oe-selftest - INFO - recipetool.RecipetoolTests.test_recipetool_appendfile_subdir (subunit.RemotedTestCase)
2020-09-23 22:10:20,325 - oe-selftest - INFO -  ... FAIL
2020-09-23 22:10:20,325 - oe-selftest - INFO - 11: 30/44 227/415 (14.85s) (recipetool.RecipetoolTests.test_recipetool_appendfile_subdir)
2020-09-23 22:10:20,325 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/selftest/cases/recipetool.py", line 226, in test_recipetool_appendfile_subdir
    _, output = self._try_recipetool_appendfile('selftest-recipetool-appendfile', '/usr/share/selftest-replaceme-subdir', self.testfile, '', expectedlines, ['testfile'])
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/selftest/cases/recipetool.py", line 85, in _try_recipetool_appendfile
    return self._try_recipetool_appendcmd(cmd, testrecipe, expectedfiles, expectedlines)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/selftest/cases/recipetool.py", line 49, in _try_recipetool_appendcmd
    bbappendfile = self._check_bbappend(testrecipe, recipefile, self.templayerdir)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/selftest/cases/devtool.py", line 186, in _check_bbappend
    result = runCmd('bitbake-layers show-appends', cwd=self.builddir)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/utils/commands.py", line 201, in runCmd
    raise AssertionError("Command '%s' returned non-zero exit status %d:\n%s" % (command, result.status, exc_output))
AssertionError: Command 'bitbake-layers show-appends' returned non-zero exit status 141:
NOTE: Reconnecting to bitbake server...

where status 141 is SIGPIPE.

We expect SIGPIPE not to be raised like this. I tried the commands in the original
commit to pipe through less with the change reverted and I don't see the error
shown. I therefore believe this is safe to revert.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-layers | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 149f1b1ac8..ff085d6744 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -14,7 +14,6 @@ import logging
 import os
 import sys
 import argparse
-import signal
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -26,7 +25,6 @@ import bb.msg
 logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
 
 def main():
-    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
     parser = argparse.ArgumentParser(
         description="BitBake layers utility",
         epilog="Use %(prog)s <subcommand> --help to get help on a specific command",
-- 
2.25.1

