Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id E045E7E553
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 17:02:14 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id v18so6499984iol.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kudzu-us.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yg0hZgx8XkYKocqOUK3P9hQeVbo1yCYbCiHGh/k9/xM=;
	b=0MzyEkLnDa60yLA0GjpLVh9r9yFU3EBUY1wACGWxpe9cPssyfX8wyszoVXD19H8KOC
	Ed5vesaGMai5Bvm2WKZwJkIrJ9AfwHLiwqoWTqPlMxdohG2EroNXnHCnvKCrEJo5gz0m
	vjnipoxFkzs0pqMilbqy46v2+GgIq5ZjY82PSkYnOH7YMUBqVNG/JT+B1RYImkzj4A/H
	qeBICqXfP7ODOZGnFxLkaTRhwtHT7h4ZnaU88RMu5RFIfTi7A0ow3kYr83Zlz8FWVond
	i/+JyBmeEStXhvFkNvWsC4M/butqFpIfjV6rkxUHFuWygweFZ0JOr8QE7Ta9eApU9Tc7
	WSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yg0hZgx8XkYKocqOUK3P9hQeVbo1yCYbCiHGh/k9/xM=;
	b=Zv576gPvQrvmkP2r7NqPfGHxGk6i5Pd4DEiV605I/q8pAyov98WMuFS1yEJXar9H3Z
	RKJt7VBTXbhu+c1Kz4HAbD4aVU1HABLbEPl+lDrCGA1Tdn1/j/ll/gEg99Blv8pizTbL
	TYAWNzeY2a8qKHQxD3H1SjGTGhyzRdmOXd6PkRv5qWGSSpXpctJUphwbN9Sk5vlKBtQr
	4trr0DD/3zlZGDd8Oa1NwT5CmOz717klVf23dmEealU3kerXx+y8SKEVFuTuwyfZxiNl
	rNnQLUFS1HMMBKXBm/hxFAFBseIjrdBiD1xzL1v83hzHHQ5iGQznn8Ahi5L+v5twzgw1
	n7Mw==
X-Gm-Message-State: APjAAAU5oYM2PdmSWPdG5gkisxTZb6fiWdNJk0NUOs+szRPhgKAj9gtF
	42eLRkupPiV00fkxkiJLGw3irDQvDpJ0/4vCL+hQJ4Qqy/Y=
X-Google-Smtp-Source: APXvYqwAELd1FzTR7agp8yCeJfYFv1BUt0auOUyLSjNd70mH3M+GqnkMYjTMkyNJWBDosa33vxasFY7V8n8BE36sNFw=
X-Received: by 2002:a5d:94c4:: with SMTP id y4mr6605035ior.163.1576774935759; 
	Thu, 19 Dec 2019 09:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20191218184525.27246-1-jdmason@kudzu.us>
	<3e0d7e89-2d4f-c8c3-e2d8-4de49f9c1c42@kernel.crashing.org>
	<e10cc269-4fb5-5ca7-e4cb-d2b49676087a@kernel.crashing.org>
In-Reply-To: <e10cc269-4fb5-5ca7-e4cb-d2b49676087a@kernel.crashing.org>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 19 Dec 2019 12:02:05 -0500
Message-ID: <CAPoiz9wVmk+yuHNiDm4XG=LgcE70nsf_yfRSpDu1zOj=cDqLjg@mail.gmail.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 19 Dec 2019 17:02:15 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 19, 2019 at 11:18 AM Mark Hatle
<mark.hatle@kernel.crashing.org> wrote:
>
> I just realized I wasn't clear with my reply yesterday.  I will start with Jon's
> patch, and make the change and test it and then send up a V2.  (Since I was
> already working on that code.)

Oh, I was literally about to send out v2 with your fixup (sanity
testing it now).  I'll nix that now.

Thanks,
Jon

>
> --Mark
>
> On 12/18/19 8:44 PM, Mark Hatle wrote:
> > I just found this same issue and was working on a fix.  What you have below is
> > almsot correct, however the value of the branch is NOT args.branch.
> >
> > args.branch specifies the branch of the layerindex, but the layerindex
> > internally knows the name of the branch corresponding the release branch.
> >
> > You actually need to get the 'actual_branch' value from the layerBranch item.
> >
> > See below:
> >
> > On 12/18/19 12:45 PM, Jon Mason wrote:
> >> When currently specified, the branch is used to verify the versioning of
> >> the meta layer, but the master branch is checked out.  This change
> >> allows for the branch to be specified.  Now it is easy to specify all
> >> of the meta layers being added are of the same version, without having
> >> to do it in each individual git tree.  Also, it will error if there are
> >> branches without a matching version.  Finally, this allows for meta
> >> layer git trees without a master branch.
> >>
> >> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> >> ---
> >>  bitbake/lib/bblayers/layerindex.py | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
> >> index 57cd9027f6..55029e0482 100644
> >> --- a/bitbake/lib/bblayers/layerindex.py
> >> +++ b/bitbake/lib/bblayers/layerindex.py
> >> @@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
> >>      This class inherits ActionPlugin to get do_add_layer.
> >>      """
> >>
> >> -    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
> >> +    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
> >>          layername = self.get_layer_name(url)
> >>          if os.path.splitext(layername)[1] == '.git':
> >>              layername = os.path.splitext(layername)[0]
> >> @@ -32,7 +32,9 @@ class LayerIndexPlugin(ActionPlugin):
> >>          layerdir = os.path.join(repodir, subdir)
> >>          if not os.path.exists(repodir):
> >>              if fetch_layer:
> >> -                result = subprocess.call(['git', 'clone', url, repodir])
> >> +                if not branch:
> >> +                    branch = "master"
> >> +                result = subprocess.call(['git', 'clone', '-b' , branch, url, repodir])
> >>                  if result:
> >>                      logger.error("Failed to download %s" % url)
> >>                      return None, None, None
> >> @@ -171,7 +173,8 @@ class LayerIndexPlugin(ActionPlugin):
> >>                  subdir, name, layerdir = self.get_fetch_layer(fetchdir,
> >>                                                        layerBranch.layer.vcs_url,
> >>                                                        layerBranch.vcs_subdir,
> >> -                                                      not args.show_only)
> >> +                                                      not args.show_only,
> >> +                                                      args.branch)
> >
> > The above should be 'layerBranch.actual_branch', instead of args.branch.
> >
> > For example, in master -- "meta-gumstix" in master is set to the branch 'dora'.
> >
> > --Mark
> >
> >>                  if not name:
> >>                      # Error already shown
> >>                      return 1
> >>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

