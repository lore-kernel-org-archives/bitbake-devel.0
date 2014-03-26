Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id ED1B46F993
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 10:05:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QA5Ahb007338; Wed, 26 Mar 2014 10:05:11 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id M8oPE-ofWn01; Wed, 26 Mar 2014 10:05:10 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QA55fn007335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Mar 2014 10:05:07 GMT
Message-ID: <1395828299.24890.85.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 26 Mar 2014 10:04:59 +0000
In-Reply-To: <6d78004e5ccfd737bac24e5346d079aab11df2e7.1395802560.git.liezhi.yang@windriver.com>
References: <cover.1395802560.git.liezhi.yang@windriver.com>
	<6d78004e5ccfd737bac24e5346d079aab11df2e7.1395802560.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Wed, 26 Mar 2014 10:05:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-03-26 at 05:27 -0400, Robert Yang wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> When specifying tags, they're searched for unanchored so foo/bar could
> match:
> 
> refs/heads/abc/foo/bar
> refs/heads/xyz/foo/bar
> refs/heads/foo/bar
> 
> This change anchors the expressions so they are based against heads
> or tags (or any other base level tree that has been created).
> 
> (Bitbake master rev: df2e0972cd1db7abd5ec8b7cb295fb0c42e284a4)
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> Conflicts:
> 	bitbake/lib/bb/fetch2/git.py
> 	(ud.basecmd and basecmd conflicts, keep using basecmd)
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 6175e4c..cff5ce1 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -305,8 +305,8 @@ class Git(FetchMethod):
>              username = ""
>  
>          basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
> -        cmd = "%s ls-remote %s://%s%s%s %s" % \
> -              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
> +        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
> +              (basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])

Shouldn't this be ud.branches[name] for dora?

Cheers,

Richard


