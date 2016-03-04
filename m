Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 89789731F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Mar 2016 10:30:22 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 04 Mar 2016 02:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,535,1449561600"; d="scan'208";a="758013181"
Received: from jlock-mobl1.gar.corp.intel.com ([10.252.11.7])
	by orsmga003.jf.intel.com with ESMTP; 04 Mar 2016 02:30:16 -0800
Message-ID: <1457087406.3285.3.camel@linux.intel.com>
From: Joshua G Lock <joshua.g.lock@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 04 Mar 2016 10:30:06 +0000
In-Reply-To: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.18.5.1 (3.18.5.1-1.fc23) 
Mime-Version: 1.0
Subject: Re: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Fri, 04 Mar 2016 10:30:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-03-04 at 10:13 +0200, Ed Bartosh wrote:
> XMLRPCServer.single_use attribute was always set to False.
> This caused xmlrpc server to keep running after build is done as
> BitBakeServerCommands.removeClient only shuts down server if its
> single_use attribute is set to True.
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/server/xmlrpc.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/server/xmlrpc.py
> b/bitbake/lib/bb/server/xmlrpc.py
> index 1ceca51..d627550 100644
> --- a/bitbake/lib/bb/server/xmlrpc.py
> +++ b/bitbake/lib/bb/server/xmlrpc.py
> @@ -193,6 +193,8 @@ class XMLRPCServer(SimpleXMLRPCServer,
> BaseImplServer):
>          BaseImplServer.__init__(self)
>          if (interface[1] == 0):     # anonymous port, not getting
> reused
>              self.single_use = True
> +        else:
> +            self.singe_use = False

This won't work, right? Typo.

Regards,

Joshua

>          # Use auto port configuration
>          if (interface[1] == -1):
>              interface = (interface[0], 0)
> @@ -205,7 +207,6 @@ class XMLRPCServer(SimpleXMLRPCServer,
> BaseImplServer):
>          self.commands = BitBakeServerCommands(self)
>          self.autoregister_all_functions(self.commands, "")
>          self.interface = interface
> -        self.single_use = False
>  
>      def addcooker(self, cooker):
>          BaseImplServer.addcooker(self, cooker)
> -- 
> 2.1.4
> 

