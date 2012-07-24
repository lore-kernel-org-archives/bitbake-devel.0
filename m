Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1StoeQ-0004i3-Qb
	for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 01:36:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6ONOtX5018236
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 24 Jul 2012 16:24:55 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 24 Jul 2012 16:24:55 -0700
Message-ID: <500F2ECB.8080505@windriver.com>
Date: Wed, 25 Jul 2012 07:24:59 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1343113295.git.kai.kang@windriver.com>
	<0c6e89f1ac8abee8be17f821bda9b193b1761f6c.1343113295.git.kai.kang@windriver.com>
	<1343117680.21788.114.camel@ted>
In-Reply-To: <1343117680.21788.114.camel@ted>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q6ONOtX5018236
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/2] cooker: treat termination by disk monitor as failure
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 24 Jul 2012 23:36:27 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B407=E6=9C=8824=E6=97=A5 16:14, Richard Purdie wrote:
> On Tue, 2012-07-24 at 15:04 +0800, Kang Kai wrote:
>> [Yocto #2168]
>>
>> Check the return value of function diskMonitor.check() in runqueue the=
n
>> pass it to cooker. The cooker treats that runqueue terminated by disk
>> monitor as failure, then increase the build failure count if the retur=
n
>> value is true.
>>
>> The UIs could check the failure count accordingly, and this will helpf=
ul
>> for UIs such as Hob.
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
>>   bitbake/lib/bb/event.py    |    5 +++--
>>   bitbake/lib/bb/runqueue.py |    9 +++++----
>>   3 files changed, 20 insertions(+), 8 deletions(-)

Hi Richard,

> I have to say I don't really like this code. I agree that the UI needs
> to know about diskmonitor failures but I'm not sure about changing the
> BuiuldCompleted event in this way. I think we should add the exit statu=
s
> to the BuildCompleted event as an extra field (leaving the failures
> count alone as it means something specific right now).
>
> The UI is going to want more information about what failed (which disk
> was full, how full was it, where is it mounted?). The best approach
> therefore could be a specific DiskFull event which gets fired and the U=
I
> can act upon containing much more information.
OK. I'll update the patch.

Thanks,
Kai
>
> Cheers,
>
> Richard
>
>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 361bc88..58a10f7 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -1095,7 +1095,7 @@ class BBCooker:
>>                   rq.finish_runqueue(False)
>>               failures =3D 0
>>               try:
>> -                retval =3D rq.execute_runqueue()
>> +                retval, termedbydm =3D rq.execute_runqueue()
>>               except runqueue.TaskFailure as exc:
>>                   failures +=3D len(exc.args)
>>                   retval =3D False
>> @@ -1103,6 +1103,11 @@ class BBCooker:
>>                   self.command.finishAsyncCommand()
>>                   return False
>>
>> +            if termedbydm:
>> +                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.r=
unq_fnid), buildname, item, failures, bymonitor=3DTrue), self.configurati=
on.event_data)
>> +                self.command.finishAsyncCommand()
>> +                return False
>> +
>>               if not retval:
>>                   bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.=
runq_fnid), buildname, item, failures), self.configuration.event_data)
>>                   self.command.finishAsyncCommand()
>> @@ -1135,7 +1140,7 @@ class BBCooker:
>>                   rq.finish_runqueue(False)
>>               failures =3D 0
>>               try:
>> -                retval =3D rq.execute_runqueue()
>> +                retval, termedbydm =3D rq.execute_runqueue()
>>               except runqueue.TaskFailure as exc:
>>                   failures +=3D len(exc.args)
>>                   retval =3D False
>> @@ -1143,6 +1148,11 @@ class BBCooker:
>>                   self.command.finishAsyncCommand()
>>                   return False
>>
>> +            if termedbydm:
>> +                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.r=
unq_fnid), buildname, targets, failures, bymonitor=3DTrue), self.configur=
ation.data)
>> +                self.command.finishAsyncCommand()
>> +                return False
>> +
>>               if not retval:
>>                   bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.=
runq_fnid), buildname, targets, failures), self.configuration.data)
>>                   self.command.finishAsyncCommand()
>> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
>> index 1116c0a..d719105 100644
>> --- a/bitbake/lib/bb/event.py
>> +++ b/bitbake/lib/bb/event.py
>> @@ -305,14 +305,15 @@ class BuildStarted(BuildBase, OperationStarted):
>>
>>   class BuildCompleted(BuildBase, OperationCompleted):
>>       """bbmake build run completed"""
>> -    def __init__(self, total, n, p, failures =3D 0):
>> +    def __init__(self, total, n, p, failures =3D 0, bymonitor =3D Fal=
se):
>> +        if bymonitor:
>> +            failures +=3D 1
>>           if not failures:
>>               OperationCompleted.__init__(self, total, "Building Succe=
eded")
>>           else:
>>               OperationCompleted.__init__(self, total, "Building Faile=
d")
>>           BuildBase.__init__(self, n, p, failures)
>>
>> -
>>   class NoProvider(Event):
>>       """No Provider for an Event"""
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 0a8c723..efe3623 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -867,6 +867,7 @@ class RunQueue:
>>           """
>>
>>           retval =3D 0.5
>> +        termedbydm =3D False
>>
>>           if self.state is runQueuePrepare:
>>               self.rqexe =3D RunQueueExecuteDummy(self)
>> @@ -882,7 +883,7 @@ class RunQueue:
>>                   self.rqexe =3D RunQueueExecuteScenequeue(self)
>>
>>           if self.state in [runQueueSceneRun, runQueueRunning, runQueu=
eCleanUp]:
>> -            self.dm.check(self)
>> +            termedbydm =3D self.dm.check(self)
>>
>>           if self.state is runQueueSceneRun:
>>               retval =3D self.rqexe.execute()
>> @@ -914,14 +915,14 @@ class RunQueue:
>>
>>           if self.state is runQueueComplete:
>>               # All done
>> -            return False
>> +            return False, termedbydm
>>
>>           if self.state is runQueueChildProcess:
>>               print("Child process, eeek, shouldn't happen!")
>> -            return False
>> +            return False, termedbydm
>>
>>           # Loop
>> -        return retval
>> +        return retval, termedbydm
>>
>>       def finish_runqueue(self, now =3D False):
>>           if not self.rqexe:
>
>



