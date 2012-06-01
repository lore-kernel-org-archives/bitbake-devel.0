Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SaZP6-00022X-4j
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 23:29:04 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q51LIfNu021583
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 1 Jun 2012 14:18:41 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 1 Jun 2012 14:18:40 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 1 Jun 2012 16:18:30 -0500
Message-ID: <1338585519-869-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Subject: [PATCH v2 0/9] Multiplexed task logs / bitbake fixes for fetch2
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
X-List-Received-Date: Fri, 01 Jun 2012 21:29:04 -0000
Content-Type: text/plain

This is the second version of fixes and features for bit bake logging.

New in this series:
   Patch 5 - Change to the api for passing the screen connection
   Patch 6 - Fix logging in fetch2
   Patch 7 - Fix fetch2 failures to a read-only GITDIR
   Patch 8/9 - OE Core specific changes related to screen as a reference

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

Thanks,
Jason.


