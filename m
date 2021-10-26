Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4119C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 23:24:23 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web09.4512.1635290658830790967
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 16:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B69841BF206;
	Tue, 26 Oct 2021 23:24:15 +0000 (UTC)
Date: Wed, 27 Oct 2021 01:24:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3] fetch2: make sure the uri added as
 expected
Message-ID: <YXiOH15WmkbpUaO1@piout.net>
References: <168714731971476B.24733@lists.openembedded.org>
 <20210913054810.30554-1-mingli.yu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054810.30554-1-mingli.yu@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 23:24:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12839

Hello,

I'm sorry, it took me a while to properly test this patch but I'm pretty
sure it is the cause of:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2773/steps/11/logs/stdio

On 13/09/2021 13:48:10+0800, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> When call uri_replace to get the new uris, we should guarantee the
> new uri is added when the replace uri begins with file if the find
> uri begin with wildcard which mapped as below.
> PREMIRRORS_append = " \
>      .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "    |           |
>      |           |
>      |           |
>      find        replace
> 
> Before the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>      .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is git://somewhere.org/somedir/github.com.tianocore.edk2.git/git2_github.com.tianocore.edk2.git.tar.gz;protocol=http
> 
> After the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>      .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is None as the find begins with wildcard but the replace
> doesn't begin with file.
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 ++
>  lib/bb/tests/fetch.py     | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index d9e1599a..1c5242c7 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>      uri_replace_decoded = list(decodeurl(uri_replace))
>      logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>      result_decoded = ['', '', '', '', '', {}]
> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
> +        uri_find_decoded[0] = uri_replace_decoded[0]
>      for loc, i in enumerate(uri_find_decoded):
>          result_decoded[loc] = uri_decoded[loc]
>          regexp = i
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 242be368..25893a34 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -406,6 +406,8 @@ class MirrorUriTest(FetcherTest):
>              : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
>          ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
>              : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
> +        ("gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https", ".*://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
> +            : None,
>          ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache") 
>              : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
>          ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/") 
> @@ -447,7 +449,11 @@ class MirrorUriTest(FetcherTest):
>              ud.setup_localpath(self.d)
>              mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
>              newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
> -            self.assertEqual([v], newuris)
> +            if not v:
> +                 self.assertEqual([v], newuris)
> +            else:
> +                 self.assertEqual([], newuris)
> +
>  
>      def test_urilist1(self):
>          fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
> -- 
> 2.32.0
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12637): https://lists.openembedded.org/g/bitbake-devel/message/12637
> Mute This Topic: https://lists.openembedded.org/mt/85568847/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

