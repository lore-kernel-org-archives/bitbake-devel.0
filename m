Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8503760AF3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 21:32:34 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a9so915435wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=LwgYJ5kjgwMerOj1PMtmRjDAVPC8zK5UsZzyaB15edI=;
	b=bOdDlJcHQ24RLRTV4o2yJW1jpL7CjW+0GvE6zgg3SXg+p2k7YypK2F19lwZOba1HIV
	Ax4yWf2Y16Ty1Fq4pkO7c3vU4xLITHwUxGEtXsO8/QGEiQehLEY74sRFYDfnrE+Faxef
	aJIbkUQndEAKq6eR08NAGcV45ahJiXFroFPxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=LwgYJ5kjgwMerOj1PMtmRjDAVPC8zK5UsZzyaB15edI=;
	b=BBO0dXJeRWeJYJ+/QJKdzjtPvsntIPX86h51TvgsnZOH2vhAq3/PVOSdJEPAGqqB5U
	dJ4uGKn9VnS3Zj9bkul/INpuPbK95kZiZU7BOgOWtqFol9yl3ppPmoZ+kUqLDpZ2HTuf
	49DTtUJC0B1pLQgZexH8RtH8xYzm3ZJvG6QDsPdhU1wB2UPOKA4O8x139IOt68VF+ZNS
	aGB3wd8Bk71YgE/GlGY/EcFe37SLQwZ+4riULgA4CVIsrKHmi8Cxk16sXU0us+DRMijG
	UnIGt5qYRu1b84ugqJbC4BVuaO/RHpnoCCZutFoD92/lGLg6dES1Tm9AhZ85Hd0dLmpl
	Ah5A==
X-Gm-Message-State: APjAAAXWmHXdgpAwZ72ppUHufukCxBuS8H7Z8M8bZX23SAch3gj1q33E
	jYeEZKm/JGd4rrpCD25mIsS4Tw==
X-Google-Smtp-Source: APXvYqx8eiMR5Ce6fMmN6wozTb1qAFyXVEIqzSybGjzqcekunN0lIftBib9bxZNq2YPgMzRvbivtyQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr1015392wmi.17.1582579955025; 
	Mon, 24 Feb 2020 13:32:35 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id a9sm21520673wrn.3.2020.02.24.13.32.34
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 24 Feb 2020 13:32:34 -0800 (PST)
Message-ID: <ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2020 21:32:33 +0000
In-Reply-To: <20200224201629.13774-1-pbarker@konsulko.com>
References: <20200224201629.13774-1-pbarker@konsulko.com>
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Subject: Re: [PATCH] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Mon, 24 Feb 2020 21:32:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:
> When a shallow mirror tarball is used to satisfy a gitsm URI it needs to
> be unpacked so that the .gitmodules file can be examined.
> 
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>  lib/bb/fetch2/gitsm.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index aa121cbe..98f5dae5 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -169,6 +169,12 @@ class GitSM(Git):
>                  raise
>  
>          Git.download(self, ud, d)
> +
> +        # If we're using a shallow mirror tarball it needs to be unpacked so
> +        # that we can examine the .gitmodules file
> +        if ud.shallow and os.path.exists(ud.fullshallow) and Git.need_update(self, ud, d):
> +            bb.utils.mkdirhier(ud.clonedir)
> +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=ud.clonedir)
>          self.process_submodules(ud, ud.clonedir, download_submodule, d)
>  
>      def unpack(self, ud, destdir, d):

Does this mean we're missing a test?

Cheers,

Richard


