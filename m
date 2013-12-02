Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BACA66CEEA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 13:36:02 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2DZnuD023216; Mon, 2 Dec 2013 13:35:49 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WqjAtKgWxaGd; Mon,  2 Dec 2013 13:35:49 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2DZgLL023206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 2 Dec 2013 13:35:43 GMT
Message-ID: <1385991339.11222.106.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Mon, 02 Dec 2013 13:35:39 +0000
In-Reply-To: <1385724682-2289-1-git-send-email-cristiana.voicu@intel.com>
References: <1385724682-2289-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: btibake server must reparse the conf between builds
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
X-List-Received-Date: Mon, 02 Dec 2013 13:36:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-11-29 at 13:31 +0200, Cristiana Voicu wrote:
> When the UI event handlers are registered, the cooker reset is
> triggered. In this way it doesn't affect the cooker state.
> 
> [YOCTO #5535]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/server/xmlrpc.py |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
> index 82c0e8d..fb7a8b4 100644
> --- a/bitbake/lib/bb/server/xmlrpc.py
> +++ b/bitbake/lib/bb/server/xmlrpc.py
> @@ -103,8 +103,9 @@ class BitBakeServerCommands():
>          for f in featureset:
>              self.cooker.featureset.setFeature(f)
>  
> -        if (original_featureset != list(self.cooker.featureset)):
> -            self.cooker.reset()
> +        #always reset the cooker when a remote UI Event Handler is registered,
> +        #in order to reparse the configuration files
> +        self.cooker.reset()
>  
>          self.event_handle = bb.event.register_UIHhandler(s)
>          return self.event_handle

Whilst this is simple and solves the immediate problem, I don't think
this is going to scale. We need to properly fix the server reset paths
once and for all.

This is one of those "how deep does the rabbit hole go" type problems
though. I started looking at this and firstly got very confused that we
have both cooker.loadConfigurationData and cooker.initConfigurationData.
I think one is a hack to allow hob to inject pre/post config files to
the configuration. That appears to be backed up by the
parseConfigurationFiles() command. So to move forward we need to fix
those things.

What we need is a clear separation to setting up the configuration
(including the pre/post files), then actually parsing it. In due course
we can then put code around this to know when we need to invalidate the
cache and when we do not.

Specifically, I believe that we need to:

a) Merge cooker.loadConfigurationData and  cooker.initConfigurationData 
   into one single base datastore reset function
b) Have a setPrePostConfFiles command which sets the pre/post config 
   files which hob uses
c) Figure out which of the Async commands should be sync commands (I 
   suspect most of the find*() ones.

and once we've cleared up this tangled web, we can revisit the question
of where and when we should be triggering a reset.

Cheers,

Richard





