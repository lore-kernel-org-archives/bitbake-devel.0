Return-Path: <armccurdy@gmail.com>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
	[209.85.128.174])
	by mail.openembedded.org (Postfix) with ESMTP id C156D77B91
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 16:30:23 +0000 (UTC)
Received: by mail-wr0-f174.google.com with SMTP id u1so110544313wra.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=maD4OPjYyzieTLnh18CUwsgpbyjh9F4aQoSpoaGjoJU=;
	b=eoZE8D2YRtO4tHxgz9IwX5ZFWa6OZo12nIdu7W/g85z/QeDvMniiwEBj7Iak68eXjt
	brpcx6aAO6+AgDcvf5erlbeaqKbX23ptsh67/y3PtoA1oSa4RfRH1Qux/9mtfCp74ux9
	u5xIMILi1zuv5JmZDQuryaQDNXv0zLteKzlhphgzhw/VgCeQeXfXU2sIwVR84VWTw+z5
	v1J8dNdTW9Brlg5YSFIMp35A3SbZbvF2MbZufMg3a42DXLLvYm3+GNTESbR+IZMc+f5x
	pPmby0eod8gmlzoC4y6vFwtBplYMI5V+yCmG0o/ofakdFnz6u7DbjGi/y6mKwYe/dznp
	jIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=maD4OPjYyzieTLnh18CUwsgpbyjh9F4aQoSpoaGjoJU=;
	b=bFc+F3sxk6Hq7I0Fl6igDfseC4eFxYG3bd3XJ2jYUH0g31MQ+mn+TqmkkHNAW5hCWq
	GkZ1zGQOHsPOGVguW+sAWfB5IuKS18SmkrqQN3I6wbfwoqgbty3Cwiq0Ze01PMca9h2o
	DawEA+DcUFgj+L7NCZEdaG4TpJE7Fhl1ir/38e2ZhLEco3bZQN/a99bPs1uUi/uuUtpM
	g5I7cpiPOYBQ8NOr6BV30KeTb/nfdmMxGH+wyy+t4fTaFE687BGzuHWX4MT8cCTZ964F
	6XKXfBunbhUyuEDYZtqJFUQWkSQ8FDTZXDmUIqlV8KB0V0Ink5ZrmlcDhhQ9jETLGLdn
	4F7w==
X-Gm-Message-State: AFeK/H2W0uO8a1gsGV0itv2HgfkY7vPwJnoGmiTYwqZdpWrrK1lpmegioN1RUQ7J8dIi2pqNX0AsVmdNl/uodg==
X-Received: by 10.223.152.237 with SMTP id w100mr17217540wrb.72.1490718624431; 
	Tue, 28 Mar 2017 09:30:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.55 with HTTP; Tue, 28 Mar 2017 09:30:23 -0700 (PDT)
In-Reply-To: <1490709894-31154-1-git-send-email-pidge@toganlabs.com>
References: <1490709894-31154-1-git-send-email-pidge@toganlabs.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 28 Mar 2017 09:30:23 -0700
Message-ID: <CAJ86T=UYhwXiQ0EdVUxhT7wJXqwn-QDeTWrYruB-1go3Ak1FDg@mail.gmail.com>
To: "Elizabeth 'pidge' Flanagan" <pidge@toganlabs.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCHv2] s3.py: Add support for fetching source mirrors/minor cleanup
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
X-List-Received-Date: Tue, 28 Mar 2017 16:30:24 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 28, 2017 at 7:04 AM, Elizabeth 'pidge' Flanagan
<pidge@toganlabs.com> wrote:
> This commits main purpose is to add support for fetching source
> mirrors. In the current incarnation:
>
> SOURCE_MIRROR_URL ?= "s3://mybucket/downloads"
>
> will fail for two reasons. First, download doesn't support it,
> but second, without aws included in HOSTTOOLS you'll end up
> with aws not being found by bitbake (for either source mirrors or
> sstate mirrors).
>
> Part of this is fixed with this commit. However, this will still
> fail if HOSTTOOLS doesn't include 'aws' in bitbake.conf. I've another
> commit or two to fix that as well.
>
> I've also DRYed up some of the error handling, removed the hardcoded
> aws and added some logging.
>
> Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
> ---
>  lib/bb/fetch2/s3.py | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
> index 27993aa..791f3b2 100644
> --- a/lib/bb/fetch2/s3.py
> +++ b/lib/bb/fetch2/s3.py
> @@ -34,6 +34,7 @@ import urllib.request, urllib.parse, urllib.error
>  from bb.fetch2 import FetchMethod
>  from bb.fetch2 import FetchError
>  from bb.fetch2 import runfetchcmd
> +from bb.fetch2 import logger
>
>  class S3(FetchMethod):
>      """Class to fetch urls via 'aws s3'"""
> @@ -48,6 +49,8 @@ class S3(FetchMethod):
>          return True
>
>      def urldata_init(self, ud, d):
> +        ud.basecmd = d.getVar("FETCHCMD_s3", True) or "/usr/bin/env aws s3"
> +
>          if 'downloadfilename' in ud.parm:
>              ud.basename = ud.parm['downloadfilename']
>          else:
> @@ -60,8 +63,13 @@ class S3(FetchMethod):
>          Fetch urls
>          Assumes localpath was called first
>          """
> -
> -        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path, ud.localpath)
> +        if 'downloadfilename' in ud.parm:
> +            dldir = d.getVar("DL_DIR", True)
> +            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
> +            cmd = '%s cp s3://%s%s %s%s%s' % (ud.basecmd, ud.host, ud.path, dldir, os.sep, ud.localpath)
> +        else:
> +            cmd = '%s cp s3://%s%s %s' % (ud.basecmd, ud.host, ud.path, ud.localpath)
> +        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, cmd))

The intention is that "downloadfilename" is incorporated into
ud.localfile by urldata_init(). Did you find a case where that doesn't
work?

>          bb.fetch2.check_network_access(d, cmd, ud.url)
>          runfetchcmd(cmd, d)
>
> @@ -70,11 +78,11 @@ class S3(FetchMethod):
>          # tool with a little healthy suspicion).
>
>          if not os.path.exists(ud.localpath):
> -            raise FetchError("The aws cp command returned success for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path, ud.localpath))
> +            raise FetchError("The command  %s returned success but %s doesn't exist?!" % (cmd, ud.localpath))

This seems fairly arbitrary churn...

>
>          if os.path.getsize(ud.localpath) == 0:
>              os.remove(ud.localpath)
> -            raise FetchError("The aws cp command for s3://%s%s resulted in a zero size file?! Deleting and failing since this isn't right." % (ud.host, ud.path))
> +            raise FetchError("The command %s resulted in a zero size file?! Deleting and failing since this isn't right." % (cmd))

Ditto.

>
>          return True
>
> @@ -83,7 +91,9 @@ class S3(FetchMethod):
>          Check the status of a URL
>          """
>
> -        cmd = 'aws s3 ls s3://%s%s' % (ud.host, ud.path)
> +        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
> +        logger.debug(2, "Checking %s using command '%s'" % (ud.url, cmd))

runfetchcmd() will output basically the same thing, so this isn't
really required.

> +
>          bb.fetch2.check_network_access(d, cmd, ud.url)
>          output = runfetchcmd(cmd, d)
>
> @@ -91,6 +101,6 @@ class S3(FetchMethod):
>          # is not found, so check output of the command to confirm success.
>
>          if not output:
> -            raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
> +            raise FetchError("The command %s gave empty output" % (cmd))

More churn for little obvious gain.

>
>          return True
> --
> 1.9.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

