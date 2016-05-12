Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3A5BC6FF93
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 23:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNKvlH007667; Fri, 13 May 2016 00:20:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ArjnI_8odigE; Fri, 13 May 2016 00:20:57 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNKsDJ007664
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 May 2016 00:20:55 +0100
Message-ID: <1463095254.9746.61.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <chris_larson@mentor.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 13 May 2016 00:20:54 +0100
In-Reply-To: <CABcZAN=Fmp0rTvVy9sEifLqHRtR0dDnsPox5xvmksww7aPop3Q@mail.gmail.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
	<4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
	<CABcZAN=Fmp0rTvVy9sEifLqHRtR0dDnsPox5xvmksww7aPop3Q@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: Re: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
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
X-List-Received-Date: Thu, 12 May 2016 23:21:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-05-12 at 16:12 -0700, Christopher Larson wrote:
> On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson <
> kergoth@gmail.com> wrote:
> > From: Christopher Larson <chris_larson@mentor.com>
> > 
> > This uses bb.utils.load_plugins, based on the plugin handling in
> > recipetool
> > and devtool in oe-core.
> > 
> > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > ---
> >  bin/bitbake-layers                 | 1065 ++----------------------
> > ------------
> >  bitbake/lib/bblayers/__init__.py   |    2 +
> >  bitbake/lib/bblayers/action.py     |  233 ++++++++
> >  bitbake/lib/bblayers/common.py     |   33 ++
> >  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
> >  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
> >  6 files changed, 1097 insertions(+), 1005 deletions(-)
> >  create mode 100644 bitbake/lib/bblayers/__init__.py
> >  create mode 100644 bitbake/lib/bblayers/action.py
> >  create mode 100644 bitbake/lib/bblayers/common.py
> >  create mode 100644 bitbake/lib/bblayers/layerindex.py
> >  create mode 100644 bitbake/lib/bblayers/query.py
> > 
> Was this patch not applied for a specific reason, or just needs more
> time for review, or waiting until after python3 is merged?

The other pieces were straightforward so I merged them. I meant to ask
Paul for an Acked-by on this piece as he'd done more work on the plugin
based tools than I have but then I got distracted, sorry. Paul is
cc'd...

Cheers,

Richard

