Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF4C48BC3
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 11:00:24 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.10758.1708426819362253341
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Feb 2024 03:00:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HuraRSRR;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so52964491fa.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426817; x=1709031617; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Rb5DXsGzVCs9ImaVSfAkAfnHN2WQVrl4T/dcHWKSQ=;
        b=HuraRSRR4HmdlwijMU2a1ZiqukwE0hpB01tDfmW1jCWiYWXlAgD6Ip9PrUCzlgDCtg
         FzNSz5cGQJy1qPTXeV3a0IigHAr+n+ATph8wrqFTEjjfOA0MPa1TCccE+1ezZIjdAKdY
         1IuNqzUCA2nI8lDCOItMkI6JjHLZeYb4kORLyt03Ts0sdgq2Wq7LL+fWDIqXp2fg680V
         w9TYjTa0VCPEEWYYWXjlcGhooLOpsC2ad9syMcApubXzcnqTN0dpEH6vK3kRdl0P8CqN
         pnsyQkfRQLPc494eXK+Ii/LCOVTxe/OI/BilA0lNkVYuUnO67u99fZvH4Hjk7w0g05iz
         CLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426817; x=1709031617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+Rb5DXsGzVCs9ImaVSfAkAfnHN2WQVrl4T/dcHWKSQ=;
        b=pnol/JSpH+ItkYJtp+8kLMG6z7UpcRIGQydUxIb2Y/KoDpWxxlFgMbm5h9eRJ74wYR
         wrPa2TAbZVlmY6OQysNRHb/YrPk16XXmDFbwM5Ec/iU4iQvx/ZwjKkQMLhqXuqmnmqQC
         Yl3cr/PXmuFAYRJvdaKRtuJlPM6Pzr56otlXdQHrESQ4gb44vQxLqiMxmPacVu2IuVSx
         lIHrd2wYXxaw0uNop7oNZqepil5EVJflqVeUhPzfyEEPZKB6qhQQhYVzUrjXB3mTwl66
         S4QvjiCsO2H4I6bMP/CIan0jHAFfSZhXprr6Kp5yVQrVQ1W4fwt5rihiscBxrnDaaLhg
         E11Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaAeY9LhY61vbZQBnrbLl5JBriqRrEC3nBUJyJqFATWJJH/zdFfwiMZxHKQr7vdkyxDej3K1CPCUOXANduHE25tsG8RYEl9xhm2g9idFCPbcwdbw0=
X-Gm-Message-State: AOJu0YxGEUmNlu8QMUWQexJFJ50/bDuRmibzGN+Ewt9VA44Naep+QBUy
	2fOeX2Oc5DwHfDeEqC+lXdJyCos49gyijebpGglj/RdyeH9GDGFwGe5EOOLVAaYIryrBJx53Isz
	lwfzh8uQmexeM47vv5c9EJtfSHA0=
X-Google-Smtp-Source: AGHT+IFrKonBZklCXeteUH/UU/X3U7iEg+UrIu594/iOIbQ/A5H8zm7f3W8fvL2oK32L8oS5tKwe71Yj7Q2h5YDn3Yo=
X-Received: by 2002:a2e:97d3:0:b0:2d2:319b:2167 with SMTP id
 m19-20020a2e97d3000000b002d2319b2167mr4301537ljj.6.1708426817156; Tue, 20 Feb
 2024 03:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20240209160450.2871718-1-thomas.perrot@bootlin.com>
 <AS1PR10MB5697CC681B5757062953B279FD502@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <17B587B434B75DC9.20004@lists.openembedded.org>
In-Reply-To: <17B587B434B75DC9.20004@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Feb 2024 12:00:05 +0100
Message-ID: <CANNYZj8ntgNjg8U8Y3p+wvQ6updg7TpVy33o8D1FFosMFLD97w@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] wget.py: always use the custom user agent
To: alex.kanavin@gmail.com
Cc: peter.marko@siemens.com, 
	"thomas.perrot@bootlin.com" <thomas.perrot@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 11:00:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15948

I also noticed:

WARNING: swig-native-4.2.0-r0 do_fetch: Checksum failure encountered
with download of
https://downloads.sourceforge.net/swig/swig-4.2.0.tar.gz - will
attempt other sources if available

And indeed, wget with the firefox user-agent will get you a fancy html
page from sourceforge, and not the actual tarball. Try:
$ wget --user-agent='Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0)
Gecko/20100101 Firefox/84.0'
https://downloads.sourceforge.net/swig/swig-4.2.0.tar.gz

Revert revert revert.

Alex

On Tue, 20 Feb 2024 at 10:20, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
>
> I agree, this patch is over-reaching. It doesn't show that user_agent
> is actually set to "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0)
> Gecko/20100101 Firefox/84.0".
>
> I'd say servers have every right to send a response tailored for
> showing in an interactive browser when they see that.
>
> I'm sending a revert. The solution needs to be per-recipe. And if some
> server doesn't like wget, the real solution is opening a ticket with
> them.
>
> Alex
>
> On Tue, 20 Feb 2024 at 09:07, Peter Marko via lists.openembedded.org
> <peter.marko=siemens.com@lists.openembedded.org> wrote:
> >
> > Dear maintainers,
> >
> > Could we please revert this commit?
> > I'd propose to enable this via variable on per-recipe basis for those which point their SRC_URI to misbehaving servers.
> >
> > Sending browser user-agent causes Jfrog Artifactory to present a GUI as result and not directly the file itself.
> > I think that in corporate environment using Artifactory for storing binary files is not that uncommon.
> > And I think that there may be also other servers which try to beautify downloads for browsers.
> >
> > Thanks for considering this.
> >   Peter
> >
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Thomas Perrot via lists.openembedded.org
> > Sent: Friday, February 9, 2024 17:05
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Thomas Perrot <thomas.perrot@bootlin.com>
> > Subject: [bitbake-devel][PATCH v2] wget.py: always use the custom user agent
> >
> > From: Thomas Perrot <thomas.perrot@bootlin.com>
> >
> > Add the "--user-agent" paramater in the wget base command to perform all wget commands with this parameter, because a few HTTP servers block requests with the default wget user agent.
> >
> > For example, "hg.openjdk.org" never send a response to requests have been sent with wget:
> > wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> > https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> > Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73 Connecting to hg.openjdk.org (hg.openjdk.org)|23.54.129.73|:443... connected.
> > HTTP request sent, awaiting response...
> >
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> >  lib/bb/fetch2/wget.py | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py index dc025800e659..bb38dd435827 100644
> > --- a/lib/bb/fetch2/wget.py
> > +++ b/lib/bb/fetch2/wget.py
> > @@ -87,7 +87,8 @@ class Wget(FetchMethod):
> >          if not ud.localfile:
> >              ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
> >
> > -        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
> > +        self.basecmd = d.getVar("FETCHCMD_wget") \
> > +            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp
> > + --user-agent='%s'" % (self.user_agent)
> >
> >          if not self.check_certs(d):
> >              self.basecmd += " --no-check-certificate"
> > @@ -454,7 +455,7 @@ class Wget(FetchMethod):
> >          f = tempfile.NamedTemporaryFile()
> >          with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
> >              fetchcmd = self.basecmd
> > -            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
> > +            fetchcmd += " -O " + f.name + " '" + uri + "'"
> >              try:
> >                  self._runwget(ud, d, fetchcmd, True, workdir=workdir)
> >                  fetchresult = f.read()
> > @@ -492,7 +493,7 @@ class Wget(FetchMethod):
> >                      valid = 1
> >                  elif self._vercmp(version, newver) < 0:
> >                      version = newver
> > -
> > +
> >          pupver = re.sub('_', '.', version[1])
> >
> >          bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
> > --
> > 2.43.0
> >
> >
> >
> >
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15946): https://lists.openembedded.org/g/bitbake-devel/message/15946
> Mute This Topic: https://lists.openembedded.org/mt/104261171/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

