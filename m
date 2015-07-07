Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E3B2875D13
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 23:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67NCIum004408; Wed, 8 Jul 2015 00:12:18 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RHFFbtZjPCYs; Wed,  8 Jul 2015 00:12:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67NC5n6004403
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 00:12:17 +0100
Message-ID: <1436310725.27597.200.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>
Date: Wed, 08 Jul 2015 00:12:05 +0100
In-Reply-To: <1435956027-26996-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435956027-26996-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] cooker.py: Close lock file and watcher fds when end.
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
X-List-Received-Date: Tue, 07 Jul 2015 23:12:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2015-07-03 at 15:40 -0500, Aníbal Limón wrote:
> When run cooker inside loop it reaches OS max fd's causing
> an exception.
> 
> Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
> ---
>  lib/bb/cooker.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index f31bca6..abe8a52 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1432,6 +1432,9 @@ class BBCooker:
>          if self.state in (state.shutdown, state.forceshutdown, state.error):
>              if hasattr(self.parser, 'shutdown'):
>                  self.parser.shutdown(clean=False, force = True)
> +            self.configwatcher.close()
> +            self.watcher.close()
> +            self.lock.close()
>              raise bb.BBHandledException()
>  
>          if self.state != state.parsing:

Burying this cleanup into the updateCache function seems wrong. The
updateCache call as you use it in tinfoil highlights how odd that is.

We really need a better shutdown mechanism of cooker. It'll be more
invasive to the codebase but better in the long run I think...

Cheers,

Richard


