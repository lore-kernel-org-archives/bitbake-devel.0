Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D9F0F60557
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Aug 2015 08:07:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 21 Aug 2015 01:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,720,1432623600"; d="scan'208";a="752747144"
Received: from vyevtous-mobl2.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.21.15])
	by orsmga001.jf.intel.com with ESMTP; 21 Aug 2015 01:07:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Olof Johansson <olof.johansson@axis.com>
Date: Fri, 21 Aug 2015 09:07:50 +0100
Message-ID: <240026922.piU8TeAAyb@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.5-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <20150820225144.GB12937@axis.com>
References: <1440104436-12491-1-git-send-email-randy.e.witt@linux.intel.com>
	<20150820225144.GB12937@axis.com>
MIME-Version: 1.0
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
X-List-Received-Date: Fri, 21 Aug 2015 08:07:54 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 21 August 2015 00:51:44 Olof Johansson wrote:
> On 15-08-20 23:00 +0200, Randy Witt wrote:
> > --- a/bitbake/lib/bb/main.py
> > +++ b/bitbake/lib/bb/main.py
> > 
> > @@ -60,7 +60,7 @@ def list_extension_modules(pkg, checkattr):
> >              continue
> >          
> >          try:
> >              module = __import__(pkg.__name__, fromlist=[modulename])
> > 
> > -        except (ImportError, SystemExit):
> > 
> > +        except (ImportError, SystemExit, RuntimeError):
> >              # If we can't import it, it's not valid
> >              continue
> >          
> >          module_if = getattr(module, modulename)
> 
> Wouldn't it be better to just skip naming the exceptions you want
> to catch in this case? I.e.:
> 
>    try:
>      module = __import__(...
>    except:
>      continue
> 
> "If we can't import it" ...

As a matter of good practice I try to avoid eating all exceptions that way in 
case one of them is a genuine error rather than something we want to ignore. 
Maybe this is a reasonable exception (heh) though.

FWIW we might consider just reverting my change if it's causing too much 
greif.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

