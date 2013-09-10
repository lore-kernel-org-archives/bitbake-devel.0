Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A37C0614F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2013 14:02:14 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8AEFbMo022535; Tue, 10 Sep 2013 15:15:38 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CsJLHg8QQ_z1; Tue, 10 Sep 2013 15:15:37 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8AEFWcT022532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 10 Sep 2013 15:15:34 +0100
Message-ID: <1378821709.3484.156.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Tue, 10 Sep 2013 15:01:49 +0100
In-Reply-To: <4509f2ed87581c11ff26c10586f37516b4766503.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
	<4509f2ed87581c11ff26c10586f37516b4766503.1378743829.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 06/13] bitbake: build: add link to logfile for Task events
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
X-List-Received-Date: Tue, 10 Sep 2013 14:02:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-09 at 17:40 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> We add a pointer to the logfile for Task events, so
> that we can trace that in the Bitbake database
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/build.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 1265bdc..4abbe48 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -73,6 +73,7 @@ class TaskBase(event.Event):
>          self._task = t
>          self._package = d.getVar("PF", True)
>          self._file = d.getVar("FILE", True)
> +        self.logfile = d.getVar("BB_LOGFILE", True)
>          self.taskfile = self._file
>          self.taskname = self._task
>          event.Event.__init__(self)

This leaves the TaskFailed() events still manually passing in logfile as
a separate parameter. I think we might as well adjust the code to always
pass the logfile to the events instead of this, mainly as it makes it
explictly clear where and when the logfile is uses. BB_LOGFILE is really
meant more for external usage than for bitbake itself.

Cheers,

Richard


