Return-Path: <bnousilal@gmail.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 889026072C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 10:21:41 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id j185so110887163oih.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=OFP46JwEiYXhX0oglajwuNkghhF+QWP0nXO5+ApL1DQ=;
	b=utQkd13OzzsIyH9uFpxSX6fXKWfipiHS5XOi1b45ePRyF5tohV9bfloux6PaAVq/Ph
	RieVq10nanqIjn8CsUyopBepFLpylUihTapY53nzt92eygQukPeQYCrsYELH3BsvVsAv
	jl1a/vb8rOPJ+bvleOwIkZRya098agEoAg9BsVO78QKwBbOXwH02k0iOFhnJ/ZztJUwa
	JtIUHfA2dQxjkyXrdiNlroOIyvH5bkmbnNkzrWnx2MpFUW9gXvfacc6LVMFMhRS2B6sU
	yAlScQq0riKu5DtuaeHalgcg1EjCnpx4PwhGLDKPpyicTaqfg84MgkTYSlm9QgbxJCU2
	ZbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=OFP46JwEiYXhX0oglajwuNkghhF+QWP0nXO5+ApL1DQ=;
	b=B8XP+FJ5ip7P8a+8w+dIb1HqQ7K4rszZfoOyjG+d1Dici0og/oQKj/a805gW2o4uyx
	xqHKaZYZ+dwvuKv9HeB57tbeEblBTIGtQbLHPMsRf9r9zLXmge6l3SZwkzhto72xQZAm
	u9Lux1OtG9DlzSmjXJZMGh//Rk/pG5o8IVx+3qgKvJkk+sFkansEJzJUo9ZDUMt0o9OG
	hvECARkvXJ+IA3l/6CE5vn8p/o63niX82CkYR369hMpmsONX04zLFgc85zVSI5O/5arG
	e/WGFW6QduQ0rJnOVr+ipWbzICR73PBz2imPxuh/WX3HFnHQQvu4+0RgxljxqaqJ/R/U
	LEMA==
X-Gm-Message-State: ALyK8tI2L/KvEljerkklOYapS8tlOpS3/qx0D0EBMOqFKfAjm0Xs/59VAHF6fx6t9m1Hu/HBtD7FzENRpctGFw==
X-Received: by 10.202.95.133 with SMTP id t127mr10614926oib.80.1469096502541; 
	Thu, 21 Jul 2016 03:21:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.168 with HTTP; Thu, 21 Jul 2016 03:21:42 -0700 (PDT)
In-Reply-To: <DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
References: <CAJ5vXcR+QuZ3KTBgY5TFHfetTzLvvC6moYdDDa4fRV385tKwsA@mail.gmail.com>
	<DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
From: nousi <bnousilal@gmail.com>
Date: Thu, 21 Jul 2016 15:51:42 +0530
Message-ID: <CAJ5vXcQZH=zXWnF7bseRDGtGHJ3gkLRh=sc388cw+_aZyO0F1Q@mail.gmail.com>
To: Zhenhua Luo <zhenhua.luo@nxp.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: source modification and re-build
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
X-List-Received-Date: Thu, 21 Jul 2016 10:21:43 -0000
Content-Type: multipart/alternative; boundary=001a113d55442cc1aa053822af86

--001a113d55442cc1aa053822af86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua Luo,

Could not able to compile the kernel after changing the kernel
configuration using "bitbake -c menuconfig nousi-linux" command.
Please, have a look at the console logs below.

#bitbake -C compile =E2=80=93f nousi-linux
NOTE: Preparing RunQueue
NOTE: Tainting hash to force rebuild of task
/projects/nousi-linux/nousilal/ns2/poky/build/../meta-nousi/common/recipes-=
kernel/linux/
nousi-linux_0.0.0.bb, do_rm_work_all
ERROR: Task do_compile is marked nostamp, cannot invalidate this task
ERROR: An uncaught exception occured in runqueue, please see the failure
below:
ERROR: Running idle function
Traceback (most recent call last):
  File
"/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
line 1094, in RunQueue.execute_runqueue():
             try:
    >            return self._execute_runqueue()
             except bb.runqueue.TaskFailure:
  File
"/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
line 1029, in RunQueue._execute_runqueue():
                 self.rqexe =3D RunQueueExecuteDummy(self)
    >            if self.rqdata.prepare() =3D=3D 0:
                     self.state =3D runQueueComplete
  File
"/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
line 796, in RunQueueData.prepare():
                     for st in
self.cooker.configuration.invalidate_stamp.split(','):
    >                    invalidate_task(fn, "do_%s" % st, True)

  File
"/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
line 780, in
invalidate_task(fn=3D'/projects/nousi123-linux/nousilal/nn2/poky/build/../m=
eta-nousi/common/recipes-kernel/linux/
nousi-linux_0.0.0.bb', taskname=3D'do_compile', error_nostamp=3DTrue):
                     if error_nostamp:
    >                    bb.fatal("Task %s is marked nostamp, cannot
invalidate this task" % taskname)
                     else:
  File
"/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/__init__.py",
line 102, in fatal:
         logger.critical(''.join(args))
    >    raise BBHandledException()

BBHandledException

On Thu, Jul 21, 2016 at 9:30 AM, Zhenhua Luo <zhenhua.luo@nxp.com> wrote:

> Hi Nousilal,
>
>
>
> =E2=80=9Cbitbake -c menuconfig nousi-linux=E2=80=9D is used for changing =
the kernel
> configs instead of modifying source code, you can run =E2=80=9Cbitbake -C=
 compile
> -f nousi-linux =E2=80=9D to force rebuild with updated kernel configs.
>
>
>
> To modify the source code, you can do it in
> tmp/work-shared/<machine>/kernel-source/, then run =E2=80=9Cbitbake -C co=
mpile =E2=80=93f
> nousi-linux=E2=80=9D to rebuild new kernel image.
>
>
>
>
>
> Best Regards,
>
>
>
> Zhenhua
>
>
>
> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *nousi
> *Sent:* Wednesday, July 20, 2016 2:18 PM
> *To:* bitbake-devel@lists.openembedded.org
> *Subject:* [bitbake-devel] source modification and re-build
>
>
>
> Hi All,
>
>
>
> Am new to yocto environment, please let me know the process to change
> kernel source using "bitbake nousi-linux -c menuconfig".
>
>
>
> I can able to make changes using "bitbake nousi-linux -c menuconfig" this
> command but my changes were not included in the new re-built image.
>
> Am using the development linux source code.
>
> Any help is appreciated.
>
>
>
> --
>
>
> *Thanks & Regards, B.Nousilal,*
>



--=20


*Thanks & Regards,B.Nousilal,*

--001a113d55442cc1aa053822af86
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zhenhua Luo,<div><br></div><div>Could not able to compi=
le the kernel after changing the kernel configuration using &quot;<span sty=
le=3D"color:rgb(31,73,125);font-family:Calibri,sans-serif;font-size:14.6667=
px">bitbake -c menuconfig nousi-linux&quot; command.</span></div><div>Pleas=
e, have a look at the console logs below.</div><div><br></div><div>#<span s=
tyle=3D"color:rgb(31,73,125);font-family:Calibri,sans-serif;font-size:14.66=
67px">bitbake -C compile =E2=80=93f nousi-linux</span></div><div><div>NOTE:=
 Preparing RunQueue</div><div>NOTE: Tainting hash to force rebuild of task =
/projects/nousi-linux/nousilal/ns2/poky/build/../meta-nousi/common/recipes-=
kernel/linux/<a href=3D"http://nousi-linux_0.0.0.bb">nousi-linux_0.0.0.bb</=
a>, do_rm_work_all</div><div>ERROR: Task do_compile is marked nostamp, cann=
ot invalidate this task</div><div>ERROR: An uncaught exception occured in r=
unqueue, please see the failure below:</div><div>ERROR: Running idle functi=
on</div><div>Traceback (most recent call last):</div><div>=C2=A0 File &quot=
;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py&quot=
;, line 1094, in RunQueue.execute_runqueue():</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:</div><div>=C2=A0 =C2=A0 &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._execute_runqueue()</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except bb.runqueue.TaskFail=
ure:</div><div>=C2=A0 File &quot;/projects/nousi123-linux/nousilal/nn2/poky=
/bitbake/lib/bb/runqueue.py&quot;, line 1029, in RunQueue._execute_runqueue=
():</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.rqexe =3D RunQueueExecuteDummy(self)</div><div>=C2=A0 =C2=A0 &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.rqdata.prepare() =3D=3D 0:=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0self.state =3D runQueueComplete</div><div>=C2=A0 File &quot;/p=
rojects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py&quot;, =
line 796, in RunQueueData.prepare():</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for st in self.cooker.confi=
guration.invalidate_stamp.split(&#39;,&#39;):</div><div>=C2=A0 =C2=A0 &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0invali=
date_task(fn, &quot;do_%s&quot; % st, True)</div><div><br></div><div>=C2=A0=
 File &quot;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqu=
eue.py&quot;, line 780, in invalidate_task(fn=3D&#39;/projects/nousi123-lin=
ux/nousilal/nn2/poky/build/../meta-nousi/common/recipes-kernel/linux/<a hre=
f=3D"http://nousi-linux_0.0.0.bb">nousi-linux_0.0.0.bb</a>&#39;, taskname=
=3D&#39;do_compile&#39;, error_nostamp=3DTrue):</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if error_nostamp=
:</div><div>=C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Task %s is marked nostamp, cannot=
 invalidate this task&quot; % taskname)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:</div><div>=C2=A0 =
File &quot;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/__init=
__.py&quot;, line 102, in fatal:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0logger.critical(&#39;&#39;.join(args))</div><div>=C2=A0 =C2=A0 &gt; =C2=
=A0 =C2=A0raise BBHandledException()</div><div><br></div><div>BBHandledExce=
ption</div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Thu, Jul 21, 2016 at 9:30 AM, Zhenhua Luo <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:zhenhua.luo@nxp.com" target=3D"_blank">zhenhua.luo@nxp.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Hi Nousilal,
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">=E2=80=9Cbitbake -c menuconfig nousi-=
linux=E2=80=9D is used for changing the kernel configs instead of modifying=
 source code, you can run =E2=80=9Cbitbake -C compile -f nousi-linux =E2=80=
=9D
 to force rebuild with updated kernel configs. <u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">To modify the source code, you can do=
 it in tmp/work-shared/&lt;machine&gt;/kernel-source/, then run =E2=80=9Cbi=
tbake -C compile =E2=80=93f nousi-linux=E2=80=9D to rebuild new kernel imag=
e.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Best Regards,<u></u><u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Zhenhua<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> <a href=3D"mailto:bitbake-deve=
l-bounces@lists.openembedded.org" target=3D"_blank">bitbake-devel-bounces@l=
ists.openembedded.org</a> [mailto:<a href=3D"mailto:bitbake-devel-bounces@l=
ists.openembedded.org" target=3D"_blank">bitbake-devel-bounces@lists.openem=
bedded.org</a>]
<b>On Behalf Of </b>nousi<br>
<b>Sent:</b> Wednesday, July 20, 2016 2:18 PM<br>
<b>To:</b> <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
<b>Subject:</b> [bitbake-devel] source modification and re-build<u></u><u><=
/u></span></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Hi All,<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Am new to=C2=A0yocto environment, please let me know=
 the process to change kernel source using &quot;bitbake nousi-linux -c men=
uconfig&quot;.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I can able to make changes using=C2=A0&quot;bitbake=
=C2=A0nousi-linux=C2=A0-c menuconfig&quot; this command but my changes were=
 not included in the new re-built image.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Am using the=C2=A0development linux source code.<br =
clear=3D"all">
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">Any help is appreciated.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal">-- <u></u><u></u></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><i><span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#3333ff">Thank=
s &amp; Regards,<br>
B.Nousilal,</span></i><u></u><u></u></p>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><i style=3D"color:r=
gb(51,51,255)"><font style=3D"font-family:arial,helvetica,sans-serif" size=
=3D"2">Thanks &amp; Regards,<br>B.Nousilal,<br></font></i><br></div>
</div>

--001a113d55442cc1aa053822af86--
