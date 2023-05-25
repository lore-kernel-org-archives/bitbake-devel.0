Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01607C77B7A
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 08:19:18 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.6961.1685002748195537878
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 01:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=glY2/G36;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685002749;
  x=1716538749;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=SyweMZoH+dz7/tnHv+uVJyeoo+NVPTwo1onvvwf9CNE=;
  b=glY2/G36tyGdW0HvLNBMr8MGYqOVxYGl6GCyGGqOYi21uFF80DqObfd5
   Qq/QWK8HTVNH6w/tsDwrmJyjlEQEFqC+zLhw4YPzMsV7PLiWEMj1fS/uF
   LPnrV9IjxrAoDoCquACclY034HKm90NtlOnQsf33d6JFpm/lgQUU0yOYP
   O8GZTzUlOVkIPluKomV6YdjDOV0PL5In6wABnFFekXmJsQEN1awUm8ygT
   0C7e1/9Zhz1un72jZfuRV68W/gRpOUboc2lbCMWs6zeJW/0Em202eYeHH
   hSVQgerNpz6uEeFYhxoSL15MdWh9WyLrifQ+a9nGAxme9ItKI8WUv17I6
   A==;
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
User-agent: mu4e 1.8.14; emacs 29.0.60
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: <randy.macleod@windriver.com>
CC: <Qi.Chen@windriver.com>, Randy MacLeod via lists.openembedded.org
	<randy.macleod=windriver.com@lists.openembedded.org>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Date: Thu, 25 May 2023 10:17:48 +0200
Organization: Axis Communications AB
In-Reply-To: <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
Message-ID: <jwqilcg4ydl.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 08:19:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14805


On Tue, May 23 2023, Randy MacLeod via lists.openembedded.org wrote:

> On 2023-05-22 22:09, Qi.Chen@windriver.com wrote:
>> From: Chen Qi<Qi.Chen@windriver.com>
>>
>> The current logic is not correct because if the time interval
>> between the current check and the last check is very small, the PSI
>> checker is not likely to block things even if the system is heavy
>> loaded.
>>
>> It's not good to calculate the value too often. So we change to a 1s
>> check. As a build will usually take at least minutes, using the 1s value
>> seems reasonable.
>
> I don't have time to check today but I'm not convinced that this is true.
>
> I suspect that in the typical case, it would be okay but there will be
> workloads (perhaps rare workloads) where you want to check more often.
>
> The 1 second intervals where we no longer launch new work may
> result in a significantly longer build. IIRC, our benchmark was building
> core-image-minimal on a 24 core system without PSI regulation and then
> with it set to 300. I'd look at the elapsed time and the
> buildchart/bootchart:
> =C2=A0=C2=A0 scripts/pybootchartgui/README.pybootchart
>
> Ola, have you been able to test this and if not, can you?
>

This patch is identical to the V1 except for the commit message, so I
consider it

Tested-By: Ola Nilsson <ola.x.nilsson@axis.com>

/Ola

> All for today.
>
> ../Randy
>
>
>>
>> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>> ---
>>   bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>>   1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 02f1474540..4d49d25153 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
>>                       self.prev_memory_pressure =3D memory_pressure_fds.=
readline().split()[4].split("=3D")[1]
>>                       self.prev_pressure_time =3D time.time()
>>                   self.check_pressure =3D True
>> +                self.psi_exceeded =3D False
>>               except:
>> bb.note("The /proc/pressure files can't be read. Continuing build
> without monitoring pressure")
>>                   self.check_pressure =3D False
>> @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
>>           BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above =
threshold.
>>           """
>>           if self.check_pressure:
>> +            now =3D time.time()
>> +            tdiff =3D now - self.prev_pressure_time
>> +            if tdiff < 1.0:
>> +                return self.psi_exceeded
>>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>>                   open("/proc/pressure/io") as io_pressure_fds, \
>>                   open("/proc/pressure/memory") as memory_pressure_fds:
>> @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
>>                   curr_cpu_pressure =3D cpu_pressure_fds.readline().spli=
t()[4].split("=3D")[1]
>>                   curr_io_pressure =3D io_pressure_fds.readline().split(=
)[4].split("=3D")[1]
>>                   curr_memory_pressure =3D memory_pressure_fds.readline(=
).split()[4].split("=3D")[1]
>> -                now =3D time.time()
>> -                tdiff =3D now - self.prev_pressure_time
>> -                if tdiff > 1.0:
>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
> self.rq.max_cpu_pressure
>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
> self.rq.max_io_pressure
>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
> tdiff > self.rq.max_memory_pressure
>> -                    self.prev_cpu_pressure =3D curr_cpu_pressure
>> -                    self.prev_io_pressure =3D curr_io_pressure
>> -                    self.prev_memory_pressure =3D curr_memory_pressure
>> -                    self.prev_pressure_time =3D now
>> -                else:
>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
> self.rq.max_cpu_pressure
>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
> self.rq.max_io_pressure
>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
> self.rq.max_memory_pressure
>> -            return (exceeds_cpu_pressure or exceeds_io_pressure or exce=
eds_memory_pressure)
>> + exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
> self.rq.max_cpu_pressure
>> + exceeds_io_pressure =3D self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
> self.rq.max_io_pressure
>> + exceeds_memory_pressure =3D self.rq.max_memory_pressure and
> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
> tdiff > self.rq.max_memory_pressure
>> +                self.prev_cpu_pressure =3D curr_cpu_pressure
>> +                self.prev_io_pressure =3D curr_io_pressure
>> +                self.prev_memory_pressure =3D curr_memory_pressure
>> +                self.prev_pressure_time =3D now
>> +                self.psi_exceeded =3D exceeds_cpu_pressure or exceeds_i=
o_pressure or exceeds_memory_pressure
>> +            return self.psi_exceeded
>>           return False
>>         def next_buildable_task(self):


--=20
Ola x Nilsson

