Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Suh6L-0000ID-EI
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jul 2012 11:44:53 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6R9XIpr006626
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 27 Jul 2012 02:33:18 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Fri, 27 Jul 2012 02:33:18 -0700
Message-ID: <50126063.2020203@windriver.com>
Date: Fri, 27 Jul 2012 17:33:23 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1343295453.git.kai.kang@windriver.com>
	<29b7d71a66994a626bcbcfce87e9279cb0da7961.1343295453.git.kai.kang@windriver.com>
	<1343298776.29991.23.camel@ted>
In-Reply-To: <1343298776.29991.23.camel@ted>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q6R9XIpr006626
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/3] cooker: send event when terminated by disk monitor
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
X-List-Received-Date: Fri, 27 Jul 2012 09:44:53 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B407=E6=9C=8826=E6=97=A5 18:32, Richard Purdie wrote:
> On Thu, 2012-07-26 at 17:39 +0800, Kang Kai wrote:
>> Part of [Yocto #2168]
>>
>> Add a event DiskFull to descript the termination by disk monitor.
>>
>> According to the return info from function diskMonitor.check, runqueue
>> pass it to cooker. The cooker check the info and send event DiskFull
>> when runqueue terminated by disk monitor.
>>
>> The UIs could get the infomation from the event DiskFull.
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
>>   bitbake/lib/bb/event.py    |    8 ++++++++
>>   bitbake/lib/bb/runqueue.py |    9 +++++----
>>   3 files changed, 25 insertions(+), 6 deletions(-)

Hi Richard,

> This is good and heading the right way but why can't self.dm.check fire
> the event itself? This appears to unnecessarily complicate code...
Thank you.
I have send the Version 3.

Regards,
Kai
>
> Cheers,
>
> Richard
>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 5d01af3..d8341b9 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -1095,7 +1095,7 @@ class BBCooker:
>>                   rq.finish_runqueue(False)
>>               failures =3D 0
>>               try:
>> -                retval =3D rq.execute_runqueue()
>> +                retval, dmdata =3D rq.execute_runqueue()
>>               except runqueue.TaskFailure as exc:
>>                   failures +=3D len(exc.args)
>>                   retval =3D False
>> @@ -1103,6 +1103,11 @@ class BBCooker:
>>                   self.command.finishAsyncCommand()
>>                   return False
>>
>> +            if 'terminated' in dmdata and dmdata['terminated']:
>> +                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata=
['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.=
event_data)
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
>> +                retval, dmdata =3D rq.execute_runqueue()
>>               except runqueue.TaskFailure as exc:
>>                   failures +=3D len(exc.args)
>>                   retval =3D False
>> @@ -1143,6 +1148,11 @@ class BBCooker:
>>                   self.command.finishAsyncCommand()
>>                   return False
>>
>> +            if 'terminated' in dmdata and dmdata['terminated']:
>> +                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata=
['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.=
event_data)
>> +                self.command.finishAsyncCommand()
>> +                return False
>> +
>>               if not retval:
>>                   bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.=
runq_fnid), buildname, targets, failures), self.configuration.data)
>>                   self.command.finishAsyncCommand()
>> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
>> index 1116c0a..20923b5 100644
>> --- a/bitbake/lib/bb/event.py
>> +++ b/bitbake/lib/bb/event.py
>> @@ -312,6 +312,14 @@ class BuildCompleted(BuildBase, OperationComplete=
d):
>>               OperationCompleted.__init__(self, total, "Building Faile=
d")
>>           BuildBase.__init__(self, n, p, failures)
>>
>> +class DiskFull(Event):
>> +    """Disk full case build aborted"""
>> +    def __init__(self, dev, type, freespace, mountpoint):
>> +        Event.__init__(self)
>> +        self._dev =3D dev
>> +        self._type =3D type
>> +        self._free =3D freespace
>> +        self._mountpoint =3D mountpoint
>>
>>   class NoProvider(Event):
>>       """No Provider for an Event"""
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 0a8c723..233e6a9 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -867,6 +867,7 @@ class RunQueue:
>>           """
>>
>>           retval =3D 0.5
>> +        dmdata =3D {}
>>
>>           if self.state is runQueuePrepare:
>>               self.rqexe =3D RunQueueExecuteDummy(self)
>> @@ -882,7 +883,7 @@ class RunQueue:
>>                   self.rqexe =3D RunQueueExecuteScenequeue(self)
>>
>>           if self.state in [runQueueSceneRun, runQueueRunning, runQueu=
eCleanUp]:
>> -            self.dm.check(self)
>> +            dmdata =3D self.dm.check(self)
>>
>>           if self.state is runQueueSceneRun:
>>               retval =3D self.rqexe.execute()
>> @@ -914,14 +915,14 @@ class RunQueue:
>>
>>           if self.state is runQueueComplete:
>>               # All done
>> -            return False
>> +            return False, dmdata
>>
>>           if self.state is runQueueChildProcess:
>>               print("Child process, eeek, shouldn't happen!")
>> -            return False
>> +            return False, dmdata
>>
>>           # Loop
>> -        return retval
>> +        return retval, dmdata
>>
>>       def finish_runqueue(self, now =3D False):
>>           if not self.rqexe:
>
>



