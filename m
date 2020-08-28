Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web12.46505.1598631780674469889
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2020 09:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: sandra.tobajas@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4C4079C00AF;
	Fri, 28 Aug 2020 12:22:59 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id i7DC7QGkd-sJ; Fri, 28 Aug 2020 12:22:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF09A9C02DD;
	Fri, 28 Aug 2020 12:22:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V6j3UpAQ7veB; Fri, 28 Aug 2020 12:22:58 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A26679C00AF;
	Fri, 28 Aug 2020 12:22:58 -0400 (EDT)
Date: Fri, 28 Aug 2020 12:22:58 -0400 (EDT)
From: "Sandra Tobajas" <sandra.tobajas@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Message-ID: <249103790.1725871.1598631778617.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <59cafb789dc3c57bceee16372f306dfff1cfb218.camel@linuxfoundation.org>
References: <20200827192537.3091416-1-sandra.tobajas@savoirfairelinux.com> <59cafb789dc3c57bceee16372f306dfff1cfb218.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: fetch2/npm: allow to build npm package with no dependency
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3928)
Thread-Topic: bitbake: fetch2/npm: allow to build npm package with no dependency
Thread-Index: uaoG0mleLAUb46vR7HZv3qi8cNvR2Q==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I will add an unit test with a npm package with no dependency.

----- Original Message -----
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Sandra Tobajas" <sandra.tobajas@savoirfairelinux.com>, bitbake-devel@lists.openembedded.org
Sent: Thursday, August 27, 2020 3:28:32 PM
Subject: Re: [bitbake-devel][PATCH] bitbake: fetch2/npm: allow to build npm package with no dependency

On Thu, 2020-08-27 at 15:25 -0400, Sandra Tobajas wrote:
> In the case of an empty npm-shrinkwrap.json file (with no
> dependency),
> the npmsw fetcher was causing a RecursionError reported in [1].
> 
> It also happened if the package has only "dev" dependencies and was
> built
> without --npm-dev option.
> 
> Add sanity checks to ensure that the dependency list is not empty and
> set
> the urldata proxy attribute to None if no dependency is found.
> 
> [1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=13901.
> 
> Signed-off-by: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
> ---
>  bitbake/lib/bb/fetch2/npmsw.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Thanks, do we need to add any test case for this?

Cheers,

Richard
