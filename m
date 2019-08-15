Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id B25477F2ED
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Aug 2019 23:03:53 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id e8so1951479wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Aug 2019 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=T735pc6YVAs/sSMpxWeaukmA/cplh/vQBbB3opbnA1o=;
	b=GqcYwLgbNAU3UJolyiw+GVZ6MfsXiaSsjGEIufeq+YVKN3WokiggSZfFXEEA0DD+UB
	aW3IJCFF63e7gYWvv2CC1P4GKEeLNwBOyhdX6wT5ZF0rSswEYDEdAGc9O1vnRVD/cno5
	1sWfe8E0GNnpf6jCgcr9yrGGdtNnbJphqdbCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=T735pc6YVAs/sSMpxWeaukmA/cplh/vQBbB3opbnA1o=;
	b=LY8E1ydmyDYamM+8iwdlg4t0nFpEaSnaceygRs2vx50pTn/WMhJa/dyRK1YK1AZ17T
	J6NjoLi87YmIgpMXWzR24R4RhdJFsUBNqJwXKrYQnR47QxjN4wZZET6e/krukgaQ1mzx
	oYOqS1T0mZe7PDEAlbXTW6cEKyBJKrmDLZWwTF8NVXJmb7HlDGZxrShbZ3fJEFw89WQW
	AhvWW2kxrn2rax5q5pehqBg9QoeP6bb8SPj/ZnhTpKTKt3zuTwEH9lKXf+Q7ZNCWn5il
	QmyfTY6mjNOE2yI/q3ZpDyIZVBTQX8oprnYKEHjp4Y2hvqmwuOHktCGSnIIngX9prFLQ
	NKYQ==
X-Gm-Message-State: APjAAAVxv+sXTb4lBnxjP68CiSUIbj/MmzeWnxLfoh/49wHIsRLxhVfP
	adItHlF93SeIp34RVRRmYaHGDdMxdM74CQ==
X-Google-Smtp-Source: APXvYqz0GXB678WwN4G4tM0L1mP0Y+aC8pu/fatMXu2r1n2cUtUYIZYqDOM3oMVQe9wltyiIlrQEGw==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr4723288wmk.52.1565910234302;
	Thu, 15 Aug 2019 16:03:54 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id l3sm6151991wrb.41.2019.08.15.16.03.53
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 15 Aug 2019 16:03:53 -0700 (PDT)
Message-ID: <352084d7f3f933b692ad60aa8ce50dee9b05c80d.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 00:03:51 +0100
In-Reply-To: <e6a757b4-a2f0-1785-3db9-fa496ead7441@windriver.com>
References: <cover.1557388944.git.liezhi.yang@windriver.com>
	<ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
	<850ae48669455c75cf34b2306f01add428aa62c0.camel@linuxfoundation.org>
	<3fb3e0d9-098f-7fdc-5c3c-9501dfe98af4@windriver.com>
	<e6a757b4-a2f0-1785-3db9-fa496ead7441@windriver.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: cookerdata: Avoid double exceptions for bb.fatal()
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
X-List-Received-Date: Thu, 15 Aug 2019 23:03:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-08-15 at 19:29 +0800, Robert Yang wrote:
> 
> On 5/14/19 7:02 PM, Robert Yang wrote:
> > 
> > On 5/12/19 4:28 PM, Richard Purdie wrote:
> > > On Thu, 2019-05-09 at 16:03 +0800, Robert Yang wrote:
> > > > The bb.fatal() raises BBHandledException() which causes double
> > > > exceptions,
> > > > e.g.:
> > > > 
> > > > Add 'HOSTTOOLS += "hello"' to conf/local.conf:
> > > > $ bitbake -p
> > > > [snip]
> > > > During handling of the above exception, another exception
> > > > occurred:
> > > > [snip]
> > > > ERROR: The following required tools (as specified by HOSTTOOLS)
> > > > appear to be 
> > > > unavailable in PATH, please install them in order to proceed:
> > > >    hello
> > > > 
> > > > Use "raise" rather than "raise bb.BBHandledException" to fix
> > > > the double
> > > > exceptions.
> > > > 
> > > > [YOCTO #13267]
> > > > 
> > > > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> > > > ---
> > > >   bitbake/lib/bb/cookerdata.py | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/bitbake/lib/bb/cookerdata.py
> > > > b/bitbake/lib/bb/cookerdata.py
> > > > index f8ae410..585edc5 100644
> > > > --- a/bitbake/lib/bb/cookerdata.py
> > > > +++ b/bitbake/lib/bb/cookerdata.py
> > > > @@ -301,7 +301,9 @@ class CookerDataBuilder(object):
> > > >               if multiconfig:
> > > >                  
> > > > bb.event.fire(bb.event.MultiConfigParsed(self.mcdata
> > > > ), self.data)
> > > > -        except (SyntaxError, bb.BBHandledException):
> > > > +        except bb.BBHandledException:
> > > > +            raise
> > > > +        except SyntaxError:
> > > >               raise bb.BBHandledException
> > > >           except bb.data_smart.ExpansionError as e:
> > > >               logger.error(str(e))
> > > 
> > > Hi Robert,
> > > 
> > > This doesn't sound right, where is this exception being printed a
> > > second time? The point of "BBHandledException" is to say "don't
> > > print
> > > any further traces for this exception". If this fixes the bug, it
> > > means
> > > something somewhere is printing a trace for a second time when it
> > > should pass through BBHandledException?
> > 
> > Hi RP,
> > 
> > I found another serious problem when tried to raise
> > BBHandledException. There
> > is a deadlock when a recipe is failed to parse, e.g.:
> > 
> > $ echo helloworld >> meta/recipes-extended/bash/bash_4.4.18.bb
> > $ bitbake -p
> > meta/recipes-extended/bash/bash_4.4.18.bb:42: unparsed line:
> > 'helloworld'
> > [hangs]
> > 
> > Then bitbake hangs, we can use Ctrl-C to break it, but the sub
> > processes
> > are still existed, and we need kill them manually, otherwise we
> > can't start
> > bitbake again.
> 
> BTW, things becomes much better after the following two patches are
> merged:
> bitbake: knotty: Fix for the Second Keyboard Interrupt
> bitbake: cooker: Cleanup the queue before call process.join()
> 
> Now we hardly can reproduce the problem:
> echo helloworld >> meta/recipes-extended/bash/bash_4.4.18.bb
> $ while true; do kill-bb; rm -fr bitbake-cookerdaemon.log 
> tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* ; bitbake -p;
> done
> 
> It's not easy to hang any more, but still hangs sometimes, I tried to
> debug it,
> but didn't find the root cause, the ui/knotty.py can't get event from
> server,
> and goes into a dead loop.
> 
>              event = eventHandler.waitEvent(0)
>              if event is None:
>                  if main.shutdown > 1:
>                      break
>                  termfilter.updateFooter()
>                  event = eventHandler.waitEvent(0.25)
>                  if event is None:
>                      continue
> 
> The main.shutdown is always 0 when it hangs.

In theory there are timeouts there so it should never hang waiting for
an event. Is it looping and not getting an event? or is the other end
disconnected?

I guess the question is what we can do to detect a dead connection, or
if the server is still alive, why the server is hanging and not sending
any events?

Thanks for the patches, those were tricky issues to track down and
solve!

Cheers,

Richard



