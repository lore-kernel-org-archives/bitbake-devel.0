Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 51FC172D64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGYT8e024982; Wed, 27 May 2015 17:34:29 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sHIHnw6uJn2n; Wed, 27 May 2015 17:34:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGYFho024979
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 May 2015 17:34:26 +0100
Message-ID: <1432744455.404.53.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Wed, 27 May 2015 17:34:15 +0100
In-Reply-To: <CABcZAN=t4OFiwpAYT+CD8heNJVZO4s=Y3XOqxkqRvoakTSx=bQ@mail.gmail.com>
References: <1432653462.404.12.camel@linuxfoundation.org>
	<CABcZAN=t4OFiwpAYT+CD8heNJVZO4s=Y3XOqxkqRvoakTSx=bQ@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] tests/data: Add log parsing test code
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
X-List-Received-Date: Wed, 27 May 2015 16:34:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2015-05-26 at 08:26 -0700, Christopher Larson wrote:
> 
> On Tue, May 26, 2015 at 8:17 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         +class LogRecord():
>         +    def __enter__(self):
>         +        import logging
>         +        logs = []
>         +        class LogHandler(logging.Handler):
>         +            def emit(self, record):
>         +                logs.append(record)
>         +
>         +        logger = logging.getLogger("BitBake")
>         +        handler = LogHandler()
>         +        logger.addHandler(handler)
>         +        return logs
>         +    def __exit__(self, type, value, traceback):
>         +        return
> 
> I realize it probably doesn’t matter in the testing case specifically,
> but this lies to the user of the class. Using a context manager that
> doesn’t undo what it’s done on exit.. :)

Er, yes, quite. I knew there was something I'd meant to go back and do
once it worked. I've posted a v2 with that fixed.

Cheers,

Richard



