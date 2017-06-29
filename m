Return-Path: <garbados@gmail.com>
Received: from mail-pg0-f43.google.com (mail-pg0-f43.google.com [74.125.83.43])
	by mail.openembedded.org (Postfix) with ESMTP id BDCDA71A71
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jun 2017 17:46:50 +0000 (UTC)
Received: by mail-pg0-f43.google.com with SMTP id u62so51278401pgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jun 2017 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Mx7BXoy/qDQCQ5ZJHiBd0gAWoSD6IBx9rdOlA3L6Ek8=;
	b=ta1mBY9CexVz7k8isq6doOh2aHtbkLwkziIwcWvfpC6v1FAyb618IRZZ28APO6Eilm
	gEmoxhXbN3oZTSWbII4FXcHEIdM19MYzCzUip7Cl1BEKuEVgEq4I33jmf1+i69lq4ZJB
	2D2Ljkr4a5LPMXhgFO9c1b4NZpoWnNO6Je61B8DH26mWxSKN+QKy/8Os1DYeDsY04GWE
	7cTTxLkb5QHw1evQHMU/MWAF1Kj+jsCIH3sK6vNxokphRzF3Ow4vNoGAruxW+odFX1D4
	08oqcltnBPPgm6fyZ8d6PFH0afK1eUnL2O2E0l10BluWUMqjN/+qafZHpQJ0M+vi67Cx
	Ghiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Mx7BXoy/qDQCQ5ZJHiBd0gAWoSD6IBx9rdOlA3L6Ek8=;
	b=mX+GGcbQ6Lua8/KVCznVtdX9VmSFasgXu+ZAw55fLD9WzLSOmREIhP7AMohBz7l4DR
	sAOKNEt5hY5I7Yw0fwM0xNIQEpTv92Ts6LVYK7umfYIMVmLOB9XIedQ3jxOFdUtM8oIn
	Fwc2KextxatMXg/eQ0uh3DQ1uVbcun083b9CKFXimcP4iHnATeT0JUcOM8cO1X2/szMR
	uwCxyMbe0eqOelV4uvOFofGqwbVbtiQt14jSrTx3JHFtJpN/8i2tqNWjBzplGjwXfFZ5
	PjnphYndDva4DnmDnLaVyfE8l4NSDaze8w4WRz5HYscdwgFPtrdRKNZejurQBVbT8YF5
	50Rg==
X-Gm-Message-State: AKS2vOw6wz5SdWgIRxlvX25hseOT0aQt7nU2r0ylOwz++nWzYMIoFtJC
	VOM1VGnGPC54ExGDRKG5iBzUcpXI5w==
X-Received: by 10.84.224.74 with SMTP id a10mr19238049plt.210.1498758411455;
	Thu, 29 Jun 2017 10:46:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.225 with HTTP; Thu, 29 Jun 2017 10:46:11 -0700 (PDT)
In-Reply-To: <20170629022411.57685-1-rob.woolley@windriver.com>
References: <20170629022411.57685-1-rob.woolley@windriver.com>
From: Diana Thayer <garbados@gmail.com>
Date: Thu, 29 Jun 2017 10:46:11 -0700
Message-ID: <CA++8a_B9RJ_HOXcAEXFn3CfC2a8rO9ScKr1z1Kwh+=wuAsvvPw@mail.gmail.com>
To: Rob Woolley <rob.woolley@windriver.com>
Cc: paul.eggleton@linux.intel.com,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 0/1] Automatically paginate bitbake -e output
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
X-List-Received-Date: Thu, 29 Jun 2017 17:46:53 -0000
Content-Type: multipart/alternative; boundary="f40304373814b810c105531ce280"

--f40304373814b810c105531ce280
Content-Type: text/plain; charset="UTF-8"

Given the change in behavior, should we also include changes to the
documentation for the affected flags?

On Wed, Jun 28, 2017 at 7:24 PM, Rob Woolley <rob.woolley@windriver.com>
wrote:

> The bitbake show_versions (-s) and show_environment (-e) commands provide
> a lot of non-interactive output.  Even experienced users will sometimes
> forget to page the output.
>
> This enhancement adds a feature to automatically page these commands when
> using the knotty user interface.  It doesn't affect any other commands
> and is designed to work in a similar fashion to the auto-paging in git.
>
> This was tested with bitbake -s and bitbake -s | less (and -e) to ensure
> that
> there were no regressions.  This includes testing broken pipe conditions
> caused by quitting the pager before the full output has been sent through
> the pipe.
>
> This is an update of my previous patch from February 2015 and adds support
> for Python 3 and utf-8.
>
> PATCH v1: https://patchwork.openembedded.org/patch/89543/
> YOCTO #9203: https://bugzilla.yoctoproject.org/show_bug.cgi?id=9203
>

--f40304373814b810c105531ce280
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Given the change in behavior, should we also include =
changes to the documentation for the affected flags?<br></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jun 28, 2017 at =
7:24 PM, Rob Woolley <span dir=3D"ltr">&lt;<a href=3D"mailto:rob.woolley@wi=
ndriver.com" target=3D"_blank">rob.woolley@windriver.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">The bitbake show_versions (-s) and sh=
ow_environment (-e) commands provide<br>
a lot of non-interactive output.=C2=A0 Even experienced users will sometime=
s<br>
forget to page the output.<br>
<br>
This enhancement adds a feature to automatically page these commands when<b=
r>
using the knotty user interface.=C2=A0 It doesn&#39;t affect any other comm=
ands<br>
and is designed to work in a similar fashion to the auto-paging in git.<br>
<br>
This was tested with bitbake -s and bitbake -s | less (and -e) to ensure th=
at<br>
there were no regressions.=C2=A0 This includes testing broken pipe conditio=
ns<br>
caused by quitting the pager before the full output has been sent through<b=
r>
the pipe.<br>
<br>
This is an update of my previous patch from February 2015 and adds support<=
br>
for Python 3 and utf-8.<br>
<br>
PATCH v1: <a href=3D"https://patchwork.openembedded.org/patch/89543/" rel=
=3D"noreferrer" target=3D"_blank">https://patchwork.<wbr>openembedded.org/p=
atch/89543/</a><br>
YOCTO #9203: <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=
=3D9203" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject=
.<wbr>org/show_bug.cgi?id=3D9203</a><br>
</blockquote></div><br></div>

--f40304373814b810c105531ce280--
