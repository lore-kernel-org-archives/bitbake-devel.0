Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RkbDX-0002tA-6v
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 13:54:19 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0ACknj1028141
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 04:46:49 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 10 Jan 2012 04:46:49 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Jan 2012 20:45:06 +0800
Message-ID: <cover.1326199289.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [PATCH 0/2] V2 Disk space monitoring
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
X-List-Received-Date: Tue, 10 Jan 2012 12:54:19 -0000
Content-Type: text/plain

Changes of V2:
* Rebase the code to the up to date master branch

Here are the test info:
1) set the following variables in conf/local.conf for testing:
   BB_DISKMON_DIRS = "${TMPDIR} ${DL_DIR} ${SSTATE_DIR} /home/lyang1"
   BB_DISKMON_MINSPACE = "200G"
   BB_DISKMON_MININODES = "20M"
   BB_DISKMON_INTERVAL = "30s"

   The TMPDIR, DL_DIR and SSTATE_DIR are in the same disk(/dev/sdb4) in
   my build, so I added another direcotory /home/lyang1 to test the
   ability of monitoring multi mount points.

2) bitbake core-image-sato
   WARNING: The free space of /dev/sdb5 is running low (25.915GB left)
   WARNING: The free inode of /dev/sdb5 is running low (1788.202K left)
   WARNING: The free space of /dev/sdb4 is running low (189.309GB left)
   WARNING: The free inode of /dev/sdb4 is running low (18005.443K left)

3) Aalso have tested about the following items:
   a) Use ctrl-c to stop the monitor
   b) The monitor should stop when the build stops
   c) Test the space unit G, B, K(case in-sensitive) and the time unit
      h, m, s(case-sensitive)

// Robert

The following changes since commit 468998cddbe1a803096c9b357e1b5daa3b7e8c2e:

  command.py: add parseConfigurationFiles API (2012-01-06 16:01:44 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/disk-space-monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/disk-space-monitor

Robert Yang (2):
  Disk space monitoring
  Add config sample for disk space monitoring

 bitbake/bin/bitbake               |   13 +++
 bitbake/lib/bb/monitordisk.py     |  153 +++++++++++++++++++++++++++++++++++++
 meta-yocto/conf/local.conf.sample |   28 +++++++
 3 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/monitordisk.py

-- 
1.7.4.1



