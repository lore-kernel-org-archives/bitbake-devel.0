Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5581B6FFED
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jan 2018 16:06:03 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w02G65fL022814
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Jan 2018 08:06:05 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Tue, 2 Jan 2018 08:05:51 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 2 Jan 2018 07:59:23 -0800
Message-ID: <cover.1514703701.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/1] toaster: cummulative 123117 patch
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
X-List-Received-Date: Tue, 02 Jan 2018 16:06:04 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


This patch repairs the second of two patch file corruptions that affected
#12192 "toaster: update Toaster for Django 1.11". The first corruption was found and
fixed by Richard before being committed.

That had been my first "V2" patch, and unfortunately the string "V2 " ended up in 
more places that just the header.


The following changes since commit 591b5b241d78e9d4ef8d5d3dd6280f7a4ff7ee17:

  bitbake: build.py: Don't return dependencies for tasks which don't exist (2017-12-28 15:08:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/repair_url_12459
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_123117_patch

David Reyna (1):
  toaster: corrupted patch for bldcollector URL file

 lib/toaster/bldcollector/urls.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1


