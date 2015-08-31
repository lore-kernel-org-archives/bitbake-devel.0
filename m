Return-Path: <benjamin.esquivel@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 6E88D76B7C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Sep 2015 17:25:15 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 01 Sep 2015 10:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,450,1437462000"; d="scan'208";a="553188823"
Received: from besquive-mobl2.zpn.intel.com ([10.219.17.159])
	by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2015 10:25:14 -0700
Message-ID: <1441064109.3828.5.camel@linux.intel.com>
From: Benjamin Esquivel <benjamin.esquivel@linux.intel.com>
To: Alex Franco <alejandro.franco@linux.intel.com>, 
	bitbake-devel@lists.openembedded.org
In-Reply-To: <1441041701-27060-1-git-send-email-alejandro.franco@linux.intel.com>
References: <1441041701-27060-1-git-send-email-alejandro.franco@linux.intel.com>
Organization: Intel Corporation
Date: Mon, 31 Aug 2015 18:35:09 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.16.5 (3.16.5-1.fc22) 
Subject: Re: [PATCH] Allow bitbake commands starting with do_
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: benjamin.esquivel@linux.intel.com
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 01 Sep 2015 17:25:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I like this version from the 3 you sent today :) See comment below

On Mon, 2015-08-31 at 12:21 -0500, Alex Franco wrote:
> The output of "bitbake, -c listtasks pkg" lists tasks with their real
> names
> (starting with "do_"), but then "bitbake -c do_task" fails, as "do_"
> always
> gets unconditionally prepended to task names. This patch handles this
> error
> by always removing "do_" from the beginning of task names when the
> runqueue
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
> index 0f99e5a..4a0f01a 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -634,6 +634,10 @@ class RunQueueData:
>  
>              fnid = taskData.build_targets[targetid][0]
>              fn = taskData.fn_index[fnid]
> +
imports at this point sometimes get messy, would be good if it was at
least at the beginning of the function.
> +            import re
> +            target[1] = re.sub("^do_", "", target[1])
> +
>              self.target_pairs.append((fn, target[1]))
>  
>              if fnid in taskData.failed_fnids:

