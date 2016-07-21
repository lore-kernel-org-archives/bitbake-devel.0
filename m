Return-Path: <jussi.kukkonen@intel.com>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
	[209.85.218.43])
	by mail.openembedded.org (Postfix) with ESMTP id 07B53607F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 11:26:37 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id l65so112729666oib.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Yu6RZxKcnANL3rMTt3k44vwgpuvK5JvQionFDpFgJd8=;
	b=Dijd4/IlMHEj8UwIJKtIl6SPS8z+rY5h+Q7pA9THzgOKImIw6qoI0J+78AtQHHqx4L
	6K+ovEOUdubeW66agTcBi1coHbXz6h3IJOk3Vzm2lnFI6KDrcaXuEy9rejKwdNiNW92q
	yDrq/C51mKvnAGe7zL+Uthdm8oo6FeQAKQoRxeckoUASwCTZhdJp1NKf13A80CvRw0r5
	qNwRLEKRm07VSbiTUECMAVNmQGGhpCs54I6a7kg55yIAfpvNonA1bhjPj2sZbcKdQGIQ
	BaWScD4dJJBu98zEmKwzMEzz/DDYJ+wYCfDCbY7mr+SzZdksbPbfUJ5d5pf6UG8r0z+T
	tHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Yu6RZxKcnANL3rMTt3k44vwgpuvK5JvQionFDpFgJd8=;
	b=BDsDW8tShENuYyrMipRDXt6rkiI+/QBH/ze9IBPsxc8M0PUBSDU+vc+sRBiSSokCo1
	9xWXioFjpP8dH9PK2Xs3DMXa1sagN5SkfVu0vitfV6CB2juBHqnZH5bhA11tUWK+ksYH
	GlINipyhHab6PsTzqK2kLQiL3BQA9kFYWNSOC9F5dxxr65U3/It7dJy9gWC1sOin1MnA
	yTyMZushjNEju7wHizCuO44PPNiiy8wbcQzW2mtqGtHcRt3CszyMwKQPWATuFepf/vJG
	58xRkmRfUioU40VMYU33c7BRMURVhufCxd8uyojcg+dF90IZha3B7ePdBMNK2k5tlMa5
	VPlg==
X-Gm-Message-State: ALyK8tL4YQQd66vvj3QYrHxFstWrCPZhspr7skQ1HMj/Ijg7uRbTXw1BB3VZXo2Xv9BXr5bruedjwXKFptfSwdF4
X-Received: by 10.157.22.245 with SMTP id s50mr21796184ots.161.1469100398527; 
	Thu, 21 Jul 2016 04:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.199.134 with HTTP; Thu, 21 Jul 2016 04:26:09 -0700 (PDT)
In-Reply-To: <CAJ5vXcRB1ue67dWdxRdP9xr2LV5tYFgV5COTLU-xAQ98qCCVHQ@mail.gmail.com>
References: <CAJ5vXcR+QuZ3KTBgY5TFHfetTzLvvC6moYdDDa4fRV385tKwsA@mail.gmail.com>
	<DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
	<CAJ5vXcQZH=zXWnF7bseRDGtGHJ3gkLRh=sc388cw+_aZyO0F1Q@mail.gmail.com>
	<CAJ5vXcRB1ue67dWdxRdP9xr2LV5tYFgV5COTLU-xAQ98qCCVHQ@mail.gmail.com>
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Date: Thu, 21 Jul 2016 14:26:09 +0300
Message-ID: <CAHiDW_HZGSDwu7HQdGT684dA3e1_5hPkTgOZoFN-s-WW3O7RpA@mail.gmail.com>
To: nousi <bnousilal@gmail.com>
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
X-List-Received-Date: Thu, 21 Jul 2016 11:26:40 -0000
Content-Type: multipart/alternative; boundary=001a1145f22a6523d9053823974e

--001a1145f22a6523d9053823974e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 July 2016 at 13:32, nousi <bnousilal@gmail.com> wrote:

> please, ignore my previous mail.
> There was an issue with the option "-C", it should be "-c".
>
> I have compiled modified kernel using " bitbake -c compile -f nousi-linux=
"
> command but, it seems kernel image does not get update with new
> configuration at below path.
>
> "poky/build/tmp/deploy/images/nousi123k/"
>

You forced a kernel compile only, after that you probably want to
re-generate the image ("bitbake <image-name>").

Note that this method of modifying kernel configuration is not how you'd do
it in production: See
http://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#generat=
ing-configuration-files
for how to create a defconfig or a config fragment and
http://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#changin=
g-the-configuration
for configuring your kernel with them.

Jussi


> Please, let me know if I am missing something in the process.
>
> On Thu, Jul 21, 2016 at 3:51 PM, nousi <bnousilal@gmail.com> wrote:
>
>> Hi Zhenhua Luo,
>>
>> Could not able to compile the kernel after changing the kernel
>> configuration using "bitbake -c menuconfig nousi-linux" command.
>> Please, have a look at the console logs below.
>>
>> #bitbake -C compile =E2=80=93f nousi-linux
>> NOTE: Preparing RunQueue
>> NOTE: Tainting hash to force rebuild of task
>> /projects/nousi-linux/nousilal/ns2/poky/build/../meta-nousi/common/recip=
es-kernel/linux/
>> nousi-linux_0.0.0.bb, do_rm_work_all
>> ERROR: Task do_compile is marked nostamp, cannot invalidate this task
>> ERROR: An uncaught exception occured in runqueue, please see the failure
>> below:
>> ERROR: Running idle function
>> Traceback (most recent call last):
>>   File
>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
>> line 1094, in RunQueue.execute_runqueue():
>>              try:
>>     >            return self._execute_runqueue()
>>              except bb.runqueue.TaskFailure:
>>   File
>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
>> line 1029, in RunQueue._execute_runqueue():
>>                  self.rqexe =3D RunQueueExecuteDummy(self)
>>     >            if self.rqdata.prepare() =3D=3D 0:
>>                      self.state =3D runQueueComplete
>>   File
>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
>> line 796, in RunQueueData.prepare():
>>                      for st in
>> self.cooker.configuration.invalidate_stamp.split(','):
>>     >                    invalidate_task(fn, "do_%s" % st, True)
>>
>>   File
>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py",
>> line 780, in
>> invalidate_task(fn=3D'/projects/nousi123-linux/nousilal/nn2/poky/build/.=
./meta-nousi/common/recipes-kernel/linux/
>> nousi-linux_0.0.0.bb', taskname=3D'do_compile', error_nostamp=3DTrue):
>>                      if error_nostamp:
>>     >                    bb.fatal("Task %s is marked nostamp, cannot
>> invalidate this task" % taskname)
>>                      else:
>>   File
>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/__init__.py",
>> line 102, in fatal:
>>          logger.critical(''.join(args))
>>     >    raise BBHandledException()
>>
>> BBHandledException
>>
>> On Thu, Jul 21, 2016 at 9:30 AM, Zhenhua Luo <zhenhua.luo@nxp.com> wrote=
:
>>
>>> Hi Nousilal,
>>>
>>>
>>>
>>> =E2=80=9Cbitbake -c menuconfig nousi-linux=E2=80=9D is used for changin=
g the kernel
>>> configs instead of modifying source code, you can run =E2=80=9Cbitbake =
-C compile
>>> -f nousi-linux =E2=80=9D to force rebuild with updated kernel configs.
>>>
>>>
>>>
>>> To modify the source code, you can do it in
>>> tmp/work-shared/<machine>/kernel-source/, then run =E2=80=9Cbitbake -C =
compile =E2=80=93f
>>> nousi-linux=E2=80=9D to rebuild new kernel image.
>>>
>>>
>>>
>>>
>>>
>>> Best Regards,
>>>
>>>
>>>
>>> Zhenhua
>>>
>>>
>>>
>>> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
>>> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *nousi
>>> *Sent:* Wednesday, July 20, 2016 2:18 PM
>>> *To:* bitbake-devel@lists.openembedded.org
>>> *Subject:* [bitbake-devel] source modification and re-build
>>>
>>>
>>>
>>> Hi All,
>>>
>>>
>>>
>>> Am new to yocto environment, please let me know the process to change
>>> kernel source using "bitbake nousi-linux -c menuconfig".
>>>
>>>
>>>
>>> I can able to make changes using "bitbake nousi-linux -c menuconfig"
>>> this command but my changes were not included in the new re-built image=
.
>>>
>>> Am using the development linux source code.
>>>
>>> Any help is appreciated.
>>>
>>>
>>>
>>> --
>>>
>>>
>>> *Thanks & Regards, B.Nousilal,*
>>>
>>
>>
>>
>> --
>>
>>
>> *Thanks & Regards,B.Nousilal,*
>>
>
>
>
> --
>
>
> *Thanks & Regards,B.Nousilal,*
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--001a1145f22a6523d9053823974e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 21 July 2016 at 13:32, nousi <span dir=3D"ltr">&lt;<a href=3D"mailto=
:bnousilal@gmail.com" target=3D"_blank">bnousilal@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">please, ignore my previous mail=
.<div>There was an=C2=A0issue with the option &quot;-C&quot;, it should be =
&quot;-c&quot;.</div><div><br></div><div>I have compiled modified kernel us=
ing &quot;=C2=A0bitbake -c compile -f nousi-linux&quot; command but, it see=
ms kernel image does not get=C2=A0update with new configuration at below pa=
th.</div><div><br></div><div>&quot;poky/build/tmp/deploy/images/nousi123k/&=
quot;</div></div></blockquote><div><br></div><div>You forced a kernel compi=
le only, after that you probably want to re-generate the image (&quot;bitba=
ke &lt;image-name&gt;&quot;).</div><div><br></div><div>Note that this metho=
d of modifying kernel configuration is not how you&#39;d do it in productio=
n: See=C2=A0<a href=3D"http://www.yoctoproject.org/docs/current/kernel-dev/=
kernel-dev.html#generating-configuration-files">http://www.yoctoproject.org=
/docs/current/kernel-dev/kernel-dev.html#generating-configuration-files</a>=
 for how to create a defconfig or a config fragment and =C2=A0<a href=3D"ht=
tp://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#changing-=
the-configuration">http://www.yoctoproject.org/docs/current/kernel-dev/kern=
el-dev.html#changing-the-configuration</a> for configuring your kernel with=
 them.</div><div><br></div><div>Jussi</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div>Please, let me know if I am missing something in th=
e process.</div></div><div class=3D""><div class=3D"h5"><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Thu, Jul 21, 2016 at 3:51 PM, nou=
si <span dir=3D"ltr">&lt;<a href=3D"mailto:bnousilal@gmail.com" target=3D"_=
blank">bnousilal@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr">Hi Zhenhua Luo,<div><br></div><div>Could not able to compile the=
 kernel after changing the kernel configuration using &quot;<span style=3D"=
color:rgb(31,73,125);font-family:Calibri,sans-serif;font-size:14.6667px">bi=
tbake -c menuconfig nousi-linux&quot; command.</span></div><div>Please, hav=
e a look at the console logs below.</div><div><br></div><div>#<span style=
=3D"color:rgb(31,73,125);font-family:Calibri,sans-serif;font-size:14.6667px=
">bitbake -C compile =E2=80=93f nousi-linux</span></div><div><div>NOTE: Pre=
paring RunQueue</div><div>NOTE: Tainting hash to force rebuild of task /pro=
jects/nousi-linux/nousilal/ns2/poky/build/../meta-nousi/common/recipes-kern=
el/linux/<a href=3D"http://nousi-linux_0.0.0.bb" target=3D"_blank">nousi-li=
nux_0.0.0.bb</a>, do_rm_work_all</div><div>ERROR: Task do_compile is marked=
 nostamp, cannot invalidate this task</div><div>ERROR: An uncaught exceptio=
n occured in runqueue, please see the failure below:</div><div>ERROR: Runni=
ng idle function</div><div>Traceback (most recent call last):</div><div>=C2=
=A0 File &quot;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/ru=
nqueue.py&quot;, line 1094, in RunQueue.execute_runqueue():</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:</div><div>=C2=A0 =C2=A0 &=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._execute_runqueue(=
)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except bb.runqu=
eue.TaskFailure:</div><div>=C2=A0 File &quot;/projects/nousi123-linux/nousi=
lal/nn2/poky/bitbake/lib/bb/runqueue.py&quot;, line 1029, in RunQueue._exec=
ute_runqueue():</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0self.rqexe =3D RunQueueExecuteDummy(self)</div><div>=C2=A0 =C2=
=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.rqdata.prepare() =
=3D=3D 0:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0self.state =3D runQueueComplete</div><div>=C2=A0 File =
&quot;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py=
&quot;, line 796, in RunQueueData.prepare():</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for st in self.cook=
er.configuration.invalidate_stamp.split(&#39;,&#39;):</div><div>=C2=A0 =C2=
=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0invalidate_task(fn, &quot;do_%s&quot; % st, True)</div><div><br></div><d=
iv>=C2=A0 File &quot;/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib=
/bb/runqueue.py&quot;, line 780, in invalidate_task(fn=3D&#39;/projects/nou=
si123-linux/nousilal/nn2/poky/build/../meta-nousi/common/recipes-kernel/lin=
ux/<a href=3D"http://nousi-linux_0.0.0.bb" target=3D"_blank">nousi-linux_0.=
0.0.bb</a>&#39;, taskname=3D&#39;do_compile&#39;, error_nostamp=3DTrue):</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if error_nostamp:</div><div>=C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Task %s =
is marked nostamp, cannot invalidate this task&quot; % taskname)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else:</div><div>=C2=A0 File &quot;/projects/nousi123-linux/nousilal/nn2/=
poky/bitbake/lib/bb/__init__.py&quot;, line 102, in fatal:</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.critical(&#39;&#39;.join(args))</div><di=
v>=C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0raise BBHandledException()</div><div><br>=
</div><div>BBHandledException</div></div></div><div><div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Thu, Jul 21, 2016 at 9:30 AM, Zh=
enhua Luo <span dir=3D"ltr">&lt;<a href=3D"mailto:zhenhua.luo@nxp.com" targ=
et=3D"_blank">zhenhua.luo@nxp.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">Hi Nousilal,
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">=E2=80=9Cbitbake -c menuconfig nousi-linux=
=E2=80=9D is used for changing the kernel configs instead of modifying sour=
ce code, you can run =E2=80=9Cbitbake -C compile -f nousi-linux =E2=80=9D
 to force rebuild with updated kernel configs. <u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">To modify the source code, you can do it in =
tmp/work-shared/&lt;machine&gt;/kernel-source/, then run =E2=80=9Cbitbake -=
C compile =E2=80=93f nousi-linux=E2=80=9D to rebuild new kernel image.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">Best Regards,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">Zhenhua<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-style:none none none solid;border-left-width:1.5pt;bor=
der-left-color:blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-style:solid none none;border-top-width:1pt;border-top-=
color:rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded=
.org" target=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a> [m=
ailto:<a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a>]
<b>On Behalf Of </b>nousi<br>
<b>Sent:</b> Wednesday, July 20, 2016 2:18 PM<br>
<b>To:</b> <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
<b>Subject:</b> [bitbake-devel] source modification and re-build<u></u><u><=
/u></span></p>
</div>
</div><div><div>
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
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><i><span style=3D"font-=
size:10pt;font-family:Arial,sans-serif;color:rgb(51,51,255)">Thanks &amp; R=
egards,<br>
B.Nousilal,</span></i><u></u><u></u></p>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div data-sm=
artmail=3D"gmail_signature"><i style=3D"color:rgb(51,51,255)"><font style=
=3D"font-family:arial,helvetica,sans-serif" size=3D"2">Thanks &amp; Regards=
,<br>B.Nousilal,<br></font></i><br></div>
</div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div data-smartmail=3D"gmail_signature"><i style=3D"color:rgb(51,51,255)"><=
font style=3D"font-family:arial,helvetica,sans-serif" size=3D"2">Thanks &am=
p; Regards,<br>B.Nousilal,<br></font></i><br></div>
</div>
</div></div><br>--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
<br></blockquote></div><br></div></div>

--001a1145f22a6523d9053823974e--
