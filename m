Return-Path: <tylerwhall@gmail.com>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id 9AAA865F81
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Aug 2014 22:46:29 +0000 (UTC)
Received: by mail-ie0-f175.google.com with SMTP id x19so7840197ier.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Aug 2014 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=h/hE5mKWtuW1CgvBJ6QG+5u9NDusl8GBMGjglPsQVMQ=;
	b=PrgC3pSlhJDQPZUDdMHwFks/NesnkY0riWCMlzlQLS8Q6MSPfFwEP2gEprHmJ6Br4M
	ME57AIkqyJZpw2GFd+k0N25FJBgfLWRQUfYFxl8a23EMdPzW/o+agjAq8rXKhR6uClLg
	InM2X8IAwDYTfjedWBVy5fceZ73ss3GX38OfdBrpMEXcWMg2bcRBIHSzEJBREIPvqpDu
	lr2TzOZqZi71jecTHYRxCs5E6KHzP/XnqOMBXtNJsBZU4kny+WCtsWUIHLg/W0JXBzge
	fbyBPnA+BNBIErV+4VVikqDOGkOeHzOQrX4C9cGb0CJKORSV/oZtonaKfTWtWqF6BoJY
	p2uw==
X-Received: by 10.50.112.67 with SMTP id io3mr16638248igb.37.1407624390405;
	Sat, 09 Aug 2014 15:46:30 -0700 (PDT)
Received: from localhost.localdomain (CPE-76-177-97-210.natcky.res.rr.com.
	[76.177.97.210])
	by mx.google.com with ESMTPSA id i8sm27266024igt.17.2014.08.09.15.46.29
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 09 Aug 2014 15:46:29 -0700 (PDT)
From: Tyler Hall <tylerwhall@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  9 Aug 2014 18:46:19 -0400
Message-Id: <1407624380-21750-1-git-send-email-tylerwhall@gmail.com>
X-Mailer: git-send-email 2.0.3
Subject: [PATCH 0/1] Fix TOCTOU issue with sstate mirror
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
X-List-Received-Date: Sat, 09 Aug 2014 22:46:29 -0000

When attempting to use sstate from a mirror, the siginfo file will be checked
twice: first when deciding whether to run the setscene task and again while
fetching in the setscene task. If the file is removed from the mirror between
those two checks, the setscene task will run and fail. This is acceptable since
since the real task will be run instead, but currently the fetcher will emit an
error message which causes bitbake to return a nonzero exit code. The build
completes successfully but appears to have failed.

This race has occurred several times in practice when using an http sstate
server that periodically prunes old files.

The simple fix provided here is to downgrade the internal fetcher error message
to a warning and let the do_fetch task continue to generate its error level
message.

This is one of two paches. First openembedded-core must be patched to ignore
the "Error:" prefix when scraping the log for this message. Then bitbake's log
level can change.

Tyler Hall (1):
  fetch2: Downgrade the fetch failure log to a warning

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.0.3


