Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S2NFX-0000Br-QZ
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 14:37:52 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 28 Feb 2012 05:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="122511499"
Received: from unknown (HELO helios.localnet) ([10.252.123.68])
	by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2012 05:29:23 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Feb 2012 13:29:22 +0000
Message-ID: <3580154.xKMjJO2Syk@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <1330358657.4593.24.camel@ted>
References: <cover.1330351817.git.paul.eggleton@linux.intel.com>
	<f3c3d4bb21940b9f96a604145c76cfaef7b25943.1330351817.git.paul.eggleton@linux.intel.com>
	<1330358657.4593.24.camel@ted>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: implement BB_VERBOSE_LOGS
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
X-List-Received-Date: Tue, 28 Feb 2012 13:37:52 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 February 2012 16:04:17 Richard Purdie wrote:
> On Mon, 2012-02-27 at 14:11 +0000, Paul Eggleton wrote:
> > diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> > index e85d7c4..37686f8 100644
> > --- a/bitbake/lib/bb/build.py
> > +++ b/bitbake/lib/bb/build.py
> > 
> > @@ -221,9 +221,10 @@ def exec_func_shell(function, d, runfile, cwd=None):
> >      with open(runfile, 'w') as script:
> >          script.write('#!/bin/sh -e\n')
> > 
> > +        if bb.msg.loggerVerboseLogs:
> > +            script.write("set -x\n")
> > 
> >          data.emit_func(function, script, d)
> > 
> > -        script.write("set -x\n")
> > 
> >          if cwd:
> >              script.write("cd %s\n" % cwd)
> 
> Looks good to me but could I suggest one small tweak - position the set
> -x after data.emit_func()?
> 
> The reason being that having lines of output for each line in the run.*
> file is generally painful and it makes more sense to start tracing only
> when we start executing the function we care about.

OK, will send a v2 shortly.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


