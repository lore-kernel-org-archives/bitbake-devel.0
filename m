Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkzIK-00011v-7k for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 15:36:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BETLYQ024932;
	Wed, 11 Jan 2012 14:29:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24317-04; Wed, 11 Jan 2012 14:29:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BETAiY024926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2012 14:29:12 GMT
Message-ID: <1326292152.23315.51.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Date: Wed, 11 Jan 2012 14:29:12 +0000
In-Reply-To: <40776A41FC278F40B59438AD47D147A90FCA1A78@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<2b70816adeae4c278747d52654f3184f5e5a15a3.1326249301.git.dongxiao.xu@intel.com>
	<1326281886.23315.23.camel@ted>
	<40776A41FC278F40B59438AD47D147A90FCA1A78@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 5/8] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Wed, 11 Jan 2012 14:36:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-01-11 at 13:30 +0000, Xu, Dongxiao wrote:
> > >      # Save a logfile for cooker into the current working directory. When the
> > >      # server is daemonized this logfile will be truncated.
> > >      cooker_logfile = os.path.join(os.getcwd(), "cooker.log") @@
> > > -211,9 +210,15 @@ Default BBFILES are the .bb files in the current
> > directory.""")
> > >      # of the UIs (e.g. for DISPLAY, etc.)
> > >      bb.utils.clean_environment()
> > >
> > > -    server = server.BitBakeServer()
> > > +    if configuration.server_only:
> > > +        if configuration.servertype != "xmlrpc":
> > > +            sys.exit("FATAL: If '--server-only' is defined, we must set the
> > servertype as 'xmlrpc'.\n")
> > > +        server = server.BitBakeServer()
> > > +        server.initServer((configuration.bind, 0))
> > > +    else:
> > > +        server = server.BitBakeServer()
> > > +        server.initServer()
> > 
> > This looks like it will silently ignore configuration.bind in the non server-only case.
> > Don't you need something like:
> > 
> > 
> > +    if configuration.server_only:
> > +        if configuration.servertype != "xmlrpc":
> > +            sys.exit("FATAL: If '--server-only' is defined, we must set the
> > servertype as 'xmlrpc'.\n")
> > +        server = server.BitBakeServer()
> > +        server.initServer((configuration.bind, 0))
> > +    elif configuration.bind:
> > +        server = server.BitBakeServer()
> > +        server.initServer((configuration.bind, 0))
> > +    else:
> > +        server = server.BitBakeServer()
> > +        server.initServer()
> > 
> > ?
> 
> I had a thought of this code piece, we may need the following code. For --server-only option, it requires --bind, while not vice versa.
> 
> @@ -189,8 +191,14 @@ Default BBFILES are the .bb files in the current directory.""")
>          sys.exit("FATAL: Invalid server type '%s' specified.\n"
>                   "Valid interfaces: xmlrpc, process [default], none." % servertype)
> 
> -    if configuration.server_only and configuration.servertype != "xmlrpc":
> -        sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
> +    if configuration.server_only:
> +        if configuration.servertype != "xmlrpc":
> +            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
> +        if not configuration.bind:
> +            sys.exit("FATAL: The '--server-only' option requires a name/address to bind to with the -B option.\n")
> +
> +    if configuration.bind and configuration.servertype != "xmlrpc":
> +        sys.exit("FATAL: If '-B' or '--bind' is defined, we must set the servertype as 'xmlrpc'.\n")

That looks reasonable to me.

Cheers,

Richard



