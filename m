Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 0FB8771996
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jun 2017 21:10:24 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id s66so4636403pfs.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jun 2017 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=H5PoMj5rxuCTaOAkxb9x7ggA1lOUWRH7brOXo/iX/vQ=;
	b=ZRfK36UL/SWNFQMq0O7YRhlpuaKSr+cfOvLcIemr1sxrW7kOG/HLjUrgKOVYnPCTOk
	0SQK5P7kXt5MoP8jPc5YTYsdBRwToz1WyQnX+UId2u2r/fZ2no1/i4GcwHWQoavn6v9Q
	/JgzlUHneN/STVaIdkZr+Hfo+uW0I7J8AAqEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=H5PoMj5rxuCTaOAkxb9x7ggA1lOUWRH7brOXo/iX/vQ=;
	b=NEbjtd4V9sUTvuVZUIv4QU1VhyHGCl4kRa51DFhref250/052UblR/RI3lcEUoGTU4
	LdS83RqRoaBMumCRBeReEpbZsdkAJBaqc2syaOsovUT1sH3riu+OH5haoT0crKMuI6dl
	DKYU0vZzfFtQ25nCPmUqpdSoadWYbJi1KLgkl8GCzYQQjKWLY1fPUDCK9bEWfgxf4Zku
	R4lJ+XUMQPjZ4IOsCuB5V5HG2xdbn6jWSIAzDWhRBIVHumNHxwC+b5S+tGJo6T0NR4IL
	ytXJINqG/PEeiBb15H+f4bRT11rc9hr4mNnpkbzA9dM2crkPjYo7gpKO1Z8qVizgjRF2
	hlnA==
X-Gm-Message-State: AKS2vOxXc2rAo9Muxhf3X+yPCQDkJhJ9qP4rXe2QtVyoMpOLITzNS88M
	ogFamjwnBJkFuXLkP7Y0d4p2unrvv/NQ
X-Received: by 10.84.195.129 with SMTP id j1mr5180830pld.191.1498165826231;
	Thu, 22 Jun 2017 14:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.130.73 with HTTP; Thu, 22 Jun 2017 14:10:05 -0700 (PDT)
In-Reply-To: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Thu, 22 Jun 2017 16:10:05 -0500
Message-ID: <CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Make calc_taskhash match get_taskhash for file checksums
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
X-List-Received-Date: Thu, 22 Jun 2017 21:10:25 -0000
Content-Type: text/plain; charset="UTF-8"

Seeing this issue on some older (err, really olderrrr) versions of
bitbake. How far back could we backport?

-M

On Fri, Jun 2, 2017 at 8:02 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> The code in these two functions is meant to be equivlanet in behaviour
> but isn't. Add in code to ensure files that don't exist are handled
> consistently by both functions. Users did report being able to generate
> tracebacks otherwise.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/siggen.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 169756e..f71190a 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -667,7 +667,8 @@ def calc_taskhash(sigdata):
>          data = data + sigdata['runtaskhashes'][dep]
>
>      for c in sigdata['file_checksum_values']:
> -        data = data + c[1]
> +        if c[1]:
> +            data = data + c[1]
>
>      if 'taint' in sigdata:
>          if 'nostamp:' in sigdata['taint']:
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

