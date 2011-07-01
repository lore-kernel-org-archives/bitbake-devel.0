Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qcg5c-0008R0-H3
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 17:57:08 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Jul 2011 08:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,459,1304319600"; d="scan'208";a="21559319"
Received: from unknown (HELO [10.255.13.137]) ([10.255.13.137])
	by azsmga001.ch.intel.com with ESMTP; 01 Jul 2011 08:53:11 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 01 Jul 2011 08:53:05 -0700
In-Reply-To: <1309535267.20015.523.camel@rex>
References: <cover.1309499227.git.josh@linux.intel.com>
	<1309535267.20015.523.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-2.fc15) 
Message-ID: <1309535591.2177.1.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/10] Hob - BitBake GUI
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 01 Jul 2011 15:57:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-01 at 16:47 +0100, Richard Purdie wrote:
> On Thu, 2011-06-30 at 23:02 -0700, Joshua Lock wrote:
> > Of course, before sending this pull request I ran some final tests and
> > encountered a significant problem with the implementation approach.
> > Images are built by first using the buildTargets command to build all of the
> > target dependencies then creating a recipe file and using the buildFile
> > command to handle the build.
> > The problem is that if you have a clean build directory, perfectly reasonable
> > with such a tool, the buildFile command does not handle the native
> > dependencies added by the image class.
> > 
> > The alternative I have is to save the image files somewhere within BBPATH,
> > and perhaps suggest the user create a "workspace" layer, and build them with
> > buildTargets. I didn't do this because I'd rather not pollute the users file
> > system without good cause. It may be the only tenable approach though.
> > 
> > Any suggestions here?
> 
> I think you should be able to modify the base configuration data and
> just add a local directory that the image creator uses to BBPATH
> yourself?
> 
> That way you should always be able to use buildTargets...

Right. I had some code like this but I hadn't achieved it in a way which
was both a) non-invasive and b) didn't result in parsing a bunch of
stuff then throwing that away and parsing again. I'll look into this
approach some more.

Thanks for the feedback,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



