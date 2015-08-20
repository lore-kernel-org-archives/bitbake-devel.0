Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 263C865CBC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 07:36:14 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 20 Aug 2015 00:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,714,1432623600"; d="scan'208";a="628889699"
Received: from ljegan-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.8.54])
	by orsmga003.jf.intel.com with ESMTP; 20 Aug 2015 00:36:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Christopher Larson <clarson@kergoth.com>
Date: Thu, 20 Aug 2015 08:36:13 +0100
Message-ID: <25718099.WuexgQOq5e@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.4-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <CABcZANk5hNk0_gWucHdoHWe7m5h0O_tdZ0swJgNhtUGGBy1tNg@mail.gmail.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
	<9c6e61aab76b3cfad015aab68864bd1f920d9732.1439990327.git.paul.eggleton@linux.intel.com>
	<CABcZANk5hNk0_gWucHdoHWe7m5h0O_tdZ0swJgNhtUGGBy1tNg@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/4] bitbake-layers: remove-layer: accept just layer directory
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
X-List-Received-Date: Thu, 20 Aug 2015 07:36:16 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 19 August 2015 10:51:35 Christopher Larson wrote:
> On Wed, Aug 19, 2015 at 6:20 AM, Paul Eggleton <
> paul.eggleton@linux.intel.com> wrote:
> > If the specified layer isn't a path, then just match on the directory.
> > 
> > Fixes [YOCTO #7839].
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> > 
> >  bin/bitbake-layers | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> > index a0227d4..1b4694b 100755
> > --- a/bin/bitbake-layers
> > +++ b/bin/bitbake-layers
> > @@ -120,6 +120,8 @@ Removes the specified layer from bblayers.conf
> > 
> >          if args.layerdir.startswith('*'):
> >              layerdir = args.layerdir
> > 
> > +        elif not '/' in args.layerdir:
> > +            layerdir = '*/%s' % args.layerdir
> > 
> >          else:
> >              layerdir = os.path.abspath(args.layerdir)
> >          
> >          (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf,
> > 
> > None, layerdir)
> 
> Shouldn't this check to see if args.layerdir is an existing path, instead?

IIRC I think I didn't do this on the offchance that the user happened to have a 
directory named the same as one of the layers in their configuration in the 
current directory. A corner case to be sure but one that does happen on my 
machine (due to my less than stellar organisation skills).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

