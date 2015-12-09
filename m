Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id EC41D6FF7D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 14:25:59 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so31540187pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=NOSvlsGwlbSFq/Jc+tLiOsV9aoZqS03qcHVNDy4xg+g=;
	b=j9zzvQQkFY9+H74eC/jsEZdyPL1/aSuhQHwNCYopZLrwBDcTxmK0U1lH2nifujHI3n
	D1vsM0LrhjJfFkKrp0Rgtqgi3MS4Cdd2+iXjgU+9HC3QasJmNo7uYvCfSk/8KWO64mu8
	X/RECGYDU50sUNINcDUIC45GOJ5I0xy46YNdJXhGy6Cul8qqfQfsZzaCPZaCKVFEOvMp
	y9LOZilarArI0HIqnzrOU6/svWGOOoJcOM13aa5E4kalPaMMZ9qC/9dzyokpCCIueBFS
	hUF4T7ONHGCOJDQOYWsMSwoX2O8P4LnJwp2rYbKRJxnY0CpOJWBVDmQzfTfJOKRZ2sOb
	p6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NOSvlsGwlbSFq/Jc+tLiOsV9aoZqS03qcHVNDy4xg+g=;
	b=m972hdYIn8OR7IgSdFCXAAf4JBsBAdyF3VhP4uJdhWtGhywi0VXbPw2TkzT5YMxmhY
	aavS24Ys9s9WJQK2UA0ajx/Dqi8cK+cdx6JR2rXZ8lrYhRV7WOZ7hUjUgdmTpOKJ9mQA
	7s8jpTGmG50zBsIdlW7jZ4uLzOxao/0zeWwjdFLv/9PxOXP02ioi51vGt8saD+2VgCr+
	GWIycvtLujA5Ql2K0ICcde1s/rL7h/6G3lj+hnVNhnbfxncpvRDaEJFlCj3gKRTtjPsI
	Wx688Z5UwxiiBeGbDWN5aXHt5keaHNXnxgFrCCP83Xm+t73kdUvr/F9UqoedGLML5Sfn
	kuCA==
X-Gm-Message-State: ALoCoQlZ0QxPI2S6Q+CJbAfeODYcFJSt3Q3uPY/BROr4tDRHlxS5jgONBhw58Hw/9RSaJvJwnHzvDu9dfU4H86h/nFo0vgqWHQ==
X-Received: by 10.98.71.157 with SMTP id p29mr13346596pfi.152.1449671159983;
	Wed, 09 Dec 2015 06:25:59 -0800 (PST)
Received: from draco.icx.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	k2sm12095175pfj.25.2015.12.09.06.25.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 06:25:58 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 14:25:46 +0000
Message-Id: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] Pass BRBE to buildinfohelper as soon as it's set
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
X-List-Received-Date: Wed, 09 Dec 2015 14:26:01 -0000

This fixes 'hanging' builds in UI when build is failed on early stages (recipe
parsing or processing configuration).

See also https://lists.yoctoproject.org/pipermail/toaster/2015-December/003464.html

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/trigger-metadata-event


Ed Bartosh (3):
  toaster: implement BitbakeController.triggerEvent
  toaster: trigger SetBRBE event
  toasterui: process SetBRBE event

 lib/bb/ui/toasterui.py                          | 2 ++
 lib/toaster/bldcontrol/bbcontroller.py          | 3 +++
 lib/toaster/bldcontrol/localhostbecontroller.py | 3 +++
 3 files changed, 8 insertions(+)

-- 
2.1.4


