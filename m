Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 489A860124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 18:54:09 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 07 Dec 2015 10:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,396,1444719600"; d="scan'208";a="614031604"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2015 10:54:11 -0800
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 7A78A6A4087;
	Mon,  7 Dec 2015 10:52:59 -0800 (PST)
Date: Mon, 7 Dec 2015 20:22:48 +0200
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20151207182248.GA9348@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
	<3bf6fe429855eb5b4d44e28c7bf832423d2f72cb.1449078919.git.avery.brian@gmail.com>
	<1449509817.19730.8.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1449509817.19730.8.camel@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 28/30] command: add CommandStarted event
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
X-List-Received-Date: Mon, 07 Dec 2015 18:54:12 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 07, 2015 at 05:36:57PM +0000, Richard Purdie wrote:
> Hi Ed,
> 
> On Wed, 2015-12-02 at 10:03 -0800, brian avery wrote:
> > From: Ed Bartosh <ed.bartosh@linux.intel.com>
> > 
> > This event will be used by toasterui to set BRBE build parameter
> > as soon as it's provided to bitbake server by Toaster.
> > 
> > Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> > Signed-off-by: brian avery <avery.brian@gmail.com>
> > ---
> >  lib/bb/command.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/lib/bb/command.py b/lib/bb/command.py
> > index 74106d1..78ce03a 100644
> > --- a/lib/bb/command.py
> > +++ b/lib/bb/command.py
> > @@ -31,6 +31,11 @@ Commands are queued in a CommandQueue
> >  import bb.event
> >  import bb.cooker
> >  
> > +class CommandStarted(bb.event.Event):
> > +    def  __init__(self, commandline):
> > +        bb.event.Event.__init__(self)
> > +        self.commandline = commandline
> > +
> >  class CommandCompleted(bb.event.Event):
> >      pass
> >  
> > @@ -60,6 +65,7 @@ class Command:
> >          self.currentAsyncCommand = None
> >  
> >      def runCommand(self, commandline, ro_only = False):
> > +        bb.event.fire(CommandStarted(commandline), self.cooker.expanded_data)
> >          command = commandline.pop(0)
> >          if hasattr(CommandsSync, command):
> >              # Can run synchronous commands straight away
> 
> I'm not sure I like the idea of this, particularly after I've seen what
> you're using it to do. Just from a performance standpoint, adding in an
> event per command execution adds in round trips and will increase the
> time something simple like "bitbake -p" takes to do nothing when the
> cache is hot.
>
> I note in a later patch you use this to check for a command coming from
> elsewhere to modify the data store and I worry that we'll end up with
> unstructured code if we encourage people to do that too.
>
The reason of adding this event is that I wanted to introduce generic
event that can be used by other people. Less generic ones would be 'VariableSet' or
'BRBESet'. I'm not sure those are better choice than CommandStarted.

> I did briefly talk to Brian and he mentioned you needed a way to
> differentiate between events from different builds. I'd suggest you can
> could do this if you markup the events as they come through your event
> receiver, since events for a specific build should come through a
> specific socket. Worst case I'd prefer doing this internally to bitbake
> rather than the command interception above but adding data to every
> event being sent over IPC is something I'd prefer to avoid if we can
> too.
>
There were no suitable events for this purpose I'm afraid. All events I
looked at were fired late than BRBE variable is set. I wanted to know
when it's changed as soon as possible.

> Would you be able to see if there is a different way we could handle
> this?
I'll try to look again.

--
Regards,
Ed

