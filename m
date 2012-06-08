Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdB-0004ab-7H
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:37 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q58Dh51h023958
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:06 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:05 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:35 -0500
Message-ID: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Subject: [PATCH v4 0/18] Multiplexed task logs / bitbake fixes for fetch2 / stamp features
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:37 -0000
Content-Type: text/plain

This is the v4 patch set for various fixes/features to bitbake. 

The patches 13-15 are probably bit more of an RFC vs ready for merge,
in particular the patch 14.  Bitbake's setscene engine really
shouldn't know the specifics about what stamp (in this case do_patch)
should invalidate the use of setscene for any given task.  At the
moment there is no provision to be able to pass this from oe-core to
bitbake such that this can be generically specified.  That being said
the patch 14 does serve a real purpose to allow for incremental
building while preserving the setscene data without wiping out the
existing compile sources (which cleansstate does).

Thanks,
Jason.


-- New in v4 patch set --
   Patch 1 - Fix bug where the LogTee did not have a flush operation
             and caused a python trace
   Patch 13 - Add --no-setscene to avoid running any setscene task
              and force builds via the standard tasks
   Patch 14 - Invalidate setscene tasks if you have built locally
              to support using your build area as a "true scratch area"
   Patch 15 - Add bitbake -i STAMP to invalidate a specific stamp
              and run the do_build target

--  Previous information from v3 patch set --
   Patch 8 - knotty would not flush in a timely manner through |tee
   Patch 9 - knotty2 - fix reporting of set scene tasks
   Patch 10 - knotty2 - fix line wrap issues
   Patch 11 - merge knotty2 functionality into knotty
   Patch 12 - dynamically toggle log locations
   Patch 18 - OE Core specific change to make screen_inline the default 

--  Previous information from v2 patch set --

New in this series:
   Patch 5 - Change to the api for passing the screen connection
   Patch 6 - Fix logging in fetch2
   Patch 7 - Fix fetch2 failures to a read-only GITDIR
   Patch 16/17 - OE Core specific changes related to screen as a reference

-- Previous information from first patch set --

This patch set is intended to provide a semi real time aspect to the
logging to stdout.  Originally I was just interested in the output of
the do_compile and I will still consider adding that capability, but I
ended up using the logger generically.  It provides the ability to see
all the task logs multiplexed to stdout by PID.

More recently I decided I wanted to be able to toggle the logs on and
off while bitbake was already running, so that was added into the
series as well.  After seeing how that worked, I also decided I wanted
to be able to run the dev shell in a single terminal window.  The last
patch in the series is for the OE-Core, but since I made reference to
this patch I included in this series for completeness.

As a foot note, I have actually been using a more primitive version of
this patch set for the last 4 weeks that was controlled only by the
local.conf setting and used it to diagnose quite a few different
problems as well as to just understand what it is that bitbake is
doing at times.

--

Bitbake specific short log:

Jason Wessel (15):
      process.py,build.py: Fix log truncation problems with flush()
      knotty: Extend knotty to support "real time" log tail for tasks
      knotty: Add the ability to dynamically select loglevel from stdin
      msg.py, knotty.py: Allow dynamic toggle of the debug log level
      knotty.py: Add the ability to spawn screen directly from knotty with OE_TERMINAL=screen_inline
      fetch2: Fix missing output from stderr in fetcher logs
      fetch2/git.py: Use local download dir, when using an external read-only GITDIR
      knotty.py, knotty2,py: Flush and update footer on dynamic log level change
      knotty2.py: Fix knotty2 to report something other than 0 of 0 for setscene tasks
      knotty2: Properly adjust for lines longer than terminal size
      knotty: Merge knotty2 functionality into knotty
      knotty: Add ability to dynamically toggle log location
      bitbake,runqueue: Add --no-setscene to skip all setscene tasks
      runqueue.py,build.py: Invalidate setscene tasks based on do_unpack stamps
      bitbake,runqueue.py: Add -i to invalidate a stamp and rebuild the target

 bin/bitbake                      |    5 ++
 lib/bb/build.py                  |   15 +++++-
 lib/bb/fetch2/__init__.py        |    5 +-
 lib/bb/fetch2/git.py             |    5 +-
 lib/bb/msg.py                    |    9 +++-
 lib/bb/process.py                |   29 ++++++++++-
 lib/bb/runqueue.py               |   38 +++++++++++---
 lib/bb/ui/crumbs/multilogtail.py |  135 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py              |  283 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 lib/bb/ui/knotty2.py             |   51 +++++++++++++++++--
 lib/bb/ui/uihelper.py            |    5 ++
 11 files changed, 550 insertions(+), 30 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/multilogtail.py


