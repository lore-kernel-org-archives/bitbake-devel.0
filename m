Return-Path: <raj.khem@gmail.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id CD09277CE0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Jul 2017 00:26:05 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id e131so25767146wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nem0jPDIlnYvvO28sdjxeOMZuo/j/RK64yuRGFxbJo4=;
	b=pjNGKUR8Ib0sMz7bKxD6XIbdj1wvzzig1wWFctAne7dhko5ugVC82sPsWKJ5eOu8FS
	7IYFLNU3iJFkPky9qH6rQzPbwE/Qt1pJfGP6CodVCjO9CET3pVqn+f+515HZJGQx8IwW
	x50yLQklEsB0fpb2WGdFlBhl8JVJlSA9vJV+jOlqUSNUp02awFWiJq6ePWp4j3lc1YVH
	1pSMrLC2skPOyVOyHZUsU2A492aNEsWEl0tja8/q6VEp00VbdjajPI9gGf24aGXzzxAB
	AG0b5/dObHDzV8pzH6oqmmZ/+xyvyPZUYqpCQuKxk8A1j8BLR1QsuW8MFSPfIO34xUNt
	nUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nem0jPDIlnYvvO28sdjxeOMZuo/j/RK64yuRGFxbJo4=;
	b=Wl6ujV8NEx8m4GyhwWosbStJLFIRSAD/7MKy8mzLQmlXiJQXRQl3Nq+3E+5+LoSql1
	DizzaKkkGn9bckG3GrgnO3/KeNYAIok6iFVLnd8A6ijyi6swFSy5iwYw5j41NIvVHpzz
	m3sKLAHCRRjGOKlqX+mZG32E2EjaWjC8VBPoBwEi5pXazIjVCZDyIBxIgH/2purwnznE
	WQVDYvqoZfNvMJACVeJCHrmx/txccZjnK6cKgRRDiE1Fr4th/2qcm1hxdk+5hqxtt3sl
	xBrqd/I1BjBmwHrNaxEJKynexidORBzjrtsFOyPI9mharzO/1hoP4AorPjRKVOvVUdqz
	2Vhg==
X-Gm-Message-State: AIVw112Wk68wigILS2DcV/obWIBpDtsBcTpOk2FynTxGiG/cFGIs1LsN
	U6JSvWqpdHuEOP6bEemVqcutM2+vAA==
X-Received: by 10.80.139.65 with SMTP id l59mr7197242edl.52.1500683166425;
	Fri, 21 Jul 2017 17:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
	<CAJ86T=VSTa2h9FBvkXnwRb9S5ZfBs89n_qg+1kOKtww94rS1Jw@mail.gmail.com>
In-Reply-To: <CAJ86T=VSTa2h9FBvkXnwRb9S5ZfBs89n_qg+1kOKtww94rS1Jw@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 22 Jul 2017 00:25:55 +0000
Message-ID: <CAMKF1sqB1EBkqWYSGFfvr9=wpZhGYFtLTV7Z+VtdCSjfPr+rkw@mail.gmail.com>
To: Andre McCurdy <armccurdy@gmail.com>,
	Viditha Murahari <viditha@mpconsultants.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: need help to write a recipe to link a static library to my application
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
X-List-Received-Date: Sat, 22 Jul 2017 00:26:06 -0000
Content-Type: multipart/alternative; boundary="94eb2c194a060e28590554dd07c3"

--94eb2c194a060e28590554dd07c3
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 21, 2017 at 6:43 PM Andre McCurdy <armccurdy@gmail.com> wrote:

> On Fri, Jul 21, 2017 at 12:11 PM, Viditha Murahari
> <viditha@mpconsultants.org> wrote:
> > I'm new to yocto and bitbake and I'm building a voip application for a
> > custom imx6 board. I want to use  pjsip libraries to build my
> application, I
> > have compiled pjsip in my yocto build and generated pjsip libraries ( all
> > pjsip libraries r static). I'm having issues building a recipe for my
> > application that calls the pjsip functions. Below is how my recipe looks
> >
> >
> > Filename: rttapp.bb
> >
> > DESCRIPTION = "Simple voip application"
> > SECTION = "examples"
> > LICENSE = "MIT"
> > LIC_FILES_CHKSUM
> > ="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
> > PR = "r1"
> >
> > SRC_URI += "file://rttapp.c"
> > SRC_URI += "file://include"
> > SRC_URI += "file://lib"
> >
> > S = "${WORKDIR}"
> >
> > CFLAGS_prepend += "-I${WORKDIR}/include -DPJ_AUTOCONF=1
> -DPJ_IS_BIG_ENDIAN=0
> > -DPJ_IS_LITTLE_ENDIAN=1"
> > LDFLAGS_append += "-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi
> -lstdc++
> > -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound"
> >
> > do_compile() {
> > ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp
>
> Try splitting this into two commands. First compile rttapp.c to
> rttapp.o and then link the final application as a second step. When
> linking the application, ensure that rttapp.o is listed on the command
> line before the libraries which provide the symbols it requires.
>
> > }
> >
> >
> > When i do bitbake rttapp, the error i see is as below
> >
> >
> > Log data follows:
> > DEBUG: Executing shell function do_compile
> > /tmp/cc6nn4Dp.o: In function `main':
> > /usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to
> > `pjsua_create'
> > collect2: error: ld returned 1 exit status
> > WARNING: exit code 1 from a shell command.
> >
> >
> > Please advise


You are not having the said libraries in your workdir ensure that either
you have them via fetcher or via depends

>
> >
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--94eb2c194a060e28590554dd07c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div dir=3D"auto">On Fri, Jul 21, 2017 =
at 6:43 PM Andre McCurdy &lt;<a href=3D"mailto:armccurdy@gmail.com">armccur=
dy@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri,=
 Jul 21, 2017 at 12:11 PM, Viditha Murahari<br>
&lt;<a href=3D"mailto:viditha@mpconsultants.org" target=3D"_blank">viditha@=
mpconsultants.org</a>&gt; wrote:<br>
&gt; I&#39;m new to yocto and bitbake and I&#39;m building a voip applicati=
on for a<br>
&gt; custom imx6 board. I want to use=C2=A0 pjsip libraries to build my app=
lication, I<br>
&gt; have compiled pjsip in my yocto build and generated pjsip libraries ( =
all<br>
&gt; pjsip libraries r static). I&#39;m having issues building a recipe for=
 my<br>
&gt; application that calls the pjsip functions. Below is how my recipe loo=
ks<br>
&gt;<br>
&gt;<br>
&gt; Filename: <a href=3D"http://rttapp.bb" rel=3D"noreferrer" target=3D"_b=
lank">rttapp.bb</a><br>
&gt;<br>
&gt; DESCRIPTION =3D &quot;Simple voip application&quot;<br>
&gt; SECTION =3D &quot;examples&quot;<br>
&gt; LICENSE =3D &quot;MIT&quot;<br>
&gt; LIC_FILES_CHKSUM<br>
&gt; =3D&quot;file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecd=
a2f7b4f302&quot;<br>
&gt; PR =3D &quot;r1&quot;<br>
&gt;<br>
&gt; SRC_URI +=3D &quot;file://rttapp.c&quot;<br>
&gt; SRC_URI +=3D &quot;file://include&quot;<br>
&gt; SRC_URI +=3D &quot;file://lib&quot;<br>
&gt;<br>
&gt; S =3D &quot;${WORKDIR}&quot;<br>
&gt;<br>
&gt; CFLAGS_prepend +=3D &quot;-I${WORKDIR}/include -DPJ_AUTOCONF=3D1 -DPJ_=
IS_BIG_ENDIAN=3D0<br>
&gt; -DPJ_IS_LITTLE_ENDIAN=3D1&quot;<br>
&gt; LDFLAGS_append +=3D &quot;-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnu=
eabi -lstdc++<br>
&gt; -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound&quot;<br>
&gt;<br>
&gt; do_compile() {<br>
&gt; ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp<br>
<br>
Try splitting this into two commands. First compile rttapp.c to<br>
rttapp.o and then link the final application as a second step. When<br>
linking the application, ensure that rttapp.o is listed on the command<br>
line before the libraries which provide the symbols it requires.<br>
<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; When i do bitbake rttapp, the error i see is as below<br>
&gt;<br>
&gt;<br>
&gt; Log data follows:<br>
&gt; DEBUG: Executing shell function do_compile<br>
&gt; /tmp/cc6nn4Dp.o: In function `main&#39;:<br>
&gt; /usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to<br>
&gt; `pjsua_create&#39;<br>
&gt; collect2: error: ld returned 1 exit status<br>
&gt; WARNING: exit code 1 from a shell command.<br>
&gt;<br>
&gt;<br>
&gt; Please advise</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto=
">You are not having the said libraries in your workdir ensure that either =
you have them via fetcher or via depends</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><br>
&gt;<br>
&gt; --<br>
&gt; _______________________________________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_bla=
nk">bitbake-devel@lists.openembedded.org</a><br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailm=
an/listinfo/bitbake-devel</a><br>
&gt;<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div></div>

--94eb2c194a060e28590554dd07c3--
