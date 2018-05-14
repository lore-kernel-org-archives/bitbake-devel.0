Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6092578415
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 14:21:41 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w4EELgpO024174
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 07:21:42 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Mon, 14 May 2018 07:21:40 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 14 May 2018 10:21:37 -0400
Message-ID: <20180514142139.165484-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/2] Add maximum task accounting
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 14 May 2018 14:21:41 -0000
Content-Type: text/plain

On my own machine, a 192 thread machine, if I start a new project without
a local download cache, I end of DoSing my machine.  I wanted a way to
create a maximum number of tasks, of any given type, so that I could limit
the number of concurrent do_fetch commands.

The first patch is a cleanup, while it's not required for the task accounting
I did discover that a few operations were happening in the wrong order --
this could cause a problem if anyone is trying to use the RunQueueStats in
new ways.

The second patch is the one that actually implements the max-task limits.
As noted in the comment, while theoretically you could set this in a recipe,
the behavior will be unpredictable, it's meant to be set in the global
configuration space, i.e. the local.conf.

I've been using these patches successfully for the path few months.


Mark Hatle (2):
  runqueue.py: Minor cleanup for RunQueueStats and users
  runqueue.py: Initial implementation of per task process limits

 lib/bb/runqueue.py | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

-- 
1.8.3.1


