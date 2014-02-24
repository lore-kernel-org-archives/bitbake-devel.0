Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
	[209.85.214.181])
	by mail.openembedded.org (Postfix) with ESMTP id 416996BB41
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 07:34:29 +0000 (UTC)
Received: by mail-ob0-f181.google.com with SMTP id wp4so4624155obc.26
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2014 23:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:content-transfer-encoding;
	bh=pS14G781sdw+WCzvO1IJm8ZO2wsQ33uvmvlEA1+P0Sc=;
	b=WV3f3SZG+xiyLtOHptFBCxpSouon7vjwFe4Hemow8XONNUUfUn/MCUmRBVm9ffyeJS
	oehhdq18rGnRgFK8YptrZnYSnOiESvlAwu2X6X3mRSPzPgVBJ8bd5t/FzW+6/SHPWx/X
	bnBcMcduUaKJJYWMGR2hcBgTqNf5zzZ1gyTRawJ0SW1eVRdjWwSR1fQC+ce3uOBOjeyr
	IjKOfXF6mmyktLDvnDzfxN0up9KDpN1BDRNtSszkmieErks2oMwreztN6vtXFdTKgydb
	6T0dMMnMTROMA+palT2n27ANvLvuGfp66ahz9Kck8B7HqU02ZzfhHXKxhWhHvOXtponH
	FF2A==
X-Gm-Message-State: ALoCoQmB9sJkNHrTCDd5H3f3p+vN/1wlLaujJBgzaMxsP+GM4iPVjKF1YujwCaQ1hC3WaW5OAP5S
X-Received: by 10.60.62.199 with SMTP id a7mr19642226oes.64.1393227270359;
	Sun, 23 Feb 2014 23:34:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.182.99 with HTTP; Sun, 23 Feb 2014 23:34:10 -0800 (PST)
In-Reply-To: <CAC7Dm8+3uyPxwUiUxYbRnw0_+gZsN+0L6hEq7Wsv3GksctH6Ew@mail.gmail.com>
References: <CAC7Dm8+3uyPxwUiUxYbRnw0_+gZsN+0L6hEq7Wsv3GksctH6Ew@mail.gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Mon, 24 Feb 2014 08:34:10 +0100
Message-ID: <CAP71Wjy3QXvznrcOj88RvrdZQL0NemFSNDw_9zijhazemY8NNA@mail.gmail.com>
To: =?KOI8-R?B?5M3J1NLJyiDvws/U1dLP1w==?= <oboturoff@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake -c cleanall <target>
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
X-List-Received-Date: Mon, 24 Feb 2014 07:34:33 -0000
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2014 at 2:18 PM, =E4=CD=C9=D4=D2=C9=CA =EF=C2=CF=D4=D5=D2=
=CF=D7 <oboturoff@gmail.com> wrote:
>
> sorry for my stupid question. i am beginner in bitbake.
>
> How I can correct delete all images from folder:
> /build_p5040ds_release/tmp/deploy/images
>
> in yocto system.
>
> i know a command:
>  bitbake -c cleanall <target>
>
> but i am not understand, what this <target>?
>
> i try to use:
> bitbake -c cleanall e5500
> bitbake -c cleanall fsl-networking
> bitbake -c cleanall ppc
> bitbake -c cleanall fsl*
> bitbake -c cleanall fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.g=
z
> bitbake -c cleanall linux
>
> they are not working.... and I have always error:
> ERROR: Nothing PROVIDES ....

first of all, it's not the right mailing list for such questions. you
should use openemebedded-core or yocto list.

<target> is a recipe name.

bitbake -c <task> <target> will complete the <task> for <target>, as
well as as dependent tasks. "cleanall" will in turn run the 'make
clean' command in your WORKDIR, clean up the sstate folder for
<target>, and remove any files downloaded by <target> from DOWNLOADS
folder. but it won't clean up tmp/deploy/images, you need to
manage/cleanup this folder yourself.

