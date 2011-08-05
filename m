Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QpOsg-0000d1-Ld
	for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 20:12:22 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 05 Aug 2011 11:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,324,1309762800"; 
   d="scan'208";a="4522340"
Received: from unknown (HELO [10.255.14.201]) ([10.255.14.201])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Aug 2011 11:07:56 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 05 Aug 2011 11:07:51 -0700
In-Reply-To: <1312564373.14274.149.camel@rex>
References: <cover.1312310554.git.josh@linux.intel.com>
	<1312564373.14274.149.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1312567676.2241.3.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Store a list of parsed configuration files
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
X-List-Received-Date: Fri, 05 Aug 2011 18:12:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-05 at 18:12 +0100, Richard Purdie wrote:
> On Tue, 2011-08-02 at 11:51 -0700, Joshua Lock wrote:
> > This series addresses Yocto #1246 "Configuration changes could be saved to a
> > file the cooker isn't using" by having the parser store a list of
> > configuration files it has parsed in the data object and then switching the
> > cooker to verify against this list that the found file was parsed before
> > emitting the ConfigFilePathFound event.
> > 
> > The following changes since commit 1009ca570a750a00b0e60afcc30ead070c7b310a:
> > 
> >   hob: remove temporary directory on program shutdown (2011-07-30 12:21:18 -0700)
> > 
> > are available in the git repository at:
> >   git://github.com/incandescant/bitbake configfiles
> >   https://github.com/incandescant/bitbake/tree/configfiles
> > 
> > Joshua Lock (2):
> >   bb/parse: track parsed configuration files in __BB_PARSED_CONF
> >   bb/cooker: only emit ConfigFilePathFound for files which were parsed
> 
> Am I right in thinking this series is now superseded by the tweak to
> include the information in __base_depends?

That's right. The only reason I haven't sent that patch out yet is
because I'm in two minds about which is the cleanest way.

Because __base_depends a) contains more than just .conf files and b)
gets renamed I'm thinking the cleanest thing to do would be to iterate
__depends before the call to renameVar, pull out all conf files and
store them in self.configuration.config_files (or similar).

I wasn't sure adding an extra list to the configuration object would be
appreciated though...

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



