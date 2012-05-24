Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SXTZm-0006Y1-WA
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 10:39:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4O8T4QB001016
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 24 May 2012 01:29:04 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Thu, 24 May 2012 01:29:03 -0700
Message-ID: <4FBDF165.5060201@windriver.com>
Date: Thu, 24 May 2012 16:29:25 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1337764882.git.kai.kang@windriver.com>
	<dac2367a09e77d0230e8c2e625484336533ea50e.1337764882.git.kai.kang@windriver.com>
	<CABcZAN=Rs1HC6dTKOvU4r2cuO04m10f1-hoNtRfox_xgVhbsxg@mail.gmail.com>
In-Reply-To: <CABcZAN=Rs1HC6dTKOvU4r2cuO04m10f1-hoNtRfox_xgVhbsxg@mail.gmail.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q4O8T4QB001016
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] cooker.py: terminate the Parser processes
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
X-List-Received-Date: Thu, 24 May 2012 08:39:19 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B405=E6=9C=8823=E6=97=A5 23:34, Chris Larson wrote:
> terminate()'ing processes can corrupt any queues those processes have
> open, and thereby disrupt any pending log messages in the queues
> heading to the ui as a result. If that's not an issue here, so be it,
> but be aware of the issues -- we had to remove terminate() from the
> shutdown in the past due to this issue.
Hi Chris,

Call terminate() directly seems not be elegant. But I didn't figure out=20
why after the queue belongs to Parse process
calls  cancel_join_thread(), so ..
Before the terminate() the every Parse process, it is waited for 0.1=20
second to quit.
If the process will not be blocked, I suppose that 0.1 second is enough=20
for them to quit.

What's your opinion?

Thanks,
Kai
>
> On Wed, May 23, 2012 at 2:40 AM, Kang Kai<kai.kang@windriver.com>  wrot=
e:
>> [Yocto 2142]
>>
>> Force to exit HOB when hob is parsing recipes, the bitbake doesn't sto=
p.
>> It hangs on function BitBakeServerConnection::terminate in file
>> server/process.py:
>>     else:
>>         self.procserver.join()
>> It is waiting for the children process quit.
>>
>> In stage of parse recipes BBCooker spawns Parser processes as many as
>> cpu numbers. When quit the Parser processes they make their internal
>> Queue to call cancel_join_thread() to avoid block but don't work at
>> this time.
>> So force to terminate the Parser processes.
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   bitbake/lib/bb/cooker.py |    9 ++++++---
>>   1 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index dea0aad..4a4dc38 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -1175,7 +1175,7 @@ class BBCooker:
>>              return
>>
>>          if self.state in (state.shutdown, state.stop):
>> -            self.parser.shutdown(clean=3DFalse)
>> +            self.parser.shutdown(clean=3DFalse, force =3D True)
>>              sys.exit(1)
>>
>>          if self.state !=3D state.parsing:
>> @@ -1608,10 +1608,13 @@ class CookerParser(object):
>>                  self.parser_quit.put(None)
>>
>>              self.jobs.cancel_join_thread()
>> -            sys.exit(1)
>>
>>          for process in self.processes:
>> -            process.join()
>> +            if force:
>> +                process.join(.1)
>> +                process.terminate()
>> +            else:
>> +                process.join()
>>          self.feeder.join()
>>
>>          sync =3D threading.Thread(target=3Dself.bb_cache.sync)
>> --
>> 1.7.5.4
>>
>>
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>
>



