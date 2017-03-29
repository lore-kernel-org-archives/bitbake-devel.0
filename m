Return-Path: <armccurdy@gmail.com>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
	[209.85.215.42])
	by mail.openembedded.org (Postfix) with ESMTP id 3D7D377CEE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 13:45:47 +0000 (UTC)
Received: by mail-lf0-f42.google.com with SMTP id h125so8766985lfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=BDHOmbT2/zzKm0FGnKNp1qljL3hKHN6WFIRWONsJUYE=;
	b=LaDPSXc94qa10GVQFFodtGqFheYIVx3OaVp/cFKVZsWg76X2gHirnvsmEYdhNu0dIK
	GxOz03Sg2qjst+kpEgTn3cvpr8lXR/4EaDbl6TOpvdXSb+n0wBqV6BlTuNtz81ggxKsN
	auUmq1WXBkZs0PR4JD8ca2mvnW4+fu4NdI1OMhV+gh1GVP0K+9lraY7nst04C9nLgmpX
	nd6jfiP309Vk0irv+eMALf/qfq6udnz3xIBC9lvg4NvK8BJYzXYexoBta8VC+a2NthH3
	brD/kQ2TMYj+PBfGgEKhH3VTga18y6HUJXC9SKs1HIt10dBFCMz1iJVfwNe2L8lVGb8R
	z+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=BDHOmbT2/zzKm0FGnKNp1qljL3hKHN6WFIRWONsJUYE=;
	b=S4q3LaKHMoqWK8aZWefOKwL02phkWftTjmq4KdWXjveSkJmucXfMB8OwUQ4gFHPkT5
	7lGRyKPJ3u8XaFAMu9atZYZs54GrJ01MNg3oLwsF0hdmOEQj8YOXYO1zxAK3GmCLzOkZ
	uGEvblKDsLth1+B5Nxaop+Hyry5vI4+P6tdY97BoHZEOqYo8r7cDacQBf0QJrDM4+EJG
	v5fm3ao+3H9+q9Dqo6sk7BsDi+NtnHMDdcN+3t3v1GTnNKLqTi48yYkLEYDfl0098SJ4
	qAoi42DKigkv4gZBdryrAep5KKZAEugSMulLZc4XFIFS+vo1tm3Hsr1NnakKBacgr8Qx
	tdWQ==
X-Gm-Message-State: AFeK/H131VgeNzzyX+WvxRguNFy/VstEavtrIVj0olxM8v5a105RqCckP1NusZkDm+5ZEiM4fnSIxEuZOOALDw==
X-Received: by 10.28.215.18 with SMTP id o18mr1541656wmg.98.1490795148717;
	Wed, 29 Mar 2017 06:45:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.55 with HTTP; Wed, 29 Mar 2017 06:45:48 -0700 (PDT)
In-Reply-To: <1490781846-2121-1-git-send-email-pidge@toganlabs.com>
References: <1490781846-2121-1-git-send-email-pidge@toganlabs.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 29 Mar 2017 06:45:48 -0700
Message-ID: <CAJ86T=W870aGuyqDzcRZomgu5JmT0_-nGSSV93tc+xvT5tLfyw@mail.gmail.com>
To: "Elizabeth 'pidge' Flanagan" <pidge@toganlabs.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] s3.py: Remove hardcoded aws
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
X-List-Received-Date: Wed, 29 Mar 2017 13:45:48 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 29, 2017 at 3:04 AM, Elizabeth 'pidge' Flanagan
<pidge@toganlabs.com> wrote:
> This commit looks to see if FETCHCMD_s3 is set and if not, sets
> it.
>
> This is needed because I've use cases where I don't use aws, but
> s3cmd (due to license).
>
> Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
> ---
>  lib/bb/fetch2/s3.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
> index 27993aa..9157c46 100644
> --- a/lib/bb/fetch2/s3.py
> +++ b/lib/bb/fetch2/s3.py
> @@ -53,6 +53,8 @@ class S3(FetchMethod):
>          else:
>              ud.basename = os.path.basename(ud.path)
>
> +        ud.basecmd = d.getVar("FETCHCMD_s3", True) or "/usr/bin/env aws s3"

Maybe better to put this after the line below, rather than breaking
the flow of setting ud.localfile. Also remove unnecessary True from
d.getVar().

>          ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
>
>      def download(self, ud, d):
> @@ -61,7 +63,7 @@ class S3(FetchMethod):
>          Assumes localpath was called first
>          """
>
> -        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path, ud.localpath)
> +        cmd = '%s cp s3://%s%s %s' % (ud.basecmd, ud.host, ud.path, ud.localpath)
>          bb.fetch2.check_network_access(d, cmd, ud.url)
>          runfetchcmd(cmd, d)
>
> @@ -83,7 +85,7 @@ class S3(FetchMethod):
>          Check the status of a URL
>          """
>
> -        cmd = 'aws s3 ls s3://%s%s' % (ud.host, ud.path)
> +        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
>          bb.fetch2.check_network_access(d, cmd, ud.url)
>          output = runfetchcmd(cmd, d)
>
> --
> 1.9.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

