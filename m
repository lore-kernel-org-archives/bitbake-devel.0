Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail.openembedded.org (Postfix) with ESMTP id 580DD73BBE
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 14:15:55 +0000 (UTC)
Received: by oiww2 with SMTP id w2so32208770oiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Jun 2015 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=qG5tv1Zg/GbjmVnOxW09/6neU7QPWwkuZpiZVarvc28=;
	b=EnwUXDkKRv8WsWenDOOZw5I0Lc5wL4g5fMcvjZXyLXVdwrsM2lAD/rllZN1FJ+vSjl
	+y1FYNnreH/9hjTyYNeQh3/UtonaEOEqBayJMtwDyRbcGaOiUIKHGjRQ+1weZqJ23KK1
	/4u6/ycnBTnu6CfkC/PjqEX7V4reKD1Ha477hR4P8HbJD/QivDX63iuC4oOH94/tdU77
	6EJC87V2t/Oza1Axo1rmNlzGktaAhpV7fns4HA5tVHEDA6z1ofY1iRZZg5fT+5ImnKup
	ZbqJ7EmOSf/C1+l6J1GIAtjh3HsZfLtzJSl5gRsBndmnxkkZE6i/jhWnafynOngr3I8f
	gSjw==
X-Received: by 10.182.220.199 with SMTP id py7mr10407372obc.60.1433427356543; 
	Thu, 04 Jun 2015 07:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Thu, 4 Jun 2015 07:15:36 -0700 (PDT)
In-Reply-To: <CAJTo0LbTnQQmj-KsmncAsnE-kcuZxKTH-mwHMC_=HwPCV6JCgQ@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
	<CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
	<B8A83673-75A0-4880-97BE-1712A4093058@gmail.com>
	<CAJTo0LbTnQQmj-KsmncAsnE-kcuZxKTH-mwHMC_=HwPCV6JCgQ@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Thu, 4 Jun 2015 19:45:36 +0530
Message-ID: <CADL-HDh=p-=YvT-xw-EuCVKOux9+k3RtpN93LznaQ=5mT3=opA@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Thu, 04 Jun 2015 14:15:58 -0000
Content-Type: multipart/alternative; boundary=001a11c334aa65f4700517b1d0cc

--001a11c334aa65f4700517b1d0cc
Content-Type: text/plain; charset=UTF-8

Hi,

I have not overridden any variable but when I printed "libdir" in Makefile,
it's value is "/lib" . This should be the reason why my libs were not
getting installed to /usr/lib/gstreamer-0.10. But why this is happening? As
per bitbake documentation  "libdir" should be /usr/lib and I also confirmed
this by

bitbake -e|grep libdir

How come it is changes in Makefile.

Thanks,
Yogesh

On Thu, Jun 4, 2015 at 3:21 PM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 4 June 2015 at 07:25, Khem Raj <raj.khem@gmail.com> wrote:
>
>> you will then hit the .so not being symlink QA errors
>
>
> dev-so is "symlink .so isn't in a -dev package", there's isn't a check for
> ".so isn't a symlink" as that would trigger for every plugin.
>
> Ross
>

--001a11c334aa65f4700517b1d0cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have not overridden any variable =
but when I printed &quot;libdir&quot; in Makefile, it&#39;s value is &quot;=
/lib&quot; . This should be the reason why my libs were not getting install=
ed to /usr/lib/gstreamer-0.10. But why this is happening? As per bitbake do=
cumentation =C2=A0&quot;libdir&quot; should be /usr/lib and I also confirme=
d this by</div><div><br></div><div>bitbake -e|grep libdir</div><div><br></d=
iv><div>How come it is changes in Makefile.</div><div><br></div><div>Thanks=
,</div><div>Yogesh</div></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Thu, Jun 4, 2015 at 3:21 PM, Burton, Ross <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton=
@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><span class=3D""><br><div class=3D"gmai=
l_quote">On 4 June 2015 at 07:25, Khem Raj <span dir=3D"ltr">&lt;<a href=3D=
"mailto:raj.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">you will then hit the .so not=
 being symlink QA errors</blockquote></div><br></span>dev-so is &quot;symli=
nk .so isn&#39;t in a -dev package&quot;, there&#39;s isn&#39;t a check for=
 &quot;.so isn&#39;t a symlink&quot; as that would trigger for every plugin=
.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">Ross</div></font></span></div>
</blockquote></div><br></div>

--001a11c334aa65f4700517b1d0cc--
