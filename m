Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 26FE37FD66
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 20:51:03 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id r13so7198692ioa.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kudzu-us.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7NEFE/FtNF6EOZEH+mgg44hDIWKtSkaXJvCzPrkRBno=;
	b=rzVN+H3+EdjA2Sfw4g+sK6uUaTQR+v8Yhsc3sSwuwhVWra4y9cqrwdLbf0H/uk9NEU
	5guT+NvQofmlj0PVPjh+uQYRGZzoBfSLGw0bwDgHmiJa9B+CNXk7ABR4vBAeqhjlayVS
	4zEleEL8THRR/QYRRLi7uJJYoJgZpBDJnzBTi9Ayan5u3WfQu8lxQZYWjQ+1CIZkXrO5
	iv0/ySJX6B0iVWuvobW7HMej/gpTujOtLkhA10fdGrvfYR6ExoTTctiPyvokDMmfIebj
	0qDq9JsG/h4rrjtIp/jMV83hS8qvWJWX70dhdCgMikTP0YB/wj1ud+u0wUnUh9+Yzv1b
	O+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7NEFE/FtNF6EOZEH+mgg44hDIWKtSkaXJvCzPrkRBno=;
	b=NE+7ikMEO9TcJfEm3aKrDmvQaeA00ThozTMPAryyZbsUkn5BVU+yaHsNGu+17hN5vP
	ZVLgqcue2Y+8h01Fl1lARpG7ljlQikvfeDL5FnI698kuJFDP7ZZv8M3+Jz8u8kXia7Va
	/cDsrxXYLmDNWmuOB+ImhCilRMA4Ux4g5NU6OPLrjG65j0TONPj/PIBzThdMj0kr9QnB
	fTeTMFkAdl2R2dMyU+wvGoW/AfV4tEoe9tbUVM1A4mjfMMn54c27m0zwiKlWOe9ylf0g
	MX8GE2luc8QFKETit67r0v9aFMNG5tYgM8jR17j2mgNY3lJckl3EKdz3fQVWrkYyo95Z
	cqbQ==
X-Gm-Message-State: APjAAAUByswuZn1B7RsCmM+nKgVRwSzq582iOEa+qJ83CxtAuw4QngTq
	ZNG4NAGYhADG6CifIeUBMN5KApdOy2GCuAv8JmClsQ==
X-Google-Smtp-Source: APXvYqzyRRKqhe8gQSD0bW9umTKK7wBZnGRHYAqMsbT/C9NAAkVD6SpndyI7iYWf38y8hHxnsryg/rNKhoWVfhYTa50=
X-Received: by 2002:a02:b897:: with SMTP id p23mr9227952jam.58.1576788663834; 
	Thu, 19 Dec 2019 12:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20191219173908.46461-1-mark.hatle@kernel.crashing.org>
In-Reply-To: <20191219173908.46461-1-mark.hatle@kernel.crashing.org>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 19 Dec 2019 15:50:53 -0500
Message-ID: <CAPoiz9yDkC2CXZjrabCW=y5yQok=KkWHAi-Z-mTZEwswrot_cA@mail.gmail.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] bitbake: layerindex: use branch when specified
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
X-List-Received-Date: Thu, 19 Dec 2019 20:51:03 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 19, 2019 at 12:39 PM Mark Hatle
<mark.hatle@kernel.crashing.org> wrote:
>
> From: Jon Mason <jdmason@kudzu.us>
>
> When currently specified, the branch is used to verify the versioning of
> the meta layer, but the master branch is checked out.  This change
> allows for the branch to be specified.  Now it is easy to specify all
> of the meta layers being added are of the same version, without having
> to do it in each individual git tree.  Also, it will error if there are
> branches without a matching version.  Finally, this allows for meta
> layer git trees without a master branch.
>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
>
> Minor rework of the patch to use the layerBranch actual_branch since
> the layerindex referenced branch may be different then the overall
> release branch.
>
> Also adjust the patch to use the default git checkout branch instead of
> master if no branch was specified.  (Some repositories don't have a
> master branch.)
>
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>


Looks good to me!

Thanks,
Jon


> ---
>  lib/bblayers/layerindex.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
> index 57cd9027..aa3b682d 100644
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
> @@ -32,9 +32,13 @@ class LayerIndexPlugin(ActionPlugin):
>          layerdir = os.path.join(repodir, subdir)
>          if not os.path.exists(repodir):
>              if fetch_layer:
> -                result = subprocess.call(['git', 'clone', url, repodir])
> +                cmd = ['git', 'clone', '-b' , branch, url, repodir]
> +                if not branch:
> +                    # Branch really shouldn't be empty, but use the repo default if it is
> +                    cmd = ['git', 'clone', url, repodir]
> +                result = subprocess.call(cmd)
>                  if result:
> -                    logger.error("Failed to download %s" % url)
> +                    logger.error("Failed to download %s (%s)" % (url, branch))
>                      return None, None, None
>                  else:
>                      return subdir, layername, layerdir
> @@ -171,7 +175,8 @@ class LayerIndexPlugin(ActionPlugin):
>                  subdir, name, layerdir = self.get_fetch_layer(fetchdir,
>                                                        layerBranch.layer.vcs_url,
>                                                        layerBranch.vcs_subdir,
> -                                                      not args.show_only)
> +                                                      not args.show_only,
> +                                                      layerBranch.actual_branch)
>                  if not name:
>                      # Error already shown
>                      return 1
> --
> 2.17.1
>

