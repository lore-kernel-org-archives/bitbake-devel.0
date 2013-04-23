Received: from mail2.eads.net ([80.156.45.114] helo=mail.eads.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Wolfgang.Hauser.external@cassidian.com>)
	id 1UUaXJ-00071U-JM; Tue, 23 Apr 2013 12:33:22 +0200
Received: from gsx3072-vs5.mxchg.m.corp ([53.147.176.149])
	by mail.eads.net (8.13.8/8.13.8/Debian-2) with ESMTP id r3NA2cFH014235; 
	Tue, 23 Apr 2013 12:02:39 +0200
Received: from gsx300a.mxchg.m.corp ([10.43.212.131]) by
	gsx3072-vs5.mxchg.m.corp with Microsoft SMTPSVC(6.0.3790.4675); 
	Tue, 23 Apr 2013 12:02:57 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
MIME-Version: 1.0
Date: Tue, 23 Apr 2013 12:02:57 +0200
Message-ID: <0C757E680E33864AB113392C7E83F910019806D9@GSX300A.mxchg.m.corp>
In-Reply-To: <51765508.1070803@windriver.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
Thread-Index: Ac5ABada16KtWc8wQ5uu4H1KFjhm/QAARhAg
References: <1366640172.23738.12.camel@ted>
	<51758B94.8010405@linaro.org><1366707875.23738.40.camel@ted>
	<517653EA.9000401@linaro.org> <51765508.1070803@windriver.com>
From: "Hauser, Wolfgang (external)" <Wolfgang.Hauser.external@cassidian.com>
To: "Patches and discussions about the oe-core layer"
	<openembedded-core@lists.openembedded.org>, 
	<bitbake-devel@lists.openembedded.org>
X-OriginalArrivalTime: 23 Apr 2013 10:02:57.0792 (UTC)
	FILETIME=[BB14F800:01CE4009]
X-Mailman-Approved-At: Sun, 28 Apr 2013 23:31:41 +0200
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Tue, 23 Apr 2013 10:33:25 -0000
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,=20
if there was a plan to divide bitbake into a server and a client part, I
would suggest to add a kind of "fetching proxy" functionality or run
mode to the bitbake sever part.

The reason behind this suggestion is: If you sitting behind a
restrictive proxy/firewall and want to use yocto (OE) you always get
problems to load from git:// svn:// or cvn:// URLs.

Here it may be useful to be able to run a bb fetch proxy outside of the
firewall that tunnels the protocols by https or ssh (via (ssl)port 443
like github does for git), or acts as a flexible download server, do the
fetching part and providing the download archives to an other server
through a common usable protocol tunnel.
May be this was a special issue, but it may ease the use of yocto (OE)
extremely.

Regards
Wolfgang Hauser


