Return-Path: <daiane.list@gmail.com>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
	[209.85.217.172])
	by mail.openembedded.org (Postfix) with ESMTP id 46CD360745
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 11:55:30 +0000 (UTC)
Received: by mail-lb0-f172.google.com with SMTP id bc4so156711911lbc.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Jan 2016 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=DOYIEomHHFXY/7ErewsS7eY+DpAJzIJ3gZu6Ez5my3Q=;
	b=DA+LRvk6s306b95CPs2t1TBfxe4Q+V6VOZlzHF4jgEErBNepuY0+Z62CHgTDdgcCnm
	fwBpeImLfw/Adi1vSMLL1ydGOAvcHiUlOA0cpZiY+oJCmn6Ewj77iwtWJlPJROs85bZm
	UC3tK1qIFIeHaXUTcIfebYn0waqt/mhP/wh1KsDlialPtMT/vOef/HxtPOAFwqSZ0Zjn
	BWMOvQBoINDEXOzWT2qX7QaP9DYimk4LfFzElKJ+XM0ZyHLzdeaY7C1bJPQxD27qelWS
	4qtZzgxLzvVRtfbfSFD1cTfU3wE8UxsNBF7zAsf59S6gZdvTBdiXvcZ8REaHU6zAPYKc
	y0Hw==
MIME-Version: 1.0
X-Received: by 10.112.12.233 with SMTP id b9mr22877533lbc.63.1451908530828;
	Mon, 04 Jan 2016 03:55:30 -0800 (PST)
Sender: angolini@gmail.com
X-Google-Sender-Delegation: angolini@gmail.com
Received: by 10.114.160.71 with HTTP; Mon, 4 Jan 2016 03:55:30 -0800 (PST)
In-Reply-To: <SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10@SN2PR0801MB0798.namprd08.prod.outlook.com>
References: <SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10@SN2PR0801MB0798.namprd08.prod.outlook.com>
Date: Mon, 4 Jan 2016 09:55:30 -0200
X-Google-Sender-Auth: qw1NuGT6ToxRZfH2UC18OgCreJg
Message-ID: <CA+jg_OU9-jhsn_HxytVeSGejxVe3b0RzEJNdcsPHiWkMUZkLDg@mail.gmail.com>
From: Daiane Angolini <daiane.list@gmail.com>
To: "Moore, Calvin" <c1moore@ufl.edu>
X-Mailman-Approved-At: Tue, 05 Jan 2016 14:12:33 +0000
Cc: "meta-freescale@yoctoproject.org" <meta-freescale@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [meta-freescale] FlexCAN on Freescale iMX6Q SoC
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
X-List-Received-Date: Mon, 04 Jan 2016 11:55:33 -0000
Content-Type: text/plain; charset=UTF-8

On Sun, Jan 3, 2016 at 6:00 PM, Moore, Calvin <c1moore@ufl.edu> wrote:
> Hello,
>
>
> I am trying to install the FlexCAN driver on a Freescale iMX6Q SoC using the
> Yocto project (version 1.5) provided on the VIA Technologies website at
> http://www.viatech.com/en/systems/industrial-fanless-pcs/amos-820/.  I have
> contacted Freescale, but they have been unable to assist me actually install
> the driver.  They did tell me that I would have to build a completely new
> image for the system, though
> (https://community.freescale.com/message/600561?et=watches.email.thread#600561).
> I assume this would require editing the BitBake recipe, but I am unsure how
> to properly install a driver with BitBake.  Can anybody give me some
> guidance to install FlexCAN properly?

I would probably start using only kernel source code and testing it
with any available rootfs.

When defconfig is defined, I would only update this file on metadata.

And absolutely I would not use 1.5 as we are 2.0 now.

Daiane
>
>
> Thanks,
>
> Calvin
>
>
> --
> _______________________________________________
> meta-freescale mailing list
> meta-freescale@yoctoproject.org
> https://lists.yoctoproject.org/listinfo/meta-freescale
>

