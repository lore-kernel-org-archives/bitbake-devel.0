Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id 433D06AC00
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 08:44:29 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id l13so208960567itl.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Tx3fWTLKTt0kv6ulwHFgurZB4Beo09HJuv7daEx6W+8=;
	b=LT1S3gKOGnVITFX0YV+Kv1JND01yfE+HhMl2VN7nC0ETyG4qMd67ge12H4aIQvOHZR
	DMSVdabT/sJH9RBCb+4xJlR6XwGeAGoNyOfDqynRLrB0sjbvSr2IAIXuttGxuV6T8f/r
	VPcHzw7/ZOL1+XrLmpufxfBYcTJaVNAPAM8TW55/rjOhEG/RPPVVL/kWXSIGga3lmMMu
	mZ5r9IthBPv+5/cAs5VHzT8Km1Ieu1Um7HVyUWF9ypx+ZBM9c/7AkvBBkTnDOjDFTwwP
	vLkP59nW5F4qH+zr8yo1fkv9Mk5Qwm1lvbIQQwwXQP0yPcr9ZTDTl7vIWsWFQQNo7BP5
	5ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Tx3fWTLKTt0kv6ulwHFgurZB4Beo09HJuv7daEx6W+8=;
	b=U5O9FjViCZ0D1SYeya3oFdSlDzcPF57M0G0Sa8VGSgkbxyE2RTgnh9NSsyO+CJe07r
	46hTXtQXZkAhud/iOtS6rb40fyPDqwVml8GPc0yCLtWWT8PUreBNW/7rwEfWI6RoYDop
	N8L7s25+NKoHD56rigkSj0lZbf8PnfKR1g2QVIhi/p5sTA3Poxi+NkFC0k+rbviZwq0W
	9Ez6XkZouOkjQCkmqaHnehwxRWmkvirS2zqh9dxKD5E1y8mc9F6YM9qiZhEUCRyzNSYl
	mhFn0LDaKvndd7RMpiymUiLBXkss91mVap8fuW48RgAkMhGM/k4ajhlUJPH3UEWfWvG0
	oCpg==
X-Gm-Message-State: AA6/9RmLjhOe9N73FIWUdSqh8IFwDSPmDLidLTdWyahQOvZ/uSA57P/Exbnd29YTwvDeUE3OUoToI5YSOby6cHTi
X-Received: by 10.36.181.78 with SMTP id j14mr11631612iti.20.1476434670562;
	Fri, 14 Oct 2016 01:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.66 with HTTP; Fri, 14 Oct 2016 01:44:10 -0700 (PDT)
In-Reply-To: <CABh+foZJcLBTQLLVU8a3axbOF+f+Die6ws15U-9B4s3L0PySFA@mail.gmail.com>
References: <CABh+foZtU_KQ0+2WUC0J=oef-EcbKHH60Fc+yDqGtW79Jc7tBQ@mail.gmail.com>
	<CAJTo0Lb2Wh9Godxx2tDOGxbpm3OjMzdnvmv_=Rt2N7z0vvqN2w@mail.gmail.com>
	<CABh+foZJcLBTQLLVU8a3axbOF+f+Die6ws15U-9B4s3L0PySFA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 14 Oct 2016 09:44:10 +0100
Message-ID: <CAJTo0LaTgfjUqczysmNyJowfZ8WTPP-bOaPXkDJw3hWP47FF_Q@mail.gmail.com>
To: nitish jha <nitishjha16@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: changing content of configuration parameters of Cmakelist file from .bb file
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
X-List-Received-Date: Fri, 14 Oct 2016 08:44:30 -0000
Content-Type: multipart/alternative; boundary=f403045d9aaa12c2e2053ecf3c3d

--f403045d9aaa12c2e2053ecf3c3d
Content-Type: text/plain; charset=UTF-8

On 13 October 2016 at 12:57, nitish jha <nitishjha16@gmail.com> wrote:

> I want to assign value to a variable in my recipe file by using awk command
>
>
> do_configure_prepend() {
>
> var_lib = awk -F '/'  '{$2}'  '${libdir}'
> }
>
>
> #EXTRA_OECMAKE += "-DEF_INSTALL_CMAKE_DIR:PATH=${var_lib}/cmake/vsomeip"
>
> EXTRA_OECMAKE += "-DINSTALL_LIB_DIR:PATH=${var_lib}"
>
> EXTRA_OECMAKE += "-DINSTALL_CMAKE_DIR:PATH=${var_lib}/cmake/vsomeip"
>
>
>
>
> *here libdir = /usr/lib64.*
>
> But when I compile it give me error while running command in do_configure
> append
>
> Do I need to inherit anything to run shell command through recipes.
>

If you didn't used $var_lib instead of ${var_lib} (as bitbake only expands
${foo}, $var_lib will exist when the shell runs) then this will work.
However, this isn't pretty.  Just use ${baselib}, the name of the final
directory in ${libdir}, which is presumably what you want.

Ross

--f403045d9aaa12c2e2053ecf3c3d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 13 October 2016 at 12:57, nitish jha <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:nitishjha16@gmail.com" target=3D"_blank">nitishjha16@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div>I want to assign valu=
e to a variable in my recipe file by using awk command</div><div><br></div>=
<div><div><br></div><div>do_configure_prepend() {</div><div><br></div><div>=
<span class=3D"m_-9091723846335891928gmail-Apple-tab-span" style=3D"white-s=
pace:pre-wrap">	</span>var_lib =3D awk -F &#39;/&#39; =C2=A0&#39;{$2}&#39; =
=C2=A0&#39;${libdir}&#39;</div><div>}</div><div><br></div><div><br></div><d=
iv>#EXTRA_OECMAKE +=3D &quot;-DEF_INSTALL_CMAKE_DIR:PATH=3D$<wbr>{var_lib}/=
cmake/vsomeip&quot;</div><div><br></div><div>EXTRA_OECMAKE +=3D &quot;-DINS=
TALL_LIB_DIR:PATH=3D${var_<wbr>lib}&quot;</div><div><br></div><div>EXTRA_OE=
CMAKE +=3D &quot;-DINSTALL_CMAKE_DIR:PATH=3D${<wbr>var_lib}/cmake/vsomeip&q=
uot;</div><div><br></div><div><br></div></div><div><br></div><div><br></div=
><div><b>here libdir =3D /usr/lib64.</b></div><div><br></div><div>But when =
I compile it give me error while running command in do_configure append</di=
v><div><br></div><div>Do I need to inherit anything to run shell command th=
rough recipes.</div></blockquote></div><br></div><div class=3D"gmail_extra"=
>If you didn&#39;t used $var_lib instead of ${var_lib} (as bitbake only exp=
ands ${foo}, $var_lib will exist when the shell runs) then this will work.=
=C2=A0 However, this isn&#39;t pretty.=C2=A0 Just use ${baselib}, the name =
of the final directory in ${libdir}, which is presumably what you want.=C2=
=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ro=
ss</div></div>

--f403045d9aaa12c2e2053ecf3c3d--
