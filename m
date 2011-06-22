Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1QZRYk-0000Ec-2t
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 19:49:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p5MHkEGW029953
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2011 10:46:14 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Wed, 22 Jun 2011 10:46:14 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jun 2011 12:57:48 -0500
Message-ID: <cover.1308765394.git.mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 0/1] Add the ability to specify a umask per task
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
X-List-Received-Date: Wed, 22 Jun 2011 17:49:50 -0000
Content-Type: text/plain

Add the ability to spcify a umask per-task.

The following changes since commit 5481cc90645e13c4e3cdea41e8e369528a0b1649:

  doc/usermanual.xml: Tweaks for the manual (2011-06-22 16:30:26 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib mhatle/bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=mhatle/bitbake

Mark Hatle (1):
  runqueue.py: Add umask task control

 lib/bb/build.py    |    1 +
 lib/bb/runqueue.py |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

-- 
1.7.3.4



