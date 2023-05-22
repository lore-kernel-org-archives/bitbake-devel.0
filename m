Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB76C7EE26
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 09:47:18 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.18234.1684748831724954452
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 May 2023 02:47:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Ybz+JskF;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684748832;
  x=1716284832;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=AVaL4RUJueVcCYeGD1TQKoOIK4QeNZhcMh1evP3mXhM=;
  b=Ybz+JskFt7w8szrT8rJuQGqZIRKZ7rA7L2Bq3wgdztqLr5+eKSWV0XEJ
   FZR7KV8P9pGYkBPGVssmBQOdanT2KhsIzo2fsNP6aIBsc8xfTfBd12c4I
   xmpmEWZ0i89AgXxa8L56a7nM1thJFZ2v/KpS+RsZKfQNyWhWwPhE09LRy
   xvtjntwGVY04cKKKca6D4K9GkMxxlm/10f4RRiJHhUV6RtujBV1zB+QxC
   50ne/RF/wVYSc6Hp9w0d/re8ZNATvrX+FKA9wXLc4YlkbJqrrcso6o7Rt
   WcqBwVsMkeVP6oO8OgMIMACp1yj4PyvegziDpa/ApuKc1jVkDsKWU8NdC
   Q==;
References: <jwq5yegq5h5.fsf@axis.com>
 <49ffc1db-9b43-e570-d726-dba12d560a30@windriver.com>
 <jwqfsdbo6w9.fsf@axis.com>
 <C2B324F8-26C0-4FD6-848C-1224EB502474@zhengqiu.net>
 <732553c1-870e-c794-c245-d664afa14343@windriver.com>
 <5fb8eecc-135f-c34a-3d1a-1d4b9ae62509@windriver.com>
User-agent: mu4e 1.8.14; emacs 29.0.60
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: ChenQi <Qi.Chen@windriver.com>
CC: Randy MacLeod <randy.macleod@windriver.com>, <contrib@zhengqiu.net>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Bitbake PSI checker
Date: Mon, 22 May 2023 11:36:20 +0200
Organization: Axis Communications AB
In-Reply-To: <5fb8eecc-135f-c34a-3d1a-1d4b9ae62509@windriver.com>
Message-ID: <jwqzg5w4s0y.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 09:47:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14794


Hi Qi and Randy,

I did some testing this morning, and I think this works fine for the <1s
intervals.

I added log prints whenever the exceeds_max_pressure function was called
and was a bit suprised at some of my observations.

It seems setscene tasks are started without checking the PSI.  Is this
by design?  With the antivirus program forced on me by IT I easily reach
CPU PSI on above 600000 (my current limit) while only running setscene
tasks.

If the PSI threshold has been reached, no new tasks will be started for
a while.  But once the PSI check passes, it seems as many tasks as are
allowed are started at once.  Considering the time interval between
checks for each started task would be very small, this would probably
happen even if the PSI was checked for each task start.  But won't this
cause 'waves' of tasks that compete and cause high PSI instead of
allowing just a few (one?) tasks to start and then wait a second?

These two things are obviously not connected to this patch.  I think
this is fine except for the commit message which refers to runqemu.py
instead of runqueue.py.

Thank you for this improvment.=20
/Ola

On Mon, May 22 2023, ChenQi wrote:

> Hi Ola & Randy,
>
> I just checked the codes and I think Ola is right. The current PSI check =
cannot block spawning of new tasks if the time interval
> is small between current check and last check. I'll send out a patch to f=
ix this issue.
>
> Also, I don't think calculating the value too often is a good idea, so I'=
ll change the check to be >1s.
>
> Please help review the patch.
>
> Regards,
> Qi
>
> On 5/21/23 03:58, Randy MacLeod wrote:
>
>  On 2022-12-19 14:49, Zheng Qiu via lists.openembedded.org wrote:
>
>  On Dec 19, 2022, at 7:50 AM, Ola x Nilsson <ola.x.nilsson@axis.com> wrot=
e:
>
>  On Mon, Dec 12 2022, Randy MacLeod wrote:
>
>  CCing Richard
>
>  On 2022-12-12 05:07, Ola x Nilsson via lists.openembedded.org wrote:
>
>  Hi,
>
>  I've been looking into using the pressure stall information awareness of
>  bitbake
>
>  That's good to hear Ola.
>
>   but I have some problems getting it to work.  Actually I think
>  it just doesn't work at all.
>
>  Doesn't work at all?
>
>  Well that would be surprising. See below.
>
>  OK, it will occasionally block a task. But since the next attempt will
>  always be a very short time interval it will almost always start a new
>  task even if the pressure is high.
>  At least this is what I observe on my system.
>
>  <snip>
>
>  1. Rather than just keep track of the previous pressure values
>  seen more than 1 second ago as done currently:
>
>        if now - self.prev_pressure_time > 1.0:
>
>  and always using that as a reference, we can
>  store say 10 values per second and use that as a reference.
>
>  There are some challenges in that approach in that we don't control
>  how often the function is called. Averaging over the last 10 calls
>  is tempting but likely has some edge cases such as when there are
>  lots of tasks starting/ending.
>
>  2. If there has been a long delay since the function was last called,
>  we could check the pressure, sleep for a short period of time and check =
it
>  again. Some people would not like this since it will needlessly delay=20
>  the build
>  so we'd have to keep the delay to < 1 second. Too short a delay will red=
uce
>  the accuracy of the result but I suspect that 0.1 seconds is sufficient=
=20
>  for most
>  users. We could also look at the avg10 value in this case or even some=20
>  combination of
>  both the current contention and avg10.
>
>  3. Just calculate the pressure per second by:
>
>     ( current pressure - last pressure ) / (now - last_time)
>
>  This could handle  short time differences such os milliseconds
>  as would be a 'cheap' way to deal with long delays. In your case,
>  the pressure would be:
>
>    978077.0 io_pressure 1353882.0 mem_pressure 20922.0
>
>  divided by ~19 since the initial values were close to zero.
>
>  Then for the next time, just 0.1 seconds later:
>
>  1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_press=
ure 20922.0
>  1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
>  1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.0
>
>  Multiplying by 10 or easy calculation, the would be a pressure:
>
>  cpu: 4660, io: 307920, mem: 0.
>
>  Do you have another idea or a preference as to which approach we take?
>
>  I think 3 is a good first step.  Using multiple samples could improve
>  our calculated "avg1", but lets do that later if needed.
>
>  I agree; Randy and I have been working on patching make and have taken a=
 similar approach:
>
>  make.png=20
>  ZhengQ2/make at cpu-pressure github.com=20=20=20
> make.png
>  Additionally, we found that when the pressure read is too frequent, we m=
ay get the same cpu pressure as an result,=20
>  even if the pressure have actually changed. This is likely due to the pe=
r cpu variables used in the kernel.
>  So, in addition to the algorithm Randy talked above, we also compares if=
 the cpu pressure has been changed, if not,
>  we will return the last result that has been produced.
>
>  I will CC you when I have a patch, and you can try it out before the com=
mit gets merged if you like.
>
>  Ola,=20
>
>  Does Qi's patch below help in your situation?
>
>  I still want/intent to add a bitbake PSI test case that uses stress-ng t=
o induce load
>  and a lightweight sleep task but there are never enough hours in the day=
/week/...
>
>  The basic idea is to:
>
>  1. Run a task that just sleeps for say 10 seconds and confirm that the a=
ctual
>  execution time is < 11 seconds or so.
>
>  2. use stress to get the system into a CPU pressure environment above
>  the current threshold for say 30 seconds and simultaneously / shortly th=
ere after,=20
>  launch the same sleep task and confirm that this time, the actual exectu=
ion time of
>  the launch to completion time is 40+ seconds.
>
>  ../Randy 'getting caught up on email on the weekend' MacLeod
>
>  =E2=9D=AF git show ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
>  commit ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
>  Author: Chen Qi <Qi.Chen@windriver.com>
>  Date:   Thu Apr 6 23:07:14 2023
>
>      bitbake: runqueue: fix PSI check calculation
>=20=20=20=20=20=20
>      The current PSI check calculation does not take into consideration
>      the possibility of the time interval between last check and current
>      check being much larger than 1s. In fact, the current behavior does
>      not match what the manual says about BB_PRESSURE_MAX_XXX, even if
>      the value is set to upper limit, 1000000, we still get many blocks
>      on new task launch. The difference between 'total' should be divided
>      by the time interval if it's larger than 1s.
>=20=20=20=20=20=20
>      (Bitbake rev: b4763c2c93e7494e0a27f5970c19c1aac66c228b)
>=20=20=20=20=20=20
>      Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>      Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
>  =CE=94 bitbake/lib/bb/runqueue.py
>  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
>=20=20
>
>  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=80=A2 198: class RunQueueScheduler(object): =E2=94=82
>  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                  curr_cpu_pressure =3D cpu_pressure_fds.readline().split(=
)[4].split("=3D")[1]
>                  curr_io_pressure =3D io_pressure_fds.readline().split()[=
4].split("=3D")[1]
>                  curr_memory_pressure =3D memory_pressure_fds.readline().=
split()[4].split("=3D")[1]
>                  exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and (=
float(curr_cpu_pressure) - float(self.prev_cpu_pressure))
>  > self.rq.max_cpu_pressure
>                  exceeds_io_pressure =3D  self.rq.max_io_pressure and (fl=
oat(curr_io_pressure) - float(self.prev_io_pressure)) >
>  self.rq.max_io_pressure
>                  exceeds_memory_pressure =3D self.rq.max_memory_pressure =
and (float(curr_memory_pressure) - float
>  (self.prev_memory_pressure)) > self.rq.max_memory_pressure
>                  now =3D time.time()
>                  if now - self.prev_pressure_time > 1.0:
>                  tdiff =3D now - self.prev_pressure_time
>                  if tdiff > 1.0:
>                      exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd (float(curr_cpu_pressure) - float
>  (self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
>                      exceeds_io_pressure =3D  self.rq.max_io_pressure and=
 (float(curr_io_pressure) - float(self.prev_io_pressure)) /
>  tdiff > self.rq.max_io_pressure
>                      exceeds_memory_pressure =3D self.rq.max_memory_press=
ure and (float(curr_memory_pressure) - float
>  (self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
>                      self.prev_cpu_pressure =3D curr_cpu_pressure
>                      self.prev_io_pressure =3D curr_io_pressure
>                      self.prev_memory_pressure =3D curr_memory_pressure
>                      self.prev_pressure_time =3D now
>                  else:
>                      exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd (float(curr_cpu_pressure) - float
>  (self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
>                      exceeds_io_pressure =3D  self.rq.max_io_pressure and=
 (float(curr_io_pressure) - float(self.prev_io_pressure)) >
>  self.rq.max_io_pressure
>                      exceeds_memory_pressure =3D self.rq.max_memory_press=
ure and (float(curr_memory_pressure) - float
>  (self.prev_memory_pressure)) > self.rq.max_memory_pressure
>              return (exceeds_cpu_pressure or exceeds_io_pressure or excee=
ds_memory_pressure)
>          return False
>
>  ZQ
>
>  /Ola
>
>  ../Randy
>
>  /Ola Nilsson
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14206): https://lists.openembedded.org/g/bitbake-deve=
l/message/14206
> Mute This Topic: https://lists.openembedded.org/mt/95618299/3616765
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [randy.=
macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Ola x Nilsson

