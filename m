Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QqnEO-00005J-P9 for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 16:24:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p79EK1xF014217;
	Tue, 9 Aug 2011 15:20:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14042-04; Tue,  9 Aug 2011 15:19:57 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p79EJsmh014211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Aug 2011 15:19:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <3f06f5187755ed7ee59eb4c486733c643a4770ae.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
	<3f06f5187755ed7ee59eb4c486733c643a4770ae.1312852599.git.josh@linux.intel.com>
Date: Tue, 09 Aug 2011 15:19:22 +0100
Message-ID: <1312899562.14274.303.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/4] bb/cooker: only emit ConfigFilePathFound for files which were parsed
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
X-List-Received-Date: Tue, 09 Aug 2011 14:24:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-08 at 18:18 -0700, Joshua Lock wrote:
> When the requested configuration file is found on disk check the
> against the configuration files in __depends/__base_depends to ensure the
> file was parsed before emitting the ConfigFilePathFound event.
> If the requested file wasn't parsed just return (and don't emit).
> 
> Fixes [YOCTO #1246]
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/cooker.py |   32 ++++++++++++++++++++++++++++++--
>  1 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 6022192..337a817 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -609,9 +609,37 @@ class BBCooker:
>                  collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
>  
>      def findConfigFilePath(self, configfile):
> +        """
> +        Find the location on disk of configfile and if it exists and was parsed by BitBake
> +        emit the ConfigFilePathFound event with the path to the file.
> +        """
>          path = self._findConfigFile(configfile)
> -        if path:
> -            bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
> +        if not path:
> +            return
> +
> +        # Generate a list of parsed configuration files by searching the files
> +        # listed in the __depends variable with a .conf suffix.
> +        # NOTE: We can't know if we've been called before the variable has been
> +        # renamed so if depends isn't set try __base_depends (the variable name
> +        # after rename).
> +        conffiles = []
> +        dep_files = bb.data.getVar('__depends', self.configuration.data) or None
> +        if not dep_files:
> +            dep_files = bb.data.getVar('__base_depends', self.configuration.data) or set()

Nearly. You need to look at the combined array of __depends and
__base_depends values here...

Cheers,

Richard





