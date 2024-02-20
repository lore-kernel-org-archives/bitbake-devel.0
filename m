Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F5DC48BC4
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 09:20:44 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.9615.1708420841282436122
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Feb 2024 01:20:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q5waRYWX;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51181d8f52fso6862608e87.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 01:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708420839; x=1709025639; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XLTsB3ewH0qVl7nC6nGDExzzS0w3BlmVR+q3BRGkDso=;
        b=Q5waRYWXOPiyDjY8Ye2+ibGqvPmhqVPlZZ8uSIGCR0wuPkAUF3VjiWUn8PABX9Jd8F
         5MiuXKU2cUC/HcjJnwV00+jSzR5YbfXlweOh5wWeoZeSGwPZtGso26kfR2CdHwWMEAqk
         cDAufv5MagVuWRcC7cY3X6mfRnJl1TAI8EuIEEb/TztWTbU6UclWsnsfQczPSDrUbicv
         pjBEklGSUxXAboqpPGCf6lOJHeYr4eyyeE6y5Ujl6Gaz1fzSaoUigVdWluV6PbvthR8m
         y/bLC6Re4Nob/phVKs3u+/jFRT5azFvRbbPGFBrGt9ygFq5mm44nuXqa72NVdeCZhqNk
         2G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420839; x=1709025639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLTsB3ewH0qVl7nC6nGDExzzS0w3BlmVR+q3BRGkDso=;
        b=DWgp9D7/vYUJs9zlfMcB7Vg0F9GWBV3RiTLasaNZOdl21C5NPiPWiwSu8gcac0vle0
         do/F/Cr2z/Kce4CQW5bKhzeb6Oy1KaoaolcxqgJj5kbDEn2gzlO83yCPXiKxMeayQaW/
         KbkrzZ0v5Z5LgAqpmofqNOQvPTxiQ/azYIJr8k5hwH9z97mwJbHv+ekkoS0eAcOnxTa9
         pXvUc7rhLsX8kSlg3j+mZ8dBpk7ej5S5Ca5Bcc4YIq3kiviqsOgzYNGFz+/Ec50BqEYC
         bS3f00F1BXJUspCn1RlXvBlFfNPjc1iPzqXc8WGQ2uUQ5g+KxBR2CBcNkE0hE5/GVL7B
         Ml4g==
X-Forwarded-Encrypted: i=1; AJvYcCUBRNBX6Zh7j4IDKYugh1kM2KFtkUjuSCeMxb53LoXk05poJsYJSFJMzVlmReHFrSt5qA8A3bQUVk3QJk6REGQqJ6uYG5zXCZzfNSTkXfYJ4CQFlTU=
X-Gm-Message-State: AOJu0YyuIOXgibvfpmxwKvG8n/Hhmt7pbaTNsApMjl5wlGTg5A46dRq1
	teCUNp7Y6ZwFJs0YRVFaiw4zxKpYTuWZOZVSUZFQGbO4Af79WCtoZhkg6AzXgrscVyBTjW2wWry
	2QjahPQXoDdugOdi5j+ClbbaPDrY=
X-Google-Smtp-Source: AGHT+IEvpoC8f5cSQADovG1d4VorDfFkweus/UQsFYFSSjMvyHGR6OTvbwUPkizDtX8swC6haAii4m6q5Ep09WvS+Vc=
X-Received: by 2002:a05:6512:34c9:b0:512:be5a:e33a with SMTP id
 w9-20020a05651234c900b00512be5ae33amr1784203lfr.48.1708420839174; Tue, 20 Feb
 2024 01:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20240209160450.2871718-1-thomas.perrot@bootlin.com> <AS1PR10MB5697CC681B5757062953B279FD502@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB5697CC681B5757062953B279FD502@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Feb 2024 10:20:27 +0100
Message-ID: <CANNYZj-bPOJDr23TmZLGdQEHFJ+A7SX5utmwvUnutiDvAkz3Tw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] wget.py: always use the custom user agent
To: peter.marko@siemens.com
Cc: "thomas.perrot@bootlin.com" <thomas.perrot@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 09:20:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15946

I agree, this patch is over-reaching. It doesn't show that user_agent
is actually set to "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0)
Gecko/20100101 Firefox/84.0".

I'd say servers have every right to send a response tailored for
showing in an interactive browser when they see that.

I'm sending a revert. The solution needs to be per-recipe. And if some
server doesn't like wget, the real solution is opening a ticket with
them.

Alex

On Tue, 20 Feb 2024 at 09:07, Peter Marko via lists.openembedded.org
<peter.marko=siemens.com@lists.openembedded.org> wrote:
>
> Dear maintainers,
>
> Could we please revert this commit?
> I'd propose to enable this via variable on per-recipe basis for those which point their SRC_URI to misbehaving servers.
>
> Sending browser user-agent causes Jfrog Artifactory to present a GUI as result and not directly the file itself.
> I think that in corporate environment using Artifactory for storing binary files is not that uncommon.
> And I think that there may be also other servers which try to beautify downloads for browsers.
>
> Thanks for considering this.
>   Peter
>
> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Thomas Perrot via lists.openembedded.org
> Sent: Friday, February 9, 2024 17:05
> To: bitbake-devel@lists.openembedded.org
> Cc: Thomas Perrot <thomas.perrot@bootlin.com>
> Subject: [bitbake-devel][PATCH v2] wget.py: always use the custom user agent
>
> From: Thomas Perrot <thomas.perrot@bootlin.com>
>
> Add the "--user-agent" paramater in the wget base command to perform all wget commands with this parameter, because a few HTTP servers block requests with the default wget user agent.
>
> For example, "hg.openjdk.org" never send a response to requests have been sent with wget:
> wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73 Connecting to hg.openjdk.org (hg.openjdk.org)|23.54.129.73|:443... connected.
> HTTP request sent, awaiting response...
>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>  lib/bb/fetch2/wget.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py index dc025800e659..bb38dd435827 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -87,7 +87,8 @@ class Wget(FetchMethod):
>          if not ud.localfile:
>              ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
>
> -        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
> +        self.basecmd = d.getVar("FETCHCMD_wget") \
> +            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp
> + --user-agent='%s'" % (self.user_agent)
>
>          if not self.check_certs(d):
>              self.basecmd += " --no-check-certificate"
> @@ -454,7 +455,7 @@ class Wget(FetchMethod):
>          f = tempfile.NamedTemporaryFile()
>          with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
>              fetchcmd = self.basecmd
> -            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
> +            fetchcmd += " -O " + f.name + " '" + uri + "'"
>              try:
>                  self._runwget(ud, d, fetchcmd, True, workdir=workdir)
>                  fetchresult = f.read()
> @@ -492,7 +493,7 @@ class Wget(FetchMethod):
>                      valid = 1
>                  elif self._vercmp(version, newver) < 0:
>                      version = newver
> -
> +
>          pupver = re.sub('_', '.', version[1])
>
>          bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
> --
> 2.43.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15945): https://lists.openembedded.org/g/bitbake-devel/message/15945
> Mute This Topic: https://lists.openembedded.org/mt/104261171/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

