Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.33839.1618240362879920026
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 08:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: henning.schild@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13CFCdvl009582
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Apr 2021 17:12:39 +0200
Received: from md1za8fc.ad001.siemens.net ([139.22.41.180])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13CF5KQO004576;
	Mon, 12 Apr 2021 17:05:20 +0200
Date: Mon, 12 Apr 2021 17:05:19 +0200
From: henning.schild@siemens.com
To: <bitbake-devel@lists.openembedded.org>,
        Richard Purdie
 <richard.purdie@linuxfoundation.org>
Cc: <isar-users@googlegroups.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: add support for disabling shared clones on unpack
Message-ID: <20210412170519.53612c01@md1za8fc.ad001.siemens.net>
In-Reply-To: <20180130131805.4725ccf3@mmd1pvb1c.ad001.siemens.net>
References: <20171220164209.9609-1-henning.schild@siemens.com>
	<20171220174538.441d517f@mmd1pvb1c.ad001.siemens.net>
	<20180130131805.4725ccf3@mmd1pvb1c.ad001.siemens.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey,

this is still pretty much relevant to Isar, where an unpack with git
goes into a chroot. Having a way not clone "shared" would really help
us in Isar.

Any comments? Except for this one maybe not applying anymore, did not
try.

regards,
Henning

Am Tue, 30 Jan 2018 13:18:05 +0100
schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:

> Bump! Could i please get a review on this patch?
> 
> regards,
> Henning
> 
> Am Wed, 20 Dec 2017 17:45:38 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
> > We actually ran into that issue on a build system called Isar.
> > 
> > https://github.com/ilbers/isar
> > 
> > This build system executes some tasks in a chroot. In this chroot a
> > "shared" clone will not work because it expects its "alternate" to
> > be at the very same location it was outside the chroot. We
> > considered several hacks in Isar
> > - patching the alternates before and after chroot
> > - mounting the "alternate" to the exact location in chroot
> > None of this is really nice, so we decided to try and do something
> > about it upstream.
> > 
> > regards,
> > Henning
> > 
> > Am Wed, 20 Dec 2017 17:42:09 +0100
> > schrieb Henning Schild <henning.schild@siemens.com>:
> >   
> > > By default the unpacker will create a "shared" clone when cloning
> > > from the DL_DIR to the WORKDIR. This patch introduces an option to
> > > control that behaviour. Probably something that hardly anyone
> > > would want to do.
> > > 
> > > Imagine some recipe steps are executed in a namespace that is
> > > different from the one your downloader and unpacker ran in.
> > > (chroot) Because a "shared" clone has an absolute reference to its
> > > "alternate" you now have to make that "alternate" visible in that
> > > new namespace (chroot) at the exact place.
> > > 
> > > With this patch you can unpack "noshared" and get a stand-alone
> > > copy. This copy will also work if the "alternate" is not visible
> > > or existant.
> > > 
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > ---
> > >  lib/bb/fetch2/git.py | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 5ef8cd69..7b7f02b2 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -53,6 +53,13 @@ Supported SRC_URI options are:
> > >     For local git:// urls to use the current branch HEAD as the
> > > revision for use with AUTOREV. Implies nobranch.
> > >  
> > > +- noshared
> > > +   When unpacking do not clone with the parameter "--shared".
> > > This option will
> > > +   allow the unpacked copy to work stand-alone i.e. if your
> > > recipe runs in a
> > > +   chroot where the "alternate" can not be found. Setting this
> > > will increase
> > > +   the unpack-time and the disk-usage.
> > > +   The default is "0", set noshared=1 if needed.
> > > +
> > >  """
> > >  
> > >  #Copyright (C) 2005 Richard Purdie
> > > @@ -159,6 +166,8 @@ class Git(FetchMethod):
> > >  
> > >          ud.nobranch = ud.parm.get("nobranch","0") == "1"
> > >  
> > > +        ud.noshared = ud.parm.get("noshared","0") == "1"
> > > +
> > >          # usehead implies nobranch
> > >          ud.usehead = ud.parm.get("usehead","0") == "1"
> > >          if ud.usehead:
> > > @@ -176,7 +185,9 @@ class Git(FetchMethod):
> > >          if len(branches) != len(ud.names):
> > >              raise bb.fetch2.ParameterError("The number of name
> > > and branch parameters is not balanced", ud.url) 
> > > -        ud.cloneflags = "-s -n"
> > > +        ud.cloneflags = "-n"
> > > +        if not ud.noshared:
> > > +            ud.cloneflags += " -s"
> > >          if ud.bareclone:
> > >              ud.cloneflags += " --mirror"
> > >      
> >   
> 

