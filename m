Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 6585877089
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:59:51 +0000 (UTC)
Received: by wieq12 with SMTP id q12so84761708wie.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 06:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=F4lVAIOZFiKjG9+Gw2sWLDEV8RpGHr9Oyc5BhbIDtjQ=;
	b=BXjq73FGfu507ym3RH+8D+B5mgqW75DKY22vzjP2vGbCaLbLAawExmHZEb+OkcPoSS
	UXM/vKjQjCRzqQpnnkSFq2wzBmx+rV15Ii+mDMg+WGsg2nflItIwr5t6huGeGrOQL08F
	NZMfahpPzJbzPUdAQYa9oPclOKKfQ+rrEXWmbAAKkmeAQewAXiDtjPPei2R0M9NsMUS+
	iLbpO0Z79pVKclmngByC8RBVS00PE15JvHYW0zqXrhAwg4Z9UWDGzgLQ1e7u1qYJ7zsI
	hJowtl20KhDbYsldVTSIkyFltMZJQohJmBu5/LN09MzhWuoz+jcb1ruSAMVIspTQ9rVG
	ndqw==
X-Gm-Message-State: ALoCoQlf8P1HrVj43LaDO51YjcKV/azI0sft5RpjI6bu76V3Hnz+nBQ5hgZOafAsBJrVn0WryyMQ
X-Received: by 10.194.192.6 with SMTP id hc6mr4109193wjc.33.1444831171641;
	Wed, 14 Oct 2015 06:59:31 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	p2sm10241826wjb.21.2015.10.14.06.59.30
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 06:59:30 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 14:59:13 +0100
Message-Id: <cover.1444830820.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] toaster: Fix error thrown by command line builds project page
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
X-List-Received-Date: Wed, 14 Oct 2015 13:59:54 -0000


This patch series fixes an exception being thrown when viewing
the default "command line builds" project while a bitbake command line
build is running.

It also modifies and cleans up the toaster startup script so that
the bldcontrol migrations are applied in analysis mode, as well as
in managed mode. This should help prevent other errors which may
occur in analysis mode due to missing database tables.


Available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/submit/elliot/toaster/cli_builds_error-8277
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/submit/elliot/toaster/cli_builds_error-8277

Elliot Smith (3):
  toaster: Always run bldcontrol migrations
  toaster: Check whether buildrequest exists before using it
  toaster: Test that exception isn't thrown by project page

 bin/toaster                     | 56 ++++++++++++++++++++++++++++-------------
 lib/toaster/orm/models.py       | 20 +++++++++++++--
 lib/toaster/toastergui/tests.py | 30 ++++++++++++++++++++++
 3 files changed, 87 insertions(+), 19 deletions(-)

-- 
2.1.4


