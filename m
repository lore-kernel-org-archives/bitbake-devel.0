Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 43A317D431
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 10:49:00 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t17so17910736wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=RECw/DZ130hnnZzeLWZ9EO1MYa+mw9CcJCR2uTSPQLU=;
	b=bv5Ih76w8U7cLDbm6pQ706Z60thoNxxAB/EIdfe8L8W0+GSoek9/Tn2rlPw5JAOAIL
	AYo4ZN9YV9RuECAY0A+LyDbkBNHjU1LFAjpw3ZPY1qLFK0bdlR6cAmh4Rjh6P005JvaR
	U2Um6ld+C9KNbeJ4l8tNGIQGFzCr0OWiQc/aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=RECw/DZ130hnnZzeLWZ9EO1MYa+mw9CcJCR2uTSPQLU=;
	b=j2or+jNLTa4EQUggcBBz4TfuQpSjZ5iyEnNoMy7kjx758/YmBBuOwh5fGCQfCmo6oT
	hrqeWg1i3HviRPEab5uy+uSVvLuCOvihe5V0AB2v1zTwaVtzoD049WtUVCtjL8i+ZP0E
	aY+6I0xKi2GBURIYe4Z8n926vlLCo7qCLAT/4/uHPEG4n/+Zm6Ny8h4TpxVt8mlXUyc+
	w/3CrsNldS82hH6S7khOtqQCrm622T/V/t/L/Ft8exTYZvoyW3t25nNk9IXXN5fr+OWq
	VdGkcu3bHAUqZrU2kwYEZ0bqi8hTYmX0Ja4K6VFtjTPFSlhTM1bpowTONig91T2wq5Cd
	sgtw==
X-Gm-Message-State: APjAAAWkGEKP4ihMkliP9c2YdfasCEZCsdKPu2jNBWpzncvNA90M5/fD
	gJdEzFrxHMEasyXWeX2hA1JFrQ==
X-Google-Smtp-Source: APXvYqzYFKBFI49q5jIoSpzyrY4oQkKDej1VFxHlMVF2tCCeCQoiPxfuyStLXTXpkflK7WfDeZgx4A==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr11318619wrl.26.1556189340944; 
	Thu, 25 Apr 2019 03:49:00 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a10sm11484613wro.67.2019.04.25.03.48.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 03:48:59 -0700 (PDT)
Message-ID: <c7e5005a5f24dd70c6a2d59922c43ce07ba41fe2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 25 Apr 2019 11:48:58 +0100
In-Reply-To: <793cb29db2286f072e1cc1f73a11b89ac3168196.1556186399.git.liezhi.yang@windriver.com>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<793cb29db2286f072e1cc1f73a11b89ac3168196.1556186399.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bitbake: BBHandler: Fix addtask and deltask
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
X-List-Received-Date: Thu, 25 Apr 2019 10:49:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-04-25 at 18:00 +0800, Robert Yang wrote:
> The following commands are not supported, but they were ignored
> silently, that
> may suprise users:
> 
> * addtask task1 task2
>   task2 is ignored
> 
> * addtask task1 before task2 before task3
>   Should be: addtask task1 before task2 task3
> 
> * addtask task1 after task2 after task3
>   Should be: addtask task1 after task2 task3
> 
> * deltask task1 task2
>   task2 is ignore
> 
> This patch can check and warn for them.
> 
> [YOCTO #13282]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/parse/parse_py/BBHandler.py | 25
> ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py
> b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> index 9dba5f2..4d90ff0 100644
> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> @@ -42,7 +42,7 @@ __func_start_regexp__    =
> re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(
>  __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
>  __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
>  __addtask_regexp__       =
> re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=a
> fter))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
> -__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)")
> +__deltask_regexp__       =
> re.compile(r"deltask\s+(?P<func>\w+)(?P<ignores>.*)")
>  __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
>  __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
>  __python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
> @@ -236,11 +236,34 @@ def feeder(lineno, s, fn, root, statements,
> eof=False):
>  
>      m = __addtask_regexp__.match(s)
>      if m:
> +        if len(m.group().split()) == 2:
> +            # Check and warn for "addtask task1 task2"
> +            m2 = re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)",
> s)
> +            if m2 and m2.group('ignores'):
> +                logger.warning('addtask ignored: "%s"' %
> m2.group('ignores'))
> +
> +        # Check and warn for "addtask task1 before task2 before
> task3", the
> +        # similar to "after"
> +        dup_after = 0
> +        dup_before = 0
> +        for tmp in s.split():
> +            if 'before' == tmp:
> +                dup_before += 1
> +            if 'after' == tmp:
> +                dup_after += 1
> +        if dup_after > 1:

taskexpression = s.split()
if taskexpression.count("after") > 1:
   
logger.warning("X")
if taskexpression.count("before") > 1:
   
logger.warning("Y")

> +            logger.warning('addtask found more than 1 keyword
> "after": "%s"' % s)

How about:

addtask contained multiple 'after' keywords, only one is supported

> +        if dup_before > 1:
> +            logger.warning('addtask found more than 1 keyword
> "before": "%s"' % s)

and:

addtask contained multiple 'before' keywords, only one is supported

>          ast.handleAddTask(statements, fn, lineno, m)
>          return
>  
>      m = __deltask_regexp__.match(s)
>      if m:
> +        # Check and warn "for deltask task1 task2"
> +        if m.group('ignores'):
> +            logger.warning('deltask ignored: "%s"' %
> m.group('ignores'))

deltask listing multiple tasks is not supported

I did wonder if we should support multiple tasks for deltask?

Also, we might want to consider adding something to lib/bb/tests/ for
this?

Cheers,

Richard


