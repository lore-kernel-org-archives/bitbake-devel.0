Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qreek-0005rk-QX
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 01:27:19 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 11 Aug 2011 16:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36972571"
Received: from vorpal.jf.intel.com (HELO [10.7.199.53]) ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 16:22:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 16:27:34 -0700
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1313105254.2506.8.camel@vorpal.jf.intel.com>
Mime-Version: 1.0
Subject: [RFC] Do postfiles make sense?
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
X-List-Received-Date: Thu, 11 Aug 2011 23:27:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

All,

Some time ago I added an -R switch to bitbake for configuration files to
load after bitbake.conf[1].

I'd been happily using this for the UI I've been working on without
fully realising that it's not safe to rely on postfiles to set variables
which affect the files included by bitbake.conf. For oe-core this
includes: BUILD_SYS, TARGET_SYS, MACHINE, SDKMACHINE and DISTRO.

In light of this flaw do postfiles make sense?

For the UI's purpose I think I'm going to have to switch to a prefile
(-r) in the wrapper script and add logic to hob to detect whether the
set variables differ from those in hob.local.conf - so that we can warn
those with a local.conf that uses = assignment that things won't work...

Thoughts? Suggestions?

Thanks,
Joshua

1.
http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=a8246ae5400c23df0d3ee29c36f4d9f257d1e6d1
-- 
Joshua Lock
        Yocto Project "Johannes Factotum"
        Intel Open Source Technology Centre



