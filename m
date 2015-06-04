Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 1628273BBE
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 18:11:51 +0000 (UTC)
Received: by oiww2 with SMTP id w2so37326786oiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Jun 2015 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=fxvgyyP85gQjTPaPfqCnH0J2s66gZFNOFphvdmv+gxc=;
	b=H7ZAvKDn8TyVKzY+mg1LoU4A/ME0cWDPzq29Bjhui1SsqepbeyTeMsHfnaCm0dl/q/
	923lRrO9MV2cQSsUqxjCBq5nHfMvMCe5or/NUFAvwkB0BRujP/zSYODdpwN99aO21bJn
	kwQoOdPltRaTZv7+TZV3a4HtRjYe7/neBAom/+jzwOphNr9GWWRzf0uCeHMWcqgk1Yb/
	0xFy4nXH0qW+TsZwtWlmZktS4zT3DKWr18RpIiv6qVXKfaSam2I65IGQEfw/IIhSE4h8
	ehNUI9JuZsZya4YAhQD4XnCMMLc1BIz4os3aDiq2tZmoyWuRk1yRh3sfUSZg51qb4tA0
	jP3A==
X-Received: by 10.182.220.199 with SMTP id py7mr11369520obc.60.1433441512951; 
	Thu, 04 Jun 2015 11:11:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Thu, 4 Jun 2015 11:11:32 -0700 (PDT)
In-Reply-To: <CAJTo0La_T6oP7n6TuDUS4v5u=L59-=WSiAg4wuw+j37z9uLFTA@mail.gmail.com>
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
	<CADL-HDh=p-=YvT-xw-EuCVKOux9+k3RtpN93LznaQ=5mT3=opA@mail.gmail.com>
	<CAJTo0La_T6oP7n6TuDUS4v5u=L59-=WSiAg4wuw+j37z9uLFTA@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Thu, 4 Jun 2015 23:41:32 +0530
Message-ID: <CADL-HDiKpEuye3vYDB+GV2irAHD2oJHek2x6bEg=FWdKXy38nA@mail.gmail.com>
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
X-List-Received-Date: Thu, 04 Jun 2015 18:11:54 -0000
Content-Type: multipart/alternative; boundary=001a11c334aa2f96780517b51c98

--001a11c334aa2f96780517b51c98
Content-Type: text/plain; charset=UTF-8

Hi,

I searched all the packages in my repo and I have observed that all those
packages which inherit autotools have "libdir" set to /lib and others have
libdir set to "/usr/lib" in Makefile.

Thanks,
Yogesh

On Thu, Jun 4, 2015 at 8:12 PM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 4 June 2015 at 15:15, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
>
>> I have not overridden any variable but when I printed "libdir" in
>> Makefile, it's value is "/lib" . This should be the reason why my libs were
>> not getting installed to /usr/lib/gstreamer-0.10. But why this is
>> happening? As per bitbake documentation  "libdir" should be /usr/lib and I
>> also confirmed this by
>>
>> bitbake -e|grep libdir
>>
>
> If bitbake thinks its /usr/lib then your configure or makefile is
> overriding it.
>
> Ross
>

--001a11c334aa2f96780517b51c98
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I searched all the packages in my r=
epo and I have observed that all those packages which inherit autotools hav=
e &quot;libdir&quot; set to /lib and others have libdir set to &quot;/usr/l=
ib&quot; in Makefile.</div><div><br></div><div>Thanks,</div><div>Yogesh</di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, J=
un 4, 2015 at 8:12 PM, Burton, Ross <span dir=3D"ltr">&lt;<a href=3D"mailto=
:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D=
"gmail_extra"><span class=3D""><br><div class=3D"gmail_quote">On 4 June 201=
5 at 15:15, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit=
2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div>I have not overridden any vari=
able but when I printed &quot;libdir&quot; in Makefile, it&#39;s value is &=
quot;/lib&quot; . This should be the reason why my libs were not getting in=
stalled to /usr/lib/gstreamer-0.10. But why this is happening? As per bitba=
ke documentation =C2=A0&quot;libdir&quot; should be /usr/lib and I also con=
firmed this by</div><div><br></div><div>bitbake -e|grep libdir</div></block=
quote></div><br></span>If bitbake thinks its /usr/lib then your configure o=
r makefile is overriding it.</div><span class=3D"HOEnZb"><font color=3D"#88=
8888"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross<=
/div></font></span></div>
</blockquote></div><br></div>

--001a11c334aa2f96780517b51c98--
