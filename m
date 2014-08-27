Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 513DF7114F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 15:38:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7RFctIG026787
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 08:38:55 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.174.1;
	Wed, 27 Aug 2014 08:38:54 -0700
Message-ID: <53FDFB8D.7020809@windriver.com>
Date: Wed, 27 Aug 2014 23:38:53 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1409141244.5772.42.camel@ted>
In-Reply-To: <1409141244.5772.42.camel@ted>
Subject: Re: [PATCH] runqueue: Fix setscene tasks not running
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
X-List-Received-Date: Wed, 27 Aug 2014 15:39:01 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Thank you very much, I tested it again, it worked well.

// Robert

On 08/27/2014 08:07 PM, Richard Purdie wrote:
> Currently, if you have hard dependencies between setscene tasks (like avahi on
> base-passwd through useradd.bbclass), other dependencies may not be installed
> even if these exist in sstate. For example, avahi -> expat -> pigz-native
> (and avahi -> base-passwd) yet if you cleansstate base-passwd:
>
> bitbake gzip-native:do_clean avahi:do_clean expat:do_clean pigz-native:do_clean base-passwd:do_cleansstate
> bitbake avahi | tee
>
> you will currently see pigz-native being rebuilt even though it was in
> sstate. The fix for this is to continue to iterate dependency chains
> around hard blocked dependencies as per this patch.
>
> After this patch is applied, you will see pigz-native installed from sstate.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index e13dc57..e32f81a 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1844,6 +1844,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>                   realtask = self.rqdata.runq_setscene[task]
>                   realdep = self.rqdata.runq_setscene[dep]
>                   logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (self.rqdata.get_user_idstring(realtask), self.rqdata.get_user_idstring(realdep)))
> +                self.scenequeue_updatecounters(dep, fail)
> +                continue
> +            if task not in self.sq_revdeps2[dep]:
> +                # May already have been removed by the fail case above
>                   continue
>               self.sq_revdeps2[dep].remove(task)
>               if len(self.sq_revdeps2[dep]) == 0:
>
>

