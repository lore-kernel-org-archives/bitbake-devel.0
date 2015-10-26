Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1B92960657
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Oct 2015 16:05:55 +0000 (UTC)
Received: by igbhv6 with SMTP id hv6so59710317igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Oct 2015 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=wnzp1td+FAWiEuSI5dLQTrpowrf1ZqeR+w38K2/sdXE=;
	b=rlu953NGGiO1IO0I5IsDWA3DqmAdG6tirupk/BWll5/KWzpHuUsMCKR02jgrB9ZLBK
	Zh/Kdhpgd+INJZ+mT9rkNpIZVA0kOpLw+tf4KWrQB3kVIKNHsKyka7OHGgwBwDv4QTxt
	CBvnjx8NmeQ24EH675I4FlXONi2N/kt3JGN4XUsyE677lOjITOusDH18+C5uaLWyqLdn
	blnJ/EJvBGBVF02+R8Z/1wjM5293/+0Ik8NlhYUa4Rk76DeY6ZcK/6Xs1jrXRqMJ7677
	L+4OZeA1wJ6L8FRxnt4aJ9zl3gRzBx4Fmn3KdJZmxGpkxnwcO+WSYwCv//psRqCod/pX
	rctA==
MIME-Version: 1.0
X-Received: by 10.50.27.9 with SMTP id p9mr19463972igg.28.1445875555415; Mon,
	26 Oct 2015 09:05:55 -0700 (PDT)
Received: by 10.64.221.74 with HTTP; Mon, 26 Oct 2015 09:05:55 -0700 (PDT)
In-Reply-To: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
References: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
Date: Mon, 26 Oct 2015 09:05:55 -0700
Message-ID: <CAKV_0egMyNQ2bzbO+gydU+vDsc_xwGgKgwmh9YW8vynVhShQ8Q@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: Point to meta/conf for default toasterconf.json
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
X-List-Received-Date: Mon, 26 Oct 2015 16:06:00 -0000
Content-Type: text/plain; charset=UTF-8

True,

but then builds for poky would fail :(

How about something like (posted from gmail so just for discussion not
to be used!!):

if [ "$TOASTER_CONF" = "" ]; then

-    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"

+    if [ -e "$(dirname
$TOASTER)/../../meta-yocto/conf/toasterconf.json" ] ; then

+       TOASTER_CONF="$(dirname
$TOASTER)/../../meta-yocto/conf/toasterconf.json"

+    elif [ -e "$(dirname $TOASTER)/../../meta/conf/toasterconf.json" ] ; then

+       TOASTER_CONF="$(dirname $TOASTER)/../../meta/conf/toasterconf.json"

+    fi

     export TOASTER_CONF=$(python -c "import os; print
os.path.realpath('$TOASTER_CONF')")

 fi

-b

On Sat, Oct 24, 2015 at 2:56 PM, Khem Raj <raj.khem@gmail.com> wrote:
> meta-yocto may not exist in nodistro env
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  bin/toaster | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/toaster b/bin/toaster
> index 2c3432c..c1a01f0 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -196,7 +196,7 @@ fi
>  # in the local layers that currently prevent using an arbitrary
>  # toasterconf.json
>  if [ "$TOASTER_CONF" = "" ]; then
> -    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
> +    TOASTER_CONF="$(dirname $TOASTER)/../../meta/conf/toasterconf.json"
>      export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
>  fi
>  if [ ! -f $TOASTER_CONF ]; then
> --
> 2.6.2
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

