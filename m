Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Se5Cl-0003qV-OZ for bitbake-devel@lists.openembedded.org;
	Mon, 11 Jun 2012 16:02:51 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5BDqIg2015336;
	Mon, 11 Jun 2012 14:52:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13603-10; Mon, 11 Jun 2012 14:52:13 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5BDq8KG015330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 14:52:09 +0100
Message-ID: <1339422729.28854.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Mon, 11 Jun 2012 14:52:09 +0100
In-Reply-To: <1339162913-23759-15-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
	<1339162913-23759-15-git-send-email-jason.wessel@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v4 14/18] runqueue.py, build.py: Invalidate setscene tasks based on do_unpack stamps
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
X-List-Received-Date: Mon, 11 Jun 2012 14:02:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-06-08 at 08:41 -0500, Jason Wessel wrote:
> If you have a fully populated sstate cache and have used it to
> execute a build, it is not possible to invalidate repackage
> an intermediate build after you have forced a compiled
> 
> Example when you have build from a complete sstate cache build:
>   bitbake core-image-sato
>   bitbake -c patch acl
>      *** Make some changes to the C files for experimentation.
>   bitbake -f -c compile acl
>   bitbake acl
> 
> The bitbake will refuse to build the acl package at this
> point and instead keep populating it from the sstate.  Using
> the cleanstate is no longer a good option because it will
> also erase the scratch area.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> ---
>  lib/bb/build.py    |    8 ++++++++
>  lib/bb/runqueue.py |   14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index fb61b00..18c28aa 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -463,6 +463,14 @@ def del_stamp(task, d, file_name = None):
>      stamp = stamp_internal(task, d, file_name)
>      bb.utils.remove(stamp)
>  
> +def exists_stamp(task, d, file_name = None):
> +    """
> +    Removes a stamp for a given task
> +    (d can be a data dict or dataCache)
> +    """
> +    stamp = stamp_internal(task, d, file_name)
> +    return os.path.exists(stamp)
> +
>  def stampfile(taskname, d, file_name = None):
>      """
>      Return the stamp for a given task
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index da3fdf9..6c802af 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -718,6 +718,20 @@ class RunQueueData:
>                      for dep in self.runq_depends[task]:
>                          procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
>                      self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
> +        try:
> +            new_setscene = []
> +            for task in self.runq_setscene:
> +                try:
> +                    fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
> +                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn):
> +                        logger.debug(2, 'Removing task %s from queue because do_unpack exists', task)
> +                    else:
> +                        new_setscene.append(task)
> +                except:
> +                    logger.debug(2, 'Failed do_unpack check for %s', task)
> +            self.runq_setscene = new_setscene
> +        except:
> +            logger.debug(2, 'Failed to update runq_setscene')

We've gone to quite a bit of trouble to keep knowledge of the specific
tasks out of bitbake. I've noticed a few of your patches are "blurring"
the separation between bitbake and the metadata.

Here, bitbake shouldn't have knowledge of "unpack" or why its special.
I'd also argue its not in fact special and there are probably other
"force" scenarios which would break with a similar problem even with
this patch. I agree there is a problem here but we need to fix it in a
more generic way. There is already a bug open on this kind of problem
(#2256).

Cheers,

Richard







