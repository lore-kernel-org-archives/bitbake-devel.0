Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 484797DDCC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Oct 2019 23:19:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x91NJFBZ007986
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 1 Oct 2019 16:19:16 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.468.0; Tue, 1 Oct 2019 16:19:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 1 Oct 2019 16:17:42 -0700
Message-ID: <cover.1569971660.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 0/2] toaster: cummulative 100119 patch
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
X-List-Received-Date: Tue, 01 Oct 2019 23:19:15 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster cummulative patch October 01, 2019
  [YOCTO #13385] toaster: issues in import layer when clicking 'add layer'
  [YOCTO #13386]toaster: improve warnings when adding dependency to packages

The following changes since commit a73cbe649af5e988eddb4a35b81011cb482d7480:

  bitbake: siggen: Remove full path from unitaskhashes keys (2019-09-30 17:23:35 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_100119
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/toaster_cummulative_100119

David Reyna (2):
  toaster: issues in import layer when clicking 'add layer'
  toaster: improve warnings when adding dependency to packages

 lib/bb/ui/buildinfohelper.py                    | 10 ++++++++++
 lib/toaster/toastergui/static/js/importlayer.js | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
1.9.1


