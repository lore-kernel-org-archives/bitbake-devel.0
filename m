Return-Path: <mark.hatle@kernel.crashing.org>
X-Greylist: delayed 931 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 14 Feb 2020 18:24:15 UTC
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 4D3D56112C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 18:24:15 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01EI8SES032221
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO) for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 12:08:45 -0600
To: bitbake-devel@lists.openembedded.org
References: <20200214150109.29296-1-dl9pf@gmx.de>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <80610678-1f40-8b81-f852-4d48a950ef73@kernel.crashing.org>
Date: Fri, 14 Feb 2020 12:08:27 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214150109.29296-1-dl9pf@gmx.de>
Subject: Re: [PATCH] Fix bitbake-layerindex to checkout the requested branch
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
X-List-Received-Date: Fri, 14 Feb 2020 18:24:15 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

This issue was already found (and I thought fixed?)  Maybe the submission hadn't
been accepted.  See:

http://lists.openembedded.org/pipermail/bitbake-devel/2019-December/020645.html

Also comments below inline:

On 2/14/20 9:01 AM, dl9pf@gmx.de wrote:
> From: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
> 
> Bitbake-layerindex would not respect the branch given with -b .
> This fixes the clone command.
> 
> V2: Corrected 'branch' back to 'branches' and added
>     a FIXME on multiple LAYERSERIES_CORENAMES.
> V3: After discussion on IRC use branches[-1] as well
>     educated guess for now but leave the FIXME in place.
> 
> Signed-off-by: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
> ---
>  lib/bblayers/layerindex.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
> index 57cd9027..096ea4f8 100644
> --- a/lib/bblayers/layerindex.py
> +++ b/lib/bblayers/layerindex.py
> @@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
>      This class inherits ActionPlugin to get do_add_layer.
>      """
> 
> -    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
> +    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
>          layername = self.get_layer_name(url)
>          if os.path.splitext(layername)[1] == '.git':
>              layername = os.path.splitext(layername)[0]
> @@ -32,7 +32,7 @@ class LayerIndexPlugin(ActionPlugin):
>          layerdir = os.path.join(repodir, subdir)
>          if not os.path.exists(repodir):
>              if fetch_layer:
> -                result = subprocess.call(['git', 'clone', url, repodir])
> +                result = subprocess.call(['git', 'clone', '-b', branch, url, repodir])
>                  if result:
>                      logger.error("Failed to download %s" % url)

There are cases where it might be called if the branch is blank.  So the repo
URL should be called instead.  Thus -b should not be forced to always be there.
 (odd use-case, but it does exist.)

>                      return None, None, None
> @@ -73,6 +73,10 @@ class LayerIndexPlugin(ActionPlugin):
>              branches = [args.branch]
>          else:
>              branches = (self.tinfoil.config_data.getVar('LAYERSERIES_CORENAMES') or 'master').split()
> +
> +        # FIXME: multple branches is not deterministic when cloning the repository
> +        # for now we pull the last entry
> +        checkoutbranch = branches[-1]

The branch here is the name of the branch(es) to query the layerindex for.  They
are in order of priority, so the first found would be the one that is to be used.

>          logger.debug(1, 'Trying branches: %s' % branches)
> 
>          ignore_layers = []
> @@ -171,7 +175,7 @@ class LayerIndexPlugin(ActionPlugin):
>                  subdir, name, layerdir = self.get_fetch_layer(fetchdir,
>                                                        layerBranch.layer.vcs_url,
>                                                        layerBranch.vcs_subdir,
> -                                                      not args.show_only)
> +                                                      not args.show_only, checkoutbranch)

This is incorrect, it must use the branch value from the
layerBranch.actual_branch.  Since the branch in the repository and the branch
(corename) being questioned can and are often different.

--Mark

>                  if not name:
>                      # Error already shown
>                      return 1
> --
> 2.11.0
> 

