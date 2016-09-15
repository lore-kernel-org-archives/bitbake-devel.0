Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9C44973695
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 08:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8F83RdN000409; Thu, 15 Sep 2016 09:03:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bMcy7RKra1td; Thu, 15 Sep 2016 09:03:27 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8F83Oil000405
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Sep 2016 09:03:26 +0100
Message-ID: <1473926604.7207.71.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 09:03:24 +0100
In-Reply-To: <1473432540-22120-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1473432540-22120-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH] cooker: check if target contains task
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
X-List-Received-Date: Thu, 15 Sep 2016 08:03:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-09-09 at 17:49 +0300, Ed Bartosh wrote:
> Task name was incorrectly added to the targets that already
> contained :task suffix and fired with BuildInit event. This
> caused Toaster to create incorrect Target objects and show
> them in UI.
> 
> [YOCTO #10221]
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/cooker.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index b7d7a7e..2952f9e 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1421,7 +1421,8 @@ class BBCooker:
>          if not task.startswith("do_"):
>              task = "do_%s" % task
>  
> -        packages = ["%s:%s" % (target, task) for target in targets]
> +        packages = [target if ':' in target else '%s:%s' (target,
> task) for target in targets]
> +
>          bb.event.fire(bb.event.BuildInit(packages),
> self.expanded_data)
>  
>          taskdata, runlist = self.buildTaskData(targets, task,
> self.configuration.abort)

I put this into a build without looking too closely, the result was
near enough everything failed with failures like:

http://autobuilder.yocto.io:8010/builders/buildtools/builds/37

Cheers,

Richard

