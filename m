Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 170E660557
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Aug 2015 16:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7LGrMJr028312; Fri, 21 Aug 2015 17:53:22 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VDOehze6-Xsa; Fri, 21 Aug 2015 17:53:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7LGr5rV028308
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 21 Aug 2015 17:53:16 +0100
Message-ID: <1440175985.12105.263.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 21 Aug 2015 17:53:05 +0100
In-Reply-To: <240026922.piU8TeAAyb@peggleto-mobl.ger.corp.intel.com>
References: <1440104436-12491-1-git-send-email-randy.e.witt@linux.intel.com>
	<20150820225144.GB12937@axis.com>
	<240026922.piU8TeAAyb@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake:main.py: Handle RuntimeError exception in list_extension_modules
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
X-List-Received-Date: Fri, 21 Aug 2015 16:53:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-08-21 at 09:07 +0100, Paul Eggleton wrote:
> On Friday 21 August 2015 00:51:44 Olof Johansson wrote:
> > On 15-08-20 23:00 +0200, Randy Witt wrote:
> > > --- a/bitbake/lib/bb/main.py
> > > +++ b/bitbake/lib/bb/main.py
> > > 
> > > @@ -60,7 +60,7 @@ def list_extension_modules(pkg, checkattr):
> > >              continue
> > >          
> > >          try:
> > >              module = __import__(pkg.__name__, fromlist=[modulename])
> > > 
> > > -        except (ImportError, SystemExit):
> > > 
> > > +        except (ImportError, SystemExit, RuntimeError):
> > >              # If we can't import it, it's not valid
> > >              continue
> > >          
> > >          module_if = getattr(module, modulename)
> > 
> > Wouldn't it be better to just skip naming the exceptions you want
> > to catch in this case? I.e.:
> > 
> >    try:
> >      module = __import__(...
> >    except:
> >      continue
> > 
> > "If we can't import it" ...
> 
> As a matter of good practice I try to avoid eating all exceptions that way in 
> case one of them is a genuine error rather than something we want to ignore. 
> Maybe this is a reasonable exception (heh) though.

I think in this case, a generic except might be a better alternative. I
agree in general its a bad idea. I merged the other fix since it got us
around the issue whilst we could consider what to do about it.

> FWIW we might consider just reverting my change if it's causing too much 
> greif.

I think I'd be happier if it only tried to import the UIs if --help were
specified. How you do that with python argument handling I'm less sure
of though...

Cheers,

Richard


