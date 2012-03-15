Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Gd-0006Is-75
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:42:39 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 15 Mar 2012 01:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="77811404"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 15 Mar 2012 01:33:51 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F60F395.9080502@linux.intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<42a098d7aa3f119f3f6735be07da727591ef8118.1331716896.git.dongxiao.xu@intel.com>
	<4F60F395.9080502@linux.intel.com>
Date: Thu, 15 Mar 2012 16:31:55 +0800
Message-ID: <1331800315.1855.25.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 02/11] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Thu, 15 Mar 2012 08:42:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-14 at 12:37 -0700, Joshua Lock wrote:
> 
> On 14/03/12 02:26, Dongxiao Xu wrote:
> > Currently for non-x86 architecture, there are un-resolved dependency
> > issue when generate universe dependency tree. Therefore disable the
> > handling of "NoProvider" event in Hob to enable the build for non-x86
> > architectures. After we resolved the dependency for universe, we still
> > need to handle this event in Hob.
> 
> I'm not sure we'll ever be able to strongly guarantee that NoProvider 
> issues won't creep in. Would we better off coming up with a more tenable 
> long term solution?

The current code is a strict check for NoProvider issue. Do you have any
suggestion on this one? What about putting the NoProvider error in
building time?

Thanks,
Dongxiao

> 
> >
> > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> 
> This is a reasonable short-term solution
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> 
> > ---
> >   lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++++++----------------
> >   1 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
> > index 6c109fc..9c82bfe 100644
> > --- a/lib/bb/ui/crumbs/hobeventhandler.py
> > +++ b/lib/bb/ui/crumbs/hobeventhandler.py
> > @@ -215,23 +215,26 @@ class HobHandler(gobject.GObject):
> >           elif isinstance(event, bb.command.CommandCompleted):
> >               self.current_phase = None
> >               self.run_next_command()
> > -
> > -        elif isinstance(event, bb.event.NoProvider):
> > -            if event._runtime:
> > -                r = "R"
> > -            else:
> > -                r = ""
> > -            if event._dependees:
> > -                self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
> > -            else:
> > -                self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
> > -            if event._reasons:
> > -                for reason in event._reasons:
> > -                    self.error_msg += " %s" % reason
> > -
> > -            self.commands_async = []
> > -            self.emit("command-failed", self.error_msg)
> > -            self.error_msg = ""
> > +        # TODO: Currently there are NoProvider issues when generate
> > +        # universe tree dependency for non-x86 architecture.
> > +        # Comment the follow code to enable the build of non-x86
> > +        # architectures in Hob.
> > +        #elif isinstance(event, bb.event.NoProvider):
> > +        #    if event._runtime:
> > +        #        r = "R"
> > +        #    else:
> > +        #        r = ""
> > +        #    if event._dependees:
> > +        #        self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
> > +        #    else:
> > +        #        self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
> > +        #    if event._reasons:
> > +        #        for reason in event._reasons:
> > +        #            self.error_msg += " %s" % reason
> > +
> > +        #    self.commands_async = []
> > +        #    self.emit("command-failed", self.error_msg)
> > +        #    self.error_msg = ""
> >
> >           elif isinstance(event, bb.command.CommandFailed):
> >               self.commands_async = []
> 




