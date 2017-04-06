Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6898B77C87
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 11:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v36BqAf4006012; 
	Thu, 6 Apr 2017 12:52:10 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id j4GqYCp7pyxV; Thu,  6 Apr 2017 12:52:10 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v36Bjh2p005536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 6 Apr 2017 12:45:44 +0100
Message-ID: <1491479143.17200.36.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Ohly <patrick.ohly@intel.com>, Juro Bystricky
	<juro.bystricky@intel.com>
Date: Thu, 06 Apr 2017 12:45:43 +0100
In-Reply-To: <1491468186.10884.38.camel@intel.com>
References: <1491428045-10132-1-git-send-email-juro.bystricky@intel.com>
	<1491468186.10884.38.camel@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Thu, 06 Apr 2017 11:52:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-04-06 at 10:43 +0200, Patrick Ohly wrote:
> On Wed, 2017-04-05 at 14:34 -0700, Juro Bystricky wrote:
> > 
> > In a multiconfig environment, a tinfoil call such as
> > 
> >     tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")
> > 
> > can fail with an error such as:
> > 
> >   File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in
> > get_recipe_file
> >     raise bb.providers.NoProvider('Unable to find any recipe file
> > matching "%s"' % pn)
> > bb.providers.NoProvider: Unable to find any recipe file matching
> > "multiconfig:arduino-101-sss:gcc"
> > 
> > The culprit is findBestProvider (only called from tinfoil), which
> > does not
> > handle multiconfig. This patch fixes the error and the tinfoil call
> > returns absolute path
> > to the recipe, i.e:
> > 
> >   "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"
> So tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc") and
> tinfoil.parse_recipe("gcc") then return identical data, because both
> end
> up parsing "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"
> without taking the "arduino-101-sss" config into account?
> 
> That wouldn't be correct.
> 
> As far as I understand it, the mapping has to be:
> multiconfig:arduino-101-sss:gcc ->
> multiconfig:arduino-101-sss:/data/master/poky/meta/recipes-
> devtools/gcc/gcc_6.3.bb

I agree with Patrick. At a quick glance, I think the caller
of findBestProvider is going to need to handle the mc, which is
why findBestProvider takes it as a parameter.

Cheers,

Richard

