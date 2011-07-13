Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qgxf5-0004Sg-5x for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 13:31:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6DBRRfj028715;
	Wed, 13 Jul 2011 12:27:27 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28111-07; Wed, 13 Jul 2011 12:27:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6DBRI3r028709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jul 2011 12:27:18 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <7cb0ce38f4b80a2cace870bd0ab5af4f003b433c.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
	<7cb0ce38f4b80a2cace870bd0ab5af4f003b433c.1310507186.git.josh@linux.intel.com>
Date: Wed, 13 Jul 2011 12:27:17 +0100
Message-ID: <1310556437.20015.1108.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/3] cooker: only return *Found events if something was actually found
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
X-List-Received-Date: Wed, 13 Jul 2011 11:31:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-12 at 14:49 -0700, Joshua Lock wrote:
> @@ -569,7 +570,8 @@ class BBCooker:
>                          if p.search(f):
>                              matches.append(f)
>  
> -        bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)
> +        if len(matches):
> +            bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)

I think this can just be "if matches:"

>      def findConfigFiles(self, varname):
>          """
> @@ -592,7 +594,8 @@ class BBCooker:
>                          if end == 'conf':
>                              possible.append(val)
>  
> -        bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.configuration.data)
> +        if len(possible):
> +            bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.configuration.data)
>  
>      def findInheritsClass(self, klass):
>          """

ditto.

Cheers,

Richard



