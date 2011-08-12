Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs1FG-0007CG-29
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 01:34:30 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Aug 2011 16:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="37337490"
Received: from unknown (HELO [10.255.15.3]) ([10.255.15.3])
	by orsmga002.jf.intel.com with ESMTP; 12 Aug 2011 16:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 16:29:50 -0700
In-Reply-To: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
References: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1313191795.2228.6.camel@scimitar>
Mime-Version: 1.0
Subject: Re: Conditional assignment broken
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
X-List-Received-Date: Fri, 12 Aug 2011 23:34:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2011-08-13 at 06:50 +0800, James Limbouris wrote:
> Hi,
> 
>  Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditional assignment
>  in all conf files. Previously, the environment was copied from a
> cleaned up os environment.
>  After the commit, a pristine environment is available in
> data['_data'], and will be copied to
>  data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
> Variables not conditionally
>  assigned will still be available from data['_data'], also in defiance
> of BB_ENV_EXTRAWHITE.
> 
>  To verify, simply:
> 
>  export RANDOMENV=42
>  bitbake -e | grep RANDOMENV

Thanks for the report James, and apologies for the breakage. I'll try
and get a fix submitted and merged asap.

I'm now wondering if we want the pristine environment, or the cleaned
environment, saved.

diff --git a/bin/bitbake b/bin/bitbake
index fdeeb36..d151dd5 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -197,13 +197,11 @@ Default BBFILES are the .bb files in the current
directory
     handler = bb.event.LogHandler()
     logger.addHandler(handler)
 
-    # Before we start modifying the environment we should take a
pristine
-    # copy for possible later use
-    initialenv = os.environ.copy()
     # Clear away any spurious environment variables. But don't wipe the
     # environment totally. This is necessary to ensure the correct
operation
     # of the UIs (e.g. for DISPLAY, etc.)
     bb.utils.clean_environment()
+    initialenv = os.environ.copy()
 
     server = server.BitBakeServer()

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



