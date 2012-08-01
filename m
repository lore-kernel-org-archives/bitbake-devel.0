Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SwTHt-0002fA-9X
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Aug 2012 09:24:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q717CTYM014468
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 1 Aug 2012 00:12:29 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Wed, 1 Aug 2012 00:12:29 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 1 Aug 2012 15:18:17 +0800
Message-ID: <cover.1343804786.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] contrib/dump_cache.py: dump recipe -> packages mapping from bb_cache.dat
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
X-List-Received-Date: Wed, 01 Aug 2012 07:24:09 -0000
Content-Type: text/plain

The following changes since commit 3309cf42d314f0a26079a11836c6b9b9bb5f253e:

  package_rpm.bbclass: Accomodate dash when using arrays (2012-07-31 12:22:10 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/dump_cache
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/dump_cache

Robert Yang (1):
  contrib/dump_cache.py: dump recipe -> packages mapping from bb_cache.dat

 bitbake/contrib/dump_cache.py |   68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 bitbake/contrib/dump_cache.py

-- 
1.7.10.4



