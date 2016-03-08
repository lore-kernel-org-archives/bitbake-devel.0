Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E64D16FF23
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 08:28:05 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 00:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,556,1449561600"; d="scan'208";a="61912374"
Received: from jlock-mobl1.gar.corp.intel.com ([10.252.7.23])
	by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2016 00:28:04 -0800
Message-ID: <1457425665.3474.5.camel@linux.intel.com>
From: Joshua G Lock <joshua.g.lock@linux.intel.com>
To: ed.bartosh@linux.intel.com
Date: Tue, 08 Mar 2016 08:27:45 +0000
In-Reply-To: <20160307192120.GA5834@linux.intel.com>
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
	<1457087406.3285.3.camel@linux.intel.com>
	<20160307192120.GA5834@linux.intel.com>
X-Mailer: Evolution 3.18.5.1 (3.18.5.1-1.fc23) 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Tue, 08 Mar 2016 08:28:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2016-03-07 at 21:21 +0200, Ed Bartosh wrote:
> On Fri, Mar 04, 2016 at 10:30:06AM +0000, Joshua G Lock wrote:
> > 
> > On Fri, 2016-03-04 at 10:13 +0200, Ed Bartosh wrote:
> > > 
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
> > >          if (interface[1] == 0):     # anonymous port, not
> > > getting
> > > reused
> > >              self.single_use = True
> > > +        else:
> > > +            self.singe_use = False
> > This won't work, right? Typo.
> > 
> Why do you think so? It works for me so far :)

I don't know toaster's code and only have the context from this diff,
however it looks like you've removed a line that sets a single_use
variable and added a line that sets a singe_use variable. These are
different variables (looks like the result of a typo) thus I wouldn't
expect it to work, or at least I wouldn't expect the addition of this
line to have affected things.

(Just to be sure I used git grep on the bitbake repository and didn't
find any instances of singe_use).

Regards,

Joshua

