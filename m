Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 058F86142A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 22:06:37 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01IM67kp020976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO) for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 16:06:37 -0600
To: bitbake-devel@lists.openembedded.org
References: <20200218135554.19362-1-dl9pf@gmx.de>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <503a475e-e96d-2bd7-c132-a0df0b886be6@kernel.crashing.org>
Date: Tue, 18 Feb 2020 16:06:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218135554.19362-1-dl9pf@gmx.de>
Subject: Re: [PATCH] bitbake: layerindex: allow clones to be shallow
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
X-List-Received-Date: Tue, 18 Feb 2020 22:06:38 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Ack, this looks fine.

It would be nice (in the future) to have a way to specify an optional depth,
that could be passed through the system.  But as implemented it's fine.

--Mark

On 2/18/20 7:55 AM, Jan-Simon Moeller wrote:
> When bitbake-layers fetch-layerindex clones the repositories, these are
> full clones. Allow the user to specify '-s' and do shallow clones
> instead for faster downloads.
> 
> Signed-off-by: Jan-Simon Moeller <dl9pf@gmx.de>
> ---
>  lib/bblayers/layerindex.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
> index aa3b682d..95b67a66 100644
> --- a/lib/bblayers/layerindex.py
> +++ b/lib/bblayers/layerindex.py
> @@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
>      This class inherits ActionPlugin to get do_add_layer.
>      """
> 
> -    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
> +    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch, shallow=False):
>          layername = self.get_layer_name(url)
>          if os.path.splitext(layername)[1] == '.git':
>              layername = os.path.splitext(layername)[0]
> @@ -32,10 +32,12 @@ class LayerIndexPlugin(ActionPlugin):
>          layerdir = os.path.join(repodir, subdir)
>          if not os.path.exists(repodir):
>              if fetch_layer:
> -                cmd = ['git', 'clone', '-b' , branch, url, repodir]
> -                if not branch:
> -                    # Branch really shouldn't be empty, but use the repo default if it is
> -                    cmd = ['git', 'clone', url, repodir]
> +                cmd = ['git', 'clone']
> +                if shallow:
> +                    cmd.extend(['--depth', '1'])
> +                if branch:
> +                    cmd.extend(['-b' , branch])
> +                cmd.extend([url, repodir])
>                  result = subprocess.call(cmd)
>                  if result:
>                      logger.error("Failed to download %s (%s)" % (url, branch))
> @@ -176,7 +178,8 @@ class LayerIndexPlugin(ActionPlugin):
>                                                        layerBranch.layer.vcs_url,
>                                                        layerBranch.vcs_subdir,
>                                                        not args.show_only,
> -                                                      layerBranch.actual_branch)
> +                                                      layerBranch.actual_branch,
> +                                                      args.shallow)
>                  if not name:
>                      # Error already shown
>                      return 1
> @@ -209,6 +212,7 @@ class LayerIndexPlugin(ActionPlugin):
>          parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch, parserecipes=False)
>          parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
>          parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch')
> +        parser_layerindex_fetch.add_argument('-s', '--shallow', help='do only shallow clones (--depth=1)', action='store_true')
>          parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
>          parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
> 
> --
> 2.11.0
> 

