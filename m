Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C68CE72A85
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 16:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGm9vA003430; Tue, 28 Apr 2015 17:48:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c67ENnHwkqJr; Tue, 28 Apr 2015 17:48:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGlsFp003406
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Apr 2015 17:48:05 +0100
Message-ID: <1430239674.13022.241.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mariano Lopez <mariano.lopez@linux.intel.com>
Date: Tue, 28 Apr 2015 17:47:54 +0100
In-Reply-To: <553E60F0.5050908@linux.intel.com>
References: <553E60F0.5050908@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2/git: Allow HEAD to be searched.
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
X-List-Received-Date: Tue, 28 Apr 2015 16:48:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-04-27 at 11:16 -0500, Mariano Lopez wrote:
> This makes it possble to fetch/search HEAD. This is useful when 
> searching for HEAD doing the sanity check.
> 
> Please disregard previous patch with the same topic.
> 
> [YOCTO #7592]
> 
> Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 0d91431..12fb6a2 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -345,6 +345,9 @@ class Git(FetchMethod):
>           if ud.unresolvedrev[name][:5] == "refs/":
>               head = ud.unresolvedrev[name]
>               tag = ud.unresolvedrev[name]
> +        elif ud.unresolvedrev[name] == "HEAD":
> +            head = ud.unresolvedrev[name]
> +            tag = ud.unresolvedrev[name]
>           else:
>               head = "refs/heads/%s" % ud.unresolvedrev[name]
>               tag = "refs/tags/%s" % ud.unresolvedrev[name]

Looking at the bug, I think the example in poky.conf needs fixing not to
use HEAD rather than this patch.

I'd also mention that you could do:

if ud.unresolvedrev[name][:5] == "refs/" or  ud.unresolvedrev[name] == "HEAD":

rather than duplicate code. The whitespace in this patch is also broken.

Cheers,

Richard


