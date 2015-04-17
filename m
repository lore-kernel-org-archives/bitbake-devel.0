Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C16EC73D58
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 10:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3HAVofB004261; Fri, 17 Apr 2015 11:31:50 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MX6JknAuBn_Z; Fri, 17 Apr 2015 11:31:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3HAVa9I004253
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Apr 2015 11:31:47 +0100
Message-ID: <1429266695.6976.194.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Date: Fri, 17 Apr 2015 11:31:35 +0100
In-Reply-To: <1429029770-15462-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1429029770-15462-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: invalidate mtime cache if file doesn't exist
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
X-List-Received-Date: Fri, 17 Apr 2015 10:31:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-04-14 at 19:42 +0300, Ed Bartosh wrote:
> Mtime cache is desinged with assumption that files are not
> removed. Unfortunately it's not always the case for memory-resident
> bitbake as build/tmp can be removed to perform build from scratch.
> In this case bitbake crashes when trying to create timestamps if
> tmp/stamps/ hierarchy doesn't exist.
> 
> Simple check of file existance should solve this issue.
> 
> [YOCTO: #7562]
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/parse/__init__.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
> index 25effc2..e880732 100644
> --- a/bitbake/lib/bb/parse/__init__.py
> +++ b/bitbake/lib/bb/parse/__init__.py
> @@ -62,6 +62,8 @@ def cached_mtime(f):
>      return __mtime_cache[f]
>  
>  def cached_mtime_noerror(f):
> +    if not os.path.exists(f):
> +        return 0
>      if f not in __mtime_cache:
>          try:
>              __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]

I don't think this is right. The whole idea of this cache is so we don't
repeatedly hit stat() syscalls and by adding in the exists() check, the
cache is made worthless and I suspect we'd see a bad performance change.

Most of the use of this cache is from cooker/cache.py and there, we use
inotify to refresh the cache if something in the filesystem changes. We
probably need to teach the other users of this cache about the need to
deal with inotify (or simply remove any stamp data from the cache
entirely at the start of each bitbake invocation).

Cheers,

Richard




