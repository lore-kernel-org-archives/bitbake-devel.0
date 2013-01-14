Received: from relay1.mentorg.com ([192.94.38.131])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Andrew_Stubbs@mentor.com>) id 1TuktH-00089T-4X
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 15:19:59 +0100
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp 
	id 1TukeR-0005Wd-Pf from Andrew_Stubbs@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 06:04:35 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by
	svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.4675); Mon, 14 Jan 2013 06:04:35 -0800
Received: from [172.30.3.170] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
	(137.202.0.104) with Microsoft SMTP Server id 14.1.289.1;
	Mon, 14 Jan 2013 14:04:33 +0000
Message-ID: <50F4106E.8070404@codesourcery.com>
Date: Mon, 14 Jan 2013 14:04:30 +0000
From: Andrew Stubbs <ams@codesourcery.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-OriginalArrivalTime: 14 Jan 2013 14:04:35.0066 (UTC)
	FILETIME=[153C2DA0:01CDF260]
Subject: Minimal BitBake template
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
X-List-Received-Date: Mon, 14 Jan 2013 14:19:59 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm trying to evaluate use of BitBake for projects other than OE.

As part of that I've been experimenting, and trying to learn how it 
works by writing a minimalist working recipe set starting from a blank 
slate. I had hoped that, with the documentation and error/warning 
messages, I would be able to do this step-by-step through trial and 
error, and thus learn more than doing a straight cut-and-paste. This 
works up to a point, but I've now hit a dead end:

> ERROR: An uncaught exception occured in runqueue, please see the failure below:
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/opt/bitbake/lib/bb/cooker.py", line 1152, in buildTargetsIdle(server=<ProcessServer(ProcessServer-1, started)>, rq=<bb.runqueue.RunQueue instance at 0x14654d0>, abort=False):
>                  try:
>     >                retval = rq.execute_runqueue()
>                  except runqueue.TaskFailure as exc:
>   File "/opt/bitbake/lib/bb/runqueue.py", line 934, in RunQueue.execute_runqueue():
>              try:
>     >            return self._execute_runqueue()
>              except bb.runqueue.TaskFailure:
>   File "/opt/bitbake/lib/bb/runqueue.py", line 901, in RunQueue._execute_runqueue():
>              if self.state is runQueueRunning:
>     >            retval = self.rqexe.execute()
>
>   File "/opt/bitbake/lib/bb/runqueue.py", line 1365, in RunQueueExecuteTasks.execute():
>
>     >            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
>                      logger.debug(2, "Stamp current task %s (%s)", task,
>   File "/opt/bitbake/lib/bb/runqueue.py", line 821, in RunQueue.check_stamp_task(task=0, taskname='do_build', recurse=False, cache={}):
>              # If the stamp is missing its not current
>     >        if not os.access(stampfile, os.F_OK):
>                  logger.debug(2, "Stampfile %s not available", stampfile)
> TypeError: coercing to Unicode: need string or buffer, NoneType found

Apparently BitBake has some kind of internal assumption about what the 
recipes/classes will look like that it doesn't explicitly check, and I 
haven't satisfied, somehow? Googling around suggests that the problem 
might be related to loops in the dependency chain, or something, but my 
recipe only has one task.

Essentially, I have three files:

conf/bitbake.conf
---8<--------------->8---
BBFILES = "*.bb"
CACHE = "/tmp/bbcache"
---8<--------------->8---

classes/base.bbclass
---8<--------------->8---
addtask build

do_build () {
	:
}
---8<--------------->8---

hello.bb
---8<--------------->8---
PROVIDES="hello"

do_build () {
	echo "Hello, World!"
}
---8<--------------->8---

I then invoke "env BBPATH=$PWD bitbake hello" and get the above exception.

Clearly, I'm missing something crucial, but what? Can you help me figure 
out what the minimal "hello world" recipe might look like?

Thanks in advance

Andrew

P.S. I will probably end up using something based on a copy of the OE 
base-class, given there's no point in reinventing the wheel, but I'd 
like to understand how these things work from first-principles first.


