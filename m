Received: from [93.97.173.237] (helo=tim.rpsys.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QpO1s-0007BD-3U for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 19:17:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p75HDLnU014859;
	Fri, 5 Aug 2011 18:13:21 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14489-04; Fri,  5 Aug 2011 18:13:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p75HDGNp014853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Aug 2011 18:13:16 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312310554.git.josh@linux.intel.com>
References: <cover.1312310554.git.josh@linux.intel.com>
Date: Fri, 05 Aug 2011 18:12:53 +0100
Message-ID: <1312564373.14274.149.camel@rex>
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
X-List-Received-Date: Fri, 05 Aug 2011 17:17:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-02 at 11:51 -0700, Joshua Lock wrote:
> This series addresses Yocto #1246 "Configuration changes could be saved to a
> file the cooker isn't using" by having the parser store a list of
> configuration files it has parsed in the data object and then switching the
> cooker to verify against this list that the found file was parsed before
> emitting the ConfigFilePathFound event.
> 
> The following changes since commit 1009ca570a750a00b0e60afcc30ead070c7b310a:
> 
>   hob: remove temporary directory on program shutdown (2011-07-30 12:21:18 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake configfiles
>   https://github.com/incandescant/bitbake/tree/configfiles
> 
> Joshua Lock (2):
>   bb/parse: track parsed configuration files in __BB_PARSED_CONF
>   bb/cooker: only emit ConfigFilePathFound for files which were parsed

Am I right in thinking this series is now superseded by the tweak to
include the information in __base_depends?

Cheers,

Richard





