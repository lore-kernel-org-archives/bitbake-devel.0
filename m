Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8xO-0004pq-4F for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 12:38:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAS852011256;
	Wed, 23 May 2012 11:28:08 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10563-07; Wed, 23 May 2012 11:28:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAS0X5011250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 11:28:01 +0100
Message-ID: <1337768879.8248.57.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Wed, 23 May 2012 11:27:59 +0100
In-Reply-To: <1337527217-5550-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1337527217-5550-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] parse: get_file_depends(): return deterministic result
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 May 2012 10:38:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-05-20 at 17:20 +0200, Enrico Scholz wrote:
> The output of get_file_depends() concatenates elements of a set.  Result
> of this operation is not deterministic because it is calculated by
> parallel running parsing threads.
> 
> Because result of get_file_depends() is stored into BBINCLUDED which
> goes in into various hash calculations, this can cause unwanted rebuilds
> of cache or recipes.
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/parse/__init__.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
> index 7b9c47e..1e69778 100644
> --- a/lib/bb/parse/__init__.py
> +++ b/lib/bb/parse/__init__.py
> @@ -138,6 +138,6 @@ def get_file_depends(d):
>      depends = depends.union(d.getVar('__base_depends', True) or set())
>      for (fn, _) in depends:
>          dep_files.append(os.path.abspath(fn))
> -    return " ".join(dep_files)
> +    return " ".join(sorted(dep_files))
>  
>  from bb.parse.parse_py import __version__, ConfHandler, BBHandler

I've commented before on this list about the problems in this variable.
We need to fix this problem so the list is both correctly ordered and
that the order is maintained.

I'm therefore reluctant to take this patch and would like one that fixes
all the issues properly once and for all.

Cheers,

Richard




