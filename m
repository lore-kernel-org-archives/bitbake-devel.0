Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8D2897C361
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 15:08:05 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id f7so10702708wrp.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=Jk3zj6EOWqL7qjRnGaWjlAgIb8K+DnYz1JTODhovYaE=;
	b=TvPrAhqFP2By7DKrV0ISs9cXuX+BB44+rnDW83UKgVqJQ3FQ1skfSeqJMlet4TNMpf
	UXk0i9V5A1/AFAcrnQXyjsc0k8s7GpthcbLeZVG3BpvX3H5AIhpQUBR64O3z1lLAxuFt
	SgjsQUfvkS2AHQLeOi+Q5y/hUA8w4MT2WK+5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=Jk3zj6EOWqL7qjRnGaWjlAgIb8K+DnYz1JTODhovYaE=;
	b=qUuEHP5zq7X0q1APboK4J2Jj3lYhAahjo2qDLWVvn/jRmYErMM2q6iDjqIXwk5ZnXb
	xxQLSwb71lHzS+3f5NJdLMB6LsrfrNRjkcQmu2KLAqThJSWa6xSPSkECcj/oki5/84H0
	DljuAiOxQVyjGb+lM6W1OruwfGDhv9fdjFxE1jugS5xXe49k8arzjPo3/n5Uzdkv0ItY
	fefX5zOuvT01wfoBOi1WajU/Mh/pnQKWMZQYq5Xi39KujqRkZaZY5l802n4Ifu2gJjZf
	d+iEHD9Gdzm0W/nr3U3Mee8xF1l5hRFrB8DU5wbzjaQ5E/e+UKsPM6ZpRYmsJ37gA1/q
	2woA==
X-Gm-Message-State: AJcUukcRy+n5pJHQoKWIqwq/MePnsCvPFfysFzsDs6tTHQAfeAtziYgg
	LnteUsRSsQc35Vh74xl3D4z0bg==
X-Google-Smtp-Source: ALg8bN7hn6xdqartUU47si9dAjNRAO089LajT7gkFaPdfBVj8jQBzmgcw83/6qlEWDwsvY/y16vgIQ==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr12236617wru.152.1548428886148;
	Fri, 25 Jan 2019 07:08:06 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w16sm127937685wrp.1.2019.01.25.07.08.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 25 Jan 2019 07:08:05 -0800 (PST)
Message-ID: <238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liu.ming50@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2019 15:08:04 +0000
In-Reply-To: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Cc: stefan.agner@toradex.com, luka.pivk@toradex.com
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 15:08:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-01-25 at 15:41 +0100, liu.ming50@gmail.com wrote:
> From: Ming Liu <liu.ming50@gmail.com>
> 
> A following issue was observed with gitsm:
> > git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
> > error: could not lock config file config: File exists
> 
> Since all git submodules share a config file and Git creates a lock
> file (.git/config.lock) to synchronize access to it, but Git only tries
> exactly once and returns a error if it's already locked. This leads to
> a race condition if there are many 'git config submodule' run in
> different processes.
> 
> It could be fixed by introducing a bitbake file lock to protect config
> file from concurrent update from submodules.
> 
> Reported-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index f45546b..9465acb 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -183,11 +183,19 @@ class GitSM(Git):
>  
>              local_path = newfetch.localpath(url)
>  
> -            # Correct the submodule references to the local download version...
> -            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
> +            # Protects the config file from concurrent updates by submodules
> +            # e.g. 'git config submodule' run in different processes may lead
> +            # to a race condition.
> +            lf = bb.utils.lockfile(os.path.join(ud.destdir, "gitsm-config.lock"))
>  
> -            if ud.shallow:
> -                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
> +            try:
> +                # Correct the submodule references to the local download version...
> +                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
> +
> +                if ud.shallow:
> +                    runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
> +            finally:
> +                bb.utils.unlockfile(lf)
>  
>              # Ensure the submodule repository is NOT set to bare, since we're checking it out...
>              try:

I still don't see why this is necessary after Mark's recent changes.
These files are in ud.destdir which in OE terms is WORKDIR. Only one
fetch happens against WORKDIR at a time? Therefore how is this racing?

Have you seen this problem against the current master code?

Cheers,

Richard



