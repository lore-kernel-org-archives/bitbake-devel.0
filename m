Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 8EF67782BC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Jun 2017 17:12:05 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Jun 2017 10:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,334,1493708400"; d="scan'208";a="97170513"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga004.jf.intel.com with ESMTP; 12 Jun 2017 10:12:06 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Jun 2017 10:12:03 -0700
Message-Id: <1497287524-5406-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: richard.purdie@intel.com, jurobystricky@hotmail.com,
	paul.eggleton@linux.intel.com
Subject: [PATCH 0/1] flush stdout/stderr to log file
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
X-List-Received-Date: Mon, 12 Jun 2017 17:12:05 -0000

This patch fixes the bug https://bugzilla.yoctoproject.org/show_bug.cgi?id=10785
It was observed that some messages may not make it into the log file.
Alternatively, they may end up in the log file but in wrong order.
It is fairly simple to demostrate this, please see the bug description.

Simplified, the logging code (in proccess.py) looks like this:

def _logged_communicate(pipe, log, input, extrafiles):
   <...>
   while ProcessOpen
       log fifo(s)
       log stdout 
       log stderr

   # Process closed....
   log fifo(s)

The messages are written in a round-robin fashion and if he "Process" is closed somewhere in
the loop, some of the pipes may have still data in them. Also, the "Process" may be already closed
before the code reaches the "while" loop and hence the pipes do not get a chance to be logged/drained. 
Note after "Process" is closed we do make effort to drain/log fifos but not stdout/stderr.

So the fix is this:

   while ProcessOpen
       log fifo(s)
       log stdout 
       log stderr

   # Drain pipes after process closed
   log fifo()
   log stdout
   log stderr

Which can be refactored as:

    def log_all_pipes:
       log fifo(s)
       log stdout 
       log stderr

    while ProcessOpen
       log_all_pipes

   # Drain all pipes after process closed
   log_all_pipes

I extensively tested the patch with the following test cases:

do_test1() {
    bbdebug 1 "breakage"
    echo "this will not be printed"
    printf "nor this\n"
}

do_test2() {
    echo "this will not be printed"
    bbdebug 1 "breakage"
    printf "nor this\n"
}

do_test3() {
    echo "line1"
    bbdebug 1 "breakage1 line2"
    echo "this will not be printed (line3)"
    printf "nor this (line4)\n"
    bbdebug 1 "breakage2 line5"
}

do_test4() {
    bbdebug 1 "breakage1 line2"
    bbdebug 1 "breakage2 line2"
}

Juro Bystricky (1):
  bitbake:process: flush stderr/stdout to log

 bitbake/lib/bb/process.py | 81 +++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

-- 
2.7.4


