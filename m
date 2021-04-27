Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.11104.1619542385534923877
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 09:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: henning.schild@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13RGr2kg021150
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Apr 2021 18:53:02 +0200
Received: from md1za8fc.ad001.siemens.net ([167.87.26.73])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13RGr165002869;
	Tue, 27 Apr 2021 18:53:02 +0200
Date: Tue, 27 Apr 2021 18:53:00 +0200
From: henning.schild@siemens.com
To: <isar-users@googlegroups.com>
Cc: <bitbake-devel@lists.openembedded.org>,
        Richard Purdie
 <richard.purdie@linuxfoundation.org>,
        Cedric Hombourger
 <Cedric_Hombourger@mentor.com>,
        Chris Larson <Chris_Larson@mentor.com>
Subject: Re: [PATCH v3 1/3] fetch/git: add support for disabling shared clones on unpack
Message-ID: <20210427185300.5f4357ea@md1za8fc.ad001.siemens.net>
In-Reply-To: <20210414063241.18528-1-henning.schild@siemens.com>
References: <20210414063241.18528-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Note mainly to isar-users, this is now merged in upstream bitbake. Once
we update our bitbake we can set "BB_GIT_NOSHARED = 1" in our
bitbake.conf and drop the git adjust task. That should allow use of git
outside the chroot and hopefully does not have a too negative impact on
unpack performance ... for big things like the kernel

Henning

Am Wed, 14 Apr 2021 08:32:39 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> By default the unpacker will create a "shared" clone when cloning from
> the DL_DIR to the WORKDIR. This patch introduces an option to control
> that behaviour.
> 
> Imagine some recipe steps are executed in a namespace that is
> different from the one your downloader and unpacker ran in. (chroot)
> Because a "shared" clone has an absolute reference to its "alternate"
> you now have to make that "alternate" visible in that new namespace
> (chroot) at the exact place.
> 
> With this patch you can unpack "noshared" and get a stand-alone copy.
> This copy will also work if the "alternate" is not visible or
> existant.
> 
> The switch is a global bitbake switch and will affect all git urls.
> Build systems that need "noshared" most likely need it for everything
> they do with git.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  lib/bb/fetch2/git.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e3ba80a3f52a..3e25b4b6047c 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -168,7 +168,11 @@ class Git(FetchMethod):
>          if len(branches) != len(ud.names):
>              raise bb.fetch2.ParameterError("The number of name and
> branch parameters is not balanced", ud.url) 
> -        ud.cloneflags = "-s -n"
> +        ud.noshared = d.getVar("BB_GIT_NOSHARED") == "1"
> +
> +        ud.cloneflags = "-n"
> +        if not ud.noshared:
> +            ud.cloneflags += " -s"
>          if ud.bareclone:
>              ud.cloneflags += " --mirror"
>  

