Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 48AE076B7C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Sep 2015 21:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t81LiZjV017352; Tue, 1 Sep 2015 22:44:35 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yQUYOv8IoMmn; Tue,  1 Sep 2015 22:44:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t81LiMTd017345
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 1 Sep 2015 22:44:34 +0100
Message-ID: <1441143862.24871.24.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Franco <alejandro.franco@linux.intel.com>
Date: Tue, 01 Sep 2015 22:44:22 +0100
In-Reply-To: <1441054569-1661-2-git-send-email-alejandro.franco@linux.intel.com>
References: <1441054569-1661-1-git-send-email-alejandro.franco@linux.intel.com>
	<1441054569-1661-2-git-send-email-alejandro.franco@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: david.nystrom@enea.com, clarson@kergoth.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCHv3 1/1] Allow bitbake commands starting with do_
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
X-List-Received-Date: Tue, 01 Sep 2015 21:44:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-08-31 at 15:56 -0500, Alex Franco wrote:
> The output of "bitbake, -c listtasks pkg" lists tasks with their real names
> (starting with "do_"), but then "bitbake -c do_task" fails, as "do_" always
> gets unconditionally prepended to task names. This patch handles this error
> by always removing "do_" from the beginning of task names when the runqueue
> is being constructed.
> 
> [YOCTO #7818]
> 
> Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0f99e5a..7b25e31 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -634,6 +634,10 @@ class RunQueueData:
>  
>              fnid = taskData.build_targets[targetid][0]
>              fn = taskData.fn_index[fnid]
> +
> +            if target[1].startswith("do_"):
> +                target[1] = target[1][3:]
> +
>              self.target_pairs.append((fn, target[1]))
>  
>              if fnid in taskData.failed_fnids:

I tried this on the autobuilder and we saw cascades of failures, e.g:

https://autobuilder.yoctoproject.org/main/builders/build-appliance/builds/468/steps/BuildImages/logs/stdio 

so clearly we need more thought on this. I prefer the .startswith over
the regex as in general its much faster code than loading the re engine.

Cheers,

Richard


