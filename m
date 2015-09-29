Return-Path: <avery.brian@gmail.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id A2EB076F9D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 05:29:19 +0000 (UTC)
Received: by iofh134 with SMTP id h134so199577403iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=eN0ICqMtWzX+G+pMVSfVGqpLPcy3JSCuLKdd6mAOHHI=;
	b=RRIJx3gD4PtPxnHAl0sqlqs4hikz55qO/HUa0zkPjlGZRmbgAMaCrSc3n1N8ek+Hcc
	l4Vl03DjnXtn5jAeXmtTQ4Xhy+JEkooNY8RnPIn1VC0Cm189rTsNEgUko5ZwHDhYG7Qw
	9vzMLtV8rnGS8CYkTeU4F5tUqJlTzyFWBry2lTGCTsQmr2THK8aUlTcp7SYsEd+tvYXU
	QSzXRc18UW26r7SZsiXG0/kf/2pZnOk6wTRDvm8FNfTkJl45FwwDBaM7Qpat58zXIhIb
	9/n9xflMvdiODOk3BfeGSatqAS3+L4vQ08qfZJuD7yR/l+DGGQoFUDlpEr5PfPBvo6O9
	p8Lw==
MIME-Version: 1.0
X-Received: by 10.107.32.80 with SMTP id g77mr23584773iog.14.1443504559297;
	Mon, 28 Sep 2015 22:29:19 -0700 (PDT)
Received: by 10.64.155.36 with HTTP; Mon, 28 Sep 2015 22:29:19 -0700 (PDT)
In-Reply-To: <92bef2c338fd79ad607f25b8062e8c71eef2a31e.1443090607.git.elliot.smith@intel.com>
References: <cover.1443090607.git.elliot.smith@intel.com>
	<92bef2c338fd79ad607f25b8062e8c71eef2a31e.1443090607.git.elliot.smith@intel.com>
Date: Mon, 28 Sep 2015 22:29:19 -0700
Message-ID: <CAKV_0egbpt2H7P5xHvO48yV3tAtxpKMgR=LJ02p0_j5YkTEzzQ@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] toaster: small improvements to the startup script
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
X-List-Received-Date: Tue, 29 Sep 2015 05:29:19 -0000
Content-Type: text/plain; charset=UTF-8

this patch contains a typo. I'll resubmit.
-b

On Thu, Sep 24, 2015 at 3:31 AM, Elliot Smith <elliot.smith@intel.com> wrote:
> From: brian avery <avery.brian@gmail.com>
>
> Do not ask the user to create a superuser on running in managed mode
>
> Correctly inherit the env variable WEB_PORT if set in analysis mode
>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bin/toaster | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/bin/toaster b/bin/toaster
> index ac27826..2153282 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -54,11 +54,9 @@ webserverStartAll()
>      fi
>
>      retval=0
> -    if [ "$TOASTER_MANAGED" '=' '1' ]; then
> -        python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
> -    else
> -        python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
> -    fi
> +    # you can always add a superuser later via
> +    # python bitbake/lib/toaster/manage.py python manage.py createsuperuser --username=<ME>
> +    python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
>      python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
>      if [ $retval -eq 1 ]; then
>          echo "Failed db sync, stopping system start" 1>&2
> @@ -163,7 +161,9 @@ RUNNING=0
>  NOTOASTERUI=0
>  WEBSERVER=1
>  TOASTER_BRBE=""
> -WEB_PORT="8000"
> +if [ "WEB_PORT" == "" ]; then
> +    WEB_PORT="8000"
> +fi
>  NOBROWSER=0
>
>  for param in $*; do
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

