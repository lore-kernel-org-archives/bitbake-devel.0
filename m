Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (unknown [74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id D770165F1A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 13:36:52 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id u57so5464528wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 06:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=UcDlcp455fI2tk/Z5bEYpZy8YPAFhLrQh2jaACRnReY=;
	b=XdvTBE2cQI27KaWF7yA9xUjGqVoPOqDVC5Pr8Wb6R8Ub7p3JYO0kBtNh3LZb3QEU/T
	WAt319sZWYxWVXcpsSqanwph/Yvrjc6y1VsMEQhagkJtEXlOhn9VRveL52aQjcm+4BHe
	FZYGl1+aQOCWov3BzztRI6npcJaLag/Jyt8QQ+vZJCsvBQn7DXenYzLOm9Y6bdAlSaIt
	SmTPR9Hslp9iqXRmUQa5Bb2yTz5w4fZoH8YrXM70Dzk+j2nN0aPUSV3SU9+uCrrlrrQX
	6IhbHk6sIyfJSSKs92ECTwqyOh0f/Y5mcTMyTuHaUXXWEnCVQRP1i9Rj63yVGJKZdcxg
	e0+w==
X-Gm-Message-State: ALoCoQmOpl6b0LhHMKQPAIT+C8FoO4z6D3hwXnJIXSiCCvG9amMfvPxDqIg1QQn17aWEDftrAXTK
X-Received: by 10.180.212.48 with SMTP id nh16mr13070977wic.49.1400506613357; 
	Mon, 19 May 2014 06:36:53 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ph8sm14182539wjb.32.2014.05.19.06.36.51 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 19 May 2014 06:36:52 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B82055603B0; Mon, 19 May 2014 14:36:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 May 2014 14:36:50 +0100
Message-Id: <cover.1400506418.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/2] Fixes for xmlrpc code
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
X-List-Received-Date: Mon, 19 May 2014 13:36:58 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello, 

These are two patches that refactor the XMLRPC client code to make it more reusable,
with the goal of using the client class directly in the Toaster build controller to
start, control and stop a bitbake server.

Can you please review and merge ?

Cheers,
Alex


The following changes since commit ef2bf63e56b87e19d1a9059dd2d81a9a1a537254:

  fetch2/gitsm: Documentation improvements for gitsm:// fetcher (2014-05-19 12:02:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140519-xmlrpcfixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140519-xmlrpcfixes

Alexandru DAMIAN (2):
  bitbake: move configuration reading code
  xmlrpc: client - remove fatal errors

 bin/bitbake             | 46 +++++++++++++++++++++++++++++++++++-----------
 lib/bb/server/xmlrpc.py | 33 ++++++---------------------------
 2 files changed, 41 insertions(+), 38 deletions(-)

-- 
1.9.1


