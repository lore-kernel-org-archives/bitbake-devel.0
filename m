Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QZtNq-0000NO-KB
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Jun 2011 01:32:26 +0200
Received: by pvf24 with SMTP id 24so1531690pvf.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2011 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=YonWQZnXTgp15LHCCag5K87Is3kEyb8zU1qAweJHtoU=;
	b=huiALbaEU1CqEdBbBG9Wkhjk+bBxkwUgijfu790E73j3EIDBz7KhXI4VfHcSn4DRCx
	CLidsZq/DqivUkczX3h+AZEVv19POAkGme0DtGPhZnFVyHRMiCwMZj05Ym9uERFyh2ml
	J5V5CGykN7RQADdMvtDK6D0R/Wb/kayqgwipc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	b=MyA/xMOYaaA5wZHlD5whzlYJ5EU7F7Ue9NspgqtN7Nc7tqJHlUdaKKYrKkgd0JNekM
	CyVsLSifsqGOhNjobG6k+IgnYpZU8xhNObzckAQIUUVZd24SNdLxsQRdH/zvJ8YT5k8V
	BZZ+9iYQ95QZ4w6S61Em9cFxKrWhwl8o1Z3go=
Received: by 10.143.40.10 with SMTP id s10mr529058wfj.302.1308871352735;
	Thu, 23 Jun 2011 16:22:32 -0700 (PDT)
Received: from [192.168.1.75] (99-57-141-118.lightspeed.sntcca.sbcglobal.net
	[99.57.141.118])
	by mx.google.com with ESMTPS id x8sm1439359wfx.19.2011.06.23.16.22.31
	(version=SSLv3 cipher=OTHER); Thu, 23 Jun 2011 16:22:32 -0700 (PDT)
Message-ID: <4E03CAB7.6030602@gmail.com>
Date: Thu, 23 Jun 2011 16:22:31 -0700
From: Khem Raj <raj.khem@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1308765394.git.mark.hatle@windriver.com>
	<69acceaeb4816d1f62db445909936324a3adba9c.1308765394.git.mark.hatle@windriver.com>
In-Reply-To: <69acceaeb4816d1f62db445909936324a3adba9c.1308765394.git.mark.hatle@windriver.com>
Subject: Re: [PATCH 1/1] runqueue.py: Add umask task control
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
X-List-Received-Date: Thu, 23 Jun 2011 23:32:26 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/22/2011 10:57 AM, Mark Hatle wrote:
> The umask for a task can now be set as:
>
> task[umask] = 022
> task[umask] = '022'
>
> If specified as a text string, it must be octal.  (This is due to
> recipe parsing where it's always set to a string.)
>
> Signed-off-by: Mark Hatle<mark.hatle@windriver.com>
> ---
>   lib/bb/build.py    |    1 +
>   lib/bb/runqueue.py |   12 ++++++++++++
>   2 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 15ba956..4bbf10f 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -465,6 +465,7 @@ def add_tasks(tasklist, d):
>           getTask('nostamp')
>           getTask('fakeroot')
>           getTask('noexec')
> +        getTask('umask')
>           task_deps['parents'][task] = []
>           for dep in flags['deps']:
>               dep = data.expand(dep, d)
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 1f3b54c..e455893 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1063,8 +1063,17 @@ class RunQueueExecute:
>           # a fork() or exec*() activates PSEUDO...
>
>           envbackup = {}
> +        umask = -1
>
>           taskdep = self.rqdata.dataCache.task_deps[fn]
> +        if 'umask' in taskdep and taskname in taskdep['umask']:
> +            # umask might come in as a number or text string..
> +            try:
> +                 umask = int(taskdep['umask'][taskname],8)
> +            except TypeError:
> +                 umask = taskdep['umask'][taskname]
> +            logger.warning("Using umask 0%o %s, %s" % (umask, fn, taskname))
> +

this will be annoying. It should be made part of verbose messages though


>           if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
>               envvars = (self.rqdata.dataCache.fakerootenv[fn] or "").split()
>               for key, value in (var.split('=') for var in envvars):
> @@ -1103,6 +1112,9 @@ class RunQueueExecute:
>               newsi = os.open(os.devnull, os.O_RDWR)
>               os.dup2(newsi, sys.stdin.fileno())
>
> +            if umask != -1:
> +                os.umask(umask)
> +
>               bb.data.setVar("BB_WORKERCONTEXT", "1", self.cooker.configuration.data)
>               bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self, self.cooker.configuration.data)
>               bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn, self.cooker.configuration.data)



