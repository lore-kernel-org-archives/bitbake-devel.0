Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1QZRby-0000If-LS
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 19:53:11 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p5MHnZuE000365
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2011 10:49:35 -0700 (PDT)
Received: from Macintosh-5.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 22 Jun 2011 10:49:35 -0700
Message-ID: <4E022B2E.7080505@windriver.com>
Date: Wed, 22 Jun 2011 12:49:34 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
	rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 22 Jun 2011 17:53:11 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

I just noticed I left in some debug below..

The line:

 logger.warning("Using umask 0%o %s, %s" % (umask, fn, taskname))

should be either commented out or removed.  I'd be happy to re-send the pull
request if this is easier.

--Mark

On 6/22/11 12:57 PM, Mark Hatle wrote:
> The umask for a task can now be set as:
> 
> task[umask] = 022
> task[umask] = '022'
> 
> If specified as a text string, it must be octal.  (This is due to
> recipe parsing where it's always set to a string.)
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/build.py    |    1 +
>  lib/bb/runqueue.py |   12 ++++++++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 15ba956..4bbf10f 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -465,6 +465,7 @@ def add_tasks(tasklist, d):
>          getTask('nostamp')
>          getTask('fakeroot')
>          getTask('noexec')
> +        getTask('umask')
>          task_deps['parents'][task] = []
>          for dep in flags['deps']:
>              dep = data.expand(dep, d)
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 1f3b54c..e455893 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1063,8 +1063,17 @@ class RunQueueExecute:
>          # a fork() or exec*() activates PSEUDO...
>  
>          envbackup = {}
> +        umask = -1
>  
>          taskdep = self.rqdata.dataCache.task_deps[fn]
> +        if 'umask' in taskdep and taskname in taskdep['umask']:
> +            # umask might come in as a number or text string..
> +            try:
> +                 umask = int(taskdep['umask'][taskname],8)
> +            except TypeError:
> +                 umask = taskdep['umask'][taskname]
> +            logger.warning("Using umask 0%o %s, %s" % (umask, fn, taskname))
> +
>          if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
>              envvars = (self.rqdata.dataCache.fakerootenv[fn] or "").split()
>              for key, value in (var.split('=') for var in envvars):
> @@ -1103,6 +1112,9 @@ class RunQueueExecute:
>              newsi = os.open(os.devnull, os.O_RDWR)
>              os.dup2(newsi, sys.stdin.fileno())
>  
> +            if umask != -1:
> +                os.umask(umask)
> +
>              bb.data.setVar("BB_WORKERCONTEXT", "1", self.cooker.configuration.data)
>              bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self, self.cooker.configuration.data)
>              bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn, self.cooker.configuration.data)



