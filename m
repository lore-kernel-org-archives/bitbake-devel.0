Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6C3DA74197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 20:16:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t7VKGlrT024303
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 31 Aug 2015 13:16:47 -0700 (PDT)
Received: from Marks-MacBook-Pro-2.local (172.25.36.228) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.235.1; Mon, 31 Aug 2015 13:16:47 -0700
To: Alex Franco <alejandro.franco@linux.intel.com>,
	<bitbake-devel@lists.openembedded.org>
References: <1441051232-30028-1-git-send-email-alejandro.franco@linux.intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <55E4B62E.7070400@windriver.com>
Date: Mon, 31 Aug 2015 15:16:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
	Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1441051232-30028-1-git-send-email-alejandro.franco@linux.intel.com>
Cc: david.nystrom@enea.com, clarson@kergoth.com
Subject: Re: [PATCH] Allow bitbake commands starting with do_ v2
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
X-List-Received-Date: Mon, 31 Aug 2015 20:16:57 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 8/31/15 3:00 PM, Alex Franco wrote:
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
> index 0f99e5a..834992f 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -634,6 +634,10 @@ class RunQueueData:
>  
>              fnid = taskData.build_targets[targetid][0]
>              fn = taskData.fn_index[fnid]
> +
> +            if target[1].startswith("do_"):
> +                target[1] = target[1].replace("do_", "", 1)
> +

not sure if it's faster and/or more obvious...

target[1] = target[1][3:]

(since we know the first three characters are 'do_' since we did a 'startswith'...)

--Mark

>              self.target_pairs.append((fn, target[1]))
>  
>              if fnid in taskData.failed_fnids:
> 


