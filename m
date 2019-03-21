Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 8694E7CFA1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 23:42:05 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id q1so443541wrp.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=YnxNRwy+s3zG4IArsoMSrZ5zjx/STHWjKwsA5anPu7s=;
	b=JMgmramgqBfoSvgXpcJGD1bOOu0hxycHkxOdw5LdvC2ubiva7ZD8jLs+52t/cHM6X0
	4UytEsiZg4bBDTn5Eb6To5iJgW9mEEeVSdJ83rY7Z9NSr/ZwvvXcDBUV4nXpHIHmEZOJ
	l3KHvWGPsI9Tq35V9Uxe6uxv14V3UHJqR6Y2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=YnxNRwy+s3zG4IArsoMSrZ5zjx/STHWjKwsA5anPu7s=;
	b=Pk3El92hfnB6H/PDQwNJTx/+QqFHrbj3q+GXOJLz/3Z5vW4fhkfarcoU93qi/xzyI8
	2oTSmUqwCT+bZWbC9XxM9MbVY5mCT56PtZxdYKTWGbGCY+Rl4A0HdFvOIs7Opn0/13eH
	3LkBrtHN2z0/D2TwmdzFyT0ZV7iZSHPccMlykzgR5c6nTfgxOUb6fbamHqCWgLiV7fT7
	DEIEh/Y9axQubXyPpUBKbrUlgRX6tJ8aAqPOxFaPbPcfha/enTxtPiNzvW8Y0JKcQr+6
	ySTOwTN4+w70YHrXAakgRwN8L1AuolBZaOMIQh1LTtW/HMESuSpzRuP8goFR+nINtVL8
	koxw==
X-Gm-Message-State: APjAAAU3hPT1vT5YDUsHWtCzeKcozr0vGx8j7rIuVESr6Y8jG2VZVLGT
	G/IUTEuDodb2BbeRE838c77lLA==
X-Google-Smtp-Source: APXvYqxWFKAwIr2uzvwHj5M8JJnQiNj+xSy8/TVsP650AtdDblGERVGsLWJeaq8btgU/w4QRm2/AMg==
X-Received: by 2002:a5d:6b4a:: with SMTP id x10mr4183370wrw.63.1553211726294; 
	Thu, 21 Mar 2019 16:42:06 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id y1sm7818337wrd.34.2019.03.21.16.42.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Mar 2019 16:42:05 -0700 (PDT)
Message-ID: <72417715c42b0b3841681387fc85c68f120aa1a2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 21 Mar 2019 23:42:04 +0000
In-Reply-To: <b3ade2ccda56d3abbe44c5ede950093995f8b536.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<b3ade2ccda56d3abbe44c5ede950093995f8b536.1552555629.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] fetch2: Add get_mirrorname()
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
X-List-Received-Date: Thu, 21 Mar 2019 23:42:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-03-14 at 17:28 +0800, Robert Yang wrote:
> It can be used by both __init__.py and git.py.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
>  bitbake/lib/bb/fetch2/git.py      | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index f112067..5062bb2 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -889,6 +889,9 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>  
>      return output
>  
> +def get_mirrorname(ud):
> +    return ud.host.replace(':','.') + ud.path.replace('/', '.').replace('*', '.')
> +
>  def check_network_access(d, info, url):
>      """
>      log remote network access, and error if BB_NO_NETWORK is set or the given
> @@ -910,7 +913,7 @@ def build_mirroruris(origud, mirrors, ld):
>      replacements["HOST"] = origud.host
>      replacements["PATH"] = origud.path
>      replacements["BASENAME"] = origud.path.split("/")[-1]
> -    replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
> +    replacements["MIRRORNAME"] = get_mirrorname(origud)
>  
>      def adduri(ud, uris, uds, mirrors, tarballs):
>          for line in mirrors:
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index cf8bee7..45d7303 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -248,7 +248,7 @@ class Git(FetchMethod):
>                      ud.unresolvedrev[name] = ud.revisions[name]
>                  ud.revisions[name] = self.latest_revision(ud, d, name)
>  
> -        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
> +        gitsrcname = bb.fetch2.get_mirrorname(ud)
>          if gitsrcname.startswith('.'):
>              gitsrcname = gitsrcname[1:]
>  

I think your patch is highlighting a deeper problem here. The mirror
name is something which the given fetcher module should be decoding and
this shouldn't handled in __init__.py unless its some kind of default.

We probably need to look more deeply about why git fetcher knowledge is
being used in the general case and fix that instead...

Cheers,

Richard


