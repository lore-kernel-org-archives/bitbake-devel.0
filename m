Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 149536011A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 22:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CMtOxg006798; Thu, 12 May 2016 23:55:24 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QRiEdfivEP19; Thu, 12 May 2016 23:55:23 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CMtKmi006795
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 May 2016 23:55:21 +0100
Message-ID: <1463093720.9746.57.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Humberto Ibarra <humberto.ibarra.lopez@intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 23:55:20 +0100
In-Reply-To: <1463080671-27074-1-git-send-email-humberto.ibarra.lopez@intel.com>
References: <1463080671-27074-1-git-send-email-humberto.ibarra.lopez@intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH v3] bitbake/lib/bb/cookerdata.py: Improve response when bitbake-layers can't find layer conf file
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
X-List-Received-Date: Thu, 12 May 2016 22:55:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-05-12 at 14:17 -0500, Humberto Ibarra wrote:
> If an invalid layer is added to bblayers.conf, the parsing of said
> file
> ends with a trace and an "Unable to parse" exception. This is not the
> ideal output, especially considering that we know exactly why this is
> failing.
> 
> This patch handles this situation failing with a graceful error
> message. The
> message shows the path to the conf file that couldn't be found.
> 
> [Yocto #9506]
> 
> Signed-off-by: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/cookerdata.py
> b/bitbake/lib/bb/cookerdata.py
> index 50259a9..a1b0457 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -178,9 +178,13 @@ def catch_parse_error(func):
>          try:
>              return func(fn, *args)
>          except IOError as exc:
> -            import traceback
> -            parselog.critical(traceback.format_exc())
> -            parselog.critical("Unable to parse %s: %s" % (fn, exc))
> +            import errno
> +            if exc.errno == errno.ENOENT:
> +                parselog.critical("Unable to find the configuration
> file: %s" % fn)
> +            else:
> +                import traceback
> +                parselog.critical(traceback.format_exc())
> +                parselog.critical("Unable to parse %s: %s" % (fn,
> exc))
>              sys.exit(1)
>          except bb.data_smart.ExpansionError as exc:
>              import traceback

I think I'm not going to take this patch. My concern is that we have a
number of places where we'd have this problem and adding in specific
exception handling in all of them is going to be tricky.

I do agree we need to solve the problem and started to wonder if we
could make the standard exception more useful. I then realised that in
python3, they already did. If I try this under python3, I see:

FileNotFoundError: [Errno 2] file /foo/bar/conf/layer.conf not found

ERROR: Unable to parse /foo/bar/conf/layer.conf: [Errno 2] file /foo/bar/conf/layer.conf not found

So with python3, we get better exceptions for free with no code changes.

Can we therefore say this will be fixed with the move to python3? 

It would be good to double check as I just tested this with bitbake and
bitbake-layers hasn't been ported to python3 yet but I'd imagine its
the same.

Cheers,

Richard



