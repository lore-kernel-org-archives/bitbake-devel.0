Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
	[209.85.192.181])
	by mail.openembedded.org (Postfix) with ESMTP id F0DC165C98
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 14:57:11 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so25178505pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 07:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=EQbqiriNbDZGDy6D4h2DQAyLtnTz7fJVuXsC1pA4by4=;
	b=RolOBTIDVGsmAR0ErpAiP5zpRsc5UpbEhnaX77WxMiyHm9jP70gXIBF6lPjV/0Sr0M
	UoU4R3sMlMcPZkQuNX/AIUYSYjZlcJ22nEsB0pEVresQ7Nij/4mQpSvW+vOcP2IVkKn7
	E/V/qsRy/GX/OYm2Yu17mETFgirqY/R14sPLFEsEO9ugqEK3h+By64wpQ7NI/J1f7Ulw
	LbzcL93NqKDJ20wws3qmEZis0Q/+xPxyNKrhJC4+tT9004OHvAXGcse8xqKankwWxgok
	kszlBxtA3pi0MLk2hpuNSYtjxVu2GoMHMmzHTsjD20d7aRXD3WuLmzyjkEgf1OiXwqLJ
	oyHw==
X-Gm-Message-State: ALoCoQnNMj3v7KOe3c4A1b9nJasIHJpYechUW0R9KFaKNWIm9dUpV8o4hu+jZJSjAmGnFMPCWs1R
X-Received: by 10.70.136.106 with SMTP id pz10mr3296567pdb.105.1428677833143; 
	Fri, 10 Apr 2015 07:57:13 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ve3sm2542517pbc.22.2015.04.10.07.57.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 07:57:12 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 7B9C1560CE2; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:00 +0100
Message-Id: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [dizzy 0/7] inotify patchset back-port
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
X-List-Received-Date: Fri, 10 Apr 2015 14:57:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is the backport of the inotify patchset that allows the bitbake
server to read files (configuration and recipes) modified while it is running.

This backport allows proper Toaster experience for Yocto Project 1.7 Dizzy users.

I've tested this patch both functionally and performance-wise, and I could not
find any obvious bugs.

Thank you,
Alex

Alexandru DAMIAN (1):
  cooker: read file watches on server idle

Richard Purdie (6):
  bitbake: Add pyinotify to lib/
  cooker/cache/parse: Implement pyinofity based reconfigure
  cooker: Fix pyinotify handling of ENOENT issues
  cooker: Further optimise pyinotify
  cooker: Improve pyinotify performance
  cooker/server: Fix up 100% CPU usage at idle

 lib/bb/cache.py          |    5 +-
 lib/bb/cooker.py         |   79 +-
 lib/bb/parse/__init__.py |    5 +
 lib/bb/server/process.py |    3 +
 lib/bb/server/xmlrpc.py  |    3 +
 lib/pyinotify.py         | 2416 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 2508 insertions(+), 3 deletions(-)
 create mode 100644 lib/pyinotify.py

-- 
1.9.1


