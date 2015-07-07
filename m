Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A3ABB75D18
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 15:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67FHwIZ011914; Tue, 7 Jul 2015 16:17:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Vbi4tEeBy0FJ; Tue,  7 Jul 2015 16:17:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67FHgQY011910
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 7 Jul 2015 16:17:54 +0100
Message-ID: <1436282262.27597.183.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 07 Jul 2015 16:17:42 +0100
In-Reply-To: <fc82e0723a4877cdcd92e97cd2cf19f4a5d0ff70.1436232786.git.liezhi.yang@windriver.com>
References: <cover.1436232786.git.liezhi.yang@windriver.com>
	<fc82e0723a4877cdcd92e97cd2cf19f4a5d0ff70.1436232786.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] git.py: create a branch when checkout
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
X-List-Received-Date: Tue, 07 Jul 2015 15:18:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-07-06 at 18:33 -0700, Robert Yang wrote:
> Create a branch named oebuild_SRCREV when checkout the source, this
> makes debug easier than "(no branch)" when look into the source.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 2e53882..12087dd 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -280,7 +280,8 @@ class Git(FetchMethod):
>                  runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d)
>                  runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d)
>              else:
> -                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d)
> +                runfetchcmd("%s checkout %s -b oebuild_%s" % (ud.basecmd, \
> +                            ud.revisions[ud.names[0]], ud.revisions[ud.names[0]]), d)
>          return True

Would it not make more sense to set the branch to the upstream branch
name here?

Cheers,

Richard
 



