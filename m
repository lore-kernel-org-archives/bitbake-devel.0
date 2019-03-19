Return-Path: <armccurdy@gmail.com>
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
	[209.85.221.195])
	by mail.openembedded.org (Postfix) with ESMTP id 647156BA11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 06:28:52 +0000 (UTC)
Received: by mail-vk1-f195.google.com with SMTP id d15so1818539vka.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 23:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=aLmsMk/W1P7kiZH/mMRRQOy4leZV1DFUmDG1jDda/uo=;
	b=GdSAPTtsJvs/iZkkV8r92BftuqdVEo3Oigg9dn/J9yVk4fTne0uTtdP6u4iE235YLc
	FAHS2MIB+knPOdK1tJm2DbhGzAHufTiRba/ysSNlG1aab9pDiColV211v61LwqaIJ8B/
	riX1+po5MzP1vb/7+sCpAJbk2dCmXyMwnfAEr3hrBMqW1lsp0vN2zoUr5/0Xrivrkkmd
	U1yuENTRXqoC8OB3u8D+up6hjmRyV5ujRmEa/VM4haNBP2s/V+2EvgQw8pxGWqXNOEUE
	FdKKo7ZOXIQyO+h/EiceRsoBaF2z9xHCAAXj8bVzQr5bZbqD7l/DOGPdHGIl/+O7tn8V
	EgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=aLmsMk/W1P7kiZH/mMRRQOy4leZV1DFUmDG1jDda/uo=;
	b=FkW44kBNu4P6apBbS/0VFA0CT1KwRmj6ppV0esLmf9A8MLf9SiW0RXkxkgKmHsEFJ6
	eE6MZMG5ijEizN6n65VrkpB2yhiFbVicgKT+WiYPWxlSgurZU2jNRZmUscB1qMEEGGWc
	llrMnQvve+rSKhNhThuKhOVkrXeVB52biybmNBC2ELTP8mRFhtdlJpGHyVFsLC2pOvIo
	JV1d9R/ZFDaYzcWq5NAwV57aRII7lgjY+BIhIyU5/R/sfihlVgdBkaQw/s74fW5t2U9/
	7j0UKazHScpyajn5hGaOTwaXyuvXKBnMowUy2EfXDn3x3bHdyJjyNONUZcfhUQkpjGz9
	bVtg==
X-Gm-Message-State: APjAAAWynDSAfSm84OCs/XbXbPITPaU/75z7+iBhUPF9AHDSgMQ8PEl4
	wn5iPAVoiUJlr8JGDtoruCdS8YigoQ8nAfH/aWo=
X-Google-Smtp-Source: APXvYqxIDskEQdGJtVT448UwWjNzR2Fhyxz9NIsN56zXCVCs500mXxl7dDU1vxVzdr1Ncdj+1k3e1w9prcDCZNR07eY=
X-Received: by 2002:a1f:a4c4:: with SMTP id n187mr388052vke.77.1552976933080; 
	Mon, 18 Mar 2019 23:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
	<20190318135820.7344-4-stefan.klug@baslerweb.com>
In-Reply-To: <20190318135820.7344-4-stefan.klug@baslerweb.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 18 Mar 2019 23:28:41 -0700
Message-ID: <CAJ86T=VCGsyMeV+=EOZnhi7yND6sRPJntF=izk4QWa_nRCz_nA@mail.gmail.com>
To: Stefan Klug <stefan.klug@baslerweb.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 3/3] fetch2/wget: Fix authentication in checkstatus() of the wget fetcher
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
X-List-Received-Date: Tue, 19 Mar 2019 06:28:52 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 18, 2019 at 7:08 AM Stefan Klug <stefan.klug@baslerweb.com> wrote:
>
> I wonder how this used to work for anybody.

No need to wonder when you have access to the git history... :-)

  http://git.openembedded.org/bitbake/commit/?id=cea8113d14da9e12db80a5b6b5811a47a7dfdeef

It looks like ud.user used to contain both the username and
password... and when that changed, download() was updated but
checkstatus() was not:

  http://git.openembedded.org/bitbake/commit/?id=6a917ec99d659e684b15fa8af94c325172676062

> Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
> ---
>  lib/bb/fetch2/wget.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e2037511..3addb219 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -322,8 +322,8 @@ class Wget(FetchMethod):
>                  authheader =  "Basic %s" % encodeuser
>                  r.add_header("Authorization", authheader)
>
> -            if ud.user:
> -                add_basic_auth(ud.user, r)
> +            if ud.user and ud.pswd:
> +                add_basic_auth(ud.user + ':' + ud.pswd, r)
>
>              try:
>                  import netrc, urllib.parse
> --
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

