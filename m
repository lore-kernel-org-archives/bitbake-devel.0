Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5715260777
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 03:31:50 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w4T3VoFB020711
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 28 May 2018 20:31:50 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 28 May 2018 20:31:50 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 May 2018 20:26:49 -0700
Message-ID: <cover.1527564213.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/2] toaster: broken custom.xml and threads patch
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
X-List-Received-Date: Tue, 29 May 2018 03:31:51 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The Toaster for Rocko is broken on HEAD. There are two patches that made it into master and Sumo, but missed Rocko.

The first patch fixes an error that breaks the initialization of Toaster.
The second patches fixes a change in behaviour for Django that creates an extra thread that blocks Toaster from shutting down.

The following changes since commit 7e7ee662f5dea4d090293045f7498093322802cc:

  build-appliance-image: Update to rocko head revision (2018-05-23 17:46:34 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/broken_customxml_threads_12751_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/broken_customxml_threads_12751_patch

David Reyna (2):
  bitbake: toaster: do not fail on optional 'custom.xml' file
  bitbake: Toaster: fix shutdown and extra threads

 bin/toaster                                                 | 4 ++--
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.9.1


