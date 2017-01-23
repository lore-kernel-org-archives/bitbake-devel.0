Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 178B07319F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jan 2017 08:45:22 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 23 Jan 2017 00:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,274,1477983600"; d="scan'208";a="1086189909"
Received: from jheng2-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.132.52])
	by orsmga001.jf.intel.com with ESMTP; 23 Jan 2017 00:45:21 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jan 2017 21:45:19 +1300
Message-ID: <3401278.g9qvUHL6E8@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.8.13-100.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <1484181858-2247-1-git-send-email-msm-oss@mcclintock.net>
References: <1484181858-2247-1-git-send-email-msm-oss@mcclintock.net>
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake-layers: show-appends: add optional argument to limit package list
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
X-List-Received-Date: Mon, 23 Jan 2017 08:45:23 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wed, 11 Jan 2017 18:44:18 Matthew McClintock wrote:
> Add ability to limit output per package:
> 
> $ bitbake-layers show-appends m4
> === Matched appended recipes ===
> m4_1.4.17.bb:
>  
> /home/mattsm/git/openembedded-core/meta-selftest/recipes-test/m4/m4_1.4.17.
> bbappend
> 
> Useful for writing tools to process the output, and debugging
> bbappends for specific packages
> 
> Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
> ---
>  lib/bblayers/query.py | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
> index 5def717..bef3af3 100644
> --- a/lib/bblayers/query.py
> +++ b/lib/bblayers/query.py
> @@ -242,17 +242,22 @@ skipped recipes will also be listed, with a "
> (skipped)" suffix.
> 
>  Lists recipes with the bbappends that apply to them as subitems.
>  """
> -
> -        logger.plain('=== Appended recipes ===')
> +        if args.pnspec:
> +            logger.plain('=== Matched appended recipes ===')
> +        else:
> +            logger.plain('=== Appended recipes ===')
> 
>          pnlist = list(self.tinfoil.cooker_data.pkg_pn.keys())
>          pnlist.sort()
>          appends = False
>          for pn in pnlist:
> +            if args.pnspec and pn != args.pnspec:
> +                continue
> +
>              if self.show_appends_for_pn(pn):
>                  appends = True
> 
> -        if self.show_appends_for_skipped():
> +        if not args.pnspec and self.show_appends_for_skipped():
>              appends = True
> 
>          if not appends:
> @@ -477,7 +482,8 @@ NOTE: .bbappend files can impact the dependencies.
>          parser_show_recipes.add_argument('-i', '--inherits', help='only
> list recipes that inherit the named class', metavar='CLASS', default='')
> parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe
> name specification (wildcards allowed, enclose in quotes to avoid shell
> expansion)')
> 
> -        self.add_command(sp, 'show-appends', self.do_show_appends)
> +        parser_show_appends = self.add_command(sp, 'show-appends',
> self.do_show_appends) +        parser_show_appends.add_argument('pnspec',
> nargs='?', help='optional recipe name specification (wildcards allowed,
> enclose in quotes to avoid shell expansion)')
> 
>          parser_show_cross_depends = self.add_command(sp,
> 'show-cross-depends', self.do_show_cross_depends)
> parser_show_cross_depends.add_argument('-f', '--filenames', help='show full
> file path', action='store_true')

Acked-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

