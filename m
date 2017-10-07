Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B11E771DCF
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  7 Oct 2017 10:01:06 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v97A140n002373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sat, 7 Oct 2017 11:01:05 +0100
Message-ID: <1507370464.20313.65.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, Mounesh Sutar
	<mounesh.sutar@gmail.com>
Date: Sat, 07 Oct 2017 11:01:04 +0100
In-Reply-To: <CAJ86T=XWPVANsJmSW2aPCWKQOEB_r84E-08HTirHSjxQVPxmkQ@mail.gmail.com>
References: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
	<CAOtT3B52FFNZHsx+7GQwtLp0qoWvZ3C5AxU4tVYm5cPnAZC3Zg@mail.gmail.com>
	<CAJ86T=XWPVANsJmSW2aPCWKQOEB_r84E-08HTirHSjxQVPxmkQ@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: Re: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Sat, 07 Oct 2017 10:01:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-10-06 at 13:37 -0700, Andre McCurdy wrote:
> > 
> > On Tue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar <mounesh.sutar@gmai
> > l.com>
> > > 
> > > 
> > > bitbake is parsing all recipe files, against layers
> > > BBFILE_PATTERN for
> > > warning message display.
> > > In case of sublayer with lower/equal priority, then all
> > > sublayer's
> > > patterns are not being
> > > considered for pattern match. While checking recipe file against
> > > matching
> > > pattern,
> > > the first matching pattern is accepted and added to matched list,
> > > while
> > > remaning PATTERNs are
> > > not being considered. With this, the recipes are being neglected
> > > from
> > > PATTERN match.
> > > This fix let's parser run through all the layers PATTERNs and on
> > > matching
> > > added to match list.
> > > 
> > > Upstream-Status: Submitted [bitbake-devel@lists.openembedded.org]
> > > 
> > > Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
> > > ---
> > >  bitbake/lib/bb/cooker.py |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > > index 4df8881..5fde995 100644
> > > --- a/bitbake/lib/bb/cooker.py
> > > +++ b/bitbake/lib/bb/cooker.py
> > > @@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):
> > >                  if matched != None:
> > >                      if not regex in matched:
> > >                          matched.add(regex)
> > > -                return pri
> > > +                        return pri
> > >          return 0
> > > 
> > >      def get_bbfiles(self):
> > > --
> Resurrecting an old thread as it's been pointed out to me that this
> patch fixes the issue I raised a while ago on the oe-core list:
> 
>   http://lists.openembedded.org/pipermail/openembedded-core/2016-July
> /123466.html
> 
> Are there any problems or concerns with this change?

I had to go and look at this again but yes, there are problems with the
patch:

a) If matched = None, the function never returns a priority after this 
   change.
b) Currently the first match is returned and also used in parallel for 
   the priority calculation. After the patch, the priority used would 
   be the last match found. The patch therefore reverses priority 
   assignments for layers.

There is a definite problem here but the patch simply moves the
goalposts, it doesn't actually fix it. It breaks the current behaviour
too.

Cheers,

Richard


