Return-Path: <akuster@mvista.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 6B356731E0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 15:49:46 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id wo6so18024612pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=MpoKYDMfPzFcuHsDXfW1RIeE4DLQh65nG5J/Okn691k=;
	b=iXwOi05kvPk+hXuBAAIaQr7TalIPX+xIlyU/DABG5xoNMJoxCW7Qr4C1swlmAnFvv0
	+lG9Rl+ReHgJ0klaho0EwYnxX17ijcFtZ41JvAp1EiSM6aezyr0T85fsuPG/OKTpVDnl
	+UJbRKPaEaMxZSW1vTuLuxebfO+clzEg8nPSgMzoI+le/RTk3ajecEWDRtEz/cMxA9tT
	8a2++DQWqI+OZF9SRKSHrf15WvSW7pJfoTmCglPugRvYdBMXAYzEioY3+0BcsIFcMtGV
	NY/lUoNXfhqFuTcw2pZ5f0UeW4BWdmxysKjFauwfgSoI7FRyctTYJ0ROXbWMcV2NhPqx
	yDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=MpoKYDMfPzFcuHsDXfW1RIeE4DLQh65nG5J/Okn691k=;
	b=f5GQoaZanB7bjw4dzPnRm52rvJFW3M5lwqYAORx0Ms57zddm39SVlID4MFfzSnSrx7
	YInb4/qjB/eFM5mZkNgdROJsW53dizb8pt1yYUeDdjtcN8xFFQvfA0bnYKc2SkFaZfDE
	HfMecQbm0oxlBdcTQS896HbIPKv+rL0kKvWBEyeOycqo0+8UDxvznJAXrvXW0bnpGgwY
	g6Xb9y3D33EnGW+rzxuQHIStuXDo9ZodpLO6rFTJgrbBmdSuEBEkTtZB4rf9wlHhVLyG
	6Ba5q6eM9qZKPkME0T3jiebGNU+POL3g7SVB/mQ5ISBvhsyHc0jvQDgrqSrgno0bF0ez
	xXgw==
X-Gm-Message-State: ALyK8tJ3c0aKW1buPTqK/eqCVZTken1KdeiC8QmSx0MyK4XXNhV0RsXFSdWB2BPWni/MxkF0
X-Received: by 10.66.149.99 with SMTP id tz3mr35895562pab.128.1466610586778;
	Wed, 22 Jun 2016 08:49:46 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:509e:4be1:bb63:3d6f?
	([2601:202:4001:9ea0:509e:4be1:bb63:3d6f])
	by smtp.googlemail.com with ESMTPSA id
	p187sm682540pfg.67.2016.06.22.08.49.44
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 22 Jun 2016 08:49:45 -0700 (PDT)
To: Stefan Christ <s.christ@phytec.de>, bitbake-devel@lists.openembedded.org
References: <1466588072-37331-1-git-send-email-s.christ@phytec.de>
From: akuster <akuster@mvista.com>
Message-ID: <576AB396.3020207@mvista.com>
Date: Wed, 22 Jun 2016 08:49:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1466588072-37331-1-git-send-email-s.christ@phytec.de>
Subject: Re: [PATCH krogoth+] fetch2: fix unpack of symbolic links
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
X-List-Received-Date: Wed, 22 Jun 2016 15:49:49 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Does the "Krogoth+" mean "master" too?

- armin

On 06/22/2016 02:34 AM, Stefan Christ wrote:
> Files in the download directory can be symbolic links to the real file.
> The fetcher must copy the real file instead of copying the symbolic
> link. Otherwise other tasks will fail, like patching, or the recipe will
> modify files in the download directory.
> 
> This patch fixes commit 865d2fef ("bitbake: fetch2: fixes copying of
> file://dir; subdir=foo, bug 6128 and bug 6129").
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index e8fbe89..a1819e7 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1423,7 +1423,9 @@ class FetchMethod(object):
>                      if urlpath.find("/") != -1:
>                          destdir = urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
> -                cmd = 'cp -fpPR %s %s' % (file, destdir)
> +                # Use -L to always resolve symbolic links. Files in download
> +                # directory can be links to the real file.
> +                cmd = 'cp -fpLR %s %s' % (file, destdir)
>  
>          if not cmd:
>              return
> 

