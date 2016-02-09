Return-Path: <avery.brian@gmail.com>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 97C906FF9F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 20:33:48 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id l127so22077075iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Feb 2016 12:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=8zb7245QVoSY4GqbjOcYSe3iuf3S+NV5FGvNdcZ3Th4=;
	b=JwJTczn5AL2BZnjwJtJKPiU4o6SRTkyLI8Gj5EhQ2DyaKxJtBCFVcrQvXk4cYzXZUN
	gShVIgs/InIPBdQuR5ja0xH/wmRAlPMUMfAdr8to9++ZvRceBGifyHeN2zn0J37BKfHC
	IoHx4Pmvrmgv/dHOk7pbjfC3yusOioW2y1HiMr5HT5nW4/HaxI5qZYHL/u7uh7fQRAAm
	O+vINwLM0buyiTACM00CsY0mgYMUWOg/bn+vEBTi1CbPIwz3u2hLgAXCPH3mY6ISjigg
	LxewXYOW9KjM58z7uozHK9Q9lZE9J56E5L3DcFLVOaN5lrF9fFeFvCgcrlKpqgjuSslo
	KqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=8zb7245QVoSY4GqbjOcYSe3iuf3S+NV5FGvNdcZ3Th4=;
	b=fdtJ9pOzDvVqzLAAHC9LAuL7l3siRlYVE5cpXzJRjGrEbthFaT6QWFVau/6njsz+MW
	YSYkp7MWaWn/DNX5IzziNelToZacBNWJ+tc6sXm1takli0XSFNdk1Djy7fMzBfcUQMiJ
	eIQ40g8dPYWCjNqU0xK1qfMBQCHUz260RCdHGeMFLHaH39nj8YBEypYJQlSnnpYoetef
	pUZizV13BF8wWxaex2LhC5hxB1P+0LzDMEDqk0fvULP1/5IQRyPo2LhHYplh4N2vD1yv
	64jtre+2++T36EfRJ/EngQ415xm55jsFXlgHv76q/EaSnyHcutdMpL5iza3HvU+myshV
	53Rw==
X-Gm-Message-State: AG10YORTLEVv7Ru+UsmuTRv3hHNjvozxF7pCpyuHnWWUcJoTKPGyjJsLmta2Uc2W482UrOknVi0T0SQcqKMB/A==
MIME-Version: 1.0
X-Received: by 10.107.46.11 with SMTP id i11mr39139000ioo.67.1455050029868;
	Tue, 09 Feb 2016 12:33:49 -0800 (PST)
Received: by 10.107.164.73 with HTTP; Tue, 9 Feb 2016 12:33:49 -0800 (PST)
In-Reply-To: <1449828119-23489-1-git-send-email-elliot.smith@intel.com>
References: <1449828119-23489-1-git-send-email-elliot.smith@intel.com>
Date: Tue, 9 Feb 2016 12:33:49 -0800
Message-ID: <CAKV_0ei6-uSkVqLf3pc4T8f5y-cZLiBDD5jv61AUHc_Y5kveRA@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: Mihail Stanciu <stanciux.mihail@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: tests Remove symlinks from toasteruitest folder
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
X-List-Received-Date: Tue, 09 Feb 2016 20:33:50 -0000
Content-Type: text/plain; charset=UTF-8

bump.
This seems to have neither made it in to master nor gotten any comments...
-bavery


On Fri, Dec 11, 2015 at 2:01 AM, Elliot Smith <elliot.smith@intel.com> wrote:
> From: Mihail Stanciu <stanciux.mihail@intel.com>
>
> Remove symlinks in the UI tests folder as they are causing
> problems for bitbake upstream.
>
> [YOCTO #8787]
>
> Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite   | 1 -
>  bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json | 1 -
>  2 files changed, 2 deletions(-)
>  delete mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
>  delete mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
>
> diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
> deleted file mode 120000
> index 656b8e8..0000000
> --- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../../../../../toaster.sqlite
> \ No newline at end of file
> diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json b/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
> deleted file mode 120000
> index 9b33bcc..0000000
> --- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../../../../../meta-yocto/conf/toasterconf.json
> \ No newline at end of file
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
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

