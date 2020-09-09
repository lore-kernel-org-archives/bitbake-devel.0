Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web11.11733.1599652548976919425
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 04:55:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 089BtGmR012482
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Sep 2020 04:55:37 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 04:55:20 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 0/3] Fix performance issues for bitbake-layers show-recipes (Saves 95% time)
Date: Wed, 9 Sep 2020 04:55:17 -0700
Message-ID: <cover.1599652176.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain

* V3
  - Define self.collection_res in an init function

* V2
  - Save prioritized BBFILES to BBFILES_PRIORITIZED

  - "bitbake-layers show-recipes" requires 14 min to run which was too slow,
    these 3 patches can make it run in 40s which can save 95% time.

  - It becomes slow since the following commit:
    (85e03a64: tinfoil: Simplify remote datastore connections)

* V1
  - Initial version

The following changes since commit c25309ecde4e7ff81fb74a74fe06991dcdbbbfc8:

  bitbake: cooker: Ensure parser worker signal handlers are default (2020-09-08 10:18:02 +0100)

are available in the Git repository at:

  git://git.yoctoproject.org/poky-contrib rbt/bblayers
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rbt/bblayers

Robert Yang (3):
  cooker.py: Save prioritized BBFILES to BBFILES_PRIORITIZED
  utils.py: get_file_layer(): Exit the loop when file is matched
  utils.py: get_file_layer(): Improve performance

 bitbake/lib/bb/cooker.py      |  2 +-
 bitbake/lib/bb/utils.py       | 17 ++++++++++++-----
 bitbake/lib/bblayers/query.py | 12 ++++++++++--
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.17.1

