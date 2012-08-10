Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SzpbZ-0001Cm-NV
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 15:50:21 +0200
Received: by lban1 with SMTP id n1so758049lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Aug 2012 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=CSZdDBm98yzRJqTCiMNH+cCTXVC6Ad8Jr34pbuIQ7+c=;
	b=QmNOajoOHB/FBvDfmx/UN8vW+qirrAGRM3TJVpiICTT9SHsl2txMPpUspU5tX8Flen
	5RtWWdMK34laJYMkHIiqYwmG+o345+/em6bGNsyFQZES3EbmPHozzKlJclBO5MpUkiOh
	v1H3yvPjS0S0cMg1koR9kKMh0hDEn8EdWquyDRGgIpUcegqh5IgwBoWdjkZli32z6M82
	bI+CXYLqYrWPddgZaD8wsuW0FNQWl64+MOTy0+q7YYa3HbmAyAebTuzdFdAzj035T+KX
	eNAtF1XLW2dbGiLg2T+AZCO4nnzDX5quoXPoMpb9wk91psKurxTf6OrX47/gbFd0hm9j
	0X5A==
Received: by 10.112.42.225 with SMTP id r1mr2407915lbl.102.1344605911726; Fri,
	10 Aug 2012 06:38:31 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.64.209 with HTTP; Fri, 10 Aug 2012 06:38:11 -0700 (PDT)
In-Reply-To: <6a3f6d68c2bb44faac061761f2565a5f03d8e8d8.1344569166.git.liezhi.yang@windriver.com>
References: <cover.1344569166.git.liezhi.yang@windriver.com>
	<6a3f6d68c2bb44faac061761f2565a5f03d8e8d8.1344569166.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 10 Aug 2012 06:38:11 -0700
X-Google-Sender-Auth: Sg76WH7m1P-i9gdlkatecNnq7hY
Message-ID: <CABcZANkj1Uq30z-uvc5EjNRZOXeCLKp=yWEi6ORxTPtm3jNWWA@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1 V2] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 10 Aug 2012 13:50:21 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 9, 2012 at 8:47 PM, Robert Yang <liezhi.yang@windriver.com> wrote:
> * Usage:
>   bitbake-whatchanged [[opts] recipe]
>
> * Implementation summary:
>   - Use the "BB_STAMPS_DIR=<path> bitbake -S recipe" to generate the new
>     stamps

If this script depends on a variable that is metadata specific, it
doesn't belong in the bitbake repository.
-- 
Christopher Larson


