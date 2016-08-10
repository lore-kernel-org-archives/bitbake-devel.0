Return-Path: <matt@madison.systems>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6D7C276988
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 12:25:42 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id q128so90194730wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=xnvqaV5ikUqggT7XZWU4uChFTFOZsRUhGXtnjfH9HE0=;
	b=u95fRZbrp0JtauOBrb5DN1r0oWP45GEb2HvYJVeKioJf7EQSrG/bnlss6odW+XD467
	dJZS+aOVePOlJmPJhlbT386zIpAv19D81u4u8+pj9ZCMLp/jLwYmIf0MkG8kxJEPBeAY
	YJCqTeis0zL5B+5go2Zf3t3LTrK6Jq5By3k9IYCt7jwWz512OUz4xI/O+lIfAvQumw28
	zAGvAxSvCEZu3LteTWy3daYtiOzgMmHA1iTCjPtbuJsvt9VKY+PFs3Y8DuF6U6vVHqjL
	7ra0kB02VlIrPMUBhS/F6bVjQoTGlqEO9CoFnwha90Rxslpbfkrik+hglD/GI9MKRwUu
	cc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=xnvqaV5ikUqggT7XZWU4uChFTFOZsRUhGXtnjfH9HE0=;
	b=fcV9HRJH1wnSYB1AOeXwTuae/ebsuAQh2s4bxbu4KenRnb32h7x+h4fYNJ9LVyoB1Y
	KvBJl/eZR0D5IkDy5IhjkZUdIjpDCuVALAcKY4oOe58F65yAiyfEZHIWUjWNZJQIHt9i
	6TNnaMyHLcRk2zozX8D4Gb5rn/0OI2/J8dqGmljnfu5Y+hyfajVYEAuqjQheT8AsKA7u
	zTqtLj1w3ItgoZGH+KOzcyltZ6ZJpnSUpQJzq7LnWshba9JmoULkArCjD/rZ/MTDp5sd
	ImWoUdGwIlZNEgXvN+nBFFFcjbZGTLVQ2S4EyLqe/34bNieN3bCoGLjuEXN788soTI2b
	ay9w==
X-Gm-Message-State: AEkoouvX/ef/gdZMZd41ysv4ZxhAesVjYMaqLGqkBmnOAZUwwfCcEZcnY4JNW43Zzgtc4juZXao96bJf3fw3Pw==
X-Received: by 10.25.18.90 with SMTP id h87mr692987lfi.118.1470831941986; Wed,
	10 Aug 2016 05:25:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.24.162 with HTTP; Wed, 10 Aug 2016 05:25:41 -0700 (PDT)
In-Reply-To: <1470825624.18638.1.camel@linuxfoundation.org>
References: <1470696223-9260-1-git-send-email-matt@madison.systems>
	<1470825624.18638.1.camel@linuxfoundation.org>
From: Matt Madison <matt@madison.systems>
Date: Wed, 10 Aug 2016 05:25:41 -0700
Message-ID: <CAGgRHJokE8v1H-8K_fa=KNLzU5DXaynQWwP3+efopYYjAMRrvQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: save/restore cwd for mirror URL downloads
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
X-List-Received-Date: Wed, 10 Aug 2016 12:25:42 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 10, 2016 at 3:40 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Mon, 2016-08-08 at 15:43 -0700, Matt Madison wrote:
>> Fixes "changed cwd" warnings from setscene tasks when the
>> packages are downloaded from a shared-state mirror.
>>
>> Signed-off-by: Matt Madison <matt@madison.systems>
>> ---
>>  lib/bb/fetch2/__init__.py | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> bitbake-selftest doesn't seem to like this change:
>
> https://autobuilder.yoctoproject.org/main/builders/nightly/builds/973/steps/BitbakeSelftest/logs/stdio
>
> I do wonder if we need to fix the individual fetcher modules...

I could at least rework the patch to put the getcwd call into a
try/except block.  I'll
take a closer look.

Thanks,
-Matt

>
> Cheers,
>
> Richard
>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 9054b2e..c0017a8 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -928,6 +928,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =
>> False):
>>      if ud.lockfile and ud.lockfile != origud.lockfile:
>>          lf = bb.utils.lockfile(ud.lockfile)
>>
>> +    save_cwd = os.getcwd()
>> +
>>      try:
>>          if check:
>>              found = ud.method.checkstatus(fetch, ud, ld)
>> @@ -995,6 +997,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =
>> False):
>>              pass
>>          return False
>>      finally:
>> +        os.chdir(save_cwd)
>>          if ud.lockfile and ud.lockfile != origud.lockfile:
>>              bb.utils.unlockfile(lf)
>>
>> @@ -1558,6 +1561,7 @@ class Fetch(object):
>>
>>          network = self.d.getVar("BB_NO_NETWORK", True)
>>          premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY",
>> True) == "1")
>> +        save_cwd = os.getcwd()
>>
>>          for u in urls:
>>              ud = self.ud[u]
>> @@ -1635,6 +1639,7 @@ class Fetch(object):
>>              finally:
>>                  if ud.lockfile:
>>                      bb.utils.unlockfile(lf)
>> +        os.chdir(save_cwd)
>>
>>      def checkstatus(self, urls=None):
>>          """
>> --
>> 2.7.4
>>

