Return-Path: <pascal.bach@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id 6F57770016
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 07:22:41 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id u8J7Ma8b014476
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Mon, 19 Sep 2016 09:22:36 +0200
Received: from [139.16.76.169] (MD1FZU9C.ww002.siemens.net [139.16.76.169])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTPS id u8J7MZ87007115
	(version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2016 09:22:35 +0200
To: Christopher Larson <clarson@kergoth.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
	<CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
From: Pascal Bach <pascal.bach@siemens.com>
Message-ID: <508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
Date: Mon, 19 Sep 2016 09:22:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
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
X-List-Received-Date: Mon, 19 Sep 2016 07:22:43 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 16.09.2016 18:20, Christopher Larson wrote:

>
> On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach <pascal.bach@siemens.com <mailto:pascal.bach@siemens.com>> wrote:
>
>     When an update of the local copy is required always try to fetch the update
>     from a premirror first.
>     The premirror should always have precedence over the upstream repository
>     as updating from there might not work if BB_FETCH_PREMIRRORONLY,
>     BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.
>
>     This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.
>
>     Signed-off-by: Pascal Bach <pascal.bach@siemens.com <mailto:pascal.bach@siemens.com>>
>     ---
>      lib/bb/fetch2/git.py | 9 ++-------
>      1 file changed, 2 insertions(+), 7 deletions(-)
>
>     diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>     index 1bec60a..cac2a87 100644
>     --- a/lib/bb/fetch2/git.py
>     +++ b/lib/bb/fetch2/git.py
>     @@ -227,13 +227,8 @@ class Git(FetchMethod):
>              return False
>
>          def try_premirror(self, ud, d):
>     -        # If we don't do this, updating an existing checkout with only premirrors
>     -        # is not possible
>     -        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
>     -            return True
>     -        if os.path.exists(ud.clonedir):
>     -            return False
>     -        return True
>     +        # Always try premirror if an update is required
>     +        return self.need_update(ud, d)
>
>
> Will this result in fetching a mirror tarball even if you already have a clone in ud.clonedir? The previous logic always returned False if the clonedir existed..
The tarball should only be fetched if the local ud.clonedir is out of date, this means the revision that is requested via SRCREV is not in the local repository.
In the case the revision is present the tarball should not be fetched again, at least that was the intention and my local tests didn't indicate otherwise.

Without this change the git fetcher would directly fall back to do a git fetch from the original source, which doesn't work if the build machine doesn't have access to the internet.


