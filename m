Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 620D871A82
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:40:43 +0000 (UTC)
Received: by mail-pf0-f182.google.com with SMTP id 189so25678858pfz.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=x4NLPReVpFdWEIi/jYiO6t/moh5k9HkLIpxmGwt7C2w=;
	b=lzX/fhau8RJuv7i+TN2gAP3OqDdll/5DHoP+2yPMxZP6RtbbTtiOUTxOOGMiknZkYv
	vudzLM1hAUEjJpstYY1ZKie8PNuQQUQetSo4f97G1SsnCWuomF0sCKAWqxlKoQ2P3hUD
	wlW1b2SzWhVtWYHU0lYDubJOZGKO51/TBOGbu3zD4zXuaGkBeSJbPMdqiAE8+hzzOEeH
	Oud9SjbnKjzuaxtdYjekmr0yoQiK5CzhEbdnzHj7qSpsPcxHEQfdwgUXO+jziR0fI1na
	zHmq20pJGgBiMWLI7O5iDjdwRsveLyY8IpqCiMqnNvtH0TECO8xnchdj12GogE/HlStr
	PGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=x4NLPReVpFdWEIi/jYiO6t/moh5k9HkLIpxmGwt7C2w=;
	b=LRmKBV+0MaKr1aeHywd/MI4Q3ON4Pmak8W2rBhUIgXZHE/rZmeck7KdQNYLx6K440n
	LmkVYVqBueEm/mRmqZCWdPCxDcrG2kcML9T/T3b3kTYzrdzLfwvIzzkE+WyP41ppx9CE
	ZX9ga3kTDDmidQd8DJCS/bjuSTJng66WHD6VIH89Py5frsR2LRGx5Kja/ZY3IRZ4vP5i
	cTswSp++8rJgRzak2md3lNmAX4y9jLM0rFxs3F7XYs6AG/lff0VhMeME20R21UGIIgsx
	7CVoejq211CQPLYEpG3/GUGP+9xYEa85KRzvIrzz7bjaVOgNvcHekXIGMFE5KpLNiJcd
	e8zg==
X-Gm-Message-State: ABUngvcx9h6k9BhNwJWkBg3w8GJfL0Yo6cK7x29ST2eNQiSm2tKbL5MtDBKa3/lxNuxg+D6c
X-Received: by 10.99.7.210 with SMTP id 201mr42147119pgh.51.1477932045537;
	Mon, 31 Oct 2016 09:40:45 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	j192sm36718494pfc.60.2016.10.31.09.40.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 31 Oct 2016 09:40:45 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 16:40:36 +0000
Message-Id: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/4] toaster event eventreplay tests
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
X-List-Received-Date: Mon, 31 Oct 2016 16:40:44 -0000

From Ed Bartosh:
This patchset adds 2 tests that use eventreplay script to "replay" core-image-minimal and zlib build events.

Note that tests require event files that are not included into the patchset due to their big size. Please, have a look at README file for the instructions how to produce event files.

####

*Note* This adds new files and depends on series "toaster: Fixes and clean ups" 28/10/2016

Branch available at:

git://git.yoctoproject.org/poky-contrib ed/toaster/tests/eventreplay
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/tests/eventreplay

####

Ed Bartosh (4):
  toaster: use current directory if BUILDDIR is not set
  toaster: add eventreplay test case for core-image-minimal
  toaster: add eventreplay test case for zlib
  toaster: add tests/eventreplay/README

 lib/toaster/orm/models.py                 |  2 +-
 lib/toaster/tests/eventreplay/README      | 22 +++++++
 lib/toaster/tests/eventreplay/__init__.py | 97 +++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 lib/toaster/tests/eventreplay/README
 create mode 100644 lib/toaster/tests/eventreplay/__init__.py

-- 
2.7.4


