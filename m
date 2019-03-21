Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id B064D7CFCE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 23:35:43 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id d17so382798wre.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=EdakJGMQsT38TrLs3qs8+stjB0J6mpEkxSUbRiCb5nI=;
	b=PTQiSWksZ7NQxfyV7JdNxyN17lBXsr4Zqib4Jm0JymHDhankTi+a8nZ0luQv6srwZ0
	DbhORKR65KeW/s6n79mYfgc0ujBTkg3MTF2OIUf51NBW13XDefBNS1q3bp5vCpmbkmDS
	+FXszjiR7H+f6moEgakGB2f0tO8w+X+6a9ocY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=EdakJGMQsT38TrLs3qs8+stjB0J6mpEkxSUbRiCb5nI=;
	b=jZvObD72RYEiIn29cABdQQRrxUITIm6wwU2nOf0GCvsTtFJagATY+UbpBCw6h5fGKI
	zu4Ytp2wKyJCprvtdDZsKx3twmF2L0/npfY6EudGeqaQSyuy3bsDsJ2NMRtHZwxhX20g
	qFOxNh5cOsMSQwfir6c/qf9WRn78sokYt1lFZyfTATqMhAXx/cxrTs5GegiLUw4OMS0C
	g5KsyHGk6vIoB8iBURbk5Xd0jTJ95q2NwVKgz6IPFVYiLQdYPRmOEOZE3UPwAiCmKa+0
	hG2k19JmhWd7H2bfhq4pah6es//bC9PjxfmrqEz1VgaQVWv9FEjtWazqXqOa5vM20Jqv
	KZ4Q==
X-Gm-Message-State: APjAAAXMb3S0DOrlvjDMrjjq8E1a8AQN/XGIzORCQ4M9yzqvOxPLO2TB
	dC4PrnKc3qFIPGay36lXsmV3IQ==
X-Google-Smtp-Source: APXvYqx839bzkIG/4rMIWC2sh1GyzSFqwYlzhmzEggWfGueAyaEnn1GPzKXA/k6e3XhiCCkTc2Iv8Q==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr4116200wrw.71.1553211344473;
	Thu, 21 Mar 2019 16:35:44 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n19sm4590775wmk.35.2019.03.21.16.35.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Mar 2019 16:35:43 -0700 (PDT)
Message-ID: <57405634beb17bee8c7cf82af7d8bf672a21ed52.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 21 Mar 2019 23:35:40 +0000
In-Reply-To: <db5c32f158267831427a769f4db1a4f80125fd92.1553063929.git.liezhi.yang@windriver.com>
References: <cover.1553063929.git.liezhi.yang@windriver.com>
	<db5c32f158267831427a769f4db1a4f80125fd92.1553063929.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Thu, 21 Mar 2019 23:35:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-03-20 at 14:40 +0800, Robert Yang wrote:
> The fetch2/__init__.py checks whether "BB_FETCH_PREMIRRORONLY" ==
> "1", but
> fetch2/git.py and hg.py checks whether it is None, this makes it
> discontinuous,
> and BB_FETCH_PREMIRRORONLY = "0" doens't work as expected in the
> later case,
> so unify it to the previous one. (As BB_NO_NETWORK does).
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 2 +-
>  bitbake/lib/bb/fetch2/hg.py  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py
> b/bitbake/lib/bb/fetch2/git.py
> index 1a8ebe3..e021f33 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -318,7 +318,7 @@ class Git(FetchMethod):
>      def try_premirror(self, ud, d):
>          # If we don't do this, updating an existing checkout with
> only premirrors
>          # is not possible
> -        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
> +        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
>              return True
>          if os.path.exists(ud.clonedir):
>              return False
> diff --git a/bitbake/lib/bb/fetch2/hg.py
> b/bitbake/lib/bb/fetch2/hg.py
> index 936d043..5a3db92 100644
> --- a/bitbake/lib/bb/fetch2/hg.py
> +++ b/bitbake/lib/bb/fetch2/hg.py
> @@ -99,7 +99,7 @@ class Hg(FetchMethod):
>      def try_premirror(self, ud, d):
>          # If we don't do this, updating an existing checkout with
> only premirrors
>          # is not possible
> -        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
> +        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
>              return True
>          if os.path.exists(ud.moddir):
>              return False

Can we use bb.utils.to_boolean() in all cases to be consistent please?

Cheers,

Richard



