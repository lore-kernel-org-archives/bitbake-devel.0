Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoJts-0001cC-KG
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 20:41:08 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 11:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="34731357"
Received: from unknown (HELO [10.255.13.215]) ([10.255.13.215])
	by orsmga001.jf.intel.com with ESMTP; 02 Aug 2011 11:36:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 02 Aug 2011 11:36:40 -0700
In-Reply-To: <1312292259.2344.593.camel@rex>
References: <cover.1312240827.git.josh@linux.intel.com>
	<a727b7256bcab11fb35c712a5920c1b8ed6f9425.1312240827.git.josh@linux.intel.com>
	<1312292259.2344.593.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1312310206.2423.18.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] cooker: store a list of parsed configuration files
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
X-List-Received-Date: Tue, 02 Aug 2011 18:41:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-02 at 14:37 +0100, Richard Purdie wrote:
> On Mon, 2011-08-01 at 16:22 -0700, Joshua Lock wrote:
> > Signed-off-by: Joshua Lock <josh@linux.intel.com>
> > ---
> >  lib/bb/cooker.py                     |    3 +++
> >  lib/bb/parse/parse_py/ConfHandler.py |    3 +++
> >  2 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index 025dfe4..c7142e1 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -772,6 +772,9 @@ class BBCooker:
> >          for p in postfiles:
> >              data = _parse(p, data)
> >  
> > +        self.configuration.parsed_configuration = (bb.data.getVar('PARSED_CONF', data) or '').split(':')
> > +        bb.data.delVar('PARSED_CONF', data)
> > +
> >          # Handle any INHERITs and inherit the base class
> >          bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
> >          for bbclass in bbclasses:
> > diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
> > index 102c0e9..22686b7 100644
> > --- a/lib/bb/parse/parse_py/ConfHandler.py
> > +++ b/lib/bb/parse/parse_py/ConfHandler.py
> > @@ -103,6 +103,9 @@ def handle(fn, data, include):
> >  
> >      # DONE WITH PARSING... time to evaluate
> >      bb.data.setVar('FILE', fn, data)
> > +    conf_files = bb.data.getVar('PARSED_CONF', data) or ''
> > +    bb.data.setVar('PARSED_CONF', "%s:%s" % (conf_files, abs_fn), data)
> > +
> >      statements.eval(data)
> >      if oldfile:
> >          bb.data.setVar('FILE', oldfile, data)
> 
> Hmm, this isn't particularly nice :/
> 
> At the very least call the variable __BB<something> to indicate its
> internal.
> 
> Did you find and have a look at the internal __depends and
> __base_depends variables?

I see them, that does seem like a more explicit and therefore cleaner
way of achieving this.

There'll be a series out shortly inspired by that and using an internal
namespace on the variable.

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



