Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SX9mL-0005N8-Tt
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 13:30:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4N9e3ob001037
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 May 2012 02:40:03 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 23 May 2012 02:40:03 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 23 May 2012 17:40:18 +0800
Message-ID: <cover.1337764882.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] Force to teminate the Parser process
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
X-List-Received-Date: Wed, 23 May 2012 11:30:58 -0000
Content-Type: text/plain

This patch is for Yocto 2142.

Force to exit HOB when hob is parsing recipes, the bitbake doesn't stop.
It hangs on function BitBakeServerConnection::terminate in file
server/process.py:
    else:
        self.procserver.join()
It is waiting for the children process quit.

In stage of parse recipes BBCooker spawns Parser processes as many as
cpu numbers. When quit the Parser processes they make their internal
Queue to call cancel_join_thread() to avoid block but don't work at
this time.

So force to terminate the Parser processes.

The following changes since commit 3bf8069100e54153d13319dc32ca089327b6a139:

  documentation/yocto-project-qs/yocto-project-qs.xml: added quotes (2012-05-01 21:00:36 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/distro
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro

Kang Kai (1):
  cooker.py: terminate the Parser processes

 bitbake/lib/bb/cooker.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.5.4



