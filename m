Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7BDC41513
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 07:45:09 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.5840.1718178307919043096
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Jun 2024 00:45:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mnIFOX4G;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bbf73f334so4880069e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Jun 2024 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718178306; x=1718783106; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNe89HJIM67EHeH5KsYtqFanihTCiP+x0/qEZrMPc3U=;
        b=mnIFOX4GCuioadHT/R/249Yc7eIbFOIyidYehO79jMlvNrsDSdsTi+ZmXgnvPIGJ99
         oUUfNmBIqFWWfjUm2e2vR4QRNvJTPPew6b0h9MDmgeI/D7Xz4BB1MAJYW0Ejt0ale7A+
         2VIUp1FoBKv8KP0g953mY3OQKpOE8293TerqBAXuBjlLksY8SAa0b68Ht2UGxoTgFmKz
         oIXH/UzjMdjArAe/kyXzPAdLW1QJD4cg4vkbKpAbaPeehUOmnORsWkESY8trtteLTptK
         e3DRUG0hTCdQkTk5BI7YFb2mphAwKS0EOtLBGAi1G34TftsHmwYcxywlHHCTA2EG/TmE
         d54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178306; x=1718783106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNe89HJIM67EHeH5KsYtqFanihTCiP+x0/qEZrMPc3U=;
        b=HSWIATMppicr4Fc52I/vyv7wq4N0mgkKLseu5Zlw7w/Dol+QX85MFKuIDdztArNpyZ
         qvFQt/fI0xig/MNHDEvOoorFP/zK6vYuJ7jLi1oTHChd7I/EKFk0sDO/24boN7jrgkz4
         NSyHLmdLG9sjjiNJjtTgpKj8lGEk+oPSglhSe8nhEPudMie8wp3LzNPPeWGpcQN7fYXv
         jqQvOUx5Ws942FS2LzsCwxcjZcUFklOy7AflKRuaSLpyMsbqYK6YnwPz3Pbjvttl83hN
         fbY5YkLuww24xI7ZaDozjkOrDw7nzLPGnk5XwaDWIQk2xtazuCZ/PcMTJlc/aNlURqKx
         g+bA==
X-Gm-Message-State: AOJu0YxblEXkTRfQ8GYk/TGk53/2GV9Wbf7/DZvqDWo4Nhe22n+JlefI
	ri/IWh0sWZW84jRt1oJUKEBvzeacfiLPkJc3ePy1qsW25w9ClRsUR19u9L6yjKcL3HIcMh9etD/
	UMGFNqUK7h7n5FfaJoDHH3x1pFNM=
X-Google-Smtp-Source: AGHT+IH+/0ksn/klYtfJPTl+cSION/HvnqxxIjEIPLr3O0qBk4KEYRuss3CRH9Df5SRtvM6+hFV650rpVIWpe84MfVg=
X-Received: by 2002:a05:6512:e8e:b0:52b:c025:859a with SMTP id
 2adb3069b0e04-52c9a3b8f0emr677182e87.2.1718178305555; Wed, 12 Jun 2024
 00:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240611230649.1473-1-egyszeregy@freemail.hu>
In-Reply-To: <20240611230649.1473-1-egyszeregy@freemail.hu>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Jun 2024 09:45:05 +0200
Message-ID: <CANNYZj8wFjFyLTbA7ug501hs=n+UZd=K9Y4YsW=qLTNf6b_K8w@mail.gmail.com>
Subject: Re: [docs] [PATCH v3] fetch2/wget: Add user_agent parameter so it can
 be used optionally
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Jun 2024 07:45:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16353

It helps to include all relevant links into the commit message, e.g.
the issues with xilinx's PMU_ROM that you had:
https://support.xilinx.com/s/question/0D54U00008RolRMSAZ/yocto-metaxilinxco=
re-cannot-find-pmuromnative-url?language=3Den_US

I just tried to reproduce the locally, and there is no issue with wget:

alex@alex-lx-laptop:~$ wget
https://www.xilinx.com/bin/public/openDownload?filename=3DPMU_ROM.tar.gz
--2024-06-12 09:29:55--
https://www.xilinx.com/bin/public/openDownload?filename=3DPMU_ROM.tar.gz
Resolving www.xilinx.com (www.xilinx.com)... 184.25.239.57, 184.25.239.48
Connecting to www.xilinx.com (www.xilinx.com)|184.25.239.57|:443... connect=
ed.
HTTP request sent, awaiting response... 302 Moved Temporarily
Location: https://xilinx-ax-dl.entitlenow.com/dl/ul/2021/12/20/R210497260/P=
MU_ROM.tar.gz?hash=3DoU3pGSFXZ2pq00I2gGZX-g&expires=3D1718209784&filename=
=3DPMU_ROM.tar.gz
[following]
--2024-06-12 09:29:56--
https://xilinx-ax-dl.entitlenow.com/dl/ul/2021/12/20/R210497260/PMU_ROM.tar=
.gz?hash=3DoU3pGSFXZ2pq00I2gGZX-g&expires=3D1718209784&filename=3DPMU_ROM.t=
ar.gz
Resolving xilinx-ax-dl.entitlenow.com (xilinx-ax-dl.entitlenow.com)...
184.25.239.24, 184.25.239.83
Connecting to xilinx-ax-dl.entitlenow.com
(xilinx-ax-dl.entitlenow.com)|184.25.239.24|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 8031 (7.8K) [application/x-gzip]
Saving to: =E2=80=98openDownload?filename=3DPMU_ROM.tar.gz=E2=80=99

openDownload?filename=3DPMU_ROM.tar.gz
100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
  7.84K  --.-KB/s    in 0s

2024-06-12 09:29:57 (87.0 MB/s) -
=E2=80=98openDownload?filename=3DPMU_ROM.tar.gz=E2=80=99 saved [8031/8031]


The sha25sum matches what is in the recipe:

alex@alex-lx-laptop:~$ sha256sum openDownload\?filename\=3DPMU_ROM.tar.gz
f9a450ef960979463ea0a87a35fafb4a5b62d3a741de30cbcef04c8edc22a7cf
openDownload?filename=3DPMU_ROM.tar.gz

The report indicated that there was a broken redirect via amd.com
(which does require browser user-agent), but this seems to be no
longer happening. Can you check?

All of this is to say, I'm still reluctant to support making the code
more complex when there is no proven need for it.

Alex


On Wed, 12 Jun 2024 at 01:07, Livius via lists.yoctoproject.org
<egyszeregy=3Dfreemail.hu@lists.yoctoproject.org> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Add "user_agent" optional parameter for wget fetcher to able
> to use it if HTTP servers block requests with the default wget
> user-agent.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  conf/bitbake.conf                             |  1 +
>  .../bitbake-user-manual-fetching.rst          | 23 +++++++++++++------
>  .../bitbake-user-manual-ref-variables.rst     |  5 ++++
>  lib/bb/fetch2/wget.py                         | 11 +++++----
>  4 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/conf/bitbake.conf b/conf/bitbake.conf
> index f5a5a333a..a16f72d25 100644
> --- a/conf/bitbake.conf
> +++ b/conf/bitbake.conf
> @@ -44,3 +44,4 @@ TARGET_ARCH =3D "${BUILD_ARCH}"
>  TMPDIR =3D "${TOPDIR}/tmp"
>  WORKDIR =3D "${TMPDIR}/work/${PF}"
>  GITPKGV =3D "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
> +BB_FETCH_USER_AGENT ??=3D "bitbake/${BB_VERSION}"
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index fb4f0a23d..0ee07992f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -221,13 +221,21 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``, ``h=
ttps://``)
>  This fetcher obtains files from web and FTP servers. Internally, the
>  fetcher uses the wget utility.
>
> -The executable and parameters used are specified by the
> -``FETCHCMD_wget`` variable, which defaults to sensible values. The
> -fetcher supports a parameter "downloadfilename" that allows the name of
> -the downloaded file to be specified. Specifying the name of the
> -downloaded file is useful for avoiding collisions in
> -:term:`DL_DIR` when dealing with multiple files that
> -have the same name.
> +The executable and parameters used are specified by the ``FETCHCMD_wget`=
`
> +variable, which defaults to sensible values. The fetcher supports
> +parameters:
> +
> +-  *downloadfilename:* That allows the name of the downloaded file
> +   to be specified.
> +
> +-  *user_agent:* Enable to use a default ``bitbake/${BB_VERSION}`` user-=
agent
> +   which is defined in :term:`BB_FETCH_USER_AGENT`.
> +
> +Specifying the name of the downloaded file is useful for avoiding
> +collisions in :term:`DL_DIR` when dealing with multiple files
> +that have the same name. A few HTTP servers block requests with
> +the default wget user-agent, in this case specifying a valid
> +user-agent can solve this issue.
>
>  If a username and password are specified in the ``SRC_URI``, a Basic
>  Authorization header will be added to each request, including across red=
irects.
> @@ -239,6 +247,7 @@ Some example URLs are as follows::
>     SRC_URI =3D "http://oe.handhelds.org/not_there.aac"
>     SRC_URI =3D "ftp://oe.handhelds.org/not_there_as_well.aac"
>     SRC_URI =3D "ftp://you@oe.handhelds.org/home/you/secret.plan"
> +   SRC_URI =3D "https://oe.handhelds.org/not_there.aac;user_agent=3D1"
>
>  .. note::
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 899e584f9..3f310bd72 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -699,6 +699,11 @@ overview of their function and contents.
>        Within an executing task, this variable holds the hash of the task=
 as
>        returned by the currently enabled signature generator.
>
> +   :term:`BB_FETCH_USER_AGENT`
> +      Specifies a user-agent string which BitBake uses if "user_agent"
> +      parameter is enabled for HTTP/FTP wget fetcher. Default value can
> +      be found in ``conf/bitbake.conf``.
> +
>     :term:`BB_VERBOSE_LOGS`
>        Controls how verbose BitBake is during builds. If set, shell scrip=
ts
>        echo commands and shell script output appears on standard out
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 2e9211763..30a56df71 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -52,11 +52,8 @@ class WgetProgressHandler(bb.progress.LineFilterProgre=
ssHandler):
>
>  class Wget(FetchMethod):
>      """Class to fetch urls via 'wget'"""
> -
> -    # CDNs like CloudFlare may do a 'browser integrity test' which can f=
ail
> -    # with the standard wget/urllib User-Agent, so pretend to be a moder=
n
> -    # browser.
> -    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gec=
ko/20100101 Firefox/84.0"
> +    def init(self, d):
> +        self.user_agent =3D d.getVar("BB_FETCH_USER_AGENT")
>
>      def check_certs(self, d):
>          """
> @@ -89,6 +86,10 @@ class Wget(FetchMethod):
>
>          self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30"
>
> +        is_user_agent_enabled =3D ud.parm.get("user_agent","0") =3D=3D "=
1"
> +        if is_user_agent_enabled:
> +            self.basecmd +=3D f" --user-agent=3D'{self.user_agent}'"
> +
>          if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
>              self.basecmd +=3D " --passive-ftp"
>
> --
> 2.45.2.windows.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5294): https://lists.yoctoproject.org/g/docs/message/=
5294
> Mute This Topic: https://lists.yoctoproject.org/mt/106623550/1686489
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [alex.kanavin@gm=
ail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

