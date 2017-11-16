Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5CAFA71ABD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Nov 2017 17:10:13 +0000 (UTC)
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 Nov 2017 09:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,404,1505804400"; 
   d="scan'208";a="161515"
Received: from $_hostname.zpn.intel.com (HELO lsandov1-mobl2.zpn.intel.com)
	([10.219.128.134])
	by orsmga006.jf.intel.com with ESMTP; 16 Nov 2017 09:10:14 -0800
Date: Thu, 16 Nov 2017 11:19:28 -0600
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Message-ID: <20171116111928.17c27c0b@lsandov1-mobl2.zpn.intel.com>
In-Reply-To: <20171116141541.5533-1-v.vogelhuber@digitalendoscopy.de>
References: <20171116141541.5533-1-v.vogelhuber@digitalendoscopy.de>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix mercurial fetching (hosttools need hd for latest revision autoinc, fix username and password usage and setting moddir needed by setup_revisions)
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
X-List-Received-Date: Thu, 16 Nov 2017 17:10:14 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


subject should be shorter answering the 'what this patch does' and the description the 'why this is needed'


On Thu, 16 Nov 2017 15:15:41 +0100
Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de> wrote:

> Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
> ---
>  bitbake/lib/bb/fetch2/hg.py | 27 +++++++++++++++++----------
>  meta/conf/bitbake.conf      |  2 ++
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
> index d0857e63f7..04620f3722 100644
> --- a/bitbake/lib/bb/fetch2/hg.py
> +++ b/bitbake/lib/bb/fetch2/hg.py
> @@ -66,13 +66,6 @@ class Hg(FetchMethod):
>          else:
>              ud.proto = "hg"
>  
> -        ud.setup_revisions(d)
> -
> -        if 'rev' in ud.parm:
> -            ud.revision = ud.parm['rev']
> -        elif not ud.revision:
> -            ud.revision = self.latest_revision(ud, d)
> -
>          # Create paths to mercurial checkouts
>          hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
>                              ud.host, ud.path.replace('/', '.'))
> @@ -86,6 +79,13 @@ class Hg(FetchMethod):
>          ud.localfile = ud.moddir
>          ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
>  
> +        ud.setup_revisions(d)
> +
> +        if 'rev' in ud.parm:
> +            ud.revision = ud.parm['rev']
> +        elif not ud.revision:
> +            ud.revision = self.latest_revision(ud, d)
> +
>          ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS")
>  
>      def need_update(self, ud, d):
> @@ -151,7 +151,7 @@ class Hg(FetchMethod):
>                  cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
>              else:
>                  cmd = "%s pull" % (ud.basecmd)
> -        elif command == "update":
> +        elif command == "update" or command == "up":
>              if ud.user and ud.pswd:
>                  cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
>              else:
> @@ -259,12 +259,19 @@ class Hg(FetchMethod):
>  
>          scmdata = ud.parm.get("scmdata", "")
>          if scmdata != "nokeep":
> +            proto = ud.parm.get('protocol', 'http')
>              if not os.access(os.path.join(codir, '.hg'), os.R_OK):
>                  logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
>                  runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
>              logger.debug(2, "Unpack: updating source in '" + codir + "'")
> -            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
> -            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
> +            if ud.user and ud.pswd:
> +                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull %s" % (ud.basecmd, ud.user, ud.pswd, proto, ud.moddir), d, workdir=codir)
> +            else:
> +                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
> +            if ud.user and ud.pswd:
> +                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" up -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, revflag), d, workdir=codir)
> +            else:
> +                runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
>          else:
>              logger.debug(2, "Unpack: extracting source to '" + codir + "'")
>              runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
> index 9696273acc..9ec527228b 100644
> --- a/meta/conf/bitbake.conf
> +++ b/meta/conf/bitbake.conf
> @@ -494,6 +494,8 @@ HOSTTOOLS_NONFATAL += "join nl size yes zcat"
>  
>  # Used by bzr fetcher
>  HOSTTOOLS_NONFATAL += "bzr"
> +# Used by hg fetcher
> +HOSTTOOLS_NONFATAL += "hg"
>  
>  CCACHE ??= ""
>  # ccache < 3.1.10 will create CCACHE_DIR on startup even if disabled, and
> -- 
> 2.11.0
> 
> -- 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

