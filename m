Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RzQ6y-00057x-OY
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Feb 2012 11:04:49 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1K9uUnp008421
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Feb 2012 01:56:30 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Mon, 20 Feb 2012 01:56:30 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Feb 2012 17:53:54 +0800
Message-ID: <cover.1329727465.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [PATCH 0/2] V4 Disk space monitoring
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
X-List-Received-Date: Mon, 20 Feb 2012 10:04:49 -0000
Content-Type: text/plain

Hi Richard,

Here is V4, the main changes are:
1) Can set each directory's threshold separately
2) Can choose the action when the disk space is running low:
   a) Warn
   b) No new task
   c) Abort
3) Change the time interval to disk space(or inode) interval, the reason
   is:
   If we use the time interval, then we need a timer, and the timer
   should be actived when the runqueue starts, and it should combine
   closely with the runqueue since it it needs controll the task(no new
   task), and the timer should in the subprocess, otherewise it would
   block the runqueue, it seems hard to terminate to pass the Ctrl-C
   to the subprocess since the Ctrl-C is captured by the ui, so I change
   the time interval to the disk space(or inode) interval, this seems
   more reasonable than the time interval, it would only warn when the
   disk space reduce more than the interval, for example, if the interval
   is 10M, it would warn when the space is lower than the threshold, and
   warn again when the space reduce more than 10M.

4) The testing result: (The action would be executed when the space or inode
   is lower than the threshold):
   a) When the space is running low:
      BB_DISKMON_DIRS = "${TMPDIR},130G,20M"
      i) BB_DISKMON_ACTION = "WARN"
         WARNING: The free space of /dev/sdb4 is running low (119.700GB left)
         ...

         The build will go on, and will warn again when the disk space reduces
         more than interval.

     ii) BB_DISKMON_ACTION = "NO_NEW_TASK"
         WARNING: The free space of /dev/sdb4 is running low (119.689GB left)
         WARNING: No new tasks can be excuted since BB_DISKMON_ACTION = "NO_NEW_TASK"!

         The build will stop after other tasks has been done

    iii) WARNING: The free space of /dev/sdb4 is running low (119.689GB left)
         ERROR: Immediately abort since BB_DISKMON_ACTION = "ABORT"!

        The build will stop immediately.

   b) The similar to the inode, and also the similar to more than one disks
       are monitored.

// Robert

The following changes since commit 41a83ccfe50ec69425a4828fb5836d38d3f99e67:

  guile: fix cross configure failure (2012-02-10 17:01:42 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/disk-space-monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/disk-space-monitor

Robert Yang (2):
  Disk space monitoring
  Add config sample for disk space monitoring

 bitbake/bin/bitbake               |    1 +
 bitbake/lib/bb/monitordisk.py     |  177 +++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/runqueue.py        |   67 +++++++++++++-
 meta-yocto/conf/local.conf.sample |   29 ++++++
 4 files changed, 271 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/bb/monitordisk.py

-- 
1.7.4.1



