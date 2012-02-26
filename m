Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1ZuP-0000Jj-4e
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 09:56:45 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1Q8mIPs010719
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 00:48:18 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 26 Feb 2012 00:48:18 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Feb 2012 16:48:13 +0800
Message-ID: <cover.1330245845.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [PATCH 0/3] V5 Disk space monitoring
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 26 Feb 2012 08:56:45 -0000
Content-Type: text/plain

Hi Richard,

Thank you very much for your detailed review, here is V5,
please take your review.

Changes:

* Add the patch "Fix finish_now when no running task" which is from you.

* Change the code as you suggested.

* Change the default disk interval value from "10M,50" to "50M,5K",
  this seems a reasonable value during the testing(not too many or
  few warnings).

* Add more explanations in local.conf.sample

// Robert

The following changes since commit 2ff96d664e8e003f64de42187fce9ad0f9646070:

  crumbs: add back progress implementation for depexp (2012-02-25 11:55:45 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/disk-space-monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/disk-space-monitor

Robert Yang (3):
  Fix finish_now when no running task
  Disk space monitoring
  Add config sample for disk space monitoring

 bitbake/lib/bb/monitordisk.py     |  237 +++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/runqueue.py        |   14 ++
 meta-yocto/conf/local.conf.sample |   33 +++++
 3 files changed, 284 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/monitordisk.py

-- 
1.7.4.1



