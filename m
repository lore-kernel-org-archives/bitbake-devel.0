Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E58AD6FF9F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Apr 2016 08:40:53 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 20 Apr 2016 01:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,509,1455004800"; d="scan'208";a="962553343"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2016 01:40:33 -0700
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id BB7C76A4002;
	Wed, 20 Apr 2016 02:28:10 -0700 (PDT)
Date: Wed, 20 Apr 2016 09:20:42 +0300
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160420062042.GB12553@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
	<1461095936.31320.27.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1461095936.31320.27.camel@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: main: add 2 environment variables
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
X-List-Received-Date: Wed, 20 Apr 2016 08:40:55 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 08:58:56PM +0100, Richard Purdie wrote:
> On Tue, 2016-04-19 at 17:30 +0300, Ed Bartosh wrote:
> > Bitbake uses set of environment variables to set command line
> > options, e.g. seeting BBTOKEN variable has the same effect
> > as using --token command line option.
> > 
> > Added new environment variables BBPRECONF and BBPOSTCONF that
> > are equivalents of --read and --postread command line options.
> > They can be used by high level scripts to append or prepend
> > configuration files to conf/local.conf
> > 
> > [YOCTO #9235]
> > 
> > Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> > ---
> >  bitbake/lib/bb/main.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> > index e302173..1dd7877 100755
> > --- a/bitbake/lib/bb/main.py
> > +++ b/bitbake/lib/bb/main.py
> > @@ -250,6 +250,12 @@ class
> > BitBakeConfigParameters(cookerdata.ConfigParameters):
> >          if "BBEVENTLOG" in os.environ:
> >              options.writeeventlog = os.environ["BBEVENTLOG"]
> >  
> > +        if "BBPRECONF" in os.environ:
> > +            option.prefile = os.environ["BBPRECONF"]
> > +
> > +        if "BBPOSTCONF" in os.environ:
> > +            option.postfile = os.environ["BBPOSTCONF"]
> > +
> 
> I think for principle of least surprise the commandline should override
> the environment, append to the environment (but then which order?) or
> it should just error and tell the user if they specify both the
> commandline and environment options at the same time.
> 
I agree. I found it confusing myself. I did it this way to be consistent
with current way of handling env variables in bitbake main().
I'll send v2 soon.


--
Regards,
Ed

