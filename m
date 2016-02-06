Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 249EE77229;
	Sat,  6 Feb 2016 09:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u169MqH0014264; Sat, 6 Feb 2016 09:22:52 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id S8ahk6g1ML5u; Sat,  6 Feb 2016 09:22:52 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u169MlhR014261
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 6 Feb 2016 09:22:49 GMT
Message-ID: <1454750567.27087.289.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Sat, 06 Feb 2016 09:22:47 +0000
In-Reply-To: <2240342.nbMP20jZIu@peggleto-mobl.ger.corp.intel.com>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<2240342.nbMP20jZIu@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-architecture@lists.openembedded.org,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Sat, 06 Feb 2016 09:22:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2016-02-06 at 19:38 +1300, Paul Eggleton wrote:
> On Tue, 02 Feb 2016 23:55:40 Richard Purdie wrote:
> > At some point in the future, getVar should expand by default. To
> > get
> > there from the current position, we need a period of time where the
> > expand parameter is mandatory.
> > 
> > This patch starts that process. Clear errors will result from any
> > code
> > which doesn't provide this. Layers can be fixed with an expression
> > like:
> > 
> > sed -e 's:\(\.getVar([^,()]*, [^,()]*\)):\1, False):g' -i `grep 
> > -ril getVar
> > *`
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > diff --git a/bitbake/lib/bb/data_smart.py
> > b/bitbake/lib/bb/data_smart.py
> > index 8c3e9ef..79bec1b 100644
> > --- a/bitbake/lib/bb/data_smart.py
> > +++ b/bitbake/lib/bb/data_smart.py
> > @@ -566,7 +566,7 @@ class DataSmart(MutableMapping):
> >                  if len(shortvar) == 0:
> >                      override = None
> > 
> > -    def getVar(self, var, expand=False, noweakdefault=False,
> > parsing=False): +    def getVar(self, var, expand,
> > noweakdefault=False,
> > parsing=False): return self.getVarFlag(var, "_content", expand,
> > noweakdefault, parsing)
> > 
> >      def renameVar(self, key, newkey, **loginfo):
> 
> This change is reasonable and we've been discussing it on and off for
> years 
> now, so I'm generally in favour.
> 
> However, what I would really like to see us do is write a script that
> people 
> can use to upgrade their layers to accommodate this and any other
> breaking 
> changes so they don't have to go and figure out what to do
> themselves; the more 
> of these kinds of changes we make the more useful this script will
> be. I'll 
> file a bug.

This sounds great at first glance. What are the expectations here
though?

The getVar/getVarFlag change can be automatic, however, the MAKEFLAGS
change can't, nor can the python expansion change, at least not at all
easily. I suspect that this change is unusual and that in most cases we
make changes which can't be automatically fixed.

I worry that the user expectation then changes that we'd only ever make
changes which the script can 'save' them from and we end up blocked
from making any other kind of change. Some could argue that is a good
thing, I'm less sure.

This is one reason I put the sed command in these commits. I would note
that the version in one that I sent to the list was incorrect, I did
fix it on the branch though.

The compromise might be better migration notes in the metadata for
these issues?

[Incidentally, there are other kinds of breakage, e.g. I just fixed one
of the sanity tests and merged the fix, thinking I'd checked the
metadata for issues. Turns out multilib is still broken :(. Fixing that
breakage is way beyond a script, sadly, it will probably take me most
of the weekend to untangle that mess :(]

Cheers,

Richard


