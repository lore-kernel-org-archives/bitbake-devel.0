Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 027197F7A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 02:44:22 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xBJ2iKID006932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO) for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2019 20:44:21 -0600
To: bitbake-devel@lists.openembedded.org
References: <20191218184525.27246-1-jdmason@kudzu.us>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <3e0d7e89-2d4f-c8c3-e2d8-4de49f9c1c42@kernel.crashing.org>
Date: Wed, 18 Dec 2019 20:44:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218184525.27246-1-jdmason@kudzu.us>
Subject: Re: [PATCH] bitbake: layerindex: use branch when specified
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
X-List-Received-Date: Thu, 19 Dec 2019 02:44:23 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

I just found this same issue and was working on a fix.  What you have below is
almsot correct, however the value of the branch is NOT args.branch.

args.branch specifies the branch of the layerindex, but the layerindex
internally knows the name of the branch corresponding the release branch.

You actually need to get the 'actual_branch' value from the layerBranch item.

See below:

On 12/18/19 12:45 PM, Jon Mason wrote:
> When currently specified, the branch is used to verify the versioning of
> the meta layer, but the master branch is checked out.  This change
> allows for the branch to be specified.  Now it is easy to specify all
> of the meta layers being added are of the same version, without having
> to do it in each individual git tree.  Also, it will error if there are
> branches without a matching version.  Finally, this allows for meta
> layer git trees without a master branch.
> 
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  bitbake/lib/bblayers/layerindex.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
> index 57cd9027f6..55029e0482 100644
> --- a/bitbake/lib/bblayers/layerindex.py
> +++ b/bitbake/lib/bblayers/layerindex.py
> @@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
>      This class inherits ActionPlugin to get do_add_layer.
>      """
>  
> -    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
> +    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
>          layername = self.get_layer_name(url)
>          if os.path.splitext(layername)[1] == '.git':
>              layername = os.path.splitext(layername)[0]
> @@ -32,7 +32,9 @@ class LayerIndexPlugin(ActionPlugin):
>          layerdir = os.path.join(repodir, subdir)
>          if not os.path.exists(repodir):
>              if fetch_layer:
> -                result = subprocess.call(['git', 'clone', url, repodir])
> +                if not branch:
> +                    branch = "master"
> +                result = subprocess.call(['git', 'clone', '-b' , branch, url, repodir])
>                  if result:
>                      logger.error("Failed to download %s" % url)
>                      return None, None, None
> @@ -171,7 +173,8 @@ class LayerIndexPlugin(ActionPlugin):
>                  subdir, name, layerdir = self.get_fetch_layer(fetchdir,
>                                                        layerBranch.layer.vcs_url,
>                                                        layerBranch.vcs_subdir,
> -                                                      not args.show_only)
> +                                                      not args.show_only,
> +                                                      args.branch)

The above should be 'layerBranch.actual_branch', instead of args.branch.

For example, in master -- "meta-gumstix" in master is set to the branch 'dora'.

--Mark

>                  if not name:
>                      # Error already shown
>                      return 1
> 

