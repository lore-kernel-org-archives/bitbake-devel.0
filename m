Return-Path: <alexandru.damian@intel.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
	[209.85.213.174])
	by mail.openembedded.org (Postfix) with ESMTP id 07446607BB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 May 2015 10:39:46 +0000 (UTC)
Received: by igbpi8 with SMTP id pi8so102241391igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 May 2015 03:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=z1gOfxe7E4Zu1qAskWSyjDI7ts8PWTGFltUgdVyVa8Y=;
	b=KqJ7vGIdHaold0LwlxnBkdB+ingzCp/x1Yy0KqBJMXThd4KSbsJV2zPPaLVAPeurNA
	YB1/7fIRlyxb/dWyTiPW/WtYLB8mtXNUWgE4KMn5yUewBjCuRJGhpnz5FkjGS/2o7ok8
	uXCAPMLGYqjmS2kAhOlUzS7zSFoq7hsinzLWJ6hdNehvbRI0MlFy6sY842pnTO+hmyTx
	MfWPZLNJhQO6YOIHHo0Go33XA4qiHm388bNmFqp+KCLRTw4MwDGRDKg39pZJaeY+PWAo
	dWPtkPcYHo2qKfEpUl+ozyDjI8Hk0FBUQLrxgzoAmtBCh6GXgNrcUIIZNge/BUhCgZSw
	NpKg==
X-Gm-Message-State: ALoCoQmO5r3mqIKfmMkTSI0hboVSpifXT2gKcyhJXuBIfikJfVoMA1sTHik2uqIY7W6WRntKQEht
X-Received: by 10.107.129.133 with SMTP id l5mr712361ioi.32.1432031987067;
	Tue, 19 May 2015 03:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.10.67 with HTTP; Tue, 19 May 2015 03:39:26 -0700 (PDT)
In-Reply-To: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
References: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Tue, 19 May 2015 11:39:26 +0100
Message-ID: <CAJ2CSBthQefQEgNQrxLXfyUBnWersXyLq4nhmUknW2g7jgzc5w@mail.gmail.com>
To: Randy Witt <randy.e.witt@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/2] Remove Toaster dependency on daemon
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
X-List-Received-Date: Tue, 19 May 2015 10:39:47 -0000
Content-Type: multipart/alternative; boundary=001a113fc306e5873805166cede1

--001a113fc306e5873805166cede1
Content-Type: text/plain; charset=UTF-8

Randy, thanks for the patches. They work fine !

Can you please add toaster@yoctoproject.org in CC for future patches ?

Cheers,
Alex

On Mon, May 18, 2015 at 11:06 PM, Randy Witt <randy.e.witt@linux.intel.com>
wrote:

> The following changes since commit
> bc162d21dd148252efcf3ed771e04c791ef4d869:
>
>   bitbake: tests/parse: Add file missing from previous commit (2015-05-16
> 22:40:44 +0100)
>
> are available in the git repository at:
>
>   git@git.yoctoproject.org:poky-contrib rewitt/toaster
>
> for you to fetch changes up to e5e8d341edd28007eac22381e336f8362d784530:
>
>   toaster: Remove dependency on daemon application (2015-05-18 15:01:42
> -0700)
>
> ----------------------------------------------------------------
> Randy Witt (2):
>       localhostbecontroller: Fix server search debug message
>       toaster: Remove dependency on daemon application
>
>  bitbake/bin/toaster                                 |  5 -----
>  .../lib/toaster/bldcontrol/localhostbecontroller.py | 21
> ++++++++++++++-------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--001a113fc306e5873805166cede1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Randy, thanks for the patches. They work fine !</div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Can you plea=
se add <a href=3D"mailto:toaster@yoctoproject.org">toaster@yoctoproject.org=
</a> in CC for future patches ?</div><div class=3D"gmail_default" style=3D"=
font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:tahoma,sans-serif">Cheers,</div><div class=3D"gmail_default=
" style=3D"font-family:tahoma,sans-serif">Alex</div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Mon, May 18, 2015 at 11:06 PM, =
Randy Witt <span dir=3D"ltr">&lt;<a href=3D"mailto:randy.e.witt@linux.intel=
.com" target=3D"_blank">randy.e.witt@linux.intel.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">The following changes since commit bc162d=
21dd148252efcf3ed771e04c791ef4d869:<br>
<br>
=C2=A0 bitbake: tests/parse: Add file missing from previous commit (2015-05=
-16 22:40:44 +0100)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git@git.yoctoproject.org:poky-contrib rewitt/toaster<br>
<br>
for you to fetch changes up to e5e8d341edd28007eac22381e336f8362d784530:<br=
>
<br>
=C2=A0 toaster: Remove dependency on daemon application (2015-05-18 15:01:4=
2 -0700)<br>
<br>
----------------------------------------------------------------<br>
Randy Witt (2):<br>
=C2=A0 =C2=A0 =C2=A0 localhostbecontroller: Fix server search debug message=
<br>
=C2=A0 =C2=A0 =C2=A0 toaster: Remove dependency on daemon application<br>
<br>
=C2=A0bitbake/bin/toaster=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 -----<br>
=C2=A0.../lib/toaster/bldcontrol/localhostbecontroller.py | 21 ++++++++++++=
++-------<br>
=C2=A02 files changed, 14 insertions(+), 12 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Pro=
ject<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--001a113fc306e5873805166cede1--
