Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7DD24731D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 21:42:34 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 07 Mar 2016 13:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,553,1449561600"; d="scan'208";a="904280477"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 07 Mar 2016 13:42:35 -0800
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id B06776A4002;
	Mon,  7 Mar 2016 14:30:20 -0800 (PST)
Date: Mon, 7 Mar 2016 21:22:43 +0200
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Message-ID: <20160307192243.GB5834@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
	<1457087406.3285.3.camel@linux.intel.com>
	<6accf51a177b4b4b9d7452f14b03b610@XBOX02.axis.com>
MIME-Version: 1.0
In-Reply-To: <6accf51a177b4b4b9d7452f14b03b610@XBOX02.axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Mon, 07 Mar 2016 21:42:34 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 04, 2016 at 03:20:12PM +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Joshua G Lock
> > Sent: den 4 mars 2016 11:30
> > To: bitbake-devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH] xmlrpc: fix bug in setting
> > XMLRPCServer.single_use
> > 
> > On Fri, 2016-03-04 at 10:13 +0200, Ed Bartosh wrote:
> > > XMLRPCServer.single_use attribute was always set to False.
> > > This caused xmlrpc server to keep running after build is done as
> > > BitBakeServerCommands.removeClient only shuts down server if its
> > > single_use attribute is set to True.
> > >
> > > Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> > > ---
> > >  bitbake/lib/bb/server/xmlrpc.py | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/bitbake/lib/bb/server/xmlrpc.py
> > > b/bitbake/lib/bb/server/xmlrpc.py
> > > index 1ceca51..d627550 100644
> > > --- a/bitbake/lib/bb/server/xmlrpc.py
> > > +++ b/bitbake/lib/bb/server/xmlrpc.py
> > > @@ -193,6 +193,8 @@ class XMLRPCServer(SimpleXMLRPCServer,
> > > BaseImplServer):
> > >          BaseImplServer.__init__(self)
> > >          if (interface[1] == 0):     # anonymous port, not getting
> > > reused
> > >              self.single_use = True
> > > +        else:
> > > +            self.singe_use = False
> > 
> > This won't work, right? Typo.
> > 
> > Regards,
> > 
> > Joshua
> 
> Or you can simplify it as:
> 
>             self.single_use = interface[1] == 0

I thought about doing this. Decided not to do as it's less readable from
my point of view.

--
Regards,
Ed

