Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id EF0DA7F845
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2019 16:34:36 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xB5GYRUp003120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Thu, 5 Dec 2019 10:34:34 -0600
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20191205152909.30943-1-richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <a20b8e3d-8c4b-79fa-1b16-9863a7441c45@kernel.crashing.org>
Date: Thu, 5 Dec 2019 10:34:27 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205152909.30943-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Thu, 05 Dec 2019 16:34:37 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

I don't have the context of this, but the question popped into my mind.

Is there a way that the system can clear the tainted hash?   (i.e. on a memory
resident bitbake over multiple builds for instance)

Or is this not an issue, since these reset for each build, and it's only in memory?

--Mark

On 12/5/19 9:29 AM, Richard Purdie wrote:
> An example:
> 
> NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Started
> ERROR: Taskhash mismatch b074da4334aff8aa06572e7a8725c941fa6b08de4ce714a65a90c0c0b680abea versus 17375278daed609a7129769b74a1336a37bdef14b534ae85189ccc033a9f2db4 for /home/pokybuild/yocto-worker/qemux86-64/build/meta/recipes-devtools/binutils/binutils-cross-testsuite_2.32.bb:do_check
> NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Succeeded
> 
> Is caused by a rehash in a dependency happening somewhere earlier in the build
> and the taint being reset.
> 
> Change the code so that nostamp taints are preserved to avoid the issue.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/siggen.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index edf10105f9..de85326872 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -232,10 +232,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
>          taskdep = dataCache.task_deps[fn]
>          if 'nostamp' in taskdep and task in taskdep['nostamp']:
>              # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
> -            import uuid
> -            taint = str(uuid.uuid4())
> -            data = data + taint
> -            self.taints[tid] = "nostamp:" + taint
> +            if tid in self.taints and self.taints[tid].startswith("nostamp:"):
> +                # Don't reset taint value upon every call
> +                data = data + self.taints[tid][8:]
> +            else:
> +                import uuid
> +                taint = str(uuid.uuid4())
> +                data = data + taint
> +                self.taints[tid] = "nostamp:" + taint
>  
>          taint = self.read_taint(fn, task, dataCache.stamp[fn])
>          if taint:
> 

