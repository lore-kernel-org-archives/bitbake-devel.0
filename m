Return-Path: <raj.khem@gmail.com>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
	[209.85.192.51])
	by mail.openembedded.org (Postfix) with ESMTP id 7A8BB65C5C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 11:05:31 +0000 (UTC)
Received: by mail-qg0-f51.google.com with SMTP id y89so92669209qge.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Mar 2016 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=L5bVIW0LNmsMf6wdHHHgJ6ZkkoWvMtqGDc/e1etlrRw=;
	b=fRVYEum+1DfIPzA//cIyk+CpiCGubjNrAIUA2MFFK5kIoA2FtFfNaxCoPhtwgKZe80
	BWQWIuG78mQ5i+LQNMtHgTCiM+qkbGoWDuwPCj70HdhK8m55u5hot0Kh0Pv1o/PbgomX
	A8x2GLfbwb/jIuZkU+veRkTc47Ek3uKzMexLG5iOLzuMBQ6yyhsv3K3Tc38WzsLF3UTZ
	nG/OrQbl0scLAndP8CTw33O0N2Hor5xeiBK15PqB0f/4JvvZHrGU8iNgoUV0ekYFGwGm
	1Le3dP3iKCLPv08+Ul0jCi50mQdc1hEErgA0TDPMop7PwHA284OlHPL6DFpVR7o1RDZw
	7GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=L5bVIW0LNmsMf6wdHHHgJ6ZkkoWvMtqGDc/e1etlrRw=;
	b=HaJAMoAmiDxdz/vplWzy454fZAPKfWxz+UG4x9KDapwnjSDjVtMxj7E2DvVm1QoY0z
	y3XZAeR1hVA3I/bCla6gb095Vu4C0GCeV2an2ah5AIpeTTTcTn+z1voUS39CiGxlXwta
	PbL3frW9qiaeMhpd2PAHV96LKN08y8qQkZTNpzFPTn1jjV5SFtPNqAobJu4umPuKyzTg
	C3wCYJgLlv34DDWPpPA3Wt20sTTjLX9Y8qUZAP/KDXW8PC7EAZ+OPn3SjrdTmp66r+wD
	jjOYtMniQO28CZodO2hkhLI+DhDJxNmQ2Ph6xQJ7jAMciuLCs3Jrtu3jbhwLg9IKOKG9
	c4Zg==
X-Gm-Message-State: AD7BkJJ7qgLYT/wpsK9OuqjkDFypth04hMfh0zSb8I43XXGciiCghLQlOfAO/qn36qyt9mriP/SqIo+swDbUlA==
MIME-Version: 1.0
X-Received: by 10.140.104.234 with SMTP id a97mr27291021qgf.57.1457348732125; 
	Mon, 07 Mar 2016 03:05:32 -0800 (PST)
Received: by 10.55.130.196 with HTTP; Mon, 7 Mar 2016 03:05:31 -0800 (PST)
Received: by 10.55.130.196 with HTTP; Mon, 7 Mar 2016 03:05:31 -0800 (PST)
In-Reply-To: <09856974BCEE6F48AB378E52E4CAA73C226D7C15@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
References: <09856974BCEE6F48AB378E52E4CAA73C226D79DD@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
	<56DD45D3.5030506@mlbassoc.com>
	<09856974BCEE6F48AB378E52E4CAA73C226D7C15@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
Date: Mon, 7 Mar 2016 18:05:31 +0700
Message-ID: <CAMKF1spOi8RbduxxwJHtUx_Xv69YO9nX7kr3fWBd4haMsL8OGQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
To: Praveenreddy Padamati <praveenreddy.p@hcl.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Gary Thomas <gary@mlbassoc.com>
Subject: Re: chromium browser
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
X-List-Received-Date: Mon, 07 Mar 2016 11:05:33 -0000
Content-Type: multipart/alternative; boundary=001a11352ee27e1029052d737130

--001a11352ee27e1029052d737130
Content-Type: text/plain; charset=UTF-8

What is your build machine configuration and look at log.do_cpmpile it
might have some info
On Mar 7, 2016 5:57 PM, "Praveenreddy Padamati" <praveenreddy.p@hcl.com>
wrote:

> Hi,
>
> Thanks for the reply. It took more than 24 hours and then we stopped it.
>
> Thanks
> Praveen Reddy P
>
> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] On Behalf Of Gary Thomas
> Sent: Monday, March 07, 2016 2:42 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] chromium browser
>
> On 2016-03-07 09:30, Praveenreddy Padamati wrote:
> > Hi,
> >
> > When I added chromium browser in yocto build configuration then bitbake
> is stucking at do compile. Can you please help me?
> >
>
> How long have you waited?  Depending on your target and host/build
> settings, building chromium can take a LONG time (measured in hours)
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
> ::DISCLAIMER::
>
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
> The contents of this e-mail and any attachment(s) are confidential and
> intended for the named recipient(s) only.
> E-mail transmission is not guaranteed to be secure or error-free as
> information could be intercepted, corrupted,
> lost, destroyed, arrive late or incomplete, or may contain viruses in
> transmission. The e mail and its contents
> (with or without referred errors) shall therefore not attach any liability
> on the originator or HCL or its affiliates.
> Views or opinions, if any, presented in this email are solely those of the
> author and may not necessarily reflect the
> views or opinions of HCL or its affiliates. Any form of reproduction,
> dissemination, copying, disclosure, modification,
> distribution and / or publication of this message without the prior
> written consent of authorized representative of
> HCL is strictly prohibited. If you have received this email in error
> please delete it and notify the sender immediately.
> Before opening any email and/or attachments, please check them for viruses
> and other defects.
>
>
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a11352ee27e1029052d737130
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">What is your build machine configuration and look at log.do_=
cpmpile it might have some info</p>
<div class=3D"gmail_quote">On Mar 7, 2016 5:57 PM, &quot;Praveenreddy Padam=
ati&quot; &lt;<a href=3D"mailto:praveenreddy.p@hcl.com">praveenreddy.p@hcl.=
com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">H=
i,<br>
<br>
Thanks for the reply. It took more than 24 hours and then we stopped it.<br=
>
<br>
Thanks<br>
Praveen Reddy P<br>
<br>
-----Original Message-----<br>
From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org">bitba=
ke-devel-bounces@lists.openembedded.org</a> [mailto:<a href=3D"mailto:bitba=
ke-devel-bounces@lists.openembedded.org">bitbake-devel-bounces@lists.openem=
bedded.org</a>] On Behalf Of Gary Thomas<br>
Sent: Monday, March 07, 2016 2:42 PM<br>
To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@l=
ists.openembedded.org</a><br>
Subject: Re: [bitbake-devel] chromium browser<br>
<br>
On 2016-03-07 09:30, Praveenreddy Padamati wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; When I added chromium browser in yocto build configuration then bitbak=
e is stucking at do compile. Can you please help me?<br>
&gt;<br>
<br>
How long have you waited?=C2=A0 Depending on your target and host/build set=
tings, building chromium can take a LONG time (measured in hours)<br>
<br>
--<br>
------------------------------------------------------------<br>
Gary Thomas=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 Consulting for the<br>
MLB Associates=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 Embedded world<br>
------------------------------------------------------------<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
<br>
<br>
::DISCLAIMER::<br>
---------------------------------------------------------------------------=
-------------------------------------------------------------------------<b=
r>
<br>
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.<br>
E-mail transmission is not guaranteed to be secure or error-free as informa=
tion could be intercepted, corrupted,<br>
lost, destroyed, arrive late or incomplete, or may contain viruses in trans=
mission. The e mail and its contents<br>
(with or without referred errors) shall therefore not attach any liability =
on the originator or HCL or its affiliates.<br>
Views or opinions, if any, presented in this email are solely those of the =
author and may not necessarily reflect the<br>
views or opinions of HCL or its affiliates. Any form of reproduction, disse=
mination, copying, disclosure, modification,<br>
distribution and / or publication of this message without the prior written=
 consent of authorized representative of<br>
HCL is strictly prohibited. If you have received this email in error please=
 delete it and notify the sender immediately.<br>
Before opening any email and/or attachments, please check them for viruses =
and other defects.<br>
<br>
---------------------------------------------------------------------------=
-------------------------------------------------------------------------<b=
r>
<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--001a11352ee27e1029052d737130--
