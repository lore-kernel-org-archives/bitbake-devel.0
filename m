Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 199E677047
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 08:22:28 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 15 Sep 2016 01:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,338,1470726000"; d="scan'208";a="879060631"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 15 Sep 2016 01:22:29 -0700
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id CADC26A4080;
	Thu, 15 Sep 2016 01:22:05 -0700 (PDT)
Date: Thu, 15 Sep 2016 11:22:15 +0300
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160915082215.GA11487@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <1473432540-22120-1-git-send-email-ed.bartosh@linux.intel.com>
	<1473926604.7207.71.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1473926604.7207.71.camel@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: check if target contains task
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
X-List-Received-Date: Thu, 15 Sep 2016 08:22:31 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 15, 2016 at 09:03:24AM +0100, Richard Purdie wrote:
> On Fri, 2016-09-09 at 17:49 +0300, Ed Bartosh wrote:
> > Task name was incorrectly added to the targets that already
> > contained :task suffix and fired with BuildInit event. This
> > caused Toaster to create incorrect Target objects and show
> > them in UI.
> > 
> > [YOCTO #10221]
> > 
> > Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> > ---
> >  bitbake/lib/bb/cooker.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index b7d7a7e..2952f9e 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1421,7 +1421,8 @@ class BBCooker:
> >          if not task.startswith("do_"):
> >              task = "do_%s" % task
> >  
> > -        packages = ["%s:%s" % (target, task) for target in targets]
> > +        packages = [target if ':' in target else '%s:%s' (target,
> > task) for target in targets]
> > +
> >          bb.event.fire(bb.event.BuildInit(packages),
> > self.expanded_data)
> >  
> >          taskdata, runlist = self.buildTaskData(targets, task,
> > self.configuration.abort)
> 
> I put this into a build without looking too closely, the result was
> near enough everything failed with failures like:
> 
> http://autobuilder.yocto.io:8010/builders/buildtools/builds/37
> 

Sorry for the typo. I'll send an update in a minute.

--
Regards,
Ed

