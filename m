Return-Path: <pascal.bach@siemens.com>
X-Greylist: delayed 684 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 20 Sep 2016 07:02:35 UTC
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
	by mail.openembedded.org (Postfix) with ESMTP id C882B6074F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 07:02:35 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id u8K6pA05015599
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Tue, 20 Sep 2016 08:51:10 +0200
Received: from [139.16.76.169] (MD1FZU9C.ww002.siemens.net [139.16.76.169])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTPS id u8K6pAWs025775
	(version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Sep 2016 08:51:10 +0200
To: Christopher Larson <clarson@kergoth.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
	<CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
	<508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
	<CABcZANn4D8Qog6ukM_7XM65ZY+OymnmD2K8DeipxoVOOaY1FcA@mail.gmail.com>
From: Pascal Bach <pascal.bach@siemens.com>
Message-ID: <64d81891-801e-292e-e26c-1c44bd38a8c5@siemens.com>
Date: Tue, 20 Sep 2016 08:51:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABcZANn4D8Qog6ukM_7XM65ZY+OymnmD2K8DeipxoVOOaY1FcA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Tue, 20 Sep 2016 07:02:36 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 19.09.2016 17:10, Christopher Larson wrote:
>
> On Mon, Sep 19, 2016 at 12:22 AM, Pascal Bach <pascal.bach@siemens.com <mailto:pascal.bach@siemens.com>> wrote:
>
>     On 16.09.2016 18:20, Christopher Larson wrote:
>
>     >
>     > On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach <pascal.bach@siemens.com <mailto:pascal.bach@siemens.com> <mailto:pascal.bach@siemens.com <mailto:pascal.bach@siemens.com>>> wrote:
>     >
>     >     When an update of the local copy is required always try to fetch the update
>     >     from a premirror first.
>     >     The premirror should always have precedence over the upstream repository
>     >     as updating from there might not work if BB_FETCH_PREMIRRORONLY,
>     >     BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.
>     >
>     >     This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.
>     >
>     >     Signed-off-by: Pascal Bach <pascal.bach@siemens.com <mailto:pascal.bach@siemens.com> <mailto:pascal.bach@siemens.com <mailto:pascal.bach@siemens.com>>>
>     >     ---
>     >      lib/bb/fetch2/git.py | 9 ++-------
>     >      1 file changed, 2 insertions(+), 7 deletions(-)
>     >
>     >     diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>     >     index 1bec60a..cac2a87 100644
>     >     --- a/lib/bb/fetch2/git.py
>     >     +++ b/lib/bb/fetch2/git.py
>     >     @@ -227,13 +227,8 @@ class Git(FetchMethod):
>     >              return False
>     >
>     >          def try_premirror(self, ud, d):
>     >     -        # If we don't do this, updating an existing checkout with only premirrors
>     >     -        # is not possible
>     >     -        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
>     >     -            return True
>     >     -        if os.path.exists(ud.clonedir):
>     >     -            return False
>     >     -        return True
>     >     +        # Always try premirror if an update is required
>     >     +        return self.need_update(ud, d)
>     >
>     >
>     > Will this result in fetching a mirror tarball even if you already have a clone in ud.clonedir? The previous logic always returned False if the clonedir existed..
>     The tarball should only be fetched if the local ud.clonedir is out of date, this means the revision that is requested via SRCREV is not in the local repository.
>     In the case the revision is present the tarball should not be fetched again, at least that was the intention and my local tests didn't indicate otherwise.
>
>
> Yes, but it’s better to run ‘git fetch’ in an out of date clone than to re-download a 1gb mirror tarball which may well be out of date too.
Agreed, but this doesn't work in the case where the machine doesn't have access to the upstream git repository. For example in the case where BB_ALLOWED_NETWORKS = "*.my.company". The fetcher would still got to to github.com which is not allowed, in that case it should fall back to fetch the tarball from "mirror.my.company".

I'm open for suggestions how to make this more efficient.

Pascal

