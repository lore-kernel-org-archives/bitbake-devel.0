Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B563271C42
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Feb 2018 10:44:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1SAi3hf027247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 28 Feb 2018 10:44:04 GMT
Message-ID: <1519814643.24236.418.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, Paul Barker <pbarker@toganlabs.com>
Date: Wed, 28 Feb 2018 10:44:03 +0000
In-Reply-To: <1519768112-25072-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1519768112-25072-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] runqueue: Ensure only recursive task dependencies are pruned
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
X-List-Received-Date: Wed, 28 Feb 2018 10:44:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-02-27 at 21:48 +0000, Richard Purdie wrote:
> If a standalone tasks adds a dependency on X:do_build, the code in
> runqueue would
> currently remove it if that do_build was part of an image recipe
> which uses
> recrdeptask on do_build.
> 
> Such individual tasks shouldn't do this, therefore tweak the
> recursive reference code
> to only process recurseive tasks, not all tasks.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 48df013..f2e52cf 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -765,7 +765,7 @@ class RunQueueData:
>              bb.debug(1, "Added %s recursive dependencies in this
> loop" % extradeps)
>  
>          # Remove recrdeptask circular references so that
> do_a[recrdeptask] = "do_a do_b" can work
> -        for tid in self.runtaskentries:
> +        for tid in recursivetasksselfref:
>              self.runtaskentries[tid].depends.difference_update(recur
> sivetasksselfref)
>  
>          self.init_progress_reporter.next_stage()

We have a problem with this patch since it causes:

$ oe-selftest -r sstatetests.SStateTests.test_sstate_sametune_samesigs
2018-02-28 10:33:56,968 - oe-selftest - INFO - Adding layer libraries:
2018-02-28 10:33:56,968 - oe-selftest - INFO - 	/media/build1/poky/meta/lib
2018-02-28 10:33:56,969 - oe-selftest - INFO - 	/media/build1/poky/meta-yocto-bsp/lib
2018-02-28 10:33:56,969 - oe-selftest - INFO - 	/media/build1/poky/meta-selftest/lib
2018-02-28 10:33:56,969 - oe-selftest - INFO - Running bitbake -p
2018-02-28 10:34:02,651 - oe-selftest - INFO - Adding: "include selftest.inc" in /media/build1/poky/build/conf/local.conf
2018-02-28 10:34:02,652 - oe-selftest - INFO - test_sstate_sametune_samesigs (sstatetests.SStateTests)
2018-02-28 10:36:13,404 - oe-selftest - INFO -  ... FAIL
2018-02-28 10:36:13,406 - oe-selftest - INFO - ======================================================================
2018-02-28 10:36:13,406 - oe-selftest - INFO - FAIL: test_sstate_sametune_samesigs (sstatetests.SStateTests)
2018-02-28 10:36:13,406 - oe-selftest - INFO - ----------------------------------------------------------------------
2018-02-28 10:36:13,406 - oe-selftest - INFO - Traceback (most recent call last):
  File "/media/build1/poky/meta/lib/oeqa/core/decorator/__init__.py", line 32, in wrapped_f
    return func(*args, **kwargs)
  File "/media/build1/poky/meta/lib/oeqa/selftest/cases/sstatetests.py", line 449, in test_sstate_sametune_samesigs
    self.assertCountEqual(files1, files2)
AssertionError: Element counts were not equal:
First has 1, Second has 0:  '/media/build1/poky/build/tmp-sstatesamehash/stamps/i586-poky-linux/meta-world-pkgdata/1.0-r0.do_allpackagedata.sigdata.d002ff3e63a32eb99a2cec0db32958ea'
First has 1, Second has 0:  '/media/build1/poky/build/tmp-sstatesamehash/stamps/x86-pokymllib32-linux/lib32-meta-world-pkgdata/1.0-r0.do_allpackagedata.sigdata.3408a479c43dc528f7087d1f49d048a1'
First has 0, Second has 1:  '/media/build1/poky/build/tmp-sstatesamehash/stamps/i586-poky-linux/meta-world-pkgdata/1.0-r0.do_allpackagedata.sigdata.870804331fb653c926de0e5837f4634a'
First has 0, Second has 1:  '/media/build1/poky/build/tmp-sstatesamehash/stamps/x86-pokymllib32-linux/lib32-meta-world-pkgdata/1.0-r0.do_allpackagedata.sigdata.e99b43d58e820c369e8d7e717bac41a2'

Cheers,

Richard


