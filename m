Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55BC433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Jul 2022 09:48:45 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.20237.1657705711717842773
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Jul 2022 02:48:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=L56X8Kwu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6E292E0004;
	Wed, 13 Jul 2022 09:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1657705709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpeJ4Xe0RHUh9VgMpnvOZL6QSPHi954cE/yQ5yw3zZw=;
	b=L56X8KwuVMyaO9AE+dMWwfP/K0XiFD3uhVV5PxLVe+X62v/f+Isrk2S8dQvZW9TUgo6YFz
	RnIpKFiMy7a2XUNZJDzPk8p3jD101DEdi5in0CW2gAz54F5PFNgYJuOMhs+LsLFwmqd4Sx
	LKnO9vmpt1JE+UlZWMlvfujJ1PRzVrmXv2SF+PDChX4JFuWZhHrBUWrVWU9UWL1CsM5RQN
	7EP7620D0WyL4/3Cq3vk11zDvdik8a24jyQQKpldKtKCEvZYwy55EuH4vL+SnPiKfqC1Q5
	EXMa0BFeT00vXjKRI+CVsH9HWBDgn0BLQtqCuZSRZwv6in5i0kXpB7JIp5ye6A==
Date: Wed, 13 Jul 2022 11:48:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paulo Neves <ptsneves@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
Message-ID: <Ys6U7V+xOe7/2Pso@mail.local>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708205407.1680137-2-ptsneves@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Jul 2022 09:48:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13822

Hello,

I believe this is the cause of the following failure:

2022-07-13 08:32:51,511 - oe-selftest - INFO - bbtests.BitbakeTests.test_invalid_recipe_src_uri (subunit.RemotedTestCase)
2022-07-13 08:32:51,512 - oe-selftest - INFO -  ... FAIL
2022-07-13 08:32:51,512 - oe-selftest - INFO - 3: 18/58 119/493 (3.15s) (bbtests.BitbakeTests.test_invalid_recipe_src_uri)
2022-07-13 08:32:51,512 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/selftest/cases/bbtests.py", line 148, in test_invalid_recipe_src_uri
    bitbake('-ccleanall man-db')
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/utils/commands.py", line 229, in bitbake
    return runCmd(cmd, ignore_status, timeout, output_log=output_log, **options)
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/utils/commands.py", line 207, in runCmd
    raise AssertionError("Command '%s' returned non-zero exit status %d:\n%s" % (command, result.status, exc_output))
AssertionError: Command 'bitbake  -ccleanall man-db' returned non-zero exit status 1:
/usr/lib64/python3.6/importlib/_bootstrap.py:219: ImportWarning: can't resolve package from __spec__ or __package__, falling back on __name__ and __path__
  return f(*args, **kwds)
NOTE: Reconnecting to bitbake server...
Loading cache...done.
Loaded 1718 entries from dependency cache.
Parsing recipes...ERROR: /home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/recipes-extended/man-db/man-db_2.10.2.bb: Unable to get checksum for man-db SRC_URI entry invalid: file could not be found
ERROR: Parsing halted due to errors, see error messages above

I guess you have to update
bbtests.BitbakeTests.test_invalid_recipe_src_uri too

On 08/07/2022 22:54:07+0200, Paulo Neves wrote:
> If the local fetcher was not able to find the file anywhere but it
> was included in the SRC_URI for checksumming just make it a fatal
> error.
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  lib/bb/tests/fetch.py     | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5f05278a..8184b55e 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
>                              " This means there is no way to get the file except for an orphaned copy"
>                              " in DL_DIR.") % (d.getVar('PN'), os.path.basename(f)))
>                      else:
> -                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
> +                        bb.fatal("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
>                  filelist.append(f + ":" + str(os.path.exists(f)))
>  
>      return " ".join(filelist)
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 3ebd9fd7..5b577b06 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -700,6 +700,11 @@ class FetcherLocalTest(FetcherTest):
>          with self.assertRaises(bb.BBHandledException):
>              bb.fetch.get_checksum_file_list(self.d)
>  
> +    def test_local_checksum_fails_no_file(self):
> +        self.d.setVar("SRC_URI", "file://404")
> +        with self.assertRaises(bb.BBHandledException):
> +            bb.fetch.get_checksum_file_list(self.d)
> +
>      def test_local(self):
>          tree = self.fetchUnpack(['file://a', 'file://dir/c'])
>          self.assertEqual(tree, ['a', 'dir/c'])
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13813): https://lists.openembedded.org/g/bitbake-devel/message/13813
> Mute This Topic: https://lists.openembedded.org/mt/92260795/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

