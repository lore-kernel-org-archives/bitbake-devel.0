Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S5KaV-0007pb-LC
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Mar 2012 18:23:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id B602E3159DD9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Mar 2012 18:15:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ZOPwvDsqUhTl for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Mar 2012 18:14:58 +0100 (CET)
Received: from [172.22.22.61] (drms-590ec29b.pool.mediaWays.net
	[89.14.194.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id D6C233159D98
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Mar 2012 18:14:57 +0100 (CET)
Message-ID: <4F579790.7020806@opendreambox.org>
Date: Wed, 07 Mar 2012 18:14:56 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: bitbake multi-processing semaphore in linux-vserver
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
X-List-Received-Date: Wed, 07 Mar 2012 17:23:43 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I tried to run today's BitBake master on Debian Squeeze,
running inside a Linux-Vserver. I ran into the problem below:

Traceback (most recent call last):
  File ".../bitbake/bin/bitbake", line 258, in <module>
    ret = main()
  File ".../bitbake/bin/bitbake", line 226, in main
    server.initServer()
  File ".../bitbake/lib/bb/server/process.py", line 245, in initServer
    self.event_queue = ProcessEventQueue(0)
  File "/usr/lib/python2.6/multiprocessing/queues.py", line 37, in __init__
    self._rlock = Lock()
  File "/usr/lib/python2.6/multiprocessing/synchronize.py", line 117, in __init__
    SemLock.__init__(self, SEMAPHORE, 1, 1)
OSError: [Errno 38] Function not implemented

Has anybody else seen this? Is it likely to be caused by limitations
of Linux-Vserver? Are there any workarounds or patches available to
address this?

Regards,
Andreas


