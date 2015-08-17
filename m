Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7766065CBC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 07:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7jk8p023831; Mon, 17 Aug 2015 08:46:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xfnMoNDfzRsA; Mon, 17 Aug 2015 08:46:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7kSNd023862
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2015 08:46:40 +0100
Message-ID: <1439797588.1218.37.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 17 Aug 2015 08:46:28 +0100
In-Reply-To: <629f01246969a76254c26d5e614ebef5c1ed4270.1439449677.git.liezhi.yang@windriver.com>
References: <cover.1439449677.git.liezhi.yang@windriver.com>
	<629f01246969a76254c26d5e614ebef5c1ed4270.1439449677.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetch2/git.py: fix _latest_revision for local PREMIRROR
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
X-List-Received-Date: Mon, 17 Aug 2015 07:46:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-08-13 at 00:08 -0700, Robert Yang wrote:
> - Fixed when SRCREV = "${AUTOREV}", and set BB_NO_NETWORK = "1":
> $ bitbake <recipe> -ccleanall
> | DEBUG: Executing python function do_cleanall
> | DEBUG: Python function do_cleanall finished
> | ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...
> 
> - Fixed when SRCREV = "${AUTOREV}", set BB_NO_NETWORK = "1"  and use
>   local PREMIRROR:
> $ bitbake <recipe> -cfetchall
> | DEBUG: Python function do_fetch finished
> | ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...
> 
> Stop running "git ls-remote" when BB_NO_NETWORK would fix the problem.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 374d846..67ee107 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -350,7 +350,6 @@ class Git(FetchMethod):
>          """
>          Compute the HEAD revision for the url
>          """
> -        output = self._lsremote(ud, d, "")
>          # Tags of the form ^{} may not work, need to fallback to other form
>          if ud.unresolvedrev[name][:5] == "refs/":
>              head = ud.unresolvedrev[name]
> @@ -358,6 +357,12 @@ class Git(FetchMethod):
>          else:
>              head = "refs/heads/%s" % ud.unresolvedrev[name]
>              tag = "refs/tags/%s" % ud.unresolvedrev[name]
> +        # Only ls-remote when url is "file://" or BB_NO_NETWORK != "1",
> +        # this makes local mirror works.
> +        if ud.proto.lower() == 'file' or d.getVar("BB_NO_NETWORK", True) != "1":
> +            output = self._lsremote(ud, d, "")
> +        else:
> +            output = "%s %s" % (name, head)
>          for s in [head, tag + "^{}", tag]:
>              for l in output.split('\n'):
>                  if s in l:

The idea is that when BB_NO_NETWORK is set, network accesses show
errors. This would stop that happening in all cases and lead to silent
failures which would be bad for user experience.

So no, this isn't an acceptable way to fix this, sorry.

Cheers,

Richard









