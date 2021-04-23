Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.73.1619201003311041129
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 11:03:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=iOaWbXtY;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619201003;
  x=1650737003;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=MZBjwRwSZtrRHLLoUkdILwFu0d+LXUEoymeOqCm3Pm8=;
  b=iOaWbXtY6HV/bfy16euB3uoYQ56aeoCUt1fWcYY3QuA7MEsu50de2uos
   GkQJOEGr3skMSKMxSN5u7oZE7zK3sC0k7Xh9ZQ+ZoRhpTAi2SX+Pa2h5X
   y/YeK12kpETdGZLj7xDVi0n+qfRnQsXesg60/BfpSmHuBUuwdV/k7zPZP
   4WODXJqwqVuVoXmANfJS10yvhYGsOxeRfibuiIDkrOtAP6lHPNv8DIC9k
   AV/tYumcBBpQ5UUZo6zcWA8vRaljhmVyHC7bTFxNqotZ8Ti1w16A8H3FG
   jnpkVAQvInIeZbaX9hB85irJc2J0/wh2syaoJXjUeZayQRAhlZycDF9M2
   g==;
References: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
 <20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
User-agent: mu4e 1.4.8; emacs 28.0.50
From: "Ola x Nilsson" <ola.x.nilsson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bin/bitbake-getvar: Add a new command to query a variable value (with history)
In-Reply-To: <20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
Date: Fri, 23 Apr 2021 20:03:10 +0200
Message-ID: <jwqv98cri8x.fsf@axis.com>
MIME-Version: 1.0
Return-Path: ola.x.nilsson@axis.com
Content-Type: text/plain


On fri, apr 16 2021, Richard Purdie wrote:

> We've talked about having this for long enough. Add a command which queries a single
> variable value with history. This saves "bitbake -e | grep" and avoids the
> various pitfalls that has.
>
> It also provides a neat example of using tinfoil to make such a query.
>
> Parameters to limit the output to just the value, to limit to a variable flag
> and to not expand the output are provided.

I think this will be a very useful tool.  I have hacked (as in I really
don't want to show anyone the code) something similar together on top of
bitbake -e and I've found this commandline very useful

bitbake-getvar RECIPE VARIABLE [VARIABLE...]

so that I do not have to repeat the command when I want to examine more
than one variable.  Expanding with VARIABLE[FLAG] syntax would be nice.
Of course, if you want to examine several flags for a variable that will
mean a lot of extra typing.

I chose to add a -g flag for --global, as in no specific recipe so it is
kind of reverse of this command's options.

Just my 2 cents

/Ola
