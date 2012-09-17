Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8c-0003Qz-Eo
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:49:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbIQC001987
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:18 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:18 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:30 -0500
Message-ID: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Subject: [PATCH 0/8] knotty: Interactive logging changes
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
X-List-Received-Date: Mon, 17 Sep 2012 22:49:58 -0000
Content-Type: text/plain

This a series that was posted some time ago in conjunction with the
knotty2 -> knotty merge.  Since that time the knotty2 has been merged
into knotty.  This series of patches adds in the ability to
interactively control the logging behavior while building, or set
the defaults by using the variable BB_RT_LOGLEVEL.

Certainly I am open to the re-naming any of these variables and such
or even changing the key bindings.  I do find it quite useful to be
able track down problems without having to go snooping through logs.
Most of the problems I find or debug all use these logging changes, so
I would like to make another attempt to get them upstream.

Thanks,
Jason.

--

Jason Wessel (8):
      bitbake: Unbuffer stdout for log files
      knotty.py: Extend knotty to support "real time" log tail for tasks
      knotty.py: Add the ability to dynamically select loglevel from stdin
      msg.py, knotty.py: Allow dynamic toggle of the debug log level
      knotty.py: update footer on dynamic log level change
      knotty.py: Add interactive commands to knotty
      knotty.py: Add ability to dynamically toggle log location
      knotty.py: Handle rare interrupted select call

 bin/bitbake                      |    8 ++
 lib/bb/build.py                  |    4 +
 lib/bb/msg.py                    |    9 ++-
 lib/bb/ui/crumbs/multilogtail.py |  135 +++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py              |  178 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 330 insertions(+), 4 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/multilogtail.py




