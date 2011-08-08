Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QqTNH-00028T-8o for bitbake-devel@lists.openembedded.org;
	Mon, 08 Aug 2011 19:12:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p78H7sEe004668;
	Mon, 8 Aug 2011 18:07:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04291-03; Mon,  8 Aug 2011 18:07:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p78H7jTx004662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Aug 2011 18:07:46 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <1312567676.2241.3.camel@scimitar>
References: <cover.1312310554.git.josh@linux.intel.com>
	<1312564373.14274.149.camel@rex>  <1312567676.2241.3.camel@scimitar>
Date: Mon, 08 Aug 2011 18:07:15 +0100
Message-ID: <1312823235.14274.229.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
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
X-List-Received-Date: Mon, 08 Aug 2011 17:12:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-05 at 11:07 -0700, Joshua Lock wrote:
> On Fri, 2011-08-05 at 18:12 +0100, Richard Purdie wrote:
> > On Tue, 2011-08-02 at 11:51 -0700, Joshua Lock wrote:
> > >   git://github.com/incandescant/bitbake configfiles
> > >   https://github.com/incandescant/bitbake/tree/configfiles
> > > 
> > > Joshua Lock (2):
> > >   bb/parse: track parsed configuration files in __BB_PARSED_CONF
> > >   bb/cooker: only emit ConfigFilePathFound for files which were parsed
> > 
> > Am I right in thinking this series is now superseded by the tweak to
> > include the information in __base_depends?
> 
> That's right. The only reason I haven't sent that patch out yet is
> because I'm in two minds about which is the cleanest way.
> 
> Because __base_depends a) contains more than just .conf files and b)
> gets renamed I'm thinking the cleanest thing to do would be to iterate
> __depends before the call to renameVar, pull out all conf files and
> store them in self.configuration.config_files (or similar).
> 
> I wasn't sure adding an extra list to the configuration object would be
> appreciated though...

I'm not sure we need a variable just for .conf files. Anyone wanting
conf files can generate that information easily enough...

Cheers,

Richard



