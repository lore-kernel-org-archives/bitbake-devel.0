Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1Sym7Y-0006q7-Qt
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 Aug 2012 17:55:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q77FhEOl002565
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Aug 2012 08:43:14 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Tue, 7 Aug 2012 08:43:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 7 Aug 2012 23:48:55 +0800
Message-ID: <cover.1344346253.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Tue, 07 Aug 2012 15:55:01 -0000
Content-Type: text/plain

The following changes since commit c86d26cb976e665b1516e72153f3f686f62dedf9:

  subversion: Add missing build dependency on sqlite3 (2012-08-06 16:14:06 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/whatchanged
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/whatchanged

Robert Yang (1):
  bitbake-whatchanged: print what is about to happen

 bitbake/bin/bitbake-whatchanged | 334 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 334 insertions(+)
 create mode 100755 bitbake/bin/bitbake-whatchanged

-- 
1.7.11.2



