Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ty34j-0005kq-GZ for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 17:21:40 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NG9i2k017617; Wed, 23 Jan 2013 16:09:44 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sRWbe7uKjGdD; Wed, 23 Jan 2013 16:09:44 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NG9Ywg017607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 23 Jan 2013 16:09:37 GMT
Message-ID: <1358957124.6356.63.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 23 Jan 2013 16:05:24 +0000
In-Reply-To: <1358943248-21313-1-git-send-email-cristiana.voicu@intel.com>
References: <1358943248-21313-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] bitbake & hob: implement functions to assure consistency for configuration files
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
X-List-Received-Date: Wed, 23 Jan 2013 16:21:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-01-23 at 14:14 +0200, Cristiana Voicu wrote:
> Added a new command in bitbake to save a variable in a file; added a function
> in cooker which is called by this command
> 
> The function saveConfigurationVar from cooker.py saves a variable in the file that
> is received by argument. It checks all the operations made on that variable, using the history.
> If it's the first time when it does some changes on a variable,it comments the lines where
> an operation is made on it, and it sets it in a line to the end of file. If it's not
> the first time(it has a comment before), it replaces the line.
> 
> Make some changes in hob to save the variables from bblayers.conf and local.conf
> using the bitbake command.
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/command.py                   |    7 +++
>  bitbake/lib/bb/cooker.py                    |   86 +++++++++++++++++++++++++++
>  bitbake/lib/bb/data_smart.py                |   21 +++++++
>  bitbake/lib/bb/ui/crumbs/builder.py         |   32 ++++++----
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    3 +
>  bitbake/lib/bb/ui/crumbs/template.py        |   24 --------
>  6 files changed, 136 insertions(+), 37 deletions(-)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 0fed25a..77b08b1 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -179,6 +179,7 @@ class CommandsSync:
>          Init the cooker to initial state with nothing parsed
>          """
>          command.cooker.initialize()
> +        command.cooker.enableDataTracking()

Please make this a new separte command to the server and also add a
disable call which you can call once hob has the configuration data.

Cheers,

Richard



