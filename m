Return-Path: <bnousilal@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 7B0AC6FF9B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jul 2016 06:13:19 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id c199so324376oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=5nXJgstEng4wkvrjIJZRYs4V8sfBgoUICmGyCbmqSvQ=;
	b=wthBxInTqopLefRPfrgveJUypAHHwj0q5hFF51rYuo0WL1cR16ds9My6VOSlhoOL+Q
	WLZ0TA3MuQGXiQ2EaPX+WoN3g5lahl9//1dBOCzQboxjeVTPl+zTv0GcLPH2Zv749l9P
	ncjwNaCkLxxLBvL3jeQjTp0Zi/XmzueOCP/IcjWAeHwM/RI1V8pyRvK5Wf2O8joyPURs
	Kd+3/bBhGH4R0nUsAAaunEY6FlZhD2I0kSTchpwaGnRtsONnQ3II30l695ldY42nUGi4
	y8MOrd+nU5AX4CqMJuwaGJ16EOkzSWtHc5/gwuUjv8E1I4+S1pp6QcHSXEt6bnpwrdy8
	naww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=5nXJgstEng4wkvrjIJZRYs4V8sfBgoUICmGyCbmqSvQ=;
	b=CbKbhc2ZX9JCpzJdSGmE612zU3WQL9kAAGgj22xH2s+V2Hs0EmHI0mQPLxFHIT4l3E
	Tv3gZh7pA0+ZiyQoXPN7kZ9Kb1N0HKc1TG+iOuGsNC+JJE6OAAAGJiyK77GW58e4YP54
	IiuqpRx5Qvd1AVy1FL57iG1EseYVarxD/W1NL0itlWxGmBOIeBmUo/C5KB1eR0YAW533
	atWyYw/65M/TxlUQYRvjKQeo2le82nLUykm9EMlhl56U/ZYCV7DIqI6a8oCQNwmWX7NX
	Ddap+SOVq0/EupvimMrUU91Q0aUz23JPIB1NRQ1cbtguBSuPtfCPlU2lL/v7XkYPzxV5
	Sibg==
X-Gm-Message-State: AEkoouuMa/q/YoHBJ4gzCJDAVr9IJBec8HhRMU1fts8ggbFDCZQRO7ZfP+WEZRPIceuZ8iqfJ1p6q2hOnq8j6Q==
X-Received: by 10.157.12.70 with SMTP id 64mr15667489otr.192.1469599999683;
	Tue, 26 Jul 2016 23:13:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.168 with HTTP; Tue, 26 Jul 2016 23:13:19 -0700 (PDT)
In-Reply-To: <CAHiDW_HZGSDwu7HQdGT684dA3e1_5hPkTgOZoFN-s-WW3O7RpA@mail.gmail.com>
References: <CAJ5vXcR+QuZ3KTBgY5TFHfetTzLvvC6moYdDDa4fRV385tKwsA@mail.gmail.com>
	<DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
	<CAJ5vXcQZH=zXWnF7bseRDGtGHJ3gkLRh=sc388cw+_aZyO0F1Q@mail.gmail.com>
	<CAJ5vXcRB1ue67dWdxRdP9xr2LV5tYFgV5COTLU-xAQ98qCCVHQ@mail.gmail.com>
	<CAHiDW_HZGSDwu7HQdGT684dA3e1_5hPkTgOZoFN-s-WW3O7RpA@mail.gmail.com>
From: nousi <bnousilal@gmail.com>
Date: Wed, 27 Jul 2016 11:43:19 +0530
Message-ID: <CAJ5vXcSF8gSpCeXPKrykn=0p+dHogBJZkOZhiHMuAtAtHhZ8DQ@mail.gmail.com>
To: Jussi Kukkonen <jussi.kukkonen@intel.com>
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
X-List-Received-Date: Wed, 27 Jul 2016 06:13:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

kernel image name is "uImage-nousi-linux.img" in
"poky/build/tmp/deploy/images/nousi12k/" directory when I use "bitbake
nousi-dev-image", it will create all the images including rootfs,
u-boot, dtb and takes lot of time to build.

I would like to build only kernel image "uImage-nousi-linux.img".
Please, let me know how can I do it.

Thanks,
Nousi.


On Thu, Jul 21, 2016 at 4:56 PM, Jussi Kukkonen
<jussi.kukkonen@intel.com> wrote:
>
>
> On 21 July 2016 at 13:32, nousi <bnousilal@gmail.com> wrote:
>>
>> please, ignore my previous mail.
>> There was an issue with the option "-C", it should be "-c".
>>
>> I have compiled modified kernel using " bitbake -c compile -f nousi-linu=
x"
>> command but, it seems kernel image does not get update with new
>> configuration at below path.
>>
>> "poky/build/tmp/deploy/images/nousi123k/"
>
>
> You forced a kernel compile only, after that you probably want to
> re-generate the image ("bitbake <image-name>").
>
> Note that this method of modifying kernel configuration is not how you'd =
do
> it in production: See
> http://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#gener=
ating-configuration-files
> for how to create a defconfig or a config fragment and
> http://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#chang=
ing-the-configuration
> for configuring your kernel with them.
>
> Jussi
>
>>
>> Please, let me know if I am missing something in the process.
>>
>> On Thu, Jul 21, 2016 at 3:51 PM, nousi <bnousilal@gmail.com> wrote:
>>>
>>> Hi Zhenhua Luo,
>>>
>>> Could not able to compile the kernel after changing the kernel
>>> configuration using "bitbake -c menuconfig nousi-linux" command.
>>> Please, have a look at the console logs below.
>>>
>>> #bitbake -C compile =E2=80=93f nousi-linux
>>> NOTE: Preparing RunQueue
>>> NOTE: Tainting hash to force rebuild of task
>>> /projects/nousi-linux/nousilal/ns2/poky/build/../meta-nousi/common/reci=
pes-kernel/linux/nousi-linux_0.0.0.bb,
>>> do_rm_work_all
>>> ERROR: Task do_compile is marked nostamp, cannot invalidate this task
>>> ERROR: An uncaught exception occured in runqueue, please see the failur=
e
>>> below:
>>> ERROR: Running idle function
>>> Traceback (most recent call last):
>>>   File
>>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py"=
,
>>> line 1094, in RunQueue.execute_runqueue():
>>>              try:
>>>     >            return self._execute_runqueue()
>>>              except bb.runqueue.TaskFailure:
>>>   File
>>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py"=
,
>>> line 1029, in RunQueue._execute_runqueue():
>>>                  self.rqexe =3D RunQueueExecuteDummy(self)
>>>     >            if self.rqdata.prepare() =3D=3D 0:
>>>                      self.state =3D runQueueComplete
>>>   File
>>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py"=
,
>>> line 796, in RunQueueData.prepare():
>>>                      for st in
>>> self.cooker.configuration.invalidate_stamp.split(','):
>>>     >                    invalidate_task(fn, "do_%s" % st, True)
>>>
>>>   File
>>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/runqueue.py"=
,
>>> line 780, in
>>> invalidate_task(fn=3D'/projects/nousi123-linux/nousilal/nn2/poky/build/=
../meta-nousi/common/recipes-kernel/linux/nousi-linux_0.0.0.bb',
>>> taskname=3D'do_compile', error_nostamp=3DTrue):
>>>                      if error_nostamp:
>>>     >                    bb.fatal("Task %s is marked nostamp, cannot
>>> invalidate this task" % taskname)
>>>                      else:
>>>   File
>>> "/projects/nousi123-linux/nousilal/nn2/poky/bitbake/lib/bb/__init__.py"=
,
>>> line 102, in fatal:
>>>          logger.critical(''.join(args))
>>>     >    raise BBHandledException()
>>>
>>> BBHandledException
>>>
>>> On Thu, Jul 21, 2016 at 9:30 AM, Zhenhua Luo <zhenhua.luo@nxp.com> wrot=
e:
>>>>
>>>> Hi Nousilal,
>>>>
>>>>
>>>>
>>>> =E2=80=9Cbitbake -c menuconfig nousi-linux=E2=80=9D is used for changi=
ng the kernel
>>>> configs instead of modifying source code, you can run =E2=80=9Cbitbake=
 -C compile -f
>>>> nousi-linux =E2=80=9D to force rebuild with updated kernel configs.
>>>>
>>>>
>>>>
>>>> To modify the source code, you can do it in
>>>> tmp/work-shared/<machine>/kernel-source/, then run =E2=80=9Cbitbake -C=
 compile =E2=80=93f
>>>> nousi-linux=E2=80=9D to rebuild new kernel image.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Best Regards,
>>>>
>>>>
>>>>
>>>> Zhenhua
>>>>
>>>>
>>>>
>>>> From: bitbake-devel-bounces@lists.openembedded.org
>>>> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of nou=
si
>>>> Sent: Wednesday, July 20, 2016 2:18 PM
>>>> To: bitbake-devel@lists.openembedded.org
>>>> Subject: [bitbake-devel] source modification and re-build
>>>>
>>>>
>>>>
>>>> Hi All,
>>>>
>>>>
>>>>
>>>> Am new to yocto environment, please let me know the process to change
>>>> kernel source using "bitbake nousi-linux -c menuconfig".
>>>>
>>>>
>>>>
>>>> I can able to make changes using "bitbake nousi-linux -c menuconfig"
>>>> this command but my changes were not included in the new re-built imag=
e.
>>>>
>>>> Am using the development linux source code.
>>>>
>>>> Any help is appreciated.
>>>>
>>>>
>>>>
>>>> --
>>>>
>>>> Thanks & Regards,
>>>> B.Nousilal,
>>>
>>>
>>>
>>>
>>> --
>>> Thanks & Regards,
>>> B.Nousilal,
>>>
>>
>>
>>
>> --
>> Thanks & Regards,
>> B.Nousilal,
>>
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>



--=20
Thanks & Regards,
B.Nousilal,

