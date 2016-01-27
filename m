Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9F3F3731E1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 03:00:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 19:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,353,1449561600"; d="scan'208";a="899027414"
Received: from lsooi-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.139.21])
	by orsmga002.jf.intel.com with ESMTP; 26 Jan 2016 19:00:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Jan 2016 16:00:53 +1300
Message-ID: <2347316.L4IDf5da3k@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.3.3-301.fc23.x86_64; KDE/4.14.16; x86_64; ;
	)
In-Reply-To: <1451998815-4536-1-git-send-email-sujith.h@gmail.com>
References: <1451998815-4536-1-git-send-email-sujith.h@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: BBUIHelper: Remove function findServerDetails
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
X-List-Received-Date: Wed, 27 Jan 2016 03:01:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 05 Jan 2016 18:30:15 Sujith H wrote:
> findServerDetails function can be removed safely
> from the source tree. Couldn't find any files
> calling this function.
> 
> Signed-off-by: Sujith H <sujith.h@gmail.com>
> ---
>  lib/bb/ui/uihelper.py | 41 -----------------------------------------
>  1 file changed, 41 deletions(-)
> 
> diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
> index a703387..db70b76 100644
> --- a/lib/bb/ui/uihelper.py
> +++ b/lib/bb/ui/uihelper.py
> @@ -57,44 +57,3 @@ class BBUIHelper:
>          self.needUpdate = False
>          return (self.running_tasks, self.failed_tasks)
> 
> -    def findServerDetails(self):
> -        import sys
> -        import optparse
> -        from bb.server.xmlrpc import BitbakeServerInfo,
> BitBakeServerConnection -        host = ""
> -        port = 0
> -        bind = ""
> -        parser = optparse.OptionParser(
> -            usage = """%prog -H host -P port -B bindaddr""")
> -
> -        parser.add_option("-H", "--host", help = "Bitbake server's IP
> address", -                   action = "store", dest = "host", default =
> None) -
> -        parser.add_option("-P", "--port", help = "Bitbake server's Port
> number", -                   action = "store", dest = "port", default =
> None) -
> -        parser.add_option("-B", "--bind", help = "Hob2 local bind address",
> -                   action = "store", dest = "bind", default = None) -
> -        options, args = parser.parse_args(sys.argv)
> -        for key, val in options.__dict__.items():
> -            if key == 'host' and val:
> -                host = val
> -            elif key == 'port' and val:
> -                port = int(val)
> -            elif key == 'bind' and val:
> -                bind = val
> -
> -        if not host or not port or not bind:
> -            parser.print_usage()
> -            sys.exit(1)
> -
> -        serverinfo = BitbakeServerInfo(host, port)
> -        clientinfo = (bind, 0)
> -        connection = BitBakeServerConnection(serverinfo, clientinfo)
> -
> -        server = connection.connection
> -        eventHandler = connection.events
> -
> -        return server, eventHandler, host, bind
> -

Looks like this was left over from the early days of Hob.

Acked-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

