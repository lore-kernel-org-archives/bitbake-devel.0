Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1T81bD-0002wC-B0
	for bitbake-devel@lists.openembedded.org;
	Sun, 02 Sep 2012 06:15:51 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8243VcM013221
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 1 Sep 2012 21:03:31 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Sat, 1 Sep 2012 21:03:30 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 2 Sep 2012 12:08:50 +0800
Message-ID: <cover.1346558600.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] fetch2: unpack rpm, ipk and deb binary package
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
X-List-Received-Date: Sun, 02 Sep 2012 04:15:51 -0000
Content-Type: text/plain

This is useful for unpacking the binary package.

// Robert

The following changes since commit 9ba1e33e2d14362971d6441ee6142bcb0857df1a:

  sstate: Ensure master.list exists if it doesn't already (2012-08-30 22:45:56 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/unpack_rpm_ipk_deb
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/unpack_rpm_ipk_deb

Robert Yang (1):
  fetch2: unpack rpm, ipk and deb binary package

 bitbake/lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.11.2



