Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3C66465C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 15:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CFBR9O019622; Thu, 12 May 2016 16:11:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w2O9lOknCdx6; Thu, 12 May 2016 16:11:27 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CFBQLt019618
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 May 2016 16:11:27 +0100
Message-ID: <1463065886.9746.14.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Thu, 12 May 2016 16:11:26 +0100
In-Reply-To: <CABcZAN=v9YiLHPQugxLXpOKbznSjek30Xbk72+9-BF6bPiyLOQ@mail.gmail.com>
References: <1463047019.9746.7.camel@linuxfoundation.org>
	<CABcZAN=v9YiLHPQugxLXpOKbznSjek30Xbk72+9-BF6bPiyLOQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cookerdata: Fix log messages and ensure we exit
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
X-List-Received-Date: Thu, 12 May 2016 15:11:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-05-12 at 07:55 -0700, Christopher Larson wrote:
> 
> On Thu, May 12, 2016 at 2:56 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > The string formatting wasn't correct and we should exit if we hit
> > errors here similar to the other exception handlers.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index 50259a9..fba95af 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -192,7 +192,8 @@ def catch_parse_error(func):
> >                  fn, _, _, _ = traceback.extract_tb(tb, 1)[0]
> >                  if not fn.startswith(bbdir):
> >                      break
> > -            parselog.critical("Unable to parse %s", fn,
> > exc_info=(exc_class, exc, tb))
> > +            parselog.critical("Unable to parse %s" % fn,
> > exc_info=(exc_class, exc, tb))
> > +            sys.exit(1)
> > 
> The python logging module supports passing the % format values as
> arguments, you don't have to format the string at call time. What was
> the error here?

I had a whole load of debug here and distilled it down to this as it
looked inconsistent with the rest of our code. Its possible the real
problem was with exc_info as mentioned in another patch...

Cheers,

Richard



