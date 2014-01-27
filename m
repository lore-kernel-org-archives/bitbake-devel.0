Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9B67A6E719
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 22:43:24 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0RMhAUm000619; Mon, 27 Jan 2014 22:43:10 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8rqjVfm8htsk; Mon, 27 Jan 2014 22:43:10 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0RMh7gx000606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Jan 2014 22:43:09 GMT
Message-ID: <1390862582.21652.41.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>
Date: Mon, 27 Jan 2014 22:43:02 +0000
In-Reply-To: <CAMKF1soPEMALs27a1f2Xi7upTgbt9EDix-dACYLct+QDt_3+hw@mail.gmail.com>
References: <1390833424.17424.251.camel@ted>
	<CAMKF1soPEMALs27a1f2Xi7upTgbt9EDix-dACYLct+QDt_3+hw@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Rifenbark,
	Scott M" <scott.m.rifenbark@intel.com>
Subject: Re: [PATCH] cooker: Add option of specifying indvidual tasks for targets
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
X-List-Received-Date: Mon, 27 Jan 2014 22:43:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-01-27 at 14:39 -0800, Khem Raj wrote:
> On Mon, Jan 27, 2014 at 6:37 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Currently its near enough impossible to tell bitbake to run target X,
> > task Y and target A, task B. We could hack various parts of the API
> > around but it would mean incompatibilities.
> >
> > An alternative is to accept the syntax "<target>:do_<task>" as a target
> > name. The default task would be used where the task is unspecified.
> >
> 
> This should be documented in manuals as well IMO

Totally agreed.

Hi Scott, we need to document this new syntax! ;-)

(I was planning to talk to Scott when I reached the point of merging
this)

Cheers,

Richard

> > This has the advantage that its neat/clean code and works from all
> > current APIs including the commandline.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index db4cb51..cc7d84e 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -449,9 +449,14 @@ class BBCooker:
> >          current = 0
> >          runlist = []
> >          for k in fulltargetlist:
> > +            ktask = task
> > +            if ":do_" in k:
> > +                k2 = k.split(":do_")
> > +                k = k2[0]
> > +                ktask = k2[1]
> >              taskdata.add_provider(localdata, self.recipecache, k)
> >              current += 1
> > -            runlist.append([k, "do_%s" % task])
> > +            runlist.append([k, "do_%s" % ktask])
> >              bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
> >          taskdata.add_unresolved(localdata, self.recipecache)
> >          bb.event.fire(bb.event.TreeDataPreparationCompleted(len(fulltargetlist)), self.data)
> >
> >
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> 



