Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUXPN-0004Mi-Hz
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 08:08:25 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4G5wNqT004977
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 22:58:23 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 15 May 2012 22:58:23 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 May 2012 13:55:27 +0800
Message-ID: <cover.1337147194.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/2] V3 replace os.system and os.popen with subbprocess module
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
X-List-Received-Date: Wed, 16 May 2012 06:08:26 -0000
Content-Type: text/plain

* Changes of V3:
  Use bb.process.run() rather than bb.process.Popen() to replace os.popen()

* Changes of V2:

  - Remove the 2>/dev/null since we dont' need it.
  - Use the wrapped Popen from bb.process, which is simpler than
    subprocess.Popen(....).

* Original message of V1:
Replace os.popen and os.system with subprocess.Popen and
subprocess.call, since the older functions would fail (more or less) if
the executed program cannot be found, this would cause potential errors
since we don't know whether the problem executed well or not.

For the performance issue, I've done the testing before the patches and
after with the oe-core layer (also the oe-core have applied the similar
patches):

# The sources are on local disk

1) Before applied these pacthes to bitbake and similar patches to oe-core:
$ time bitbake core-image-sato
real    177m50.723s
user    436m1.551s
sys     71m29.588s

2) After applied the pathes:
$ time bitbake core-image-sato
real    176m26.194s
user    436m7.931s
sys     71m1.994s

After applied these patches, the time has reduced 84 seconds, this is
very slight, I think that we can assume this is just a deviation, it
doesn't cause performance problems.

// Robert



The following changes since commit f3ba3cb6af96aebf5167bb1565edf11cceb7897f:

  gdk-pixbuf: Fix lsb builds where dependency may be missing (2012-05-15 19:44:37 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/subprocess
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/subprocess

Robert Yang (2):
  replace os.system with subprocess.call
  replace os.popen with subprocess.Popen

 bitbake/lib/bb/fetch2/perforce.py            |    9 +++++----
 bitbake/lib/bb/fetch2/svk.py                 |    2 +-
 bitbake/lib/bb/shell.py                      |    6 +++---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 ++-
 bitbake/lib/bb/ui/crumbs/hig.py              |    7 ++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    3 ++-
 bitbake/lib/bb/ui/ncurses.py                 |    4 ++--
 7 files changed, 19 insertions(+), 15 deletions(-)



